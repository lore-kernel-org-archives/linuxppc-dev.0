Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTxlP0y35zDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 14:43:13 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 1so1419691pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 19:43:13 -0800 (PST)
Subject: Re: [PATCH kernel v5 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-11-aik@ozlabs.ru>
 <20170224021432.GH17615@umbus.fritz.box>
 <7b2d6cba-73e7-e846-a520-fc2837694c11@ozlabs.ru>
 <20170224033607.GQ17615@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
Date: Fri, 24 Feb 2017 14:43:05 +1100
MIME-Version: 1.0
In-Reply-To: <20170224033607.GQ17615@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5oV1LRpUWAKX1aec9Q66nhxTvEIR7xnQn"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5oV1LRpUWAKX1aec9Q66nhxTvEIR7xnQn
Content-Type: multipart/mixed; boundary="W10cBmDw7stLLTsHfde2sw50eBVX4hcGj";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
Subject: Re: [PATCH kernel v5 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-11-aik@ozlabs.ru>
 <20170224021432.GH17615@umbus.fritz.box>
 <7b2d6cba-73e7-e846-a520-fc2837694c11@ozlabs.ru>
 <20170224033607.GQ17615@umbus.fritz.box>
In-Reply-To: <20170224033607.GQ17615@umbus.fritz.box>

--W10cBmDw7stLLTsHfde2sw50eBVX4hcGj
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 24/02/17 14:36, David Gibson wrote:
> On Fri, Feb 24, 2017 at 02:29:14PM +1100, Alexey Kardashevskiy wrote:
>> On 24/02/17 13:14, David Gibson wrote:
>>> On Wed, Feb 22, 2017 at 07:21:33PM +1100, Alexey Kardashevskiy wrote:=

>>>> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
>>>> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
>>>> without passing them to user space which saves time on switching
>>>> to user space and back.
>>>>
>>>> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
>>>> KVM tries to handle a TCE request in the real mode, if failed
>>>> it passes the request to the virtual mode to complete the operation.=

>>>> If it a virtual mode handler fails, the request is passed to
>>>> the user space; this is not expected to happen though.
>>>>
>>>> To avoid dealing with page use counters (which is tricky in real mod=
e),
>>>> this only accelerates SPAPR TCE IOMMU v2 clients which are required
>>>> to pre-register the userspace memory. The very first TCE request wil=
l
>>>> be handled in the VFIO SPAPR TCE driver anyway as the userspace view=

>>>> of the TCE table (iommu_table::it_userspace) is not allocated till
>>>> the very first mapping happens and we cannot call vmalloc in real mo=
de.
>>>>
>>>> If we fail to update a hardware IOMMU table unexpected reason, we ju=
st
>>>> clear it and move on as there is nothing really we can do about it -=

>>>> for example, if we hot plug a VFIO device to a guest, existing TCE t=
ables
>>>> will be mirrored automatically to the hardware and there is no inter=
face
>>>> to report to the guest about possible failures.
>>>>
>>>> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
>>>> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd=

>>>> and associates a physical IOMMU table with the SPAPR TCE table (whic=
h
>>>> is a guest view of the hardware IOMMU table). The iommu_table object=

>>>> is cached and referenced so we do not have to look up for it in real=
 mode.
>>>>
>>>> This does not implement the UNSET counterpart as there is no use for=
 it -
>>>> once the acceleration is enabled, the existing userspace won't
>>>> disable it unless a VFIO container is destroyed; this adds necessary=

>>>> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
>>>>
>>>> As this creates a descriptor per IOMMU table-LIOBN couple (called
>>>> kvmppc_spapr_tce_iommu_table), it is possible to have several
>>>> descriptors with the same iommu_table (hardware IOMMU table) attache=
d
>>>> to the same LIOBN; we do not remove duplicates though as
>>>> iommu_table_ops::exchange not just update a TCE entry (which is
>>>> shared among IOMMU groups) but also invalidates the TCE cache
>>>> (one per IOMMU group).
>>>>
>>>> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the use=
r
>>>> space.
>>>>
>>>> This finally makes use of vfio_external_user_iommu_id() which was
>>>> introduced quite some time ago and was considered for removal.
>>>>
>>>> Tests show that this patch increases transmission speed from 220MB/s=

>>>> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).=

>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> I have some comments on this patch, but all the definite ones are
>>> pretty minor and could be done as later cleanups.
>>>
>>> I have some more serious queries, but they are just queries and
>>> requests for clarification.  If there are satisfactory answers to
>>> them, I'll add my R-b.
>>>
>>>
>>> ---
>>>> Changes:
>>>> v5:
>>>> * changed error codes in multiple places
>>>> * added bunch of WARN_ON() in places which should not really happen
>>>> * adde a check that an iommu table is not attached already to LIOBN
>>>> * dropped explicit calls to iommu_tce_clear_param_check/
>>>> iommu_tce_put_param_check as kvmppc_tce_validate/kvmppc_ioba_validat=
e
>>>> call them anyway (since the previous patch)
>>>> * if we fail to update a hardware IOMMU table for unexpected reason,=

>>>> this just clears the entry
>>>>
>>>> v4:
>>>> * added note to the commit log about allowing multiple updates of
>>>> the same IOMMU table;
>>>> * instead of checking for if any memory was preregistered, this
>>>> returns H_TOO_HARD if a specific page was not;
>>>> * fixed comments from v3 about error handling in many places;
>>>> * simplified TCE handlers and merged IOMMU parts inline - for exampl=
e,
>>>> there used to be kvmppc_h_put_tce_iommu(), now it is merged into
>>>> kvmppc_h_put_tce(); this allows to check IOBA boundaries against
>>>> the first attached table only (makes the code simpler);
>>>>
>>>> v3:
>>>> * simplified not to use VFIO group notifiers
>>>> * reworked cleanup, should be cleaner/simpler now
>>>>
>>>> v2:
>>>> * reworked to use new VFIO notifiers
>>>> * now same iommu_table may appear in the list several times, to be f=
ixed later
>>>> ---
>>>>  Documentation/virtual/kvm/devices/vfio.txt |  22 ++-
>>>>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>>>>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>>>>  include/uapi/linux/kvm.h                   |   8 +
>>>>  arch/powerpc/kvm/book3s_64_vio.c           | 307 ++++++++++++++++++=
++++++++++-
>>>>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 152 +++++++++++++-
>>>>  arch/powerpc/kvm/powerpc.c                 |   2 +
>>>>  virt/kvm/vfio.c                            |  60 ++++++
>>>>  8 files changed, 555 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentat=
ion/virtual/kvm/devices/vfio.txt
>>>> index ef51740c67ca..f95d867168ea 100644
>>>> --- a/Documentation/virtual/kvm/devices/vfio.txt
>>>> +++ b/Documentation/virtual/kvm/devices/vfio.txt
>>>> @@ -16,7 +16,25 @@ Groups:
>>>> =20
>>>>  KVM_DEV_VFIO_GROUP attributes:
>>>>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device track=
ing
>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>> +	for the VFIO group.
>>>>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device =
tracking
>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>> +	for the VFIO group.
>>>> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE ta=
ble
>>>> +	allocated by sPAPR KVM.
>>>> +	kvm_device_attr.addr points to a struct:
>>>> =20
>>>> -For each, kvm_device_attr.addr points to an int32_t file descriptor=

>>>> -for the VFIO group.
>>>> +	struct kvm_vfio_spapr_tce {
>>>> +		__u32	argsz;
>>>> +		__u32	flags;
>>>> +		__s32	groupfd;
>>>> +		__s32	tablefd;
>>>> +	};
>>>> +
>>>> +	where
>>>> +	@argsz is the size of kvm_vfio_spapr_tce_liobn;
>>>> +	@flags are not supported now, must be zero;
>>>> +	@groupfd is a file descriptor for a VFIO group;
>>>> +	@tablefd is a file descriptor for a TCE table allocated via
>>>> +		KVM_CREATE_SPAPR_TCE.
>>>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/incl=
ude/asm/kvm_host.h
>>>> index e59b172666cd..a827006941f8 100644
>>>> --- a/arch/powerpc/include/asm/kvm_host.h
>>>> +++ b/arch/powerpc/include/asm/kvm_host.h
>>>> @@ -191,6 +191,13 @@ struct kvmppc_pginfo {
>>>>  	atomic_t refcnt;
>>>>  };
>>>> =20
>>>> +struct kvmppc_spapr_tce_iommu_table {
>>>> +	struct rcu_head rcu;
>>>> +	struct list_head next;
>>>> +	struct vfio_group *group;
>>>> +	struct iommu_table *tbl;
>>>> +};
>>>> +
>>>>  struct kvmppc_spapr_tce_table {
>>>>  	struct list_head list;
>>>>  	struct kvm *kvm;
>>>> @@ -199,6 +206,7 @@ struct kvmppc_spapr_tce_table {
>>>>  	u32 page_shift;
>>>>  	u64 offset;		/* in pages */
>>>>  	u64 size;		/* window size in pages */
>>>> +	struct list_head iommu_tables;
>>>>  	struct page *pages[0];
>>>>  };
>>>> =20
>>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/inclu=
de/asm/kvm_ppc.h
>>>> index e04b7fb8ccaa..b8a39dec92cf 100644
>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>> @@ -163,6 +163,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm=
,
>>>>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>>>>  			struct kvm_memory_slot *memslot, unsigned long porder);
>>>>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
>>>> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int t=
ablefd,
>>>> +		struct vfio_group *group);
>>>> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
>>>> +		struct vfio_group *group);
>>>> =20
>>>>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>>>  				struct kvm_create_spapr_tce_64 *args);
>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>> index a2c9bb5a0ead..cdfa01169bd2 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -1076,6 +1076,7 @@ struct kvm_device_attr {
>>>>  #define  KVM_DEV_VFIO_GROUP			1
>>>>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>>>>  #define   KVM_DEV_VFIO_GROUP_DEL			2
>>>> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
>>>> =20
>>>>  enum kvm_device_type {
>>>>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
>>>> @@ -1097,6 +1098,13 @@ enum kvm_device_type {
>>>>  	KVM_DEV_TYPE_MAX,
>>>>  };
>>>> =20
>>>> +struct kvm_vfio_spapr_tce {
>>>> +	__u32	argsz;
>>>> +	__u32	flags;
>>>> +	__s32	groupfd;
>>>> +	__s32	tablefd;
>>>> +};
>>>> +
>>>>  /*
>>>>   * ioctls for VM fds
>>>>   */
>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/boo=
k3s_64_vio.c
>>>> index 15df8ae627d9..062407af09ee 100644
>>>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>>>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>>>> @@ -27,6 +27,10 @@
>>>>  #include <linux/hugetlb.h>
>>>>  #include <linux/list.h>
>>>>  #include <linux/anon_inodes.h>
>>>> +#include <linux/iommu.h>
>>>> +#include <linux/file.h>
>>>> +#include <linux/vfio.h>
>>>> +#include <linux/module.h>
>>>> =20
>>>>  #include <asm/tlbflush.h>
>>>>  #include <asm/kvm_ppc.h>
>>>> @@ -39,6 +43,36 @@
>>>>  #include <asm/udbg.h>
>>>>  #include <asm/iommu.h>
>>>>  #include <asm/tce.h>
>>>> +#include <asm/mmu_context.h>
>>>> +
>>>> +static void kvm_vfio_group_put_external_user(struct vfio_group *vfi=
o_group)
>>>> +{
>>>> +	void (*fn)(struct vfio_group *);
>>>> +
>>>> +	fn =3D symbol_get(vfio_group_put_external_user);
>>>> +	if (WARN_ON(!fn))
>>>> +		return;
>>>> +
>>>> +	fn(vfio_group);
>>>> +
>>>> +	symbol_put(vfio_group_put_external_user);
>>>> +}
>>>> +
>>>> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_=
group)
>>>> +{
>>>> +	int (*fn)(struct vfio_group *);
>>>> +	int ret =3D -1;
>>>> +
>>>> +	fn =3D symbol_get(vfio_external_user_iommu_id);
>>>> +	if (!fn)
>>>> +		return ret;
>>>> +
>>>> +	ret =3D fn(vfio_group);
>>>> +
>>>> +	symbol_put(vfio_external_user_iommu_id);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> =20
>>>>  static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
>>>>  {
>>>> @@ -90,6 +124,130 @@ static long kvmppc_account_memlimit(unsigned lo=
ng stt_pages, bool inc)
>>>>  	return ret;
>>>>  }
>>>> =20
>>>> +static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
>>>> +{
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(head,
>>>> +			struct kvmppc_spapr_tce_iommu_table, rcu);
>>>> +
>>>> +	iommu_table_put(stit->tbl);
>>>> +	kvm_vfio_group_put_external_user(stit->group);
>>>> +
>>>> +	kfree(stit);
>>>> +}
>>>> +
>>>> +static void kvm_spapr_tce_liobn_release_iommu_group(
>>>> +		struct kvmppc_spapr_tce_table *stt,
>>>> +		struct vfio_group *group)
>>>> +{
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
>>>> +
>>>> +	list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
>>>> +		if (group && (stit->group !=3D group))
>>>> +			continue;
>>>> +
>>>> +		list_del_rcu(&stit->next);
>>>> +
>>>> +		call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
>>>> +	}
>>>> +}
>>>> +
>>>> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
>>>> +		struct vfio_group *group)
>>>> +{
>>>> +	struct kvmppc_spapr_tce_table *stt;
>>>> +
>>>> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list)
>>>> +		kvm_spapr_tce_liobn_release_iommu_group(stt, group);
>>>> +}
>>>> +
>>>> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int t=
ablefd,
>>>> +		struct vfio_group *group)
>>>> +{
>>>> +	struct kvmppc_spapr_tce_table *stt =3D NULL;
>>>> +	bool found =3D false;
>>>> +	struct iommu_table *tbl =3D NULL;
>>>> +	struct iommu_table_group *table_group;
>>>> +	long i, ret =3D 0;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> +	struct fd f;
>>>> +	int group_id;
>>>> +	struct iommu_group *grp;
>>>> +
>>>> +	group_id =3D kvm_vfio_external_user_iommu_id(group);
>>>> +	grp =3D iommu_group_get_by_id(group_id);
>>>> +	if (WARN_ON(!grp))
>>>> +		return -EIO;
>>>
>>> I think it would be nicer to have a function that goes directly from
>>> vfio_group to iommu_group rather than going via id.  That can be a
>>> later cleanup, though.
>>>
>>>> +
>>>> +	f =3D fdget(tablefd);
>>>> +	if (!f.file) {
>>>> +		ret =3D -EBADF;
>>>> +		goto put_exit;
>>>> +	}
>>>> +
>>>> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
>>>> +		if (stt =3D=3D f.file->private_data) {
>>>> +			found =3D true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	fdput(f);
>>>> +
>>>> +	if (!found) {
>>>> +		ret =3D -EINVAL;
>>>> +		goto put_exit;
>>>> +	}
>>>> +
>>>> +	table_group =3D iommu_group_get_iommudata(grp);
>>>> +	if (WARN_ON(!table_group)) {
>>>> +		ret =3D -EFAULT;
>>>> +		goto put_exit;
>>>> +	}
>>>> +
>>>> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>>>> +		struct iommu_table *tbltmp =3D table_group->tables[i];
>>>> +
>>>> +		if (!tbltmp)
>>>> +			continue;
>>>> +
>>>> +		/*
>>>> +		 * Make sure hardware table parameters are exactly the same;
>>>> +		 * this is used in the TCE handlers where boundary checks
>>>> +		 * use only the first attached table.
>>>> +		 */
>>>> +		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
>>>> +				(tbltmp->it_offset =3D=3D stt->offset) &&
>>>> +				(tbltmp->it_size =3D=3D stt->size)) {
>>>> +			tbl =3D tbltmp;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	if (!tbl) {
>>>> +		ret =3D -EINVAL;
>>>> +		goto put_exit;
>>>> +	}
>>>> +
>>>> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
>>>> +		if ((stit->tbl =3D=3D tbl) && (stit->group =3D=3D group)) {
>>>> +			ret =3D -EBUSY;
>>>> +			goto put_exit;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	iommu_table_get(tbl);
>>>> +
>>>> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
>>>> +	stit->tbl =3D tbl;
>>>> +	stit->group =3D group;
>>>> +
>>>> +	list_add_rcu(&stit->next, &stt->iommu_tables);
>>>> +
>>>> +put_exit:
>>>> +	iommu_group_put(grp);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static void release_spapr_tce_table(struct rcu_head *head)
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
>>>> @@ -132,6 +290,8 @@ static int kvm_spapr_tce_release(struct inode *i=
node, struct file *filp)
>>>> =20
>>>>  	list_del_rcu(&stt->list);
>>>> =20
>>>> +	kvm_spapr_tce_liobn_release_iommu_group(stt, NULL /* release all *=
/);
>>>> +
>>>>  	kvm_put_kvm(stt->kvm);
>>>> =20
>>>>  	kvmppc_account_memlimit(
>>>> @@ -181,6 +341,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *k=
vm,
>>>>  	stt->offset =3D args->offset;
>>>>  	stt->size =3D size;
>>>>  	stt->kvm =3D kvm;
>>>> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
>>>> =20
>>>>  	for (i =3D 0; i < npages; i++) {
>>>>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
>>>> @@ -209,11 +370,102 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm=
 *kvm,
>>>>  	return ret;
>>>>  }
>>>> =20
>>>> +static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long=
 entry)
>>>> +{
>>>> +	unsigned long hpa =3D 0;
>>>> +	enum dma_data_direction dir =3D DMA_NONE;
>>>> +
>>>> +	iommu_tce_xchg(tbl, entry, &hpa, &dir);
>>>> +}
>>>> +
>>>> +static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
>>>> +		struct iommu_table *tbl, unsigned long entry)
>>>> +{
>>>> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>>>
>>> Initialization is unnecessary for the variable above.
>>>
>>>> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
>>>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>>>> +
>>>> +	if (WARN_ON(!pua))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	mem =3D mm_iommu_lookup(kvm->mm, *pua, pgsize);
>>>> +	if (!mem)
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	mm_iommu_mapped_dec(mem);
>>>> +
>>>> +	*pua =3D 0;
>>>> +
>>>> +	return H_SUCCESS;
>>>> +}
>>>> +
>>>> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>>>> +		struct iommu_table *tbl, unsigned long entry)
>>>> +{
>>>> +	enum dma_data_direction dir =3D DMA_NONE;
>>>> +	unsigned long hpa =3D 0;
>>>> +	long ret;
>>>> +
>>>> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	if (dir =3D=3D DMA_NONE)
>>>> +		return H_SUCCESS;
>>>> +
>>>> +	ret =3D kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
>>>> +	if (ret !=3D H_SUCCESS)
>>>> +		iommu_tce_xchg(tbl, entry, &hpa, &dir);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,=

>>>> +		unsigned long entry, unsigned long gpa,
>>>> +		enum dma_data_direction dir)
>>>> +{
>>>> +	long ret;
>>>> +	unsigned long hpa, ua, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, e=
ntry);
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +
>>>> +	if (!pua)
>>>> +		/* it_userspace allocation might be delayed */
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
>>>> +		return H_PARAMETER;
>>>> +
>>>> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
>>>> +	if (!mem)
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	if (WARN_ON(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
>>>> +		return H_HARDWARE;
>>>
>>> Remind me - could a failure here be triggered by userspace failing to=

>>> preregister all the memory it should?
>>
>>
>> mm_iommu_lookup() should fail first as the only reason for
>> mm_iommu_ua_to_hpa() to fail is (entry >=3D mem->entries) but this is =
checked
>> in mm_iommu_lookup().
>=20
> Ah, yes of course, I forgot.  Ok, that should be fine.
>=20
>=20
>>>
>>>> +	if (mm_iommu_mapped_inc(mem))
>>>> +		return H_CLOSED;
>>>> +
>>>> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
>>>> +	if (ret) {
>>>> +		mm_iommu_mapped_dec(mem);
>>>> +		return H_TOO_HARD;
>>>> +	}
>>>> +
>>>> +	if (dir !=3D DMA_NONE)
>>>> +		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
>>>> +
>>>> +	*pua =3D ua;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>>>  		      unsigned long ioba, unsigned long tce)
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>> -	long ret;
>>>> +	long ret, idx;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> +	unsigned long entry, gpa;
>>>> +	enum dma_data_direction dir;
>>>> =20
>>>>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%=
lx\n", */
>>>>  	/* 	    liobn, ioba, tce); */
>>>> @@ -230,7 +482,28 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, un=
signed long liobn,
>>>>  	if (ret !=3D H_SUCCESS)
>>>>  		return ret;
>>>> =20
>>>> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
>>>> +	entry =3D ioba >> stt->page_shift;
>>>> +	gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>>>> +	dir =3D iommu_tce_direction(tce);
>>>> +
>>>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +		if (dir =3D=3D DMA_NONE) {
>>>> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
>>>> +					stit->tbl, entry);
>>>> +		} else {
>>>> +			idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>>>> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
>>>> +					entry, gpa, dir);
>>>> +			srcu_read_unlock(&vcpu->kvm->srcu, idx);
>>>> +		}
>>>> +
>>>> +		if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>> +			kvmppc_clear_tce(stit->tbl, entry);
>>>> +		else if (ret !=3D H_SUCCESS)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	kvmppc_tce_put(stt, entry, tce);
>>>> =20
>>>>  	return H_SUCCESS;
>>>>  }
>>>> @@ -242,9 +515,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret =3D H_SUCCESS, idx;
>>>> -	unsigned long entry, ua =3D 0;
>>>> +	unsigned long entry, ua =3D 0, gpa;
>>>>  	u64 __user *tces;
>>>>  	u64 tce;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -283,6 +557,18 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>>>  		if (ret !=3D H_SUCCESS)
>>>>  			goto unlock_exit;
>>>> =20
>>>> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>>>> +
>>>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
>>>> +					stit->tbl, entry + i, gpa,
>>>> +					iommu_tce_direction(tce));
>>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>> +				kvmppc_clear_tce(stit->tbl, entry);
>>>> +			else if (ret !=3D H_SUCCESS)
>>>> +				goto unlock_exit;
>>>> +		}
>>>> +
>>>>  		kvmppc_tce_put(stt, entry + i, tce);
>>>>  	}
>>>> =20
>>>> @@ -299,6 +585,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -312,6 +599,20 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>>>>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>>>>  		return H_PARAMETER;
>>>> =20
>>>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
>>>> +
>>>> +		for (i =3D 0; i < npages; ++i) {
>>>> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
>>>> +					stit->tbl, entry + i);
>>>> +
>>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>> +				kvmppc_clear_tce(stit->tbl, entry);
>>>> +			else if (ret !=3D H_SUCCESS)
>>>> +				return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift)=
)
>>>>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
>>>> =20
>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/=
book3s_64_vio_hv.c
>>>> index 92d769f4eaea..4a1d978ebd98 100644
>>>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> @@ -161,11 +161,111 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsign=
ed long gpa,
>>>>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
>>>> =20
>>>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>>> +static void kvmppc_rm_clear_tce(struct iommu_table *tbl, unsigned l=
ong entry)
>>>> +{
>>>> +	unsigned long hpa =3D 0;
>>>> +	enum dma_data_direction dir =3D DMA_NONE;
>>>> +
>>>> +	iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>>>> +}
>>>> +
>>>> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
>>>> +		struct iommu_table *tbl, unsigned long entry)
>>>> +{
>>>> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>>>> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
>>>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>>>> +
>>>> +	if (WARN_ON(!pua))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	pua =3D (void *) vmalloc_to_phys(pua);
>>>> +	if (!pua)
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	mem =3D mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
>>>> +	if (!mem)
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	mm_iommu_mapped_dec(mem);
>>>> +
>>>> +	*pua =3D 0;
>>>> +
>>>> +	return H_SUCCESS;
>>>> +}
>>>> +
>>>> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>>>> +		struct iommu_table *tbl, unsigned long entry)
>>>> +{
>>>> +	enum dma_data_direction dir =3D DMA_NONE;
>>>> +	unsigned long hpa =3D 0;
>>>> +	long ret;
>>>> +
>>>> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
>>>> +		return H_HARDWARE;
>>>
>>> To avoid a double WARN() (and to make the warnings easier to
>>> understand) I'd suggest putting a WARN_ON() here, rather than in the
>>> callers when they receieve an H_HARDWARE.  IIUC this really shouldn't=

>>> ever happen, and it certainly can't be the guest's fault?
>>
>>
>> Makes sense.
>=20
> I guess it might want WARN_ON_ONCE() to avoid spamming the user with
> errors for every TCE, though.


We do not expect this to happen at all :) I can convert all of them to
_ONCE really as the purpose of WARN_ON is mostly to document what we do n=
ot
expect.



>>>> +
>>>> +	if (dir =3D=3D DMA_NONE)
>>>> +		return H_SUCCESS;
>>>> +
>>>> +	ret =3D kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
>>>> +	if (ret)
>>>> +		iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_t=
able *tbl,
>>>> +		unsigned long entry, unsigned long gpa,
>>>> +		enum dma_data_direction dir)
>>>> +{
>>>> +	long ret;
>>>> +	unsigned long hpa =3D 0, ua;
>>>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +
>>>> +	if (!pua)
>>>> +		/* it_userspace allocation might be delayed */
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
>>>> +		return H_PARAMETER;
>>
>>
>> Referred below as [1]
>>
>>
>>>> +
>>>> +	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift=
);
>>>> +	if (!mem)
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	if (WARN_ON(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	pua =3D (void *) vmalloc_to_phys(pua);
>>>> +	if (WARN_ON(!pua))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	if (WARN_ON(mm_iommu_mapped_inc(mem)))
>>>> +		return H_CLOSED;
>>>> +
>>>> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>>>> +	if (ret) {
>>>> +		mm_iommu_mapped_dec(mem);
>>>> +		return H_TOO_HARD;
>>>> +	}
>>>> +
>>>> +	if (dir !=3D DMA_NONE)
>>>> +		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
>>>> +
>>>> +	*pua =3D ua;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn=
,
>>>>  		unsigned long ioba, unsigned long tce)
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long ret;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> +	unsigned long entry, gpa;
>>>> +	enum dma_data_direction dir;
>>>> =20
>>>>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%=
lx\n", */
>>>>  	/* 	    liobn, ioba, tce); */
>>>> @@ -182,7 +282,25 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu,=
 unsigned long liobn,
>>>>  	if (ret !=3D H_SUCCESS)
>>>>  		return ret;
>>>> =20
>>>> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
>>>> +	entry =3D ioba >> stt->page_shift;
>>>> +	gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>>>> +	dir =3D iommu_tce_direction(tce);
>>>> +
>>>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +		if (dir =3D=3D DMA_NONE)
>>>> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>>>> +					stit->tbl, entry);
>>>> +		else
>>>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
>>>> +					stit->tbl, entry, gpa, dir);
>>>> +
>>>> +		if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>> +			kvmppc_rm_clear_tce(stit->tbl, entry);
>>>> +		else if (ret !=3D H_SUCCESS)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	kvmppc_tce_put(stt, entry, tce);
>>>> =20
>>>>  	return H_SUCCESS;
>>>>  }
>>>> @@ -220,9 +338,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vc=
pu *vcpu,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret =3D H_SUCCESS;
>>>> -	unsigned long tces, entry, ua =3D 0;
>>>> +	unsigned long tces, entry, ua =3D 0, tce, gpa;
>>>>  	unsigned long *rmap =3D NULL;
>>>>  	bool prereg =3D false;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -287,12 +406,24 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_v=
cpu *vcpu,
>>>>  	}
>>>> =20
>>>>  	for (i =3D 0; i < npages; ++i) {
>>>> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>> =20
>>>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>>>  		if (ret !=3D H_SUCCESS)
>>>>  			goto unlock_exit;
>>>> =20
>>>> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>>>> +
>>>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
>>>> +					stit->tbl, entry + i, gpa,
>>>> +					iommu_tce_direction(tce));
>>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>
>>> I don't think you need the WARN() here - the only H_HARDWARE failure
>>> path in iommu_map() already includes a WARN().
>>
>>
>> True, I can drop it here.
>>
>>
>>>
>>>> +				kvmppc_rm_clear_tce(stit->tbl, entry);
>>>> +			else if (ret !=3D H_SUCCESS)
>>>> +				goto unlock_exit;
>>>
>>> It's also not clear to me why the H_HARDWARE error path clears the
>>> entry, but the other failure paths don't.  Or why an H_HARDWARE will
>>> result in continuing to set the rest of the TCEs, but other failures
>>> won't.
>>
>>
>> The idea was that other failures still have some chance that handling =
may
>> succeed in virtual mode or via QEMU, H_HARDWARE is fatal.
>=20
> Um... yes.. but the logic seems to be backwards for that: on
> H_HARDWARE you warn and keep going, on other errors you bail out
> entirely.

By "fatal" I means fatal for this particular hardware TCE(s), no hope in
trying this particular TCE in virtual mode.


>=20
>> I am just not sure if H_PARAMETER is what I want to return at [1], to =
make
>> the calling code simplier, I could return H_HARDWARE there as well (in=
stead
>> of H_PARAMETER).
>=20
> That sounds right, IIUC the gpa to ua translation shouldn't ever
> fail because of something the guest did.=20


The guest can easily pass bad TCE/GPA which is not in any registered slot=
=2E
So it is rather H_PARAMETER.

> So I'd expect either
> H_HARDWARE, or H_TOO_HARD (if there's some hope that virtual mode can
> make the translation when real mode couldn't).

No, virtual mode uses the exact same helper.


>>>> +		}
>>>> +
>>>>  		kvmppc_tce_put(stt, entry + i, tce);
>>>>  	}
>>>> =20
>>>> @@ -309,6 +440,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu=
,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -322,6 +454,20 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcp=
u,
>>>>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>>>>  		return H_PARAMETER;
>>>> =20
>>>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
>>>> +
>>>> +		for (i =3D 0; i < npages; ++i) {
>>>> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>>>> +					stit->tbl, entry + i);
>>>> +
>>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>> +				kvmppc_rm_clear_tce(stit->tbl, entry);
>>>
>>> As noted earlier, I think this WARN belongs within iommu_unmap()
>>> rather than out here.
>>>
>>>> +			else if (ret !=3D H_SUCCESS)
>>>> +				return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift)=
)
>>>>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
>>>> =20
>>>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c=

>>>> index cd892dec7cb6..f3127dc87912 100644
>>>> --- a/arch/powerpc/kvm/powerpc.c
>>>> +++ b/arch/powerpc/kvm/powerpc.c
>>>> @@ -536,6 +536,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm=
, long ext)
>>>>  #ifdef CONFIG_PPC_BOOK3S_64
>>>>  	case KVM_CAP_SPAPR_TCE:
>>>>  	case KVM_CAP_SPAPR_TCE_64:
>>>> +		/* fallthrough */
>>>> +	case KVM_CAP_SPAPR_TCE_VFIO:
>>>>  	case KVM_CAP_PPC_RTAS:
>>>>  	case KVM_CAP_PPC_FIXUP_HCALL:
>>>>  	case KVM_CAP_PPC_ENABLE_HCALL:
>>>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>>>> index d32f239eb471..2b7dc22265fe 100644
>>>> --- a/virt/kvm/vfio.c
>>>> +++ b/virt/kvm/vfio.c
>>>> @@ -20,6 +20,10 @@
>>>>  #include <linux/vfio.h>
>>>>  #include "vfio.h"
>>>> =20
>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>> +#include <asm/kvm_ppc.h>
>>>> +#endif
>>>> +
>>>>  struct kvm_vfio_group {
>>>>  	struct list_head node;
>>>>  	struct vfio_group *vfio_group;
>>>> @@ -211,6 +215,9 @@ static int kvm_vfio_set_group(struct kvm_device =
*dev, long attr, u64 arg)
>>>> =20
>>>>  		mutex_unlock(&kv->lock);
>>>> =20
>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>> +		kvm_spapr_tce_release_iommu_group(dev->kvm, vfio_group);
>>>> +#endif
>>>>  		kvm_vfio_group_set_kvm(vfio_group, NULL);
>>>> =20
>>>>  		kvm_vfio_group_put_external_user(vfio_group);
>>>> @@ -218,6 +225,53 @@ static int kvm_vfio_set_group(struct kvm_device=
 *dev, long attr, u64 arg)
>>>>  		kvm_vfio_update_coherency(dev);
>>>> =20
>>>>  		return ret;
>>>> +
>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
>>>> +		struct kvm_vfio_spapr_tce param;
>>>> +		unsigned long minsz;
>>>> +		struct kvm_vfio *kv =3D dev->private;
>>>> +		struct vfio_group *vfio_group;
>>>> +		struct kvm_vfio_group *kvg;
>>>> +		struct fd f;
>>>> +
>>>> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce, tablefd);
>>>> +
>>>> +		if (copy_from_user(&param, (void __user *)arg, minsz))
>>>> +			return -EFAULT;
>>>> +
>>>> +		if (param.argsz < minsz || param.flags)
>>>> +			return -EINVAL;
>>>> +
>>>> +		f =3D fdget(param.groupfd);
>>>> +		if (!f.file)
>>>> +			return -EBADF;
>>>> +
>>>> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
>>>> +		fdput(f);
>>>> +
>>>> +		if (IS_ERR(vfio_group))
>>>> +			return PTR_ERR(vfio_group);
>>>> +
>>>> +		ret =3D -ENOENT;
>>>> +
>>>> +		mutex_lock(&kv->lock);
>>>> +
>>>> +		list_for_each_entry(kvg, &kv->group_list, node) {
>>>> +			if (kvg->vfio_group !=3D vfio_group)
>>>> +				continue;
>>>> +
>>>> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
>>>> +					param.tablefd, vfio_group);
>>>> +
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		mutex_unlock(&kv->lock);
>>>> +
>>>> +		return ret;
>>>> +	}
>>>> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>>>>  	}
>>>> =20
>>>>  	return -ENXIO;
>>>> @@ -242,6 +296,9 @@ static int kvm_vfio_has_attr(struct kvm_device *=
dev,
>>>>  		switch (attr->attr) {
>>>>  		case KVM_DEV_VFIO_GROUP_ADD:
>>>>  		case KVM_DEV_VFIO_GROUP_DEL:
>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
>>>> +#endif
>>>>  			return 0;
>>>>  		}
>>>> =20
>>>> @@ -257,6 +314,9 @@ static void kvm_vfio_destroy(struct kvm_device *=
dev)
>>>>  	struct kvm_vfio_group *kvg, *tmp;
>>>> =20
>>>>  	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>> +		kvm_spapr_tce_release_iommu_group(dev->kvm, kvg->vfio_group);
>>>> +#endif
>>>>  		kvm_vfio_group_set_kvm(kvg->vfio_group, NULL);
>>>>  		kvm_vfio_group_put_external_user(kvg->vfio_group);
>>>>  		list_del(&kvg->node);
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
Alexey


--W10cBmDw7stLLTsHfde2sw50eBVX4hcGj--

--5oV1LRpUWAKX1aec9Q66nhxTvEIR7xnQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYr6vJDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5uQ8P/A6u
Jl1AGv0BgMfpn6OcqNrhGK/MtQvguf5CKI1B9ttjA+z2JMobmGUNylScdYbN0uGp
cHNihgnWy2nhaxf4W/uGnaw11TIkGlBb52U+tFLu1k3Prbo7tJV+LYP7asQ3bUUX
BmWgEy0JSYoDgj+YWIkVcib4ni7d1RpkmBTmDChgtpyLc+hw9jg1ujD5XPIwCsV2
O9Ui3wgPieKE2dakMLKUO71kLACKJnowc+EeNnm9f6sloLNjbtvahki+975FSU9J
I7f23WPV4Ndqt0SyTUBsyFG14C9xex801BrC2q6ZQYgyaO5zN0JqDgn+e97E1pVs
oBzT6eTaThtdDx5uccgrTgOhuuE6yTKebTPIOkMKdmaYAvPkbGRwgR8LsuP/lK0A
zvRzPOMCVXcKyP0WKgEUzNgd9E/2vJKm20Mmd5424NULR4QPWwXZs1TR2mcyH19z
2mPK/l1UIXxwMAxV7mtOdMxpXCmCwz0wJ3Z1m5fCjhjbds9TQGZW5y7y5TEssYUx
WMNBoMVfx2QhJHyrDLfoFvErYOiYZc+Ny0aBQYvRkNP67e7ySjxzq11p4uUSS0Ku
XbKwWecsEHJsB4/AJV0hh1q3rayyj6IFJcudiR1U7Do+dh08oT6hU1/NOIuhmUzj
c6/Q2PEPPeqrAvVAam2nHyqZieWAVL8whJF/u6C6
=qPqW
-----END PGP SIGNATURE-----

--5oV1LRpUWAKX1aec9Q66nhxTvEIR7xnQn--
