Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42184y1m2gzF36Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 14:04:18 +1000 (AEST)
Date: Thu, 30 Aug 2018 14:01:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 2/4] KVM: PPC: Inform the userspace about TCE
 update failures
Message-ID: <20180830040127.GH2222@umbus.fritz.box>
References: <20180830031647.34134-1-aik@ozlabs.ru>
 <20180830031647.34134-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
In-Reply-To: <20180830031647.34134-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 01:16:45PM +1000, Alexey Kardashevskiy wrote:
> We return H_TOO_HARD from TCE update handlers when we think that
> the next handler (realmode -> virtual mode -> user mode) has a chance to
> handle the request; H_HARDWARE/H_CLOSED otherwise.
>=20
> This changes the handlers to return H_TOO_HARD on every error giving
> the userspace an opportunity to handle any request or at least log
> them all.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++----
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 0fef22b..3e8ac98 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -401,7 +401,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
>  	long ret;
> =20
>  	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
> -		return H_HARDWARE;
> +		return H_TOO_HARD;
> =20
>  	if (dir =3D=3D DMA_NONE)
>  		return H_SUCCESS;
> @@ -449,15 +449,15 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struc=
t iommu_table *tbl,
>  		return H_TOO_HARD;
> =20
>  	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
> -		return H_HARDWARE;
> +		return H_TOO_HARD;
> =20
>  	if (mm_iommu_mapped_inc(mem))
> -		return H_CLOSED;
> +		return H_TOO_HARD;
> =20
>  	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
>  	if (WARN_ON_ONCE(ret)) {
>  		mm_iommu_mapped_dec(mem);
> -		return H_HARDWARE;
> +		return H_TOO_HARD;
>  	}
> =20
>  	if (dir !=3D DMA_NONE)
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 7ab6f3f..9584d9b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -277,10 +277,10 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *=
kvm, struct iommu_table *tbl,
> =20
>  	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
>  			&hpa)))
> -		return H_HARDWARE;
> +		return H_TOO_HARD;
> =20
>  	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
> -		return H_CLOSED;
> +		return H_TOO_HARD;
> =20
>  	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>  	if (ret) {
> @@ -478,7 +478,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
> =20
>  		rmap =3D (void *) vmalloc_to_phys(rmap);
>  		if (WARN_ON_ONCE_RM(!rmap))
> -			return H_HARDWARE;
> +			return H_TOO_HARD;
> =20
>  		/*
>  		 * Synchronize with the MMU notifier callbacks in

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHbBcACgkQbDjKyiDZ
s5Ke4RAA18x5B01fmWmhE5/5lrduv2+tyrs+uzv7Bm93hlYqQ24gYsi+Pns1zQZI
detCa4SJIYvTAHMNQ12PeHVlxRqY3R60Glp3QzwCI0d2KX4nbM1OtlV7KxxXIVoH
U76NlddNhJHYjv79720QFkiWthVRo3uXUsQmFSEtqmWhIKRCzTXG8B+taQI34JBd
VwFhAB4d3H4l2ZO7IGhaQMxoEY/+9laBdEqPfy0A4yDwt1/vljNcnFhGLQzhtOcR
uLSxHbS1YvxxhH12yOPMYDySZ2czBAaMXXBOtGWcznaKhUKmMd34eTWge32wRYga
f+OfXi80Q81NfR11g0qlIOoPtJyFMtVuWM/D4/da/Vhudhc5ZR47WkzIF3lZFTMI
0Yxo/qKHe9nOnyrz4xyCMr//GMs71auzG143V+pN/QnxAtMg64gQV9929g2CsM5Y
Pwz48MuoZLxIcbaLuLfq0AcD9OIphCeJOHhsbokKOnQNYaXNYTeXSls2cNtdUOQd
fNXJnyPszCXiX39mTHI8F9nCiJYtA+g1w/1wSaDgrgVKbiV4v46193Ejj5E4UbDe
/dmpMzaO8v8CHiaRdklwwJMsYCTak4UzcegISz01XdwDnTCIN0jZeR/U598RGhnA
2zH31pumf2oHQa7H065mZ9kbl96xLMt4YdccDspa6wtRrwtuV84=
=pevi
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
