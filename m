Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 23EE3DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 04:24:02 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 2.6.21-rt7] PowerPC: fix clockevents for classic CPUs
Date: Thu, 24 May 2007 22:25:30 +0400
References: <200705172142.26739.sshtylyov@ru.mvista.com>
In-Reply-To: <200705172142.26739.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705242225.30225.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Uncoditionally set a maximum positive value to the decrementer before calling
an event handler for all "classic" PPC CPUs (although this is only necessary
to clear interrupt on POWER4+, I've been asked to do it this way) -- otherwise
it wouldn't have been done for an offline CPU in periodic mode since the event
reprogramming has been delegated to the timer subsystem.
Also, as the classic decrementer doesn't have periodic mode, make set_mode()
method for this case completely empty.
While at it, add a switch case for CLOCK_EVT_MODE_RESUME to hush the warning.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Testing on "classic" CPUs is still needed (used to work atop of 2.6.18-rt7).

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
