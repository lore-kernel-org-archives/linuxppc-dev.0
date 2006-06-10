Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:18:39 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: 64bit FPSCR support
Message-ID: <20060610101839.GI23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add 64bit FPSCR support. This requires a new form of mtfsf instruction.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/fpu.S
===================================================================
--- build.orig/arch/powerpc/kernel/fpu.S	2006-06-08 10:57:36.000000000 +1000
+++ build/arch/powerpc/kernel/fpu.S	2006-06-10 11:38:37.000000000 +1000
@@ -72,7 +72,7 @@ _GLOBAL(load_up_fpu)
 	std	r12,_MSR(r1)
 #endif
 	lfd	fr0,THREAD_FPSCR(r5)
-	mtfsf	0xff,fr0
+	MTFSF_L(fr0)
 	REST_32FPRS(0, r5)
 #ifndef CONFIG_SMP
 	subi	r4,r5,THREAD
@@ -127,7 +127,7 @@ _GLOBAL(giveup_fpu)
 
 _GLOBAL(cvt_fd)
 	lfd	0,THREAD_FPSCR(r5)	/* load up fpscr value */
-	mtfsf	0xff,0
+	MTFSF_L(0)
 	lfs	0,0(r3)
 	stfd	0,0(r4)
 	mffs	0
@@ -136,7 +136,7 @@ _GLOBAL(cvt_fd)
 
 _GLOBAL(cvt_df)
 	lfd	0,THREAD_FPSCR(r5)	/* load up fpscr value */
-	mtfsf	0xff,0
+	MTFSF_L(0)
 	lfd	0,0(r3)
 	stfs	0,0(r4)
 	mffs	0
Index: build/arch/powerpc/kernel/vector.S
===================================================================
--- build.orig/arch/powerpc/kernel/vector.S	2006-06-08 10:57:36.000000000 +1000
+++ build/arch/powerpc/kernel/vector.S	2006-06-10 11:38:37.000000000 +1000
@@ -53,12 +53,12 @@ fpenable:
 	stfd	fr31,8(r1)
 	LDCONST(fr1, fpzero)
 	mffs	fr31
-	mtfsf	0xff,fr1
+	MTFSF_L(fr1)
 	blr
 
 fpdisable:
 	mtlr	r12
-	mtfsf	0xff,fr31
+	MTFSF_L(fr31)
 	lfd	fr31,8(r1)
 	lfd	fr1,16(r1)
 	lfd	fr0,24(r1)
Index: build/include/asm-powerpc/reg.h
===================================================================
--- build.orig/include/asm-powerpc/reg.h	2006-06-10 11:37:33.000000000 +1000
+++ build/include/asm-powerpc/reg.h	2006-06-10 11:38:37.000000000 +1000
@@ -499,6 +499,19 @@
 #define MMCR0_PMC2_LOADMISSTIME	0x5
 #endif
 
+/*
+ * An mtfsf instruction with the L bit set. On CPUs that support this a
+ * full 64bits of FPSCR is restored and on other CPUs it is ignored.
+ *
+ * Until binutils gets the new form of mtfsf, hardwire the instruction.
+ */
+#ifdef CONFIG_PPC64
+#define MTFSF_L(REG) \
+	.long (0xfc00058e | ((0xff) << 17) | ((REG) << 11) | (1 << 25))
+#else
+#define MTFSF_L(REG)	mtfsf	0xff, (REG)
+#endif
+
 /* Processor Version Register (PVR) field extraction */
 
 #define PVR_VER(pvr)	(((pvr) >>  16) & 0xFFFF)	/* Version field */
