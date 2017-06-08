Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8fD3Q8RzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:36:20 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f27so5541378pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:36:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] powerpc/64s: context switch leave interrupts hard enabled
 for radix
Date: Fri,  9 Jun 2017 01:36:06 +1000
Message-Id: <20170608153609.19217-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4387e9ff25 ("[POWERPC] Fix PMU + soft interrupt disable bug")
hard disabled interrupts over the low level context switch, because
the SLB management can't cope with a PMU interrupt accesing the stack
in that window.

Radix based kernel mapping does not use the SLB so it does not require
interrupts hard disabled here.

This is worth 1-2% in context switch performance on POWER9.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S |  8 ++++++++
 arch/powerpc/kernel/process.c  | 14 ++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6f70ea821a07..91f9fdc2d027 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -607,6 +607,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	   top of the kernel stack. */
 	addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
 
+	/*
+	 * PMU interrupts in radix may come in here. They will use r1, not
+	 * PACAKSAVE, so this stack switch will not cause a problem. They
+	 * will store to the process stack, which may then be migrated to
+	 * another CPU. However the rq lock release on this CPU paired with
+	 * the rq lock acquire on the new CPU before the stack becomes
+	 * active on the new CPU, will order those stores.
+	 */
 	mr	r1,r8		/* start using new stack pointer */
 	std	r7,PACAKSAVE(r13)
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5cbb8b1faf7e..45faa9a32a01 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1199,12 +1199,14 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	__switch_to_tm(prev, new);
 
-	/*
-	 * We can't take a PMU exception inside _switch() since there is a
-	 * window where the kernel stack SLB and the kernel stack are out
-	 * of sync. Hard disable here.
-	 */
-	hard_irq_disable();
+	if (!radix_enabled()) {
+		/*
+		 * We can't take a PMU exception inside _switch() since there
+		 * is a window where the kernel stack SLB and the kernel stack
+		 * are out of sync. Hard disable here.
+		 */
+		hard_irq_disable();
+	}
 
 	/*
 	 * Call restore_sprs() before calling _switch(). If we move it after
-- 
2.11.0
