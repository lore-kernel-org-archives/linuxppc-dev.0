Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F1E1A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 23:09:08 +1000 (AEST)
Date: Tue, 5 May 2015 22:05:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 22/32] powerpc/powernv: Implement multilevel
 TCE tables
Message-ID: <20150505120558.GN14090@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-23-git-send-email-aik@ozlabs.ru>
 <20150429050408.GS32589@voom.redhat.com> <55434C01.90808@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rTTzD97p2CCc/LGU"
In-Reply-To: <55434C01.90808@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rTTzD97p2CCc/LGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 07:48:49PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 03:04 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:46PM +1000, Alexey Kardashevskiy wrote:
> >>TCE tables might get too big in case of 4K IOMMU pages and DDW enabled
> >>on huge guests (hundreds of GB of RAM) so the kernel might be unable to
> >>allocate contiguous chunk of physical memory to store the TCE table.
> >>
> >>To address this, POWER8 CPU (actually, IODA2) supports multi-level TCE =
tables,
> >>up to 5 levels which splits the table into a tree of smaller subtables.
> >>
> >>This adds multi-level TCE tables support to pnv_pci_create_table()
> >>and pnv_pci_free_table() helpers.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v9:
> >>* moved from ioda2 to common powernv pci code
> >>* fixed cleanup if allocation fails in a middle
> >>* removed check for the size - all boundary checks happen in the callin=
g code
> >>anyway
> >>---
> >>  arch/powerpc/include/asm/iommu.h          |  2 +
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++--
> >>  arch/powerpc/platforms/powernv/pci.c      | 94 ++++++++++++++++++++++=
+++++++--
> >>  arch/powerpc/platforms/powernv/pci.h      |  4 +-
> >>  4 files changed, 104 insertions(+), 11 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index 7e7ca0a..0f50ee2 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -96,6 +96,8 @@ struct iommu_pool {
> >>  struct iommu_table {
> >>  	unsigned long  it_busno;     /* Bus number this table belongs to */
> >>  	unsigned long  it_size;      /* Size of iommu table in entries */
> >>+	unsigned long  it_indirect_levels;
> >>+	unsigned long  it_level_size;
> >>  	unsigned long  it_offset;    /* Offset into global table */
> >>  	unsigned long  it_base;      /* mapped address of tce table */
> >>  	unsigned long  it_index;     /* which iommu table this is */
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index 59baa15..cc1d09c 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1967,13 +1967,17 @@ static long pnv_pci_ioda2_set_window(struct iom=
mu_table_group *table_group,
> >>  			table_group);
> >>  	struct pnv_phb *phb =3D pe->phb;
> >>  	int64_t rc;
> >>+	const unsigned long size =3D tbl->it_indirect_levels ?
> >>+			tbl->it_level_size : tbl->it_size;
> >>  	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
> >>  	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> >>
> >>  	pe_info(pe, "Setting up window at %llx..%llx "
> >>-			"pgsize=3D0x%x tablesize=3D0x%lx\n",
> >>+			"pgsize=3D0x%x tablesize=3D0x%lx "
> >>+			"levels=3D%d levelsize=3D%x\n",
> >>  			start_addr, start_addr + win_size - 1,
> >>-			1UL << tbl->it_page_shift, tbl->it_size << 3);
> >>+			1UL << tbl->it_page_shift, tbl->it_size << 3,
> >>+			tbl->it_indirect_levels + 1, tbl->it_level_size << 3);
> >>
> >>  	tbl->it_table_group =3D &pe->table_group;
> >>
> >>@@ -1984,9 +1988,9 @@ static long pnv_pci_ioda2_set_window(struct iommu=
_table_group *table_group,
> >>  	rc =3D opal_pci_map_pe_dma_window(phb->opal_id,
> >>  			pe->pe_number,
> >>  			pe->pe_number << 1,
> >>-			1,
> >>+			tbl->it_indirect_levels + 1,
> >>  			__pa(tbl->it_base),
> >>-			tbl->it_size << 3,
> >>+			size << 3,
> >>  			1ULL << tbl->it_page_shift);
> >>  	if (rc) {
> >>  		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
> >>@@ -2099,7 +2103,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  		phb->ioda.m32_pci_base);
> >>
> >>  	rc =3D pnv_pci_create_table(&pe->table_group, pe->phb->hose->node,
> >>-			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
> >>+			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
> >>+			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
> >>  	if (rc) {
> >>  		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> >>  		return;
> >>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> >>index 6bcfad5..fc129c4 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.c
> >>+++ b/arch/powerpc/platforms/powernv/pci.c
> >>@@ -46,6 +46,8 @@
> >>  #define cfg_dbg(fmt...)	do { } while(0)
> >>  //#define cfg_dbg(fmt...)	printk(fmt)
> >>
> >>+#define ROUND_UP(x, n) (((x) + (n) - 1ULL) & ~((n) - 1ULL))
> >
> >Use the existing ALIGN_UP macro instead of creating a new one.
>=20
> Ok. I knew it existed, it is just _ALIGN_UP (with an underscore) and
> PPC-only - this is why I did not find it :)

I'm pretty sure there's a generic one too.  I think it's just plain
"ALIGN".

> >>  #ifdef CONFIG_PCI_MSI
> >>  static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int typ=
e)
> >>  {
> >>@@ -577,6 +579,19 @@ struct pci_ops pnv_pci_ops =3D {
> >>  static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
> >>  {
> >>  	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> >>+	int  level =3D tbl->it_indirect_levels;
> >>+	const long shift =3D ilog2(tbl->it_level_size);
> >>+	unsigned long mask =3D (tbl->it_level_size - 1) << (level * shift);
> >>+
> >>+	while (level) {
> >>+		int n =3D (idx & mask) >> (level * shift);
> >>+		unsigned long tce =3D be64_to_cpu(tmp[n]);
> >>+
> >>+		tmp =3D __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
> >>+		idx &=3D ~mask;
> >>+		mask >>=3D shift;
> >>+		--level;
> >>+	}
> >>
> >>  	return tmp + idx;
> >>  }
> >>@@ -648,12 +663,18 @@ void pnv_pci_setup_iommu_table(struct iommu_table=
 *tbl,
> >>  }
> >>
> >>  static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
> >>+		unsigned levels, unsigned long limit,
> >>  		unsigned long *tce_table_allocated)
> >>  {
> >>  	struct page *tce_mem =3D NULL;
> >>-	__be64 *addr;
> >>+	__be64 *addr, *tmp;
> >>  	unsigned order =3D max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
> >>  	unsigned long local_allocated =3D 1UL << (order + PAGE_SHIFT);
> >>+	unsigned entries =3D 1UL << (shift - 3);
> >>+	long i;
> >>+
> >>+	if (limit =3D=3D *tce_table_allocated)
> >>+		return NULL;
> >
> >If this is for what I think, it seems a bit unsafe.  Shouldn't it be
> >>=3D, otherwise it could fail to trip if the limit isn't exactly a
> >>multiple of the bottom level allocation unit.
>=20
> Good point, will fix.
>=20
>=20
> >>  	tce_mem =3D alloc_pages_node(nid, GFP_KERNEL, order);
> >>  	if (!tce_mem) {
> >>@@ -662,14 +683,33 @@ static __be64 *pnv_alloc_tce_table_pages(int nid,=
 unsigned shift,
> >>  	}
> >>  	addr =3D page_address(tce_mem);
> >>  	memset(addr, 0, local_allocated);
> >>-	*tce_table_allocated =3D local_allocated;
> >>+
> >>+	--levels;
> >>+	if (!levels) {
> >>+		/* Update tce_table_allocated with bottom level table size only */
> >>+		*tce_table_allocated +=3D local_allocated;
> >>+		return addr;
> >>+	}
> >>+
> >>+	for (i =3D 0; i < entries; ++i) {
> >>+		tmp =3D pnv_alloc_tce_table_pages(nid, shift, levels, limit,
> >>+				tce_table_allocated);
> >
> >Urgh.. it's a limited depth so it *might* be ok, but recursion is
> >generally avoided in the kernel, becuase of the very limited stack
> >size.
>=20
>=20
> It is 5 levels max 7 64bit values, there should be room for it. Avoiding
> recursion here - I can do that but it is going to look ugly :-/

Yeah, I guess.  Probably worth a comment noting why the recusion depth
is limited though.

>=20
>=20
> >>+		if (!tmp)
> >>+			break;
> >>+
> >>+		addr[i] =3D cpu_to_be64(__pa(tmp) |
> >>+				TCE_PCI_READ | TCE_PCI_WRITE);
> >>+	}
> >
> >It also seems like it would make sense for this function ti set
> >it_indirect_levels ant it_level_size, rather than leaving it to the
> >caller.
>=20
>=20
> Mmm. Sure? It calls itself in recursion, does not seem like it is the rig=
ht
> place for setting up it_indirect_levels ant it_level_size.

Yeah, ok, I hadn't properly thought through the recursion.

> >>  	return addr;
> >>  }
> >>
> >>+static void pnv_free_tce_table_pages(unsigned long addr, unsigned long=
 size,
> >>+		unsigned level);
> >>+
> >>  long pnv_pci_create_table(struct iommu_table_group *table_group, int =
nid,
> >>  		__u64 bus_offset, __u32 page_shift, __u64 window_size,
> >>-		struct iommu_table *tbl)
> >>+		__u32 levels, struct iommu_table *tbl)
> >>  {
> >>  	void *addr;
> >>  	unsigned long tce_table_allocated =3D 0;
> >>@@ -678,16 +718,34 @@ long pnv_pci_create_table(struct iommu_table_grou=
p *table_group, int nid,
> >>  	unsigned table_shift =3D entries_shift + 3;
> >>  	const unsigned long tce_table_size =3D max(0x1000UL, 1UL << table_sh=
ift);
> >>
> >>+	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
> >>+		return -EINVAL;
> >>+
> >>  	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_si=
ze))
> >>  		return -EINVAL;
> >>
> >>+	/* Adjust direct table size from window_size and levels */
> >>+	entries_shift =3D ROUND_UP(entries_shift, levels) / levels;
> >
> >ROUND_UP() only works if the second parameter is a power of 2.  Is
> >that always true for levels?
> >
> >For division rounding up, the usual idiom is just ((a + (b - 1)) / b)
>=20
>=20
> Yes, I think this is what I actually wanted.
>=20
>=20
> >>+	table_shift =3D entries_shift + 3;
> >>+	table_shift =3D max_t(unsigned, table_shift, PAGE_SHIFT);
> >
> >Does the PAGE_SHIFT rounding make sense any more?  I would have
> >thought you'd round the level size up to page size, rather than the
> >whole thing.
>=20
>=20
> At this point in the code @table_shift is level_shift but it is not that
> obvious :) I'll rework it. Thanks.
>=20
>=20
> >>  	/* Allocate TCE table */
> >>  	addr =3D pnv_alloc_tce_table_pages(nid, table_shift,
> >>-			&tce_table_allocated);
> >>+			levels, tce_table_size, &tce_table_allocated);
> >>+	if (!addr)
> >>+		return -ENOMEM;
> >>+
> >>+	if (tce_table_size !=3D tce_table_allocated) {
> >>+		pnv_free_tce_table_pages((unsigned long) addr,
> >>+				tbl->it_level_size, tbl->it_indirect_levels);
> >>+		return -ENOMEM;
> >>+	}
> >>
> >>  	/* Setup linux iommu table */
> >>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
> >>  			page_shift);
> >>+	tbl->it_level_size =3D 1ULL << (table_shift - 3);
> >>+	tbl->it_indirect_levels =3D levels - 1;
> >>
> >>  	pr_info("Created TCE table: window size =3D %08llx, "
> >>  			"tablesize =3D %lx (%lx), start @%08llx\n",
> >>@@ -697,12 +755,38 @@ long pnv_pci_create_table(struct iommu_table_grou=
p *table_group, int nid,
> >>  	return 0;
> >>  }
> >>
> >>+static void pnv_free_tce_table_pages(unsigned long addr, unsigned long=
 size,
> >>+		unsigned level)
> >>+{
> >>+	addr &=3D ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >>+
> >>+	if (level) {
> >>+		long i;
> >>+		u64 *tmp =3D (u64 *) addr;
> >>+
> >>+		for (i =3D 0; i < size; ++i) {
> >>+			unsigned long hpa =3D be64_to_cpu(tmp[i]);
> >>+
> >>+			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
> >>+				continue;
> >>+
> >>+			pnv_free_tce_table_pages((unsigned long) __va(hpa),
> >>+					size, level - 1);
> >>+		}
> >>+	}
> >>+
> >>+	free_pages(addr, get_order(size << 3));
> >>+}
> >>+
> >>  void pnv_pci_free_table(struct iommu_table *tbl)
> >>  {
> >>+	const unsigned long size =3D tbl->it_indirect_levels ?
> >>+			tbl->it_level_size : tbl->it_size;
> >>+
> >>  	if (!tbl->it_size)
> >>  		return;
> >>
> >>-	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> >>+	pnv_free_tce_table_pages(tbl->it_base, size, tbl->it_indirect_levels);
> >>  	iommu_reset_table(tbl, "pnv");
> >>  }
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> >>index e6cbbec..3d1ff584 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.h
> >>+++ b/arch/powerpc/platforms/powernv/pci.h
> >>@@ -218,9 +218,11 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
> >>  extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
> >>  				      void *tce_mem, u64 tce_size,
> >>  				      u64 dma_offset, unsigned page_shift);
> >>+#define POWERNV_IOMMU_DEFAULT_LEVELS	1
> >>+#define POWERNV_IOMMU_MAX_LEVELS	5
> >>  extern long pnv_pci_create_table(struct iommu_table_group *table_grou=
p, int nid,
> >>  		__u64 bus_offset, __u32 page_shift, __u64 window_size,
> >>-		struct iommu_table *tbl);
> >>+		__u32 levels, struct iommu_table *tbl);
> >>  extern void pnv_pci_free_table(struct iommu_table *tbl);
> >>  extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
> >>  extern void pnv_pci_init_ioda_hub(struct device_node *np);
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rTTzD97p2CCc/LGU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVSLImAAoJEGw4ysog2bOSThwP/2lnbwCsOQaYxGInLDifRsoK
ibA2R13115VLpdgYTo7mHoOJsbQ9zLsgtPKprHYQK3l/PVHdEpWoAb+LxdJRAHmu
mmIJxZHCXuDo3QhtPfA73Nrfg84Bz2JMpJOJ7gkQ6ukr4gZUsJP5P8VpCOKyNiKx
n14UHOHc77blrK4EM1CUkDwlS9+NnrmsszYs5rEatBAgbSru4vwpMGRb8O56kyKH
gDVtCfA++wnW1jCmeZ08jSRusitXqm6hf/OzUvVteaDLoeguuaWVM83Y8cGrEdDr
f/UNo8GXlyB2lQ5GeBcMYUwn4JZfKrBCD5HEE2TzzmZOeTTr4uRAuhDLSM07EYnG
rEn/E6iGFkAnDzG7q0SdPYvsUOf4AphNm0HbkE8xguPwAJHlxAbeT5r+Zzmv2Fb5
o0QU0xWlhF8V8Fx62Ibmvy17zHTv6V5KoUDqQkTd5/5zC0Wzk7B7D3nEhPC/l4oe
OKE3tCRRePxuKQgAUVS+kwBNTy38Oi95ls8fKASsZ2cowMVmYf3k27v3gMIm3P1g
67mIAVf/smC8gsP1C+kgKk8WOZSXRGOCKLUkajJU/UThZLJk0jHbVH5F38UjikfD
HUgsVJQvJg2cCoYz3uPTGIn83Etdq3onQ4JHVnIQEps2Z8kKTz+/hgp/O1xzDKoE
pTK7B+7oKu1WgZdZ1xd/
=nyP0
-----END PGP SIGNATURE-----

--rTTzD97p2CCc/LGU--
