Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn9531md1zDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:06:31 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y7so21382076pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:06:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 06/13] powerpc/64s: idle branch to handler with virtual mode
 offset
Date: Tue, 13 Jun 2017 23:05:50 +1000
Message-Id: <20170613130557.26315-7-npiggin@gmail.com>
In-Reply-To: <20170613130557.26315-1-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
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
 arch/powerpc/include/asm/exception-64s.h | 13 +++++++++++++
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 183d73b6ed99..33473cbc0986 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -236,6 +236,19 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
+/*
+ * Branch to label using its 0xC000 address. This results in instruction
+ * address suitable for MSR[IR]=0 or 1, which allows relocation to be turned
+ * on using mtmsr rather than rfid.
+ *
+ * This could set the 0xc bits for !RELOCATABLE as an immediate, rather than
+ * load KBASE for a slight optimisation.
+ */
+#define BRANCH_TO_C000(reg, label)					\
+	__LOAD_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
 #ifdef CONFIG_RELOCATABLE
 #define BRANCH_TO_COMMON(reg, label)					\
 	__LOAD_HANDLER(reg, label);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 31a9114860c4..ada0a20ef46c 100644
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
