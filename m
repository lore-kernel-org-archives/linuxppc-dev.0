Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF507683C0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 17:44:23 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 17:43:40 +1000
Message-Id: <1128498220.22073.3.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: Fix timekeeping with HZ=250 on some Mac models
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Older Macs which uses the VIA chip timers to calibrate the timebase used
some code that wouldn't work if HZ wasn't divisible by 100... This fixes
it at least for 250. Not totally perfect but should be enough for now
(so it at least works with the default value which is now 250). There is
still a potential issue with the core using CLOCK_TICK_RATE to maintain
xtime and CLOCK_TICK_RATE value on ppc32 is pure crap, but that is a
different problem, this patch at least brings us back to our previous
situation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-09-22 14:06:18.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_time.c	2005-10-05 08:14:17.000000000 +1000
@@ -195,7 +195,7 @@
 		;
 	dend = get_dec();
 
-	tb_ticks_per_jiffy = (dstart - dend) / (6 * (HZ/100));
+	tb_ticks_per_jiffy = (dstart - dend) / ((6 * HZ)/100);
 	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
 
 	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
