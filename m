Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrymg6ChnzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 13:35:15 +1100 (AEDT)
Date: Mon, 27 Mar 2017 13:35:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v11 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170327023505.GS19078@umbus.fritz.box>
References: <20170322042156.11756-1-aik@ozlabs.ru>
 <20170322042156.11756-11-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
In-Reply-To: <20170322042156.11756-11-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 03:21:56PM +1100, Alexey Kardashevskiy wrote:
> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
> without passing them to user space which saves time on switching
> to user space and back.
>=20
> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
> KVM tries to handle a TCE request in the real mode, if failed
> it passes the request to the virtual mode to complete the operation.
> If it a virtual mode handler fails, the request is passed to
> the user space; this is not expected to happen though.
>=20
> To avoid dealing with page use counters (which is tricky in real mode),
> this only accelerates SPAPR TCE IOMMU v2 clients which are required
> to pre-register the userspace memory. The very first TCE request will
> be handled in the VFIO SPAPR TCE driver anyway as the userspace view
> of the TCE table (iommu_table::it_userspace) is not allocated till
> the very first mapping happens and we cannot call vmalloc in real mode.
>=20
> If we fail to update a hardware IOMMU table unexpected reason, we just
> clear it and move on as there is nothing really we can do about it -
> for example, if we hot plug a VFIO device to a guest, existing TCE tables
> will be mirrored automatically to the hardware and there is no interface
> to report to the guest about possible failures.
>=20
> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
> and associates a physical IOMMU table with the SPAPR TCE table (which
> is a guest view of the hardware IOMMU table). The iommu_table object
> is cached and referenced so we do not have to look up for it in real mode.
>=20
> This does not implement the UNSET counterpart as there is no use for it -
> once the acceleration is enabled, the existing userspace won't
> disable it unless a VFIO container is destroyed; this adds necessary
> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
>=20
> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
> space.
>=20
> This adds real mode version of WARN_ON_ONCE() as the generic version
> causes problems with rcu_sched. Since we testing what vmalloc_to_phys()
> returns in the code, this also adds a check for already existing
> vmalloc_to_phys() call in kvmppc_rm_h_put_tce_indirect().
>=20
> This finally makes use of vfio_external_user_iommu_id() which was
> introduced quite some time ago and was considered for removal.
>=20
> Tests show that this patch increases transmission speed from 220MB/s
> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v11:
> * fixed vfio_group reference leak in KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE
> handler
>=20
> v10:
> * fixed leaking references in virt/kvm/vfio.c
> * moved code to helpers - kvm_vfio_group_get_iommu_group, kvm_spapr_tce_r=
elease_vfio_group
> * fixed possible race between referencing table and destroying it via
> VFIO add/remove window ioctls()
>=20
> v9:
> * removed referencing a group in KVM, only referencing iommu_table's now
> * fixed a reference leak in KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE handler
> * fixed typo in vfio.txt
> * removed @argsz and @flags from struct kvm_vfio_spapr_tce
>=20
> v8:
> * changed all (!pua) checks to return H_TOO_HARD as ioctl() is supposed
> to handle them
> * changed vmalloc_to_phys() callers to return H_HARDWARE
> * changed real mode iommu_tce_xchg_rm() callers to return H_TOO_HARD
> and added a comment about this in the code
> * changed virtual mode iommu_tce_xchg() callers to return H_HARDWARE
> and do WARN_ON
> * added WARN_ON_ONCE_RM(!rmap) in kvmppc_rm_h_put_tce_indirect() to
> have all vmalloc_to_phys() callsites covered
>=20
> v7:
> * added realmode-friendly WARN_ON_ONCE_RM
>=20
> v6:
> * changed handling of errors returned by kvmppc_(rm_)tce_iommu_(un)map()
> * moved kvmppc_gpa_to_ua() to TCE validation
>=20
> v5:
> * changed error codes in multiple places
> * added bunch of WARN_ON() in places which should not really happen
> * adde a check that an iommu table is not attached already to LIOBN
> * dropped explicit calls to iommu_tce_clear_param_check/
> iommu_tce_put_param_check as kvmppc_tce_validate/kvmppc_ioba_validate
> call them anyway (since the previous patch)
> * if we fail to update a hardware IOMMU table for unexpected reason,
> this just clears the entry
>=20
> v4:
> * added note to the commit log about allowing multiple updates of
> the same IOMMU table;
> * instead of checking for if any memory was preregistered, this
> returns H_TOO_HARD if a specific page was not;
> * fixed comments from v3 about error handling in many places;
> * simplified TCE handlers and merged IOMMU parts inline - for example,
> there used to be kvmppc_h_put_tce_iommu(), now it is merged into
> kvmppc_h_put_tce(); this allows to check IOBA boundaries against
> the first attached table only (makes the code simpler);
>=20
> v3:
> * simplified not to use VFIO group notifiers
> * reworked cleanup, should be cleaner/simpler now
>=20
> v2:
> * reworked to use new VFIO notifiers
> * now same iommu_table may appear in the list several times, to be fixed =
later
> ---
>  Documentation/virtual/kvm/devices/vfio.txt |  18 +-
>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>  include/uapi/linux/kvm.h                   |   6 +
>  arch/powerpc/kvm/book3s_64_vio.c           | 301 +++++++++++++++++++++++=
+++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 201 ++++++++++++++++++-
>  arch/powerpc/kvm/powerpc.c                 |   2 +
>  virt/kvm/vfio.c                            | 105 ++++++++++
>  8 files changed, 640 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/v=
irtual/kvm/devices/vfio.txt
> index ef51740c67ca..528c77c8022c 100644
> --- a/Documentation/virtual/kvm/devices/vfio.txt
> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> @@ -16,7 +16,21 @@ Groups:
> =20
>  KVM_DEV_VFIO_GROUP attributes:
>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.
>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device track=
ing
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.
> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE table
> +	allocated by sPAPR KVM.
> +	kvm_device_attr.addr points to a struct:
> =20
> -For each, kvm_device_attr.addr points to an int32_t file descriptor
> -for the VFIO group.
> +	struct kvm_vfio_spapr_tce {
> +		__s32	groupfd;
> +		__s32	tablefd;
> +	};
> +
> +	where
> +	@groupfd is a file descriptor for a VFIO group;
> +	@tablefd is a file descriptor for a TCE table allocated via
> +		KVM_CREATE_SPAPR_TCE.
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 7bba8f415627..178074e643e5 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -191,6 +191,13 @@ struct kvmppc_pginfo {
>  	atomic_t refcnt;
>  };
> =20
> +struct kvmppc_spapr_tce_iommu_table {
> +	struct rcu_head rcu;
> +	struct list_head next;
> +	struct iommu_table *tbl;
> +	struct kref kref;
> +};
> +
>  struct kvmppc_spapr_tce_table {
>  	struct list_head list;
>  	struct kvm *kvm;
> @@ -199,6 +206,7 @@ struct kvmppc_spapr_tce_table {
>  	u32 page_shift;
>  	u64 offset;		/* in pages */
>  	u64 size;		/* window size in pages */
> +	struct list_head iommu_tables;
>  	struct page *pages[0];
>  };
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 72c2a155641f..cfd45714189e 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -164,6 +164,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  			struct kvm_memory_slot *memslot, unsigned long porder);
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablef=
d,
> +		struct iommu_group *grp);
> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> +		struct iommu_group *grp);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f5a52ffb6b58..0f8a5e6528aa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1088,6 +1088,7 @@ struct kvm_device_attr {
>  #define  KVM_DEV_VFIO_GROUP			1
>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
> =20
>  enum kvm_device_type {
>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> @@ -1109,6 +1110,11 @@ enum kvm_device_type {
>  	KVM_DEV_TYPE_MAX,
>  };
> =20
> +struct kvm_vfio_spapr_tce {
> +	__s32	groupfd;
> +	__s32	tablefd;
> +};
> +
>  /*
>   * ioctls for VM fds
>   */
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index e96a4590464c..22c67a47eaab 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -28,6 +28,8 @@
>  #include <linux/hugetlb.h>
>  #include <linux/list.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/iommu.h>
> +#include <linux/file.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/kvm_ppc.h>
> @@ -40,6 +42,7 @@
>  #include <asm/udbg.h>
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/mmu_context.h>
> =20
>  static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
>  {
> @@ -91,6 +94,132 @@ static long kvmppc_account_memlimit(unsigned long stt=
_pages, bool inc)
>  	return ret;
>  }
> =20
> +static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
> +{
> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(head,
> +			struct kvmppc_spapr_tce_iommu_table, rcu);
> +
> +	iommu_tce_table_put(stit->tbl);
> +
> +	kfree(stit);
> +}
> +
> +static void kvm_spapr_tce_liobn_put(struct kref *kref)
> +{
> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(kref,
> +			struct kvmppc_spapr_tce_iommu_table, kref);
> +
> +	list_del_rcu(&stit->next);
> +
> +	call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
> +}
> +
> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> +		struct iommu_group *grp)
> +{
> +	int i;
> +	struct kvmppc_spapr_tce_table *stt;
> +	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
> +	struct iommu_table_group *table_group =3D NULL;
> +
> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
> +
> +		table_group =3D iommu_group_get_iommudata(grp);
> +		if (WARN_ON(!table_group))
> +			continue;
> +
> +		list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
> +			for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +				if (table_group->tables[i] !=3D stit->tbl)
> +					continue;
> +
> +				kref_put(&stit->kref, kvm_spapr_tce_liobn_put);
> +				return;
> +			}
> +		}
> +	}
> +}
> +
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablef=
d,
> +		struct iommu_group *grp)
> +{
> +	struct kvmppc_spapr_tce_table *stt =3D NULL;
> +	bool found =3D false;
> +	struct iommu_table *tbl =3D NULL;
> +	struct iommu_table_group *table_group;
> +	long i;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	struct fd f;
> +
> +	f =3D fdget(tablefd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
> +		if (stt =3D=3D f.file->private_data) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	fdput(f);
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	table_group =3D iommu_group_get_iommudata(grp);
> +	if (WARN_ON(!table_group))
> +		return -EFAULT;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbltmp =3D table_group->tables[i];
> +
> +		if (!tbltmp)
> +			continue;
> +		/*
> +		 * Make sure hardware table parameters are exactly the same;
> +		 * this is used in the TCE handlers where boundary checks
> +		 * use only the first attached table.
> +		 */
> +		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
> +				(tbltmp->it_offset =3D=3D stt->offset) &&
> +				(tbltmp->it_size =3D=3D stt->size)) {
> +			/*
> +			 * Reference the table to avoid races with
> +			 * add/remove DMA windows.
> +			 */
> +			tbl =3D iommu_tce_table_get(tbltmp);
> +			break;
> +		}
> +	}
> +	if (!tbl)
> +		return -EINVAL;
> +
> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> +		if (tbl !=3D stit->tbl)
> +			continue;
> +
> +		if (!kref_get_unless_zero(&stit->kref)) {
> +			/* stit is being destroyed */
> +			iommu_tce_table_put(tbl);
> +			return -ENOTTY;
> +		}
> +		/*
> +		 * The table is already known to this KVM, we just increased
> +		 * its KVM reference counter and can return.
> +		 */
> +		return 0;
> +	}
> +
> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> +	stit->tbl =3D tbl;
> +	kref_init(&stit->kref);
> +
> +	list_add_rcu(&stit->next, &stt->iommu_tables);
> +
> +	return 0;
> +}
> +
>  static void release_spapr_tce_table(struct rcu_head *head)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> @@ -130,9 +259,18 @@ static int kvm_spapr_tce_mmap(struct file *file, str=
uct vm_area_struct *vma)
>  static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D filp->private_data;
> +	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
> =20
>  	list_del_rcu(&stt->list);
> =20
> +	list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
> +		WARN_ON(!kref_read(&stit->kref));
> +		while (1) {
> +			if (kref_put(&stit->kref, kvm_spapr_tce_liobn_put))
> +				break;
> +		}
> +	}
> +
>  	kvm_put_kvm(stt->kvm);
> =20
>  	kvmppc_account_memlimit(
> @@ -183,6 +321,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->offset =3D args->offset;
>  	stt->size =3D size;
>  	stt->kvm =3D kvm;
> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> =20
>  	for (i =3D 0; i < npages; i++) {
>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> @@ -211,11 +350,101 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	return ret;
>  }
> =20
> +static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entr=
y)
> +{
> +	unsigned long hpa =3D 0;
> +	enum dma_data_direction dir =3D DMA_NONE;
> +
> +	iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +}
> +
> +static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	mem =3D mm_iommu_lookup(kvm->mm, *pua, pgsize);
> +	if (!mem)
> +		return H_TOO_HARD;
> +
> +	mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	enum dma_data_direction dir =3D DMA_NONE;
> +	unsigned long hpa =3D 0;
> +	long ret;
> +
> +	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
> +		return H_HARDWARE;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	ret =3D kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> +	if (ret !=3D H_SUCCESS)
> +		iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +
> +	return ret;
> +}
> +
> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long ua,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
> +		return H_TOO_HARD;
> +
> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_mapped_inc(mem))
> +		return H_CLOSED;
> +
> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +	if (WARN_ON_ONCE(ret)) {
> +		mm_iommu_mapped_dec(mem);
> +		return H_HARDWARE;
> +	}
> +
> +	if (dir !=3D DMA_NONE)
> +		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> +
> +	*pua =3D ua;
> +
> +	return 0;
> +}
> +
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt;
> -	long ret;
> +	long ret, idx;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	unsigned long entry, ua =3D 0;
> +	enum dma_data_direction dir;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -232,7 +461,35 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> +	dir =3D iommu_tce_direction(tce);
> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> +		return H_PARAMETER;
> +
> +	entry =3D ioba >> stt->page_shift;
> +
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		if (dir =3D=3D DMA_NONE) {
> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> +					stit->tbl, entry);
> +		} else {
> +			idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
> +					entry, ua, dir);
> +			srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +		}
> +
> +		if (ret =3D=3D H_SUCCESS)
> +			continue;
> +
> +		if (ret =3D=3D H_TOO_HARD)
> +			return ret;
> +
> +		WARN_ON_ONCE(1);
> +		kvmppc_clear_tce(stit->tbl, entry);
> +	}
> +
> +	kvmppc_tce_put(stt, entry, tce);
> =20
>  	return H_SUCCESS;
>  }
> @@ -247,6 +504,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	unsigned long entry, ua =3D 0;
>  	u64 __user *tces;
>  	u64 tce;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -285,6 +543,26 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> =20
> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> +				&ua, NULL))
> +			return H_PARAMETER;
> +
> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
> +					stit->tbl, entry + i, ua,
> +					iommu_tce_direction(tce));
> +
> +			if (ret =3D=3D H_SUCCESS)
> +				continue;
> +
> +			if (ret =3D=3D H_TOO_HARD)
> +				goto unlock_exit;
> +
> +			WARN_ON_ONCE(1);
> +			kvmppc_clear_tce(stit->tbl, entry);
> +		}
> +
>  		kvmppc_tce_put(stt, entry + i, tce);
>  	}
> =20
> @@ -301,6 +579,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -314,6 +593,24 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> +
> +		for (i =3D 0; i < npages; ++i) {
> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> +					stit->tbl, entry + i);
> +
> +			if (ret =3D=3D H_SUCCESS)
> +				continue;
> +
> +			if (ret =3D=3D H_TOO_HARD)
> +				return ret;
> +
> +			WARN_ON_ONCE(1);
> +			kvmppc_clear_tce(stit->tbl, entry);
> +		}
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 440d3ab5dc32..eda0a8f6fae8 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -40,6 +40,31 @@
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> =20
> +#ifdef CONFIG_BUG
> +
> +#define WARN_ON_ONCE_RM(condition)	({			\
> +	static bool __section(.data.unlikely) __warned;		\
> +	int __ret_warn_once =3D !!(condition);			\
> +								\
> +	if (unlikely(__ret_warn_once && !__warned)) {		\
> +		__warned =3D true;				\
> +		pr_err("WARN_ON_ONCE_RM: (%s) at %s:%u\n",	\
> +				__stringify(condition),		\
> +				__func__, __LINE__);		\
> +		dump_stack();					\
> +	}							\
> +	unlikely(__ret_warn_once);				\
> +})
> +
> +#else
> +
> +#define WARN_ON_ONCE_RM(condition) ({				\
> +	int __ret_warn_on =3D !!(condition);			\
> +	unlikely(__ret_warn_on);				\
> +})
> +
> +#endif
> +
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
>  /*
> @@ -161,11 +186,117 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned lo=
ng gpa,
>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +static void kvmppc_rm_clear_tce(struct iommu_table *tbl, unsigned long e=
ntry)
> +{
> +	unsigned long hpa =3D 0;
> +	enum dma_data_direction dir =3D DMA_NONE;
> +
> +	iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +}
> +
> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (WARN_ON_ONCE_RM(!pua))
> +		return H_HARDWARE;
> +
> +	mem =3D mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
> +	if (!mem)
> +		return H_TOO_HARD;
> +
> +	mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	enum dma_data_direction dir =3D DMA_NONE;
> +	unsigned long hpa =3D 0;
> +	long ret;
> +
> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> +		/*
> +		 * real mode xchg can fail if struct page crosses
> +		 * a page boundary
> +		 */
> +		return H_TOO_HARD;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	ret =3D kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
> +	if (ret)
> +		iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +
> +	return ret;
> +}
> +
> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_table =
*tbl,
> +		unsigned long entry, unsigned long ua,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa =3D 0;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		return H_TOO_HARD;
> +
> +	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
> +		return H_HARDWARE;
> +
> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (WARN_ON_ONCE_RM(!pua))
> +		return H_HARDWARE;
> +
> +	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
> +		return H_CLOSED;
> +
> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +	if (ret) {
> +		mm_iommu_mapped_dec(mem);
> +		/*
> +		 * real mode xchg can fail if struct page crosses
> +		 * a page boundary
> +		 */
> +		return H_TOO_HARD;
> +	}
> +
> +	if (dir !=3D DMA_NONE)
> +		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
> +
> +	*pua =3D ua;
> +
> +	return 0;
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	unsigned long entry, ua =3D 0;
> +	enum dma_data_direction dir;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -182,7 +313,32 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> +	dir =3D iommu_tce_direction(tce);
> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> +		return H_PARAMETER;
> +
> +	entry =3D ioba >> stt->page_shift;
> +
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		if (dir =3D=3D DMA_NONE)
> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> +					stit->tbl, entry);
> +		else
> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> +					stit->tbl, entry, ua, dir);
> +
> +		if (ret =3D=3D H_SUCCESS)
> +			continue;
> +
> +		if (ret =3D=3D H_TOO_HARD)
> +			return ret;
> +
> +		WARN_ON_ONCE_RM(1);
> +		kvmppc_rm_clear_tce(stit->tbl, entry);
> +	}
> +
> +	kvmppc_tce_put(stt, entry, tce);
> =20
>  	return H_SUCCESS;
>  }
> @@ -223,6 +379,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	unsigned long tces, entry, ua =3D 0;
>  	unsigned long *rmap =3D NULL;
>  	bool prereg =3D false;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -270,6 +427,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  			return H_TOO_HARD;
> =20
>  		rmap =3D (void *) vmalloc_to_phys(rmap);
> +		if (WARN_ON_ONCE_RM(!rmap))
> +			return H_HARDWARE;
> =20
>  		/*
>  		 * Synchronize with the MMU notifier callbacks in
> @@ -293,6 +452,27 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> =20
> +		ua =3D 0;
> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> +				&ua, NULL))
> +			return H_PARAMETER;
> +
> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> +					stit->tbl, entry + i, ua,
> +					iommu_tce_direction(tce));
> +
> +			if (ret =3D=3D H_SUCCESS)
> +				continue;
> +
> +			if (ret =3D=3D H_TOO_HARD)
> +				goto unlock_exit;
> +
> +			WARN_ON_ONCE_RM(1);
> +			kvmppc_rm_clear_tce(stit->tbl, entry);
> +		}
> +
>  		kvmppc_tce_put(stt, entry + i, tce);
>  	}
> =20
> @@ -309,6 +489,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -322,6 +503,24 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> +
> +		for (i =3D 0; i < npages; ++i) {
> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> +					stit->tbl, entry + i);
> +
> +			if (ret =3D=3D H_SUCCESS)
> +				continue;
> +
> +			if (ret =3D=3D H_TOO_HARD)
> +				return ret;
> +
> +			WARN_ON_ONCE_RM(1);
> +			kvmppc_rm_clear_tce(stit->tbl, entry);
> +		}
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 95c91a9de351..62bdd6c48107 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -538,6 +538,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	case KVM_CAP_SPAPR_TCE:
>  	case KVM_CAP_SPAPR_TCE_64:
> +		/* fallthrough */
> +	case KVM_CAP_SPAPR_TCE_VFIO:
>  	case KVM_CAP_PPC_RTAS:
>  	case KVM_CAP_PPC_FIXUP_HCALL:
>  	case KVM_CAP_PPC_ENABLE_HCALL:
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index d32f239eb471..37d9118fd84b 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -20,6 +20,10 @@
>  #include <linux/vfio.h>
>  #include "vfio.h"
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +#include <asm/kvm_ppc.h>
> +#endif
> +
>  struct kvm_vfio_group {
>  	struct list_head node;
>  	struct vfio_group *vfio_group;
> @@ -89,6 +93,47 @@ static bool kvm_vfio_group_is_coherent(struct vfio_gro=
up *vfio_group)
>  	return ret > 0;
>  }
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
> +{
> +	int (*fn)(struct vfio_group *);
> +	int ret =3D -EINVAL;
> +
> +	fn =3D symbol_get(vfio_external_user_iommu_id);
> +	if (!fn)
> +		return ret;
> +
> +	ret =3D fn(vfio_group);
> +
> +	symbol_put(vfio_external_user_iommu_id);
> +
> +	return ret;
> +}
> +
> +static struct iommu_group *kvm_vfio_group_get_iommu_group(
> +		struct vfio_group *group)
> +{
> +	int group_id =3D kvm_vfio_external_user_iommu_id(group);
> +
> +	if (group_id < 0)
> +		return NULL;
> +
> +	return iommu_group_get_by_id(group_id);
> +}
> +
> +static void kvm_spapr_tce_release_vfio_group(struct kvm *kvm,
> +		struct vfio_group *vfio_group)
> +{
> +	struct iommu_group *grp =3D kvm_vfio_group_get_iommu_group(vfio_group);
> +
> +	if (WARN_ON_ONCE(!grp))
> +		return;
> +
> +	kvm_spapr_tce_release_iommu_group(kvm, grp);
> +	iommu_group_put(grp);
> +}
> +#endif
> +
>  /*
>   * Groups can use the same or different IOMMU domains.  If the same then
>   * adding a new group may change the coherency of groups we've previously
> @@ -211,6 +256,9 @@ static int kvm_vfio_set_group(struct kvm_device *dev,=
 long attr, u64 arg)
> =20
>  		mutex_unlock(&kv->lock);
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		kvm_spapr_tce_release_vfio_group(dev->kvm, vfio_group);
> +#endif
>  		kvm_vfio_group_set_kvm(vfio_group, NULL);
> =20
>  		kvm_vfio_group_put_external_user(vfio_group);
> @@ -218,6 +266,57 @@ static int kvm_vfio_set_group(struct kvm_device *dev=
, long attr, u64 arg)
>  		kvm_vfio_update_coherency(dev);
> =20
>  		return ret;
> +
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
> +		struct kvm_vfio_spapr_tce param;
> +		struct kvm_vfio *kv =3D dev->private;
> +		struct vfio_group *vfio_group;
> +		struct kvm_vfio_group *kvg;
> +		struct fd f;
> +		struct iommu_group *grp;
> +
> +		if (copy_from_user(&param, (void __user *)arg,
> +				sizeof(struct kvm_vfio_spapr_tce)))
> +			return -EFAULT;
> +
> +		f =3D fdget(param.groupfd);
> +		if (!f.file)
> +			return -EBADF;
> +
> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
> +		fdput(f);
> +
> +		if (IS_ERR(vfio_group))
> +			return PTR_ERR(vfio_group);
> +
> +		grp =3D kvm_vfio_group_get_iommu_group(vfio_group);
> +		if (WARN_ON_ONCE(!grp)) {
> +			kvm_vfio_group_put_external_user(vfio_group);
> +			return -EIO;
> +		}
> +
> +		ret =3D -ENOENT;
> +
> +		mutex_lock(&kv->lock);
> +
> +		list_for_each_entry(kvg, &kv->group_list, node) {
> +			if (kvg->vfio_group !=3D vfio_group)
> +				continue;
> +
> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
> +					param.tablefd, grp);
> +			break;
> +		}
> +
> +		mutex_unlock(&kv->lock);
> +
> +		iommu_group_put(grp);
> +		kvm_vfio_group_put_external_user(vfio_group);
> +
> +		return ret;
> +	}
> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>  	}
> =20
>  	return -ENXIO;
> @@ -242,6 +341,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_VFIO_GROUP_ADD:
>  		case KVM_DEV_VFIO_GROUP_DEL:
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
> +#endif
>  			return 0;
>  		}
> =20
> @@ -257,6 +359,9 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
>  	struct kvm_vfio_group *kvg, *tmp;
> =20
>  	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		kvm_spapr_tce_release_vfio_group(dev->kvm, kvg->vfio_group);
> +#endif
>  		kvm_vfio_group_set_kvm(kvg->vfio_group, NULL);
>  		kvm_vfio_group_put_external_user(kvg->vfio_group);
>  		list_del(&kvg->node);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2HpWAAoJEGw4ysog2bOSuWYQAKLzumE+kWYNv9po9de9oipa
whuiOoC3QDJoYOmTYGorBlG0nGvKwDnOV92P0goH1bkCjTxS8ImkHm5YithMPZNT
BRHltHkNUUw7HePT+w5SIKNhXnjjmGDXFD4aZValeyYqKHeteX88bNKs0uy+o/My
/N1F1kR+vb6x5DS6b0LOuqYucxzgSvGKZIcq+gG4iFo+tPE1wCCx6s85Nbq49m9U
01+ye4IC/0PyQAf42qBa8PVd2bSXTLhinkMG+AVE3IcCmK1gpAgeuyMhZg5BdhF9
2NacuprvdE6uiiv5H3nZAf0nNGBa7izVyzmfKWqxjvFp9/WZqhJPy6qmV6Bm26ny
nI2Quy1o6uSyLTxlks1evbFcsKeFzbpRzecUXq2Nr2oaTwkt1Cgcep96ceF+eEwt
9WwrYjEAOENS33eM9jgW6WDvRgrzKV18xX9QAnmlvrlaLaAAed9k6azHY/IDEKWr
N5wUjgIb3TVJixr9641RiIOFmJT9ZEliUQw/hoehvfKWX69HgIAA3VaIlV3bNdUD
s2m4krbR5YR1W8Xrrl2rPlrZLgYk2mJ45qlipWiNGxHeFV5bHk7hGE1C77YoFCHS
kCRYWabyinoQykotZvDA1Za3NbTsrZxeVPHtgo9/KFBnTWzJP0TMHI3I/KXeOII2
c4uX+oCj3Ov9uQhyEao2
=NALX
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--
