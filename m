Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKLrV09K6zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 15:02:50 +1100 (AEDT)
Date: Fri, 10 Feb 2017 15:02:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v4 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170210040243.GL27610@umbus.fritz.box>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-11-aik@ozlabs.ru>
 <20170209064112.GD14524@umbus>
 <44842cba-d8ca-7fc9-a418-15755fae4163@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/y7qBwfEQL/2otS"
In-Reply-To: <44842cba-d8ca-7fc9-a418-15755fae4163@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--W/y7qBwfEQL/2otS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 01:50:31PM +1100, Alexey Kardashevskiy wrote:
> On 09/02/17 17:41, David Gibson wrote:
> > On Tue, Feb 07, 2017 at 06:17:11PM +1100, Alexey Kardashevskiy wrote:
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
> >>
> >> This has separate copies of handlers for real and virtual modes as
> >> in fact H_PUT_TCE and H_STUFF_TCE could share a lot (common helpers
> >> would take a "realmode" flag) but H_PUT_TCE_INDIRECT uses get_user()
> >> in virtual mode and direct access in real mode and having a common
> >> helper for it would make things uglier imho.
> >>
> >>
> >> ---
> >>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
> >>  arch/powerpc/include/asm/kvm_host.h        |   8 +
> >>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
> >>  include/uapi/linux/kvm.h                   |   8 +
> >>  arch/powerpc/kvm/book3s_64_vio.c           | 319 ++++++++++++++++++++=
++++++++-
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 172 +++++++++++++++-
> >>  arch/powerpc/kvm/powerpc.c                 |   2 +
> >>  virt/kvm/vfio.c                            |  60 ++++++
> >>  8 files changed, 590 insertions(+), 5 deletions(-)
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
> >> index e59b172666cd..a827006941f8 100644
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
> >> index 37bc9e7e90ba..da1410bd6b36 100644
> >> --- a/arch/powerpc/include/asm/kvm_ppc.h
> >> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >> @@ -163,6 +163,10 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
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
> >> index a2c9bb5a0ead..cdfa01169bd2 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1076,6 +1076,7 @@ struct kvm_device_attr {
> >>  #define  KVM_DEV_VFIO_GROUP			1
> >>  #define   KVM_DEV_VFIO_GROUP_ADD			1
> >>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> >> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
> >> =20
> >>  enum kvm_device_type {
> >>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> >> @@ -1097,6 +1098,13 @@ enum kvm_device_type {
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
> >> index 9a7b7fca5e84..cb0469151e35 100644
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
> >> @@ -90,6 +124,123 @@ static long kvmppc_account_memlimit(unsigned long=
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
> >> +	if (!grp)
> >> +		return -EFAULT;
> >=20
> > EFAULT doesn't look right, that's usually means userspace has give us
> > a bad address.  What does failure to look up the iommu group by id
> > mean here?
>=20
>=20
> iommu_group_get_by_id() can fail -
> 1. if "something went very wrong" - as group ids are allocated when devic=
es
> are discovered so they are pretty static;
> 2. there is some racy sriov disable or host pci hotunplug;

Ok, sounds like it should be a WARN_ON() plus.. hmm EIO, I guess?

> 3. kvm_vfio_external_user_iommu_id() returned invalid group id which means
> that a device was unbound from the vfio-pci driver but the caller holds a
> reference to vfio_group so this should not happen.

Ok this case you can distinguish with a check on the previous line.
So you can turn that into a WARN_ON() and EIO.

>=20
>=20
> >=20
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
> >> +		ret =3D -ENODEV;
> >=20
> > ENODEV doesn't look right either.  That generally means you're trying
> > to use a device or facility that doesn't exist.  This case just means
> > you've passed a file handle that either isn't a TCE table at all, or
> > os one associated with a different VM.  -EINVAL, I guess, overloaded
> > as it is.
>=20
> Ok.
>=20
>=20
>=20
> >=20
> >> +		goto put_exit;
> >=20
> > Don't you need to put the table fd as well as the iommu group which
> > you put in that exit path?
>=20
>=20
> It is put few lines above.

Oh, yes, sorry.

>=20
>=20
> >> +	}
> >> +
> >> +	table_group =3D iommu_group_get_iommudata(grp);
> >> +	if (WARN_ON(!table_group)) {
> >> +		ret =3D -EFAULT;
> >> +		goto put_exit;
> >=20
> > Again don't you need to put the table fd as well.
>=20
> It is put few lines above, I do not keep it open longer than needed.
>=20
>=20
> >=20
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
> >> +		ret =3D -ENODEV;
> >=20
> > Again, ENODEV doesn't seem right.  Here the problem is that the host
> > hardware constraints don't match the guest hardware constraints.
> > Hmm.  EIO?  ENOSPC?
>=20
>=20
> Neither is very appealing to me... EINVAL?
> When I use "ENODEV", I am thinking of "there is no device with
> expected/requested characteristics" but this is probably wrong.

Yeah, generally ENODEV means no device at all - for example if you
mknod a device file with bogus numbers then try to access it that's
what you'll get.

EINVAL is correct, I guess, though I try to avoid it if there's any
excuse to do so, since it's so common.  I'll grant ENOSPC is an odd
suggestion: my rationale is that ENOSPC in its usual sense clearly
doesn't apply here, so it's not ambiguous with that.  Then, it's
vaguely thematically appropriate - you can't find space in the host
mapping windows to accommodate the guest mapping windows.  Bit of a
stretch, maybe.

> >> +		goto put_exit;
> >> +	}
> >> +
> >> +	iommu_table_get(tbl);
> >> +
> >> +	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> >> +	stit->tbl =3D tbl;
> >> +	stit->group =3D group;
> >> +
> >> +	list_add_rcu(&stit->next, &stt->iommu_tables);
> >=20
> > So if you add the same group to the same liobn multiple times, you'll
> > get multiple identical entries in this list.
> >=20
> > I guess that's mostly harmless... although.. does it allow the user to
> > force the allocation of arbitrary amounts of kernel memory in that
> > list?
>=20
>=20
> Oh. No, I'll add a check to avoid duplicates, they do not make sense here.
>=20
>=20
> >=20
> >> +put_exit:
> >> +	iommu_group_put(grp);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static void release_spapr_tce_table(struct rcu_head *head)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> >> @@ -132,6 +283,8 @@ static int kvm_spapr_tce_release(struct inode *ino=
de, struct file *filp)
> >> =20
> >>  	list_del_rcu(&stt->list);
> >> =20
> >> +	kvm_spapr_tce_liobn_release_iommu_group(stt, NULL /* release all */);
> >> +
> >>  	kvm_put_kvm(stt->kvm);
> >> =20
> >>  	kvmppc_account_memlimit(
> >> @@ -181,6 +334,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  	stt->offset =3D args->offset;
> >>  	stt->size =3D size;
> >>  	stt->kvm =3D kvm;
> >> +	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> >> =20
> >>  	for (i =3D 0; i < npages; i++) {
> >>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> >> @@ -209,11 +363,94 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *k=
vm,
> >>  	return ret;
> >>  }
> >> =20
> >> +static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +
> >> +	if (!pua)
> >> +		return H_HARDWARE;
> >=20
> > What could trigger this error?  Should it be a WARN_ON?
>=20
> Nothing should so yes, it can be WARN_ON.

Ok.

>=20
>=20
> >=20
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
> >> +		unsigned long entry, unsigned long gpa,
> >> +		enum dma_data_direction dir)
> >> +{
> >> +	long ret;
> >> +	unsigned long hpa, ua, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, ent=
ry);
> >> +	struct mm_iommu_table_group_mem_t *mem;
> >> +
> >> +	if (!pua)
> >> +		/* it_userspace allocation might be delayed */
> >> +		return H_TOO_HARD;
> >> +
> >> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
> >> +		return H_PARAMETER;
> >> +
> >> +	mem =3D mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >> +
> >> +	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
> >> +		return H_HARDWARE;
> >=20
> > IIUC this would happen if qemu had failed to preregister all of guest
> > RAM, making this indeed an H_HARDWARE.
>=20
>=20
> If QEMU failed to preregister, then mm_iommu_lookup() fails and it is
> TOO_HARD. mm_iommu_ua_to_hpa() in this context cannot possibly fail (unle=
ss
> broken memory) as it only returns error when out of bounds but
> mm_iommu_lookup() ensures this.

Ah, ok so it should be a WARN_ON + H_HARDWARE.

>=20
>=20
>=20
> >=20
> >> +	if (mm_iommu_mapped_inc(mem))
> >> +		return H_HARDWARE;
> >=20
> > I'm less clear on when this one would happen.
>=20
>=20
> This may happen when there is a race with mm_iommu_put().

Ah, so I guess H_CLOSED could make sense here?

>=20
>=20
> >=20
> >> +
> >> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> >> +	if (ret) {
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
> >> +	unsigned long entry, gpa;
> >> +	enum dma_data_direction dir;
> >> =20
> >>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx=
\n", */
> >>  	/* 	    liobn, ioba, tce); */
> >> @@ -230,6 +467,36 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
> >>  	if (ret !=3D H_SUCCESS)
> >>  		return ret;
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +	if (stit) {
> >> +		entry =3D ioba >> stit->tbl->it_page_shift;
> >> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +		dir =3D iommu_tce_direction(tce);
> >> +
> >> +		if (dir =3D=3D DMA_NONE) {
> >> +			if (iommu_tce_clear_param_check(stit->tbl, ioba, 0, 1))
> >> +				return H_PARAMETER;
> >> +		} else {
> >> +			if (iommu_tce_put_param_check(stit->tbl, ioba, gpa))
> >=20
> > Any way you could make these param check functions based on stt
> > instead of stit->tbl?  That would let you do them before checking if
> > there are any hw tables to update, avaoiding the somewhat awkward
> > 	if (at least one)
> > 		for (each one)
> > construct.
>=20
> I could:
> 1. change iommu_tce_put_param_check() to take shift, offset, size and drop
> use of IOMMU_PAGE_MASK(tbl) (and change all callers in vfio_iommu_spapr_t=
ce.c);
> 2. make a copy of iommu_tce_put_param_check() which would take stt.

I'd suggest doing (1) but giving the full version a new name, then
define both a tbl and stt version as trivial wrappers on that.  Makes
this a bit neater without having to change all the non-KVM related callers.

> And yet this code does operate with tbl anyway, akward either way imho...
>=20
>=20
>=20
> >=20
> >> +				return H_PARAMETER;
> >> +		}
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			if (dir =3D=3D DMA_NONE) {
> >> +				ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> >> +						stit->tbl, entry);
> >> +			} else {
> >> +				idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> >> +				ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
> >> +						entry, gpa, dir);
> >> +				srcu_read_unlock(&vcpu->kvm->srcu, idx);
> >> +			}
> >> +			if (ret !=3D H_SUCCESS)
> >> +				return ret;
> >=20
> > Doesn't this error path need to clean up for the case where you
> > managed to update some backing TCE tables, but then failed later ones?
>=20
> Probably.
>=20
> This is what I asked in:
> Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from update
>=20
> Failure to update a hardware TCE table means we are in deep trouble, I
> cannot think of any valid reason how we could get this far and not fail
> before but fail now.

Ok, I've made some suggestions about that in reply to that patch.
>=20
>=20
> >=20
> >> +		}
> >> +	}
> >> +
> >>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> >> =20
> >>  	return H_SUCCESS;
> >> @@ -242,9 +509,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret =3D H_SUCCESS, idx;
> >> -	unsigned long entry, ua =3D 0;
> >> +	unsigned long entry, gpa, ua =3D 0;
> >>  	u64 __user *tces;
> >>  	u64 tce;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -272,6 +540,9 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
> >>  	}
> >>  	tces =3D (u64 __user *) ua;
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +
> >>  	for (i =3D 0; i < npages; ++i) {
> >>  		if (get_user(tce, tces + i)) {
> >>  			ret =3D H_TOO_HARD;
> >> @@ -282,6 +553,15 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
> >>  		ret =3D kvmppc_tce_validate(stt, tce);
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> +
> >> +		if (stit) {
> >> +			gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +			ret =3D iommu_tce_put_param_check(stit->tbl,
> >> +					ioba + (i << stit->tbl->it_page_shift),
> >> +					gpa);
> >> +			if (ret !=3D H_SUCCESS)
> >> +				goto unlock_exit;
> >> +		}
> >>  	}
> >> =20
> >>  	for (i =3D 0; i < npages; ++i) {
> >> @@ -291,6 +571,21 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
> >>  		}
> >>  		tce =3D be64_to_cpu(tce);
> >> =20
> >> +		if (stit) {
> >> +			for (i =3D 0; i < npages; ++i) {
> >> +				gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +
> >> +				list_for_each_entry_lockless(stit,
> >> +						&stt->iommu_tables, next) {
> >> +					ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
> >> +						stit->tbl, entry + i, gpa,
> >> +						iommu_tce_direction(tce));
> >> +					if (ret !=3D H_SUCCESS)
> >> +						goto unlock_exit;
> >> +				}
> >=20
> > Um.. what value will this for_each leave in stit after completion?  I
> > suspect it will be something bogus, which means re-using stit in the
> > next 0..npages loop iteration won't be safe (you only initialize stit
> > with the first entry outside that loop).
>=20
>=20
> #define list_for_each_entry_lockless(pos, head, member) \
>   for (pos =3D list_entry_lockless((head)->next, typeof(*pos), member); \
>      &pos->member !=3D (head); \
>      pos =3D list_entry_lockless(pos->member.next, typeof(*pos), member))
>=20
> stit is "pos" which is reset every time the loop is called.

Um.. I'm not concerned about the access to stit within the
list_for_each().  It's the 'if (stit)' a few lines above I'm worried
about.

On the first iteration of the *outer* loop (for i=3D0..npages) stit has
been set correctly to list_first_entry_or_null().  But on subsequent
iteratoins of that outer loop, it has whatever value it has after the
completion of the list_for_each() in the previious iteration of the
outer loop.  I don't think it's wise to rely on what that value will
be.

Simplest fix would be to introduce a stit2 as the counter for the
inner loop.

>=20
>=20
> >=20
> >> +			}
> >> +		}
> >> +
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >> =20
> >> @@ -307,6 +602,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -320,6 +616,25 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>  		return H_PARAMETER;
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +	if (stit) {
> >> +		if (iommu_tce_clear_param_check(stit->tbl, ioba,
> >> +					tce_value, npages))
> >> +			return H_PARAMETER;
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> >> +
> >> +			for (i =3D 0; i < npages; ++i) {
> >> +				ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> >> +						stit->tbl, entry + i);
> >> +				if (ret)
> >> +					return ret;
> >=20
> > Again do you need some sort of cleanup for partial completion?
>=20
> Again,
> Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from update
>=20
> This is an unexpected failure which should not happen, what kind of clean=
up
> it would make sense to do here? Re-map what was mapped before H_STUFF_TCE
> was called?

Ok, documenting to me the fact that it's a "can't happen" is one of
the reasons I like to see WARN_ON()s in those cases.

>=20
> >=20
> >=20
> >> +			}
> >> +		}
> >> +	}
> >> +
> >>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> >>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> >> =20
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/bo=
ok3s_64_vio_hv.c
> >> index dc1c66fda941..018c7d94a575 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> @@ -178,11 +178,104 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned=
 long gpa,
> >>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >> =20
> >>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >> +{
> >> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +
> >> +	if (!pua)
> >> +		return H_HARDWARE;
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
> >> +long kvmppc_rm_tce_iommu_map(struct kvm_vcpu *vcpu, struct iommu_tabl=
e *tbl,
> >> +		unsigned long entry, unsigned long gpa,
> >> +		enum dma_data_direction dir)
> >> +{
> >> +	long ret;
> >> +	unsigned long hpa =3D 0, ua;
> >> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> +	struct mm_iommu_table_group_mem_t *mem;
> >> +
> >> +	if (!pua)
> >> +		/* it_userspace allocation might be delayed */
> >> +		return H_TOO_HARD;
> >> +
> >> +	if (kvmppc_gpa_to_ua(vcpu->kvm, gpa, &ua, NULL))
> >> +		return H_PARAMETER;
> >> +
> >> +	mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, 1ULL << tbl->it_page_s=
hift);
> >> +	if (!mem)
> >> +		return H_TOO_HARD;
> >> +
> >> +	if (mm_iommu_ua_to_hpa_rm(mem, ua, &hpa))
> >> +		return H_HARDWARE;
> >> +
> >> +	pua =3D (void *) vmalloc_to_phys(pua);
> >> +	if (!pua)
> >> +		return H_HARDWARE;
> >=20
> > What circumstances can this fail under?  Does it need to be H_TOO_HARD =
instead?
>=20
>=20
> When kernel memory gets corrupted and vmalloc_to_page() won't be able to
> find a page which was allocated with vmalloc.

Ok, so again there should be a WARN_ON().

>=20
>=20
> >> +
> >> +	if (mm_iommu_mapped_inc(mem))
> >> +		return H_HARDWARE;
> >> +
> >> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> >> +	if (ret) {
> >> +		mm_iommu_mapped_dec(mem);
> >> +		return H_TOO_HARD;
> >> +	}
> >> +
> >> +	if (dir !=3D DMA_NONE)
> >> +		kvmppc_rm_tce_iommu_mapped_dec(vcpu->kvm, tbl, entry);
> >> +
> >> +	*pua =3D ua;
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(kvmppc_rm_tce_iommu_map);
> >> +
> >>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>  		unsigned long ioba, unsigned long tce)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> +	unsigned long entry, gpa;
> >> +	enum dma_data_direction dir;
> >> =20
> >>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx=
\n", */
> >>  	/* 	    liobn, ioba, tce); */
> >> @@ -199,6 +292,33 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, u=
nsigned long liobn,
> >>  	if (ret !=3D H_SUCCESS)
> >>  		return ret;
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +	if (stit) {
> >> +		entry =3D ioba >> stit->tbl->it_page_shift;
> >> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +		dir =3D iommu_tce_direction(tce);
> >> +
> >> +		if (dir =3D=3D DMA_NONE) {
> >> +			if (iommu_tce_clear_param_check(stit->tbl, ioba, 0, 1))
> >> +				return H_PARAMETER;
> >> +		} else {
> >> +			if (iommu_tce_put_param_check(stit->tbl, ioba, gpa))
> >> +				return H_PARAMETER;
> >> +		}
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			if (dir =3D=3D DMA_NONE)
> >> +				ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> >> +						stit->tbl, entry);
> >> +			else
> >> +				ret =3D kvmppc_rm_tce_iommu_map(vcpu, stit->tbl,
> >> +						entry, gpa, dir);
> >> +			if (ret !=3D H_SUCCESS)
> >> +				return ret;
> >> +		}
> >> +	}
> >> +
> >>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> >> =20
> >>  	return H_SUCCESS;
> >> @@ -237,9 +357,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret =3D H_SUCCESS;
> >> -	unsigned long tces, entry, tce, ua =3D 0;
> >> +	unsigned long tces, entry, gpa, tce, ua =3D 0;
> >>  	unsigned long *rmap =3D NULL;
> >>  	bool prereg =3D false;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -303,17 +424,45 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcp=
u *vcpu,
> >>  		}
> >>  	}
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +
> >>  	for (i =3D 0; i < npages; ++i) {
> >>  		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >> =20
> >>  		ret =3D kvmppc_tce_validate(stt, tce);
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> +
> >> +		if (stit) {
> >> +			gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +			ret =3D iommu_tce_put_param_check(stit->tbl,
> >> +					ioba + (i << stit->tbl->it_page_shift),
> >> +					gpa);
> >> +			if (ret !=3D H_SUCCESS)
> >> +				goto unlock_exit;
> >> +
> >> +		}
> >>  	}
> >> =20
> >>  	for (i =3D 0; i < npages; ++i) {
> >>  		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >=20
> > As noted in the earlier patch this is really dangerous - by reloading
> > the tce from userspace you've thrown away the verification above.
>=20
>=20
> Sure, I am adding a tces cache to kvm_vcpu.

>=20
>=20
> >> +		if (stit) {
> >> +			for (i =3D 0; i < npages; ++i) {
> >> +				gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >> +
> >> +				list_for_each_entry_lockless(stit,
> >> +						&stt->iommu_tables, next) {
> >> +					ret =3D kvmppc_rm_tce_iommu_map(vcpu,
> >> +						stit->tbl, entry + i, gpa,
> >> +						iommu_tce_direction(tce));
> >> +					if (ret !=3D H_SUCCESS)
> >> +						goto unlock_exit;
> >> +				}
> >> +			}
> >> +		}
> >> +
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >> =20
> >> @@ -330,6 +479,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret;
> >> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >> +
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>  	if (!stt)
> >> @@ -343,6 +494,25 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>  		return H_PARAMETER;
> >> =20
> >> +	stit =3D list_first_entry_or_null(&stt->iommu_tables,
> >> +			struct kvmppc_spapr_tce_iommu_table, next);
> >> +	if (stit) {
> >> +		if (iommu_tce_clear_param_check(stit->tbl, ioba,
> >> +					tce_value, npages))
> >> +			return H_PARAMETER;
> >> +
> >> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >> +			unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> >> +
> >> +			for (i =3D 0; i < npages; ++i) {
> >> +				ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> >> +						stit->tbl, entry + i);
> >> +				if (ret)
> >> +					return ret;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> >>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> >> =20
> >> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> >> index cd892dec7cb6..f3127dc87912 100644
> >> --- a/arch/powerpc/kvm/powerpc.c
> >> +++ b/arch/powerpc/kvm/powerpc.c
> >> @@ -536,6 +536,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
> >>  #ifdef CONFIG_PPC_BOOK3S_64
> >>  	case KVM_CAP_SPAPR_TCE:
> >>  	case KVM_CAP_SPAPR_TCE_64:
> >> +		/* fallthrough */
> >=20
> > I'm not sure why this one should get a fallthrough comment, when none
> > of the other cases do.
>=20
>=20
> I believe it was either ignored then or checkpatch.pl did not warn about
> this at the time.

Hm. Sounds like a bug in checkpatch.pl TBH.  Fall through after
executing code for one case definitely requires a comment IMO,
fallthrough from an empty label - i.e. where there's just a bunch of
different labels with the same code block doesn't require one, I feel.

>=20
>=20
> >=20
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
> >=20
> >=20
> > Is there any particular reason you unwrap the group fd here, but the
> > table fd inside kvm__spapr_tce_attach_iommu_group()?
>=20
> No particular reason, just an intention not to spread too much spapr to K=
VM
> VFIO device and vfio_group to POWER KVM.
>
> I only unwrapp table_fd to see if it is in the kvm->arch.spapr_tce_tables
> list, I am trying to keep spapr_tce_tables and kvmppc_spapr_tce_iommu_tab=
le
> local to arch/powerpc/kvm/book3s_64_vio*.c
>=20
> Unwrapping groupfd in arch/powerpc/kvm/book3s_64_vio*.c would mean
> duplicating all kvm_vfio_group_get_external_user()/etc stubs in
> arch/powerpc/kvm/book3s_64_vio.c, I did not want to duplicate these stubs.
> I could but since I already have vfio_group unwrapped here, it seems
> pointless to unwrap it over again in arch/powerpc/kvm/book3s_64_vio.c,
> should I?

Ok, that seems like an adequate reason to do it this way.

>=20
>=20
>=20
> >=20
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

--W/y7qBwfEQL/2otS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnTtgAAoJEGw4ysog2bOSJQcP/RLddt0xB+Sgmn9pUVrjvxYn
SZ9TnjDMV5C1nRaLIVlShIWax0oGwXhx9w4g81iRTOzI3INZTDIjN5verSE5bpOX
0OC9Xr8rJmwIyBG7LOYUVdi1r0Im32L+ptqE/1rkN9+rpFzog+w+Xd2pJng8hWAG
YIW9NIChPmTx/BY83s9iLrTnGwB5L0W5k877mTJW4Y7YEEHaMyWqOeBp2rSavDvL
P1ROmEDPF/oPkOPjykUEQMhYzoA/3BHnlUFmcgO2iC9QrBVeND5p45qD1fAs0ADs
FyU/wHclC4WlepyEwx5Kj8tl+na6RrKNloaEiaJpjKrSdwMAW9mnTplw1ejzW+nO
m1fm5lZF1f9Dh5ODdK7r84Kib2ox7bFiuHAIRlfG42LdDndzUfjfk/2gd6M7upyD
MVa5ffRZqF++8m9X72Axit+S00LBKhSqrgAVFqOCkL0MEvfo+kuo3E7NFprd0O/L
mQpN5O2E/5ichiR2QBYkvkITOitkrmCJtDNfOvbahu8ZXjE8DsRJm8Civ1jzVLzI
rtd2bKP5oyZX/e7w1ep16lHAhn5UNOOKDmdbQKinP75QhgoGEt5QPEqDnzkwqKXT
I0bvIO6RX2B6n2QR7l4c/lD4MhZ+o9FHcztwOtut+GnIY41CrwlniHPGeAb7wG5X
dbjsJCh7pVg5JnIjMCU1
=SuEu
-----END PGP SIGNATURE-----

--W/y7qBwfEQL/2otS--
