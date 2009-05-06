Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id B1319DDF90
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:59:51 +1000 (EST)
Received: by gxk20 with SMTP id 20so672115gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 13:59:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-7-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 14:59:30 -0600
Message-ID: <fa686aa40905061359p3ba2115fj57f4d9a79f01efda@mail.gmail.com>
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> This patch adds NAND Flash Controller driver for MPC5121
> revision 2. All device features, except hardware ECC and
> power management, are supported.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: <linux-mtd@lists.infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> =A0arch/powerpc/include/asm/mpc5121_nfc.h =A0 =A0 =A0 | =A0100 +++
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 =A01 +
> =A0drivers/mtd/nand/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +
> =A0drivers/mtd/nand/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0drivers/mtd/nand/mpc5121_nfc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0855 ++=
++++++++++++++++++++++++
> =A05 files changed, 964 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/include/asm/mpc5121_nfc.h
> =A0create mode 100644 drivers/mtd/nand/mpc5121_nfc.c
>
> diff --git a/arch/powerpc/include/asm/mpc5121_nfc.h b/arch/powerpc/includ=
e/asm/mpc5121_nfc.h
> new file mode 100644
> index 0000000..b96a5b9
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc5121_nfc.h
[... bunch of #defines trimmed]

There is only one user of this.  It should be moved into the driver .c
file.  Otherwise okay.

> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index d8cd579..7135d89 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)
> =A0static struct of_device_id __initdata of_bus_ids[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-immr", },
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-localbus", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-nfc", },

This doesn't look right.  Shouldn't the NAND controller be hanging of
the IMMR node?

> =A0 =A0 =A0 =A0{},
> =A0};
>
> diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nf=
c.c
> new file mode 100644
> index 0000000..a8da4db
> --- /dev/null
> +++ b/drivers/mtd/nand/mpc5121_nfc.c
> @@ -0,0 +1,855 @@
> +/*
> + * Copyright 2004-2008 Freescale Semiconductor, Inc.
> + * Copyright 2009 Semihalf.
> + *
> + * Based on original driver from Freescale Semiconductor
> + * written by John Rigby <jrigby@freescale.com> on basis
> + * of drivers/mtd/nand/mxc_nand.c. Reworked and extended
> + * Piotr Ziecik <kosmo@semihalf.com>.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mpc512x.h>
> +#include <asm/mpc5121_nfc.h>
> +
> +#define =A0 =A0 =A0 =A0DRV_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc5121_=
nfc"
> +#define =A0 =A0 =A0 =A0DRV_VERSION =A0 =A0 =A0 =A0 =A0 =A0 "0.5"

Is this really necessary (especially the DRV_VERSION thing)?

> +/* Wait for operation complete */
> +static void mpc5121_nfc_done(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> + =A0 =A0 =A0 int rv;
> +
> + =A0 =A0 =A0 if ((nfc_read(mtd, NFC_CONFIG2) & NFC_INT) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG1, NFC_INT_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rv =3D wait_event_timeout(prv->irq_waitq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (nfc_read(mtd, NFC_CONFIG2)=
 & NFC_INT), NFC_TIMEOUT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_NAM=
E

Throughout this driver printk() calls should really be dev_*() calls.

> +/*
> + * Read NFC configuration from Reset Config Word
> + *
> + * NFC is configured during reset in basis of information stored
> + * in Reset Config Word. There is no other way to set NAND block
> + * size, spare size and bus width.
> + */
> +static int mpc5121_nfc_read_hw_config(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc512x_reset_module *rm;
> + =A0 =A0 =A0 struct device_node *rmnode;
> + =A0 =A0 =A0 uint rcw_pagesize =3D 0;
> + =A0 =A0 =A0 uint rcw_sparesize =3D 0;
> + =A0 =A0 =A0 uint rcw_width;
> + =A0 =A0 =A0 uint rcwh;
> + =A0 =A0 =A0 uint romloc, ps;
> +
> + =A0 =A0 =A0 rmnode =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121=
-reset");
> + =A0 =A0 =A0 if (!rmnode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME ": Missing 'fsl,mp=
c5121-reset' "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "node in device tree!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }

A little ugly, but I won't gripe too much about it.  I'd rather see a
platform code export some kind of api for manipulating the reset
module (I assume that multiple drivers will need to fiddle with it),
but I'm willing to be pragmatic here in the interest of getting it
merged.  It can always be reworked later with little risk.

> +static struct of_platform_driver mpc5121_nfc_driver =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 .match_table =A0 =A0=3D mpc5121_nfc_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc5121_nfc_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(mpc5121_nfc_remove),
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D NULL,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D NULL,

2 unnecessary lines.  gcc initializes unset fields to 0.

> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },

Duplicate settings.  Don't need to set both .name/.owner and
.driver.name and .driver.owner.

> +};
> +
> +static int __init mpc5121_nfc_init(void)
> +{
> + =A0 =A0 =A0 if (of_register_platform_driver(&mpc5121_nfc_driver) !=3D 0=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME ": Driver register=
 failed!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;

Heh.  "return of_register_platform_driver(&mpc5121_nfc_driver);" is
sufficient and accepted here.

> +}
> +
> +static void __exit mpc5121_nfc_cleanup(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc5121_nfc_driver);
> +}
> +
> +module_init(mpc5121_nfc_init);

Please move this line to just below the mpc5121_nfc_init function.

> +module_exit(mpc5121_nfc_cleanup);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("MPC5121 NAND MTD driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);

As I alluded to above, I really don't like the MODULE_VERSION think in
mainline code.

I only skimmed the driver, but that being said, other than my comments
it looks pretty good to me.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
