Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31F21DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 11:46:43 +1000 (EST)
Subject: Re: [PATCH 2/8] powerpc: share .data output section definition
	between 32 and 64 bits.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tim Abbott <tabbott@MIT.EDU>
In-Reply-To: <1241135777-9462-3-git-send-email-tabbott@mit.edu>
References: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
	<1241135777-9462-2-git-send-email-tabbott@mit.edu>
	<1241135777-9462-3-git-send-email-tabbott@mit.edu>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-pBD/crFb9Rr12ewOtvDp"
Date: Fri, 01 May 2009 11:46:42 +1000
Message-Id: <1241142402.6928.7.camel@concordia>
Mime-Version: 1.0
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>, Waseem Daher <wdaher@MIT.EDU>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pBD/crFb9Rr12ewOtvDp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-30 at 19:56 -0400, Tim Abbott wrote:
> Since upcoming changes will add several more common pieces of code
> between the 32-bit and 64-bit powerpc architectures, it seems best to
> unify these two blocks.
>=20
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/kernel/vmlinux.lds.S |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmli=
nux.lds.S
> index a047a6c..47899b0 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -220,20 +220,19 @@ SECTIONS
>  	. =3D ALIGN(PAGE_SIZE);
>  	_sdata =3D .;
> =20
> -#ifdef CONFIG_PPC32
>  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
>  		DATA_DATA
> +#ifdef CONFIG_PPC32
>  		*(.sdata)
>  		*(.got.plt) *(.got)
> -	}
>  #else
> -	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> -		DATA_DATA
>  		*(.data.rel*)
>  		*(.toc1)
>  		*(.branch_lt)
> +#endif
>  	}
> =20
> +#ifndef CONFIG_PPC32
>  	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
>  		*(.opd)
>  	}

This would be clearer in the positive, as in #ifdef CONFIG_PPC64.

cheers

--=-pBD/crFb9Rr12ewOtvDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn6VIIACgkQdSjSd0sB4dLK4gCghtUKdXXhmpo3+W67QRfXzAYP
2GwAoKwQHum+aOUJCFgwDYIt3A8gTlGy
=mqSI
-----END PGP SIGNATURE-----

--=-pBD/crFb9Rr12ewOtvDp--
