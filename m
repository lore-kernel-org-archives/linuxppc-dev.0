Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: kdump: Fix NULL pointer dereference in
	irq disable code
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100511022329.GE12203@kryten>
References: <20100511022329.GE12203@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-yx9W7Dzj8myQOC4G/UQg"
Date: Tue, 11 May 2010 14:14:47 +1000
Message-ID: <1273551287.9209.136.camel@concordia>
Mime-Version: 1.0
Cc: mikey@neuling.org, miltonm@bga.com, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-yx9W7Dzj8myQOC4G/UQg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 12:23 +1000, Anton Blanchard wrote:
> With sparse irqs we have to check if we have a descriptor before derefere=
ncing
> it.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 6f4613d..5182439 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -375,6 +375,9 @@ void default_machine_crash_shutdown(struct pt_regs *r=
egs)
>  	for_each_irq(i) {
>  		struct irq_desc *desc =3D irq_to_desc(i);
> =20
> +		if (!desc)
> +			continue;
> +
>  		if (desc->status & IRQ_INPROGRESS)
>  			desc->chip->eoi(i);
> =20

Ouch, my bad.

cheers

--=-yx9W7Dzj8myQOC4G/UQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvo2bcACgkQdSjSd0sB4dLoSwCdEmk1RCkPg4K8hm4VUUYnzyVa
UiUAmwbBm+RPiT6yqgPEYPrqrQkuKF9X
=ppf3
-----END PGP SIGNATURE-----

--=-yx9W7Dzj8myQOC4G/UQg--
