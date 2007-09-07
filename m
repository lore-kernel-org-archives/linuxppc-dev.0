Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CD160DDF50
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 05:15:58 +1000 (EST)
Date: Fri, 7 Sep 2007 14:16:16 -0500
From: Olof Johansson <olof@lixom.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
Message-ID: <20070907191616.GB6765@lixom.net>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
	<1189173891.28781.162.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189173891.28781.162.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 04:04:51PM +0200, Johannes Berg wrote:
> On Fri, 2007-09-07 at 00:44 +1000, Paul Mackerras wrote:
> > This creates a clockevent for the PowerPC decrementer and registers it
> > with the generic clock/timer system, and implements the dynamic ticks
> > (no idle HZ) option for PowerPC.
> 
> I tried both patches applied and with/without CONFIG_NOHZ but my quad G5
> won't boot. Anybody else have more luck?

Did you try with the two changes I suggested? Patch below.


diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 1353d73..c863b07 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -554,6 +554,7 @@ void timer_interrupt(struct pt_regs * regs)
 	u64 tb_next_jiffy;
 	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
 
+	set_dec(DECREMENTER_MAX);
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
@@ -931,8 +932,6 @@ void __init time_init(void)
 
 	/* Register the clocksource */
 	clocksource_init();
-
-	set_dec(DECREMENTER_MAX);
 }
 
 
