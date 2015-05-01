Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 545211A0D0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 15:24:04 +1000 (AEST)
Date: Fri, 1 May 2015 15:23:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 29/32] vfio: powerpc/spapr: Register memory and
 define IOMMU v2
Message-ID: <20150501052357.GQ24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-30-git-send-email-aik@ozlabs.ru>
 <20150430065524.GB24886@voom.redhat.com> <5543028B.300@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
In-Reply-To: <5543028B.300@ozlabs.ru>
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


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 02:35:23PM +1000, Alexey Kardashevskiy wrote:
> On 04/30/2015 04:55 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:53PM +1000, Alexey Kardashevskiy wrote:
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
> >>New IOMMU splits physical pages pinning and TCE table update into 2 dif=
ferent
> >>operations. It requires 1) guest pages to be registered first 2) conseq=
uent
> >>map/unmap requests to work only with pre-registered memory.
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
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>---
> >>Changes:
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
> >>  Documentation/vfio.txt              |  23 ++++
> >>  drivers/vfio/vfio_iommu_spapr_tce.c | 230 +++++++++++++++++++++++++++=
++++++++-
> >>  include/uapi/linux/vfio.h           |  27 +++++
> >>  3 files changed, 274 insertions(+), 6 deletions(-)
> >>
> >>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >>index 96978ec..94328c8 100644
> >>--- a/Documentation/vfio.txt
> >>+++ b/Documentation/vfio.txt
> >>@@ -427,6 +427,29 @@ The code flow from the example above should be sli=
ghtly changed:
> >>
> >>  	....
> >>
> >>+5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
> >>+VFIO_IOMMU_DISABLE and implements 2 new ioctls:
> >>+VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
> >>+(which are unsupported in v1 IOMMU).
> >
> >A summary of the semantic differeces between v1 and v2 would be nice.
> >At this point it's not really clear to me if there's a case for
> >creating v2, or if this could just be done by adding (optional)
> >functionality to v1.
>=20
> v1: memory preregistration is not supported; explicit enable/disable ioct=
ls
> are required
>=20
> v2: memory preregistration is required; explicit enable/disable are
> prohibited (as they are not needed).
>=20
> Mixing these in one IOMMU type caused a lot of problems like should I
> increment locked_vm by the 32bit window size on enable() or not; what do I
> do about pages pinning when map/map (check if it is from registered memory
> and do not pin?).
>=20
> Having 2 IOMMU models makes everything a lot simpler.

Ok.  Would it simplify it further if you made v2 only usable on IODA2
hardware?

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
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index 892a584..4cfc2c1 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >
> >So, from things you said at other points, I thought the idea was that
> >this registration stuff could also be used on non-Power IOMMUs.  Did I
> >misunderstand, or is that a possibility for the future?
>=20
>=20
> I never said a thing about non-PPC :) I seriously doubt any other arch has
> this hypervisor interface with H_PUT_TCE (may be s390? :) ); for others
> there is no profit from memory preregistration as they (at least x86) do =
map
> the entire guest before it starts which essentially is that preregistrati=
on.
>=20
>=20
> btw later we may want to implement simple IOMMU v3 which will do pinning +
> locked_vm when mapping as x86 does, for http://dpdk.org/ - these things do
> not really have to bother with preregistration (even if it just a single
> additional ioctl).
>=20
>=20
>=20
> >>@@ -21,6 +21,7 @@
> >>  #include <linux/vfio.h>
> >>  #include <asm/iommu.h>
> >>  #include <asm/tce.h>
> >>+#include <asm/mmu_context.h>
> >>
> >>  #define DRIVER_VERSION  "0.1"
> >>  #define DRIVER_AUTHOR   "aik@ozlabs.ru"
> >>@@ -91,8 +92,58 @@ struct tce_container {
> >>  	struct iommu_group *grp;
> >>  	bool enabled;
> >>  	unsigned long locked_pages;
> >>+	bool v2;
> >>  };
> >>
> >>+static long tce_unregister_pages(struct tce_container *container,
> >>+		__u64 vaddr, __u64 size)
> >>+{
> >>+	long ret;
> >>+	struct mm_iommu_table_group_mem_t *mem;
> >>+
> >>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> >>+		return -EINVAL;
> >>+
> >>+	mem =3D mm_iommu_get(vaddr, size >> PAGE_SHIFT);
> >>+	if (!mem)
> >>+		return -EINVAL;
> >>+
> >>+	ret =3D mm_iommu_put(mem); /* undo kref_get() from mm_iommu_get() */
> >>+	if (!ret)
> >>+		ret =3D mm_iommu_put(mem);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static long tce_register_pages(struct tce_container *container,
> >>+		__u64 vaddr, __u64 size)
> >>+{
> >>+	long ret =3D 0;
> >>+	struct mm_iommu_table_group_mem_t *mem;
> >>+	unsigned long entries =3D size >> PAGE_SHIFT;
> >>+
> >>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> >>+			((vaddr + size) < vaddr))
> >>+		return -EINVAL;
> >>+
> >>+	mem =3D mm_iommu_get(vaddr, entries);
> >>+	if (!mem) {
> >>+		ret =3D try_increment_locked_vm(entries);
> >>+		if (ret)
> >>+			return ret;
> >>+
> >>+		ret =3D mm_iommu_alloc(vaddr, entries, &mem);
> >>+		if (ret) {
> >>+			decrement_locked_vm(entries);
> >>+			return ret;
> >>+		}
> >>+	}
> >>+
> >>+	container->enabled =3D true;
> >>+
> >>+	return 0;
> >>+}
> >
> >So requiring that registered regions get unregistered with exactly the
> >same addr/length is reasonable.  I'm a bit less convinced that
> >disallowing overlaps is a good idea.  What if two libraries in the
> >same process are trying to use VFIO - they may not know if the regions
> >they try to register are overlapping.
>=20
>=20
> Sorry, I do not understand. A library allocates RAM. A library is expected
> to do register it via additional ioctl, that's it. Another library alloca=
tes
> another chunk of memory and it won't overlap and the registered areas won=
't
> either.

So the case I'm thinking is where the library does VFIO using a buffer
passed into it from the program at large.  Another library does the
same.

The main program, unaware of the VFIO shenanigans passes different
parts of the same page to the 2 libraries.

This is somewhat similar to the case of the horribly, horribly broken
semantics of POSIX file range locks (it's both hard to implement and
dangerous in the multi-library case similar to above).

>=20
>=20
> >>  static bool tce_page_is_contained(struct page *page, unsigned page_sh=
ift)
> >>  {
> >>  	/*
> >>@@ -205,7 +256,7 @@ static void *tce_iommu_open(unsigned long arg)
> >>  {
> >>  	struct tce_container *container;
> >>
> >>-	if (arg !=3D VFIO_SPAPR_TCE_IOMMU) {
> >>+	if ((arg !=3D VFIO_SPAPR_TCE_IOMMU) && (arg !=3D VFIO_SPAPR_TCE_v2_IO=
MMU)) {
> >>  		pr_err("tce_vfio: Wrong IOMMU type\n");
> >>  		return ERR_PTR(-EINVAL);
> >>  	}
> >>@@ -215,6 +266,7 @@ static void *tce_iommu_open(unsigned long arg)
> >>  		return ERR_PTR(-ENOMEM);
> >>
> >>  	mutex_init(&container->lock);
> >>+	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> >>
> >>  	return container;
> >>  }
> >>@@ -243,6 +295,47 @@ static void tce_iommu_unuse_page(struct tce_contai=
ner *container,
> >>  	put_page(page);
> >>  }
> >>
> >>+static int tce_iommu_use_page_v2(unsigned long tce, unsigned long size,
> >>+		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>=20
>=20
> You suggested s/tce_get_hpa/tce_iommu_use_page/ but in this particular pa=
tch
> it is confusing as tce_iommu_unuse_page_v2() calls it to find correspondi=
ng
> mm_iommu_table_group_mem_t by the userspace address address of a page bei=
ng
> stopped used.
>=20
> tce_iommu_use_page (without v2) does use the page but this one I'll rename
> back to tce_iommu_ua_to_hpa_v2(), is that ok?

Sorry, I couldn't follow this comment.

>=20
>=20
> >>+{
> >>+	long ret =3D 0;
> >>+	struct mm_iommu_table_group_mem_t *mem;
> >>+
> >>+	mem =3D mm_iommu_lookup(tce, size);
> >>+	if (!mem)
> >>+		return -EINVAL;
> >>+
> >>+	ret =3D mm_iommu_ua_to_hpa(mem, tce, phpa);
> >>+	if (ret)
> >>+		return -EINVAL;
> >>+
> >>+	*pmem =3D mem;
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> >>+		unsigned long entry)
> >>+{
> >>+	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>+	int ret;
> >>+	unsigned long hpa =3D 0;
> >>+	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >>+
> >>+	if (!pua || !current || !current->mm)
> >>+		return;
> >>+
> >>+	ret =3D tce_iommu_use_page_v2(*pua, IOMMU_PAGE_SIZE(tbl),
> >>+			&hpa, &mem);
> >>+	if (ret)
> >>+		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> >>+				__func__, *pua, entry, ret);
> >>+	if (mem)
> >>+		mm_iommu_mapped_update(mem, false);
> >>+
> >>+	*pua =3D 0;
> >>+}
> >>+
> >>  static int tce_iommu_clear(struct tce_container *container,
> >>  		struct iommu_table *tbl,
> >>  		unsigned long entry, unsigned long pages)
> >>@@ -261,6 +354,11 @@ static int tce_iommu_clear(struct tce_container *c=
ontainer,
> >>  		if (direction =3D=3D DMA_NONE)
> >>  			continue;
> >>
> >>+		if (container->v2) {
> >>+			tce_iommu_unuse_page_v2(tbl, entry);
> >>+			continue;
> >>+		}
> >>+
> >>  		tce_iommu_unuse_page(container, oldtce);
> >>  	}
> >>
> >>@@ -327,6 +425,62 @@ static long tce_iommu_build(struct tce_container *=
container,
> >>  	return ret;
> >>  }
> >>
> >>+static long tce_iommu_build_v2(struct tce_container *container,
> >>+		struct iommu_table *tbl,
> >>+		unsigned long entry, unsigned long tce, unsigned long pages,
> >>+		enum dma_data_direction direction)
> >>+{
> >>+	long i, ret =3D 0;
> >>+	struct page *page;
> >>+	unsigned long hpa;
> >>+	enum dma_data_direction dirtmp;
> >>+
> >>+	for (i =3D 0; i < pages; ++i) {
> >>+		struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>+		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
> >>+				entry + i);
> >>+
> >>+		ret =3D tce_iommu_use_page_v2(tce, IOMMU_PAGE_SIZE(tbl),
> >>+				&hpa, &mem);
> >>+		if (ret)
> >>+			break;
> >>+
> >>+		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> >>+		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> >>+			ret =3D -EPERM;
> >>+			break;
> >>+		}
> >>+
> >>+		/* Preserve offset within IOMMU page */
> >>+		hpa |=3D tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
> >>+		dirtmp =3D direction;
> >>+
> >>+		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
> >>+		if (ret) {
> >>+			/* dirtmp cannot be DMA_NONE here */
> >>+			tce_iommu_unuse_page_v2(tbl, entry + i);
> >>+			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
> >>+					__func__, entry << tbl->it_page_shift,
> >>+					tce, ret);
> >>+			break;
> >>+		}
> >>+
> >>+		mm_iommu_mapped_update(mem, true);
> >>+
> >>+		if (dirtmp !=3D DMA_NONE)
> >>+			tce_iommu_unuse_page_v2(tbl, entry + i);
> >>+
> >>+		*pua =3D tce;
> >>+
> >>+		tce +=3D IOMMU_PAGE_SIZE(tbl);
> >>+	}
> >>+
> >>+	if (ret)
> >>+		tce_iommu_clear(container, tbl, entry, i);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>  static long tce_iommu_ioctl(void *iommu_data,
> >>  				 unsigned int cmd, unsigned long arg)
> >>  {
> >>@@ -338,6 +492,7 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  	case VFIO_CHECK_EXTENSION:
> >>  		switch (arg) {
> >>  		case VFIO_SPAPR_TCE_IOMMU:
> >>+		case VFIO_SPAPR_TCE_v2_IOMMU:
> >>  			ret =3D 1;
> >>  			break;
> >>  		default:
> >>@@ -425,11 +580,18 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  		if (ret)
> >>  			return ret;
> >>
> >>-		ret =3D tce_iommu_build(container, tbl,
> >>-				param.iova >> tbl->it_page_shift,
> >>-				param.vaddr,
> >>-				param.size >> tbl->it_page_shift,
> >>-				direction);
> >>+		if (container->v2)
> >>+			ret =3D tce_iommu_build_v2(container, tbl,
> >>+					param.iova >> tbl->it_page_shift,
> >>+					param.vaddr,
> >>+					param.size >> tbl->it_page_shift,
> >>+					direction);
> >>+		else
> >>+			ret =3D tce_iommu_build(container, tbl,
> >>+					param.iova >> tbl->it_page_shift,
> >>+					param.vaddr,
> >>+					param.size >> tbl->it_page_shift,
> >>+					direction);
> >>
> >>  		iommu_flush_tce(tbl);
> >>
> >>@@ -474,7 +636,60 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>
> >>  		return ret;
> >>  	}
> >>+	case VFIO_IOMMU_SPAPR_REGISTER_MEMORY: {
> >>+		struct vfio_iommu_spapr_register_memory param;
> >>+
> >>+		if (!container->v2)
> >>+			break;
> >>+
> >>+		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
> >>+				size);
> >>+
> >>+		if (copy_from_user(&param, (void __user *)arg, minsz))
> >>+			return -EFAULT;
> >>+
> >>+		if (param.argsz < minsz)
> >>+			return -EINVAL;
> >>+
> >>+		/* No flag is supported now */
> >>+		if (param.flags)
> >>+			return -EINVAL;
> >>+
> >>+		mutex_lock(&container->lock);
> >>+		ret =3D tce_register_pages(container, param.vaddr, param.size);
> >>+		mutex_unlock(&container->lock);
> >
> >AFAICT, this is the only call to tce_register_pages(), so why not put
> >the mutex into the function.
>=20
> 1) I can use "return" in tce_register_pages() instead of "goto unlock_exi=
t".
> Convinient.
>=20
> 2) I keep mutex_lock()/mutex_unlock() in immediate vfio_iommu_driver_ops
> callbacks (i.e. tce_iommu_ioctl, tce_iommu_attach_group,
> tce_iommu_detach_group) and do not spread them all over the file which I
> find easier to track, no?

Yeah, fair enough.

> >>+
> >>+		return ret;
> >>+	}
> >>+	case VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY: {
> >>+		struct vfio_iommu_spapr_register_memory param;
> >>+
> >>+		if (!container->v2)
> >>+			break;
> >>+
> >>+		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
> >>+				size);
> >>+
> >>+		if (copy_from_user(&param, (void __user *)arg, minsz))
> >>+			return -EFAULT;
> >>+
> >>+		if (param.argsz < minsz)
> >>+			return -EINVAL;
> >>+
> >>+		/* No flag is supported now */
> >>+		if (param.flags)
> >>+			return -EINVAL;
> >>+
> >>+		mutex_lock(&container->lock);
> >>+		tce_unregister_pages(container, param.vaddr, param.size);
> >>+		mutex_unlock(&container->lock);
> >>+
> >>+		return 0;
> >>+	}
> >>  	case VFIO_IOMMU_ENABLE:
> >>+		if (container->v2)
> >>+			break;
> >>+
> >>  		mutex_lock(&container->lock);
> >>  		ret =3D tce_iommu_enable(container);
> >>  		mutex_unlock(&container->lock);
> >>@@ -482,6 +697,9 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>
> >>
> >>  	case VFIO_IOMMU_DISABLE:
> >>+		if (container->v2)
> >>+			break;
> >>+
> >>  		mutex_lock(&container->lock);
> >>  		tce_iommu_disable(container);
> >>  		mutex_unlock(&container->lock);
> >>diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>index b57b750..8fdcfb9 100644
> >>--- a/include/uapi/linux/vfio.h
> >>+++ b/include/uapi/linux/vfio.h
> >>@@ -36,6 +36,8 @@
> >>  /* Two-stage IOMMU */
> >>  #define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
> >>
> >>+#define VFIO_SPAPR_TCE_v2_IOMMU		7
> >>+
> >>  /*
> >>   * The IOCTL interface is designed for extensibility by embedding the
> >>   * structure length (argsz) and flags into structures passed between
> >>@@ -495,6 +497,31 @@ struct vfio_eeh_pe_op {
> >>
> >>  #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
> >>
> >>+/**
> >>+ * VFIO_IOMMU_SPAPR_REGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 17, =
struct vfio_iommu_spapr_register_memory)
> >>+ *
> >>+ * Registers user space memory where DMA is allowed. It pins
> >>+ * user pages and does the locked memory accounting so
> >>+ * subsequent VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA calls
> >>+ * get faster.
> >>+ */
> >>+struct vfio_iommu_spapr_register_memory {
> >>+	__u32	argsz;
> >>+	__u32	flags;
> >>+	__u64	vaddr;				/* Process virtual address */
> >>+	__u64	size;				/* Size of mapping (bytes) */
> >>+};
> >>+#define VFIO_IOMMU_SPAPR_REGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 17)
> >>+
> >>+/**
> >>+ * VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 18=
, struct vfio_iommu_spapr_register_memory)
> >>+ *
> >>+ * Unregisters user space memory registered with
> >>+ * VFIO_IOMMU_SPAPR_REGISTER_MEMORY.
> >>+ * Uses vfio_iommu_spapr_register_memory for parameters.
> >>+ */
> >>+#define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + =
18)
> >>+
> >>  /* ***************************************************************** =
*/
> >>
> >>  #endif /* _UAPIVFIO_H */
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQw3tAAoJEGw4ysog2bOSFxEP/3+3MlbAKaQaPkmsPTjvuKq1
hQTl9ZZI6Z2+wLvNSQ5JZsGL5AkHiT8L9h9tQm0kBF8x5wlWyPbQCySr8eJE1XwK
aYsIY5e/CWyrwrY0QbWRI++z8jAPpza0Ed2JA3ExM+V5oLlkz6HL7xYw84U9MSvX
E8oplnRDQxi+aB4wuOXx3DjU9jdiNjI59QywMlAbqQl8Zr79UIqcfq89i/tQIINi
xX5Rhj8uan/yrfDytNoXhzHurUnFqcLrfx/Pw4CEjMnK2mJv4JrtJx671O3f1snu
x998PovAF5JZGOapm7G1aKCiLCpKfY0eTmRrBjqV9LwAQN08B2qLlWkWTrBnVVpB
hmqDflG7utxT/8pn7tjr1Of7W5KSkEGwbXD7wWBOFBeiAWsAH9qjXtausaoHm1V6
3dAru0ROqJM080Bs4XStB0+PNC7+fcDhPH2g87tuw3O5XFpwXCkMioWJ08WkNI3n
+YMPVWVy3AKv8IDPeVmf35l800ItaCq8ORfE2J4VqLirwN346H6ocobJJhRKt/yK
TjWx7F9CslRjlFjh1ueA6umcavZcibaAq7xMcwbRrDDbjkBcRyCRxJodN8cOfRqi
NsoTbgDWjNBByRlmQNrEmLkmCZ2h6WjRZ4BPEpB2EWbA6aWMDx9fqBx7FlOeYaVz
560xWAhzIjGsd0MlBVO+
=ZvzC
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
