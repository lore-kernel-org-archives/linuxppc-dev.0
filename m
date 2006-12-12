Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
From: Michael Ellerman <michael@ellerman.id.au>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612120331.kBC3VUIZ016091@toshiba.co.jp>
References: <200612120331.kBC3VUIZ016091@toshiba.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KN+ewIzLOpSCNG5iF5Yq"
Date: Tue, 12 Dec 2006 15:09:26 +1100
Message-Id: <1165896566.14839.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-KN+ewIzLOpSCNG5iF5Yq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 12:31 +0900, Ishizaki Kou wrote:
> This patch adds hypervisor console driver for Celleb platform.
>=20
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> ---
>=20
> Index: linux-powerpc-git/drivers/char/Kconfig
> diff -u linux-powerpc-git/drivers/char/Kconfig:1.1.1.1 linux-powerpc-git/=
drivers/char/Kconfig:1.2
> --- linux-powerpc-git/drivers/char/Kconfig:1.1.1.1	Wed Dec  6 08:24:08 20=
06
> +++ linux-powerpc-git/drivers/char/Kconfig	Wed Dec  6 08:43:15 2006
> @@ -595,6 +595,13 @@
>  	help
>  	  IBM Console device driver which makes use of RTAS
> =20
> +config HVC_BEAT
> +	bool "Toshiba's Beat Hypervisor Console support"
> +	depends on PPC_CELLEB
> +	select HVC_DRIVER
> +	help
> +	  Toshiba's Cell Reference Set Beat Console device driver
> +
>  config HVCS
>  	tristate "IBM Hypervisor Virtual Console Server support"
>  	depends on PPC_PSERIES
> Index: linux-powerpc-git/drivers/char/Makefile
> diff -u linux-powerpc-git/drivers/char/Makefile:1.1.1.1 linux-powerpc-git=
/drivers/char/Makefile:1.2
> --- linux-powerpc-git/drivers/char/Makefile:1.1.1.1	Wed Dec  6 08:24:08 2=
006
> +++ linux-powerpc-git/drivers/char/Makefile	Wed Dec  6 08:43:15 2006
> @@ -44,6 +44,7 @@
>  obj-$(CONFIG_HVC_CONSOLE)	+=3D hvc_vio.o hvsi.o
>  obj-$(CONFIG_HVC_ISERIES)	+=3D hvc_iseries.o
>  obj-$(CONFIG_HVC_RTAS)		+=3D hvc_rtas.o
> +obj-$(CONFIG_HVC_BEAT)		+=3D hvc_beat.o
>  obj-$(CONFIG_HVC_DRIVER)	+=3D hvc_console.o
>  obj-$(CONFIG_RAW_DRIVER)	+=3D raw.o
>  obj-$(CONFIG_SGI_SNSC)		+=3D snsc.o snsc_event.o
> Index: linux-powerpc-git/drivers/char/hvc_beat.c
> diff -u /dev/null linux-powerpc-git/drivers/char/hvc_beat.c:1.1
> --- /dev/null	Mon Dec 11 20:37:34 2006
> +++ linux-powerpc-git/drivers/char/hvc_beat.c	Wed Dec  6 08:43:15 2006
> @@ -0,0 +1,106 @@
> +/*
> + * Beat hypervisor console driver
> + *
> + * (C) Copyright 2006 TOSHIBA CORPORATION
> + *
> + * This code is based on drivers/char/hvc_rtas.c:
> + * (C) Copyright IBM Corporation 2001-2005
> + * (C) Copyright Red Hat, Inc. 2005
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation, Inc=
.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/console.h>
> +#include <asm/prom.h>
> +#include <asm/hvconsole.h>
> +
> +#include "hvc_console.h"
> +
> +extern int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint=
64_t *);
> +extern int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t=
);
> +
> +struct hvc_struct *hvc_beat_dev =3D NULL;
> +
> +static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
> +{
> +	unsigned long kb[2];
> +	unsigned long got;
> +
> +	if (beat_get_term_char(vtermno, &got, &kb[0], &kb[1]) =3D=3D 0) {
> +		memcpy(buf, kb, got);
> +		return got;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt=
)
> +{
> +	unsigned long kb[2];
> +
> +	memcpy(kb, buf, sizeof(kb));
> +	beat_put_term_char(vtermno, cnt, kb[0], kb[1]);
> +	return cnt;
> +}
> +
> +static struct hv_ops hvc_beat_get_put_ops =3D {
> +	.get_chars =3D hvc_beat_get_chars,
> +	.put_chars =3D hvc_beat_put_chars,
> +};
> +
> +static int hvc_beat_useit =3D 1;
> +
> +static int hvc_beat_config(char *p)
> +{
> +	hvc_beat_useit =3D simple_strtoul(p, NULL, 0);
> +	return 0;
> +}
> +
> +static int hvc_beat_console_init(void)
> +{
> +	if (hvc_beat_useit && machine_is_compatible("Beat")) {
> +		hvc_instantiate(0, 0, &hvc_beat_get_put_ops);
> +	}
> +	return 0;
> +}

Why do you need hvc_beat_useit? You don't want the driver loaded at all
sometimes? Is console=3Dblah not enough?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-KN+ewIzLOpSCNG5iF5Yq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFfit2dSjSd0sB4dIRAnqCAJ41/UCKuC+GzA3vECngyxtpgLoQJgCgoC4M
PNc/xvgqKEmKumBsuOfuMPo=
=MU8V
-----END PGP SIGNATURE-----

--=-KN+ewIzLOpSCNG5iF5Yq--
