Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2H2pqXzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 19/42] powerpc/64s: Consolidate System Call 0xc00 interrupt
Date: Wed,  5 Oct 2016 11:22:41 +1100
Message-Id: <1475626984-18770-20-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 121 ++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 54dd9b8aba9a..6d4d7800895a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -77,59 +77,6 @@ OPEN_TEXT_SECTION(0x7000)
 
 USE_FIXED_SECTION(real_vectors)
 
-#define LOAD_SYSCALL_HANDLER(reg)				\
-	ld	reg,PACAKBASE(r13);				\
-	ori	reg,reg,(ABS_ADDR(system_call_common))@l;
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
-	LOAD_SYSCALL_HANDLER(r10) ; 				\
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
-	LOAD_SYSCALL_HANDLER(r12) ;				\
-	mtctr	r12 ;						\
-	mfspr	r12,SPRN_SRR1 ;					\
-	li	r10,MSR_RI ;					\
-	mtmsrd 	r10,1 ;						\
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
@@ -864,6 +811,59 @@ TRAMP_KVM(PACA_EXGEN, 0xb00)
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 
 
+#define LOAD_SYSCALL_HANDLER(reg)				\
+	ld	reg,PACAKBASE(r13);				\
+	ori	reg,reg,(ABS_ADDR(system_call_common))@l;
+
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
+	LOAD_SYSCALL_HANDLER(r10) ; 				\
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
+	LOAD_SYSCALL_HANDLER(r12) ;				\
+	mtctr	r12 ;						\
+	mfspr	r12,SPRN_SRR1 ;					\
+	li	r10,MSR_RI ;					\
+	mtmsrd 	r10,1 ;						\
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
 EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	 /*
 	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
@@ -891,8 +891,16 @@ EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	SYSCALL_PSERIES_3
 EXC_REAL_END(system_call, 0xc00, 0xd00)
 
+EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
+	HMT_MEDIUM
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_DIRECT
+	SYSCALL_PSERIES_3
+EXC_VIRT_END(system_call, 0x4c00, 0x4d00)
+
 TRAMP_KVM(PACA_EXGEN, 0xc00)
 
+
 EXC_REAL(single_step, 0xd00, 0xe00)
 
 TRAMP_KVM(PACA_EXGEN, 0xd00)
@@ -1240,13 +1248,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-	HMT_MEDIUM
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_DIRECT
-	SYSCALL_PSERIES_3
-EXC_VIRT_END(system_call, 0x4c00, 0x4d00)
-
 EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 
 EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-- 
2.7.4
