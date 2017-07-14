Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x8SfG30SvzDqlX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 08:53:42 +1000 (AEST)
Message-ID: <1500072810.2865.92.camel@kernel.crashing.org>
Subject: Re: [PATCH] machintosh: select defaults for cooling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, opensuse-ppc@opensuse.org,
 stable@vger.kernel.org
Date: Sat, 15 Jul 2017 08:53:30 +1000
In-Reply-To: <20170714114629.1512-1-linus.walleij@linaro.org>
References: <20170714114629.1512-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-14 at 13:46 +0200, Linus Walleij wrote:
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

It's not actually the BIOS but the fan controller HW who does that.

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
> 
> I think this will make install images work in the G5 Macs.

Why is it not the job of the defconfig ? I was under the impression
that just "selecting" like this was frowned upon ? I don't care much
either way mind you, I'll let Michael decide what he wants to do. 

> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/macintosh/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 97a420c11eed..d7186d8f30a9 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -101,6 +101,7 @@ config ADB_PMU_LED_DISK
>  config PMAC_SMU
>  	bool "Support for SMU  based PowerMacs"
>  	depends on PPC_PMAC64
> +	default PPC_PMAC64
>  	help
>  	  This option adds support for the newer G5 iMacs and PowerMacs based
>  	  on the "SMU" system control chip which replaces the old PMU.
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
>  
> @@ -206,6 +209,7 @@ config WINDFARM_PM72
>  	tristate "Support for thermal management on PowerMac G5 (AGP)"
>  	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && ADB_PMU
>  	select I2C_POWERMAC
> +	default CPU_FREQ_PMAC64
>  	help
>  	  This driver provides thermal control for the PowerMac G5
>  	  "AGP" variants (PowerMac 7,2 and 7,3)
> @@ -214,6 +218,7 @@ config WINDFARM_RM31
>  	tristate "Support for thermal management on Xserve G5"
>  	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && ADB_PMU
>  	select I2C_POWERMAC
> +	default CPU_FREQ_PMAC64
>  	help
>  	  This driver provides thermal control for the Xserve G5
>  	  (RackMac3,1)
> @@ -222,6 +227,7 @@ config WINDFARM_PM91
>  	tristate "Support for thermal management on PowerMac9,1"
>  	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
>  	select I2C_POWERMAC
> +	default CPU_FREQ_PMAC64
>  	help
>  	  This driver provides thermal control for the PowerMac9,1
>            which is the recent (SMU based) single CPU desktop G5
