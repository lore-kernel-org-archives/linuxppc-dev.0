Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 26B0967A8E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Mar 2005 02:16:23 +1100 (EST)
In-Reply-To: <4.20050322_000905.tnt@patchsend.246tNt.com>
References: <4.20050322_000905.tnt@patchsend.246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <c89dafb7866b71817e467fe9b42bc4f4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 25 Mar 2005 09:15:35 -0600
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 4/6] ppc32: Add platform bus / ppc_sys model to
	Freescale MPC52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One question, do you really need #defines for the device offsets in=20
mpc52xx_devices.c ?  Are these used anywhere else?

- kumar

On Mar 21, 2005, at 5:08 PM, Sylvain Munaut wrote:

> ppc32: Add platform bus / ppc_sys model to Freescale MPC52xx
>
> This patch makes all platform based around the Freescale MPC52xx use
>  the platform bus and more precisly the ppc_sys model put in
>  place by Kumar Gala.
>
>
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

[ snip ]

> diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
> --- a/arch/ppc/syslib/Makefile=A0 2005-03-21 20:10:34 +01:00
>  +++ b/arch/ppc/syslib/Makefile=A0 2005-03-21 20:10:34 +01:00
>  @@ -106,7 +106,8 @@
>  =A0obj-$(CONFIG_PCI)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D =
indirect_pci.o pci_auto.o
>  =A0endif
>  =A0obj-$(CONFIG_MPC8555_CDS)=A0=A0=A0=A0=A0 +=3D todc_time.o
> -obj-$(CONFIG_PPC_MPC52xx)=A0=A0=A0=A0=A0 +=3D mpc52xx_setup.o =
mpc52xx_pic.o
> +obj-$(CONFIG_PPC_MPC52xx)=A0=A0=A0=A0=A0 +=3D mpc52xx_setup.o =
mpc52xx_pic.o \
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 mpc52xx_sys.o=20
> mpc52xx_devices.o ppc_sys.o
>  =A0ifeq ($(CONFIG_PPC_MPC52xx),y)
> =A0obj-$(CONFIG_PCI)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D =
mpc52xx_pci.o
> =A0endif
>  diff -Nru a/arch/ppc/syslib/mpc52xx_devices.c=20
> b/arch/ppc/syslib/mpc52xx_devices.c
> --- /dev/null=A0=A0 Wed Dec 31 16:00:00 196900
>  +++ b/arch/ppc/syslib/mpc52xx_devices.c 2005-03-21 20:10:34 +01:00
>  @@ -0,0 +1,333 @@
>  +/*
>  + * arch/ppc/syslib/mpc52xx_devices.c
> + *
>  + * Freescale MPC52xx device descriptions
>  + *
>  + *
>  + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> + *
>  + * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
> + *
>  + * This file is licensed under the terms of the GNU General Public=20=

> License
>  + * version 2. This program is licensed "as is" without any warranty=20=

> of any
>  + * kind, whether express or implied.
>  + */
>  +
>  +#include <linux/fsl_devices.h>
> +#include <linux/resource.h>
> +#include <asm/mpc52xx.h>
> +#include <asm/ppc_sys.h>
> +
>  +
>  +static u64 mpc52xx_dma_mask =3D 0xffffffffULL;
>  +
>  +static struct fsl_i2c_platform_data mpc52xx_fsl_i2c_pdata =3D {
>  +=A0=A0=A0=A0=A0=A0 .device_flags =3D FSL_I2C_DEV_CLOCK_5200,
> +};
>  +
>  +
>  +/* We use relative offsets for IORESOURCE_MEM to be independent from=20=

> the
>  + * MBAR location at compile time
>  + */
>  +
>  +/* TODO Add the BestComm initiator channel to the device =
definitions,
>  +=A0=A0 possibly using IORESOURCE_DMA. But that's when BestComm is =
ready=20
> ... */
>  +
>  +struct platform_device ppc_sys_platform_devices[] =3D {
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_MSCAN1] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-mscan",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 0,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource =3D (struct =
resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_MSCAN1_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_MSCAN1_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_MSCAN_SIZE -=20
> 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_MSCAN1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_MSCAN1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_MSCAN2] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-mscan",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 1,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource =3D (struct =
resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_MSCAN2_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_MSCAN2_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_MSCAN_SIZE -=20
> 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_MSCAN2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_MSCAN2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_SPI] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-spi",
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D -1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 3,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_SPI_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_SPI_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_SPI_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D "modf",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_SPI_MODF_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_SPI_MODF_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D "spif",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_SPI_SPIF_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_SPI_SPIF_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_USB] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "ppc-soc-ohci",
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D -1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .dev.dma_mask=A0=A0 =3D =
&mpc52xx_dma_mask,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .dev.coherent_dma_mask =3D =
0xffffffffULL,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_USB_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_USB_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_USB_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_USB_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_USB_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_BDLC] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-bdlc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D -1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_BDLC_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_BDLC_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_BDLC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_BDLC_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_BDLC_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC1] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 0,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC1_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC1_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC2] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 1,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC2_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC2_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC3] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 2,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC3_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC3_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC3_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC3_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC4] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 3,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC4_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC4_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC4_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC4_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC5] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 4,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC5_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC5_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC5_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC5_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_PSC6] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-psc",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 5,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC6_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC6_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_PSC6_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_PSC6_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_FEC] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-fec",
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D -1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_FEC_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_FEC_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_FEC_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_FEC_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_FEC_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_ATA] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "mpc52xx-ata",
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D -1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_ATA_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_ATA_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_ATA_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_ATA_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_ATA_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_I2C1] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "fsl-i2c",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 0,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .dev.platform_data =3D =
&mpc52xx_fsl_i2c_pdata,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_I2C1_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_I2C1_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_I2C_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_I2C1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_I2C1_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 [MPC52xx_I2C2] =3D {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =3D "fsl-i2c",
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 =3D 1,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .dev.platform_data =3D =
&mpc52xx_fsl_i2c_pdata,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0 =3D 2,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource=A0=A0=A0=A0=A0=A0 =
=3D (struct resource[]) {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_I2C2_OFFSET,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_I2C2_OFFSET +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_I2C_SIZE - 1,
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .start=A0 =3D MPC52xx_I2C2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .end=A0=A0=A0 =3D MPC52xx_I2C2_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  +=A0=A0=A0=A0=A0=A0 },
>  +};
>  +
>  +
>  +static int __init mach_mpc52xx_fixup(struct platform_device *pdev)
>  +{
>  +=A0=A0=A0=A0=A0=A0 ppc_sys_fixup_mem_resource(pdev, MPC52xx_MBAR);
> +=A0=A0=A0=A0=A0=A0 return 0;
>  +}
>  +
>  +static int __init mach_mpc52xx_init(void)
> +{
>  +=A0=A0=A0=A0=A0=A0 ppc_sys_device_fixup =3D mach_mpc52xx_fixup;
> +=A0=A0=A0=A0=A0=A0 return 0;
>  +}
>  +
>  +postcore_initcall(mach_mpc52xx_init);
