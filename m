Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVg3dPCzDsgt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:15 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id my20so1945328pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/41] powerpc/64s: consolidate System Call 0xc00 interrupt
Date: Wed, 21 Sep 2016 17:43:44 +1000
Message-Id: <20160921074407.4885-19-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 124 +++++++++++++++++------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e614a58..8a12701 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -77,61 +77,6 @@ OPEN_TEXT_SECTION(0x7000)
 
 USE_FIXED_SECTION(real_vectors)
 
-
-	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
-#define SYSCALL_PSERIES_1 					\
-BEGIN_FTR_SECTION						\
-	cmpdi	r0,0x1ebe ; 					\
-	beq-	1f ;						\
-END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
-	mr	r9,r13 ;					\
-	GET_PACA(r13) ;						\
-	mfspr	r11,SPRN_SRR0 ;					\
-0:
-
-#define SYSCALL_PSERIES_2_RFID 					\
-	mfspr	r12,SPRN_SRR1 ;					\
-	ld	r10,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r10, system_call_common) ; 		\
-	mtspr	SPRN_SRR0,r10 ; 				\
-	ld	r10,PACAKMSR(r13) ;				\
-	mtspr	SPRN_SRR1,r10 ; 				\
-	rfid ; 							\
-	b	. ;	/* prevent speculative execution */
-
-#define SYSCALL_PSERIES_3					\
-	/* Fast LE/BE switch system call */			\
-1:	mfspr	r12,SPRN_SRR1 ;					\
-	xori	r12,r12,MSR_LE ;				\
-	mtspr	SPRN_SRR1,r12 ;					\
-	rfid ;		/* return to userspace */		\
-	b	. ;	/* prevent speculative execution */
-
-#if defined(CONFIG_RELOCATABLE)
-	/*
-	 * We can't branch directly so we do it via the CTR which
-	 * is volatile across system calls.
-	 */
-#define SYSCALL_PSERIES_2_DIRECT				\
-	mflr	r10 ;						\
-	ld	r12,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r12, system_call_common) ;			\
-	mtctr	r12 ;						\
-	mfspr	r12,SPRN_SRR1 ;					\
-	/* Re-use of r13... No spare regs to do this */	\
-	li	r13,MSR_RI ;					\
-	mtmsrd 	r13,1 ;						\
-	GET_PACA(r13) ;	/* get r13 back */			\
-	bctr ;
-#else
-	/* We can branch directly */
-#define SYSCALL_PSERIES_2_DIRECT				\
-	mfspr	r12,SPRN_SRR1 ;					\
-	li	r10,MSR_RI ;					\
-	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
-	b	system_call_common ;
-#endif
-
 /*
  * This is the start of the interrupt handlers for pSeries
  * This code runs with relocation off.
@@ -861,6 +806,60 @@ TRAMP_KVM(PACA_EXGEN, 0xb00)
 COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
 
 
+/* Syscall routine is used twice, in reloc-off and reloc-on paths */
+#define SYSCALL_PSERIES_1 					\
+BEGIN_FTR_SECTION						\
+	cmpdi	r0,0x1ebe ; 					\
+	beq-	1f ;						\
+END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
+	mr	r9,r13 ;					\
+	GET_PACA(r13) ;						\
+	mfspr	r11,SPRN_SRR0 ;					\
+0:
+
+#define SYSCALL_PSERIES_2_RFID 					\
+	mfspr	r12,SPRN_SRR1 ;					\
+	ld	r10,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER(r10, system_call_common) ; 		\
+	mtspr	SPRN_SRR0,r10 ; 				\
+	ld	r10,PACAKMSR(r13) ;				\
+	mtspr	SPRN_SRR1,r10 ; 				\
+	rfid ; 							\
+	b	. ;	/* prevent speculative execution */
+
+#define SYSCALL_PSERIES_3					\
+	/* Fast LE/BE switch system call */			\
+1:	mfspr	r12,SPRN_SRR1 ;					\
+	xori	r12,r12,MSR_LE ;				\
+	mtspr	SPRN_SRR1,r12 ;					\
+	rfid ;		/* return to userspace */		\
+	b	. ;	/* prevent speculative execution */
+
+#if defined(CONFIG_RELOCATABLE)
+	/*
+	 * We can't branch directly so we do it via the CTR which
+	 * is volatile across system calls.
+	 */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mflr	r10 ;						\
+	ld	r12,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER(r12, system_call_common) ;			\
+	mtctr	r12 ;						\
+	mfspr	r12,SPRN_SRR1 ;					\
+	/* Re-use of r13... No spare regs to do this */	\
+	li	r13,MSR_RI ;					\
+	mtmsrd 	r13,1 ;						\
+	GET_PACA(r13) ;	/* get r13 back */			\
+	bctr ;
+#else
+	/* We can branch directly */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mfspr	r12,SPRN_SRR1 ;					\
+	li	r10,MSR_RI ;					\
+	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
+	b	system_call_common ;
+#endif
+
 VECTOR_HANDLER_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	 /*
 	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
@@ -888,8 +887,16 @@ VECTOR_HANDLER_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	SYSCALL_PSERIES_3
 VECTOR_HANDLER_REAL_END(system_call, 0xc00, 0xd00)
 
+VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
+	HMT_MEDIUM
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_DIRECT
+	SYSCALL_PSERIES_3
+VECTOR_HANDLER_VIRT_END(system_call, 0x4c00, 0x4d00)
+
 TRAMP_KVM(PACA_EXGEN, 0xc00)
 
+
 VECTOR_HANDLER_REAL(single_step, 0xd00, 0xe00)
 
 TRAMP_KVM(PACA_EXGEN, 0xd00)
@@ -1244,13 +1251,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-	HMT_MEDIUM
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_DIRECT
-	SYSCALL_PSERIES_3
-VECTOR_HANDLER_VIRT_END(system_call, 0x4c00, 0x4d00)
-
 VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-- 
2.9.3
