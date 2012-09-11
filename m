Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A35A2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:37:59 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 11 Sep 2012 11:36:49 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8B1SeP626017934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:28:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8B1bjGJ007715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:37:46 +1000
Message-ID: <1347327463.8364.8.camel@ThinkPad-T420>
Subject: [PATCH powerpc,trace] Avoid suspicious RCU usage reporting for some
 tracepoints
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Sep 2012 09:37:43 +0800
In-Reply-To: <1347315255.11820.45.camel@pasglop>
References: <1347253133.2725.45.camel@ThinkPad-T420>
 <1347253812.2385.148.camel@pasglop>
 <1347285742.10751.6.camel@gandalf.local.home>
 <1347315255.11820.45.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you all, this is the updated patch for your review:

There are a few tracepoints in the interrupt code path, which is before
irq_enter(), or after irq_exit(), like
trace_irq_entry()/trace_irq_exit() in do_IRQ(),
trace_timer_interrupt_entry()/trace_timer_interrupt_exit() in
timer_interrupt(). 

If the interrupt is from idle(), and because tracepoint contains RCU
read-side critical section, we could see following suspicious RCU usage
reported:

[  145.127743] ===============================
[  145.127747] [ INFO: suspicious RCU usage. ]
[  145.127752] 3.6.0-rc3+ #1 Not tainted
[  145.127755] -------------------------------
[  145.127759] /root/.workdir/linux/arch/powerpc/include/asm/trace.h:33
suspicious rcu_dereference_check() usage!
[  145.127765] 
[  145.127765] other info that might help us debug this:
[  145.127765] 
[  145.127771] 
[  145.127771] RCU used illegally from idle CPU!
[  145.127771] rcu_scheduler_active = 1, debug_locks = 0
[  145.127777] RCU used illegally from extended quiescent state!
[  145.127781] no locks held by swapper/0/0.
[  145.127785] 
[  145.127785] stack backtrace:
[  145.127789] Call Trace:
[  145.127796] [c00000000108b530] [c000000000013c40] .show_stack
+0x70/0x1c0 (unreliable)
[  145.127806] [c00000000108b5e0]
[c0000000000f59d8] .lockdep_rcu_suspicious+0x118/0x150
[  145.127813] [c00000000108b680] [c00000000000fc58] .do_IRQ+0x498/0x500
[  145.127820] [c00000000108b750] [c000000000003950]
hardware_interrupt_common+0x150/0x180
[  145.127828] --- Exception: 501 at .plpar_hcall_norets+0x84/0xd4
[  145.127828]     LR = .check_and_cede_processor+0x38/0x70
[  145.127836] [c00000000108bab0] [c0000000000665dc] .shared_cede_loop
+0x5c/0x100
[  145.127844] [c00000000108bb70] [c000000000588ab0] .cpuidle_enter
+0x30/0x50
[  145.127850] [c00000000108bbe0]
[c000000000588b0c] .cpuidle_enter_state+0x3c/0xb0
[  145.127857] [c00000000108bc60] [c000000000589730] .cpuidle_idle_call
+0x150/0x6c0
[  145.127863] [c00000000108bd30] [c000000000058440] .pSeries_idle
+0x10/0x40
[  145.127870] [c00000000108bda0] [c00000000001683c] .cpu_idle
+0x18c/0x2d0
[  145.127876] [c00000000108be60] [c00000000000b434] .rest_init
+0x124/0x1b0
[  145.127884] [c00000000108bef0] [c0000000009d0d28] .start_kernel
+0x568/0x588
[  145.127890] [c00000000108bf90] [c000000000009660] .start_here_common
+0x20/0x40

This is because the RCU usage in interrupt context should be used in
area marked by rcu_irq_enter()/rcu_irq_exit(), called in
irq_enter()/irq_exit() respectively. 

Move them into the irq_enter()/irq_exit() area to avoid the reporting.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/irq.c  |    8 ++++----
 arch/powerpc/kernel/time.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1f017bb..71413f4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -489,10 +489,10 @@ void do_IRQ(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int irq;
 
-	trace_irq_entry(regs);
-
 	irq_enter();
 
+	trace_irq_entry(regs);
+
 	check_stack_overflow();
 
 	/*
@@ -511,10 +511,10 @@ void do_IRQ(struct pt_regs *regs)
 	else
 		__get_cpu_var(irq_stat).spurious_irqs++;
 
+	trace_irq_exit(regs);
+
 	irq_exit();
 	set_irq_regs(old_regs);
-
-	trace_irq_exit(regs);
 }
 
 void __init init_IRQ(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e49e931..bd693a1 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -493,8 +493,6 @@ void timer_interrupt(struct pt_regs * regs)
 	 */
 	may_hard_irq_enable();
 
-	trace_timer_interrupt_entry(regs);
-
 	__get_cpu_var(irq_stat).timer_irqs++;
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
@@ -505,6 +503,8 @@ void timer_interrupt(struct pt_regs * regs)
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
+	trace_timer_interrupt_entry(regs);
+
 	if (test_irq_work_pending()) {
 		clear_irq_work_pending();
 		irq_work_run();
@@ -529,10 +529,10 @@ void timer_interrupt(struct pt_regs * regs)
 	}
 #endif
 
+	trace_timer_interrupt_exit(regs);
+
 	irq_exit();
 	set_irq_regs(old_regs);
-
-	trace_timer_interrupt_exit(regs);
 }
 
 /*
-- 
1.7.1
