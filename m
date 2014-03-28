Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Remove dead code in sycall entry
Date: Fri, 28 Mar 2014 16:40:39 +1100
Message-Id: <1395985239-27390-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In:
  commit 742415d6b66bf09e3e73280178ef7ec85c90b7ee
  Author: Michael Neuling <mikey@neuling.org>
  powerpc: Turn syscall handler into macros

We converted the syscall entry code onto macros, but in doing this we
introduced some cruft that's never run and should never have been added.

This removes that code.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c34c3c..46af63d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -54,14 +54,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	xori	r12,r12,MSR_LE ;				\
 	mtspr	SPRN_SRR1,r12 ;					\
 	rfid ;		/* return to userspace */		\
-	b	. ;						\
-2:	mfspr	r12,SPRN_SRR1 ;					\
-	andi.	r12,r12,MSR_PR ;				\
-	bne	0b ;						\
-	mtspr	SPRN_SRR0,r3 ;					\
-	mtspr	SPRN_SRR1,r4 ;					\
-	mtspr	SPRN_SDR1,r5 ;					\
-	rfid ;							\
 	b	. ;	/* prevent speculative execution */
 
 #if defined(CONFIG_RELOCATABLE)
-- 
1.8.3.2
