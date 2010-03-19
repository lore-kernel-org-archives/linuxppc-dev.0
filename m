Return-Path: <temerkhanov@cifronik.ru>
Received: from cifronik.21th.com (cifronik.21th.com [62.16.86.116])
	by ozlabs.org (Postfix) with ESMTP id 26F5AB7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 02:47:49 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cifronic.local (Postfix) with ESMTP id 8BA788952F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:47:47 +0300 (MSK)
Received: from mail.cifronic.local ([127.0.0.1])
	by localhost (server.cifronic.local [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id yu52xnIKK9bw for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:47:46 +0300 (MSK)
Received: from satanklaus.localnet (satanklaus.cifronic.local [192.168.0.99])
	by mail.cifronic.local (Postfix) with ESMTPSA id 3CDEC8952D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:47:46 +0300 (MSK)
From: Sergey Temerkhanov <temerkhanov@cifronik.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] Xilinx Virtex 4 FX Soft FPU support
Date: Fri, 19 Mar 2010 18:49:03 +0300
References: <201003191847.55823.temerkhanov@cifronik.ru>
In-Reply-To: <201003191847.55823.temerkhanov@cifronik.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vz5oL07ZDliu6hA"
Message-Id: <201003191849.03717.temerkhanov@cifronik.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Boundary-00=_vz5oL07ZDliu6hA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The patch.

Regards, Resgey Temerkhanov

--Boundary-00=_vz5oL07ZDliu6hA
Content-Type: text/x-patch;
  charset="UTF-8";
  name="fp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fp.patch"

diff -r 9d9ac97e095d .config
--- a/.config	Thu Feb 25 21:23:42 2010 +0300
+++ b/.config	Thu Feb 25 21:49:02 2010 +0300
@@ -14,10 +14,12 @@
 CONFIG_40x=y
 # CONFIG_44x is not set
 # CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
 CONFIG_4xx=y
 CONFIG_PPC_MMU_NOHASH=y
 # CONFIG_PPC_MM_SLICES is not set
 CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_XILINX_FPU=y
 CONFIG_PPC32=y
 CONFIG_WORD_SIZE=32
 # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
@@ -227,7 +229,7 @@
 CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 # CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
+# CONFIG_MATH_EMULATION is not set
 # CONFIG_IOMMU_HELPER is not set
 # CONFIG_SWIOTLB is not set
 CONFIG_PPC_NEED_DMA_SYNC_OPS=y
diff -r 9d9ac97e095d arch/powerpc/include/asm/ppc_asm.h
--- a/arch/powerpc/include/asm/ppc_asm.h	Thu Feb 25 21:23:42 2010 +0300
+++ b/arch/powerpc/include/asm/ppc_asm.h	Thu Feb 25 21:49:02 2010 +0300
@@ -85,13 +85,23 @@
 #define REST_8GPRS(n, base)	REST_4GPRS(n, base); REST_4GPRS(n+4, base)
 #define REST_10GPRS(n, base)	REST_8GPRS(n, base); REST_2GPRS(n+8, base)
 
-#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+
+#ifdef CONFIG_XILINX_FPU
+#define stfr stfs
+#define lfr lfs
+#else
+#define stfr stfd
+#define lfr lfd
+#endif
+
+
+#define SAVE_FPR(n, base)	stfr	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
 #define SAVE_2FPRS(n, base)	SAVE_FPR(n, base); SAVE_FPR(n+1, base)
 #define SAVE_4FPRS(n, base)	SAVE_2FPRS(n, base); SAVE_2FPRS(n+2, base)
 #define SAVE_8FPRS(n, base)	SAVE_4FPRS(n, base); SAVE_4FPRS(n+4, base)
 #define SAVE_16FPRS(n, base)	SAVE_8FPRS(n, base); SAVE_8FPRS(n+8, base)
 #define SAVE_32FPRS(n, base)	SAVE_16FPRS(n, base); SAVE_16FPRS(n+16, base)
-#define REST_FPR(n, base)	lfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
+#define REST_FPR(n, base)	lfr	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
 #define REST_2FPRS(n, base)	REST_FPR(n, base); REST_FPR(n+1, base)
 #define REST_4FPRS(n, base)	REST_2FPRS(n, base); REST_2FPRS(n+2, base)
 #define REST_8FPRS(n, base)	REST_4FPRS(n, base); REST_4FPRS(n+4, base)
diff -r 9d9ac97e095d arch/powerpc/kernel/fpu.S
--- a/arch/powerpc/kernel/fpu.S	Thu Feb 25 21:23:42 2010 +0300
+++ b/arch/powerpc/kernel/fpu.S	Thu Feb 25 21:49:02 2010 +0300
@@ -57,6 +57,9 @@
 _GLOBAL(load_up_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_XILINX_FPU
+	oris r5,r5,MSR_VEC@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r5,r5,MSR_VSX@h
@@ -85,6 +88,9 @@
 	toreal(r5)
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r10,MSR_FP|MSR_FE0|MSR_FE1
+#ifdef CONFIG_XILINX_FPU
+	oris	r10,r10,MSR_VEC@h
+#endif
 	andc	r4,r4,r10		/* disable FP for previous task */
 	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
@@ -94,6 +100,9 @@
 	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
 	lwz	r4,THREAD_FPEXC_MODE(r5)
 	ori	r9,r9,MSR_FP		/* enable FP for current */
+#ifdef CONFIG_XILINX_FPU
+	oris	r9,r9,MSR_VEC@h
+#endif
 	or	r9,r9,r4
 #else
 	ld	r4,PACACURRENT(r13)
@@ -124,6 +133,9 @@
 _GLOBAL(giveup_fpu)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
+#ifdef CONFIG_XILINX_FPU
+	oris	r5,r5,MSR_VEC@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r5,r5,MSR_VSX@h
@@ -145,6 +157,9 @@
 	beq	1f
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r3,MSR_FP|MSR_FE0|MSR_FE1
+#ifdef CONFIG_XILINX_FPU
+	oris	r3,r3,MSR_VEC@h
+#endif
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	oris	r3,r3,MSR_VSX@h
diff -r 9d9ac97e095d arch/powerpc/kernel/head_40x.S
--- a/arch/powerpc/kernel/head_40x.S	Thu Feb 25 21:23:42 2010 +0300
+++ b/arch/powerpc/kernel/head_40x.S	Thu Feb 25 21:49:02 2010 +0300
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
diff -r 9d9ac97e095d arch/powerpc/platforms/Kconfig.cputype
--- a/arch/powerpc/platforms/Kconfig.cputype	Thu Feb 25 21:23:42 2010 +0300
+++ b/arch/powerpc/platforms/Kconfig.cputype	Thu Feb 25 21:49:02 2010 +0300
@@ -290,4 +290,9 @@
 config CHECK_CACHE_COHERENCY
 	bool
 
+config XILINX_FPU
+	bool "Xilinx softFPU"
+	select PPC_FPU
+	depends on 40x
+
 endmenu

--Boundary-00=_vz5oL07ZDliu6hA--
