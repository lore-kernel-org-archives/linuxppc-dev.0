Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CB9B2C0148
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 13:08:40 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v1][PATCH 1/1] powerpc/ppc64: rename SOFT_DISABLE_INTS with
 RECONCILE_IRQ_STATE
Date: Tue, 16 Jul 2013 11:09:30 +0800
Message-ID: <1373944170-22559-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SOFT_DISABLE_INTS seems an odd name for something that updates the
software state to be consistent with interrupts being hard disabled, so
rename SOFT_DISABLE_INTS with RECONCILE_IRQ_STATE to avoid this confusion.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
Ben,

Looks currently RECONCILE_IRQ_STATE is our better choice as we discussed :)

Tiejun

 arch/powerpc/include/asm/exception-64s.h |    2 +-
 arch/powerpc/include/asm/irqflags.h      |    7 ++++---
 arch/powerpc/kernel/entry_64.S           |    4 ++--
 arch/powerpc/kernel/exceptions-64e.S     |    4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 07ca627..4834a6d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -479,7 +479,7 @@ label##_relon_hv:							\
  */
 
 /* Exception addition: Hard disable interrupts */
-#define DISABLE_INTS	SOFT_DISABLE_INTS(r10,r11)
+#define DISABLE_INTS	RECONCILE_IRQ_STATE(r10,r11)
 
 #define ADD_NVGPRS				\
 	bl	.save_nvgprs
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 6f9b6e2..f51a558 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -40,9 +40,10 @@
 #define TRACE_DISABLE_INTS	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_off)
 
 /*
- * This is used by assembly code to soft-disable interrupts
+ * This is used by assembly code to soft-disable interrupts first and
+ * reconcile irq state.
  */
-#define SOFT_DISABLE_INTS(__rA, __rB)		\
+#define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
 	cmpwi	cr0,__rA,0;			\
@@ -58,7 +59,7 @@
 #define TRACE_ENABLE_INTS
 #define TRACE_DISABLE_INTS
 
-#define SOFT_DISABLE_INTS(__rA, __rB)		\
+#define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
 	li	__rB,0;				\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ab15b8d..c1055a1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -721,9 +721,9 @@ resume_kernel:
 
 	/*
 	 * Here we are preempting the current task. We want to make
-	 * sure we are soft-disabled first
+	 * sure we are soft-disabled first and reconcile irq state.
 	 */
-	SOFT_DISABLE_INTS(r3,r4)
+	RECONCILE_IRQ_STATE(r3,r4)
 1:	bl	.preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index be3b4b1..e71511c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -198,9 +198,9 @@ exc_##n##_common:							    \
 /* This second version is meant for exceptions that don't immediately
  * hard-enable. We set a bit in paca->irq_happened to ensure that
  * a subsequent call to arch_local_irq_restore() will properly
- * hard-enable and avoid the fast-path
+ * hard-enable and avoid the fast-path, and then reconcile irq state.
  */
-#define INTS_DISABLE	SOFT_DISABLE_INTS(r3,r4)
+#define INTS_DISABLE	RECONCILE_IRQ_STATE(r3,r4)
 
 /* This is called by exceptions that used INTS_KEEP (that did not touch
  * irq indicators in the PACA). This will restore MSR:EE to it's previous
-- 
1.7.9.5
