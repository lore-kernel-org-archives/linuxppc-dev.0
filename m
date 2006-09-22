Return-Path: <anton@ozlabs.org>
Date: Fri, 22 Sep 2006 18:26:37 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Always call cede in pseries dedicated idle loop
Message-ID: <20060922082636.GC22420@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The smt_snooze_delay logic changed a bit when the idle loops were
consolidated. A value of 0 used to mean we always polled, now it means
we always sleep. Instead of restoring the old behaviour, lets put a
reasonable default in smt_snooze_delay. This means we spin for a bit (in
case an external interrupt comes in) and then sleep.

Also the pseries dedicated idle loop currently does not cede both
threads in an SMT pair. The hypervisor wants us to call in so it can
power manage, so lets do that.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 31867a7..00231ac 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -456,8 +456,8 @@ static int __init pSeries_probe(void)
 	return 1;
 }
 
-
-DECLARE_PER_CPU(unsigned long, smt_snooze_delay);
+/* Time in microseconds we delay before sleeping in the idle loop */
+DECLARE_PER_CPU(unsigned long, smt_snooze_delay) = { 100 };
 
 static void pseries_dedicated_idle_sleep(void)
 { 
@@ -498,24 +498,7 @@ static void pseries_dedicated_idle_sleep
 			goto out;
 	}
 
-	/*
-	 * If not SMT, cede processor.  If CPU is running SMT
-	 * cede if the other thread is not idle, so that it can
-	 * go single-threaded.  If the other thread is idle,
-	 * we ask the hypervisor if it has pending work it
-	 * wants to do and cede if it does.  Otherwise we keep
-	 * polling in order to reduce interrupt latency.
-	 *
-	 * Doing the cede when the other thread is active will
-	 * result in this thread going dormant, meaning the other
-	 * thread gets to run in single-threaded (ST) mode, which
-	 * is slightly faster than SMT mode with this thread at
-	 * very low priority.  The cede enables interrupts, which
-	 * doesn't matter here.
-	 */
-	if (!cpu_has_feature(CPU_FTR_SMT) || !lppaca[cpu ^ 1].idle
-	    || poll_pending() == H_PENDING)
-		cede_processor();
+	cede_processor();
 
 out:
 	HMT_medium();
