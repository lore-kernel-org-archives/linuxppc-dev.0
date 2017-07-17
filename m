Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9mlC06hWzDqnl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 12:02:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Walleij <linus.walleij@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 opensuse-ppc@opensuse.org, stable@vger.kernel.org
Subject: Re: [PATCH] machintosh: select defaults for cooling
In-Reply-To: <20170714114629.1512-1-linus.walleij@linaro.org>
References: <20170714114629.1512-1-linus.walleij@linaro.org>
Date: Mon, 17 Jul 2017 12:02:29 +1000
Message-ID: <87pocz253e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Walleij <linus.walleij@linaro.org> writes:

> I have this pretty nasty problem when trying to boot up a fresh
> openSuSE DVD on a PowerMac G5: the kernel by default does not have
> CONFIG_WINDFARM_PM72 enabled, with the effect that the cooling
> is not functioning.
>
> The BIOS on the PowerMac G5 reacts to this by, after a grace
> period when the BIOS has waited for the OS to take over, increasing
> the fan speeds so it sounds like an airplane is in the room, and
> after another grace period simply cutting the power to the
> machine. This is done not beacuse the cooling is not working, but
> because the BIOS is not recieving handover of cooling from the
> OS, so it panics and give up. The problem has been reported by
> Linux users online.
>
> Needless to say, this makes it impossible to install the OS
> before the machine turns itself off.
>
> The g5_defconfig looks like this:
> CONFIG_PMAC_SMU=y
> CONFIG_WINDFARM=y
> CONFIG_WINDFARM_PM81=y
> CONFIG_WINDFARM_PM91=y
> CONFIG_WINDFARM_PM112=y
> CONFIG_WINDFARM_PM121=y
>
> Notably PM72 is missing, making the PowerMac G5 fail.
>
> The defconfig is not the right place to do this: it should be
> done by default when selecting Mac support for PPC/PPC64 and
> especially for the Macs CPUfreq driver. We select SMU by default
> for PPC_PMAC64, WINDFARM by default on PPC_PMAC and all the
> WINDFARM thermal managers by default if CPU_FREQ_PMAC64 is
> selected.

I agree with the intent of your patch, but I'm not sure I like the
implementation.

> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 97a420c11eed..d7186d8f30a9 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -101,6 +101,7 @@ config ADB_PMU_LED_DISK
>  config PMAC_SMU
>  	bool "Support for SMU  based PowerMacs"
>  	depends on PPC_PMAC64
> +	default PPC_PMAC64

Defaulting to one of your dependencies is exactly the same as defaulting
to yes (unless it's a tristate).

I think it's fine to make this default y, it has the dependency on the
platform so it won't appear for most users.

> @@ -194,11 +195,13 @@ config THERM_ADT746X
>  config WINDFARM
>  	tristate "New PowerMac thermal control infrastructure"
>  	depends on PPC
> +	default PPC_PMAC
>  
>  config WINDFARM_PM81
>  	tristate "Support for thermal management on iMac G5"
>  	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
>  	select I2C_POWERMAC
> +	default CPU_FREQ_PMAC64
>  	help
>  	  This driver provides thermal control for the iMacG5

These I think should all just be 'default m'.

cheers
