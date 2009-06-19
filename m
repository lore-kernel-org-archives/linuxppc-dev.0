Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A3554B7304
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:24:22 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E7E4DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 18:24:22 +1000 (EST)
Subject: Re: [PATCH] of_serial: Add UPF_FIXED_TYPE flag
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Mitchell <dmitchell@amcc.com>
In-Reply-To: <1244590787-13716-1-git-send-email-dmitchell@amcc.com>
References: <1244590787-13716-1-git-send-email-dmitchell@amcc.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-3EWuDwg2BNnXjDzAL1Jc"
Date: Fri, 19 Jun 2009 18:24:21 +1000
Message-Id: <1245399861.10629.194.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3EWuDwg2BNnXjDzAL1Jc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-09 at 18:39 -0500, Dave Mitchell wrote:
> This patch adds the UPF_FIXED_TYPE flag which will bypass the
> 8250's autoconfig probe for uart type. The uart type identified
> by the of_serial's parse of the flat device tree will be utilized
> as defined.
>=20
> Signed-off-by: Dave Mitchell <dmitchell@amcc.com>
> ---
>  drivers/serial/of_serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> index 14f8fa9..3f2027c 100644
> --- a/drivers/serial/of_serial.c
> +++ b/drivers/serial/of_serial.c
> @@ -67,7 +67,7 @@ static int __devinit of_platform_serial_setup(struct of=
_device *ofdev,
>  	port->type =3D type;
>  	port->uartclk =3D *clk;
>  	port->flags =3D UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
> -		| UPF_FIXED_PORT;
> +		| UPF_FIXED_PORT | UPF_FIXED_TYPE;

I think we /probably/ want a similar change in legacy_serial.c, for soc
ports at least.

Or do people have things that are compatible "ns16550" but aren't?

cheers

--=-3EWuDwg2BNnXjDzAL1Jc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko7SzUACgkQdSjSd0sB4dJlpACeMCwp6pGrh6VagC7sN5Be62zr
QH8An04CwXXTVjrOE0QTeYgQxYG7s8bp
=TYfW
-----END PGP SIGNATURE-----

--=-3EWuDwg2BNnXjDzAL1Jc--
