Return-Path: <michael@ellerman.id.au>
Subject: [PATCH 8/8] Cell IOMMU fixed mapping support
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RaBUQUdPIM4DdCs4on5d"
Date: Wed, 30 Jan 2008 11:03:44 +1100
Message-Id: <1201651424.11907.6.camel@concordia>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RaBUQUdPIM4DdCs4on5d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch adds support for setting up a fixed IOMMU mapping on certain
cell machines. For 64-bit devices this avoids the performance overhead of
mapping and unmapping pages at runtime. 32-bit devices are unable to use
the fixed mapping.

The fixed mapping is established at boot, and maps all of physical memory
1:1 into device space at some offset. On machines with < 30 GB of memory
we setup the fixed mapping immediately above the normal IOMMU window.

For example a machine with 4GB of memory would end up with the normal
IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. In
this case a 64-bit device wishing to DMA to 1GB would be told to DMA to
3GB, plus any offset required by firmware. The firmware offset is encoded
in the "dma-ranges" property.

On machines with 30GB or more of memory, we are unable to place the fixed
mapping above the normal IOMMU window as we would run out of address space.
Instead we move the normal IOMMU window to coincide with the hash page
table, this region does not need to be part of the fixed mapping as no
device should ever be DMA'ing to it. We then setup the fixed mapping
from 0 to 32GB.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |  269 +++++++++++++++++++++++++++++++=
+++-
 1 files changed, 267 insertions(+), 2 deletions(-)


Updated to include a description in the file.

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/c=
ell/iommu.c
index 3baade1..68274a0 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1,7 +1,7 @@
 /*
  * IOMMU implementation for Cell Broadband Processor Architecture
  *
- * (C) Copyright IBM Corporation 2006
+ * (C) Copyright IBM Corporation 2006-2008
  *
  * Author: Jeremy Kerr <jk@ozlabs.org>
  *
@@ -523,6 +523,9 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
=20
 static unsigned long cell_dma_direct_offset;
=20
+static unsigned long dma_iommu_fixed_base;
+struct dma_mapping_ops dma_iommu_fixed_ops;
+
 static void cell_dma_dev_setup_iommu(struct device *dev)
 {
 	struct iommu_window *window;
@@ -545,11 +548,16 @@ static void cell_dma_dev_setup_iommu(struct device *d=
ev)
 	archdata->dma_data =3D &window->table;
 }
=20
+static void cell_dma_dev_setup_static(struct device *dev);
+
 static void cell_dma_dev_setup(struct device *dev)
 {
 	struct dev_archdata *archdata =3D &dev->archdata;
=20
-	if (get_pci_dma_ops() =3D=3D &dma_iommu_ops)
+	/* Order is important here, these are not mutually exclusive */
+	if (get_dma_ops(dev) =3D=3D &dma_iommu_fixed_ops)
+		cell_dma_dev_setup_static(dev);
+	else if (get_pci_dma_ops() =3D=3D &dma_iommu_ops)
 		cell_dma_dev_setup_iommu(dev);
 	else if (get_pci_dma_ops() =3D=3D &dma_direct_ops)
 		archdata->dma_data =3D (void *)cell_dma_direct_offset;
@@ -752,6 +760,260 @@ static int __init cell_iommu_init_disabled(void)
 	return 0;
 }
=20
+/*
+ *  Fixed IOMMU mapping support
+ *
+ *  This code adds support for setting up a fixed IOMMU mapping on certain
+ *  cell machines. For 64-bit devices this avoids the performance overhead=
 of
+ *  mapping and unmapping pages at runtime. 32-bit devices are unable to u=
se
+ *  the fixed mapping.
+ *
+ *  The fixed mapping is established at boot, and maps all of physical mem=
ory
+ *  1:1 into device space at some offset. On machines with < 30 GB of memo=
ry
+ *  we setup the fixed mapping immediately above the normal IOMMU window.
+ *
+ *  For example a machine with 4GB of memory would end up with the normal
+ *  IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. =
In
+ *  this case a 64-bit device wishing to DMA to 1GB would be told to DMA t=
o
+ *  3GB, plus any offset required by firmware. The firmware offset is enco=
ded
+ *  in the "dma-ranges" property.
+ *
+ *  On machines with 30GB or more of memory, we are unable to place the fi=
xed
+ *  mapping above the normal IOMMU window as we would run out of address s=
pace.
+ *  Instead we move the normal IOMMU window to coincide with the hash page
+ *  table, this region does not need to be part of the fixed mapping as no
+ *  device should ever be DMA'ing to it. We then setup the fixed mapping
+ *  from 0 to 32GB.
+ */
+
+static u64 cell_iommu_get_fixed_address(struct device *dev)
+{
+	u64 cpu_addr, size, best_size, pci_addr =3D OF_BAD_ADDR;
+	struct device_node *tmp, *np;
+	const u32 *ranges =3D NULL;
+	int i, len, best;
+
+	np =3D dev->archdata.of_node;
+	of_node_get(np);
+	ranges =3D of_get_property(np, "dma-ranges", &len);
+	while (!ranges && np) {
+		tmp =3D of_get_parent(np);
+		of_node_put(np);
+		np =3D tmp;
+		ranges =3D of_get_property(np, "dma-ranges", &len);
+	}
+
+	if (!ranges) {
+		dev_dbg(dev, "iommu: no dma-ranges found\n");
+		goto out;
+	}
+
+	len /=3D sizeof(u32);
+
+	/* dma-ranges format:
+	 * 1 cell:  pci space
+	 * 2 cells: pci address
+	 * 2 cells: parent address
+	 * 2 cells: size
+	 */
+	for (i =3D 0, best =3D -1, best_size =3D 0; i < len; i +=3D 7) {
+		cpu_addr =3D of_translate_dma_address(np, ranges +i + 3);
+		size =3D of_read_number(ranges + i + 5, 2);
+
+		if (cpu_addr =3D=3D 0 && size > best_size) {
+			best =3D i;
+			best_size =3D size;
+		}
+	}
+
+	if (best >=3D 0)
+		pci_addr =3D of_read_number(ranges + best + 1, 2);
+	else
+		dev_dbg(dev, "iommu: no suitable range found!\n");
+
+out:
+	of_node_put(np);
+
+	return pci_addr;
+}
+
+static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+	if (dma_mask =3D=3D DMA_BIT_MASK(64)) {
+		if (cell_iommu_get_fixed_address(dev) =3D=3D OF_BAD_ADDR)
+			dev_dbg(dev, "iommu: 64-bit OK, but bad addr\n");
+		else {
+			dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
+			set_dma_ops(dev, &dma_iommu_fixed_ops);
+			cell_dma_dev_setup(dev);
+		}
+	} else {
+		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
+		set_dma_ops(dev, get_pci_dma_ops());
+	}
+
+	*dev->dma_mask =3D dma_mask;
+
+	return 0;
+}
+
+static void cell_dma_dev_setup_static(struct device *dev)
+{
+	struct dev_archdata *archdata =3D &dev->archdata;
+	u64 addr;
+
+	addr =3D cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
+	archdata->dma_data =3D (void *)addr;
+
+	dev_dbg(dev, "iommu: fixed addr =3D %lx\n", addr);
+}
+
+static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
+	struct device_node *np, unsigned long dbase, unsigned long dsize,
+	unsigned long fbase, unsigned long fsize)
+{
+	unsigned long base_pte, uaddr, *io_pte;
+	int i;
+
+	dma_iommu_fixed_base =3D fbase;
+
+	/* convert from bytes into page table indices */
+	dbase =3D dbase >> IOMMU_PAGE_SHIFT;
+	dsize =3D dsize >> IOMMU_PAGE_SHIFT;
+	fbase =3D fbase >> IOMMU_PAGE_SHIFT;
+	fsize =3D fsize >> IOMMU_PAGE_SHIFT;
+
+	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
+
+	io_pte =3D iommu->ptab;
+	base_pte =3D IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
+		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
+
+	uaddr =3D 0;
+	for (i =3D fbase; i < fbase + fsize; i++, uaddr +=3D IOMMU_PAGE_SIZE) {
+		/* Don't touch the dynamic region */
+		if (i >=3D dbase && i < (dbase + dsize)) {
+			pr_debug("iommu: static/dynamic overlap, skipping\n");
+			continue;
+		}
+		io_pte[i] =3D base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
+	}
+
+	mb();
+}
+
+static int __init cell_iommu_fixed_mapping_init(void)
+{
+	unsigned long dbase, dsize, fbase, fsize, hbase, hend;
+	struct cbe_iommu *iommu;
+	struct device_node *np;
+
+	/* The fixed mapping is only supported on axon machines */
+	np =3D of_find_node_by_name(NULL, "axon");
+	if (!np) {
+		pr_debug("iommu: fixed mapping disabled, no axons found\n");
+		return -1;
+	}
+
+	/* The default setup is to have the fixed mapping sit after the
+	 * dynamic region, so find the top of the largest IOMMU window
+	 * on any axon, then add the size of RAM and that's our max value.
+	 * If that is > 32GB we have to do other shennanigans.
+	 */
+	fbase =3D 0;
+	for_each_node_by_name(np, "axon") {
+		cell_iommu_get_window(np, &dbase, &dsize);
+		fbase =3D max(fbase, dbase + dsize);
+	}
+
+	fbase =3D _ALIGN_UP(fbase, 1 << IO_SEGMENT_SHIFT);
+	fsize =3D lmb_phys_mem_size();
+
+	if ((fbase + fsize) <=3D 0x800000000)
+		hbase =3D 0; /* use the device tree window */
+	else {
+		/* If we're over 32 GB we need to cheat. We can't map all of
+		 * RAM with the fixed mapping, and also fit the dynamic
+		 * region. So try to place the dynamic region where the hash
+		 * table sits, drivers never need to DMA to it, we don't
+		 * need a fixed mapping for that area.
+		 */
+		if (!htab_address) {
+			pr_debug("iommu: htab is NULL, on LPAR? Huh?\n");
+			return -1;
+		}
+		hbase =3D __pa(htab_address);
+		hend  =3D hbase + htab_size_bytes;
+
+		/* The window must start and end on a segment boundary */
+		if ((hbase !=3D _ALIGN_UP(hbase, 1 << IO_SEGMENT_SHIFT)) ||
+		    (hend !=3D _ALIGN_UP(hend, 1 << IO_SEGMENT_SHIFT))) {
+			pr_debug("iommu: hash window not segment aligned\n");
+			return -1;
+		}
+
+		/* Check the hash window fits inside the real DMA window */
+		for_each_node_by_name(np, "axon") {
+			cell_iommu_get_window(np, &dbase, &dsize);
+
+			if (hbase < dbase || (hend > (dbase + dsize))) {
+				pr_debug("iommu: hash window doesn't fit in"
+					 "real DMA window\n");
+				return -1;
+			}
+		}
+
+		fbase =3D 0;
+	}
+
+	/* Setup the dynamic regions */
+	for_each_node_by_name(np, "axon") {
+		iommu =3D cell_iommu_alloc(np);
+		BUG_ON(!iommu);
+
+		if (hbase =3D=3D 0)
+			cell_iommu_get_window(np, &dbase, &dsize);
+		else {
+			dbase =3D hbase;
+			dsize =3D htab_size_bytes;
+		}
+
+		pr_debug("iommu: setting up %d, dynamic window %lx-%lx " \
+			 "fixed window %lx-%lx\n", iommu->nid, dbase,
+			 dbase + dsize, fbase, fbase + fsize);
+
+		cell_iommu_setup_page_tables(iommu, dbase, dsize, fbase, fsize);
+		cell_iommu_setup_fixed_ptab(iommu, np, dbase, dsize,
+					     fbase, fsize);
+		cell_iommu_enable_hardware(iommu);
+		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
+	}
+
+	dma_iommu_fixed_ops =3D dma_direct_ops;
+	dma_iommu_fixed_ops.set_dma_mask =3D dma_set_mask_and_switch;
+
+	dma_iommu_ops.set_dma_mask =3D dma_set_mask_and_switch;
+	set_pci_dma_ops(&dma_iommu_ops);
+
+	printk(KERN_DEBUG "IOMMU fixed mapping established.\n");
+
+	return 0;
+}
+
+static int iommu_fixed_disabled;
+
+static int __init setup_iommu_fixed(char *str)
+{
+	if (strcmp(str, "off") =3D=3D 0)
+		iommu_fixed_disabled =3D 1;
+
+	return 1;
+}
+__setup("iommu_fixed=3D", setup_iommu_fixed);
+
 static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
@@ -771,6 +1033,9 @@ static int __init cell_iommu_init(void)
 	ppc_md.tce_build =3D tce_build_cell;
 	ppc_md.tce_free =3D tce_free_cell;
=20
+	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() =3D=3D 0)
+		goto bail;
+
 	/* Create an iommu for each /axon node.  */
 	for_each_node_by_name(np, "axon") {
 		if (np->parent =3D=3D NULL || np->parent->parent !=3D NULL)
--=20
1.5.3.7.1.g4e596e



--=-RaBUQUdPIM4DdCs4on5d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn77gdSjSd0sB4dIRApnQAKCaHcy1mb22I3RyOO0YdgXUBuUXnACgxwpN
/TrvRo1TEt1WlQ6bIQVzvDI=
=7Kwy
-----END PGP SIGNATURE-----

--=-RaBUQUdPIM4DdCs4on5d--
