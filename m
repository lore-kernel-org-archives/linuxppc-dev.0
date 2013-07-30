Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72E332C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:09:54 +1000 (EST)
Received: from mail84-ch1 (localhost [127.0.0.1])	by mail84-ch1-R.bigfish.com
 (Postfix) with ESMTP id 8AC8834007A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 30 Jul 2013 01:09:49 +0000 (UTC)
Received: from CH1EHSMHS029.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail84-ch1.bigfish.com (Postfix) with ESMTP id
 9B15A4004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 01:09:47 +0000 (UTC)
Date: Mon, 29 Jul 2013 20:09:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: powerpc/85xx: Add P1023RDB board support
Message-ID: <20130730010945.GA8645@home.buserror.net>
References: <1371198380-12792-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1371198380-12792-1-git-send-email-Chunhe.Lan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 14, 2013 at 04:26:20PM +0800, Chunhe Lan wrote:
> P1023RDB Specification:
> -----------------------
> Memory subsystem:
>    512MB DDR3 (Fixed DDR on board)
>    64MB NOR flash
>    128MB NAND flash

Where is NAND in the device tree?

> Ethernet:
>    eTSEC1: Connected to Atheros AR8035 GETH PHY
>    eTSEC2: Connected to Atheros AR8035 GETH PHY

Where are the PHYs in the device tree?

> +			partition@3f00000 {
> +				label = "firmware";
> +				reg = <0x03f00000 0x00080000>;
> +				read-only;
> +			};
> +			partition@3f80000 {
> +				label = "u-boot";
> +				reg = <0x03f80000 0x00080000>;
> +				read-only;
> +			};

What is "firmware" if not U-Boot?  FMan firmware?  Note that part of your
"firmware" partition contains the U-Boot environment.

> diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
> index b80bcc6..092a746 100644
> --- a/arch/powerpc/configs/85xx/p1023rds_defconfig
> +++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
> @@ -22,6 +22,7 @@ CONFIG_MODVERSIONS=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_MAC_PARTITION=y
> +CONFIG_P1023_RDB=y
>  CONFIG_P1023_RDS=y
>  CONFIG_QUICC_ENGINE=y
>  CONFIG_QE_GPIO=y
> @@ -67,6 +68,7 @@ CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=131072
> +CONFIG_EEPROM_AT24=y
>  CONFIG_EEPROM_LEGACY=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_CHR_DEV_ST=y
> @@ -102,6 +104,7 @@ CONFIG_SERIAL_8250_RSA=y
>  CONFIG_SERIAL_QE=m
>  CONFIG_NVRAM=y
>  CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_CPM=m
>  CONFIG_I2C_MPC=y
>  CONFIG_GPIO_MPC8XXX=y
> @@ -121,6 +124,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_DS1307=y
>  CONFIG_RTC_DRV_CMOS=y
>  CONFIG_DMADEVICES=y
>  CONFIG_FSL_DMA=y

This isn't a p1023rds.  Having one defconfig to support both boards is
good, but the defconfig should be renamed to p1023_defconfig.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index efdd37c..d0e8ff9 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -111,6 +111,12 @@ config P1022_RDK
>  	  This option enables support for the Freescale / iVeia P1022RDK
>  	  reference board.
>  
> +config P1023_RDB
> +	bool "Freescale P1023 RDB"
> +	select P1023_RDS
> +	help
> +	  This option enables support for the P1023 RDB board
> +

Why do you need a new kconfig option, if you're supporting both boards
with the same C file?  Just update the name and description of the
existing kconfig symbol.

-Scott
