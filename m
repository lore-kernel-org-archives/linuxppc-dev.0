Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5qSb5KL6zDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 17:51:27 +1100 (AEDT)
Date: Tue, 3 Oct 2017 08:50:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure()
 two stage
In-Reply-To: <87d165dqew.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.1710030848210.2281@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
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

On Tue, 3 Oct 2017, Michael Ellerman wrote:
> Hi Thomas,
> Unfortunately this is hitting the WARN_ON in start_wd_cpu() on powerpc
> because we're calling it multiple times for the boot CPU.
> 
> The first call is via:
> 
>   start_wd_on_cpu+0x80/0x2f0
>   watchdog_nmi_reconfigure+0x124/0x170
>   softlockup_reconfigure_threads+0x110/0x130
>   lockup_detector_init+0xbc/0xe0
>   kernel_init_freeable+0x18c/0x37c
>   kernel_init+0x2c/0x160
>   ret_from_kernel_thread+0x5c/0xbc
> 
> And then again via the CPU hotplug registration:
> 
>   start_wd_on_cpu+0x80/0x2f0
>   cpuhp_invoke_callback+0x194/0x620
>   cpuhp_thread_fun+0x7c/0x1b0
>   smpboot_thread_fn+0x290/0x2a0
>   kthread+0x168/0x1b0
>   ret_from_kernel_thread+0x5c/0xbc
> 
> 
> The first call is new because previously watchdog_nmi_reconfigure()
> wasn't called from softlockup_reconfigure_threads().

Hmm, don't you have the same problem with CPU hotplug or do you just get
lucky because the hotplug callback in your code is ordered vs. the
softlockup thread hotplug callback in a way that this does not hit?

> I'm not sure what the easiest fix is. One option would be to just drop
> the WARN_ON, it's just there for paranoia AFAICS.

The straight forward way is to make use of the new probe function. Patch
below.

Thanks,

	tglx

8<------------------
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -375,20 +375,18 @@ void watchdog_nmi_start(void)
 /*
  * This runs after lockup_detector_init() which sets up watchdog_cpumask.
  */
-static int __init powerpc_watchdog_init(void)
+int __init watchdog_nmi_probe(void)
 {
 	int err;
 
-	watchdog_calc_timeouts();
-
-	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/watchdog:online",
-				start_wd_on_cpu, stop_wd_on_cpu);
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"powerpc/watchdog:online",
+					start_wd_on_cpu, stop_wd_on_cpu);
 	if (err < 0)
 		pr_warn("Watchdog could not be initialized");
 
 	return 0;
 }
-arch_initcall(powerpc_watchdog_init);
 
 static void handle_backtrace_ipi(struct pt_regs *regs)
 {
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -608,7 +608,6 @@ static inline int watchdog_park_threads(
 static inline void watchdog_unpark_threads(void) { }
 static inline int watchdog_enable_all_cpus(void) { return 0; }
 static inline void watchdog_disable_all_cpus(void) { }
-static inline void softlockup_init_threads(void) { }
 static void softlockup_reconfigure_threads(void)
 {
 	cpus_read_lock();
@@ -617,6 +616,10 @@ static void softlockup_reconfigure_threa
 	watchdog_nmi_start();
 	cpus_read_unlock();
 }
+static inline void softlockup_init_threads(void)
+{
+	softlockup_reconfigure_threads();
+}
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
 static void __lockup_detector_cleanup(void)
