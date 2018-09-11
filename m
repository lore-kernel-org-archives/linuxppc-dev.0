Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428VRl2Fc5zF321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 13:16:03 +1000 (AEST)
Date: Tue, 11 Sep 2018 13:15:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Remove redundand permission bits
 removal
Message-ID: <20180911031545.GJ7978@umbus.fritz.box>
References: <20180910082912.13255-1-aik@ozlabs.ru>
 <20180910082912.13255-7-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
In-Reply-To: <20180910082912.13255-7-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 06:29:12PM +1000, Alexey Kardashevskiy wrote:
> The kvmppc_gpa_to_ua() helper itself takes care of the permission
> bits in the TCE and yet every single caller removes them.
>=20
> This changes semantics of kvmppc_gpa_to_ua() so it takes TCEs
> (which are GPAs + TCE permission bits) to make the callers simpler.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * %s/kvmppc_gpa_to_ua/kvmppc_tce_to_ua/g
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
>  arch/powerpc/kvm/book3s_64_vio.c    | 12 ++++--------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 22 +++++++++-------------
>  3 files changed, 14 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 2f5d431..38d0328 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -194,7 +194,7 @@ extern struct kvmppc_spapr_tce_table *kvmppc_find_tab=
le(
>  		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
>  				(stt)->size, (ioba), (npages)) ?        \
>  				H_PARAMETER : H_SUCCESS)
> -extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +extern long kvmppc_tce_to_ua(struct kvm *kvm, unsigned long tce,
>  		unsigned long *ua, unsigned long **prmap);
>  extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
>  		unsigned long idx, unsigned long tce);
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 8231b17..c0c64d1 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -378,8 +378,7 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_t=
ce_table *stt,
>  	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_TOO_HARD;
> =20
> -	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +	if (kvmppc_tce_to_ua(stt->kvm, tce, &ua, NULL))
>  		return H_TOO_HARD;
> =20
>  	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> @@ -552,8 +551,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
> =20
>  	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> =20
> -	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> -			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL)) {
> +	if ((dir !=3D DMA_NONE) && kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))=
 {
>  		ret =3D H_PARAMETER;
>  		goto unlock_exit;
>  	}
> @@ -614,7 +612,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		return ret;
> =20
>  	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> +	if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
>  		ret =3D H_TOO_HARD;
>  		goto unlock_exit;
>  	}
> @@ -649,9 +647,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		}
>  		tce =3D be64_to_cpu(tce);
> =20
> -		if (kvmppc_gpa_to_ua(vcpu->kvm,
> -				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +		if (kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index adf3b21..389dac1 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -110,8 +110,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spap=
r_tce_table *stt,
>  	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_PARAMETER;
> =20
> -	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +	if (kvmppc_tce_to_ua(stt->kvm, tce, &ua, NULL))
>  		return H_TOO_HARD;
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> @@ -180,10 +179,10 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *=
stt,
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_tce_put);
> =20
> -long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +long kvmppc_tce_to_ua(struct kvm *kvm, unsigned long tce,
>  		unsigned long *ua, unsigned long **prmap)
>  {
> -	unsigned long gfn =3D gpa >> PAGE_SHIFT;
> +	unsigned long gfn =3D tce >> PAGE_SHIFT;
>  	struct kvm_memory_slot *memslot;
> =20
>  	memslot =3D search_memslots(kvm_memslots(kvm), gfn);
> @@ -191,7 +190,7 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long =
gpa,
>  		return -EINVAL;
> =20
>  	*ua =3D __gfn_to_hva_memslot(memslot, gfn) |
> -		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
> +		(tce & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	if (prmap)
> @@ -200,7 +199,7 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long =
gpa,
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> +EXPORT_SYMBOL_GPL(kvmppc_tce_to_ua);
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  static long iommu_tce_xchg_rm(struct mm_struct *mm, struct iommu_table *=
tbl,
> @@ -389,8 +388,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  		return ret;
> =20
>  	dir =3D iommu_tce_direction(tce);
> -	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> -			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> +	if ((dir !=3D DMA_NONE) && kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
>  		return H_PARAMETER;
> =20
>  	entry =3D ioba >> stt->page_shift;
> @@ -492,7 +490,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		 */
>  		struct mm_iommu_table_group_mem_t *mem;
> =20
> -		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> +		if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>  			return H_TOO_HARD;
> =20
>  		mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
> @@ -508,7 +506,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		 * We do not require memory to be preregistered in this case
>  		 * so lock rmap and do __find_linux_pte_or_hugepte().
>  		 */
> -		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +		if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>  			return H_TOO_HARD;
> =20
>  		rmap =3D (void *) vmalloc_to_phys(rmap);
> @@ -542,9 +540,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> =20
>  		ua =3D 0;
> -		if (kvmppc_gpa_to_ua(vcpu->kvm,
> -				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +		if (kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXM2EACgkQbDjKyiDZ
s5Lc1A//WFWfh0hMhz6frBhyKqlaWVqB964M3kfyzLDV5ce/5VIfnqclHxblKz1P
UsZV4etSdORrW/ZzpEQOukuPkPMHFE8uCsRVC6Ox3R2569ICd1XPIVEiMXBPTaLI
RMutyFZtegdeDxbrMpBxsWEQLy2tk2b1uBuWY3mLIqNujkr6rYGTIji/NIc0PYvT
JdkWRPqd4tXJpsjELihjgJWEgAf42/3Abs3tdw3nwwqk96V+FiirMiw2iDYIv7+Y
K0NYbdRLR8pFh9Znm8tciBtAvyDI2bq/GtRG2HjMZBQO3/hCbmQtwWlFHUiw0l/i
FhaEXSVF+pVd4zJ76UhiwnNxmN61Kw2jtOfJxTYTdCM0wjPDvnxQHV6kgCgw+7Xb
eKobWcQ+3MOVc/IaRDoPrIyFUZAR7IoQS1B+/3AIoEsmZSQDNAwiQ8oSt/GabpYn
B1ICct0Mcqo2coZw1EBHvecoCJd/NKj0NSfo7aazNvFXwxVWOuZ+YI1HeAYkSlB7
ao5IR3vHL90ti8UxVSiX9pemeG0E1r4bySh8A3PIty6P2BctQvuxEgSXfhajxB8w
VuU9VHKAO/9EQAtRmsHoweats3EDn0nXrcrVqt2/5PCv+17wpj9qYA6UXF1NBRkn
vIvF6oygfzDJKGhRRJYmyQjqjv6Tze4p0Hif9KXpxJMk95lIEOI=
=L4GF
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
