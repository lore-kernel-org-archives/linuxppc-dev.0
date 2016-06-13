Return-Path: <j.anaszewski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSlTn25mszDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:56:28 +1000 (AEST)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8P006FT9L7HA80@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 13 Jun 2016 08:46:19 +0100 (BST)
Message-id: <575E64C9.6060302@samsung.com>
Date: Mon, 13 Jun 2016 09:46:17 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org,
 Joseph Jezak <josejx@gentoo.org>,
 =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] powerpc: use the new LED disk activity trigger
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-3-linz@li-pro.net>
In-reply-to: <20160610060021.12382-3-linz@li-pro.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

For consistency reasons this patch should be merged through LED tree,
but I need an ack from relevant maintainer. Benjamin, Michael, Paul?

Thanks,
Jacek Anaszewski

On 06/10/2016 07:59 AM, Stephan Linz wrote:
> - dts: rename 'ide-disk' to 'disk-activity'
> - defconfig: rename 'ADB_PMU_LED_IDE' to 'ADB_PMU_LED_DISK'
>
> Cc: Joseph Jezak <josejx@gentoo.org>
> Cc: Jörg Sommer <joerg@alea.gnuu.de>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>   arch/powerpc/boot/dts/mpc8315erdb.dts |  2 +-
>   arch/powerpc/boot/dts/mpc8377_rdb.dts |  2 +-
>   arch/powerpc/boot/dts/mpc8378_rdb.dts |  2 +-
>   arch/powerpc/boot/dts/mpc8379_rdb.dts |  2 +-
>   arch/powerpc/configs/pmac32_defconfig |  2 +-
>   arch/powerpc/configs/ppc6xx_defconfig |  2 +-
>   drivers/macintosh/Kconfig             | 13 ++++++-------
>   drivers/macintosh/via-pmu-led.c       |  4 ++--
>   8 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
> index 4354684..ca5139e 100644
> --- a/arch/powerpc/boot/dts/mpc8315erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
> @@ -472,7 +472,7 @@
>
>   		hdd {
>   			gpios = <&mcu_pio 1 0>;
> -			linux,default-trigger = "ide-disk";
> +			linux,default-trigger = "disk-activity";
>   		};
>   	};
>   };
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 2b4b653..e326139 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -496,7 +496,7 @@
>
>   		hdd {
>   			gpios = <&mcu_pio 1 0>;
> -			linux,default-trigger = "ide-disk";
> +			linux,default-trigger = "disk-activity";
>   		};
>   	};
>   };
> diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> index 74b6a53..71842fc 100644
> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> @@ -480,7 +480,7 @@
>
>   		hdd {
>   			gpios = <&mcu_pio 1 0>;
> -			linux,default-trigger = "ide-disk";
> +			linux,default-trigger = "disk-activity";
>   		};
>   	};
>   };
> diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> index 3b5cbac..e442a29 100644
> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> @@ -446,7 +446,7 @@
>
>   		hdd {
>   			gpios = <&mcu_pio 1 0>;
> -			linux,default-trigger = "ide-disk";
> +			linux,default-trigger = "disk-activity";
>   		};
>   	};
>   };
> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
> index ea8705f..3f6c9a6 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -158,7 +158,7 @@ CONFIG_ADB=y
>   CONFIG_ADB_CUDA=y
>   CONFIG_ADB_PMU=y
>   CONFIG_ADB_PMU_LED=y
> -CONFIG_ADB_PMU_LED_IDE=y
> +CONFIG_ADB_PMU_LED_DISK=y
>   CONFIG_PMAC_APM_EMU=m
>   CONFIG_PMAC_MEDIABAY=y
>   CONFIG_PMAC_BACKLIGHT=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 99ccbeba..1dde0be 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -442,7 +442,7 @@ CONFIG_ADB=y
>   CONFIG_ADB_CUDA=y
>   CONFIG_ADB_PMU=y
>   CONFIG_ADB_PMU_LED=y
> -CONFIG_ADB_PMU_LED_IDE=y
> +CONFIG_ADB_PMU_LED_DISK=y
>   CONFIG_PMAC_APM_EMU=y
>   CONFIG_PMAC_MEDIABAY=y
>   CONFIG_PMAC_BACKLIGHT=y
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 3e8b29e..d28690f 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -96,19 +96,18 @@ config ADB_PMU_LED
>   	  Support the front LED on Power/iBooks as a generic LED that can
>   	  be triggered by any of the supported triggers. To get the
>   	  behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
> -	  and the ide-disk LED trigger and configure appropriately through
> -	  sysfs.
> +	  and the disk LED trigger and configure appropriately through sysfs.
>
> -config ADB_PMU_LED_IDE
> -	bool "Use front LED as IDE LED by default"
> +config ADB_PMU_LED_DISK
> +	bool "Use front LED as DISK LED by default"
>   	depends on ADB_PMU_LED
>   	depends on LEDS_CLASS
>   	depends on IDE_GD_ATA
>   	select LEDS_TRIGGERS
> -	select LEDS_TRIGGER_IDE_DISK
> +	select LEDS_TRIGGER_DISK
>   	help
> -	  This option makes the front LED default to the IDE trigger
> -	  so that it blinks on IDE activity.
> +	  This option makes the front LED default to the disk trigger
> +	  so that it blinks on disk activity.
>
>   config PMAC_SMU
>   	bool "Support for SMU  based PowerMacs"
> diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
> index 19c3718..ae067ab 100644
> --- a/drivers/macintosh/via-pmu-led.c
> +++ b/drivers/macintosh/via-pmu-led.c
> @@ -73,8 +73,8 @@ static void pmu_led_set(struct led_classdev *led_cdev,
>
>   static struct led_classdev pmu_led = {
>   	.name = "pmu-led::front",
> -#ifdef CONFIG_ADB_PMU_LED_IDE
> -	.default_trigger = "ide-disk",
> +#ifdef CONFIG_ADB_PMU_LED_DISK
> +	.default_trigger = "disk-activity",
>   #endif
>   	.brightness_set = pmu_led_set,
>   };
>


-- 
Best regards,
Jacek Anaszewski
