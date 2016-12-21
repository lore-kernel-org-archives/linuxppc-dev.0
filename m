Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk1Xq57j0zDwVC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 15:15:39 +1100 (AEDT)
Date: Wed, 21 Dec 2016 15:08:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 05/11] KVM: PPC: Use preregistered memory API
 to access TCE list
Message-ID: <20161221040843.GD13024@umbus.fritz.box>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
In-Reply-To: <20161218012900.18142-6-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 18, 2016 at 12:28:54PM +1100, Alexey Kardashevskiy wrote:
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
> If a requested chunk of memory has not been preregistered,
> this will fail with H_TOO_HARD so the virtual mode handle can
> handle the request.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * updated the commit log with David's comment
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

I don't see that there's much point to these inlines.

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
> +		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> +		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
> +			return H_TOO_HARD;
> +	} else {
> +		/*
> +		 * This is emulated devices case.
> +		 * We do not require memory to be preregistered in this case
> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
> +		 */

Hmm.  So this isn't wrong as such, but the logic and comments are
both misleading.  The 'if' here isn't really about VFIO vs. emulated -
it's about whether the mm has *any* preregistered chunks, without any
regard to which particular device you're talking about.  For example
if your guest has two PHBs, one with VFIO devices and the other with
emulated devices, then the emulated devices will still go through the
"VFIO" case here.

Really what you have here is a fast case when the tce_list is in
preregistered memory, and a fallback case when it isn't.  But that's
obscured by the fact that if for whatever reason you have some
preregistered memory but it doesn't cover the tce_list, then you don't
go to the fallback case here, but instead fall right back to the
virtual mode handler.

So, I think you should either:
    1) Fallback to the code below whenever you can't access the
       tce_list via prereg memory, regardless of whether there's any
       _other_ prereg memory
or
    2) Drop the code below entirely and always return H_TOO_HARD if
       you can't get the tce_list from prereg.

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

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWgBIAAoJEGw4ysog2bOSJR4QAJz2jGYAIBmxoPLghllE1Pef
pwr+TC7yXe2BaeiigOmeQGKwDAwpMmXLajlQpZM6fhXgolQGjZK4Jua4CuGMCRoN
WRuDrK9QX1nkRkohtu6DaAb2zKNV0/r4kEXHRFDmX4sy26QUmTiZcbsk/DY8Yqao
nKvp/oEt8DyazOwJy/bmRYV/8doRJ3Bn0jx7d01a0/Mee5VLkv8mdc0WBrNIMgqO
XlIC5iZAdWK8fU3qxIDl2eQUfJo0VjAmy9NFq0kTl2zFwmUtHzWyCJ4znlmf8A4P
jwgfQBhxMPtmPeBAP2q+tcLKGHF1ZIE89wx3WNPibLkokqIpr+81tpS6VmeRgrJo
srFoNkCRkzCV4gyPJzlbWrfeGyW6qE2iGQhoLAnGjIW5oCZ2A6I/Drp7Jwrgju4H
bluFeLtzbkwwfKD9gUQLvVKKvIy8uAku+UuVb44MMaV9LHQJfpx9JWLVMzu455Vs
AqvVDYxnEQAdXbcuL7CYt1yHQh++wiwQrNZqPU2tPNMhZ36/y5rOTxKip6BIJItT
kzFlFBEljeLJYZfSIO9kKjdJ+u8d6qsrmty9cHAaIfl9Dc7QYvl51FYGN/x57gx0
CWtHw86QfbRwyBT+85nmTfjvxV3mtxxLeDHKXIVADGwfMZGijx00sp3fsH9hz5pe
U8qSlK+A7e/2/dU+0GYG
=sVq9
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
