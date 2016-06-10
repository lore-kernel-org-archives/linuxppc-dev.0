Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQt91337RzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:50:29 +1000 (AEST)
Date: Fri, 10 Jun 2016 16:50:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
Message-ID: <20160610065025.GR9226@voom.fritz.box>
References: <20160309054544.GM22546@voom.fritz.box>
 <56DFEACC.7030508@ozlabs.ru>
 <20160310052108.GV22546@voom.fritz.box>
 <56E1FEBE.5090602@ozlabs.ru>
 <20160315060400.GK15272@voom.fritz.box>
 <15389a41428.27cb.1ca38dd7e845b990cd13d431eb58563d@ozlabs.ru>
 <20160321051932.GJ23586@voom.redhat.com>
 <56F0932F.2050708@ozlabs.ru>
 <20160323030341.GT23586@voom.redhat.com>
 <367698b4-40eb-ec26-5154-b22d672322b7@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LZ92CUgs0ha736zO"
In-Reply-To: <367698b4-40eb-ec26-5154-b22d672322b7@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LZ92CUgs0ha736zO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 04:47:59PM +1000, Alexey Kardashevskiy wrote:
> On 23/03/16 14:03, David Gibson wrote:
> > On Tue, Mar 22, 2016 at 11:34:55AM +1100, Alexey Kardashevskiy wrote:
> >> Uff, lost cc: list. Added back. Some comments below.
> >>
> >>
> >> On 03/21/2016 04:19 PM, David Gibson wrote:
> >>> On Fri, Mar 18, 2016 at 11:12:26PM +1100, Alexey Kardashevskiy wrote:
> >>>> On March 15, 2016 17:29:26 David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>>>
> >>>>> On Fri, Mar 11, 2016 at 10:09:50AM +1100, Alexey Kardashevskiy wrot=
e:
> >>>>>> On 03/10/2016 04:21 PM, David Gibson wrote:
> >>>>>>> On Wed, Mar 09, 2016 at 08:20:12PM +1100, Alexey Kardashevskiy wr=
ote:
> >>>>>>>> On 03/09/2016 04:45 PM, David Gibson wrote:
> >>>>>>>>> On Mon, Mar 07, 2016 at 02:41:17PM +1100, Alexey Kardashevskiy =
wrote:
> >>>>>>>>>> sPAPR TCE IOMMU is para-virtualized and the guest does map/unm=
ap
> >>>>>>>>>> via hypercalls which take a logical bus id (LIOBN) as a target=
 IOMMU
> >>>>>>>>>> identifier. LIOBNs are made up, advertised to guest systems and
> >>>>>>>>>> linked to IOMMU groups by the user space.
> >>>>>>>>>> In order to enable acceleration for IOMMU operations in KVM, w=
e need
> >>>>>>>>>> to tell KVM the information about the LIOBN-to-group mapping.
> >>>>>>>>>>
> >>>>>>>>>> For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN paramet=
er
> >>>>>>>>>> is added which accepts:
> >>>>>>>>>> - a VFIO group fd and IO base address to find the actual hardw=
are
> >>>>>>>>>> TCE table;
> >>>>>>>>>> - a LIOBN to assign to the found table.
> >>>>>>>>>>
> >>>>>>>>>> Before notifying KVM about new link, this check the group for =
being
> >>>>>>>>>> registered with KVM device in order to release them at unexpec=
ted KVM
> >>>>>>>>>> finish.
> >>>>>>>>>>
> >>>>>>>>>> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to t=
he user
> >>>>>>>>>> space.
> >>>>>>>>>>
> >>>>>>>>>> While we are here, this also fixes VFIO KVM device compiling t=
o let it
> >>>>>>>>>> link to a KVM module.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>>>>> ---
> >>>>>>>>>>  Documentation/virtual/kvm/devices/vfio.txt |  21 +++++-
> >>>>>>>>>>  arch/powerpc/kvm/Kconfig                   |   1 +
> >>>>>>>>>>  arch/powerpc/kvm/Makefile                  |   5 +-
> >>>>>>>>>>  arch/powerpc/kvm/powerpc.c                 |   1 +
> >>>>>>>>>>  include/uapi/linux/kvm.h                   |   9 +++
> >>>>>>>>>>  virt/kvm/vfio.c                            | 106
> >>>>>> +++++++++++++++++++++++++++++
> >>>>>>>>>>  6 files changed, 140 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>> b/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>>> index ef51740..c0d3eb7 100644
> >>>>>>>>>> --- a/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>>> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> >>>>>>>>>> @@ -16,7 +16,24 @@ Groups:
> >>>>>>>>>>
> >>>>>>>>>>  KVM_DEV_VFIO_GROUP attributes:
> >>>>>>>>>>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device=
 tracking
> >>>>>>>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
> >>>>>>>>>> +	for the VFIO group.
> >>>>>>>>>
> >>>>>>>>> AFAICT these changes are accurate for VFIO as it is already, in=
 which
> >>>>>>>>> case it might be clearer to put them in a separate patch.
> >>>>>>>>>
> >>>>>>>>>>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM d=
evice
> >>>>>> tracking
> >>>>>>>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
> >>>>>>>>>> +	for the VFIO group.
> >>>>>>>>>>
> >>>>>>>>>> -For each, kvm_device_attr.addr points to an int32_t file desc=
riptor
> >>>>>>>>>> -for the VFIO group.
> >>>>>>>>>> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: sets a liobn for a =
VFIO group
> >>>>>>>>>> +	kvm_device_attr.addr points to a struct:
> >>>>>>>>>> +		struct kvm_vfio_spapr_tce_liobn {
> >>>>>>>>>> +			__u32	argsz;
> >>>>>>>>>> +			__s32	fd;
> >>>>>>>>>> +			__u32	liobn;
> >>>>>>>>>> +			__u8	pad[4];
> >>>>>>>>>> +			__u64	start_addr;
> >>>>>>>>>> +		};
> >>>>>>>>>> +		where
> >>>>>>>>>> +		@argsz is the size of kvm_vfio_spapr_tce_liobn;
> >>>>>>>>>> +		@fd is a file descriptor for a VFIO group;
> >>>>>>>>>> +		@liobn is a logical bus id to be associated with the group;
> >>>>>>>>>> +		@start_addr is a DMA window offset on the IO (PCI) bus
> >>>>>>>>>
> >>>>>>>>> For the cause of DDW and multiple windows, I'm assuming you can=
 call
> >>>>>>>>> this multiple times with different LIOBNs and the same IOMMU gr=
oup?
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Yes. It is called twice per each group (when DDW is activated) -=
 for 32bit
> >>>>>>>> and 64bit windows, this is why @start_addr is there.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconf=
ig
> >>>>>>>>>> index 1059846..dfa3488 100644
> >>>>>>>>>> --- a/arch/powerpc/kvm/Kconfig
> >>>>>>>>>> +++ b/arch/powerpc/kvm/Kconfig
> >>>>>>>>>> @@ -65,6 +65,7 @@ config KVM_BOOK3S_64
> >>>>>>>>>>  	select KVM
> >>>>>>>>>>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
> >>>>>>>>>>  	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
> >>>>>>>>>> +	select KVM_VFIO if VFIO
> >>>>>>>>>>  	---help---
> >>>>>>>>>>  	  Support running unmodified book3s_64 and book3s_32 guest k=
ernels
> >>>>>>>>>>  	  in virtual machines on book3s_64 host processors.
> >>>>>>>>>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Make=
file
> >>>>>>>>>> index 7f7b6d8..71f577c 100644
> >>>>>>>>>> --- a/arch/powerpc/kvm/Makefile
> >>>>>>>>>> +++ b/arch/powerpc/kvm/Makefile
> >>>>>>>>>> @@ -8,7 +8,7 @@ ccflags-y :=3D -Ivirt/kvm -Iarch/powerpc/kvm
> >>>>>>>>>>  KVM :=3D ../../../virt/kvm
> >>>>>>>>>>
> >>>>>>>>>>  common-objs-y =3D $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> >>>>>>>>>> -		$(KVM)/eventfd.o $(KVM)/vfio.o
> >>>>>>>>>> +		$(KVM)/eventfd.o
> >>>>>>>>>
> >>>>>>>>> Please don't disable the VFIO device for the non-book3s case.  =
I added
> >>>>>>>>> it (even though it didn't do anything until now) so that libvirt
> >>>>>>>>> wouldn't choke when it finds it's not available.  Obviously the=
 new
> >>>>>>>>> ioctl needs to be only for the right IOMMU setup, but the device
> >>>>>>>>> itself should be available always.
> >>>>>>>>
> >>>>>>>> Ah. Ok, I'll fix this. I just wanted to be able to compile kvm a=
s a module.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>>  CFLAGS_e500_mmu.o :=3D -I.
> >>>>>>>>>>  CFLAGS_e500_mmu_host.o :=3D -I.
> >>>>>>>>>> @@ -87,6 +87,9 @@ endif
> >>>>>>>>>>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
> >>>>>>>>>>  	book3s_xics.o
> >>>>>>>>>>
> >>>>>>>>>> +kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) +=3D \
> >>>>>>>>>> +	$(KVM)/vfio.o \
> >>>>>>>>>> +
> >>>>>>>>>>  kvm-book3s_64-module-objs +=3D \
> >>>>>>>>>>  	$(KVM)/kvm_main.o \
> >>>>>>>>>>  	$(KVM)/eventfd.o \
> >>>>>>>>>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/pow=
erpc.c
> >>>>>>>>>> index 19aa59b..63f188d 100644
> >>>>>>>>>> --- a/arch/powerpc/kvm/powerpc.c
> >>>>>>>>>> +++ b/arch/powerpc/kvm/powerpc.c
> >>>>>>>>>> @@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm
> >>>>>> *kvm, long ext)
> >>>>>>>>>>  #ifdef CONFIG_PPC_BOOK3S_64
> >>>>>>>>>>  	case KVM_CAP_SPAPR_TCE:
> >>>>>>>>>>  	case KVM_CAP_SPAPR_TCE_64:
> >>>>>>>>>> +	case KVM_CAP_SPAPR_TCE_VFIO:
> >>>>>>>>>>  	case KVM_CAP_PPC_ALLOC_HTAB:
> >>>>>>>>>>  	case KVM_CAP_PPC_RTAS:
> >>>>>>>>>>  	case KVM_CAP_PPC_FIXUP_HCALL:
> >>>>>>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm=
=2Eh
> >>>>>>>>>> index 080ffbf..f1abbea 100644
> >>>>>>>>>> --- a/include/uapi/linux/kvm.h
> >>>>>>>>>> +++ b/include/uapi/linux/kvm.h
> >>>>>>>>>> @@ -1056,6 +1056,7 @@ struct kvm_device_attr {
> >>>>>>>>>>  #define  KVM_DEV_VFIO_GROUP			1
> >>>>>>>>>>  #define   KVM_DEV_VFIO_GROUP_ADD			1
> >>>>>>>>>>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> >>>>>>>>>> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
> >>>>>>>>>>
> >>>>>>>>>>  enum kvm_device_type {
> >>>>>>>>>>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> >>>>>>>>>> @@ -1075,6 +1076,14 @@ enum kvm_device_type {
> >>>>>>>>>>  	KVM_DEV_TYPE_MAX,
> >>>>>>>>>>  };
> >>>>>>>>>>
> >>>>>>>>>> +struct kvm_vfio_spapr_tce_liobn {
> >>>>>>>>>> +	__u32	argsz;
> >>>>>>>>>> +	__s32	fd;
> >>>>>>>>>> +	__u32	liobn;
> >>>>>>>>>> +	__u8	pad[4];
> >>>>>>>>>> +	__u64	start_addr;
> >>>>>>>>>> +};
> >>>>>>>>>> +
> >>>>>>>>>>  /*
> >>>>>>>>>>   * ioctls for VM fds
> >>>>>>>>>>   */
> >>>>>>>>>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> >>>>>>>>>> index 1dd087d..87c771e 100644
> >>>>>>>>>> --- a/virt/kvm/vfio.c
> >>>>>>>>>> +++ b/virt/kvm/vfio.c
> >>>>>>>>>> @@ -20,6 +20,10 @@
> >>>>>>>>>>  #include <linux/vfio.h>
> >>>>>>>>>>  #include "vfio.h"
> >>>>>>>>>>
> >>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>>> +#include <asm/kvm_ppc.h>
> >>>>>>>>>> +#endif
> >>>>>>>>>> +
> >>>>>>>>>>  struct kvm_vfio_group {
> >>>>>>>>>>  	struct list_head node;
> >>>>>>>>>>  	struct vfio_group *vfio_group;
> >>>>>>>>>> @@ -60,6 +64,22 @@ static void
> >>>>>> kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
> >>>>>>>>>>  	symbol_put(vfio_group_put_external_user);
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> +static int kvm_vfio_external_user_iommu_id(struct vfio_group =
*vfio_group)
> >>>>>>>>>> +{
> >>>>>>>>>> +	int (*fn)(struct vfio_group *);
> >>>>>>>>>> +	int ret =3D -1;
> >>>>>>>>>
> >>>>>>>>> Should this be -ESOMETHING?
> >>>>>>>>>
> >>>>>>>>>> +	fn =3D symbol_get(vfio_external_user_iommu_id);
> >>>>>>>>>> +	if (!fn)
> >>>>>>>>>> +		return ret;
> >>>>>>>>>> +
> >>>>>>>>>> +	ret =3D fn(vfio_group);
> >>>>>>>>>> +
> >>>>>>>>>> +	symbol_put(vfio_external_user_iommu_id);
> >>>>>>>>>> +
> >>>>>>>>>> +	return ret;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>  static bool kvm_vfio_group_is_coherent(struct vfio_group *vfi=
o_group)
> >>>>>>>>>>  {
> >>>>>>>>>>  	long (*fn)(struct vfio_group *, unsigned long);
> >>>>>>>>>> @@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(str=
uct
> >>>>>> kvm_device *dev)
> >>>>>>>>>>  	mutex_unlock(&kv->lock);
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>>> +static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
> >>>>>>>>>> +		struct vfio_group *vfio_group)
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Shouldn't this go in the same patch that introduced the attach
> >>>>>>>>> function?
> >>>>>>>>
> >>>>>>>> Having less patches which touch different maintainers areas is b=
etter. I
> >>>>>>>> cannot avoid touching both PPC KVM and VFIO in this patch but I =
can in
> >>>>>>>> "[PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest v=
iew of TCE
> >>>>>>>> table".
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +{
> >>>>>>>>>> +	int group_id;
> >>>>>>>>>> +	struct iommu_group *grp;
> >>>>>>>>>> +
> >>>>>>>>>> +	group_id =3D kvm_vfio_external_user_iommu_id(vfio_group);
> >>>>>>>>>> +	grp =3D iommu_group_get_by_id(group_id);
> >>>>>>>>>> +	if (grp) {
> >>>>>>>>>> +		kvm_spapr_tce_detach_iommu_group(kvm, grp);
> >>>>>>>>>> +		iommu_group_put(grp);
> >>>>>>>>>> +	}
> >>>>>>>>>> +}
> >>>>>>>>>> +#endif
> >>>>>>>>>> +
> >>>>>>>>>>  static int kvm_vfio_set_group(struct kvm_device *dev, long at=
tr, u64 arg)
> >>>>>>>>>>  {
> >>>>>>>>>>  	struct kvm_vfio *kv =3D dev->private;
> >>>>>>>>>> @@ -186,6 +222,10 @@ static int kvm_vfio_set_group(struct kvm_=
device
> >>>>>> *dev, long attr, u64 arg)
> >>>>>>>>>>  				continue;
> >>>>>>>>>>
> >>>>>>>>>>  			list_del(&kvg->node);
> >>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>>
> >>>>>>>>> Better to make a no-op version of the call than have to #ifdef =
at the
> >>>>>>>>> callsite.
> >>>>>>>>
> >>>>>>>> It is questionable. A x86 reader may decide that
> >>>>>>>> KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN is implemented for x86 an=
d get
> >>>>>>>> confused.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
> >>>>>>>>>> +					kvg->vfio_group);
> >>>>>>>>>> +#endif
> >>>>>>>>>>  			kvm_vfio_group_put_external_user(kvg->vfio_group);
> >>>>>>>>>>  			kfree(kvg);
> >>>>>>>>>>  			ret =3D 0;
> >>>>>>>>>> @@ -201,6 +241,69 @@ static int kvm_vfio_set_group(struct kvm_=
device
> >>>>>> *dev, long attr, u64 arg)
> >>>>>>>>>>  		kvm_vfio_update_coherency(dev);
> >>>>>>>>>>
> >>>>>>>>>>  		return ret;
> >>>>>>>>>> +
> >>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >>>>>>>>>> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: {
> >>>>>>>>>> +		struct kvm_vfio_spapr_tce_liobn param;
> >>>>>>>>>> +		unsigned long minsz;
> >>>>>>>>>> +		struct kvm_vfio *kv =3D dev->private;
> >>>>>>>>>> +		struct vfio_group *vfio_group;
> >>>>>>>>>> +		struct kvm_vfio_group *kvg;
> >>>>>>>>>> +		struct fd f;
> >>>>>>>>>> +
> >>>>>>>>>> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce_liobn,
> >>>>>>>>>> +				start_addr);
> >>>>>>>>>> +
> >>>>>>>>>> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> >>>>>>>>>> +			return -EFAULT;
> >>>>>>>>>> +
> >>>>>>>>>> +		if (param.argsz < minsz)
> >>>>>>>>>> +			return -EINVAL;
> >>>>>>>>>> +
> >>>>>>>>>> +		f =3D fdget(param.fd);
> >>>>>>>>>> +		if (!f.file)
> >>>>>>>>>> +			return -EBADF;
> >>>>>>>>>> +
> >>>>>>>>>> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
> >>>>>>>>>> +		fdput(f);
> >>>>>>>>>> +
> >>>>>>>>>> +		if (IS_ERR(vfio_group))
> >>>>>>>>>> +			return PTR_ERR(vfio_group);
> >>>>>>>>>> +
> >>>>>>>>>> +		ret =3D -ENOENT;
> >>>>>>>>>
> >>>>>>>>> Shouldn't there be some runtime test for the type of the IOMMU?=
  It's
> >>>>>>>>> possible a kernel could be built for a platform supporting mult=
iple
> >>>>>>>>> IOMMU types.
> >>>>>>>>
> >>>>>>>> Well, may make sense but I do not know to test that. The IOMMU t=
ype is a
> >>>>>>>> VFIO container property, not a group property and here (KVM) we =
only have
> >>>>>>>> groups.
> >>>>>>>
> >>>>>>> Which, as mentioned previously, is broken.
> >>>>>>
> >>>>>> Which I am failing to follow you on this.
> >>>>>>
> >>>>>> What I am trying to achieve here is pretty much referencing a grou=
p so it
> >>>>>> cannot be reused. Plus LIOBNs.
> >>>>>
> >>>>> "Plus LIOBNs" is not a trivial change.  You are establishing a link=
age
> >>>> >from LIOBNs to groups.  But that doesn't make sense; if mapping in =
one
> >>>>> (guest) LIOBN affects a group it must affect all groups in the
> >>>>> container.  i.e. LIOBN->container is the natural mapping, *not* LIO=
BN
> >>>>> to group.
> >>>>
> >>>> I can see your point but i don't see how to proceed now, I'm totally=
 stuck.
> >>>> Pass container fd and then implement new api to lock containers some=
how and
> >>>
> >>> I'm not really understanding what the question is about locking conta=
iners.
> >>>
> >>>> enumerate groups when updating TCE table (including real mode)?
> >>>
> >>> Why do you need to enumerate groups?  The groups within the container
> >>> share a TCE table, so can't you just update that once?
> >>
> >> Well, they share a TCE table but they do not share TCE Kill (TCE cache
> >> invalidate) register address, it is still per PE but this does not mat=
ter
> >> here (pnv_pci_link_table_and_group() does that), just mentioned to com=
plete
> >> the picture.
> >=20
> > True, you'll need to enumerate the groups for invalidates.  But you
> > need that already, right.
> >=20
> >>>> Plus new API when we remove a group from a container as the result o=
f guest
> >>>> PCI hot unplug?
> >>>
> >>> I assume you mean a kernel internal API, since it shouldn't need
> >>> anything else visible to userspace.  Won't this happen naturally?
> >>> When the group is removed from the container, it will get its own TCE
> >>> table instead of the previously shared one.
> >>>
> >>>>>> Passing a container fd does not make much
> >>>>>> sense here as the VFIO device would walk through groups, reference=
 them and
> >>>>>> that is it, there is no locking on VFIO containters and so far the=
re was no
> >>>>>> need to teach KVM about containers.
> >>>>>>
> >>>>>> What do I miss now?
> >>>>>
> >>>>> Referencing the groups is essentially just a useful side effect.  T=
he
> >>>>> important functionality is informing VFIO of the guest LIOBNs; and
> >>>>> LIOBNs map to containers, not groups.
> >>>>
> >>>> No. One liobn maps to one KVM-allocated TCE table, not a container. =
There
> >>>> can be one or many or none containers per liobn.
> >>>
> >>> Ah, true.
> >>
> >> So I need to add new kernel API for KVM to get table(s) from VFIO
> >> container(s). And invent some locking mechanism to prevent table(s) (or
> >> associated container(s)) from going away, like
> >> vfio_group_get_external_user/vfio_group_put_external_user but for
> >> containers. Correct?
> >=20
> > Well, the container is attached to an fd, so if you get a reference on
> > the file* that should do it.
>=20
> I am still trying to think of how to implement this suggestion.
>=20
> I need a way to tell KVM about IOMMU groups. vfio-pci driver is not right
> interface as it knows nothing about KVM. There is VFIO-KVM device but it
> does not have idea about containers.
>=20
> So I have to:
>=20
> Wenever a container is created or removed, notify the VFIO-KVM device by
> passing there a container fd. ok.

Actually, I don't think the vfio-kvm device is really useful here.  It
was designed as a hack for a particular problem on x86.  It certainly
could be extended to cover the information we need here, but I don't
think it's a particularly natural way of doing so.

The problem is that conveying the information from the vfio-kvm device
to the real mode H_PUT_TCE handler, which is what really needs it,
isn't particularly simpler than conveying that information from
anywhere else.

> Then VFIO-KVM device needs to tell KVM about what iommu_table belongs to
> what LIOBN so the realmode handlers could do the job. The real mode TCE
> handlers get LIOBN, find a guest view table and update it. Now I want to
> update the hardware table which is iommu_table attached to LIOBN.
>=20
> I did pass an IOMMU group fd to VFIO-KVM device. You suggested a containe=
r fd.
>=20
> Now VFIO-KVM device needs to extract iommu_table's from the container.
> These iommu_table pointers are stored in "struct tce_container" which is
> local to drivers/vfio/vfio_iommu_spapr_tce.c and not exported anyhow. So I
> cannot export and use that.
>=20
> The other way to go would be adding API to VFIO to enumerate IOMMU groups
> in a container and use iommu_table pointers stored in iommu_table_group of
> each group (in fact the very first group will be enough as multiple groups
> in a container share the table). Adding vfio_container_get_groups() when
> only first one is needed is quite tricky in terms of maintainers approval=
s.
>=20
> So what would be the right course of action? Thanks.

So, from the user side, you need to be able to bind a VFIO backend to
a particular guest IOMMU.  This suggests a new ioctl() used in
conjunction with KVM_CREATE_SPAPR_TCE.  Let's call it
KVM_SPAPR_TCE_BIND_VFIO.  You'd use KVM_CREATE_SPAPR_TCE to make the
kernel aware of a LIOBN in the first place, then use
KVM_SPAPR_TCE_BIND_VFIO to associate a VFIO container with that LIOBN.
So it would be a VM ioctl, taking a LIOBN and a container fd.  You'd
need a capability to go with it, and some way to unbind as well.

To implement that, the ioctl() would need to use a new vfio (kernel
internal) interface - which can be specific to only the spapr TCE
type.  That would take the container fd, and return the list of
iommu_tables in some form or other (or various error conditions,
obviously).

So, when qemu creates the PHB, it uses KVM_CREATE_SPAPR_TCE to inform
the kernel of the LIOBN.  When the VFIO device is attached to the PHB,
it uses KVM_SPAPR_TCE_BIND_VFIO to connect the VFIO container to the
LIOBN.  The ioctl() implementation uses the new special interface into
the spapr_tce vfio backend to get the list of iommu tables, which it
stores in some private format.  The H_PUT_TCE implementation uses that
stored list of iommu tables to translate H_PUT_TCEs from the guest
into actions on the host IOMMU tables.

And, yes, the special interface to the spapr TCE vfio back end is kind
of a hack.  That's what you get when you need to link to separate
kernel subsystems for performance reasons.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LZ92CUgs0ha736zO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWmMxAAoJEGw4ysog2bOSmoUP/iQYzURAioKUrkvuYYE5INe1
pqjkQ3YhPDYNW6YhcRa/EtIOzy7ht53UsZnnygRix9cUx0qjvO+uUPCXqzIjkMc9
jU5THSzCA2Dg2NXyX7whlobiJp6xZYcRZYUy9Ag37sGOvdncbMNhLCr4KH4LLL6A
L8ZD17a/NpPF3ijOlzel8JXchvjJCAixiE+Ba2NgIvIofsXks6FpMyMJT0wsdkvb
OUAS8S6phCdmtTQiOths42PzvMSeF0kk7UIFmPLosHy4liWBXtS6JxTibJhUl4gL
l66J3bIzJnKV0TDwxgsnLHg18nvQt1GyACF/opP820S7hhg5P9bxUi0+3U5Maxbv
D9gWLV2Po9huV1BZncswVYvYHoSXmG4QDwzrplHCpvmhaeI8n46TAZ4rCVxhvj/X
bRA+b8AUsToHaGcNmcAAQwqzhwiE58kDBsScFNyihFXym6lOzsq5xbid3SnUo8+N
zQylukYKHhT5NjThYUHh+Ggn0wbxEyBHBRcMbZa/jjhtZ/gPHtwk9BZuBWVNkWKn
Vl+ItjPcC74kA49AyhCr/0mMQj5AkpB6MDZr0UoHe71xK5bsFRCbSMrV/2yRE7NV
QzgIuTnHk6M1UBE/QFvposO96ozz+1DqlPxZXFxf5FBt3YqKZiar/p9hK8FJ/qII
cNBMaOjU70WjzMJUef0i
=KJqS
-----END PGP SIGNATURE-----

--LZ92CUgs0ha736zO--
