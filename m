Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKvQq6qm1zDqXb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 14:30:11 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id fg1so2172475pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 21:30:11 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/asm: Define STACK_OFFSET macro in asm-offsets.c
Date: Thu,  2 Jun 2016 14:29:47 +1000
Message-Id: <1464841788-17465-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464841788-17465-1-git-send-email-rashmicy@gmail.com>
References: <1464841788-17465-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are quite a few entries in asm-offests.c look like this:
DEFINE(REG, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, reg));

So define a local MACRO to clean this up:
STACK_OFFSET(sym, val) DEFINE(sym, STACK_FRAME_OVERHEAD + \
               offsetof(struct pt_regs, val))

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c | 61 ++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 345a351909c5..3dbd3bd016ba 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -68,6 +68,9 @@
 #include "../mm/mmu_decl.h"
 #endif
 
+#define STACK_OFFSET(sym, val) DEFINE(sym, STACK_FRAME_OVERHEAD + \
+		offsetof(struct pt_regs, val))
+
 int main(void)
 {
 	OFFSET(THREAD, task_struct, thread);
@@ -253,38 +256,38 @@ int main(void)
 	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
 	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
 #endif /* CONFIG_PPC64 */
-	DEFINE(GPR0, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[0]));
-	DEFINE(GPR1, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[1]));
-	DEFINE(GPR2, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[2]));
-	DEFINE(GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[3]));
-	DEFINE(GPR4, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[4]));
-	DEFINE(GPR5, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[5]));
-	DEFINE(GPR6, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[6]));
-	DEFINE(GPR7, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[7]));
-	DEFINE(GPR8, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[8]));
-	DEFINE(GPR9, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[9]));
-	DEFINE(GPR10, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[10]));
-	DEFINE(GPR11, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[11]));
-	DEFINE(GPR12, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[12]));
-	DEFINE(GPR13, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[13]));
+	STACK_OFFSET(GPR0, gpr[0]);
+	STACK_OFFSET(GPR1, gpr[1]);
+	STACK_OFFSET(GPR2, gpr[2]);
+	STACK_OFFSET(GPR3, gpr[3]);
+	STACK_OFFSET(GPR4, gpr[4]);
+	STACK_OFFSET(GPR5, gpr[5]);
+	STACK_OFFSET(GPR6, gpr[6]);
+	STACK_OFFSET(GPR7, gpr[7]);
+	STACK_OFFSET(GPR8, gpr[8]);
+	STACK_OFFSET(GPR9, gpr[9]);
+	STACK_OFFSET(GPR10, gpr[10]);
+	STACK_OFFSET(GPR11, gpr[11]);
+	STACK_OFFSET(GPR12, gpr[12]);
+	STACK_OFFSET(GPR13, gpr[13]);
 #ifndef CONFIG_PPC64
-	DEFINE(GPR14, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[14]));
+	STACK_OFFSET(GPR14, gpr[14]);
 #endif /* CONFIG_PPC64 */
 	/*
 	 * Note: these symbols include _ because they overlap with special
 	 * register names
 	 */
-	DEFINE(_NIP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, nip));
-	DEFINE(_MSR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, msr));
-	DEFINE(_CTR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, ctr));
-	DEFINE(_LINK, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, link));
-	DEFINE(_CCR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, ccr));
-	DEFINE(_XER, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, xer));
-	DEFINE(_DAR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dar));
-	DEFINE(_DSISR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dsisr));
-	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
-	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
-	DEFINE(_TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+	STACK_OFFSET(_NIP, nip);
+	STACK_OFFSET(_MSR, msr);
+	STACK_OFFSET(_CTR, ctr);
+	STACK_OFFSET(_LINK, link);
+	STACK_OFFSET(_CCR, ccr);
+	STACK_OFFSET(_XER, xer);
+	STACK_OFFSET(_DAR, dar);
+	STACK_OFFSET(_DSISR, dsisr);
+	STACK_OFFSET(ORIG_GPR3, orig_gpr3);
+	STACK_OFFSET(RESULT, result);
+	STACK_OFFSET(_TRAP, trap);
 #ifndef CONFIG_PPC64
 	/*
 	 * The PowerPC 400-class & Book-E processors have neither the DAR
@@ -292,10 +295,10 @@ int main(void)
 	 * DEAR and ESR SPRs for such processors.  For critical interrupts
 	 * we use them to hold SRR0 and SRR1.
 	 */
-	DEFINE(_DEAR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dar));
-	DEFINE(_ESR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dsisr));
+	STACK_OFFSET(_DEAR, dar);
+	STACK_OFFSET(_ESR, dsisr);
 #else /* CONFIG_PPC64 */
-	DEFINE(SOFTE, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, softe));
+	STACK_OFFSET(SOFTE, softe);
 
 	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
 	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
-- 
2.5.0
