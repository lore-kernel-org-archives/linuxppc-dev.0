Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 209FC1A0DBE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 14:30:42 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, sam.bobroff@au1.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Russell King <linux@arm.linux.org.uk>, peterz@infradead.org,
 Don Zickus <dzickus@redhat.com>
Subject: [PATCH 2/7] powerpc: Use die_spin_lock_{irqsave,irqrestore}
Date: Tue, 24 Feb 2015 14:30:29 +1100
Message-Id: <1424748634-9153-3-git-send-email-anton@samba.org>
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the powerpc specific oops locking with the common one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/traps.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 19e4744..4cc1e72 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -36,6 +36,7 @@
 #include <linux/debugfs.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
+#include <linux/die_lock.h>
 
 #include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
@@ -109,14 +110,10 @@ static void pmac_backlight_unblank(void)
 static inline void pmac_backlight_unblank(void) { }
 #endif
 
-static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-static int die_owner = -1;
-static unsigned int die_nest_count;
 static int die_counter;
 
 static unsigned __kprobes long oops_begin(struct pt_regs *regs)
 {
-	int cpu;
 	unsigned long flags;
 
 	if (debugger(regs))
@@ -124,17 +121,7 @@ static unsigned __kprobes long oops_begin(struct pt_regs *regs)
 
 	oops_enter();
 
-	/* racy, but better than risking deadlock. */
-	raw_local_irq_save(flags);
-	cpu = smp_processor_id();
-	if (!arch_spin_trylock(&die_lock)) {
-		if (cpu == die_owner)
-			/* nested oops. should stop eventually */;
-		else
-			arch_spin_lock(&die_lock);
-	}
-	die_nest_count++;
-	die_owner = cpu;
+	die_spin_lock_irqsave(flags);
 	console_verbose();
 	bust_spinlocks(1);
 	if (machine_is(powermac))
@@ -146,15 +133,10 @@ static void __kprobes oops_end(unsigned long flags, struct pt_regs *regs,
 			       int signr)
 {
 	bust_spinlocks(0);
-	die_owner = -1;
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	die_nest_count--;
 	oops_exit();
 	printk("\n");
-	if (!die_nest_count)
-		/* Nest count reaches zero, release the lock. */
-		arch_spin_unlock(&die_lock);
-	raw_local_irq_restore(flags);
+	die_spin_unlock_irqrestore(flags);
 
 	crash_fadump(regs, "die oops");
 
-- 
2.1.0
