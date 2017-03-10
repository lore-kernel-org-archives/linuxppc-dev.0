Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfZWb2QPyzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 15:47:55 +1100 (AEDT)
Date: Fri, 10 Mar 2017 15:47:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170310044750.GA3167@umbus.fritz.box>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310035337.22091-11-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <20170310035337.22091-11-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 02:53:37PM +1100, Alexey Kardashevskiy wrote:
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
> As this creates a descriptor per IOMMU table-LIOBN couple (called
> kvmppc_spapr_tce_iommu_table), it is possible to have several
> descriptors with the same iommu_table (hardware IOMMU table) attached
> to the same LIOBN; we do not remove duplicates though as
> iommu_table_ops::exchange not just update a TCE entry (which is
> shared among IOMMU groups) but also invalidates the TCE cache
> (one per IOMMU group).
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
>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>  include/uapi/linux/kvm.h                   |   8 +
>  arch/powerpc/kvm/book3s_64_vio.c           | 323 +++++++++++++++++++++++=
+++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 201 +++++++++++++++++-
>  arch/powerpc/kvm/powerpc.c                 |   2 +
>  virt/kvm/vfio.c                            |  60 ++++++
>  8 files changed, 623 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/v=
irtual/kvm/devices/vfio.txt
> index ef51740c67ca..f95d867168ea 100644
> --- a/Documentation/virtual/kvm/devices/vfio.txt
> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> @@ -16,7 +16,25 @@ Groups:
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
> +		__u32	argsz;
> +		__u32	flags;
> +		__s32	groupfd;
> +		__s32	tablefd;
> +	};
> +
> +	where
> +	@argsz is the size of kvm_vfio_spapr_tce_liobn;
> +	@flags are not supported now, must be zero;
> +	@groupfd is a file descriptor for a VFIO group;
> +	@tablefd is a file descriptor for a TCE table allocated via
> +		KVM_CREATE_SPAPR_TCE.
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 7bba8f415627..857ae2c6aa39 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -191,6 +191,13 @@ struct kvmppc_pginfo {
>  	atomic_t refcnt;
>  };
> =20
> +struct kvmppc_spapr_tce_iommu_table {
> +	struct rcu_head rcu;
> +	struct list_head next;
> +	struct vfio_group *group;
> +	struct iommu_table *tbl;
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
> index 72c2a155641f..66de7e73b3d3 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -164,6 +164,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  			struct kvm_memory_slot *memslot, unsigned long porder);
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablef=
d,
> +		struct vfio_group *group);
> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> +		struct vfio_group *group);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f5a52ffb6b58..e743cb0d176e 100644
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
> @@ -1109,6 +1110,13 @@ enum kvm_device_type {
>  	KVM_DEV_TYPE_MAX,
>  };
> =20
> +struct kvm_vfio_spapr_tce {
> +	__u32	argsz;
> +	__u32	flags;
> +	__s32	groupfd;
> +	__s32	tablefd;
> +};
> +
>  /*
>   * ioctls for VM fds
>   */
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index e96a4590464c..be18cda01e1b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -28,6 +28,10 @@
>  #include <linux/hugetlb.h>
>  #include <linux/list.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/iommu.h>
> +#include <linux/file.h>
> +#include <linux/vfio.h>
> +#include <linux/module.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/kvm_ppc.h>
> @@ -40,6 +44,36 @@
>  #include <asm/udbg.h>
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/mmu_context.h>
> +
> +static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_gro=
up)
> +{
> +	void (*fn)(struct vfio_group *);
> +
> +	fn =3D symbol_get(vfio_group_put_external_user);
> +	if (WARN_ON(!fn))
> +		return;
> +
> +	fn(vfio_group);
> +
> +	symbol_put(vfio_group_put_external_user);
> +}
> +
> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
> +{
> +	int (*fn)(struct vfio_group *);
> +	int ret =3D -1;
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
> =20
>  static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
>  {
> @@ -91,6 +125,130 @@ static long kvmppc_account_memlimit(unsigned long st=
t_pages, bool inc)
>  	return ret;
>  }
> =20
> +static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
> +{
> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(head,
> +			struct kvmppc_spapr_tce_iommu_table, rcu);
> +
> +	iommu_table_put(stit->tbl);
> +	kvm_vfio_group_put_external_user(stit->group);
> +
> +	kfree(stit);
> +}
> +
> +static void kvm_spapr_tce_liobn_release_iommu_group(
> +		struct kvmppc_spapr_tce_table *stt,
> +		struct vfio_group *group)
> +{
> +	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
> +
> +	list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
> +		if (group && (stit->group !=3D group))
> +			continue;
> +
> +		list_del_rcu(&stit->next);
> +
> +		call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
> +	}
> +}
> +
> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> +		struct vfio_group *group)
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +
> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list)
> +		kvm_spapr_tce_liobn_release_iommu_group(stt, group);
> +}
> +
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablef=
d,
> +		struct vfio_group *group)
> +{
> +	struct kvmppc_spapr_tce_table *stt =3D NULL;
> +	bool found =3D false;
> +	struct iommu_table *tbl =3D NULL;
> +	struct iommu_table_group *table_group;
> +	long i, ret =3D 0;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	struct fd f;
> +	int group_id;
> +	struct iommu_group *grp;
> +
> +	group_id =3D kvm_vfio_external_user_iommu_id(group);
> +	grp =3D iommu_group_get_by_id(group_id);
> +	if (WARN_ON(!grp))
> +		return -EIO;
> +
> +	f =3D fdget(tablefd);
> +	if (!f.file) {
> +		ret =3D -EBADF;
> +		goto put_exit;
> +	}
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
> +	if (!found) {
> +		ret =3D -EINVAL;
> +		goto put_exit;
> +	}
> +
> +	table_group =3D iommu_group_get_iommudata(grp);
> +	if (WARN_ON(!table_group)) {
> +		ret =3D -EFAULT;
> +		goto put_exit;
> +	}
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbltmp =3D table_group->tables[i];
> +
> +		if (!tbltmp)
> +			continue;
> +
> +		/*
> +		 * Make sure hardware table parameters are exactly the same;
> +		 * this is used in the TCE handlers where boundary checks
> +		 * use only the first attached table.
> +		 */
> +		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
> +				(tbltmp->it_offset =3D=3D stt->offset) &&
> +				(tbltmp->it_size =3D=3D stt->size)) {
> +			tbl =3D tbltmp;
> +			break;
> +		}
> +	}
> +	if (!tbl) {
> +		ret =3D -EINVAL;
> +		goto put_exit;
> +	}
> +
> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> +		if ((stit->tbl =3D=3D tbl) && (stit->group =3D=3D group)) {
> +			ret =3D -EBUSY;
> +			goto put_exit;
> +		}
> +	}
> +
> +	iommu_table_get(tbl);
> +
> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> +	stit->tbl =3D tbl;
> +	stit->group =3D group;
> +
> +	list_add_rcu(&stit->next, &stt->iommu_tables);
> +
> +put_exit:
> +	iommu_group_put(grp);
> +
> +	return ret;
> +}
> +
>  static void release_spapr_tce_table(struct rcu_head *head)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> @@ -133,6 +291,8 @@ static int kvm_spapr_tce_release(struct inode *inode,=
 struct file *filp)
> =20
>  	list_del_rcu(&stt->list);
> =20
> +	kvm_spapr_tce_liobn_release_iommu_group(stt, NULL /* release all */);
> +
>  	kvm_put_kvm(stt->kvm);
> =20
>  	kvmppc_account_memlimit(
> @@ -183,6 +343,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->offset =3D args->offset;
>  	stt->size =3D size;
>  	stt->kvm =3D kvm;
> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> =20
>  	for (i =3D 0; i < npages; i++) {
>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> @@ -211,11 +372,101 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
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
> @@ -232,7 +483,35 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
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
> @@ -247,6 +526,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	unsigned long entry, ua =3D 0;
>  	u64 __user *tces;
>  	u64 tce;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -285,6 +565,26 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
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
> @@ -301,6 +601,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -314,6 +615,24 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
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
> index d32f239eb471..2b7dc22265fe 100644
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
> @@ -211,6 +215,9 @@ static int kvm_vfio_set_group(struct kvm_device *dev,=
 long attr, u64 arg)
> =20
>  		mutex_unlock(&kv->lock);
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		kvm_spapr_tce_release_iommu_group(dev->kvm, vfio_group);
> +#endif
>  		kvm_vfio_group_set_kvm(vfio_group, NULL);
> =20
>  		kvm_vfio_group_put_external_user(vfio_group);
> @@ -218,6 +225,53 @@ static int kvm_vfio_set_group(struct kvm_device *dev=
, long attr, u64 arg)
>  		kvm_vfio_update_coherency(dev);
> =20
>  		return ret;
> +
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
> +		struct kvm_vfio_spapr_tce param;
> +		unsigned long minsz;
> +		struct kvm_vfio *kv =3D dev->private;
> +		struct vfio_group *vfio_group;
> +		struct kvm_vfio_group *kvg;
> +		struct fd f;
> +
> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce, tablefd);
> +
> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (param.argsz < minsz || param.flags)
> +			return -EINVAL;
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
> +		ret =3D -ENOENT;
> +
> +		mutex_lock(&kv->lock);
> +
> +		list_for_each_entry(kvg, &kv->group_list, node) {
> +			if (kvg->vfio_group !=3D vfio_group)
> +				continue;
> +
> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
> +					param.tablefd, vfio_group);
> +
> +			break;
> +		}
> +
> +		mutex_unlock(&kv->lock);
> +
> +		return ret;
> +	}
> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>  	}
> =20
>  	return -ENXIO;
> @@ -242,6 +296,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_VFIO_GROUP_ADD:
>  		case KVM_DEV_VFIO_GROUP_DEL:
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
> +#endif
>  			return 0;
>  		}
> =20
> @@ -257,6 +314,9 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
>  	struct kvm_vfio_group *kvg, *tmp;
> =20
>  	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		kvm_spapr_tce_release_iommu_group(dev->kvm, kvg->vfio_group);
> +#endif
>  		kvm_vfio_group_set_kvm(kvg->vfio_group, NULL);
>  		kvm_vfio_group_put_external_user(kvg->vfio_group);
>  		list_del(&kvg->node);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwi/0AAoJEGw4ysog2bOSq/8P/0n/yYIyvVya93WQ/y45pRt9
OS+S/BiP/S0aMLTRW9K+rKoMridFaIykZ3F+oRcCx5sKu1D3rr7/JazcuPdZZYr1
+VLLImrKn58qNHhQ1Evhxm/PKUiwJ2c46m6RhS2zIROqSmVCbrv4eY76aez4PwkH
+V7XG3dX8hhWmnIHCkEpvGI2WrQl2G6LF28R6LKqBT0P3rb4b6o9imqHIj5GmVYM
gX99DROU3P8rGgPkf5ZBuLQT73NqmA8bFOdYLrHkYeSNmQCOZ2dkeLJUWVMWFLQv
kE5WMqqfRuJemxoqez57K35Je3/OeZTN4hCCCMgbcglGX6nb+16Gbn9mXtMQq8SV
RgCSOvdzMsKA0xaF4ko2Iv3HVZg9TSXMgCFZNiwDEZfkiFMJcdg4sbAaydb59ZKD
5+D7Rewe4Ktk51AODcayR7Odm7BVpm39qlFSbyUdbbzMVwbKxHDWj80FUrT6aTZs
AZ2W8wh4YRr/cgURNdOVMg+DeZYTcYGcz+p9W59iHxbDZ6H0VrUExWbSPNMHY7vs
CwBGdWqMwpdxsp2k4iJ5N6mO/Spv6i6KkDPtr1Bi/O1WkHCDBxE/1PssmWb7or5J
0zqhTF5BhCBm5qqaJcQBQJGr7r40TvMvH01q+w2zvM39eZyHvx3I8IQXAYFin3kf
/Y0LyBFER5qeLx2JZX+f
=g/Bg
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
