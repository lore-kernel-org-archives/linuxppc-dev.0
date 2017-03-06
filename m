Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc75C4QVCzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:05:03 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 77so5907950pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 21:05:02 -0800 (PST)
Subject: Re: [PATCH kernel v6 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170302085644.41828-1-aik@ozlabs.ru>
 <20170302085644.41828-11-aik@ozlabs.ru>
 <20170303055927.GJ667@umbus.fritz.box>
 <56d7983d-50ff-36e8-c55b-4a6316fc26b6@ozlabs.ru>
 <20170306043055.GI12030@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8c74cd5e-acac-2dd4-206d-3898c6a25405@ozlabs.ru>
Date: Mon, 6 Mar 2017 16:04:55 +1100
MIME-Version: 1.0
In-Reply-To: <20170306043055.GI12030@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GoFxAGQMEFSU0L8vGLD44TEiprOKWlcm5"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GoFxAGQMEFSU0L8vGLD44TEiprOKWlcm5
Content-Type: multipart/mixed; boundary="p1wa3Iibb3sxFepKf9PACn1WViAHSd696";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <8c74cd5e-acac-2dd4-206d-3898c6a25405@ozlabs.ru>
Subject: Re: [PATCH kernel v6 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
References: <20170302085644.41828-1-aik@ozlabs.ru>
 <20170302085644.41828-11-aik@ozlabs.ru>
 <20170303055927.GJ667@umbus.fritz.box>
 <56d7983d-50ff-36e8-c55b-4a6316fc26b6@ozlabs.ru>
 <20170306043055.GI12030@umbus.fritz.box>
In-Reply-To: <20170306043055.GI12030@umbus.fritz.box>

--p1wa3Iibb3sxFepKf9PACn1WViAHSd696
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 06/03/17 15:30, David Gibson wrote:
> On Fri, Mar 03, 2017 at 06:09:25PM +1100, Alexey Kardashevskiy wrote:
>> On 03/03/17 16:59, David Gibson wrote:
>>> On Thu, Mar 02, 2017 at 07:56:44PM +1100, Alexey Kardashevskiy wrote:=

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
>>>> ---
>>>> Changes:
>>>> v6:
>>>> * changed handling of errors returned by kvmppc_(rm_)tce_iommu_(un)m=
ap()
>>>> * moved kvmppc_gpa_to_ua() to TCE validation
>>>>
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
>>>>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
>>>>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>>>>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>>>>  include/uapi/linux/kvm.h                   |   8 +
>>>>  arch/powerpc/kvm/book3s_64_vio.c           | 321 ++++++++++++++++++=
++++++++++-
>>>>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 165 ++++++++++++++-
>>>>  arch/powerpc/kvm/powerpc.c                 |   2 +
>>>>  virt/kvm/vfio.c                            |  60 ++++++
>>>>  8 files changed, 585 insertions(+), 5 deletions(-)
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
>>>> index 7bba8f415627..857ae2c6aa39 100644
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
>>>> index 72c2a155641f..66de7e73b3d3 100644
>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>> @@ -164,6 +164,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm=
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
>>>> index f5a52ffb6b58..e743cb0d176e 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -1088,6 +1088,7 @@ struct kvm_device_attr {
>>>>  #define  KVM_DEV_VFIO_GROUP			1
>>>>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>>>>  #define   KVM_DEV_VFIO_GROUP_DEL			2
>>>> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
>>>> =20
>>>>  enum kvm_device_type {
>>>>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
>>>> @@ -1109,6 +1110,13 @@ enum kvm_device_type {
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
>>>> index 57dd036bd998..85927f467811 100644
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
>>>> @@ -182,6 +342,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *k=
vm,
>>>>  	stt->offset =3D args->offset;
>>>>  	stt->size =3D size;
>>>>  	stt->kvm =3D kvm;
>>>> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
>>>> =20
>>>>  	for (i =3D 0; i < npages; i++) {
>>>>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
>>>> @@ -210,11 +371,99 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm =
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
>>>> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
>>>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>>>> +
>>>> +	if (WARN_ON_ONCE(!pua))
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

>>>> +		unsigned long entry, unsigned long ua,
>>>> +		enum dma_data_direction dir)
>>>> +{
>>>> +	long ret;
>>>> +	unsigned long hpa, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry=
);
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +
>>>> +	if (!pua)
>>>> +		/* it_userspace allocation might be delayed */
>>>> +		return H_TOO_HARD;
>>>> +
>>>> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
>>>> +	if (!mem)
>>>> +		return H_TOO_HARD;
>>>
>>> IIUC this is the virtual mode path, not the real mode patch.  Under
>>> what circumstances could qemu succeed that KVM virtual mode couldn't,=

>>> for either of the above failures?
>>
>> The (!pua) failure is handled in tce_iommu_build_v2() from
>> drivers/vfio/vfio_iommu_spapr_tce.c as:
>>
>>
>> if (!tbl->it_userspace) {
>>        ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
>>        if (ret)
>>               return ret;
>> }
>=20
> Ah.. which is called from the ioctl() path but not the KVM hcall path,
> ok, I get it.
>=20
>> The (!mem) can succeed if the container is in VFIO_SPAPR_TCE_IOMMU mod=
e
>> (not VFIO_SPAPR_TCE_v2_IOMMU). Remember that the userspace can call
>> ioctl(vfio_kvm_device, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE) without havin=
g
>> memory preregistered so tables will appear in the
>> kvmppc_spapr_tce_iommu_table list in KVM.
>=20
> Ok.  So in short, the userspace->ioctl() path will handle both v1 and
> v2 versions of the IOMMU interface, whereas the in-kernel
> implementation (both real and virtual) will only handle v2.  Is that
> right?


Correct. I used to have an explicit check for any memory preregistered, n=
ow
it is as bit less obvious but still the case.




>=20
>>>> +
>>>> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
>>>> +		return H_HARDWARE;
>>>> +
>>>> +	if (mm_iommu_mapped_inc(mem))
>>>> +		return H_CLOSED;
>>>> +
>>>> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
>>>> +	if (ret) {
>>>
>>> It thought the xchg could basically never fail, so this should be
>>> another WARN_ON().
>>
>>
>> Correct.
>>
>>
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
>>>> +	unsigned long entry, ua =3D 0;
>>>> +	enum dma_data_direction dir;
>>>> =20
>>>>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%=
lx\n", */
>>>>  	/* 	    liobn, ioba, tce); */
>>>> @@ -231,7 +480,35 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, un=
signed long liobn,
>>>>  	if (ret !=3D H_SUCCESS)
>>>>  		return ret;
>>>> =20
>>>> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
>>>> +	dir =3D iommu_tce_direction(tce);
>>>> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
>>>> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
>>>> +		return H_PARAMETER;
>>>> +
>>>> +	entry =3D ioba >> stt->page_shift;
>>>> +
>>>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +		if (dir =3D=3D DMA_NONE) {
>>>> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
>>>> +					stit->tbl, entry);
>>>> +		} else {
>>>> +			idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>>>> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
>>>> +					entry, ua, dir);
>>>> +			srcu_read_unlock(&vcpu->kvm->srcu, idx);
>>>> +		}
>>>> +
>>>> +		if (ret =3D=3D H_SUCCESS)
>>>> +			continue;
>>>> +
>>>> +		if (ret =3D=3D H_TOO_HARD)
>>>> +			return ret;
>>>> +
>>>> +		WARN_ON_ONCE(1);
>>>> +		kvmppc_clear_tce(stit->tbl, entry);
>>>> +	}
>>>> +
>>>> +	kvmppc_tce_put(stt, entry, tce);
>>>> =20
>>>>  	return H_SUCCESS;
>>>>  }
>>>> @@ -246,6 +523,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>>>>  	unsigned long entry, ua =3D 0;
>>>>  	u64 __user *tces;
>>>>  	u64 tce;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -284,6 +562,26 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>>>  		if (ret !=3D H_SUCCESS)
>>>>  			goto unlock_exit;
>>>> =20
>>>> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
>>>> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
>>>> +				&ua, NULL))
>>>> +			return H_PARAMETER;
>>>> +
>>>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
>>>> +					stit->tbl, entry + i, ua,
>>>> +					iommu_tce_direction(tce));
>>>> +
>>>> +			if (ret =3D=3D H_SUCCESS)
>>>> +				continue;
>>>> +
>>>> +			if (ret =3D=3D H_TOO_HARD)
>>>> +				goto unlock_exit;
>>>> +
>>>> +			WARN_ON_ONCE(1);
>>>> +			kvmppc_clear_tce(stit->tbl, entry);
>>>> +		}
>>>> +
>>>>  		kvmppc_tce_put(stt, entry + i, tce);
>>>>  	}
>>>> =20
>>>> @@ -300,6 +598,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret;
>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>  	if (!stt)
>>>> @@ -313,6 +612,24 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
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
>>>> +			if (ret =3D=3D H_SUCCESS)
>>>> +				continue;
>>>> +
>>>> +			if (ret =3D=3D H_TOO_HARD)
>>>> +				return ret;
>>>> +
>>>> +			WARN_ON_ONCE(1);
>>>> +			kvmppc_clear_tce(stit->tbl, entry);
>>>> +		}
>>>> +	}
>>>> +
>>>>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift)=
)
>>>>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
>>>> =20
>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/=
book3s_64_vio_hv.c
>>>> index 440d3ab5dc32..3ad06badc552 100644
>>>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> @@ -161,11 +161,108 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsign=
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
>>>> +	if (WARN_ON_ONCE(!pua))
>>>> +		return H_HARDWARE;
>>>
>>> So.. I know I encouraged WARN_ON()s, but is it safe to call WARN_ON()=

>>> from real mode?
>>
>> Ouch. Tried WARN_ON_ONCE(1) in kvmppc_rm_h_stuff_tce() and got "rcu_sc=
hed
>> detected stalls" straight away.
>=20
> Bother.  Sorry I didn't think of that earlier.
>=20
>> What do I replace it with, in documenting purposes?
>>
>> -	if (WARN_ON_ONCE(!pua))
>> +       if (!pua) /* Not expected to fail */
>=20
> So, I'd suggest adding a WARN_ON_RM() or whatever macro to wrap this
> at least.  As you may have seen I discussed this with mpe on IRC and
> printk() should work, so you could just put a printk() and
> dump_stack() in there.

Yes, noticed. Thanks!




--=20
Alexey


--p1wa3Iibb3sxFepKf9PACn1WViAHSd696--

--GoFxAGQMEFSU0L8vGLD44TEiprOKWlcm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYvO33DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5R/wQAJxc
GvZZXuSPINcbWpFjvrNi71atn+mKM/o7sYtKd4+sSQ5svzdXyy/D9SjOlRVyUqIx
NLaAtz1rWsFSvIewJyOwClySJzX70hbGjZNdQNFYI2jOkuKwiH2Wxt9tPGKByRkz
kyyzUkXnQ31p87EnhYXz+TkPIf5zn7HyK1v40z8Qwv/HWDv9MFIl/FmGjBGFRUR7
1fKOulmjWA6vgyZkYF+nIK6JJbIJR+nITNX57xEwT7xwVkSwZ57e4H+e9Bk0LSlF
M5RZtTeyfur0o2J+5aDflRUkStNYVqyxh0XiOWGQ7ZKXKux4R4Hfed8sfCs7QGY0
1lS9ASMEuYF5AZThRopq8aShW3D1sEklSQRqPa+tiyLb7KWBbwIxrAaWcvXEqoWc
+0vEOqnwVCrdq0D/zA11lWOdIiQXOsNgL9XK9K5wU5FJtiyRAazrV2KsiOuXQWe+
HffSYQWG0NRBPMzDr/JsifyLk6H/TLxBFxCIDpv22ohTNFkSTGWMng3d28UZr3Nz
wneicBMOXsVtqpR/ggt+B2mlYr26fd7tYVo7RTh5/hVEOv7Aw2CqZiJNjQWI2+e6
/bGp+j69vKKyn7lgzvaDwM/uHASfGXu1tXtWgpWmgG55yjmbF0HNYXnvZAoayTz2
4RifAkKeP+rAv1LKSteaJLJQjzeD/PeIU9gMTxct
=cZEW
-----END PGP SIGNATURE-----

--GoFxAGQMEFSU0L8vGLD44TEiprOKWlcm5--
