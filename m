Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVDrR3r7DzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 14:02:31 +1100 (AEDT)
Date: Wed, 23 Mar 2016 14:03:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
Message-ID: <20160323030341.GT23586@voom.redhat.com>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
 <20160309054544.GM22546@voom.fritz.box>
 <56DFEACC.7030508@ozlabs.ru>
 <20160310052108.GV22546@voom.fritz.box>
 <56E1FEBE.5090602@ozlabs.ru>
 <20160315060400.GK15272@voom.fritz.box>
 <15389a41428.27cb.1ca38dd7e845b990cd13d431eb58563d@ozlabs.ru>
 <20160321051932.GJ23586@voom.redhat.com>
 <56F0932F.2050708@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dpEE41+QZ7HQEdc/"
In-Reply-To: <56F0932F.2050708@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dpEE41+QZ7HQEdc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 22, 2016 at 11:34:55AM +1100, Alexey Kardashevskiy wrote:
> Uff, lost cc: list. Added back. Some comments below.
>=20
>=20
> On 03/21/2016 04:19 PM, David Gibson wrote:
> >On Fri, Mar 18, 2016 at 11:12:26PM +1100, Alexey Kardashevskiy wrote:
> >>On March 15, 2016 17:29:26 David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >>
> >>>On Fri, Mar 11, 2016 at 10:09:50AM +1100, Alexey Kardashevskiy wrote:
> >>>>On 03/10/2016 04:21 PM, David Gibson wrote:
> >>>>>On Wed, Mar 09, 2016 at 08:20:12PM +1100, Alexey Kardashevskiy wrote:
> >>>>>>On 03/09/2016 04:45 PM, David Gibson wrote:
> >>>>>>>On Mon, Mar 07, 2016 at 02:41:17PM +1100, Alexey Kardashevskiy wro=
te:
> >>>>>>>>sPAPR TCE IOMMU is para-virtualized and the guest does map/unmap
> >>>>>>>>via hypercalls which take a logical bus id (LIOBN) as a target IO=
MMU
> >>>>>>>>identifier. LIOBNs are made up, advertised to guest systems and
> >>>>>>>>linked to IOMMU groups by the user space.
> >>>>>>>>In order to enable acceleration for IOMMU operations in KVM, we n=
eed
> >>>>>>>>to tell KVM the information about the LIOBN-to-group mapping.
> >>>>>>>>
> >>>>>>>>For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN parameter
> >>>>>>>>is added which accepts:
> >>>>>>>>- a VFIO group fd and IO base address to find the actual hardware
> >>>>>>>>TCE table;
> >>>>>>>>- a LIOBN to assign to the found table.
> >>>>>>>>
> >>>>>>>>Before notifying KVM about new link, this check the group for bei=
ng
> >>>>>>>>registered with KVM device in order to release them at unexpected=
 KVM
> >>>>>>>>finish.
> >>>>>>>>
> >>>>>>>>This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the =
user
> >>>>>>>>space.
> >>>>>>>>
> >>>>>>>>While we are here, this also fixes VFIO KVM device compiling to l=
et it
> >>>>>>>>link to a KVM module.
> >>>>>>>>
> >>>>>>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>>>---
> >>>>>>>>  Documentation/virtual/kvm/devices/vfio.txt |  21 +++++-
> >>>>>>>>  arch/powerpc/kvm/Kconfig                   |   1 +
> >>>>>>>>  arch/powerpc/kvm/Makefile                  |   5 +-
> >>>>>>>>  arch/powerpc/kvm/powerpc.c                 |   1 +
> >>>>>>>>  include/uapi/linux/kvm.h                   |   9 +++
> >>>>>>>>  virt/kvm/vfio.c                            | 106
> >>>>+++++++++++++++++++++++++++++
> >>>>>>>>  6 files changed, 140 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>>diff --git a/Documentation/virtual/kvm/devices/vfio.txt
> >>>>b/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>index ef51740..c0d3eb7 100644
> >>>>>>>>--- a/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>+++ b/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>@@ -16,7 +16,24 @@ Groups:
> >>>>>>>>
> >>>>>>>>  KVM_DEV_VFIO_GROUP attributes:
> >>>>>>>>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device t=
racking
> >>>>>>>>+	kvm_device_attr.addr points to an int32_t file descriptor
> >>>>>>>>+	for the VFIO group.
> >>>>>>>
> >>>>>>>AFAICT these changes are accurate for VFIO as it is already, in wh=
ich
> >>>>>>>case it might be clearer to put them in a separate patch.
> >>>>>>>
> >>>>>>>>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM dev=
ice
> >>>>tracking
> >>>>>>>>+	kvm_device_attr.addr points to an int32_t file descriptor
> >>>>>>>>+	for the VFIO group.
> >>>>>>>>
> >>>>>>>>-For each, kvm_device_attr.addr points to an int32_t file descrip=
tor
> >>>>>>>>-for the VFIO group.
> >>>>>>>>+  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: sets a liobn for a VFI=
O group
> >>>>>>>>+	kvm_device_attr.addr points to a struct:
> >>>>>>>>+		struct kvm_vfio_spapr_tce_liobn {
> >>>>>>>>+			__u32	argsz;
> >>>>>>>>+			__s32	fd;
> >>>>>>>>+			__u32	liobn;
> >>>>>>>>+			__u8	pad[4];
> >>>>>>>>+			__u64	start_addr;
> >>>>>>>>+		};
> >>>>>>>>+		where
> >>>>>>>>+		@argsz is the size of kvm_vfio_spapr_tce_liobn;
> >>>>>>>>+		@fd is a file descriptor for a VFIO group;
> >>>>>>>>+		@liobn is a logical bus id to be associated with the group;
> >>>>>>>>+		@start_addr is a DMA window offset on the IO (PCI) bus
> >>>>>>>
> >>>>>>>For the cause of DDW and multiple windows, I'm assuming you can ca=
ll
> >>>>>>>this multiple times with different LIOBNs and the same IOMMU group?
> >>>>>>
> >>>>>>
> >>>>>>Yes. It is called twice per each group (when DDW is activated) - fo=
r 32bit
> >>>>>>and 64bit windows, this is why @start_addr is there.
> >>>>>>
> >>>>>>
> >>>>>>>>diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> >>>>>>>>index 1059846..dfa3488 100644
> >>>>>>>>--- a/arch/powerpc/kvm/Kconfig
> >>>>>>>>+++ b/arch/powerpc/kvm/Kconfig
> >>>>>>>>@@ -65,6 +65,7 @@ config KVM_BOOK3S_64
> >>>>>>>>  	select KVM
> >>>>>>>>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
> >>>>>>>>  	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
> >>>>>>>>+	select KVM_VFIO if VFIO
> >>>>>>>>  	---help---
> >>>>>>>>  	  Support running unmodified book3s_64 and book3s_32 guest ker=
nels
> >>>>>>>>  	  in virtual machines on book3s_64 host processors.
> >>>>>>>>diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> >>>>>>>>index 7f7b6d8..71f577c 100644
> >>>>>>>>--- a/arch/powerpc/kvm/Makefile
> >>>>>>>>+++ b/arch/powerpc/kvm/Makefile
> >>>>>>>>@@ -8,7 +8,7 @@ ccflags-y :=3D -Ivirt/kvm -Iarch/powerpc/kvm
> >>>>>>>>  KVM :=3D ../../../virt/kvm
> >>>>>>>>
> >>>>>>>>  common-objs-y =3D $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> >>>>>>>>-		$(KVM)/eventfd.o $(KVM)/vfio.o
> >>>>>>>>+		$(KVM)/eventfd.o
> >>>>>>>
> >>>>>>>Please don't disable the VFIO device for the non-book3s case.  I a=
dded
> >>>>>>>it (even though it didn't do anything until now) so that libvirt
> >>>>>>>wouldn't choke when it finds it's not available.  Obviously the new
> >>>>>>>ioctl needs to be only for the right IOMMU setup, but the device
> >>>>>>>itself should be available always.
> >>>>>>
> >>>>>>Ah. Ok, I'll fix this. I just wanted to be able to compile kvm as a=
 module.
> >>>>>>
> >>>>>>
> >>>>>>>>  CFLAGS_e500_mmu.o :=3D -I.
> >>>>>>>>  CFLAGS_e500_mmu_host.o :=3D -I.
> >>>>>>>>@@ -87,6 +87,9 @@ endif
> >>>>>>>>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
> >>>>>>>>  	book3s_xics.o
> >>>>>>>>
> >>>>>>>>+kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) +=3D \
> >>>>>>>>+	$(KVM)/vfio.o \
> >>>>>>>>+
> >>>>>>>>  kvm-book3s_64-module-objs +=3D \
> >>>>>>>>  	$(KVM)/kvm_main.o \
> >>>>>>>>  	$(KVM)/eventfd.o \
> >>>>>>>>diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerp=
c.c
> >>>>>>>>index 19aa59b..63f188d 100644
> >>>>>>>>--- a/arch/powerpc/kvm/powerpc.c
> >>>>>>>>+++ b/arch/powerpc/kvm/powerpc.c
> >>>>>>>>@@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm
> >>>>*kvm, long ext)
> >>>>>>>>  #ifdef CONFIG_PPC_BOOK3S_64
> >>>>>>>>  	case KVM_CAP_SPAPR_TCE:
> >>>>>>>>  	case KVM_CAP_SPAPR_TCE_64:
> >>>>>>>>+	case KVM_CAP_SPAPR_TCE_VFIO:
> >>>>>>>>  	case KVM_CAP_PPC_ALLOC_HTAB:
> >>>>>>>>  	case KVM_CAP_PPC_RTAS:
> >>>>>>>>  	case KVM_CAP_PPC_FIXUP_HCALL:
> >>>>>>>>diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>>>>>>>index 080ffbf..f1abbea 100644
> >>>>>>>>--- a/include/uapi/linux/kvm.h
> >>>>>>>>+++ b/include/uapi/linux/kvm.h
> >>>>>>>>@@ -1056,6 +1056,7 @@ struct kvm_device_attr {
> >>>>>>>>  #define  KVM_DEV_VFIO_GROUP			1
> >>>>>>>>  #define   KVM_DEV_VFIO_GROUP_ADD			1
> >>>>>>>>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> >>>>>>>>+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
> >>>>>>>>
> >>>>>>>>  enum kvm_device_type {
> >>>>>>>>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> >>>>>>>>@@ -1075,6 +1076,14 @@ enum kvm_device_type {
> >>>>>>>>  	KVM_DEV_TYPE_MAX,
> >>>>>>>>  };
> >>>>>>>>
> >>>>>>>>+struct kvm_vfio_spapr_tce_liobn {
> >>>>>>>>+	__u32	argsz;
> >>>>>>>>+	__s32	fd;
> >>>>>>>>+	__u32	liobn;
> >>>>>>>>+	__u8	pad[4];
> >>>>>>>>+	__u64	start_addr;
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>  /*
> >>>>>>>>   * ioctls for VM fds
> >>>>>>>>   */
> >>>>>>>>diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> >>>>>>>>index 1dd087d..87c771e 100644
> >>>>>>>>--- a/virt/kvm/vfio.c
> >>>>>>>>+++ b/virt/kvm/vfio.c
> >>>>>>>>@@ -20,6 +20,10 @@
> >>>>>>>>  #include <linux/vfio.h>
> >>>>>>>>  #include "vfio.h"
> >>>>>>>>
> >>>>>>>>+#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>+#include <asm/kvm_ppc.h>
> >>>>>>>>+#endif
> >>>>>>>>+
> >>>>>>>>  struct kvm_vfio_group {
> >>>>>>>>  	struct list_head node;
> >>>>>>>>  	struct vfio_group *vfio_group;
> >>>>>>>>@@ -60,6 +64,22 @@ static void
> >>>>kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
> >>>>>>>>  	symbol_put(vfio_group_put_external_user);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>>+static int kvm_vfio_external_user_iommu_id(struct vfio_group *vf=
io_group)
> >>>>>>>>+{
> >>>>>>>>+	int (*fn)(struct vfio_group *);
> >>>>>>>>+	int ret =3D -1;
> >>>>>>>
> >>>>>>>Should this be -ESOMETHING?
> >>>>>>>
> >>>>>>>>+	fn =3D symbol_get(vfio_external_user_iommu_id);
> >>>>>>>>+	if (!fn)
> >>>>>>>>+		return ret;
> >>>>>>>>+
> >>>>>>>>+	ret =3D fn(vfio_group);
> >>>>>>>>+
> >>>>>>>>+	symbol_put(vfio_external_user_iommu_id);
> >>>>>>>>+
> >>>>>>>>+	return ret;
> >>>>>>>>+}
> >>>>>>>>+
> >>>>>>>>  static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_=
group)
> >>>>>>>>  {
> >>>>>>>>  	long (*fn)(struct vfio_group *, unsigned long);
> >>>>>>>>@@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct
> >>>>kvm_device *dev)
> >>>>>>>>  	mutex_unlock(&kv->lock);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>>+#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>+static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
> >>>>>>>>+		struct vfio_group *vfio_group)
> >>>>>>>
> >>>>>>>
> >>>>>>>Shouldn't this go in the same patch that introduced the attach
> >>>>>>>function?
> >>>>>>
> >>>>>>Having less patches which touch different maintainers areas is bett=
er. I
> >>>>>>cannot avoid touching both PPC KVM and VFIO in this patch but I can=
 in
> >>>>>>"[PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest view=
 of TCE
> >>>>>>table".
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>+{
> >>>>>>>>+	int group_id;
> >>>>>>>>+	struct iommu_group *grp;
> >>>>>>>>+
> >>>>>>>>+	group_id =3D kvm_vfio_external_user_iommu_id(vfio_group);
> >>>>>>>>+	grp =3D iommu_group_get_by_id(group_id);
> >>>>>>>>+	if (grp) {
> >>>>>>>>+		kvm_spapr_tce_detach_iommu_group(kvm, grp);
> >>>>>>>>+		iommu_group_put(grp);
> >>>>>>>>+	}
> >>>>>>>>+}
> >>>>>>>>+#endif
> >>>>>>>>+
> >>>>>>>>  static int kvm_vfio_set_group(struct kvm_device *dev, long attr=
, u64 arg)
> >>>>>>>>  {
> >>>>>>>>  	struct kvm_vfio *kv =3D dev->private;
> >>>>>>>>@@ -186,6 +222,10 @@ static int kvm_vfio_set_group(struct kvm_dev=
ice
> >>>>*dev, long attr, u64 arg)
> >>>>>>>>  				continue;
> >>>>>>>>
> >>>>>>>>  			list_del(&kvg->node);
> >>>>>>>>+#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>
> >>>>>>>Better to make a no-op version of the call than have to #ifdef at =
the
> >>>>>>>callsite.
> >>>>>>
> >>>>>>It is questionable. A x86 reader may decide that
> >>>>>>KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN is implemented for x86 and g=
et
> >>>>>>confused.
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>+			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
> >>>>>>>>+					kvg->vfio_group);
> >>>>>>>>+#endif
> >>>>>>>>  			kvm_vfio_group_put_external_user(kvg->vfio_group);
> >>>>>>>>  			kfree(kvg);
> >>>>>>>>  			ret =3D 0;
> >>>>>>>>@@ -201,6 +241,69 @@ static int kvm_vfio_set_group(struct kvm_dev=
ice
> >>>>*dev, long attr, u64 arg)
> >>>>>>>>  		kvm_vfio_update_coherency(dev);
> >>>>>>>>
> >>>>>>>>  		return ret;
> >>>>>>>>+
> >>>>>>>>+#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>+	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: {
> >>>>>>>>+		struct kvm_vfio_spapr_tce_liobn param;
> >>>>>>>>+		unsigned long minsz;
> >>>>>>>>+		struct kvm_vfio *kv =3D dev->private;
> >>>>>>>>+		struct vfio_group *vfio_group;
> >>>>>>>>+		struct kvm_vfio_group *kvg;
> >>>>>>>>+		struct fd f;
> >>>>>>>>+
> >>>>>>>>+		minsz =3D offsetofend(struct kvm_vfio_spapr_tce_liobn,
> >>>>>>>>+				start_addr);
> >>>>>>>>+
> >>>>>>>>+		if (copy_from_user(&param, (void __user *)arg, minsz))
> >>>>>>>>+			return -EFAULT;
> >>>>>>>>+
> >>>>>>>>+		if (param.argsz < minsz)
> >>>>>>>>+			return -EINVAL;
> >>>>>>>>+
> >>>>>>>>+		f =3D fdget(param.fd);
> >>>>>>>>+		if (!f.file)
> >>>>>>>>+			return -EBADF;
> >>>>>>>>+
> >>>>>>>>+		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
> >>>>>>>>+		fdput(f);
> >>>>>>>>+
> >>>>>>>>+		if (IS_ERR(vfio_group))
> >>>>>>>>+			return PTR_ERR(vfio_group);
> >>>>>>>>+
> >>>>>>>>+		ret =3D -ENOENT;
> >>>>>>>
> >>>>>>>Shouldn't there be some runtime test for the type of the IOMMU?  I=
t's
> >>>>>>>possible a kernel could be built for a platform supporting multiple
> >>>>>>>IOMMU types.
> >>>>>>
> >>>>>>Well, may make sense but I do not know to test that. The IOMMU type=
 is a
> >>>>>>VFIO container property, not a group property and here (KVM) we onl=
y have
> >>>>>>groups.
> >>>>>
> >>>>>Which, as mentioned previously, is broken.
> >>>>
> >>>>Which I am failing to follow you on this.
> >>>>
> >>>>What I am trying to achieve here is pretty much referencing a group s=
o it
> >>>>cannot be reused. Plus LIOBNs.
> >>>
> >>>"Plus LIOBNs" is not a trivial change.  You are establishing a linkage
> >>>from LIOBNs to groups.  But that doesn't make sense; if mapping in one
> >>>(guest) LIOBN affects a group it must affect all groups in the
> >>>container.  i.e. LIOBN->container is the natural mapping, *not* LIOBN
> >>>to group.
> >>
> >>I can see your point but i don't see how to proceed now, I'm totally st=
uck.
> >>Pass container fd and then implement new api to lock containers somehow=
 and
> >
> >I'm not really understanding what the question is about locking containe=
rs.
> >
> >>enumerate groups when updating TCE table (including real mode)?
> >
> >Why do you need to enumerate groups?  The groups within the container
> >share a TCE table, so can't you just update that once?
>=20
> Well, they share a TCE table but they do not share TCE Kill (TCE cache
> invalidate) register address, it is still per PE but this does not matter
> here (pnv_pci_link_table_and_group() does that), just mentioned to comple=
te
> the picture.

True, you'll need to enumerate the groups for invalidates.  But you
need that already, right.

> >>Plus new API when we remove a group from a container as the result of g=
uest
> >>PCI hot unplug?
> >
> >I assume you mean a kernel internal API, since it shouldn't need
> >anything else visible to userspace.  Won't this happen naturally?
> >When the group is removed from the container, it will get its own TCE
> >table instead of the previously shared one.
> >
> >>>>Passing a container fd does not make much
> >>>>sense here as the VFIO device would walk through groups, reference th=
em and
> >>>>that is it, there is no locking on VFIO containters and so far there =
was no
> >>>>need to teach KVM about containers.
> >>>>
> >>>>What do I miss now?
> >>>
> >>>Referencing the groups is essentially just a useful side effect.  The
> >>>important functionality is informing VFIO of the guest LIOBNs; and
> >>>LIOBNs map to containers, not groups.
> >>
> >>No. One liobn maps to one KVM-allocated TCE table, not a container. The=
re
> >>can be one or many or none containers per liobn.
> >
> >Ah, true.
>=20
> So I need to add new kernel API for KVM to get table(s) from VFIO
> container(s). And invent some locking mechanism to prevent table(s) (or
> associated container(s)) from going away, like
> vfio_group_get_external_user/vfio_group_put_external_user but for
> containers. Correct?

Well, the container is attached to an fd, so if you get a reference on
the file* that should do it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dpEE41+QZ7HQEdc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8geNAAoJEGw4ysog2bOSgT0QAJjR2BG01TPWChWUw/YgpSg2
ImiCXNGhLyrrrMfi/EChxpXudu4iHc4ttoVWLWqZ+DBTOtsXjdq4LXLKF+OrM8mb
YQfPkAeLERtrHlLPGVbGqrGcLGMUVyWe/PNdHSJt50Z6dcdQ/nYFtrN467Nq1olS
n5BCWaEsNxqgDN0IhI1Wpy234oPxAmC98JutiylAOKn8cM7CD2Ll9yWIiiyRlDKi
J7MTfZPeDgWgCU+bM/gx4KKOrLfSZVZg8/2NHSNsID3glnUgpMBamWtwGrMCxpwj
LQABlO8ToOvMDQG7vNmRo8q7r1ZZE5Eg/hrkR8PO3GE09uofKEE8Rxc6avxcL8W4
xt/WjSYPzorjLALoBW80fWEj/5wG9eYyiF3IlI3NddM7pvP/jbObsZQDnyGmtKxE
GSkFSCsMo/5w1ac9jkIcpGqGbuEQIBwAKoleOimzkgp5ak2rvOrCMkV/F3+nceqC
hM9RmjjsCUSzAQ2HqtQ/nGUPzqV5xb8N8GWOV/qchYS52gnhxl8n1n7mp3RUgo3e
kcWgeT3MSZO4JEA1QTzx/FJWhkBpNdIsGFjZUZFoXsXrUZFAft2B9e9Ex+7UlQNx
jgsLd3pjKOv/ndLI5o5xAPutNAHrGvCZ2d4yCJTRVzjgHK1fo8kx2R010uE1wW7O
SfpVKJWXKLWnjZGAlpjr
=AXxv
-----END PGP SIGNATURE-----

--dpEE41+QZ7HQEdc/--
