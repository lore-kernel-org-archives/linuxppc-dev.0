Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E96B7DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 20:47:10 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD for Taco
Date: Sat, 5 Jan 2008 10:41:17 +0100
References: <477F12D1.2070109@pikatech.com>
In-Reply-To: <477F12D1.2070109@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801051041.18173.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Sean MacLennan wrote:
> This patch adds the maps for the taco. It also gets the ndfc.c NAND
> driver in a compilable state. The map is guaranteed to change since the
> exact NOR/NAND flash configuration is in flux right now when we found
> the 256M NAND flash won't boot properly.
>
> Currently it configures the NOR in a reasonable fashion and leaves the
> NAND as one honkin' parition.

<snip>

> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> index 1c0e89f..f5e93cf 100644
> --- a/drivers/mtd/nand/ndfc.c
> +++ b/drivers/mtd/nand/ndfc.c
> @@ -24,11 +24,6 @@
> =A0#include <linux/platform_device.h>
> =A0
> =A0#include <asm/io.h>
> -#ifdef CONFIG_40x
> -#include <asm/ibm405.h>
> -#else
> -#include <asm/ibm44x.h>
> -#endif

You do break arch/ppc support with this patch. We have to still support
arch/ppc a few month, so please don't break this support for now.
 =A0
> =A0struct ndfc_nand_mtd {
> =A0=A0=A0=A0=A0=A0=A0=A0struct mtd_info=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0mtd;
> @@ -110,6 +105,40 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
> =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0}
> =A0
> +#ifdef CONFIG_TACO
> +/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
> + * the taco!
> + */

We definitely don't want to see such board specific stuff in the common
NDFC driver. And I really doubt that you need this change for your board.
We are using this ndfc driver on multiple boards, and all have no
problems accessing the controller with 32bit read/writes. So you most
likely have a problem with your board port. Perhaps something with
with the EBC setup. Please re-check and compare with boards that are know
to work, like Sequoia.

> +static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct ndfc_controller *ndfc =3D &ndfc_ctrl;
> +=A0=A0=A0=A0=A0=A0=A0uint8_t *p =3D (uint8_t *) buf;
> +
> +=A0=A0=A0=A0=A0=A0=A0for(;len > 0; len -=3D 1)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*p++ =3D __raw_readb(ndfc->=
ndfcbase + NDFC_DATA);
> +}
> +
> +static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
> len) +{
> +=A0=A0=A0=A0=A0=A0=A0struct ndfc_controller *ndfc =3D &ndfc_ctrl;
> +=A0=A0=A0=A0=A0=A0=A0uint8_t *p =3D (uint8_t *) buf;
> +
> +=A0=A0=A0=A0=A0=A0=A0for(;len > 0; len -=3D 1)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__raw_writeb(*p++, ndfc->nd=
fcbase + NDFC_DATA);
> +}
> +
> +static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int
> len) +{
> +=A0=A0=A0=A0=A0=A0=A0struct ndfc_controller *ndfc =3D &ndfc_ctrl;
> +=A0=A0=A0=A0=A0=A0=A0uint8_t *p =3D (uint8_t *) buf;
> +
> +=A0=A0=A0=A0=A0=A0=A0for(;len > 0; len -=3D 1)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (*p++ !=3D __raw_readb(n=
dfc->ndfcbase + NDFC_DATA))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -EFAULT;
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +#else

<snip>

> +++ drivers/mtd/maps/taco.c=A0=A0=A0=A0=A02008-01-02 13:07:43.000000000 -=
0500
> @@ -0,0 +1,140 @@
> +/*
> + * $Id: $
> + *
> + * drivers/mtd/maps/taco.c
> + *
> + * Mapping for PIKA Taco flash

I'm pretty sure that you don't need a board specific mapping driver
for NOR flash. physmap_of should be exactly what you need. You just need
to fill the device tree properties correctly.

BTW: I noticed you are using the boot wrapper approach. This is not
necessary anymore, since the latest U-Boot version has flattened
device tree support included for 4xx too. Let me know if you have any
questions about this.

Best regards,
Stefan

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
