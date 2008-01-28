Return-Path: <cooloney.lkml@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 0023BDDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:21:18 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2393862pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 09:21:17 -0800 (PST)
Message-ID: <386072610801280921q3e96bfc1v40ad09660c0f7ad8@mail.gmail.com>
Date: Tue, 29 Jan 2008 01:21:15 +0800
From: "Bryan Wu" <cooloney.lkml@gmail.com>
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
In-Reply-To: <479A185D.6010406@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479A185D.6010406@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 26, 2008 1:11 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Using the port of 2.4 code from Vitaly Bordug <vitb@kernel.crashing.org>
> and the actual algorithm used by the i2c driver of the DBox code on
> cvs.tuxboc.org from Tmbinc, Gillem (htoa@gmx.net). Renamed i2c-rpx.c and
> i2c-algo-8xx.c to i2c-cpm.c and converted the driver to an
> of_platform_driver.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/powerpc/boot/dts/mpc8272ads.dts         |   10 +
>  arch/powerpc/boot/dts/mpc866ads.dts          |   10 +
>  arch/powerpc/boot/dts/mpc885ads.dts          |   10 +
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
>  drivers/i2c/busses/Kconfig                   |   10 +
>  drivers/i2c/busses/Makefile                  |    1 +
>  drivers/i2c/busses/i2c-cpm.c                 |  759 ++++++++++++++++++++++++++
>  7 files changed, 805 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-cpm.c
>
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index 7285ca1..7273996 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -215,6 +215,16 @@
>                                 linux,network-index = <1>;
>                                 fsl,cpm-command = <16200300>;
>                         };
> +
> +                       i2c@11860 {
> +                               compatible = "fsl,mpc8248-i2c",
> +                                            "fsl,cpm2-i2c",
> +                                            "fsl,cpm-i2c";
> +                               reg = <11860 20 8afc 2>;
> +                               interrupts = <1 8>;
> +                               interrupt-parent = <&PIC>;
> +                               fsl,cpm-command = <29600000>;
> +                       };
>                 };
>
>                 PIC: interrupt-controller@10c00 {
> diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
> index daf9433..80c08bf 100644
> --- a/arch/powerpc/boot/dts/mpc866ads.dts
> +++ b/arch/powerpc/boot/dts/mpc866ads.dts
> @@ -169,6 +169,16 @@
>                                 fsl,cpm-command = <0000>;
>                                 linux,network-index = <1>;
>                         };
> +
> +                       i2c@860 {
> +                               compatible = "fsl,mpc866-i2c",
> +                                            "fsl,cpm1-i2c",
> +                                            "fsl,cpm-i2c";
> +                               reg = <860 20 3c80 30>;
> +                               interrupts = <10 3>;
> +                               interrupt-parent = <&Cpm_pic>;
> +                               fsl,cpm-command = <0010>;
> +                       };
>                 };
>         };
>
> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
> index 8848e63..fd9c9d7 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -213,6 +213,16 @@
>                                 fsl,cpm-command = <0080>;
>                                 linux,network-index = <2>;
>                         };
> +
> +                       i2c@860 {
> +                               compatible = "fsl,mpc885-i2c",
> +                                            "fsl,cpm1-i2c",
> +                                            "fsl,cpm-i2c";
> +                               reg = <860 20 3c80 30>;
> +                               interrupts = <10>;
> +                               interrupt-parent = <&CPM_PIC>;
> +                               fsl,cpm-command = <0010>;
> +                       };
>                 };
>         };
>
> diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> index f39447b..1e7d056 100644
> --- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> +++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> @@ -157,6 +157,11 @@ static struct cpm_pin mpc885ads_pins[] = {
>         {CPM_PORTE, 28, CPM_PIN_OUTPUT},
>         {CPM_PORTE, 29, CPM_PIN_OUTPUT},
>  #endif
> +       /* I2C */
> +#ifdef CONFIG_I2C_8XX
> +       {CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
> +       {CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
> +#endif
>  };
>
>  static void __init init_ioports(void)
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index c466c6c..5950172 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -114,6 +114,16 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>         help
>           The unit of the TWI clock is kHz.
>
> +config I2C_CPM
> +       tristate "Freescale CPM1 or CPM2 (MPC8xx/826x)"
> +       depends on (CPM1 || CPM2) && I2C && PPC_OF
> +       help
> +         This supports the use of the I2C interface on Freescale
> +         processors with CPM1 or CPM2.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-cpm.
> +
>  config I2C_DAVINCI
>         tristate "DaVinci I2C driver"
>         depends on ARCH_DAVINCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 81d43c2..a395555 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_I2C_AMD8111)     += i2c-amd8111.o
>  obj-$(CONFIG_I2C_AT91)         += i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)       += i2c-au1550.o
>  obj-$(CONFIG_I2C_BLACKFIN_TWI) += i2c-bfin-twi.o
> +obj-$(CONFIG_I2C_CPM)          += i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)      += i2c-davinci.o
>  obj-$(CONFIG_I2C_ELEKTOR)      += i2c-elektor.o
>  obj-$(CONFIG_I2C_GPIO)         += i2c-gpio.o
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> new file mode 100644
> index 0000000..7191427
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -0,0 +1,759 @@
> +/*
> + * Freescale CPM1/CPM2 I2C interface.
> + * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
> + *

[!snip!]

> +
> +       /* register new adapter to i2c module... */
> +
> +       result = i2c_add_adapter(&cpm->adap);

As I was pointed before, please use the new style i2c driver interface:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=991dee591a99d035796a8c194eb1796cc020e142

-Bryan Wu

[!snip!]
