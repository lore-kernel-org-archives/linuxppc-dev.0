Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427wb33FGFzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 14:50:23 +1000 (AEST)
Date: Mon, 10 Sep 2018 14:50:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel] KVM: PPC: Remove redundand permission bits removal
Message-ID: <20180910045018.GE24181@umbus.fritz.box>
References: <20180906095146.43981-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
In-Reply-To: <20180906095146.43981-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 07:51:46PM +1000, Alexey Kardashevskiy wrote:
> The kvmppc_gpa_to_ua() helper itself takes care of the permission
> bits in the TCE and yet every single caller removes them.
>=20
> This changes semantics of kvmppc_gpa_to_ua() so it takes TCEs
> (which are GPAs + TCE permission bits) to make the callers simpler.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Hmm.  I like shrinking the code, but it bothers me that a function
called simply kvmppc_gpa_to_ua() knows something about a TCE's
internal format.

I think either the TCE bit masking needs to happen in the callers, or
that function needs a name change.  Maybe kvmppc_tce_to_ua()?

> ---
>=20
> This is not related to any bug, just noticed this while doing other thing=
s.
>=20
> I can also rename kvmppc_gpa_to_ua() if it makes more sense, does not it?
>=20
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 10 +++-------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 16 ++++++----------
>  2 files changed, 9 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 174299d..7207481 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -378,8 +378,7 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_t=
ce_table *stt,
>  	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_TOO_HARD;
> =20
> -	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +	if (kvmppc_gpa_to_ua(stt->kvm, tce, &ua, NULL))
>  		return H_TOO_HARD;
> =20
>  	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> @@ -553,8 +552,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
> =20
>  	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> =20
> -	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> -			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL)) {
> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))=
 {
>  		ret =3D H_PARAMETER;
>  		goto unlock_exit;
>  	}
> @@ -647,9 +645,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		}
>  		tce =3D be64_to_cpu(tce);
> =20
> -		if (kvmppc_gpa_to_ua(vcpu->kvm,
> -				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 5f810dc..a03cd93 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -110,8 +110,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spap=
r_tce_table *stt,
>  	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_PARAMETER;
> =20
> -	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +	if (kvmppc_gpa_to_ua(stt->kvm, tce, &ua, NULL))
>  		return H_TOO_HARD;
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> @@ -180,10 +179,10 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *=
stt,
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_tce_put);
> =20
> -long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long tce,
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
> @@ -366,8 +365,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  		return ret;
> =20
>  	dir =3D iommu_tce_direction(tce);
> -	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
> -			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
>  		return H_PARAMETER;
> =20
>  	entry =3D ioba >> stt->page_shift;
> @@ -520,9 +518,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> =20
>  		ua =3D 0;
> -		if (kvmppc_gpa_to_ua(vcpu->kvm,
> -				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> -				&ua, NULL))
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV+AoACgkQbDjKyiDZ
s5KASA/+N6lfabp98nE2jmLr+YCE10nx8Cwc/cuu9Oq4yz+W4CXJ1MlvgeckFR6y
TpntPDQAtW0QlHfNrtW1b5nWzgiQBKn9PucjVo86Qb5FIlCO2tmalds3Kr26D+mR
rMO1zG8AZ6BMuBdyfHUWNZfyL6ddbgRu/0CuEgxnxkxrzIe5Lfa3oWN6CrfB04wU
z9heSq8xkU6IrJGbk3TPo4G6NV8RpR94VHxMwbGiNrgI8chHzjpq7pfBe1srgfKh
MOUG6LLbFYqHisoolLxgbCUF3Ozloo5fDKH1+Bel3fv0As6ql6PLVsBChBQ27nn0
nK0auVA1y9INfItH60lVL3Hco6Ez3RarwSbarj82q2y+mVPnBb11dycafEC/Gqk3
PUVlgjyrRZA1SHcLmy64D/6Sizi2aZloWF4Xal7BTvBigna2w6ApKDpqHmDIjEqi
FiZo6Gkq0u2cmDiHTm9CGFeeGiFpTIOpwQVnFD7sET9b94fNU94Ey/aVsO0F43Lg
wqID4Mc5QDC074++/KBxSRBIjMmb3Jwsot39eVUAo1qbFi34VTXFygmW6BUznhTc
sz61+TX4r4KUxpVyFD5Wb6Fw3OSPreIMZc4l73RX4SanAIuUatcveXSorSvHTRtT
tuUqTxo3H8PGKuqDJ/xz1afdaX710tggE9aOjTf4o1r9QWy5tnY=
=G+Bf
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
