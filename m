Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Date: Sun, 25 Jun 2006 22:13:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, mingo@elte.hu, schwidefsky@de.ibm.com
Subject: [PATCH] Remove extra local_bh_disable/enable from arch do_softirq
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At the moment, powerpc and s390 have their own versions of do_softirq
which include local_bh_disable() and __local_bh_enable() calls.  They
end up calling __do_softirq (in kernel/softirq.c) which also does
local_bh_disable/enable.

Apparently the two levels of disable/enable trigger a warning from
some validation code that Ingo is working on, and he would like to see
the outer level removed.  But to do that, we have to move the
account_system_vtime calls that are currently in the arch do_softirq()
implementations for powerpc and s390 into the generic __do_softirq()
(this is a no-op for other archs because account_system_vtime is
defined to be an empty inline function on all other archs).  This
patch does that.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
The s390 change here needs to be acked by the s390 folks, in case
there's a subtlety on s390 that I have missed.

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 40d4c14..2b52802 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -425,13 +425,8 @@ void do_softirq(void)
 
 	local_irq_save(flags);
 
-	if (local_softirq_pending()) {
-		account_system_vtime(current);
-		local_bh_disable();
+	if (local_softirq_pending())
 		do_softirq_onstack();
-		account_system_vtime(current);
-		__local_bh_enable();
-	}
 
 	local_irq_restore(flags);
 }
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 480b6a5..1eef509 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -69,10 +69,6 @@ asmlinkage void do_softirq(void)
 
 	local_irq_save(flags);
 
-	account_system_vtime(current);
-
-	local_bh_disable();
-
 	if (local_softirq_pending()) {
 		/* Get current stack pointer. */
 		asm volatile("la %0,0(15)" : "=a" (old));
@@ -95,10 +91,6 @@ asmlinkage void do_softirq(void)
 			__do_softirq();
 	}
 
-	account_system_vtime(current);
-
-	__local_bh_enable();
-
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 336f92d..20922c5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -81,6 +81,7 @@ asmlinkage void __do_softirq(void)
 
 	pending = local_softirq_pending();
 
+	account_system_vtime(current);
 	local_bh_disable();
 	cpu = smp_processor_id();
 restart:
@@ -109,6 +110,7 @@ restart:
 	if (pending)
 		wakeup_softirqd();
 
+	account_system_vtime(current);
 	__local_bh_enable();
 }
 
