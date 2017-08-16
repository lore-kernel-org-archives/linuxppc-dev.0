Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJd73jl6zDr2k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:01:31 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc: Remove redundant clear of MSR_VSX in
 __giveup_vsx()
Date: Wed, 16 Aug 2017 16:01:17 +1000
Message-Id: <20170816060118.24803-4-benh@kernel.crashing.org>
In-Reply-To: <20170816060118.24803-1-benh@kernel.crashing.org>
References: <20170816060118.24803-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__giveup_fpu() already does it and we cannot have MSR_VSX set
without having MSR_FP also set.

This also adds a warning to check we indeed do

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bfbd6083f841..fc285fab7118 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -331,11 +331,19 @@ static inline int restore_altivec(struct task_struct *tsk) { return 0; }
 #ifdef CONFIG_VSX
 static void __giveup_vsx(struct task_struct *tsk)
 {
-	if (tsk->thread.regs->msr & MSR_FP)
+	unsigned long msr = tsk->thread.regs->msr;
+
+	/*
+	 * We should never be ssetting MSR_VSX without also setting
+	 * MSR_FP and MSR_VEC
+	 */
+	WARN_ON((msr & MSR_VSX) && !((msr & MSR_FP) && (msr & MSR_VEC)));
+
+	/* __giveup_fpu will clear MSR_VSX */
+	if (msr & MSR_FP)
 		__giveup_fpu(tsk);
-	if (tsk->thread.regs->msr & MSR_VEC)
+	if (msr & MSR_VEC)
 		__giveup_altivec(tsk);
-	tsk->thread.regs->msr &= ~MSR_VSX;
 }
 
 static void giveup_vsx(struct task_struct *tsk)
-- 
2.13.4
