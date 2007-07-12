Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 423A5DDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 02:39:58 +1000 (EST)
Message-ID: <469659D6.7070705@ru.mvista.com>
Date: Thu, 12 Jul 2007 20:41:58 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com>	<20070712065104.GI4375@moe.telargo.com>
	<4696369A.2010200@ru.mvista.com>
In-Reply-To: <4696369A.2010200@ru.mvista.com>
Content-Type: multipart/mixed; boundary="------------020109000906080403010705"
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020109000906080403010705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sergei Shtylyov wrote:
> Hello.
> 
> Domen Puncer wrote:
> 
>>> Does anyone have the definitive patchset to enable the tickless hz,
>>> some kind of hrtimer and the other related improvements in the
>>> PowerPC tree?
> 
> 
>> I use attached patches for tickless.
>> Order in which they're applied:

>> PowerPC_GENERIC_CLOCKEVENTS.patch

    Argh! Finally had forgotten to attach a fixlet for this one, somewaht 
adjusting the code for classic PPC decrementer.

[...]

WBR, Sergei

> PS: All attached patches are against 2.6.21-rt2 -- fitting them into the 
> current (or whatever) version of the kernel is left as an excercise to 
> the readers. ;-)

    This one is for 2.6.21-rt2 as well.

--------------020109000906080403010705
Content-Type: text/x-patch;
 name="PowerPC-fix-clockevents-for-classic-CPU.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PowerPC-fix-clockevents-for-classic-CPU.patch"

Uncoditionally set a maximum positive value to the decrementer before calling
an event handler for all "classic" PPC CPUs (although this is only necessary
to clear interrupt on POWER4+, I've been asked to do it this way) -- otherwise
it wouldn't have been done for an offline CPU in periodic mode since the event
reprogramming has been delegated to the timer subsystem.
Also, as the classic decrementer doesn't have periodic mode, make set_mode()
method for this case completely empty.
While at it, add a switch case for CLOCK_EVT_MODE_RESUME to hush the warning.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/powerpc/kernel/time.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -166,11 +166,14 @@ static void decrementer_set_mode(enum	cl
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		tcr &= ~TCR_DIE;
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 	mtspr(SPRN_TCR, tcr);
-#endif
+
 	if (mode == CLOCK_EVT_MODE_PERIODIC)
 		decrementer_set_next_event(tb_ticks_per_jiffy, dev);
+#endif
 }
 
 static struct clock_event_device decrementer_clockevent = {
@@ -549,16 +552,12 @@ void timer_interrupt(struct pt_regs * re
 	irq_enter();
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#if !defined(CONFIG_40x) && !defined(CONFIG_BOOKE)
 	/*
 	 * We must write a positive value to the decrementer to clear
-	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
-	 * this happens when the decrementer gets reloaded later, but
-	 * in one-shot mode, we have to do it here since an event handler
-	 * may skip loading the new value...
+	 * the interrupt on POWER4+ compatible CPUs.
 	 */
-	if (per_cpu(decrementers, cpu).mode != CLOCK_EVT_MODE_PERIODIC)
-		set_dec(DECREMENTER_MAX);
+	set_dec(DECREMENTER_MAX);
 #endif
 	/*
 	 * We can't disable the decrementer, so in the period between

--------------020109000906080403010705--
