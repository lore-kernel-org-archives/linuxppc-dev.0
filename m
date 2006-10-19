Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D426267B61
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 05:15:04 +1000 (EST)
Date: Thu, 19 Oct 2006 23:14:55 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: kalle.pokki@iki.fi
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation
Message-ID: <20061019231455.0ea159e1@localhost.localdomain>
In-Reply-To: <Pine.OSF.4.61.0610191525580.318096@kosh.hut.fi>
References: <Pine.OSF.4.61.0610191525580.318096@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_bqz.ZolzuFo52yad_3Ghef3;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_bqz.ZolzuFo52yad_3Ghef3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Oct 2006 15:31:10 +0300 (EEST)
kalle.pokki@iki.fi wrote:

> If there is a frame buffer console, the cpm_uart_init_portdesc()
> function is never called in the compat mode. Also, the set_lineif()
> method is not called in the compat mode.
>=20
for the fbconsole case, I agree we do have  to address it. But not the prop=
osed way.
See below.
=20

> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
> ---
>   drivers/serial/cpm_uart/cpm_uart.h      |    2 +-
>   drivers/serial/cpm_uart/cpm_uart_core.c |    9 ++++-----
>   drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +++++-
>   drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++++-
>   4 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/serial/cpm_uart/cpm_uart.h
> b/drivers/serial/cpm_uart/cpm_uart.h index 3b35cb7..19a6ffe 100644
> --- a/drivers/serial/cpm_uart/cpm_uart.h
> +++ b/drivers/serial/cpm_uart/cpm_uart.h
> @@ -89,7 +89,7 @@ extern struct uart_cpm_port cpm_uart_por
>=20
>   /* these are located in their respective files */
>   void cpm_line_cr_cmd(int line, int cmd);
> -int cpm_uart_init_portdesc(void);
> +int __init cpm_uart_init_portdesc(void);
>   int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int
> is_con); void cpm_uart_freebuf(struct uart_cpm_port *pinfo);
>=20
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
> b/drivers/serial/cpm_uart/cpm_uart_core.c index 8f3b3e5..895f2f1
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1349,11 +1349,8 @@ static int cpm_uart_init(void) {
>   		pr_info("cpm_uart: WARNING: no UART devices found
> on platform bus!\n"); pr_info(
>   		"cpm_uart: the driver will guess configuration, but
> this mode is no longer supported.\n"); -#ifndef
> CONFIG_SERIAL_CPM_CONSOLE
> -		ret =3D cpm_uart_init_portdesc();
> -		if (ret)
> -			return ret;
> -#endif
> +
> +		cpm_uart_init_portdesc();
>=20
And we end up with init_portdesc called unconditionally? this would likely =
break, or at least confuse the
code, that uses platform dev to pass resources offsets.

>   		cpm_reg.nr =3D cpm_uart_nr;
>   		ret =3D uart_register_driver(&cpm_reg);
> @@ -1365,6 +1362,8 @@ #endif
>   			int con =3D cpm_uart_port_map[i];
>   			cpm_uart_ports[con].port.line =3D i;
>   			cpm_uart_ports[con].port.flags =3D
> UPF_BOOT_AUTOCONF;
> +			if (cpm_uart_ports[con].set_lineif)
> +
> cpm_uart_ports[con].set_lineif(&cpm_uart_ports[con]);
> uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port); }
>=20
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> b/drivers/serial/cpm_uart/cpm_uart_cpm1.c index 95afc37..6f04a9f
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> @@ -184,10 +184,14 @@ void cpm_uart_freebuf(struct uart_cpm_po
>   }
>=20
>   /* Setup any dynamic params in the uart desc */
> -int cpm_uart_init_portdesc(void)
> +int __init cpm_uart_init_portdesc(void)
>   {
>   	pr_debug("CPM uart[-]:init portdesc\n");
>=20
> +	/* Don't run this again, if the console driver did it
> already */
> +	if (cpm_uart_nr > 0)
> +		return 0;
> +
>   	cpm_uart_nr =3D 0;
>   #ifdef CONFIG_SERIAL_CPM_SMC1
>   	cpm_uart_ports[UART_SMC1].smcp =3D &cpmp->cp_smc[0];
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c index ef3bb47..0f21543
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -252,10 +252,14 @@ void cpm_uart_freebuf(struct uart_cpm_po
>   }
>=20
>   /* Setup any dynamic params in the uart desc */
> -int cpm_uart_init_portdesc(void)
> +int __init cpm_uart_init_portdesc(void)
>   {
>   	pr_debug("CPM uart[-]:init portdesc\n");
>=20
> +	/* Don't run this again, if the console driver did it
> already */
> +	if (cpm_uart_nr > 0)
> +		return 0;
> +

Personally, I don't care much of compat stuff, unless it is breaking/confus=
ing targets=20
using proper resources...

>   	cpm_uart_nr =3D 0;
>   #ifdef CONFIG_SERIAL_CPM_SMC1
>   	cpm_uart_ports[UART_SMC1].smcp =3D (smc_t *) &
> cpm2_immr->im_smc[0];

--Sig_bqz.ZolzuFo52yad_3Ghef3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFN86vuOg9JvQhSEsRAoGKAJ9osVAKuyBDDwZo0zrnP0B3WSl8vQCgg59k
I0w8j/LoFEqlyaI7g9AsVaw=
=lAqT
-----END PGP SIGNATURE-----

--Sig_bqz.ZolzuFo52yad_3Ghef3--
