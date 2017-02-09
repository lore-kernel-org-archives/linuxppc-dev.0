Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJlpb1P8VzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 15:44:07 +1100 (AEDT)
Date: Thu, 9 Feb 2017 15:00:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v4 09/10] KVM: PPC: Use preregistered memory API
 to access TCE list
Message-ID: <20170209040051.GB14524@umbus>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-10-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <20170207071711.28938-10-aik@ozlabs.ru>
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

On Tue, Feb 07, 2017 at 06:17:10PM +1100, Alexey Kardashevskiy wrote:
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
> entry. Note that the rmap pointer is initialized to NULL
> where declared (not in this patch).
>=20
> If a requested chunk of memory has not been preregistered, this will
> fall back to non-preregistered case and lock rmap.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v4:
> * removed oneline inlines
> * now falls back to locking rmap if TCE list is not in preregistered memo=
ry
>=20
> v2:
> * updated the commit log with David's comment
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 58 +++++++++++++++++++++++++++----=
------
>  1 file changed, 42 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index f8a54b7c788e..dc1c66fda941 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -239,6 +239,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	long i, ret =3D H_SUCCESS;
>  	unsigned long tces, entry, tce, ua =3D 0;
>  	unsigned long *rmap =3D NULL;
> +	bool prereg =3D false;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
> @@ -259,23 +260,47 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> -		return H_TOO_HARD;
> +	if (mm_iommu_preregistered(vcpu->kvm->mm)) {
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
> =20
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
> +		mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
> +		if (mem)
> +			prereg =3D mm_iommu_ua_to_hpa_rm(mem, ua, &tces) =3D=3D 0;
> +	}
> +
> +	if (!prereg) {
> +		/*
> +		 * This is usually a case of a guest with emulated devices only
> +		 * when TCE list is not in preregistered memory.
> +		 * We do not require memory to be preregistered in this case
> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
> +		 */
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +			return H_TOO_HARD;
> +
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
> @@ -293,7 +318,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
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

iQIcBAEBCAAGBQJYm+lzAAoJEGw4ysog2bOSZ70QANU7nvSTjN1C8vVevtHcu5Vl
gtS2R+yqbmpNfnXjBm/ie9vmucQsvugteKsn5em2EUEZqmN7uHikIXeA15MnQbZW
ookYMQ9oj2KZosG4sGwBxkHgWAcqYpN8KHYlwH0nXqFaXeFs4RYtRPvnyockc+CG
i0ckuRTeucU8YXAQAdDVW9IHGOEOxdxNwRu6JoNawRP7NKDVwAYjOfRMjCZCbwTd
vGeqF548lrhe95e27ThRFJRrV2tPMIGJ/VRC9NnWoVuglaSzrklKl7DNKnTTPJeX
Jy3iMb9XVfAIXuCaKYYxwyCfw3ZsNaWsbzH4c99kgaXuqTETrFfRWYrnxVHygQEk
xkgAKoyy5kW840eIeI56OLfEJtc7vK97tplQZduPeB0H69YBi2DA2YtM37gXtAjQ
CxltCvVhvrwubXO5yb98DN9/0Os8gwKfhK8Zq4yaWITD6tk+NHbTw2xnKvi+7Dmd
Cq39sbd2Wm/zGmIWZnwAKZTbceufaROYKaiz+5ACnqw2GUMI137AnDGMGnhmkWbp
n6Imi5OckyiVpmNpjI2uF2ZwQoVLcFgc4jNIPRh7/StIBpZq8WYHEA+vgT8HQ1CV
/hBu2fd2OWNPk55Loailo+IOj15LdI4IHX8YKZ2YMtcA0zPmiLH6HymIGrgcHCJe
Cjkr1cC7kUNZn7KK05wF
=YIta
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
