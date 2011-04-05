Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 157F6B6FC1
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3568ZPe004430
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:08:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKhA1061100
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKEI024399
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/15] powerpc: In HV mode, use HSPRG0 for PACA
Date: Tue,  5 Apr 2011 16:14:01 +1000
Message-Id: <1301984051-18413-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running in Hypervisor mode (arch 2.06 or later), we store the PACA
in HSPRG0 instead of SPRG1. The architecture specifies that SPRGs may be
lost during a "nap" power management operation (though they aren't
currently on POWER7) and this enables use of SPRG1 by KVM guests.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |    6 +++---
 arch/powerpc/include/asm/reg.h           |   27 ++++++++++++++++++++++++++-
 arch/powerpc/kernel/entry_64.S           |    4 ++--
 arch/powerpc/kernel/exceptions-64s.S     |    8 ++++----
 arch/powerpc/kernel/head_64.S            |    4 ++--
 arch/powerpc/kernel/paca.c               |   13 ++++++++++++-
 arch/powerpc/kvm/book3s_rmhandlers.S     |    4 +---
 7 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 7778d6f..337b6fa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -56,8 +56,8 @@
 #define LOAD_HANDLER(reg, label)					\
 	addi	reg,reg,(label)-_stext;	/* virt addr of handler ... */
 
-#define EXCEPTION_PROLOG_1(area)				\
-	mfspr	r13,SPRN_SPRG_PACA;	/* get paca address into r13 */	\
+#define EXCEPTION_PROLOG_1(area)					\
+	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
 	std	r10,area+EX_R10(r13);					\
 	std	r11,area+EX_R11(r13);					\
@@ -174,7 +174,7 @@ label##_pSeries:							\
 	HMT_MEDIUM;							\
 	DO_KVM	n;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	mfspr	r13,SPRN_SPRG_PACA;	/* get paca address into r13 */	\
+	GET_PACA(r13);							\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	lbz	r10,PACASOFTIRQEN(r13);					\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6eb1d77..13429a0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -715,12 +715,15 @@
  * SPRG usage:
  *
  * All 64-bit:
- *	- SPRG1 stores PACA pointer
+ *	- SPRG1 stores PACA pointer except 64-bit server in
+ *        HV mode in which case it is HSPRG0
  *
  * 64-bit server:
  *	- SPRG0 unused (reserved for HV on Power4)
  *	- SPRG2 scratch for exception vectors
  *	- SPRG3 unused (user visible)
+ *      - HSPRG0 stores PACA in HV mode
+ *      - HSPRG1 scratch for "HV" exceptions
  *
  * 64-bit embedded
  *	- SPRG0 generic exception scratch
@@ -783,6 +786,22 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG2
+#define SPRN_SPRG_HPACA		SPRN_HSPRG0
+#define SPRN_SPRG_HSCRATCH0	SPRN_HSPRG1
+
+#define GET_PACA(rX)					\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_PACA;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_HPACA;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+
+#define SET_PACA(rX)					\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mtspr	SPRN_SPRG_PACA,rX;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mtspr	SPRN_SPRG_HPACA,rX;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E_64
@@ -792,6 +811,10 @@
 #define SPRN_SPRG_TLB_EXFRAME	SPRN_SPRG2
 #define SPRN_SPRG_TLB_SCRATCH	SPRN_SPRG6
 #define SPRN_SPRG_GEN_SCRATCH	SPRN_SPRG0
+
+#define SET_PACA(rX)	mtspr	SPRN_SPRG_PACA,rX
+#define GET_PACA(rX)	mfspr	rX,SPRN_SPRG_PACA
+
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
@@ -842,6 +865,8 @@
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
 #endif
 
+
+
 /*
  * An mtfsf instruction with the L bit set. On CPUs that support this a
  * full 64bits of FPSCR is restored and on other CPUs the L bit is ignored.
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d82878c..dbf5bfa 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -838,7 +838,7 @@ _GLOBAL(enter_rtas)
 
 _STATIC(rtas_return_loc)
 	/* relocation is off at this point */
-	mfspr	r4,SPRN_SPRG_PACA	/* Get PACA */
+	GET_PACA(r4)
 	clrldi	r4,r4,2			/* convert to realmode address */
 
 	bcl	20,31,$+4
@@ -869,7 +869,7 @@ _STATIC(rtas_restore_regs)
 	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
 	REST_10GPRS(22, r1)		/* ditto */
 
-	mfspr	r13,SPRN_SPRG_PACA
+	GET_PACA(r13)
 
 	ld	r4,_CCR(r1)
 	mtcr	r4
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c532cb2..4ea3cc6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -53,7 +53,7 @@ data_access_pSeries:
 	DO_KVM	0x300
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
-	mfspr	r13,SPRN_SPRG_PACA
+	GET_PACA(r13)
 	std	r9,PACA_EXSLB+EX_R9(r13)
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	mfspr	r10,SPRN_DAR
@@ -82,7 +82,7 @@ data_access_slb_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x380
 	mtspr	SPRN_SPRG_SCRATCH0,r13
-	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
+	GET_PACA(r13)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -121,7 +121,7 @@ instruction_access_slb_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x480
 	mtspr	SPRN_SPRG_SCRATCH0,r13
-	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
+	GET_PACA(r13)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -165,7 +165,7 @@ BEGIN_FTR_SECTION
 	beq-	1f
 END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
-	mfspr	r13,SPRN_SPRG_PACA
+	GET_PACA(r13)
 	mfspr	r11,SPRN_SRR0
 	ld	r12,PACAKBASE(r13)
 	ld	r10,PACAKMSR(r13)
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 271140b..53d3bfd 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -228,7 +228,7 @@ generic_secondary_common_init:
 	mr	r3,r24			/* not found, copy phys to r3	 */
 	b	.kexec_wait		/* next kernel might do better	 */
 
-2:	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG */
+2:	SET_PACA(r13)
 #ifdef CONFIG_PPC_BOOK3E
 	addi	r12,r13,PACA_EXTLB	/* and TLB exc frame in another  */
 	mtspr	SPRN_SPRG_TLB_EXFRAME,r12
@@ -534,7 +534,7 @@ _GLOBAL(pmac_secondary_start)
 	ld	r4,0(r4)		/* Get base vaddr of paca array	*/
 	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
 	add	r13,r13,r4		/* for this processor.		*/
-	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG*/
+	SET_PACA(r13)			/* Save vaddr of paca in an SPRG*/
 
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 10f0aad..102244e 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -156,11 +156,22 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 /* Put the paca pointer into r13 and SPRG_PACA */
 void setup_paca(struct paca_struct *new_paca)
 {
+	/* Setup r13 */
 	local_paca = new_paca;
-	mtspr(SPRN_SPRG_PACA, local_paca);
+
 #ifdef CONFIG_PPC_BOOK3E
+	/* On Book3E, initialize the TLB miss exception frames */
 	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
+#else
+	/* In HV mode, we setup both HPACA and PACA to avoid problems
+	 * if we do a GET_PACA() before the feature fixups have been
+	 * applied
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE_206))
+		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
+	mtspr(SPRN_SPRG_PACA, local_paca);
+
 }
 
 static int __initdata paca_size;
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 2b9c908..b0ff5ff 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -35,9 +35,7 @@
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
-#define LOAD_SHADOW_VCPU(reg)				\
-	mfspr	reg, SPRN_SPRG_PACA
-
+#define LOAD_SHADOW_VCPU(reg)	GET_PACA(reg)					
 #define SHADOW_VCPU_OFF		PACA_KVM_SVCPU
 #define MSR_NOIRQ		MSR_KERNEL & ~(MSR_IR | MSR_DR)
 #define FUNC(name) 		GLUE(.,name)
-- 
1.7.1
