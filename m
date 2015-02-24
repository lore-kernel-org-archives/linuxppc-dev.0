Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BEE91A0D93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 14:30:51 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, sam.bobroff@au1.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Russell King <linux@arm.linux.org.uk>, peterz@infradead.org,
 Don Zickus <dzickus@redhat.com>
Subject: [PATCH 6/7] dump_stack: Serialise dump_stack with
 die_spin_lock_{irqsave, irqrestore}
Date: Tue, 24 Feb 2015 14:30:33 +1100
Message-Id: <1424748634-9153-7-git-send-email-anton@samba.org>
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

Remove another version of a recursive lock in dump_stack.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 lib/dump_stack.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6745c62..f64ee3c 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -7,7 +7,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
-#include <linux/atomic.h>
+#include <linux/die_lock.h>
 
 static void __dump_stack(void)
 {
@@ -20,44 +20,12 @@ static void __dump_stack(void)
  *
  * Architectures can override this implementation by implementing its own.
  */
-#ifdef CONFIG_SMP
-static atomic_t dump_lock = ATOMIC_INIT(-1);
-
 asmlinkage __visible void dump_stack(void)
 {
-	int was_locked;
-	int old;
-	int cpu;
-
-	/*
-	 * Permit this cpu to perform nested stack dumps while serialising
-	 * against other CPUs
-	 */
-	preempt_disable();
-
-retry:
-	cpu = smp_processor_id();
-	old = atomic_cmpxchg(&dump_lock, -1, cpu);
-	if (old == -1) {
-		was_locked = 0;
-	} else if (old == cpu) {
-		was_locked = 1;
-	} else {
-		cpu_relax();
-		goto retry;
-	}
-
-	__dump_stack();
+	unsigned long flags;
 
-	if (!was_locked)
-		atomic_set(&dump_lock, -1);
-
-	preempt_enable();
-}
-#else
-asmlinkage __visible void dump_stack(void)
-{
+	die_spin_lock_irqsave(flags);
 	__dump_stack();
+	die_spin_unlock_irqrestore(flags);
 }
-#endif
 EXPORT_SYMBOL(dump_stack);
-- 
2.1.0
