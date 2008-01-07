Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A8CCBDDEA2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 10:10:39 +1100 (EST)
Date: Tue, 8 Jan 2008 10:10:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 3/3] USB device tree cleanups
Message-Id: <20080108101028.db21d18a.sfr@canb.auug.org.au>
In-Reply-To: <1199707400-23588-3-git-send-email-leoli@freescale.com>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<1199707400-23588-2-git-send-email-leoli@freescale.com>
	<1199707400-23588-3-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_10_10_28_+1100_dY57xY4UufGyUnWX"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_10_10_28_+1100_dY57xY4UufGyUnWX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Jan 2008 20:03:20 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -533,9 +533,7 @@ static int __init fsl_usb_of_init(void)
>  		*usb_dev_dr_client =3D NULL;
>  	int ret;
> =20
> -	for (np =3D NULL, i =3D 0;
> -	     (np =3D of_find_compatible_node(np, "usb", "fsl-usb2-mph")) !=3D N=
ULL;
> -	     i++) {
> +	for_each_compatible_node(np, NULL, "fsl-usb2-mph") {

'i' is no longer being updated (or indeed set to anything) but is still
used in the loop - at least in Paulus' current tree).

>  		struct resource r[2];
>  		struct fsl_usb2_platform_data usb_data;
>  		const unsigned char *prop =3D NULL;
> @@ -580,9 +578,7 @@ static int __init fsl_usb_of_init(void)
>  			goto unreg_mph;
>  	}
> =20
> -	for (np =3D NULL;
> -	     (np =3D of_find_compatible_node(np, "usb", "fsl-usb2-dr")) !=3D NU=
LL;
> -	     i++) {
> +	for_each_compatible_node(np, NULL, "fsl-usb2-dr") {

Same here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_10_10_28_+1100_dY57xY4UufGyUnWX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgrFoTgG2atn1QN8RAstvAJ9oMtQl/fHt3k5H9+E4z9PGEFwNmgCgkc+C
O0XMTWoc6p+NCSkB6PbbO+M=
=d1R8
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_10_10_28_+1100_dY57xY4UufGyUnWX--
