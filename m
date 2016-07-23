Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxJlc55pbzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 17:18:36 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so8461839pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 00:18:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Optimise syscall entry for virtual, relocatable case
Date: Sat, 23 Jul 2016 17:18:12 +1000
Message-Id: <1469258292-746-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mflr r10 instruction was left over saving of lr when the code
used lr to branch to system_call_entry from the exception handler.
That was changed by 6a404806d to use the count register.

The value is never used now, so mflr can be removed, and r10 can be
used for storage rather than spilling to scratch register.

This brings getppid syscall cost from 406 to 376 cycles on a POWER8.
Non-relocatable case is 371 cycles.

Cc: Michael Neuling <mikey@neuling.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..eb0cac2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -63,15 +63,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	 * is volatile across system calls.
 	 */
 #define SYSCALL_PSERIES_2_DIRECT				\
-	mflr	r10 ;						\
 	ld	r12,PACAKBASE(r13) ; 				\
 	LOAD_HANDLER(r12, system_call_entry) ;			\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
-	/* Re-use of r13... No spare regs to do this */	\
-	li	r13,MSR_RI ;					\
-	mtmsrd 	r13,1 ;						\
-	GET_PACA(r13) ;	/* get r13 back */			\
+	li	r10,MSR_RI ;					\
+	mtmsrd 	r10,1 ;						\
 	bctr ;
 #else
 	/* We can branch directly */
-- 
2.8.1
