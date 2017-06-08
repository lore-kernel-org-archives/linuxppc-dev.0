Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk9085cmlzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:52 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id u26so5581125pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 07/14] powerpc/64s: idle branch to handler with virtual mode
 offset
Date: Fri,  9 Jun 2017 01:51:06 +1000
Message-Id: <20170608155113.21300-8-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have the system reset idle wakeup handlers branched to in real mode
with the 0xc... kernel address applied. This allows simplifications of
avoiding rfid when switching to virtual mode in the wakeup handler.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 17 ++++++++++++++---
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 183d73b6ed99..0912e328e1d7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -236,15 +236,26 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
+/*
+ * Branch to label using its 0xC000 address. This gives the same real address
+ * when relocation is off, but allows mtmsr to set MSR[IR|DR]=1.
+ * This could set the 0xc bits for !RELOCATABLE rather than load KBASE for
+ * a slight optimisation.
+ */
+#define BRANCH_TO_C000(reg, label)					\
+	__LOAD_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
 #ifdef CONFIG_RELOCATABLE
 #define BRANCH_TO_COMMON(reg, label)					\
 	__LOAD_HANDLER(reg, label);					\
 	mtctr	reg;							\
 	bctr
 
-#define BRANCH_LINK_TO_FAR(label)					\
-	__LOAD_FAR_HANDLER(r12, label);					\
-	mtctr	r12;							\
+#define BRANCH_LINK_TO_FAR(reg, label)					\
+	__LOAD_FAR_HANDLER(reg, label);					\
+	mtctr	reg;							\
 	bctrl
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 52ad0789fa89..153cd967554a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -99,7 +99,9 @@ EXC_VIRT_NONE(0x4000, 0x100)
 #ifdef CONFIG_PPC_P7_NAP
 	/*
 	 * If running native on arch 2.06 or later, check if we are waking up
-	 * from nap/sleep/winkle, and branch to idle handler.
+	 * from nap/sleep/winkle, and branch to idle handler. The idle wakeup
+	 * handler initially runs in real mode, but we branch to the 0xc000...
+	 * address so we can turn on relocation with mtmsr.
 	 */
 #define IDLETEST(n)							\
 	BEGIN_FTR_SECTION ;						\
@@ -107,7 +109,7 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	rlwinm.	r10,r10,47-31,30,31 ;					\
 	beq-	1f ;							\
 	cmpwi	cr3,r10,2 ;						\
-	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
+	BRANCH_TO_C000(r10, system_reset_idle_common) ;			\
 1:									\
 	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #else
-- 
2.11.0
