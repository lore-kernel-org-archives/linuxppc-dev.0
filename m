Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5WNy3MnTzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 05:47:14 +1100 (AEDT)
Date: Mon, 2 Oct 2017 20:46:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Don Zickus <dzickus@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC GIT Pull] core watchdog sanitizing
In-Reply-To: <CA+55aFxQsmSb=zohGZOZK7eR4n5xOHNArmCa9j1b7+wJ+khQrg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710021957480.2114@nanos>
References: <alpine.DEB.2.20.1710011217510.3874@nanos>
 <CA+55aFxQsmSb=zohGZOZK7eR4n5xOHNArmCa9j1b7+wJ+khQrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 1 Oct 2017, Linus Torvalds wrote:
> So get rid of that kind of shit, and I may reconsider. But as is, I
> look at that patch and say "no, this is worse than the garbage it used
> to be".

I agree that adding that 'run' argument was certainly not a piece of
art. Though I disagree with the sentiment that non-functional garbage is
preferrable over functionally correct code which merily contains a bad
implementation choice. Without knowing you for years, it would certainly
seem more rewarding to dump garbage and get it merged, than caring and
mopping up garbage, which should not have been merged in the first
place. Your motivation skills are truly outstanding.

Enough vented. Find below the cure for that major offense.

Thanks,

	tglx

8<--------------------

Subject: watchdog/core, powerpc: Replace watchdog_nmi_reconfigure()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 02 Oct 2017 12:34:50 +0200

The recent cleanup of the watchdog code split watchdog_nmi_reconfigure()
into two stages. One to stop the NMI and one to restart it after
reconfiguration. That was done by adding a boolean 'run' argument to the
function, which is functionally correct but not necessarily a piece of art.

Replace it by two explicit functions: watchdog_nmi_stop() and
watchdog_nmi_start().

Fixes: 6592ad2fcc8f ("watchdog/core, powerpc: Make watchdog_nmi_reconfigure() two stage")
Requested-by: Linus 'Nursing his pet-peeve' Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Thomas 'Mopping up garbage' Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/kernel/watchdog.c |   23 ++++++++++++++---------
 include/linux/nmi.h            |    3 ++-
 kernel/watchdog.c              |   33 ++++++++++++++++++---------------
 3 files changed, 34 insertions(+), 25 deletions(-)

--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -355,19 +355,24 @@ static void watchdog_calc_timeouts(void)
 	wd_timer_period_ms = watchdog_thresh * 1000 * 2 / 5;
 }
 
-void watchdog_nmi_reconfigure(bool run)
+void watchdog_nmi_stop(void)
 {
 	int cpu;
 
 	cpus_read_lock();
-	if (!run) {
-		for_each_cpu(cpu, &wd_cpus_enabled)
-			stop_wd_on_cpu(cpu);
-	} else {
-		watchdog_calc_timeouts();
-		for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
-			start_wd_on_cpu(cpu);
-	}
+	for_each_cpu(cpu, &wd_cpus_enabled)
+		stop_wd_on_cpu(cpu);
+	cpus_read_unlock();
+}
+
+void watchdog_nmi_start(void)
+{
+	int cpu;
+
+	cpus_read_lock();
+	watchdog_calc_timeouts();
+	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
+		start_wd_on_cpu(cpu);
 	cpus_read_unlock();
 }
 
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -109,7 +109,8 @@ static inline int hardlockup_detector_pe
 # endif
 #endif
 
-void watchdog_nmi_reconfigure(bool run);
+void watchdog_nmi_stop(void);
+void watchdog_nmi_start(void);
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -123,24 +123,27 @@ int __weak __init watchdog_nmi_probe(voi
 }
 
 /**
- * watchdog_nmi_reconfigure - Optional function to reconfigure NMI watchdogs
- * @run:	If false stop the watchdogs on all enabled CPUs
- *		If true start the watchdogs on all enabled CPUs
+ * watchdog_nmi_stop - Stop the watchdog for reconfiguration
  *
- * The core call order is:
- * watchdog_nmi_reconfigure(false);
+ * The reconfiguration steps are:
+ * watchdog_nmi_stop();
  * update_variables();
- * watchdog_nmi_reconfigure(true);
+ * watchdog_nmi_start();
+ */
+void __weak watchdog_nmi_stop(void) { }
+
+/**
+ * watchdog_nmi_start - Start the watchdog after reconfiguration
  *
- * The second call which starts the watchdogs again guarantees that the
- * following variables are stable across the call.
+ * Counterpart to watchdog_nmi_stop().
+ *
+ * The following variables have been updated in update_variables() and
+ * contain the currently valid configuration:
  * - watchdog_enabled
  * - watchdog_thresh
  * - watchdog_cpumask
- *
- * After the call the variables can be changed again.
  */
-void __weak watchdog_nmi_reconfigure(bool run) { }
+void __weak watchdog_nmi_start(void) { }
 
 /**
  * lockup_detector_update_enable - Update the sysctl enable bit
@@ -551,13 +554,13 @@ static void softlockup_unpark_threads(vo
 
 static void softlockup_reconfigure_threads(void)
 {
-	watchdog_nmi_reconfigure(false);
+	watchdog_nmi_stop();
 	softlockup_park_all_threads();
 	set_sample_period();
 	lockup_detector_update_enable();
 	if (watchdog_enabled && watchdog_thresh)
 		softlockup_unpark_threads();
-	watchdog_nmi_reconfigure(true);
+	watchdog_nmi_start();
 }
 
 /*
@@ -602,9 +605,9 @@ static inline void watchdog_disable_all_
 static inline void softlockup_init_threads(void) { }
 static void softlockup_reconfigure_threads(void)
 {
-	watchdog_nmi_reconfigure(false);
+	watchdog_nmi_stop();
 	lockup_detector_update_enable();
-	watchdog_nmi_reconfigure(true);
+	watchdog_nmi_start();
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
