Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78AFA1A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:36:33 +1100 (AEDT)
Date: Mon, 25 Jan 2016 16:33:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/4] KVM: PPC: Add @offset to kvmppc_spapr_tce_table
Message-ID: <20160125053309.GD32205@voom.redhat.com>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
In-Reply-To: <1453364126-22527-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 07:15:25PM +1100, Alexey Kardashevskiy wrote:
> This enables userspace view of TCE tables to start from non-zero offset
> on a bus. This will be used for huge DMA windows.

Again I'd like the commit message adjusted to clarify the fact that
this has internal changes only which will need interface changes to
actually use.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_host.h | 1 +
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index a4ed9f5..8769f91 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -185,6 +185,7 @@ struct kvmppc_spapr_tce_table {
>  	u64 liobn;
>  	struct rcu_head rcu;
>  	u32 page_shift;
> +	u64 offset;		/* in pages */
>  	u64 size;		/* in pages */
>  	struct page *pages[0];
>  };
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 01ef9f9..0e66459 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -75,7 +75,8 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table=
 *stt,
>  	unsigned long mask =3D ~((1ULL << stt->page_shift) - 1);
>  	unsigned long idx =3D ioba >> stt->page_shift;
> =20
> -	if ((ioba & ~mask) || (idx + npages > stt->size))
> +	if ((ioba & ~mask) || (idx < stt->offset) ||
> +			(idx - stt->offset + npages > stt->size))
>  		return H_PARAMETER;
> =20
>  	return H_SUCCESS;
> @@ -147,6 +148,7 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *st=
t,
>  	struct page *page;
>  	u64 *tbl;
> =20
> +	idx -=3D stt->offset;
>  	page =3D stt->pages[idx / TCES_PER_PAGE];
>  	tbl =3D kvmppc_page_address(page);
> =20
> @@ -324,7 +326,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	idx =3D ioba >> stt->page_shift;
> +	idx =3D (ioba >> stt->page_shift) - stt->offset;
>  	page =3D stt->pages[idx / TCES_PER_PAGE];
>  	tbl =3D (u64 *)page_address(page);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpbOVAAoJEGw4ysog2bOSfI8P/jh3IdsZwQMhZmIGQU8DB8ld
Avpb0yB9yFvwtnTOx2k00bHvi7GUZxAigfGfnJmycXGXKq6/1/klSKziTImmvrx4
8bM0VNyceMPrJv6De7QfME9x/t7tFia8D5VDDOSF5c+k7H0iKt0omsXnCLtERvML
DX9R/f22Xzc29Wh4WNSR1e8Fj8cbNixRLHtTk9Yrxb7eWwXsR3HP2vPB06YjxN7v
PaZxfT7aQlw4o2OTQeZqrfUHSOlwdmyj3OYzN48mkQPWOPdnMrYmsU9vPNBl7BsL
E7BJ79V5lp+rWNcR3HxNgV/R0/L7o8tSmRdqiBoiQjPtGG9n+6yy8yFrqX0c0+s+
MJJnjX0ANW3AR1sZj+0qBSEdfI8EBl4kzIeKxQbTB/wHKTek9nC3END8/n456Tkp
SfppoEj8rKSqqouj6Sv52fo+Du0f54XWKVnH27nwyadx/UZ+j3HCVbNoCDgFochS
2AdAdlcTAH7vLlaqo2i3eRCuLnfchKW6CVrrhuSa79DC7xhR2bj4ewuX/UAWKNKI
//k6GkyIwQNdsQTGgZrHl8gUbdLkBK75dvIvnFm6xUiWmSQkZCuqEHKWxSsMtbwi
CUnIC9wXJ3ZPGPMIR+O9wNsQgJQlj+PzIYkgAq5LgC0EB6W3C5iwi3UuN0nIYyv1
vTWg7pDBjx1FgLx1QQg3
=Zgxy
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
