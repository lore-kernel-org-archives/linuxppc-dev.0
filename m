Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45k1NMdzDqTF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:58 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so4890847pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:58 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 05/14] powerpc/pseries: 4GB exception handler offsets
Date: Thu, 21 Jul 2016 16:44:04 +1000
Message-Id: <1469083453-9279-6-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a LOAD_HANDLER_4GB variant which uses an extra instruction to extend
the range of handlers to 32-bit.

With 16-bit handlers, it is very difficult to move exception vector code
around or reserve any more space for new exceptions. So set all handlers
to use the new variant. After subsequent patches, the code will be in
better shape to move back to the _64K variant.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 24 +++++++++++++++---------
 arch/powerpc/kernel/exceptions-64s.S     | 27 +++++++++++++--------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index addc19b..cdb7dc7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -54,7 +54,7 @@
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label);					\
+	LOAD_HANDLER_4G(r12,label);					\
 	mtctr	r12;							\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	li	r10,MSR_RI;						\
@@ -83,14 +83,20 @@
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
 
 /*
- * We're short on space and time in the exception prolog, so we can't
- * use the normal SET_REG_IMMEDIATE macro. Normally we just need the
- * low halfword of the address, but for Kdump we need the whole low
- * word.
+ * We're short on space and time in the exception prolog, so we use short
+ * sequences to load nearby handlers.
+ *
+ * Normally we just need the low halfword of the address, but for Kdump we need
+ * the whole low word.
+ *
+ * reg must contain kbase, and kbase must be 64K aligned.
  */
-#define LOAD_HANDLER(reg, label)					\
-	/* Handlers must be within 64K of kbase, which must be 64k aligned */ \
-	ori	reg,reg,(label)-_stext;	/* virt addr of handler ... */
+#define LOAD_HANDLER_64K(reg, label)					\
+	ori	reg,reg,(label)-_stext ;
+
+#define LOAD_HANDLER_4G(reg, label)					\
+	ori	reg,reg,((label)-_stext)@l ;				\
+	addis	reg,reg,((label)-_stext)@h ;
 
 /* Exception register prefixes */
 #define EXC_HV	H
@@ -178,7 +184,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
+	LOAD_HANDLER_4G(r12,label)					\
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 79eb752..111e327 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -42,7 +42,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #define SYSCALL_PSERIES_2_RFID 					\
 	mfspr	r12,SPRN_SRR1 ;					\
 	ld	r10,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r10, system_call_entry) ; 			\
+	LOAD_HANDLER_4G(r10, system_call_common) ; 		\
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
@@ -65,7 +65,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #define SYSCALL_PSERIES_2_DIRECT				\
 	mflr	r10 ;						\
 	ld	r12,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r12, system_call_entry) ;			\
+	LOAD_HANDLER_4G(r12, system_call_common) ;		\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
 	/* Re-use of r13... No spare regs to do this */	\
@@ -220,7 +220,7 @@ data_access_slb_pSeries:
 	 */
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -241,7 +241,7 @@ instruction_access_slb_pSeries:
 #else
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -494,7 +494,7 @@ BEGIN_FTR_SECTION
 	ori	r11,r11,MSR_ME		/* turn on ME bit */
 	ori	r11,r11,MSR_RI		/* turn on RI bit */
 	ld	r12,PACAKBASE(r13)	/* get high part of &label */
-	LOAD_HANDLER(r12, machine_check_handle_early)
+	LOAD_HANDLER_4G(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
 	rfid
@@ -507,7 +507,7 @@ BEGIN_FTR_SECTION
 	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
 	ld	r11,PACAKMSR(r13)
 	ld	r12,PACAKBASE(r13)
-	LOAD_HANDLER(r12, unrecover_mce)
+	LOAD_HANDLER_4G(r12, unrecover_mce)
 	li	r10,MSR_ME
 	andc	r11,r11,r10		/* Turn off MSR_ME */
 	b	1b
@@ -739,7 +739,8 @@ kvmppc_skip_Hinterrupt:
  * Ensure that any handlers that get invoked from the exception prologs
  * above are below the first 64KB (0x10000) of the kernel image because
  * the prologs assemble the addresses of these handlers using the
- * LOAD_HANDLER macro, which uses an ori instruction.
+ * LOAD_HANDLER_4G macro, which uses an ori instruction. Care must also
+ * be taken because relative branches can only address 32K in each direction.
  */
 
 /*** Common interrupt handlers ***/
@@ -813,7 +814,7 @@ data_access_slb_relon_pSeries:
 	 */
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -833,7 +834,7 @@ instruction_access_slb_relon_pSeries:
 #else
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -925,8 +926,6 @@ hv_facility_unavailable_relon_trampoline:
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
 	.align	7
-system_call_entry:
-	b	system_call_common
 
 ppc64_runlatch_on_trampoline:
 	b	__ppc64_runlatch_on
@@ -1159,7 +1158,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	 * handlers, so that they are copied to real address 0x100 when running
 	 * a relocatable kernel. This ensures they can be reached from the short
 	 * trampoline handlers (like 0x4f00, 0x4f20, etc.) which branch
-	 * directly, without using LOAD_HANDLER().
+	 * directly, without using LOAD_HANDLER_4G().
 	 */
 	.align	7
 	.globl	__end_interrupts
@@ -1332,7 +1331,7 @@ machine_check_handle_early:
 	bne	2f
 1:	mfspr	r11,SPRN_SRR0
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10,unrecover_mce)
+	LOAD_HANDLER_4G(r10,unrecover_mce)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	/*
@@ -1432,7 +1431,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 
 2:	mfspr	r11,SPRN_SRR0
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10,unrecov_slb)
+	LOAD_HANDLER_4G(r10,unrecov_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
-- 
2.8.1
