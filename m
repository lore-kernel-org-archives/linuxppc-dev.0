Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C061DDDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:59:20 +1100 (EST)
Date: Thu, 21 Feb 2008 22:59:19 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
Message-ID: <20080221195918.GA14636@localhost.localdomain>
References: <20080221194508.GA12896@localhost.localdomain>
	<47BDD587.9060206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47BDD587.9060206@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 01:48:23PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c 
> >b/arch/powerpc/platforms/8xx/m8xx_setup.c
> >index 184f998..0d9f75c 100644
> >--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
> >+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
> >@@ -111,17 +111,12 @@ void __init mpc8xx_calibrate_decr(void)
> > 
> > 	/* Processor frequency is MHz.
> > 	 */
> >-	ppc_tb_freq = 50000000;
> >-	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
> >-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
> >-		                "(not found)\n");
> >-	}
> >-	ppc_tb_freq /= 16;
> > 	ppc_proc_freq = 50000000;
> > 	if (!get_freq("clock-frequency", &ppc_proc_freq))
> > 		printk(KERN_ERR "WARNING: Estimating processor frequency "
> > 		                "(not found)\n");
> > 
> >+	ppc_tb_freq = ppc_proc_freq / 16;
> 
> Shouldn't we just use the timebase-frequency property?

Nope. Most u-boots currently do not setup timebase-frequency, and if
they are setting it up, they're doing it wrong, in sense that Linux
overwrites timebase setup (yeah, in this regard MPC8xx is special).

So, for MPC8xx, Linux doesn't care what timebase setup was used in
the firmware.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
