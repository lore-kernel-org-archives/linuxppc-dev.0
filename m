Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47E032C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 21:58:04 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc: split the math emulation into two parts
Date: Tue, 16 Jul 2013 19:57:15 +0800
Message-ID: <1373975836-11928-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
References: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some SoC (such as the FSL BookE) even though there does have
a hardware FPU, but not all floating point instructions are
implemented. Unfortunately some versions of gcc do use these
unimplemented instructions. Then we have to enable the math emulation
to workaround this issue. It seems a little redundant to have the
support to emulate all the floating point instructions in this case.
So split the math emulation into two parts. One is for the SoC which
doesn't have FPU at all and the other for the SoC which does have the
hardware FPU and only need some special floating point instructions to
be emulated.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig           | 20 ++++++++++++++++++++
 arch/powerpc/math-emu/Makefile | 24 ++++++++++++------------
 arch/powerpc/math-emu/math.c   | 20 ++++++++++++++------
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3bf72cd..7205989 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -312,6 +312,26 @@ config MATH_EMULATION
 	  such as fsqrt on cores that do have an FPU but do not implement
 	  them (such as Freescale BookE).
 
+choice
+	prompt "Math emulation options"
+	default MATH_EMULATION_FULL
+	depends on MATH_EMULATION
+
+config	MATH_EMULATION_FULL
+	bool "Emulate all the floating point instructions"
+	---help---
+	  Select this option will enable the kernel to support to emulate
+	  all the floating point instructions. If your SoC doesn't have
+	  a FPU, you should select this.
+
+config MATH_EMULATION_HW_UNIMPLEMENTED
+	bool "Just emulate the FPU unimplemented instructions"
+	---help---
+	  Select this if you know there does have a hardware FPU on your
+	  SoC, but some floating point instructions are not implemented by that.
+
+endchoice
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 8d035d2..1b46ab4 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -1,15 +1,15 @@
-
-obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
-					fctiw.o fctiwz.o fdiv.o fdivs.o \
-					fmadd.o fmadds.o fmsub.o fmsubs.o \
-					fmul.o fmuls.o fnabs.o fneg.o \
-					fnmadd.o fnmadds.o fnmsub.o fnmsubs.o \
-					fres.o fre.o frsp.o fsel.o lfs.o \
-					frsqrte.o frsqrtes.o \
-					fsqrt.o	fsqrts.o fsub.o fsubs.o \
-					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
-					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
-					math.o fmr.o lfd.o stfd.o
+math-emu-common-objs = math.o fre.o fsqrt.o fsqrts.o frsqrtes.o mtfsf.o mtfsfi.o
+obj-$(CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED) += $(math-emu-common-objs)
+obj-$(CONFIG_MATH_EMULATION_FULL) += $(math-emu-common-objs) fabs.o fadd.o \
+					fadds.o fcmpo.o fcmpu.o fctiw.o \
+					fctiwz.o fdiv.o fdivs.o  fmadd.o \
+					fmadds.o fmsub.o fmsubs.o fmul.o \
+					fmuls.o fnabs.o fneg.o fnmadd.o \
+					fnmadds.o fnmsub.o fnmsubs.o fres.o \
+					frsp.o fsel.o lfs.o frsqrte.o fsub.o \
+					fsubs.o  mcrfs.o mffs.o mtfsb0.o \
+					mtfsb1.o stfiwx.o stfs.o math.o \
+					fmr.o lfd.o stfd.o
 
 obj-$(CONFIG_SPE)		+= math_efp.o
 
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index d1ebac7..bc90162 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -14,6 +14,20 @@
 
 #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
 
+/* The instructions list which may be not implemented by a hardware FPU */
+FLOATFUNC(fre);
+FLOATFUNC(frsqrtes);
+FLOATFUNC(fsqrt);
+FLOATFUNC(fsqrts);
+FLOATFUNC(mtfsf);
+FLOATFUNC(mtfsfi);
+
+#ifdef CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED
+#undef FLOATFUNC(x)
+#define FLOATFUNC(x)	static inline int x(void *op1, void *op2, void *op3, \
+						 void *op4) { }
+#endif
+
 FLOATFUNC(fadd);
 FLOATFUNC(fadds);
 FLOATFUNC(fdiv);
@@ -43,8 +57,6 @@ FLOATFUNC(mcrfs);
 FLOATFUNC(mffs);
 FLOATFUNC(mtfsb0);
 FLOATFUNC(mtfsb1);
-FLOATFUNC(mtfsf);
-FLOATFUNC(mtfsfi);
 
 FLOATFUNC(lfd);
 FLOATFUNC(lfs);
@@ -59,13 +71,9 @@ FLOATFUNC(fnabs);
 FLOATFUNC(fneg);
 
 /* Optional */
-FLOATFUNC(fre);
 FLOATFUNC(fres);
 FLOATFUNC(frsqrte);
-FLOATFUNC(frsqrtes);
 FLOATFUNC(fsel);
-FLOATFUNC(fsqrt);
-FLOATFUNC(fsqrts);
 
 
 #define OP31		0x1f		/*   31 */
-- 
1.8.1.4
