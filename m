Return-Path: <Geert.Uytterhoeven@eu.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id B8CFBDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 21:48:20 +1000 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id l3IBmIW5005239
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 20:48:18 +0900 (JST)
Received: from jptkyxim02.jp.sony.com (jptkyxim02.jp.sony.com [43.15.17.88])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id l3IBmIVR005227
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 20:48:18 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 2/15] Automatically lmb_reserve() initrd
Date: Wed, 18 Apr 2007 12:43:04 +0100
Message-ID: <CA6404BA52C51146981195CF9A147C1C01A9A010@GBISE0BASMSX01.eu.sony.com>
References: <20070305032450.44F57DDF1B@ozlabs.org>
From: "Uytterhoeven, Geert" <Geert.Uytterhoeven@eu.sony.com>
To: "David Gibson" <david@gibson.dropbear.id.au>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On March 5, 2007, David Gibson wrote:
> At present, when an initrd is passed to the kernel used flat device
> tree properties, the memory the initrd occupies must also be reserved
> in the flat tree's reserve map, or the kernel may overwrite it.  That
> makes life more complicated than it could be for the bootwrapper.
>=20
> This patch makes the kernel automatically reserve the initrd's space.
> That in turn requires parsing the initrd parameters earlier than they
> are currently, in early_init_dt_scan_chosen() instead of
> check_for_initrd().
>=20
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
>=20
>  arch/powerpc/kernel/prom.c         |   23 +++++++++++++++++++++++
>  arch/powerpc/kernel/setup-common.c |   22 ++--------------------
>  2 files changed, 25 insertions(+), 20 deletions(-)
>=20
> Index: working-2.6/arch/powerpc/kernel/prom.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working-2.6.orig/arch/powerpc/kernel/prom.c=09
> 2007-02-09 15:12:00.000000000 +1100
> +++ working-2.6/arch/powerpc/kernel/prom.c	2007-02-09=20
> 15:14:27.000000000 +1100
> @@ -719,6 +719,7 @@ static int __init early_init_dt_scan_cho
>  					    const char *uname,=20
> int depth, void *data)
>  {
>  	unsigned long *lprop;
> +	u32 *prop;

This causes a compiler warning if CONFIG_BLK_DEV_INITRD is not set.

>  	unsigned long l;
>  	char *p;
> =20
> @@ -760,6 +761,22 @@ static int __init early_init_dt_scan_cho
>                 crashk_res.end =3D crashk_res.start + *lprop - 1;
>  #endif
> =20
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	DBG("Looking for initrd properties... ");
> +	prop =3D of_get_flat_dt_prop(node, "linux,initrd-start", &l);
> +	if (prop) {
> +		initrd_start =3D (unsigned long)__va(of_read_ulong(prop, l/4));
> +		prop =3D of_get_flat_dt_prop(node, "linux,initrd-end", &l);
> +		if (prop) {
> +			initrd_end =3D (unsigned long)__va(of_read_ulong(prop, l/4));
> +			initrd_below_start_ok =3D 1;
> +		} else {
> +			initrd_start =3D 0;
> +		}
> +	}
> +	DBG("initrd_start=3D0x%lx  initrd_end=3D0x%lx\n", initrd_start, =
initrd_end);
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
>  	/* Retreive command line */
>   	p =3D of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p !=3D NULL && l > 0)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe =
(NSCE)
Geert.Uytterhoeven@eu.sony.com ------- The Corporate Village, Da =
Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, =
Belgium
