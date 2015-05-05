Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AE9B1A066D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 23:09:08 +1000 (AEST)
Date: Tue, 5 May 2015 21:53:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 29/32] vfio: powerpc/spapr: Register memory and
 define IOMMU v2
Message-ID: <20150505115305.GK14090@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-30-git-send-email-aik@ozlabs.ru>
 <20150430065524.GB24886@voom.redhat.com> <5543028B.300@ozlabs.ru>
 <20150501052357.GQ24886@voom.redhat.com>
 <55431CE3.6050607@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C8M3rclghDj+srEw"
In-Reply-To: <55431CE3.6050607@ozlabs.ru>
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


--C8M3rclghDj+srEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 04:27:47PM +1000, Alexey Kardashevskiy wrote:
> On 05/01/2015 03:23 PM, David Gibson wrote:
> >On Fri, May 01, 2015 at 02:35:23PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/30/2015 04:55 PM, David Gibson wrote:
> >>>On Sat, Apr 25, 2015 at 10:14:53PM +1000, Alexey Kardashevskiy wrote:
> >>>>The existing implementation accounts the whole DMA window in
> >>>>the locked_vm counter. This is going to be worse with multiple
> >>>>containers and huge DMA windows. Also, real-time accounting would req=
uite
> >>>>additional tracking of accounted pages due to the page size differenc=
e -
> >>>>IOMMU uses 4K pages and system uses 4K or 64K pages.
> >>>>
> >>>>Another issue is that actual pages pinning/unpinning happens on every
> >>>>DMA map/unmap request. This does not affect the performance much now =
as
> >>>>we spend way too much time now on switching context between
> >>>>guest/userspace/host but this will start to matter when we add in-ker=
nel
> >>>>DMA map/unmap acceleration.
> >>>>
> >>>>This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
> >>>>New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introdu=
ces
> >>>>2 new ioctls to register/unregister DMA memory -
> >>>>VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMO=
RY -
> >>>>which receive user space address and size of a memory region which
> >>>>needs to be pinned/unpinned and counted in locked_vm.
> >>>>New IOMMU splits physical pages pinning and TCE table update into 2 d=
ifferent
> >>>>operations. It requires 1) guest pages to be registered first 2) cons=
equent
> >>>>map/unmap requests to work only with pre-registered memory.
> >>>>For the default single window case this means that the entire guest
> >>>>(instead of 2GB) needs to be pinned before using VFIO.
> >>>>When a huge DMA window is added, no additional pinning will be
> >>>>required, otherwise it would be guest RAM + 2GB.
> >>>>
> >>>>The new memory registration ioctls are not supported by
> >>>>VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
> >>>>will require memory to be preregistered in order to work.
> >>>>
> >>>>The accounting is done per the user process.
> >>>>
> >>>>This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
> >>>>can do with v1 or v2 IOMMUs.
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>[aw: for the vfio related changes]
> >>>>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>>>---
> >>>>Changes:
> >>>>v9:
> >>>>* s/tce_get_hva_cached/tce_iommu_use_page_v2/
> >>>>
> >>>>v7:
> >>>>* now memory is registered per mm (i.e. process)
> >>>>* moved memory registration code to powerpc/mmu
> >>>>* merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
> >>>>* limited new ioctls to v2 IOMMU
> >>>>* updated doc
> >>>>* unsupported ioclts return -ENOTTY instead of -EPERM
> >>>>
> >>>>v6:
> >>>>* tce_get_hva_cached() returns hva via a pointer
> >>>>
> >>>>v4:
> >>>>* updated docs
> >>>>* s/kzmalloc/vzalloc/
> >>>>* in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
> >>>>replaced offset with index
> >>>>* renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_registe=
r_memory
> >>>>and removed duplicating vfio_iommu_spapr_register_memory
> >>>>---
> >>>>  Documentation/vfio.txt              |  23 ++++
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 230 +++++++++++++++++++++++++=
++++++++++-
> >>>>  include/uapi/linux/vfio.h           |  27 +++++
> >>>>  3 files changed, 274 insertions(+), 6 deletions(-)
> >>>>
> >>>>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >>>>index 96978ec..94328c8 100644
> >>>>--- a/Documentation/vfio.txt
> >>>>+++ b/Documentation/vfio.txt
> >>>>@@ -427,6 +427,29 @@ The code flow from the example above should be s=
lightly changed:
> >>>>
> >>>>  	....
> >>>>
> >>>>+5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
> >>>>+VFIO_IOMMU_DISABLE and implements 2 new ioctls:
> >>>>+VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEM=
ORY
> >>>>+(which are unsupported in v1 IOMMU).
> >>>
> >>>A summary of the semantic differeces between v1 and v2 would be nice.
> >>>At this point it's not really clear to me if there's a case for
> >>>creating v2, or if this could just be done by adding (optional)
> >>>functionality to v1.
> >>
> >>v1: memory preregistration is not supported; explicit enable/disable io=
ctls
> >>are required
> >>
> >>v2: memory preregistration is required; explicit enable/disable are
> >>prohibited (as they are not needed).
> >>
> >>Mixing these in one IOMMU type caused a lot of problems like should I
> >>increment locked_vm by the 32bit window size on enable() or not; what d=
o I
> >>do about pages pinning when map/map (check if it is from registered mem=
ory
> >>and do not pin?).
> >>
> >>Having 2 IOMMU models makes everything a lot simpler.
> >
> >Ok.  Would it simplify it further if you made v2 only usable on IODA2
> >hardware?
>=20
>=20
> Very little. V2 addresses memory pinning issue which is handled the same =
way
> on ioda2 and older hardware, including KVM acceleration. Whether enable D=
DW
> or not - this is handled just fine via extra properties in the GET_INFO
> ioctl().
>=20
> IODA2 and others are different in handling multiple groups per container =
but
> this does not require changes to userspace API.
>=20
> And remember, the only machine I can use 100% of time is POWER7/P5IOC2 so=
 it
> is really useful if at least some bits of the patchset can be tested ther=
e;
> if it was a bit less different from IODA2, I would have even implemented =
DDW
> there too :)

Hm, ok.

> >>>>+PPC64 paravirtualized guests generate a lot of map/unmap requests,
> >>>>+and the handling of those includes pinning/unpinning pages and updat=
ing
> >>>>+mm::locked_vm counter to make sure we do not exceed the rlimit.
> >>>>+The v2 IOMMU splits accounting and pinning into separate operations:
> >>>>+
> >>>>+- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMOR=
Y ioctls
> >>>>+receive a user space address and size of the block to be pinned.
> >>>>+Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expec=
ted to
> >>>>+be called with the exact address and size used for registering
> >>>>+the memory block. The userspace is not expected to call these often.
> >>>>+The ranges are stored in a linked list in a VFIO container.
> >>>>+
> >>>>+- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the act=
ual
> >>>>+IOMMU table and do not do pinning; instead these check that the user=
space
> >>>>+address is from pre-registered range.
> >>>>+
> >>>>+This separation helps in optimizing DMA for guests.
> >>>>+
> >>>>  -------------------------------------------------------------------=
------------
> >>>>
> >>>>  [1] VFIO was originally an acronym for "Virtual Function I/O" in its
> >>>>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_=
iommu_spapr_tce.c
> >>>>index 892a584..4cfc2c1 100644
> >>>>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>
> >>>So, from things you said at other points, I thought the idea was that
> >>>this registration stuff could also be used on non-Power IOMMUs.  Did I
> >>>misunderstand, or is that a possibility for the future?
> >>
> >>
> >>I never said a thing about non-PPC :) I seriously doubt any other arch =
has
> >>this hypervisor interface with H_PUT_TCE (may be s390? :) ); for others
> >>there is no profit from memory preregistration as they (at least x86) d=
o map
> >>the entire guest before it starts which essentially is that preregistra=
tion.
> >>
> >>
> >>btw later we may want to implement simple IOMMU v3 which will do pinnin=
g +
> >>locked_vm when mapping as x86 does, for http://dpdk.org/ - these things=
 do
> >>not really have to bother with preregistration (even if it just a single
> >>additional ioctl).
> >>
> >>
> >>
> >>>>@@ -21,6 +21,7 @@
> >>>>  #include <linux/vfio.h>
> >>>>  #include <asm/iommu.h>
> >>>>  #include <asm/tce.h>
> >>>>+#include <asm/mmu_context.h>
> >>>>
> >>>>  #define DRIVER_VERSION  "0.1"
> >>>>  #define DRIVER_AUTHOR   "aik@ozlabs.ru"
> >>>>@@ -91,8 +92,58 @@ struct tce_container {
> >>>>  	struct iommu_group *grp;
> >>>>  	bool enabled;
> >>>>  	unsigned long locked_pages;
> >>>>+	bool v2;
> >>>>  };
> >>>>
> >>>>+static long tce_unregister_pages(struct tce_container *container,
> >>>>+		__u64 vaddr, __u64 size)
> >>>>+{
> >>>>+	long ret;
> >>>>+	struct mm_iommu_table_group_mem_t *mem;
> >>>>+
> >>>>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> >>>>+		return -EINVAL;
> >>>>+
> >>>>+	mem =3D mm_iommu_get(vaddr, size >> PAGE_SHIFT);
> >>>>+	if (!mem)
> >>>>+		return -EINVAL;
> >>>>+
> >>>>+	ret =3D mm_iommu_put(mem); /* undo kref_get() from mm_iommu_get() */
> >>>>+	if (!ret)
> >>>>+		ret =3D mm_iommu_put(mem);
> >>>>+
> >>>>+	return ret;
> >>>>+}
> >>>>+
> >>>>+static long tce_register_pages(struct tce_container *container,
> >>>>+		__u64 vaddr, __u64 size)
> >>>>+{
> >>>>+	long ret =3D 0;
> >>>>+	struct mm_iommu_table_group_mem_t *mem;
> >>>>+	unsigned long entries =3D size >> PAGE_SHIFT;
> >>>>+
> >>>>+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> >>>>+			((vaddr + size) < vaddr))
> >>>>+		return -EINVAL;
> >>>>+
> >>>>+	mem =3D mm_iommu_get(vaddr, entries);
> >>>>+	if (!mem) {
> >>>>+		ret =3D try_increment_locked_vm(entries);
> >>>>+		if (ret)
> >>>>+			return ret;
> >>>>+
> >>>>+		ret =3D mm_iommu_alloc(vaddr, entries, &mem);
> >>>>+		if (ret) {
> >>>>+			decrement_locked_vm(entries);
> >>>>+			return ret;
> >>>>+		}
> >>>>+	}
> >>>>+
> >>>>+	container->enabled =3D true;
> >>>>+
> >>>>+	return 0;
> >>>>+}
> >>>
> >>>So requiring that registered regions get unregistered with exactly the
> >>>same addr/length is reasonable.  I'm a bit less convinced that
> >>>disallowing overlaps is a good idea.  What if two libraries in the
> >>>same process are trying to use VFIO - they may not know if the regions
> >>>they try to register are overlapping.
> >>
> >>
> >>Sorry, I do not understand. A library allocates RAM. A library is expec=
ted
> >>to do register it via additional ioctl, that's it. Another library allo=
cates
> >>another chunk of memory and it won't overlap and the registered areas w=
on't
> >>either.
> >
> >So the case I'm thinking is where the library does VFIO using a buffer
> >passed into it from the program at large.  Another library does the
> >same.
> >
> >The main program, unaware of the VFIO shenanigans passes different
> >parts of the same page to the 2 libraries.
> >
> >This is somewhat similar to the case of the horribly, horribly broken
> >semantics of POSIX file range locks (it's both hard to implement and
> >dangerous in the multi-library case similar to above).
>=20
>=20
> Ok. I'll implement x86-alike V3 SPAPR TCE IOMMU for these people, later :)
>=20
> V2 addresses issues caused by H_PUT_TCE + DDW RTAS interfaces.
>=20
>=20
>=20
> >>>>  static bool tce_page_is_contained(struct page *page, unsigned page_=
shift)
> >>>>  {
> >>>>  	/*
> >>>>@@ -205,7 +256,7 @@ static void *tce_iommu_open(unsigned long arg)
> >>>>  {
> >>>>  	struct tce_container *container;
> >>>>
> >>>>-	if (arg !=3D VFIO_SPAPR_TCE_IOMMU) {
> >>>>+	if ((arg !=3D VFIO_SPAPR_TCE_IOMMU) && (arg !=3D VFIO_SPAPR_TCE_v2_=
IOMMU)) {
> >>>>  		pr_err("tce_vfio: Wrong IOMMU type\n");
> >>>>  		return ERR_PTR(-EINVAL);
> >>>>  	}
> >>>>@@ -215,6 +266,7 @@ static void *tce_iommu_open(unsigned long arg)
> >>>>  		return ERR_PTR(-ENOMEM);
> >>>>
> >>>>  	mutex_init(&container->lock);
> >>>>+	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> >>>>
> >>>>  	return container;
> >>>>  }
> >>>>@@ -243,6 +295,47 @@ static void tce_iommu_unuse_page(struct tce_cont=
ainer *container,
> >>>>  	put_page(page);
> >>>>  }
> >>>>
> >>>>+static int tce_iommu_use_page_v2(unsigned long tce, unsigned long si=
ze,
> >>>>+		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
> >>
> >>
> >>You suggested s/tce_get_hpa/tce_iommu_use_page/ but in this particular =
patch
> >>it is confusing as tce_iommu_unuse_page_v2() calls it to find correspon=
ding
> >>mm_iommu_table_group_mem_t by the userspace address address of a page b=
eing
> >>stopped used.
> >>
> >>tce_iommu_use_page (without v2) does use the page but this one I'll ren=
ame
> >>back to tce_iommu_ua_to_hpa_v2(), is that ok?
> >
> >Sorry, I couldn't follow this comment.
>=20
>=20
> For V1 IOMMU, I used to have:
> tce_get_hpa() - this converted UA to linear address and did gup();
> tce_iommu_unuse_page() - this did put_page().
>=20
> You suggested (*) to rename the first one to tce_use_page() which makes s=
ense.
>=20
> V2 introduces its own versions of use/unuse but these use preregistered
> memory and do not do gup()/put_page(). I named them:
> tce_get_hpa_cached()
> tce_iommu_unuse_page_v2()
>=20
> then, replaying your comment (*) on V2 IOMMU, I renamed tce_get_hpa_cache=
d()
> to tce_iommu_use_page_v2(). And I do not like the result now (in the chunk
> below). I'll rename it to tce_iommu_ua_to_hpa_v2(), will it be ok?

Uh, I guess so.  To me "use_page" suggests incrementing the reference
or locking it or something along those lines, so I think that name
should follow the "gup".

>=20
>=20
>=20
> >
> >>
> >>
> >>>>+{
> >>>>+	long ret =3D 0;
> >>>>+	struct mm_iommu_table_group_mem_t *mem;
> >>>>+
> >>>>+	mem =3D mm_iommu_lookup(tce, size);
> >>>>+	if (!mem)
> >>>>+		return -EINVAL;
> >>>>+
> >>>>+	ret =3D mm_iommu_ua_to_hpa(mem, tce, phpa);
> >>>>+	if (ret)
> >>>>+		return -EINVAL;
> >>>>+
> >>>>+	*pmem =3D mem;
> >>>>+
> >>>>+	return 0;
> >>>>+}
> >>>>+
> >>>>+static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> >>>>+		unsigned long entry)
> >>>>+{
> >>>>+	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>>>+	int ret;
> >>>>+	unsigned long hpa =3D 0;
> >>>>+	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >>>>+
> >>>>+	if (!pua || !current || !current->mm)
> >>>>+		return;
> >>>>+
> >>>>+	ret =3D tce_iommu_use_page_v2(*pua, IOMMU_PAGE_SIZE(tbl),
> >>>>+			&hpa, &mem);
> >>>>+	if (ret)
> >>>>+		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> >>>>+				__func__, *pua, entry, ret);
> >>>>+	if (mem)
> >>>>+		mm_iommu_mapped_update(mem, false);
> >>>>+
> >>>>+	*pua =3D 0;
> >>>>+}
> >>>>+
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C8M3rclghDj+srEw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVSK8hAAoJEGw4ysog2bOSl6AP/1A0ZypGAByxc/3usYFDf5xs
wFDytL34Sw/fxu/Yk1GpUqd+RStbXrwh3y0UNh7hIY4DVGt1W4TOMan4KT0N/sNq
LGKUN+R3EsJb5GvI9sepPvXlxq7TbndqYXj+AFLXVRw8dF22Wuy8XDeLTiYGjEl2
KEE4rqfVfNSXBKDMmy4ovPgQjY8/9AIMkyUzVLIkBgn+dYzjywbC7m/CqRRSx7SM
XxlBT95G+n+OxiM5/aM0jpGf/3rzHwxsdJH/948Uip05w0XofFs12idWHMteaW3F
1bgvmeoRhV7nVfOa39irxTVD9z/cOVyJBGJK3i0Gx1NvoLg11txkK4lp2MQ8nZR/
qvqpnjY4EQmIp/84s4piNPuKC4c401KOWz4rLKic9wqBv7okJVdSIjm9LE/M0USE
ms2G6WvsYpAOYYJWFG41wjx49oliwBz3aqtDAQRLLMyd7lT1eirGWg2AGvMZwa8j
KjtpEut0RuuvGUGKeQc2Bs5YV8nGLBTzszfX1mN7x8OEGn6NZDZbYgqpU0iWSImX
uK4VfHdMFNWx37ljTzYdQw0d6qpSU2oeL/Z/MJodknShp88RB7AHA7yy5sedD7ns
rD3Xf1T6Z9N9ND5ryqUWkZeuPCxL3gFBEMm+T6ZNkcVk8Q6Cg3dafxtBLL45qEqA
OfNex1dJjufydVzDlQfm
=Z2ME
-----END PGP SIGNATURE-----

--C8M3rclghDj+srEw--
