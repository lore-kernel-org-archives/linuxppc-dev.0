Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72B1A2C0362
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 21:50:21 +1000 (EST)
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
Date: Fri, 13 Jul 2012 06:50:22 -0500
Message-Id: <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
To: Jiang Lu <lu.jiang@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2012, at 9:44 PM, Jiang Lu wrote:

> On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
> of timer can not reset by software after set to a non-zero value.
> Which means software can not reset the timeout behaviour of watchdog timer.
> 
> This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
> indicate the watchdog timer can not be disabled once fired.
> 
> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
> ---
> drivers/watchdog/Kconfig |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

I believe this is not 44x specific, but how Book-E watchdog is architected.

> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3709624..41f3dff 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1084,6 +1084,7 @@ config PIKA_WDT
> config BOOKE_WDT
> 	tristate "PowerPC Book-E Watchdog Timer"
> 	depends on BOOKE || 4xx
> +	select WATCHDOG_NOWAYOUT if 44x

This should probably be 'select WATCHDOG_NOWAYOUT if BOOKE'

> 	---help---
> 	  Watchdog driver for PowerPC Book-E chips, such as the Freescale
> 	  MPC85xx SOCs and the IBM PowerPC 440.
> -- 
> 1.7.7
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
