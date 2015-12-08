Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC0AB1A0F1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 20:05:55 +1100 (AEDT)
Date: Tue, 8 Dec 2015 16:19:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 6/9] KVM: PPC: Replace SPAPR_TCE_SHIFT with
 IOMMU_PAGE_SHIFT_4K
Message-ID: <20151208051934.GR20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o0y1lerN6xYE2ROn"
In-Reply-To: <1442314179-9706-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--o0y1lerN6xYE2ROn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:36PM +1000, Alexey Kardashevskiy wrote:
> SPAPR_TCE_SHIFT is used in few places only and since IOMMU_PAGE_SHIFT_4K
> can be easily used instead, remove SPAPR_TCE_SHIFT.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h | 2 --
>  arch/powerpc/kvm/book3s_64_vio.c         | 3 ++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c      | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index 2aa79c8..7529aab 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -33,8 +33,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shado=
w_vcpu *svcpu)
>  }
>  #endif
> =20
> -#define SPAPR_TCE_SHIFT		12
> -
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
>  #endif
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index b70787d..e347856 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -36,12 +36,13 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
> +#include <asm/iommu.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
>  static long kvmppc_stt_npages(unsigned long window_size)
>  {
> -	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
> +	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 8ae12ac..6cf1ab3 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -99,7 +99,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned l=
ong liobn,
>  	if (ret)
>  		return ret;
> =20
> -	idx =3D ioba >> SPAPR_TCE_SHIFT;
> +	idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
>  	page =3D stt->pages[idx / TCES_PER_PAGE];
>  	tbl =3D (u64 *)page_address(page);
> =20
> @@ -121,7 +121,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  	if (stt) {
>  		ret =3D kvmppc_ioba_validate(stt, ioba, 1);
>  		if (!ret) {
> -			unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> +			unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
>  			struct page *page =3D stt->pages[idx / TCES_PER_PAGE];
>  			u64 *tbl =3D (u64 *)page_address(page);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o0y1lerN6xYE2ROn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZmhmAAoJEGw4ysog2bOSVKAQAK/zLq222TwVIqSsUWAPZM39
VfYDvLZCn2z/XaCqgRSvuENERU7HHWld4bPOACBC/z8pQsaZ0znIIwxKoSPg/wox
mAvt72ll2wjEVXGAdsu2jlaKpwmgXP71hnWPUs0sKb2XFZRG8ktgMaqmatGuaqTB
4F1Iorl6KAXyIX6RxCxNwJkctzVIz/rNIgCwoiEh9W2X7rd110W9KKDs+LB8Ux9C
9zFOY2/nb8oZcmbVtNRMIbxGJY55yY7CBJdsk84qBfPHWCyLOo2zGc0eAWwqgT1z
74FaP8mzn+hzduwPdWkNw5jsjHVjzkHtoo/T39wRpPDf+it2eTpz7G3aQLxUe+pz
DKuTLmN3OkR3220Jt6Z6EitNAByTf29qHrb6mYdbB8zvEKZPfSGSrB9gKKls0l78
stPNkcj70b9HJFcDcyPTWER8xzSxBSpw0iK2dKPoDCDuz341+aCV72NtXzVl7sTw
Z/LBd+cjYfEqWfFeZoaUeZdzdNx3ukY6BjxPxEvDH51eiaTJgoeSgkVSoApP3ZeD
6q1XZcjvTba1hXuawf219phuky/4OyIohnad5wCqfE3ApA0T9t8rEQvQykejijEF
x0me+2qgwD3aXjsVuplYE/TycKf0pCzRwsGaSZLOO3FDvxWgDsNFhQ8lRxQ5awZ3
PXNx6lvumLTQ5N03dKKj
=gIme
-----END PGP SIGNATURE-----

--o0y1lerN6xYE2ROn--
