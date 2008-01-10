Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.240])
	by ozlabs.org (Postfix) with ESMTP id 44915DE0A2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 09:52:22 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so570777agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:52:20 -0800 (PST)
Message-ID: <fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
Date: Thu, 10 Jan 2008 15:52:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD to support audio drivers
In-Reply-To: <12000050664035-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Update the MPC8610 HPCD files to support the audio driver.  Update
> booting-without-of.txt with information on the SSI device.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

<snip>

> diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> index 966edf1..4c91890 100644
> --- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> +++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> @@ -103,6 +111,109 @@
>                         reg = <e0000 1000>;
>                         fsl,has-rstcr;
>                 };
> +
> +               i2s@16000 {
> +                       compatible = "fsl,mpc8610-ssi";
> +                       cell-index = <0>;
> +                       reg = <16000 100>;
> +                       interrupt-parent = <&mpic>;
> +                       interrupts = <3e 2>;
> +                       fsl,mode = "i2s-slave";
> +                       codec-handle = <&cs4270>;
> +               };
> +
> +               ssi@16100 {
> +                       compatible = "fsl,mpc8610-ssi";
> +                       cell-index = <1>;
> +                       reg = <16100 100>;
> +                       interrupt-parent = <&mpic>;
> +                       interrupts = <3f 2>;
> +               };
> +
> +                dma@21300 {
> +                        #address-cells = <1>;
> +                        #size-cells = <1>;
> +                        compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
> +                        cell-index = <0>;
> +                        reg = <21300 4>; /* DMA general status register */
> +                        ranges = <0 21100 200>;
> +
> +                        dma-channel@0 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,eloplus-dma-channel";

Nit: you probably don't need the compatible property for these channel
nodes since they are 100% dependent on the parent for describing the
behaviour.

Otherwise;

Acked-by: Grant Likely <grant.likely@secretlab.ca>


> +                               cell-index = <0>;
> +                               reg = <0 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <14 2>;
> +                        };
> +                        dma-channel@1 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,eloplus-dma-channel";
> +                               cell-index = <1>;
> +                               reg = <80 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <15 2>;
> +                        };
> +                        dma-channel@2 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,eloplus-dma-channel";
> +                               cell-index = <2>;
> +                               reg = <100 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <16 2>;
> +                        };
> +                        dma-channel@3 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,eloplus-dma-channel";
> +                               cell-index = <3>;
> +                               reg = <180 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <17 2>;
> +                        };
> +                };
> +
> +                dma@c300 {
> +                        #address-cells = <1>;
> +                        #size-cells = <1>;
> +                        compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
> +                        cell-index = <1>;
> +                        reg = <c300 4>; /* DMA general status register */
> +                        ranges = <0 c100 200>;
> +
> +                        dma-channel@0 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,mpc8540-dma-channel";
> +                               cell-index = <0>;
> +                               reg = <0 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <3c 2>;
> +                        };
> +                        dma-channel@1 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,mpc8540-dma-channel";
> +                               cell-index = <1>;
> +                               reg = <80 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <3d 2>;
> +                        };
> +                        dma-channel@2 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,mpc8540-dma-channel";
> +                               cell-index = <2>;
> +                               reg = <100 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <3e 2>;
> +                        };
> +                        dma-channel@3 {
> +                               compatible = "fsl,mpc8610-dma-channel",
> +                                       "fsl,mpc8540-dma-channel";
> +                               cell-index = <3>;
> +                               reg = <180 80>;
> +                               interrupt-parent = <&mpic>;
> +                               interrupts = <3f 2>;
> +                        };
> +                };
> +
>         };
>
>         pci@e0008000 {
> diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
> index 9614d24..2500ef4 100644
> --- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
> +++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
> @@ -696,7 +696,7 @@ CONFIG_SERIAL_8250_RSA=y
>  CONFIG_SERIAL_CORE=y
>  CONFIG_SERIAL_CORE_CONSOLE=y
>  # CONFIG_SERIAL_JSM is not set
> -CONFIG_SERIAL_OF_PLATFORM=y
> +# CONFIG_SERIAL_OF_PLATFORM is not set
>  CONFIG_UNIX98_PTYS=y
>  # CONFIG_LEGACY_PTYS is not set
>  # CONFIG_IPMI_HANDLER is not set
> @@ -708,7 +708,60 @@ CONFIG_UNIX98_PTYS=y
>  # CONFIG_RAW_DRIVER is not set
>  # CONFIG_TCG_TPM is not set
>  CONFIG_DEVPORT=y
> -# CONFIG_I2C is not set
> +CONFIG_I2C=y
> +CONFIG_I2C_BOARDINFO=y
> +# CONFIG_I2C_CHARDEV is not set
> +
> +#
> +# I2C Algorithms
> +#
> +# CONFIG_I2C_ALGOBIT is not set
> +# CONFIG_I2C_ALGOPCF is not set
> +# CONFIG_I2C_ALGOPCA is not set
> +
> +#
> +# I2C Hardware Bus support
> +#
> +# CONFIG_I2C_ALI1535 is not set
> +# CONFIG_I2C_ALI1563 is not set
> +# CONFIG_I2C_ALI15X3 is not set
> +# CONFIG_I2C_AMD756 is not set
> +# CONFIG_I2C_AMD8111 is not set
> +# CONFIG_I2C_I801 is not set
> +# CONFIG_I2C_I810 is not set
> +# CONFIG_I2C_PIIX4 is not set
> +CONFIG_I2C_MPC=y
> +# CONFIG_I2C_NFORCE2 is not set
> +# CONFIG_I2C_OCORES is not set
> +# CONFIG_I2C_PARPORT_LIGHT is not set
> +# CONFIG_I2C_PROSAVAGE is not set
> +# CONFIG_I2C_SAVAGE4 is not set
> +# CONFIG_I2C_SIMTEC is not set
> +# CONFIG_I2C_SIS5595 is not set
> +# CONFIG_I2C_SIS630 is not set
> +# CONFIG_I2C_SIS96X is not set
> +# CONFIG_I2C_TAOS_EVM is not set
> +# CONFIG_I2C_VIA is not set
> +# CONFIG_I2C_VIAPRO is not set
> +# CONFIG_I2C_VOODOO3 is not set
> +
> +#
> +# Miscellaneous I2C Chip support
> +#
> +# CONFIG_SENSORS_DS1337 is not set
> +# CONFIG_SENSORS_DS1374 is not set
> +# CONFIG_DS1682 is not set
> +# CONFIG_SENSORS_EEPROM is not set
> +# CONFIG_SENSORS_PCF8574 is not set
> +# CONFIG_SENSORS_PCA9539 is not set
> +# CONFIG_SENSORS_PCF8591 is not set
> +# CONFIG_SENSORS_M41T00 is not set
> +# CONFIG_SENSORS_MAX6875 is not set
> +# CONFIG_SENSORS_TSL2550 is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_I2C_DEBUG_CHIP is not set
>
>  #
>  # SPI support
> @@ -763,7 +816,119 @@ CONFIG_DUMMY_CONSOLE=y
>  #
>  # Sound
>  #
> -# CONFIG_SOUND is not set
> +CONFIG_SOUND=y
> +
> +#
> +# Advanced Linux Sound Architecture
> +#
> +CONFIG_SND=y
> +CONFIG_SND_TIMER=y
> +CONFIG_SND_PCM=y
> +# CONFIG_SND_SEQUENCER is not set
> +CONFIG_SND_OSSEMUL=y
> +CONFIG_SND_MIXER_OSS=y
> +CONFIG_SND_PCM_OSS=y
> +# CONFIG_SND_PCM_OSS_PLUGINS is not set
> +# CONFIG_SND_DYNAMIC_MINORS is not set
> +# CONFIG_SND_SUPPORT_OLD_API is not set
> +CONFIG_SND_VERBOSE_PROCFS=y
> +# CONFIG_SND_VERBOSE_PRINTK is not set
> +# CONFIG_SND_DEBUG is not set
> +
> +#
> +# Generic devices
> +#
> +# CONFIG_SND_DUMMY is not set
> +# CONFIG_SND_MTPAV is not set
> +# CONFIG_SND_SERIAL_U16550 is not set
> +# CONFIG_SND_MPU401 is not set
> +
> +#
> +# PCI devices
> +#
> +# CONFIG_SND_AD1889 is not set
> +# CONFIG_SND_ALS300 is not set
> +# CONFIG_SND_ALS4000 is not set
> +# CONFIG_SND_ALI5451 is not set
> +# CONFIG_SND_ATIIXP is not set
> +# CONFIG_SND_ATIIXP_MODEM is not set
> +# CONFIG_SND_AU8810 is not set
> +# CONFIG_SND_AU8820 is not set
> +# CONFIG_SND_AU8830 is not set
> +# CONFIG_SND_AZT3328 is not set
> +# CONFIG_SND_BT87X is not set
> +# CONFIG_SND_CA0106 is not set
> +# CONFIG_SND_CMIPCI is not set
> +# CONFIG_SND_CS4281 is not set
> +# CONFIG_SND_CS46XX is not set
> +# CONFIG_SND_CS5530 is not set
> +# CONFIG_SND_DARLA20 is not set
> +# CONFIG_SND_GINA20 is not set
> +# CONFIG_SND_LAYLA20 is not set
> +# CONFIG_SND_DARLA24 is not set
> +# CONFIG_SND_GINA24 is not set
> +# CONFIG_SND_LAYLA24 is not set
> +# CONFIG_SND_MONA is not set
> +# CONFIG_SND_MIA is not set
> +# CONFIG_SND_ECHO3G is not set
> +# CONFIG_SND_INDIGO is not set
> +# CONFIG_SND_INDIGOIO is not set
> +# CONFIG_SND_INDIGODJ is not set
> +# CONFIG_SND_EMU10K1 is not set
> +# CONFIG_SND_EMU10K1X is not set
> +# CONFIG_SND_ENS1370 is not set
> +# CONFIG_SND_ENS1371 is not set
> +# CONFIG_SND_ES1938 is not set
> +# CONFIG_SND_ES1968 is not set
> +# CONFIG_SND_FM801 is not set
> +# CONFIG_SND_HDA_INTEL is not set
> +# CONFIG_SND_HDSP is not set
> +# CONFIG_SND_HDSPM is not set
> +# CONFIG_SND_ICE1712 is not set
> +# CONFIG_SND_ICE1724 is not set
> +# CONFIG_SND_INTEL8X0 is not set
> +# CONFIG_SND_INTEL8X0M is not set
> +# CONFIG_SND_KORG1212 is not set
> +# CONFIG_SND_MAESTRO3 is not set
> +# CONFIG_SND_MIXART is not set
> +# CONFIG_SND_NM256 is not set
> +# CONFIG_SND_PCXHR is not set
> +# CONFIG_SND_RIPTIDE is not set
> +# CONFIG_SND_RME32 is not set
> +# CONFIG_SND_RME96 is not set
> +# CONFIG_SND_RME9652 is not set
> +# CONFIG_SND_SONICVIBES is not set
> +# CONFIG_SND_TRIDENT is not set
> +# CONFIG_SND_VIA82XX is not set
> +# CONFIG_SND_VIA82XX_MODEM is not set
> +# CONFIG_SND_VX222 is not set
> +# CONFIG_SND_YMFPCI is not set
> +
> +#
> +# ALSA PowerMac devices
> +#
> +
> +#
> +# ALSA PowerPC devices
> +#
> +
> +#
> +# System on Chip audio support
> +#
> +CONFIG_SND_SOC=y
> +
> +#
> +# SoC Audio support for SuperH
> +#
> +
> +#
> +# ALSA SoC audio for Freescale SOCs
> +#
> +CONFIG_SND_SOC_MPC8610=y
> +CONFIG_SND_SOC_MPC8610_HPCD=y
> +CONFIG_SND_SOC_CS4270=y
> +CONFIG_SND_SOC_CS4270_VD33_ERRATA=y
> +
>  CONFIG_HID_SUPPORT=y
>  CONFIG_HID=y
>  # CONFIG_HID_DEBUG is not set
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> index 6390895..36d8f14 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -34,9 +34,24 @@
>
>  #include <asm/mpic.h>
>
> +#include <linux/of_platform.h>
>  #include <sysdev/fsl_pci.h>
>  #include <sysdev/fsl_soc.h>
>
> +static struct of_device_id __initdata mpc8610_ids[] = {
> +       { .compatible = "fsl,mpc8610-immr", },
> +       {}
> +};
> +
> +static int __init mpc8610_declare_of_platform_devices(void)
> +{
> +       /* Without this call, the SSI device driver won't get probed. */
> +       of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> +
> +       return 0;
> +}
> +machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
> +
>  void __init
>  mpc86xx_hpcd_init_irq(void)
>  {
> --
> 1.5.2.4
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
