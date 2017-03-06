Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc6Q33wBFzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 15:34:35 +1100 (AEDT)
Date: Mon, 6 Mar 2017 15:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170306043055.GI12030@umbus.fritz.box>
References: <20170302085644.41828-1-aik@ozlabs.ru>
 <20170302085644.41828-11-aik@ozlabs.ru>
 <20170303055927.GJ667@umbus.fritz.box>
 <56d7983d-50ff-36e8-c55b-4a6316fc26b6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
In-Reply-To: <56d7983d-50ff-36e8-c55b-4a6316fc26b6@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 06:09:25PM +1100, Alexey Kardashevskiy wrote:
> On 03/03/17 16:59, David Gibson wrote:
> > On Thu, Mar 02, 2017 at 07:56:44PM +1100, Alexey Kardashevskiy wrote:
> >> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> >> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
> >> without passing them to user space which saves time on switching
> >> to user space and back.
> >>
> >> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
> >> KVM tries to handle a TCE request in the real mode, if failed
> >> it passes the request to the virtual mode to complete the operation.
> >> If it a virtual mode handler fails, the request is passed to
> >> the user space; this is not expected to happen though.
> >>
> >> To avoid dealing with page use counters (which is tricky in real mode),
> >> this only accelerates SPAPR TCE IOMMU v2 clients which are required
> >> to pre-register the userspace memory. The very first TCE request will
> >> be handled in the VFIO SPAPR TCE driver anyway as the userspace view
> >> of the TCE table (iommu_table::it_userspace) is not allocated till
> >> the very first mapping happens and we cannot call vmalloc in real mode.
> >>
> >> If we fail to update a hardware IOMMU table unexpected reason, we just
> >> clear it and move on as there is nothing really we can do about it -
> >> for example, if we hot plug a VFIO device to a guest, existing TCE tab=
les
> >> will be mirrored automatically to the hardware and there is no interfa=
ce
> >> to report to the guest about possible failures.
> >>
> >> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
> >> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
> >> and associates a physical IOMMU table with the SPAPR TCE table (which
> >> is a guest view of the hardware IOMMU table). The iommu_table object
> >> is cached and referenced so we do not have to look up for it in real m=
ode.
> >>
> >> This does not implement the UNSET counterpart as there is no use for i=
t -
> >> once the acceleration is enabled, the existing userspace won't
> >> disable it unless a VFIO container is destroyed; this adds necessary
> >> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
> >>
> >> As this creates a descriptor per IOMMU table-LIOBN couple (called
> >> kvmppc_spapr_tce_iommu_table), it is possible to have several
> >> descriptors with the same iommu_table (hardware IOMMU table) attached
> >> to the same LIOBN; we do not remove duplicates though as
> >> iommu_table_ops::exchange not just update a TCE entry (which is
> >> shared among IOMMU groups) but also invalidates the TCE cache
> >> (one per IOMMU group).
> >>
> >> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
> >> space.
> >>
> >> This finally makes use of vfio_external_user_iommu_id() which was
> >> introduced quite some time ago and was considered for removal.
> >>
> >> Tests show that this patch increases transmission speed from 220MB/s
> >> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >> Changes:
> >> v6:
> >> * changed handling of errors returned by kvmppc_(rm_)tce_iommu_(un)map=
()
> >> * moved kvmppc_gpa_to_ua() to TCE validation
> >>
> >> v5:
> >> * changed error codes in multiple places
> >> * added bunch of WARN_ON() in places which should not really happen
> >> * adde a check that an iommu table is not attached already to LIOBN
> >> * dropped explicit calls to iommu_tce_clear_param_check/
> >> iommu_tce_put_param_check as kvmppc_tce_validate/kvmppc_ioba_validate
> >> call them anyway (since the previous patch)
> >> * if we fail to update a hardware IOMMU table for unexpected reason,
> >> this just clears the entry
> >>
> >> v4:
> >> * added note to the commit log about allowing multiple updates of
> >> the same IOMMU table;
> >> * instead of checking for if any memory was preregistered, this
> >> returns H_TOO_HARD if a specific page was not;
> >> * fixed comments from v3 about error handling in many places;
> >> * simplified TCE handlers and merged IOMMU parts inline - for example,
> >> there used to be kvmppc_h_put_tce_iommu(), now it is merged into
> >> kvmppc_h_put_tce(); this allows to check IOBA boundaries against
> >> the first attached table only (makes the code simpler);
> >>
> >> v3:
> >> * simplified not to use VFIO group notifiers
> >> * reworked cleanup, should be cleaner/simpler now
> >>
> >> v2:
> >> * reworked to use new VFIO notifiers
> >> * now same iommu_table may appear in the list several times, to be fix=
ed later
> >> ---
> >>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
> >>  arch/powerpc/include/asm/kvm_host.h        |   8 +
> >>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
> >>  include/uapi/linux/kvm.h                   |   8 +
> >>  arch/powerpc/kvm/book3s_64_vio.c           | 321 ++++++++++++++++++++=
++++++++-
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 165 ++++++++++++++-
> >>  arch/powerpc/kvm/powerpc.c                 |   2 +
> >>  virt/kvm/vfio.c                            |  60 ++++++
> >>  8 files changed, 585 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentatio=
n/virtual/kvm/devices/vfio.txt
> >> index ef51740c67ca..f95d867168ea 100644
> >> --- a/Documentation/virtual/kvm/devices/vfio.txt
> >> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> >> @@ -16,7 +16,25 @@ Groups:
> >> =20
> >>  KVM_DEV_VFIO_GROUP attributes:
> >>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
> >> +	kvm_device_attr.addr points to an int32_t file descriptor
> >> +	for the VFIO group.
> >>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device tr=
acking
> >> +	kvm_device_attr.addr points to an int32_t file descriptor
> >> +	for the VFIO group.
> >> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE table
> >> +	allocated by sPAPR KVM.
> >> +	kvm_device_attr.addr points to a struct:
> >> =20
> >> -For each, kvm_device_attr.addr points to an int32_t file descriptor
> >> -for the VFIO group.
> >> +	struct kvm_vfio_spapr_tce {
> >> +		__u32	argsz;
> >> +		__u32	flags;
> >> +		__s32	groupfd;
> >> +		__s32	tablefd;
> >> +	};
> >> +
> >> +	where
> >> +	@argsz is the size of kvm_vfio_spapr_tce_liobn;
> >> +	@flags are not supported now, must be zero;
> >> +	@groupfd is a file descriptor for a VFIO group;
> >> +	@tablefd is a file descriptor for a TCE table allocated via
> >> +		KVM_CREATE_SPAPR_TCE.
> >> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/includ=
e/asm/kvm_host.h
> >> index 7bba8f415627..857ae2c6aa39 100644
> >> --- a/arch/powerpc/include/asm/kvm_host.h
> >> +++ b/arch/powerpc/include/asm/kvm_host.h
> >> @@ -191,6 +191,13 @@ struct kvmppc_pginfo {
> >>  	atomic_t refcnt;
> >>  };
> >> =20
> >> +struct kvmppc_spapr_tce_iommu_table {
> >> +	struct rcu_head rcu;
> >> +	struct list_head next;
> >> +	struct vfio_group *group;
> >> +	struct iommu_table *tbl;
> >> +};
> >> +
> >>  struct kvmppc_spapr_tce_table {
> >>  	struct list_head list;
> >>  	struct kvm *kvm;
> >> @@ -199,6 +206,7 @@ struct kvmppc_spapr_tce_table {
> >>  	u32 page_shift;
> >>  	u64 offset;		/* in pages */
> >>  	u64 size;		/* window size in pages */
> >> +	struct list_head iommu_tables;
> >>  	struct page *pages[0];
> >>  };
> >> =20
> >> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include=
/asm/kvm_ppc.h
> >> index 72c2a155641f..66de7e73b3d3 100644
> >> --- a/arch/powerpc/include/asm/kvm_ppc.h
> >> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >> @@ -164,6 +164,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
> >>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
> >>  			struct kvm_memory_slot *memslot, unsigned long porder);
> >>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> >> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tab=
lefd,
> >> +		struct vfio_group *group);
> >> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> >> +		struct vfio_group *group);
> >> =20
> >>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  				struct kvm_create_spapr_tce_64 *args);
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index f5a52ffb6b58..e743cb0d176e 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1088,6 +1088,7 @@ struct kvm_device_attr {
> >>  #define  KVM_DEV_VFIO_GROUP			1
> >>  #define   KVM_DEV_VFIO_GROUP_ADD			1
> >>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> >> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
> >> =20
> >>  enum kvm_device_type {
> >>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> >> @@ -1109,6 +1110,13 @@ enum kvm_device_type {
> >>  	KVM_DEV_TYPE_MAX,
> >>  };
> >> =20
> >> +struct kvm_vfio_spapr_tce {
> >> +	__u32	argsz;
> >> +	__u32	flags;
> >> +	__s32	groupfd;
> >> +	__s32	tablefd;
> >> +};
> >> +
> >>  /*
> >>   * ioctls for VM fds
> >>   */
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3=
s_64_vio.c
> >> index 57dd036bd998..85927f467811 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >> @@ -27,6 +27,10 @@
> >>  #include <linux/hugetlb.h>
> >>  #include <linux/list.h>
> >>  #include <linux/anon_inodes.h>
> >> +#include <linux/iommu.h>
> >> +#include <linux/file.h>
> >> +#include <linux/vfio.h>
> >> +#include <linux/module.h>
> >> =20
> >>  #include <asm/tlbflush.h>
> >>  #include <asm/kvm_ppc.h>
> >> @@ -39,6 +43,36 @@
> >>  #include <asm/udbg.h>
> >>  #include <asm/iommu.h>
> >>  #include <asm/tce.h>
> >> +#include <asm/mmu_context.h>
> >> +
> >> +static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_=
group)
> >> +{
> >> +	void (*fn)(struct vfio_group *);
> >> +
> >> +	fn =3D symbol_get(vfio_group_put_external_user);
> >> +	if (WARN_ON(!fn))
> >> +		return;
> >> +
> >> +	fn(vfio_group);
> >> +
> >> +	symbol_put(vfio_group_put_external_user);
> >> +}
> >> +
> >> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_gr=
oup)
> >> +{
> >> +	int (*fn)(struct vfio_group *);
> >> +	int ret =3D -1;
> >> +
> >> +	fn =3D symbol_get(vfio_external_user_iommu_id);
> >> +	if (!fn)
> >> +		return ret;
> >> +
> >> +	ret =3D fn(vfio_group);
> >> +
> >> +	symbol_put(vfio_external_user_iommu_id);
> >> +
> >> +	return ret;
> >> +}
> >> =20
> >>  static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
> >>  {
> >> @@ -90,6 +124,130 @@ static long kvmppc_account_memlimit(unsigned long=
 stt_pages, bool inc)
> >>  	return ret;
> >>  }
> >> =20
> >> +static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
> >> +{
> >> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(head,
> >> +			struct kvmppc_spapr_tce_iommu_table, rcu);
> >> +
> >> +	iommu_table_put(stit->tbl);
> >> +	kvm_vfio_group_put_external_user(stit->group);
> >> +
> >> +	kfree(stit);
> >> +}
> >> +
> >> +static void kvm_spapr_tce_liobn_release_iommu_group(
> >> +		struct kvmppc_spapr_tce_table *stt,
> >> +		struct vfio_group *group)
> >> +{
> >> +	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
> >> +
> >> +	list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
> >> +		if (group && (stit->group !=3D group))
> >> +			continue;
> >> +
> >> +		list_del_rcu(&stit->next);
> >> +
> >> +		call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
> >> +	}
> >> +}
> >> +
> >> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> >> +		struct vfio_group *group)
> >> +{
> >> +	struct kvmppc_spapr_tce_table *stt;
> >> +
> >> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list)
> >> +		kvm_spapr_tce_liobn_release_iommu_group(stt, group);
> >> +}
> >> +
> >> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tab=
lefd,
> >> +		struct vfio_group *group)
> >> +{
> >> +	struct kvmppc_spapr_tce_table *stt =3D NULL;
> >> +	bool found =3D false;
> >> +	struct iommu_table *tbl =3D NULL;
> >> +	struct iommu_table_group *table_group;
> >> +	long i, ret =3D 0;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> +	struct fd f;
> >> +	int group_id;
> >> +	struct iommu_group *grp;
> >> +
> >> +	group_id =3D kvm_vfio_external_user_iommu_id(group);
> >> +	grp =3D iommu_group_get_by_id(group_id);
> >> +	if (WARN_ON(!grp))
> >> +		return -EIO;
> >> +
> >> +	f =3D fdget(tablefd);
> >> +	if (!f.file) {
> >> +		ret =3D -EBADF;
> >> +		goto put_exit;
> >> +	}
> >> +
> >> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
> >> +		if (stt =3D=3D f.file->private_data) {
> >> +			found =3D true;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	fdput(f);
> >> +
> >> +	if (!found) {
> >> +		ret =3D -EINVAL;
> >> +		goto put_exit;
> >> +	}
> >> +
> >> +	table_group =3D iommu_group_get_iommudata(grp);
> >> +	if (WARN_ON(!table_group)) {
> >> +		ret =3D -EFAULT;
> >> +		goto put_exit;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >> +		struct iommu_table *tbltmp =3D table_group->tables[i];
> >> +
> >> +		if (!tbltmp)
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * Make sure hardware table parameters are exactly the same;
> >> +		 * this is used in the TCE handlers where boundary checks
> >> +		 * use only the first attached table.
> >> +		 */
> >> +		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
> >> +				(tbltmp->it_offset =3D=3D stt->offset) &&
> >> +				(tbltmp->it_size =3D=3D stt->size)) {
> >> +			tbl =3D tbltmp;
> >> +			break;
> >> +		}
> >> +	}
> >> +	if (!tbl) {
> >> +		ret =3D -EINVAL;
> >> +		goto put_exit;
> >> +	}
> >> +
> >> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> >> +		if ((stit->tbl =3D=3D tbl) && (stit->group =3D=3D group)) {
> >> +			ret =3D -EBUSY;
> >> +			goto put_exit;
> >> +		}
> >> +	}
> >> +
> >> +	iommu_table_get(tbl);
> >> +
> >> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> >> +	stit->tbl =3D tbl;
> >> +	stit->group =3D group;
> >> +
> >> +	list_add_rcu(&stit->next, &stt->iommu_tables);
> >> +
> >> +put_exit:
> >> +	iommu_group_put(grp);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static void release_spapr_tce_table(struct rcu_head *head)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> >> @@ -132,6 +290,8 @@ static int kvm_spapr_tce_release(struct inode *ino=
de, struct file *filp)
> >> =20
> >>  	list_del_rcu(&stt->list);
> >> =20
> >> +	kvm_spapr_tce_liobn_release_iommu_group(stt, NULL /* release all */);
> >> +
> >>  	kvm_put_kvm(stt->kvm);
> >> =20
> >>  	kvmppc_account_memlimit(
> >> @@ -182,6 +342,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  	stt->offset =3D args->offset;
> >>  	stt->size =3D size;
> >>  	stt->kvm =3D kvm;
> >> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> >> =20
> >>  	for (i =3D 0; i < npages; i++) {
> >>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> >> @@ -210,11 +371,99 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *k=
vm,
> >>  	return ret;
> >>  }
> >> =20
> >> +static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long e=
ntry)
> >> +{
> >> +	unsigned long hpa =3D 0;
> >> +	enum dma_data_direction dir =3D DMA_NONE;
> >> +
> >> +	iommu_tce_xchg(tbl, entry, &hpa, &dir);
> >> +}
> >> +
> >> +static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +
> >> +	if (WARN_ON_ONCE(!pua))
> >> +		return H_HARDWARE;
> >> +
> >> +	mem =3D mm_iommu_lookup(kvm->mm, *pua, pgsize);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >> +
> >> +	mm_iommu_mapped_dec(mem);
> >> +
> >> +	*pua =3D 0;
> >> +
> >> +	return H_SUCCESS;
> >> +}
> >> +
> >> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	enum dma_data_direction dir =3D DMA_NONE;
> >> +	unsigned long hpa =3D 0;
> >> +	long ret;
> >> +
> >> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
> >> +		return H_HARDWARE;
> >> +
> >> +	if (dir =3D=3D DMA_NONE)
> >> +		return H_SUCCESS;
> >> +
> >> +	ret =3D kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> >> +	if (ret !=3D H_SUCCESS)
> >> +		iommu_tce_xchg(tbl, entry, &hpa, &dir);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> >> +		unsigned long entry, unsigned long ua,
> >> +		enum dma_data_direction dir)
> >> +{
> >> +	long ret;
> >> +	unsigned long hpa, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +	struct mm_iommu_table_group_mem_t *mem;
> >> +
> >> +	if (!pua)
> >> +		/* it_userspace allocation might be delayed */
> >> +		return H_TOO_HARD;
> >> +
> >> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >=20
> > IIUC this is the virtual mode path, not the real mode patch.  Under
> > what circumstances could qemu succeed that KVM virtual mode couldn't,
> > for either of the above failures?
>=20
> The (!pua) failure is handled in tce_iommu_build_v2() from
> drivers/vfio/vfio_iommu_spapr_tce.c as:
>=20
>=20
> if (!tbl->it_userspace) {
>        ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
>        if (ret)
>               return ret;
> }

Ah.. which is called from the ioctl() path but not the KVM hcall path,
ok, I get it.

> The (!mem) can succeed if the container is in VFIO_SPAPR_TCE_IOMMU mode
> (not VFIO_SPAPR_TCE_v2_IOMMU). Remember that the userspace can call
> ioctl(vfio_kvm_device, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE) without having
> memory preregistered so tables will appear in the
> kvmppc_spapr_tce_iommu_table list in KVM.

Ok.  So in short, the userspace->ioctl() path will handle both v1 and
v2 versions of the IOMMU interface, whereas the in-kernel
implementation (both real and virtual) will only handle v2.  Is that
right?

> >> +
> >> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
> >> +		return H_HARDWARE;
> >> +
> >> +	if (mm_iommu_mapped_inc(mem))
> >> +		return H_CLOSED;
> >> +
> >> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> >> +	if (ret) {
> >=20
> > It thought the xchg could basically never fail, so this should be
> > another WARN_ON().
>=20
>=20
> Correct.
>=20
>=20
> >> +		mm_iommu_mapped_dec(mem);
> >> +		return H_TOO_HARD;
> >> +	}
> >> +
> >> +	if (dir !=3D DMA_NONE)
> >> +		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> >> +
> >> +	*pua =3D ua;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>  		      unsigned long ioba, unsigned long tce)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >> -	long ret;
> >> +	long ret, idx;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> +	unsigned long entry, ua =3D 0;
> >> +	enum dma_data_direction dir;
> >> =20
> >>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx=
\n", */
> >>  	/* 	    liobn, ioba, tce); */
> >> @@ -231,7 +480,35 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
> >>  	if (ret !=3D H_SUCCESS)
> >>  		return ret;
> >> =20
> >> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> >> +	dir =3D iommu_tce_direction(tce);
> >> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> >> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> >> +		return H_PARAMETER;
> >> +
> >> +	entry =3D ioba >> stt->page_shift;
> >> +
> >> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +		if (dir =3D=3D DMA_NONE) {
> >> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> >> +					stit->tbl, entry);
> >> +		} else {
> >> +			idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> >> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
> >> +					entry, ua, dir);
> >> +			srcu_read_unlock(&vcpu->kvm->srcu, idx);
> >> +		}
> >> +
> >> +		if (ret =3D=3D H_SUCCESS)
> >> +			continue;
> >> +
> >> +		if (ret =3D=3D H_TOO_HARD)
> >> +			return ret;
> >> +
> >> +		WARN_ON_ONCE(1);
> >> +		kvmppc_clear_tce(stit->tbl, entry);
> >> +	}
> >> +
> >> +	kvmppc_tce_put(stt, entry, tce);
> >> =20
> >>  	return H_SUCCESS;
> >>  }
> >> @@ -246,6 +523,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
> >>  	unsigned long entry, ua =3D 0;
> >>  	u64 __user *tces;
> >>  	u64 tce;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -284,6 +562,26 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> =20
> >> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
> >> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> >> +				&ua, NULL))
> >> +			return H_PARAMETER;
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
> >> +					stit->tbl, entry + i, ua,
> >> +					iommu_tce_direction(tce));
> >> +
> >> +			if (ret =3D=3D H_SUCCESS)
> >> +				continue;
> >> +
> >> +			if (ret =3D=3D H_TOO_HARD)
> >> +				goto unlock_exit;
> >> +
> >> +			WARN_ON_ONCE(1);
> >> +			kvmppc_clear_tce(stit->tbl, entry);
> >> +		}
> >> +
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >> =20
> >> @@ -300,6 +598,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -313,6 +612,24 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>  		return H_PARAMETER;
> >> =20
> >> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> >> +
> >> +		for (i =3D 0; i < npages; ++i) {
> >> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> >> +					stit->tbl, entry + i);
> >> +
> >> +			if (ret =3D=3D H_SUCCESS)
> >> +				continue;
> >> +
> >> +			if (ret =3D=3D H_TOO_HARD)
> >> +				return ret;
> >> +
> >> +			WARN_ON_ONCE(1);
> >> +			kvmppc_clear_tce(stit->tbl, entry);
> >> +		}
> >> +	}
> >> +
> >>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> >>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> >> =20
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/bo=
ok3s_64_vio_hv.c
> >> index 440d3ab5dc32..3ad06badc552 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> @@ -161,11 +161,108 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned=
 long gpa,
> >>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >> =20
> >>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >> +static void kvmppc_rm_clear_tce(struct iommu_table *tbl, unsigned lon=
g entry)
> >> +{
> >> +	unsigned long hpa =3D 0;
> >> +	enum dma_data_direction dir =3D DMA_NONE;
> >> +
> >> +	iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> >> +}
> >> +
> >> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +
> >> +	if (WARN_ON_ONCE(!pua))
> >> +		return H_HARDWARE;
> >=20
> > So.. I know I encouraged WARN_ON()s, but is it safe to call WARN_ON()
> > from real mode?
>=20
> Ouch. Tried WARN_ON_ONCE(1) in kvmppc_rm_h_stuff_tce() and got "rcu_sched
> detected stalls" straight away.

Bother.  Sorry I didn't think of that earlier.

> What do I replace it with, in documenting purposes?
>=20
> -	if (WARN_ON_ONCE(!pua))
> +       if (!pua) /* Not expected to fail */

So, I'd suggest adding a WARN_ON_RM() or whatever macro to wrap this
at least.  As you may have seen I discussed this with mpe on IRC and
printk() should work, so you could just put a printk() and
dump_stack() in there.

> >> +
> >> +	pua =3D (void *) vmalloc_to_phys(pua);
> >> +	if (!pua)
> >> +		return H_TOO_HARD;
> >> +
> >> +	mem =3D mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >> +
> >> +	mm_iommu_mapped_dec(mem);
> >> +
> >> +	*pua =3D 0;
> >> +
> >> +	return H_SUCCESS;
> >> +}
> >> +
> >> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	enum dma_data_direction dir =3D DMA_NONE;
> >> +	unsigned long hpa =3D 0;
> >> +	long ret;
> >> +
> >> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> >> +		return H_HARDWARE;
> >> +
> >> +	if (dir =3D=3D DMA_NONE)
> >> +		return H_SUCCESS;
> >> +
> >> +	ret =3D kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
> >> +	if (ret)
> >> +		iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_tab=
le *tbl,
> >> +		unsigned long entry, unsigned long ua,
> >> +		enum dma_data_direction dir)
> >> +{
> >> +	long ret;
> >> +	unsigned long hpa =3D 0;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +	struct mm_iommu_table_group_mem_t *mem;
> >> +
> >> +	if (!pua)
> >> +		/* it_userspace allocation might be delayed */
> >> +		return H_TOO_HARD;
> >> +
> >> +	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >> +
> >> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
> >> +		return H_HARDWARE;
> >> +
> >> +	pua =3D (void *) vmalloc_to_phys(pua);
> >> +	if (WARN_ON_ONCE(!pua))
> >> +		return H_HARDWARE;
> >> +
> >> +	if (WARN_ON_ONCE(mm_iommu_mapped_inc(mem)))
> >> +		return H_CLOSED;
> >> +
> >> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> >> +	if (ret) {
> >> +		mm_iommu_mapped_dec(mem);
> >> +		return H_TOO_HARD;
> >> +	}
> >> +
> >> +	if (dir !=3D DMA_NONE)
> >> +		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
> >> +
> >> +	*pua =3D ua;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>  		unsigned long ioba, unsigned long tce)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> +	unsigned long entry, ua =3D 0;
> >> +	enum dma_data_direction dir;
> >> =20
> >>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx=
\n", */
> >>  	/* 	    liobn, ioba, tce); */
> >> @@ -182,7 +279,32 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, u=
nsigned long liobn,
> >>  	if (ret !=3D H_SUCCESS)
> >>  		return ret;
> >> =20
> >> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> >> +	dir =3D iommu_tce_direction(tce);
> >> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> >> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> >> +		return H_PARAMETER;
> >> +
> >> +	entry =3D ioba >> stt->page_shift;
> >> +
> >> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +		if (dir =3D=3D DMA_NONE)
> >> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> >> +					stit->tbl, entry);
> >> +		else
> >> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> >> +					stit->tbl, entry, ua, dir);
> >> +
> >> +		if (ret =3D=3D H_SUCCESS)
> >> +			continue;
> >> +
> >> +		if (ret =3D=3D H_TOO_HARD)
> >> +			return ret;
> >> +
> >> +		WARN_ON_ONCE(1);
> >> +		kvmppc_rm_clear_tce(stit->tbl, entry);
> >> +	}
> >> +
> >> +	kvmppc_tce_put(stt, entry, tce);
> >> =20
> >>  	return H_SUCCESS;
> >>  }
> >> @@ -223,6 +345,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
> >>  	unsigned long tces, entry, ua =3D 0;
> >>  	unsigned long *rmap =3D NULL;
> >>  	bool prereg =3D false;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -293,6 +416,27 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> =20
> >> +		ua =3D 0;
> >> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
> >> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> >> +				&ua, NULL))
> >> +			return H_PARAMETER;
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> >> +					stit->tbl, entry + i, ua,
> >> +					iommu_tce_direction(tce));
> >> +
> >> +			if (ret =3D=3D H_SUCCESS)
> >> +				continue;
> >> +
> >> +			if (ret =3D=3D H_TOO_HARD)
> >> +				goto unlock_exit;
> >> +
> >> +			WARN_ON_ONCE(1);
> >> +			kvmppc_rm_clear_tce(stit->tbl, entry);
> >> +		}
> >> +
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >> =20
> >> @@ -309,6 +453,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -322,6 +467,24 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>  		return H_PARAMETER;
> >> =20
> >> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> >> +
> >> +		for (i =3D 0; i < npages; ++i) {
> >> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> >> +					stit->tbl, entry + i);
> >> +
> >> +			if (ret =3D=3D H_SUCCESS)
> >> +				continue;
> >> +
> >> +			if (ret =3D=3D H_TOO_HARD)
> >> +				return ret;
> >> +
> >> +			WARN_ON_ONCE(1);
> >> +			kvmppc_rm_clear_tce(stit->tbl, entry);
> >> +		}
> >> +	}
> >> +
> >>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> >>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> >> =20
> >> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> >> index 2b38d824e9e5..2bb01c8236fa 100644
> >> --- a/arch/powerpc/kvm/powerpc.c
> >> +++ b/arch/powerpc/kvm/powerpc.c
> >> @@ -537,6 +537,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
> >>  #ifdef CONFIG_PPC_BOOK3S_64
> >>  	case KVM_CAP_SPAPR_TCE:
> >>  	case KVM_CAP_SPAPR_TCE_64:
> >> +		/* fallthrough */
> >> +	case KVM_CAP_SPAPR_TCE_VFIO:
> >>  	case KVM_CAP_PPC_RTAS:
> >>  	case KVM_CAP_PPC_FIXUP_HCALL:
> >>  	case KVM_CAP_PPC_ENABLE_HCALL:
> >> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> >> index d32f239eb471..2b7dc22265fe 100644
> >> --- a/virt/kvm/vfio.c
> >> +++ b/virt/kvm/vfio.c
> >> @@ -20,6 +20,10 @@
> >>  #include <linux/vfio.h>
> >>  #include "vfio.h"
> >> =20
> >> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >> +#include <asm/kvm_ppc.h>
> >> +#endif
> >> +
> >>  struct kvm_vfio_group {
> >>  	struct list_head node;
> >>  	struct vfio_group *vfio_group;
> >> @@ -211,6 +215,9 @@ static int kvm_vfio_set_group(struct kvm_device *d=
ev, long attr, u64 arg)
> >> =20
> >>  		mutex_unlock(&kv->lock);
> >> =20
> >> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >> +		kvm_spapr_tce_release_iommu_group(dev->kvm, vfio_group);
> >> +#endif
> >>  		kvm_vfio_group_set_kvm(vfio_group, NULL);
> >> =20
> >>  		kvm_vfio_group_put_external_user(vfio_group);
> >> @@ -218,6 +225,53 @@ static int kvm_vfio_set_group(struct kvm_device *=
dev, long attr, u64 arg)
> >>  		kvm_vfio_update_coherency(dev);
> >> =20
> >>  		return ret;
> >> +
> >> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
> >> +		struct kvm_vfio_spapr_tce param;
> >> +		unsigned long minsz;
> >> +		struct kvm_vfio *kv =3D dev->private;
> >> +		struct vfio_group *vfio_group;
> >> +		struct kvm_vfio_group *kvg;
> >> +		struct fd f;
> >> +
> >> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce, tablefd);
> >> +
> >> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> >> +			return -EFAULT;
> >> +
> >> +		if (param.argsz < minsz || param.flags)
> >> +			return -EINVAL;
> >> +
> >> +		f =3D fdget(param.groupfd);
> >> +		if (!f.file)
> >> +			return -EBADF;
> >> +
> >> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
> >> +		fdput(f);
> >> +
> >> +		if (IS_ERR(vfio_group))
> >> +			return PTR_ERR(vfio_group);
> >> +
> >> +		ret =3D -ENOENT;
> >> +
> >> +		mutex_lock(&kv->lock);
> >> +
> >> +		list_for_each_entry(kvg, &kv->group_list, node) {
> >> +			if (kvg->vfio_group !=3D vfio_group)
> >> +				continue;
> >> +
> >> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
> >> +					param.tablefd, vfio_group);
> >> +
> >> +			break;
> >> +		}
> >> +
> >> +		mutex_unlock(&kv->lock);
> >> +
> >> +		return ret;
> >> +	}
> >> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
> >>  	}
> >> =20
> >>  	return -ENXIO;
> >> @@ -242,6 +296,9 @@ static int kvm_vfio_has_attr(struct kvm_device *de=
v,
> >>  		switch (attr->attr) {
> >>  		case KVM_DEV_VFIO_GROUP_ADD:
> >>  		case KVM_DEV_VFIO_GROUP_DEL:
> >> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
> >> +#endif
> >>  			return 0;
> >>  		}
> >> =20
> >> @@ -257,6 +314,9 @@ static void kvm_vfio_destroy(struct kvm_device *de=
v)
> >>  	struct kvm_vfio_group *kvg, *tmp;
> >> =20
> >>  	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
> >> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> >> +		kvm_spapr_tce_release_iommu_group(dev->kvm, kvg->vfio_group);
> >> +#endif
> >>  		kvm_vfio_group_set_kvm(kvg->vfio_group, NULL);
> >>  		kvm_vfio_group_put_external_user(kvg->vfio_group);
> >>  		list_del(&kvg->node);
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvOX8AAoJEGw4ysog2bOSjoUP/1fUTeGkxju9xsqLUkM9Nz5P
aZSH8UNfOKSOg4ZJvKCRzXhuF6feqva4gq9vN+n6O1wTCWjYg9qepewhr7//72rC
U4NtIjY2njxawIuqD2spVeDBMsiCbHkunrVpBe8H1KjD+Zn2GaeqBJtGJ9mYNfoh
cuDXS1vgW/uC6h2jPbkCgsTBHk80+cfzZoJuLcjGCOqS08/KdbZ2dLR7dTyyCz0E
3ABvkCURdGV4L7zpdXTFGix7C5n8l1qHYzz10LRyE2Gk+ZdHptGKjcBZ3m/retD9
9oLriUNMlMZ2hljKPCjxqgDPQJ1FbXbOPgPefX9MRrDTu7ED1G6UqnBfux/z/VxE
1AUOahcuRAzuCYHW/LpsCWFFaYOFJ5wdbC3l59vqiiTPpNE7mQ9LrDYWkO7OX34h
JbUzmAmQ+FFeBxQs2cm2mlttxR+E01b1lABq+iwL08tUBJ4v+pzR4+n3pw65tZd5
HoqHOd+H5iprZPQTPvy2Yw4gUVAcGDVrFOgjiQpP+wjJtJ+WjN2wGCREOj9SHF+C
95W2n+6gjhncYJoVCbcig1okc3FjJkoSFh2jj0vabGJaXjPpLqlp1N1VCUoB1eLG
MIIgHpVFmoMxG1EVSItQmgsOz3No7LxB0TzQtLWKUH3hMMf4TT+3WPwRD1XJ+K0k
RDiUjLBhRC1Bn5BfHfmj
=Vy4+
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
