Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6BR2mPNzDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:29:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Nick Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] powerpc/64: Do load of PACAKBASE in LOAD_HANDLER
Date: Tue, 26 Jul 2016 15:29:30 +1000
Message-Id: <1469510970-11599-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
References: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The LOAD_HANDLER macro requires that you have previously loaded "reg"
with PACAKBASE. Although that gives callers flexibility to get PACAKBASE
in some interesting way, none of the callers actually do that. So fold
the load of PACAKBASE into the macro, making it simpler for callers to
use correctly.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h |  3 +--
 arch/powerpc/kernel/exceptions-64s.S     | 10 ----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 4ff3e2f16b5d..887867ac4bfa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -52,7 +52,6 @@
 
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
-	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label);					\
 	mtctr	r12;							\
@@ -90,6 +89,7 @@
  * that kernelbase be 64K aligned.
  */
 #define LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
 	ori	reg,reg,(label)-_stext;	/* virt addr of handler ... */
 
 /* Exception register prefixes */
@@ -175,7 +175,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	__EXCEPTION_PROLOG_1(area, extra, vec)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
-	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label)						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8bcc1b457115..af30f26c35d8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -41,7 +41,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 
 #define SYSCALL_PSERIES_2_RFID 					\
 	mfspr	r12,SPRN_SRR1 ;					\
-	ld	r10,PACAKBASE(r13) ; 				\
 	LOAD_HANDLER(r10, system_call_entry) ; 			\
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
@@ -64,7 +63,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	 */
 #define SYSCALL_PSERIES_2_DIRECT				\
 	mflr	r10 ;						\
-	ld	r12,PACAKBASE(r13) ; 				\
 	LOAD_HANDLER(r12, system_call_entry) ;			\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
@@ -219,7 +217,6 @@ data_access_slb_pSeries:
 	 * the kernel ends up being put.
 	 */
 	mfctr	r11
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -240,7 +237,6 @@ instruction_access_slb_pSeries:
 	b	slb_miss_realmode
 #else
 	mfctr	r11
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -486,7 +482,6 @@ BEGIN_FTR_SECTION
 	mfmsr	r11			/* get MSR value */
 	ori	r11,r11,MSR_ME		/* turn on ME bit */
 	ori	r11,r11,MSR_RI		/* turn on RI bit */
-	ld	r12,PACAKBASE(r13)	/* get high part of &label */
 	LOAD_HANDLER(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
@@ -499,7 +494,6 @@ BEGIN_FTR_SECTION
 	 */
 	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
 	ld	r11,PACAKMSR(r13)
-	ld	r12,PACAKBASE(r13)
 	LOAD_HANDLER(r12, unrecover_mce)
 	li	r10,MSR_ME
 	andc	r11,r11,r10		/* Turn off MSR_ME */
@@ -802,7 +796,6 @@ data_access_slb_relon_pSeries:
 	 * the kernel ends up being put.
 	 */
 	mfctr	r11
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -822,7 +815,6 @@ instruction_access_slb_relon_pSeries:
 	b	slb_miss_realmode
 #else
 	mfctr	r11
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -1321,7 +1313,6 @@ machine_check_handle_early:
 	andi.	r11,r12,MSR_RI
 	bne	2f
 1:	mfspr	r11,SPRN_SRR0
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10,unrecover_mce)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
@@ -1422,7 +1413,6 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 	b	.	/* prevent speculative execution */
 
 2:	mfspr	r11,SPRN_SRR0
-	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10,unrecov_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
-- 
2.7.4
