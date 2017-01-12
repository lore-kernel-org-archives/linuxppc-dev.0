Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzYb94xpGzDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 16:04:37 +1100 (AEDT)
Date: Thu, 12 Jan 2017 16:04:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v3] KVM: PPC: Add in-kernel acceleration for VFIO
Message-ID: <20170112050428.GN14026@umbus.fritz.box>
References: <20161218012900.18142-12-aik@ozlabs.ru>
 <20161220065229.24025-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TXIPBuAs4GDcsx9K"
In-Reply-To: <20161220065229.24025-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TXIPBuAs4GDcsx9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2016 at 05:52:29PM +1100, Alexey Kardashevskiy wrote:
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
> to the same LIOBN, this is done to simplify the cleanup and can be
> improved later.
>=20
> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
> space.
>=20
> This finally makes use of vfio_external_user_iommu_id() which was
> introduced quite some time ago and was considered for removal.
>=20
> Tests show that this patch increases transmission speed from 220MB/s
> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * simplified not to use VFIO group notifiers
> * reworked cleanup, should be cleaner/simpler now
>=20
> v2:
> * reworked to use new VFIO notifiers
> * now same iommu_table may appear in the list several times, to be fixed =
later
> ---
>=20
> This obsoletes:
>=20
> [PATCH kernel v2 08/11] KVM: PPC: Pass kvm* to kvmppc_find_table()
> [PATCH kernel v2 09/11] vfio iommu: Add helpers to (un)register blocking =
notifiers per group
> [PATCH kernel v2 11/11] KVM: PPC: Add in-kernel acceleration for VFIO
>=20
>=20
> So I have not reposted the whole thing, should have I?
>=20
>=20
> btw "F:     virt/kvm/vfio.*"  is missing MAINTAINERS.
>=20
>=20
> ---
>  Documentation/virtual/kvm/devices/vfio.txt |  22 ++-
>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>  include/uapi/linux/kvm.h                   |   8 +
>  arch/powerpc/kvm/book3s_64_vio.c           | 286 +++++++++++++++++++++++=
++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 178 ++++++++++++++++++
>  arch/powerpc/kvm/powerpc.c                 |   2 +
>  virt/kvm/vfio.c                            |  88 +++++++++
>  8 files changed, 594 insertions(+), 2 deletions(-)
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
> index 28350a294b1e..3d281b7ea369 100644
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
> index 0a21c8503974..936138b866e7 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -163,6 +163,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  			struct kvm_memory_slot *memslot, unsigned long porder);
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablef=
d,
> +		struct vfio_group *group, struct iommu_group *grp);
> +extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
> +		struct vfio_group *group);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 810f74317987..4088da4a575f 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1068,6 +1068,7 @@ struct kvm_device_attr {
>  #define  KVM_DEV_VFIO_GROUP			1
>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
> =20
>  enum kvm_device_type {
>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> @@ -1089,6 +1090,13 @@ enum kvm_device_type {
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
> index 15df8ae627d9..008c4aee4df6 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -27,6 +27,10 @@
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
> @@ -39,6 +43,20 @@
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
> +	if (!fn)

I think this should have a WARN_ON().  If the vfio module is gone
while you still have VFIO groups attached to a KVM table, something
has gone horribly wrong.

> +		return;
> +
> +	fn(vfio_group);
> +
> +	symbol_put(vfio_group_put_external_user);
> +}
> =20
>  static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
>  {
> @@ -90,6 +108,99 @@ static long kvmppc_account_memlimit(unsigned long stt=
_pages, bool inc)
>  	return ret;
>  }
> =20
> +static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
> +{
> +	struct kvmppc_spapr_tce_iommu_table *stit =3D container_of(head,
> +			struct kvmppc_spapr_tce_iommu_table, rcu);
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
> +		iommu_table_put(stit->tbl);
> +		kvm_vfio_group_put_external_user(stit->group);
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
> +		struct vfio_group *group, struct iommu_group *grp)

Isn't passing both the vfio_group and the iommu_group redundant?

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
> +		return -ENODEV;

Not entirely sure if ENODEV is the right error, but I can't
immediately think of a better one.

> +	table_group =3D iommu_group_get_iommudata(grp);
> +	if (!table_group)
> +		return -EFAULT;

EFAULT is usually only returned when you pass a syscall a bad pointer,
which doesn't look to be the case here.  What situation does this
error path actually represent?

> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbltmp =3D table_group->tables[i];
> +
> +		if (!tbltmp)
> +			continue;
> +
> +		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
> +				(tbltmp->it_offset =3D=3D stt->offset)) {
> +			tbl =3D tbltmp;
> +			break;
> +		}
> +	}
> +	if (!tbl)
> +		return -ENODEV;
> +
> +	iommu_table_get(tbl);
> +
> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> +	stit->tbl =3D tbl;
> +	stit->group =3D group;
> +
> +	list_add_rcu(&stit->next, &stt->iommu_tables);

Won't this add a separate stit entry for each group attached to the
LIOBN, even if those groups share a single hardware iommu table -
which is the likely case if those groups have all been put into the
same container.

> +	return 0;
> +}
> +
>  static void release_spapr_tce_table(struct rcu_head *head)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> @@ -132,6 +243,8 @@ static int kvm_spapr_tce_release(struct inode *inode,=
 struct file *filp)
> =20
>  	list_del_rcu(&stt->list);
> =20
> +	kvm_spapr_tce_liobn_release_iommu_group(stt, NULL /* release all */);
> +
>  	kvm_put_kvm(stt->kvm);
> =20
>  	kvmppc_account_memlimit(
> @@ -181,6 +294,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->offset =3D args->offset;
>  	stt->size =3D size;
>  	stt->kvm =3D kvm;
> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> =20
>  	for (i =3D 0; i < npages; i++) {
>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> @@ -209,11 +323,161 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	return ret;
>  }
> =20
> +static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		return H_HARDWARE;
> +
> +	mem =3D mm_iommu_lookup(kvm->mm, *pua, pgsize);
> +	if (!mem)
> +		return H_HARDWARE;

IIUC, this error represents trying to unmap a page from the vIOMMU,
and discovering that it wasn't preregistered in the first place, which
shouldn't happen.  So would a WARN_ON() make sense here as well as the
H_HARDWARE.

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
> +
> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
> +		return H_HARDWARE;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	return kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> +}
> +
> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long gpa,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa, ua, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
> +		return H_HARDWARE;

This would represent the guest trying to map a mad GPA, yes?  In which
case H_HARDWARE doesn't seem right.  H_PARAMETER or H_PERMISSION, maybe.

> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		return H_HARDWARE;

Here H_HARDWARE seems right. IIUC this represents the guest trying to
map an address which wasn't pre-registered.  That would indicate a bug
in qemu, which is hardware as far as the guest is concerned.

> +
> +	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
> +		return H_HARDWARE;

Not sure what this case represents.

> +	if (mm_iommu_mapped_inc(mem))
> +		return H_HARDWARE;

Or this.

> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +	if (ret) {
> +		mm_iommu_mapped_dec(mem);
> +		return H_TOO_HARD;
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
> +long kvmppc_h_put_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce)
> +{
> +	long idx, ret =3D H_HARDWARE;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +	const unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	const enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +
> +	/* Clear TCE */
> +	if (dir =3D=3D DMA_NONE) {
> +		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
> +			return H_PARAMETER;
> +
> +		return kvmppc_tce_iommu_unmap(vcpu->kvm, tbl, entry);
> +	}
> +
> +	/* Put TCE */
> +	if (iommu_tce_put_param_check(tbl, ioba, gpa))
> +		return H_PARAMETER;
> +
> +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +	ret =3D kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry, gpa, dir);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +	return ret;
> +}
> +
> +static long kvmppc_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long ioba,
> +		u64 __user *tces, unsigned long npages)
> +{
> +	unsigned long i, ret, tce, gpa;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		gpa =3D be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);

IIUC this is the virtual mode, not the real mode version.  In which
case you shouldn't be accessing tces[i] (a userspace pointeR) directly
bit should instead be using get_user().

> +		if (iommu_tce_put_param_check(tbl, ioba +
> +				(i << tbl->it_page_shift), gpa))
> +			return H_PARAMETER;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		tce =3D be64_to_cpu(tces[i]);
> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		ret =3D kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry + i, gpa,
> +				iommu_tce_direction(tce));
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
> +	return H_SUCCESS;
> +}
> +
> +long kvmppc_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	unsigned long i;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i)
> +		kvmppc_tce_iommu_unmap(vcpu->kvm, tbl, entry + i);
> +
> +	return H_SUCCESS;
> +}
> +
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -230,6 +494,12 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {

As noted above, AFAICT there is one stit per group, rather than per
backend IOMMU table, so if there are multiple groups in the same
container (and therefore attached to the same LIOBN), won't this mean
we duplicate this operation a bunch of times?

> +		ret =3D kvmppc_h_put_tce_iommu(vcpu, stit->tbl, liobn, ioba, tce);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
> @@ -245,6 +515,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	unsigned long entry, ua =3D 0;
>  	u64 __user *tces;
>  	u64 tce;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -272,6 +543,13 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	}
>  	tces =3D (u64 __user *) ua;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		ret =3D kvmppc_h_put_tce_indirect_iommu(vcpu,
> +				stit->tbl, ioba, tces, npages);
> +		if (ret !=3D H_SUCCESS)
> +			goto unlock_exit;

Hmm, I don't suppose you could simplify things by not having a
put_tce_indirect() version of the whole backend iommu mapping
function, but just a single-TCE version, and instead looping across
the backend IOMMU tables as you put each indirect entry in .

> +	}
> +
>  	for (i =3D 0; i < npages; ++i) {
>  		if (get_user(tce, tces + i)) {
>  			ret =3D H_TOO_HARD;
> @@ -299,6 +577,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -312,6 +591,13 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		ret =3D kvmppc_h_stuff_tce_iommu(vcpu, stit->tbl, liobn, ioba,
> +				tce_value, npages);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 8a6834e6e1c8..4d6f01712a6d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -190,11 +190,165 @@ static struct mm_iommu_table_group_mem_t *kvmppc_r=
m_iommu_lookup(
>  	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
>  }
> =20
> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		return H_SUCCESS;

What case is this?  Not being able to find the userspace duesn't sound
like a success.

> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (!pua)
> +		return H_SUCCESS;

And again..

> +	mem =3D kvmppc_rm_iommu_lookup(vcpu, *pua, pgsize);
> +	if (!mem)
> +		return H_HARDWARE;

Should this have a WARN_ON?

> +	mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_rm_tce_iommu_unmap(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	enum dma_data_direction dir =3D DMA_NONE;
> +	unsigned long hpa =3D 0;
> +
> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> +		return H_HARDWARE;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	return kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
> +}
> +
> +long kvmppc_rm_tce_iommu_map(struct kvm_vcpu *vcpu, struct iommu_table *=
tbl,
> +		unsigned long entry, unsigned long gpa,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa =3D 0, ua;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (!pua)
> +		/* it_userspace allocation might be delayed */
> +		return H_TOO_HARD;
> +
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, gpa, &ua, NULL))
> +		return H_HARDWARE;

Again H_HARDWARE doesn't seem right here.

> +	mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_ua_to_hpa_rm(mem, ua, &hpa))
> +		return H_HARDWARE;
> +
> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (!pua)
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_mapped_inc(mem))
> +		return H_HARDWARE;
> +
> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +	if (ret) {
> +		mm_iommu_mapped_dec(mem);
> +		return H_TOO_HARD;
> +	}
> +
> +	if (dir !=3D DMA_NONE)
> +		kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
> +
> +	*pua =3D ua;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_rm_tce_iommu_map);
> +
> +static long kvmppc_rm_h_put_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long liobn,
> +		unsigned long ioba, unsigned long tce)
> +{
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +	const unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	const enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +
> +	/* Clear TCE */
> +	if (dir =3D=3D DMA_NONE) {
> +		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
> +			return H_PARAMETER;
> +
> +		return kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry);
> +	}
> +
> +	/* Put TCE */
> +	if (iommu_tce_put_param_check(tbl, ioba, gpa))
> +		return H_PARAMETER;
> +
> +	return kvmppc_rm_tce_iommu_map(vcpu, tbl, entry, gpa, dir);
> +}
> +
> +static long kvmppc_rm_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long ioba,
> +		u64 *tces, unsigned long npages)
> +{
> +	unsigned long i, ret, tce, gpa;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		gpa =3D be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		if (iommu_tce_put_param_check(tbl, ioba +
> +				(i << tbl->it_page_shift), gpa))
> +			return H_PARAMETER;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		tce =3D be64_to_cpu(tces[i]);
> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		ret =3D kvmppc_rm_tce_iommu_map(vcpu, tbl, entry + i, gpa,
> +				iommu_tce_direction(tce));
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_rm_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	unsigned long i;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i)
> +		kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry + i);
> +
> +	return H_SUCCESS;
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -211,6 +365,13 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		ret =3D kvmppc_rm_h_put_tce_iommu(vcpu, stit->tbl,
> +				liobn, ioba, tce);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
> @@ -278,6 +439,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		 * depend on hpt.
>  		 */
>  		struct mm_iommu_table_group_mem_t *mem;
> +		struct kvmppc_spapr_tce_iommu_table *stit;
> =20
>  		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>  			return H_TOO_HARD;
> @@ -285,6 +447,13 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
>  		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
>  		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
>  			return H_TOO_HARD;
> +
> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +			ret =3D kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
> +					stit->tbl, ioba, (u64 *)tces, npages);
> +			if (ret !=3D H_SUCCESS)
> +				return ret;
> +		}
>  	} else {
>  		/*
>  		 * This is emulated devices case.
> @@ -334,6 +503,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -347,6 +518,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		ret =3D kvmppc_rm_h_stuff_tce_iommu(vcpu, stit->tbl,
> +				liobn, ioba, tce_value, npages);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 70963c845e96..0e555ba998c0 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -536,6 +536,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	case KVM_CAP_SPAPR_TCE:
>  	case KVM_CAP_SPAPR_TCE_64:
> +		/* fallthrough */
> +	case KVM_CAP_SPAPR_TCE_VFIO:
>  	case KVM_CAP_PPC_ALLOC_HTAB:
>  	case KVM_CAP_PPC_RTAS:
>  	case KVM_CAP_PPC_FIXUP_HCALL:
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index d32f239eb471..3181054c8ff7 100644
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
> @@ -89,6 +93,22 @@ static bool kvm_vfio_group_is_coherent(struct vfio_gro=
up *vfio_group)
>  	return ret > 0;
>  }
> =20
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
> +
>  /*
>   * Groups can use the same or different IOMMU domains.  If the same then
>   * adding a new group may change the coherency of groups we've previously
> @@ -211,6 +231,9 @@ static int kvm_vfio_set_group(struct kvm_device *dev,=
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
> @@ -218,6 +241,65 @@ static int kvm_vfio_set_group(struct kvm_device *dev=
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
> +			int group_id;
> +			struct iommu_group *grp;
> +
> +			if (kvg->vfio_group !=3D vfio_group)
> +				continue;
> +
> +			group_id =3D kvm_vfio_external_user_iommu_id(
> +					kvg->vfio_group);
> +			grp =3D iommu_group_get_by_id(group_id);
> +			if (!grp) {
> +				ret =3D -EFAULT;
> +				break;
> +			}
> +
> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
> +					param.tablefd, vfio_group, grp);
> +
> +			iommu_group_put(grp);
> +			break;
> +		}
> +
> +		mutex_unlock(&kv->lock);
> +
> +		return ret;
> +	}
> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>  	}

Don't you also need to add something to the KVM_DEV_VFIO_GROUP_DEL
path to detach the group from all LIOBNs,  Or else just fail if if
there are LIOBNs attached.  I think it would be a qemu bug not to
detach the LIOBNs before removing the group, but we stil need to
protect the host in that case.

> =20
>  	return -ENXIO;
> @@ -242,6 +324,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_VFIO_GROUP_ADD:
>  		case KVM_DEV_VFIO_GROUP_DEL:
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
> +#endif
>  			return 0;
>  		}
> =20
> @@ -257,6 +342,9 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
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

--TXIPBuAs4GDcsx9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdw5aAAoJEGw4ysog2bOSeyUP/3OoaxqXoDF3Q0eJG3rH5cot
Dnh+fa49Biv33ByMwObRfTo4XLgVVCoGYr+dNwEATsw406c/xJQvDtv+HQzLqjPE
rcXPQYuN97J6oulQRlyB0UtRvO+VqMupZzxXif+yY5rHfpWZl3sXUzRbsORnV4ck
fFLp6vSStVgBu2HaVd8IgI4WiEoJqSQbmtIL8GsrzoUmuHYVsPiVXkXkbNgaJCef
ocOlJsWh2XsMXBCCQhi4pCgCDcruu4hYrlidbO88ai63OUHYV23EX51cpOU+zosl
LH5ygiO58gvFYSHvHXEGRjiW+Vpbkky7ZvLQiaswNtXnM1md6aFIrvhNmDOHvfhp
8DoA3NZviPckwC3gqT0DZD+pTNj8a70VVLk9cM5vKLhjjVfDBxxhiike82sr7O0c
xWJhWXdUgcLhU0Taw24SinpcxpOl0etW2YAJBoRRwW0QgWP/MmwqshLedHO5xHBp
yYttOxJsgwC229Z7n+XO+IMbL+iAqoeTakTXKNET1+Ei76fYfHJk6obU55cZ2/+G
hhlQYud4MnsGZaHXa2/2W2q3pabj91wbiiVMqeCIZN0/5iJkKiVN6x5Lmkd1OaVt
F7puUsxy5EZ9OruRiMmgqKtRlsNBSEB+zuuOYHlcnR9JtHrAZo14n8yN2RzvA3ry
axgw8dZs+/NjwIdLHpmi
=oNKU
-----END PGP SIGNATURE-----

--TXIPBuAs4GDcsx9K--
