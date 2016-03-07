Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458B31A02A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 18:30:25 +1100 (AEDT)
Date: Mon, 7 Mar 2016 17:25:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest
 view of TCE table
Message-ID: <20160307062523.GN22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
In-Reply-To: <1457322077-26640-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:14PM +1100, Alexey Kardashevskiy wrote:
> The existing in-kernel TCE table for emulated devices contains
> guest physical addresses which are accesses by emulated devices.
> Since we need to keep this information for VFIO devices too
> in order to implement H_GET_TCE, we are reusing it.
>=20
> This adds IOMMU group list to kvmppc_spapr_tce_table. Each group
> will have an iommu_table pointer.
>=20
> This adds kvm_spapr_tce_attach_iommu_group() helper and its detach
> counterpart to manage the lists.
>=20
> This puts a group when:
> - guest copy of TCE table is destroyed when TCE table fd is closed;
> - kvm_spapr_tce_detach_iommu_group() is called from
> the KVM_DEV_VFIO_GROUP_DEL ioctl handler in the case vfio-pci hotunplug
> (will be added in the following patch).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/kvm_host.h |   8 +++
>  arch/powerpc/include/asm/kvm_ppc.h  |   6 ++
>  arch/powerpc/kvm/book3s_64_vio.c    | 108 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 122 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 2e7c791..2c5c823 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -178,6 +178,13 @@ struct kvmppc_pginfo {
>  	atomic_t refcnt;
>  };
> =20
> +struct kvmppc_spapr_tce_group {
> +	struct list_head next;
> +	struct rcu_head rcu;
> +	struct iommu_group *refgrp;/* for reference counting only */
> +	struct iommu_table *tbl;
> +};
> +
>  struct kvmppc_spapr_tce_table {
>  	struct list_head list;
>  	struct kvm *kvm;
> @@ -186,6 +193,7 @@ struct kvmppc_spapr_tce_table {
>  	u32 page_shift;
>  	u64 offset;		/* in pages */
>  	u64 size;		/* window size in pages */
> +	struct list_head groups;
>  	struct page *pages[0];
>  };
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 2544eda..d1482dc 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -164,6 +164,12 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  			struct kvm_memory_slot *memslot, unsigned long porder);
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> =20
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
> +				unsigned long liobn,
> +				phys_addr_t start_addr,
> +				struct iommu_group *grp);
> +extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
> +				struct iommu_group *grp);
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
>  extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 2c2d103..846d16d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -27,6 +27,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/list.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/iommu.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/kvm_ppc.h>
> @@ -95,10 +96,18 @@ static void release_spapr_tce_table(struct rcu_head *=
head)
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
>  			struct kvmppc_spapr_tce_table, rcu);
>  	unsigned long i, npages =3D kvmppc_tce_pages(stt->size);
> +	struct kvmppc_spapr_tce_group *kg;
> =20
>  	for (i =3D 0; i < npages; i++)
>  		__free_page(stt->pages[i]);
> =20
> +	while (!list_empty(&stt->groups)) {
> +		kg =3D list_first_entry(&stt->groups,
> +				struct kvmppc_spapr_tce_group, next);
> +		list_del(&kg->next);
> +		kfree(kg);
> +	}
> +
>  	kfree(stt);
>  }
> =20
> @@ -129,9 +138,15 @@ static int kvm_spapr_tce_mmap(struct file *file, str=
uct vm_area_struct *vma)
>  static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D filp->private_data;
> +	struct kvmppc_spapr_tce_group *kg;
> =20
>  	list_del_rcu(&stt->list);
> =20
> +	list_for_each_entry_rcu(kg, &stt->groups, next)	{
> +		iommu_group_put(kg->refgrp);
> +		kg->refgrp =3D NULL;
> +	}

What's the reason for this kind of two-phase deletion?  Dereffing the
group here, and setting to NULL, then actually removing from the liast abov=
e.


>  	kvm_put_kvm(stt->kvm);
> =20
>  	kvmppc_account_memlimit(
> @@ -146,6 +161,98 @@ static const struct file_operations kvm_spapr_tce_fo=
ps =3D {
>  	.release	=3D kvm_spapr_tce_release,
>  };
> =20
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
> +				unsigned long liobn,
> +				phys_addr_t start_addr,
> +				struct iommu_group *grp)
> +{
> +	struct kvmppc_spapr_tce_table *stt =3D NULL;
> +	struct iommu_table_group *table_group;
> +	long i;
> +	bool found =3D false;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp;
> +
> +	/* Check this LIOBN hasn't been previously allocated */

This comment does not appear to be correct.

> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
> +		if (stt->liobn =3D=3D liobn) {
> +			if ((stt->offset << stt->page_shift) !=3D start_addr)
> +				return -EINVAL;
> +
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -ENODEV;
> +
> +	/* Find IOMMU group and table at @start_addr */
> +	table_group =3D iommu_group_get_iommudata(grp);
> +	if (!table_group)
> +		return -EFAULT;
> +
> +	tbltmp =3D NULL;
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D table_group->tables[i];
> +
> +		if (!tbl)
> +			continue;
> +
> +		if ((tbl->it_page_shift =3D=3D stt->page_shift) &&
> +				(tbl->it_offset =3D=3D stt->offset)) {
> +			tbltmp =3D tbl;
> +			break;
> +		}
> +	}
> +	if (!tbltmp)
> +		return -ENODEV;
> +
> +	list_for_each_entry_rcu(kg, &stt->groups, next) {
> +		if (kg->refgrp =3D=3D grp)
> +			return -EBUSY;
> +	}
> +
> +	kg =3D kzalloc(sizeof(*kg), GFP_KERNEL);
> +	kg->refgrp =3D grp;
> +	kg->tbl =3D tbltmp;
> +	list_add_rcu(&kg->next, &stt->groups);
> +
> +	return 0;
> +}
> +
> +static void kvm_spapr_tce_put_group(struct rcu_head *head)
> +{
> +	struct kvmppc_spapr_tce_group *kg =3D container_of(head,
> +			struct kvmppc_spapr_tce_group, rcu);
> +
> +	iommu_group_put(kg->refgrp);
> +	kg->refgrp =3D NULL;
> +	kfree(kg);
> +}
> +
> +extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
> +				struct iommu_group *grp)

Hrm.  attach takes an explicit liobn, but this one iterates over all
liobns.  Why the asymmetry?

> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	struct iommu_table_group *table_group;
> +	struct kvmppc_spapr_tce_group *kg;
> +
> +	table_group =3D iommu_group_get_iommudata(grp);
> +	if (!table_group)
> +		return;
> +
> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
> +		list_for_each_entry_rcu(kg, &stt->groups, next) {
> +			if (kg->refgrp =3D=3D grp) {
> +				list_del_rcu(&kg->next);
> +				call_rcu(&kg->rcu, kvm_spapr_tce_put_group);
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>  long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				   struct kvm_create_spapr_tce_64 *args)
>  {
> @@ -181,6 +288,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->offset =3D args->offset;
>  	stt->size =3D size;
>  	stt->kvm =3D kvm;
> +	INIT_LIST_HEAD_RCU(&stt->groups);
> =20
>  	for (i =3D 0; i < npages; i++) {
>  		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3R7TAAoJEGw4ysog2bOScJsP/261MHRvEylyKXfGlXNqTQp5
ML88mZgXvre6zYTkxsaq8t/rxZcZ4ZniJdbODiws3TMNl+X0xX0vgszH1O5wKM7O
3PdfqhQis++wrlQJBa2ouHdENkqta/s3xJuAyn/BimohvFNZbzZNtNSq9zoq9glV
T5229e57kYibdDaIgIKqTX328bL+gLBB4pLuV/pPXDoCvns3BcSz/+ZO6pvGJG6G
uyQOq1dmwySQBJ+wiMGEgMDFiwNTlK/8N3zD3ufyjU4V+RDQmGRrbiQ626Pb0Ttf
ObTVmfC5J6zLrwVPLKlSV0bQ97w5ZU0llF2tZMDH7XDM7bya0nCRRIeKS8ft22xQ
fd3/xLmMa0zM6kC6Amab9P545KNt7XJZ2pJcOC54+nx/ET9YpF74v056xEVGGfr0
6qZ6s5YfgUEB1Xjx3HNce+s/U9H2DjVX67m/6k6fXuu3X/X/0WV6XAbUTiJ4Qr/S
IZlsBU50IklpiV8fTg2uFWOZKVh+tH8Ch1sQ760kqGNpwtsza5bUL/eeowmYrirW
A5D3jfcGZgwj40Bei+/pw7TjEZ992VmKBe/QiG1khfg4TPLItr02mRnlAaYzgS0u
v6tti2trUUxiPG9R4SAttNH/11OabkiwASIFDbb/0vOsmpzlUOdCIfNu/dJOTJ2f
tWfoGYtE7f59Fpl8Moc8
=ffbi
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
