Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F887DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 13:56:57 +1000 (EST)
In-Reply-To: <20070612085931.GG23294@moe.telargo.com>
References: <20070612085931.GG23294@moe.telargo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ECDF5931-F264-4083-B4F0-C8CA1976195A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mpc5200: /dev/watchdog driver for GPT0
Date: Wed, 13 Jun 2007 22:57:29 -0500
To: Domen Puncer <domen.puncer@telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 12, 2007, at 3:59 AM, Domen Puncer wrote:

> Driver for internal mpc5200 watchdog on general purpose timer 0.
> For IPB clock of 132 MHz the maximum timeout is about 32 seconds.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Should really be submitted to the watchdog maintainer if you want  
this in the kernel

> ---
> Hi!
>
> I also have some generic GPT code that one could extend with
> what he/she needs. Mail me if you'd find it useful.
>
>
>  drivers/char/watchdog/Kconfig       |    4
>  drivers/char/watchdog/Makefile      |    1
>  drivers/char/watchdog/mpc5200_wdt.c |  257 ++++++++++++++++++++++++ 
> ++++++++++++
>  3 files changed, 262 insertions(+)
>
> Index: work-powerpc.git/drivers/char/watchdog/Kconfig
> ===================================================================
> --- work-powerpc.git.orig/drivers/char/watchdog/Kconfig
> +++ work-powerpc.git/drivers/char/watchdog/Kconfig
> @@ -521,6 +521,10 @@ config 8xx_WDT
>  	tristate "MPC8xx Watchdog Timer"
>  	depends on 8xx
>
> +config MPC5200_WDT
> +	tristate "MPC5200 Watchdog Timer"
> +	depends on PPC_MPC52xx
> +
>  config 83xx_WDT
>  	tristate "MPC83xx Watchdog Timer"
>  	depends on PPC_83xx
> Index: work-powerpc.git/drivers/char/watchdog/Makefile
> ===================================================================
> --- work-powerpc.git.orig/drivers/char/watchdog/Makefile
> +++ work-powerpc.git/drivers/char/watchdog/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc
>
>  # PowerPC Architecture
>  obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
> +obj-$(CONFIG_MPC5200_WDT) += mpc5200_wdt.o
>  obj-$(CONFIG_83xx_WDT) += mpc83xx_wdt.o
>  obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
>  obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
> Index: work-powerpc.git/drivers/char/watchdog/mpc5200_wdt.c
> ===================================================================
> --- /dev/null
> +++ work-powerpc.git/drivers/char/watchdog/mpc5200_wdt.c
> @@ -0,0 +1,257 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/watchdog.h>
> +#include <linux/io.h>
> +#include <asm/of_platform.h>
> +#include <asm/uaccess.h>
> +#include <asm/mpc52xx.h>
> +
> +
> +#define GPT_MODE_WDT		(1<<15)
> +#define GPT_MODE_CE		(1<<12)
> +#define GPT_MODE_MS_TIMER	(0x4)
> +
> +
> +struct mpc5200_wdt {
> +	unsigned count;	/* timer ticks before watchdog kicks in */
> +	long ipb_freq;
> +	struct miscdevice miscdev;
> +	struct resource mem;
> +	struct mpc52xx_gpt __iomem *regs;
> +	struct mpc52xx_gpt saved_regs;

saved_regs isn't used anywhere

[snip]

- k
