Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfwty6JHmzDw65
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 14:35:38 +1100 (AEDT)
Date: Fri, 16 Dec 2016 11:57:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 5/9] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20161216005752.GB12146@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <20161208081956.26221-6-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:52PM +1100, Alexey Kardashevskiy wrote:
> VFIO on sPAPR already implements guest memory pre-registration
> when the entire guest RAM gets pinned. This can be used to translate
> the physical address of a guest page containing the TCE list
> from H_PUT_TCE_INDIRECT.
>=20
> This makes use of the pre-registrered memory API to access TCE list
> pages in order to avoid unnecessary locking on the KVM memory
> reverse map as we know that all of guest memory is pinned and
> we have a flat array mapping GPA to HPA which makes it simpler and
> quicker to index into that array (even with looking up the
> kernel page tables in vmalloc_to_phys) than it is to find the memslot,
> lock the rmap entry, look up the user page tables, and unlock the rmap
> entry. Note that the rmap pointer is initialized to NULL where declared
> (not in this patch).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Hrm.  So, pinning all of guest memory is the usual case, but nothing
in the pre-registration APIs actually guarantees that.  Now I think
this patch is still correct because..

> ---
> Changes:
> v2:
> * updated the commit log with Paul's comment
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 65 ++++++++++++++++++++++++++++---=
------
>  1 file changed, 49 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index d461c440889a..a3be4bd6188f 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -180,6 +180,17 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long=
 gpa,
>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
> +{
> +	return mm_iommu_preregistered(vcpu->kvm->mm);
> +}
> +
> +static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
> +		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
> +{
> +	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
> @@ -260,23 +271,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> -		return H_TOO_HARD;
> +	if (kvmppc_preregistered(vcpu)) {
> +		/*
> +		 * We get here if guest memory was pre-registered which
> +		 * is normally VFIO case and gpa->hpa translation does not
> +		 * depend on hpt.
> +		 */
> +		struct mm_iommu_table_group_mem_t *mem;
> =20
> -	rmap =3D (void *) vmalloc_to_phys(rmap);
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> +			return H_TOO_HARD;

=2E.this will fail if the relevant chunk of memory has not been
pre-registered and you'll fall back to the virtual mode version.  The
commit message doesn't make that terribly clear though.

> -	/*
> -	 * Synchronize with the MMU notifier callbacks in
> -	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> -	 * While we have the rmap lock, code running on other CPUs
> -	 * cannot finish unmapping the host real page that backs
> -	 * this guest real page, so we are OK to access the host
> -	 * real page.
> -	 */
> -	lock_rmap(rmap);
> -	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> -		ret =3D H_TOO_HARD;
> -		goto unlock_exit;
> +		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> +		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
> +			return H_TOO_HARD;
> +	} else {
> +		/*
> +		 * This is emulated devices case.
> +		 * We do not require memory to be preregistered in this case
> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
> +		 */
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +			return H_TOO_HARD;

If I follow correctly you could also fall back to this path in the
failing case, but I guess there's probably not advantage to doing so.

> +		rmap =3D (void *) vmalloc_to_phys(rmap);
> +
> +		/*
> +		 * Synchronize with the MMU notifier callbacks in
> +		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> +		 * While we have the rmap lock, code running on other CPUs
> +		 * cannot finish unmapping the host real page that backs
> +		 * this guest real page, so we are OK to access the host
> +		 * real page.
> +		 */
> +		lock_rmap(rmap);
> +		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> +			ret =3D H_TOO_HARD;
> +			goto unlock_exit;
> +		}
>  	}
> =20
>  	for (i =3D 0; i < npages; ++i) {
> @@ -290,7 +322,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	}
> =20
>  unlock_exit:
> -	unlock_rmap(rmap);
> +	if (rmap)
> +		unlock_rmap(rmap);
> =20
>  	return ret;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUzwOAAoJEGw4ysog2bOSyicQAILeRDmAO1XhPsndmfBNNpwb
G07Z/CUTj9+WQChHDUJxEfxzNWChvGcrrExkC+oA6SeoeMzEqAmhI1+iFcgw2SK6
BiU5Mr1qQWDfQ5hhrQYMny8YLxYSdLGITQlhfcI/25AtFYDC+xZ/Vu3Y5nTHbMWW
m27g67gBjmCg2bgl6NXiCq0qeoSj57iHq++ZvSbzu95e1IgBEeyw+bMBrV7tcQLx
Y3ISOmedH6bZwon/Me9fmypateHw9dwisuebh2D+L8uBoF0uJyAyQQXnsEUJ+byH
qV0UFgkLXt4SI36UPQk/hSc9zUv37LFmoFt5p8e+ekhVtBnkrmLZFjhlVZazfSGK
XOsIkApWlSVUPgqFc412BEy/yEW+bk2CeqJy/wfDYO85HjEVMOZXsWcD2EvFJ5Ot
U9s8uPuKYND2F1C4pst2rB8F93ktvMH8Nlz68iknjeSLENPxR4ieAZAz9KYGvPU6
lgimyEwoIRpkx9a2Zl792MQiXwMZXuh+udmUDvJguLANVOwOZC+0PBdrwlPvVdNd
ywXxXcjWplouo2NeQamQC/NxtV2Xogymr89Q4WlUNDAaafAzPxaAcgMayUsh+Er3
WJSYbXjgx3JxfFeHBYzxUaQyyG7PCgn1/EEWvvR4CmKuedlD8I7AyoeEjFr86d+2
yci+LRdEivD3lK3sImUJ
=2uqL
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
