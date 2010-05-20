Return-Path: <temerkhanov@cifronik.ru>
Received: from cifronik.21th.com (cifronik.21th.com [62.16.86.116])
	by ozlabs.org (Postfix) with ESMTP id 76AAFB7D2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 20:00:46 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org,
 Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCHv2] [RFC] Xilinx Virtex 4 FX Soft FPU support
From: Sergey Temerkhanov <temerkhanov@cifronik.ru>
Date: Thu, 20 May 2010 14:01:09 +0400
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lhQ9LuXcVfYiNEU"
Message-Id: <201005201401.09912.temerkhanov@cifronik.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Boundary-00=_lhQ9LuXcVfYiNEU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This patch enables support for Xilinx Virtex 4 FX singe-float FPU.

Changelog v1->v2:
	-Added MSR_AP bit definition
	-Renamed CONFIG_XILINX_FPU to CONFIG_XILINX_SOFTFPU, moved it to 			
	'Platform support' and made it Virtex4-FX-only.
	-Changed SAVE_FPR/REST_FPR definition style.

Caveats: 
	- Hard-float binaries which rely on in-kernel math emulation will give 
wrong results since they expect 64-bit double-precision instead of 32-bit 
single-precision numbers which Xilinx V4-FX Soft FPU produces.

Regards, Sergey Temerkhanov

--Boundary-00=_lhQ9LuXcVfYiNEU
Content-Type: text/x-patch;
  charset="UTF-8";
  name="fp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fp.patch"

Signed-off-by: Sergey Temerkhanov<temerkhanov@cifronik.ru>

diff -r b59861a64e13 arch/powerpc/include/asm/ppc_asm.h
--- a/arch/powerpc/include/asm/ppc_asm.h	Thu May 20 13:24:53 2010 +0400
+++ b/arch/powerpc/include/asm/ppc_asm.h	Thu May 20 13:55:10 2010 +0400
@@ -85,13 +85,21 @@
 #define REST_8GPRS(n, base)	REST_4GPRS(n, base); REST_4GPRS(n+4, base)
 #define REST_10GPRS(n, base)	REST_8GPRS(n, base); REST_2GPRS(n+8, base)
 
-#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+
+#ifdef CONFIG_XILINX_SOFTFPU
+#define SAVE_FPR(n, base)	stfs n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+#define REST_FPR(n, base)	lfs n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+#else
+#define SAVE_FPR(n, base)	stfd n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+#define REST_FPR(n, base)	lfd n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+#endif
+
 #define SAVE_2FPRS(n, base)	SAVE_FPR(n, base); SAVE_FPR(n+1, base)
 #define SAVE_4FPRS(n, base)	SAVE_2FPRS(n, base); SAVE_2FPRS(n+2, base)
 #define SAVE_8FPRS(n, base)	SAVE_4FPRS(n, base); SAVE_4FPRS(n+4, base)
 #define SAVE_16FPRS(n, base)	SAVE_8FPRS(n, base); SAVE_8FPRS(n+8, base)
 #define SAVE_32FPRS(n, base)	SAVE_16FPRS(n, base); SAVE_16FPRS(n+16, base)
-#define REST_FPR(n, base)	lfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+
 #define REST_2FPRS(n, base)	REST_FPR(n, base); REST_FPR(n+1, base)
 #define REST_4FPRS(n, base)	REST_2FPRS(n, base); REST_2FPRS(n+2, base)
 #define REST_8FPRS(n, base)	REST_4FPRS(n, base); REST_4FPRS(n+4, base)
diff -r b59861a64e13 arch/powerpc/include/asm/reg.h
--- a/arch/powerpc/include/asm/reg.h	Thu May 20 13:24:53 2010 +0400
+++ b/arch/powerpc/include/asm/reg.h	Thu May 20 13:55:10 2010 +0400
@@ -30,6 +30,7 @@
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
+#define MSR_AP_LG	25	        /* Enable APU */
 #define MSR_VSX_LG	23		/* Enable VSX */
 #define MSR_POW_LG	18		/* Enable Power Management */
 #define MSR_WE_LG	18		/* Wait State Enable */
@@ -71,6 +72,7 @@
 #define MSR_HV		0
 #endif
 
+#define MSR_AP		__MASK(MSR_AP_LG)	/* Enable APU */
 #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */
 #define MSR_VSX		__MASK(MSR_VSX_LG)	/* Enable VSX */
 #define MSR_POW		__MASK(MSR_POW_LG)	/* Enable Power Management */
diff -r b59861a64e13 arch/powerpc/kernel/fpu.S
--- a/arch/powerpc/kernel/fpu.S	Thu May 20 13:24:53 2010 +0400
+++ b/arch/powerpc/kernel/fpu.S	Thu May 20 13:55:10 2010 +0400
@@ -57,6 +57,9 @@
 _GLOBAL(load_up_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_XILINX_SOFTFPU
+	oris	r5,r5,MSR_AP@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r5,r5,MSR_VSX@h
@@ -85,6 +88,9 @@
 	toreal(r5)
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r10,MSR_FP|MSR_FE0|MSR_FE1
+#ifdef CONFIG_XILINX_SOFTFPU
+	oris	r10,r10,MSR_AP@h
+#endif
 	andc	r4,r4,r10		/* disable FP for previous task */
 	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
@@ -94,6 +100,9 @@
 	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
 	lwz	r4,THREAD_FPEXC_MODE(r5)
 	ori	r9,r9,MSR_FP		/* enable FP for current */
+#ifdef CONFIG_XILINX_SOFTFPU
+	oris	r9,r9,MSR_AP@h
+#endif
 	or	r9,r9,r4
 #else
 	ld	r4,PACACURRENT(r13)
@@ -124,6 +133,9 @@
 _GLOBAL(giveup_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_XILINX_SOFTFPU
+	oris	r5,r5,MSR_AP@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r5,r5,MSR_VSX@h
@@ -145,6 +157,9 @@
 	beq	1f
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r3,MSR_FP|MSR_FE0|MSR_FE1
+#ifdef CONFIG_XILINX_SOFTFPU
+	oris	r3,r3,MSR_AP@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r3,r3,MSR_VSX@h
diff -r b59861a64e13 arch/powerpc/kernel/head_40x.S
--- a/arch/powerpc/kernel/head_40x.S	Thu May 20 13:24:53 2010 +0400
+++ b/arch/powerpc/kernel/head_40x.S	Thu May 20 13:55:10 2010 +0400
@@ -420,7 +420,19 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x700, program_check_exception)
 
+/* 0x0800 - FPU unavailable Exception */
+#ifdef CONFIG_PPC_FPU
+	START_EXCEPTION(0x0800, FloatingPointUnavailable)
+	NORMAL_EXCEPTION_PROLOG
+	beq	1f;							      \
+	bl	load_up_fpu;		/* if from user, just load it up */   \
+	b	fast_exception_return;					      \
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
+#else
 	EXCEPTION(0x0800, Trap_08, unknown_exception, EXC_XFER_EE)
+#endif
+
 	EXCEPTION(0x0900, Trap_09, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x0A00, Trap_0A, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x0B00, Trap_0B, unknown_exception, EXC_XFER_EE)
@@ -432,7 +444,7 @@
 
 	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
-	EXCEPTION(0x0F00, Trap_0F, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0F20, Trap_0F, unknown_exception, EXC_XFER_EE)
 
 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
 	START_EXCEPTION(0x1000, Decrementer)
@@ -821,8 +833,10 @@
  * The PowerPC 4xx family of processors do not have an FPU, so this just
  * returns.
  */
+#ifndef CONFIG_PPC_FPU
 _ENTRY(giveup_fpu)
 	blr
+#endif
 
 /* This is where the main kernel code starts.
  */
diff -r b59861a64e13 arch/powerpc/platforms/Kconfig
--- a/arch/powerpc/platforms/Kconfig	Thu May 20 13:24:53 2010 +0400
+++ b/arch/powerpc/platforms/Kconfig	Thu May 20 13:55:10 2010 +0400
@@ -333,4 +333,9 @@
 	bool "Xilinx PCI host bridge support"
 	depends on PCI && XILINX_VIRTEX
 
+config XILINX_SOFTFPU
+	bool "Xilinx Soft FPU"
+	select PPC_FPU
+	depends on XILINX_VIRTEX_4_FX && !PPC40x_SIMPLE && !405GP && !405GPR
+
 endmenu

--Boundary-00=_lhQ9LuXcVfYiNEU--
