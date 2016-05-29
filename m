Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHdhG6k4bzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 22:03:58 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: Avoid load hit store in __giveup_fpu() and
 __giveup_altivec()
Date: Sun, 29 May 2016 22:03:50 +1000
Message-Id: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

In both __giveup_fpu() and __giveup_altivec() we make two modifications
to tsk->thread.regs->msr. gcc decides to do a read/modify/write of
each change, so we end up with a load hit store:

        ld      r9,264(r10)
        rldicl  r9,r9,50,1
        rotldi  r9,r9,14
        std     r9,264(r10)
...
        ld      r9,264(r10)
        rldicl  r9,r9,40,1
        rotldi  r9,r9,24
        std     r9,264(r10)

Fix this by using a temporary.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e2f12cb..7da1f92 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -139,12 +139,16 @@ EXPORT_SYMBOL(__msr_check_and_clear);
 #ifdef CONFIG_PPC_FPU
 void __giveup_fpu(struct task_struct *tsk)
 {
+	u64 msr;
+
 	save_fpu(tsk);
-	tsk->thread.regs->msr &= ~MSR_FP;
+	msr = tsk->thread.regs->msr;
+	msr &= ~MSR_FP;
 #ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
-		tsk->thread.regs->msr &= ~MSR_VSX;
+		msr &= ~MSR_VSX;
 #endif
+	tsk->thread.regs->msr = msr;
 }
 
 void giveup_fpu(struct task_struct *tsk)
@@ -219,12 +223,16 @@ static int restore_fp(struct task_struct *tsk) { return 0; }
 
 static void __giveup_altivec(struct task_struct *tsk)
 {
+	u64 msr;
+
 	save_altivec(tsk);
-	tsk->thread.regs->msr &= ~MSR_VEC;
+	msr = tsk->thread.regs->msr;
+	msr &= ~MSR_VEC;
 #ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
-		tsk->thread.regs->msr &= ~MSR_VSX;
+		msr &= ~MSR_VSX;
 #endif
+	tsk->thread.regs->msr = msr;
 }
 
 void giveup_altivec(struct task_struct *tsk)
-- 
2.7.4
