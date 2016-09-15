Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZXYR2yc4zDsYX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 19:04:59 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id vz6so1896755pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 02:04:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: exception optimise MSR handling
Date: Thu, 15 Sep 2016 19:04:46 +1000
Message-Id: <20160915090446.898-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mtmsrd with L=1 only affects MSR_EE and MSR_RI bits, and we always
know what state those bits are, so the kernel MSR does not need to be
loaded when modifying them.

mtmsrd is often in the critical execution path, so avoiding dependency
on even L1 load is noticable. On a POWER8 this saves about 3 cycles
from the syscall path, and possibly a few from other exception returns
(not measured).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6b8bc0d..585b9ca 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -139,7 +139,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	1
 #else
-	ld	r11,PACAKMSR(r13)
+	li	r11,MSR_RI
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
@@ -195,7 +195,6 @@ system_call:			/* label this so stack traces look sane */
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	ld	r10,PACAKMSR(r13)
 	/*
 	 * For performance reasons we clear RI the same time that we
 	 * clear EE. We only need to clear RI just before we restore r13
@@ -203,8 +202,7 @@ system_call:			/* label this so stack traces look sane */
 	 * We have to be careful to restore RI if we branch anywhere from
 	 * here (eg syscall_exit_work).
 	 */
-	li	r9,MSR_RI
-	andc	r11,r10,r9
+	li	r11,0
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
@@ -221,13 +219,12 @@ system_call:			/* label this so stack traces look sane */
 #endif
 2:	addi    r3,r1,STACK_FRAME_OVERHEAD
 #ifdef CONFIG_PPC_BOOK3S
+	li	r10,MSR_RI
 	mtmsrd	r10,1		/* Restore RI */
 #endif
 	bl	restore_math
 #ifdef CONFIG_PPC_BOOK3S
-	ld	r10,PACAKMSR(r13)
-	li	r9,MSR_RI
-	andc	r11,r10,r9 /* Re-clear RI */
+	li	r11,0
 	mtmsrd	r11,1
 #endif
 	ld	r8,_MSR(r1)
@@ -308,6 +305,7 @@ syscall_enosys:
 	
 syscall_exit_work:
 #ifdef CONFIG_PPC_BOOK3S
+	li	r10,MSR_RI
 	mtmsrd	r10,1		/* Restore RI */
 #endif
 	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
@@ -354,7 +352,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	1
 #else
-	ld	r10,PACAKMSR(r13)
+	li	r10,MSR_RI
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
@@ -619,7 +617,7 @@ _GLOBAL(ret_from_except_lite)
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
+	li	r10,MSR_RI
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
@@ -751,7 +749,7 @@ resume_kernel:
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
+	li	r10,MSR_RI
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 #endif /* CONFIG_PREEMPT */
@@ -841,8 +839,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 * userspace and we take an exception after restoring r13,
 	 * we end up corrupting the userspace r13 value.
 	 */
-	ld	r4,PACAKMSR(r13) /* Get kernel MSR without EE */
-	andc	r4,r4,r0	 /* r0 contains MSR_RI here */
+	li	r4,0
 	mtmsrd	r4,1
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-- 
2.9.3
