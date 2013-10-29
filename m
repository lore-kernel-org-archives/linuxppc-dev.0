Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 045642C013B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 10:13:28 +1100 (EST)
Message-ID: <1383088392.5117.38.camel@pasglop>
Subject: Re: [PATCH] ADB_PMU_LED_IDE selects LEDS_TRIGGER_IDE_DISK which has
 unmet direct dependencies
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Wed, 30 Oct 2013 10:13:12 +1100
In-Reply-To: <alpine.DEB.2.11.1310280031020.31521@trent.utfs.org>
References: <alpine.DEB.2.11.1310280031020.31521@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-10-28 at 04:26 -0700, Christian Kujau wrote:
> Hi,
> 
> for quite some time the following is printed (twice) after doing
> "make oldconfig":
> 
> [...]
> scripts/kconfig/conf --oldconfig Kconfig
> warning: (ADB_PMU_LED_IDE) selects LEDS_TRIGGER_IDE_DISK which has unmet direct dependencies (NEW_LEDS && IDE_GD_ATA && LEDS_TRIGGERS)
> warning: (ADB_PMU_LED_IDE) selects LEDS_TRIGGER_IDE_DISK which has unmet direct dependencies (NEW_LEDS && IDE_GD_ATA && LEDS_TRIGGERS)
> 
> I never got around to look into this. But I remember that (when I still 
> had CONFIG_IDE selected, because CONFIG_PATA_MACIO was not working for my 
> PowerBook G5), I always had ADB_PMU_LED_IDE selected, so this option was 
> carried over to my current config.
> 
> When doing "make menuconfig" with this generated config I could see that 
> all 3 necessary options are selected:
> 
>  Support for PMU  based PowerMacs               CONFIG_ADB_PMU         
>   Support for the Power/iBook front LED		CONFIG_ADB_PMU_LED
>     Use front LED as IDE LED by default		CONFIG_ADB_PMU_LED_IDE 
> 
> And CONFIG_ADB_PMU_LED_IDE selects CONFIG_LEDS_TRIGGER_IDE_DISK, which in 
> turn depends on CONFIG_IDE_GD_ATA - but in "make menuconfig" I could still
> *unselect* CONFIG_IDE (since I'm using CONFIG_PATA_MACIO) and the 3 
> options above were still available. I guess "make oldconfig" noticed that 
> and hence printed the warning above.
> 
> The following patch causes ADB_PMU_LED to depend on IDE_GD_ATA, so that 
> the options above are only available when IDE_GD_ATA is actually selected 
> and thus eliminates the warning.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 696238b..f30ac9d 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -90,6 +90,7 @@ config ADB_PMU
>  config ADB_PMU_LED
>  	bool "Support for the Power/iBook front LED"
>  	depends on ADB_PMU
> +	depends on IDE_GD_ATA
>  	select NEW_LEDS
>  	select LEDS_CLASS
>  	help

You probably want to do that to the ADB_PMU_LED_IDE entry not the
ADB_PMU_LED one which doesn't have a dependency and isn't the one
selecting LEDS_TRIGGER_IDE_DISK :-)

Cheers,
Ben.

> 
> Being a kbuild n00b, I don't know if this is the correct approach though.
> 
> After looking through the archives I found that this has been reported by 
> Geert back in 2012 already: https://lkml.org/lkml/2012/3/13/556
> 
> Thanks,
> Christian.
