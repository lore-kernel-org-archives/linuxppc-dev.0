Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3D807DE0A3
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 08:13:45 +1100 (EST)
Date: Fri, 22 Feb 2008 00:13:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
Message-ID: <20080221211343.GA24786@localhost.localdomain>
References: <20080221194508.GA12896@localhost.localdomain>
	<47BDD587.9060206@freescale.com>
	<20080221195918.GA14636@localhost.localdomain>
	<47BDD9E2.5050007@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47BDD9E2.5050007@freescale.com>
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

On Thu, Feb 21, 2008 at 02:06:58PM -0600, Scott Wood wrote:
[...]
> >>>+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
> >>>@@ -111,17 +111,12 @@ void __init mpc8xx_calibrate_decr(void)
> >>>
> >>>	/* Processor frequency is MHz.
> >>>	 */
> >>>-	ppc_tb_freq = 50000000;
> >>>-	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
> >>>-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
> >>>-		                "(not found)\n");
> >>>-	}
> >>>-	ppc_tb_freq /= 16;
> >>>	ppc_proc_freq = 50000000;
> >>>	if (!get_freq("clock-frequency", &ppc_proc_freq))
> >>>		printk(KERN_ERR "WARNING: Estimating processor frequency "
> >>>		                "(not found)\n");
> >>>
> >>>+	ppc_tb_freq = ppc_proc_freq / 16;
> >>Shouldn't we just use the timebase-frequency property?
> >
> >Nope. Most u-boots currently do not setup timebase-frequency, and if
> >they are setting it up, they're doing it wrong, in sense that Linux
> >overwrites timebase setup (yeah, in this regard MPC8xx is special).
> 
> Current u-boots don't support device trees at all on 8xx.

Yes, vanilla u-boots. I assume many of us use some u-boot hacks to
actually boot with the device tree (no, not cuboots)... ;-)

> The most 
> recent 8xx FDT patch I saw called get_tbclk() to fill in 
> timebase-frequency; does get_tbclk() not work?

I don't know. I didn't look at this, it isn't interesting because
currently getting timebase-frequency from the device tree is
meaningless on MPC8xx. Linux is doing timebase stuff on its own.

Surely, moving timebase setup code into the cuboot will solve
backwards compatibility issues, so we'll setup timebase-frequency
there, and will use generic_calibrate_decr(). And for FDT-aware
u-boots we'll simply get fixed up timebase-frequency.

Unfortunately (or fortunately ;-) I don't have this 8xx board
any longer, so I'd suggest to not expect such 8xx cleanups from
me in near future...

If you have such patches pending... surely, they would be more
correct way to solve the issue.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
