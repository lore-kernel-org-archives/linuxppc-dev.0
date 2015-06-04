Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A79201A025F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 11:25:34 +1000 (AEST)
Date: Thu, 4 Jun 2015 11:20:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 33/34] vfio: powerpc/spapr: Register memory
 and define IOMMU v2
Message-ID: <20150604012022.GE5590@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-34-git-send-email-aik@ozlabs.ru>
 <20150602041749.GF3186@voom.fritz.box> <556EE7C1.8040502@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
In-Reply-To: <556EE7C1.8040502@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 09:40:49PM +1000, Alexey Kardashevskiy wrote:
> On 06/02/2015 02:17 PM, David Gibson wrote:
> >On Fri, May 29, 2015 at 06:44:57PM +1000, Alexey Kardashevskiy wrote:
> >>The existing implementation accounts the whole DMA window in
> >>the locked_vm counter. This is going to be worse with multiple
> >>containers and huge DMA windows. Also, real-time accounting would requi=
te
> >>additional tracking of accounted pages due to the page size difference -
> >>IOMMU uses 4K pages and system uses 4K or 64K pages.
> >>
> >>Another issue is that actual pages pinning/unpinning happens on every
> >>DMA map/unmap request. This does not affect the performance much now as
> >>we spend way too much time now on switching context between
> >>guest/userspace/host but this will start to matter when we add in-kernel
> >>DMA map/unmap acceleration.
> >>
> >>This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
> >>New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
> >>2 new ioctls to register/unregister DMA memory -
> >>VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY=
 -
> >>which receive user space address and size of a memory region which
> >>needs to be pinned/unpinned and counted in locked_vm.
> >>New IOMMU splits physical pages pinning and TCE table update
> >>into 2 different operations. It requires:
> >>1) guest pages to be registered first
> >>2) consequent map/unmap requests to work only with pre-registered memor=
y.
> >>For the default single window case this means that the entire guest
> >>(instead of 2GB) needs to be pinned before using VFIO.
> >>When a huge DMA window is added, no additional pinning will be
> >>required, otherwise it would be guest RAM + 2GB.
> >>
> >>The new memory registration ioctls are not supported by
> >>VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
> >>will require memory to be preregistered in order to work.
> >>
> >>The accounting is done per the user process.
> >>
> >>This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
> >>can do with v1 or v2 IOMMUs.
> >>
> >>In order to support memory pre-registration, we need a way to track
> >>the use of every registered memory region and only allow unregistration
> >>if a region is not in use anymore. So we need a way to tell from what
> >>region the just cleared TCE was from.
> >>
> >>This adds a userspace view of the TCE table into iommu_table struct.
> >>It contains userspace address, one per TCE entry. The table is only
> >>allocated when the ownership over an IOMMU group is taken which means
> >>it is only used from outside of the powernv code (such as VFIO).
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>---
> >>Changes:
> >>v11:
> >>* mm_iommu_put() does not return a code so this does not check it
> >>* moved "v2" in tce_container to pack the struct
> >>
> >>v10:
> >>* moved it_userspace allocation to vfio_iommu_spapr_tce as it VFIO
> >>specific thing
> >>* squashed "powerpc/iommu: Add userspace view of TCE table" into this as
> >>it is
> >>a part of IOMMU v2
> >>* s/tce_iommu_use_page_v2/tce_iommu_prereg_ua_to_hpa/
> >>* fixed some function names to have "tce_iommu_" in the beginning rather
> >>just "tce_"
> >>* as mm_iommu_mapped_inc() can now fail, check for the return code
> >>
> >>v9:
> >>* s/tce_get_hva_cached/tce_iommu_use_page_v2/
> >>
> >>v7:
> >>* now memory is registered per mm (i.e. process)
> >>* moved memory registration code to powerpc/mmu
> >>* merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
> >>* limited new ioctls to v2 IOMMU
> >>* updated doc
> >>* unsupported ioclts return -ENOTTY instead of -EPERM
> >>
> >>v6:
> >>* tce_get_hva_cached() returns hva via a pointer
> >>
> >>v4:
> >>* updated docs
> >>* s/kzmalloc/vzalloc/
> >>* in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
> >>replaced offset with index
> >>* renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_=
memory
> >>and removed duplicating vfio_iommu_spapr_register_memory
> >>---
> >>  Documentation/vfio.txt              |  31 ++-
> >>  arch/powerpc/include/asm/iommu.h    |   6 +
> >>  drivers/vfio/vfio_iommu_spapr_tce.c | 512 +++++++++++++++++++++++++++=
+++------
> >>  include/uapi/linux/vfio.h           |  27 ++
> >>  4 files changed, 487 insertions(+), 89 deletions(-)
> >>
> >>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >>index 96978ec..7dcf2b5 100644
> >>--- a/Documentation/vfio.txt
> >>+++ b/Documentation/vfio.txt
> >>@@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
> >>
> >>  This implementation has some specifics:
> >>
> >>-1) Only one IOMMU group per container is supported as an IOMMU group
> >>-represents the minimal entity which isolation can be guaranteed for and
> >>-groups are allocated statically, one per a Partitionable Endpoint (PE)
> >>+1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
> >>+container is supported as an IOMMU table is allocated at the boot time,
> >>+one table per a IOMMU group which is a Partitionable Endpoint (PE)
> >>  (PE is often a PCI domain but not always).
> >>+Newer systems (POWER8 with IODA2) have improved hardware design which =
allows
> >>+to remove this limitation and have multiple IOMMU groups per a VFIO co=
ntainer.
> >>
> >>  2) The hardware supports so called DMA windows - the PCI address range
> >>  within which DMA transfer is allowed, any attempt to access address s=
pace
> >>@@ -427,6 +429,29 @@ The code flow from the example above should be sli=
ghtly changed:
> >>
> >>  	....
> >>
> >>+5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
> >>+VFIO_IOMMU_DISABLE and implements 2 new ioctls:
> >>+VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
> >>+(which are unsupported in v1 IOMMU).
> >>+
> >>+PPC64 paravirtualized guests generate a lot of map/unmap requests,
> >>+and the handling of those includes pinning/unpinning pages and updating
> >>+mm::locked_vm counter to make sure we do not exceed the rlimit.
> >>+The v2 IOMMU splits accounting and pinning into separate operations:
> >>+
> >>+- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY =
ioctls
> >>+receive a user space address and size of the block to be pinned.
> >>+Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expecte=
d to
> >>+be called with the exact address and size used for registering
> >>+the memory block. The userspace is not expected to call these often.
> >>+The ranges are stored in a linked list in a VFIO container.
> >>+
> >>+- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
> >>+IOMMU table and do not do pinning; instead these check that the usersp=
ace
> >>+address is from pre-registered range.
> >>+
> >>+This separation helps in optimizing DMA for guests.
> >>+
> >>  ---------------------------------------------------------------------=
----------
> >>
> >>  [1] VFIO was originally an acronym for "Virtual Function I/O" in its
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index 9d37492..f9957eb 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -112,9 +112,15 @@ struct iommu_table {
> >>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
> >>  	unsigned long  it_page_shift;/* table iommu page size */
> >>  	struct list_head it_group_list;/* List of iommu_table_group_link */
> >>+	unsigned long *it_userspace; /* userspace view of the table */
> >>  	struct iommu_table_ops *it_ops;
> >>  };
> >>
> >>+#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> >>+		((tbl)->it_userspace ? \
> >>+			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
> >>+			NULL)
> >>+
> >>  /* Pure 2^n version of get_order */
> >>  static inline __attribute_const__
> >>  int get_iommu_order(unsigned long size, struct iommu_table *tbl)
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index 7a84110..cadd9f8 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -19,8 +19,10 @@
> >>  #include <linux/uaccess.h>
> >>  #include <linux/err.h>
> >>  #include <linux/vfio.h>
> >>+#include <linux/vmalloc.h>
> >>  #include <asm/iommu.h>
> >>  #include <asm/tce.h>
> >>+#include <asm/mmu_context.h>
> >>
> >>  #define DRIVER_VERSION  "0.1"
> >>  #define DRIVER_AUTHOR   "aik@ozlabs.ru"
> >>@@ -81,6 +83,11 @@ static void decrement_locked_vm(long npages)
> >>   * into DMA'ble space using the IOMMU
> >>   */
> >>
> >>+struct tce_iommu_group {
> >>+	struct list_head next;
> >>+	struct iommu_group *grp;
> >>+};
> >>+
> >>  /*
> >>   * The container descriptor supports only a single group per containe=
r.
> >>   * Required by the API as the container is not supplied with the IOMM=
U group
> >>@@ -88,11 +95,84 @@ static void decrement_locked_vm(long npages)
> >>   */
> >>  struct tce_container {
> >>  	struct mutex lock;
> >>-	struct iommu_group *grp;
> >>  	bool enabled;
> >>+	bool v2;
> >>  	unsigned long locked_pages;
> >>+	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>+	struct list_head group_list;
> >>  };
> >>
> >>+static long tce_iommu_unregister_pages(struct tce_container *container,
> >>+		__u64 vaddr, __u64 size)
> >>+{
> >>+	struct mm_iommu_table_group_mem_t *mem;
> >>+
> >>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> >>+		return -EINVAL;
> >>+
> >>+	mem =3D mm_iommu_lookup(vaddr, size >> PAGE_SHIFT);
> >>+	if (!mem)
> >>+		return -EINVAL;
> >
> >Uh.. contrary to the commit message this doesn't enforce that the
> >unregister is called on the exact same vaddr and size as was
> >registered.  Instead a call to unregister will unregister the first
> >registered region that overlaps with the specified region.
>=20
>=20
> Ah. There was another precise-lookup function which I removed during these
> rebased and got this bug. Will fix it, good catch.
>=20
>=20
> >Also, ENOENT might be a better error code for this case (couldn't find
> >a matching registered region) - EINVAL is rather overused.
>=20
> Ok.
>=20
>=20
>=20
> >>+
> >>+	return mm_iommu_put(mem);
> >>+}
> >>+
> >>+static long tce_iommu_register_pages(struct tce_container *container,
> >>+		__u64 vaddr, __u64 size)
> >>+{
> >>+	long ret =3D 0;
> >>+	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>+	unsigned long entries =3D size >> PAGE_SHIFT;
> >>+
> >>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> >>+			((vaddr + size) < vaddr))
> >>+		return -EINVAL;
> >>+
> >>+	ret =3D mm_iommu_get(vaddr, entries, &mem);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	container->enabled =3D true;
> >
> >I'm assuming that once any region is registered you can no longer add
> >or remove groups from the container?  That's fine but it might want a
> >more prominent notice in the docs.
>=20
>=20
> No, you can add/remove groups. The only limitation here is when removing =
the
> very last group, there should be no active mappings. Or hotplug would be
> broken.

Ok.

[snip]
> >>@@ -622,23 +918,45 @@ static long tce_iommu_take_ownership_ddw(struct t=
ce_container *container,
> >>
> >>  	table_group->ops->take_ownership(table_group);
> >>
> >>-	ret =3D tce_iommu_create_table(container,
> >>-			table_group,
> >>-			0, /* window number */
> >>-			IOMMU_PAGE_SHIFT_4K,
> >>-			table_group->tce32_size,
> >>-			1, /* default levels */
> >>-			&tbl);
> >>-	if (!ret) {
> >>-		ret =3D table_group->ops->set_window(table_group, 0, tbl);
> >>+	/*
> >>+	 * If it the first group attached, check if there is
> >>+	 * a default DMA window and create one if none as
> >>+	 * the userspace expects it to exist.
> >
> >You could choose not to create the 32-bit DMA window by default for v2
> >containers.  But I don't know if that would actually simplify anything.
>=20
>=20
> Current machine reset code in QEMU removes all windows and creates the
> default one. So there better be something to remove (to suppress QEMU err=
or
> messages), that is the main reason.

I don't see what you're getting at here.  The qemu code will have to
change to enable v2 containers anyway, in which case it could also be
changed to handle the creation of the 32-bit window in qemu instead of
the kernel.

Oh.. wait.. except I keep forgetting that v2 containers can still
handle pre-IODA IOMMUs that don't do ddw at all, so not initializing
the default window would given an inconsistent state for a fresh
container.

Ok. it makes sense as it is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb6fWAAoJEGw4ysog2bOSb5MP/3oAe3/BH2b+fdj2iVng4cNY
AWWMP3EcmavhH6kcbR1BRh0+dWW8er7yU2hzpKMR3vsvHXHto7njuyICA4kQuIwk
wsD07Lyk5f81pJLHn7w1y+/sQqITjq9InYyxf2KGzh4bvbyXdvL45/3tw6XK1ona
JARaatefbL+wugb3og/BBmm7lw0A6ebgwMWM8ku5L+JlepoY6M4OCe+YYi4vWTj9
nrfME24Mx33r9TBaY7cqvf0EIvksf/xmb7WhbR4Ayl9QwrM6vZjCt7gLjlZdD6ou
x2aYN+CMdjCCIkFR4y7x4eIEgD2S4d8H/XlfNeWR9Jjm3N+6b9MtGyzFOMxgJeh6
ujYUbvw3cW8AFihos+zUJyHH/HyQkccXfsmxpYoEMOc+6ZzGXnHL3Dp+lrKeZxST
UNzGdK5xvloKuwkBw9fg4U6oPvT9CFKURGuj5gxR7inYjnCoRYMTKMtC2aB3xT8l
61Wy1H0DpOhJZSJ5KQZGqqRxxwEMuDlyG73rVDe9E1sqmPCbvq4E89Mx4KhCXlDM
DTSEu8nK5oRFue/XIdK5SrGSwUT7EyHi+CE92kY4c3iKKCyj1UsLYK9H+0z3Whka
HX1hxgsPysGjhsc64FIdZX9lRwt4s5QobWjT1V5eEwPuFPxbwX3K/XsaumIMHilJ
jJPPVRl2empt4n5QNQxe
=W/Mw
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
