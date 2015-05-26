Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F359F1A0EB8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 15:46:57 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Relocatable system call no longer uses the LR
Date: Tue, 26 May 2015 15:46:54 +1000
Message-Id: <1432619215-13490-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We had some code to restore the LR in the relocatable system call path
back when we used the LR to do an indirect branch.

Commit 6a404806dfce ("powerpc: Avoid link stack corruption in MMU
on syscall entry path") changed this to use the CTR which is volatile
across system calls so does not need restoring.

Remove the stale comment and the restore of the LR.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9519e6b..cf8c1b5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -59,14 +59,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 
 #if defined(CONFIG_RELOCATABLE)
 	/*
-	 * We can't branch directly; in the direct case we use LR
-	 * and system_call_entry restores LR.  (We thus need to move
-	 * LR to r10 in the RFID case too.)
+	 * We can't branch directly so we do it via the CTR which
+	 * is volatile across system calls.
 	 */
 #define SYSCALL_PSERIES_2_DIRECT				\
 	mflr	r10 ;						\
 	ld	r12,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r12, system_call_entry_direct) ;		\
+	LOAD_HANDLER(r12, system_call_entry) ;			\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
 	/* Re-use of r13... No spare regs to do this */	\
@@ -80,7 +79,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
-	b	system_call_entry_direct ;
+	b	system_call_entry ;
 #endif
 
 /*
@@ -969,13 +968,6 @@ hv_facility_unavailable_relon_trampoline:
 __end_interrupts:
 
 	.align	7
-system_call_entry_direct:
-#if defined(CONFIG_RELOCATABLE)
-	/* The first level prologue may have used LR to get here, saving
-	 * orig in r10.  To save hacking/ifdeffing common code, restore here.
-	 */
-	mtlr	r10
-#endif
 system_call_entry:
 	b	system_call_common
 
-- 
2.1.4
