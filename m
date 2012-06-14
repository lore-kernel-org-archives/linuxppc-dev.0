Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:52 +1000
Subject: [PATCH 16/18] powerpc: enforce usage of R0-R31 where possible
In-Reply-To: <1339654536.159274.140684871779.qpush@ale>
Message-Id: <20120614061552.8AF08D42BEA@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enforce the use of R0-R31 in macros where possible now we have all the
fixes in.

R0-R31 macros are removed here so that can't be used anymore.  They
should not be defined anywhere.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    8 ++---
 arch/powerpc/include/asm/ppc_asm.h    |   50 ++++++----------------------------
 arch/powerpc/kernel/fpu.S             |   12 ++++----
 arch/powerpc/kvm/booke_interrupts.S   |    3 +-
 4 files changed, 23 insertions(+), 50 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -115,10 +115,10 @@
 #define ___PPC_RB(b)	(((b) & 0x1f) << 11)
 #define ___PPC_RS(s)	(((s) & 0x1f) << 21)
 #define ___PPC_RT(t)	___PPC_RS(t)
-#define __PPC_RA(a)	(((a) & 0x1f) << 16)
-#define __PPC_RB(b)	(((b) & 0x1f) << 11)
-#define __PPC_RS(s)	(((s) & 0x1f) << 21)
-#define __PPC_RT(s)	__PPC_RS(s)
+#define __PPC_RA(a)	___PPC_RA(__REG_##a)
+#define __PPC_RB(b)	___PPC_RB(__REG_##b)
+#define __PPC_RS(s)	___PPC_RS(__REG_##s)
+#define __PPC_RT(t)	___PPC_RT(__REG_##t)
 #define __PPC_XA(a)	((((a) & 0x1f) << 16) | (((a) & 0x20) >> 3))
 #define __PPC_XB(b)	((((b) & 0x1f) << 11) | (((b) & 0x20) >> 4))
 #define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
Index: powerpc-test/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc_asm.h
+++ powerpc-test/arch/powerpc/include/asm/ppc_asm.h
@@ -126,26 +126,26 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
 
 /* Save the lower 32 VSRs in the thread VSR region */
-#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,base,b)
+#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,R##base,R##b)
 #define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
 #define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,base)
 #define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,base)
 #define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b,base)
 #define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+16,b,base)
-#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,base,b)
+#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,R##base,R##b)
 #define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
 #define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,base)
 #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
 #define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,base)
 #define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16,b,base)
 /* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
-#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,base,b)
+#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,R##base,R##b)
 #define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,base)
 #define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,b,base)
 #define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,b,base)
 #define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,b,base)
 #define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+16,b,base)
-#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,base,b)
+#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,R##base,R##b)
 #define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,base)
 #define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,b,base)
 #define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,b,base)
@@ -183,15 +183,18 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 #else
 #define ULONG_SIZE	4
 #endif
-#define VCPU_GPR(n)	(VCPU_GPRS + (n * ULONG_SIZE))
+#define __VCPU_GPR(n)	(VCPU_GPRS + (n * ULONG_SIZE))
+#define VCPU_GPR(n)	__VCPU_GPR(__REG_##n)
 
 #ifdef __KERNEL__
 #ifdef CONFIG_PPC64
 
 #define STACKFRAMESIZE 256
-#define STK_REG(i)     (112 + ((i)-14)*8)
+#define __STK_REG(i)   (112 + ((i)-14)*8)
+#define STK_REG(i)     __STK_REG(__REG_##i)
 
-#define STK_PARAM(i)	(48 + ((i)-3)*8)
+#define __STK_PARAM(i)	(48 + ((i)-3)*8)
+#define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
@@ -543,39 +546,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define	r30	%r30
 #define	r31	%r31
 
-#define	R0	0
-#define	R1	1
-#define	R2	2
-#define	R3	3
-#define	R4	4
-#define	R5	5
-#define	R6	6
-#define	R7	7
-#define	R8	8
-#define	R9	9
-#define	R10	10
-#define	R11	11
-#define	R12	12
-#define	R13	13
-#define	R14	14
-#define	R15	15
-#define	R16	16
-#define	R17	17
-#define	R18	18
-#define	R19	19
-#define	R20	20
-#define	R21	21
-#define	R22	22
-#define	R23	23
-#define	R24	24
-#define	R25	25
-#define	R26	26
-#define	R27	27
-#define	R28	28
-#define	R29	29
-#define	R30	30
-#define	R31	31
-
 #define	__REG_R0	0
 #define	__REG_R1	1
 #define	__REG_R2	2
Index: powerpc-test/arch/powerpc/kernel/fpu.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kernel/fpu.S
+++ powerpc-test/arch/powerpc/kernel/fpu.S
@@ -26,7 +26,7 @@
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_VSX
-#define REST_32FPVSRS(n,c,base)						\
+#define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
 END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
@@ -35,7 +35,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);
 2:	REST_32VSRS(n,c,base);						\
 3:
 
-#define SAVE_32FPVSRS(n,c,base)						\
+#define __SAVE_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
 END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
@@ -44,9 +44,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
-#define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
-#define SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
+#define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
+#define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
+#define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
 /*
  * This task wants to use the FPU now.
@@ -79,7 +81,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	beq	1f
 	toreal(r4)
 	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
-	SAVE_32FPVSRS(0, r5, r4)
+	SAVE_32FPVSRS(0, R5, R4)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r4)
 	PPC_LL	r5,PT_REGS(r4)
Index: powerpc-test/arch/powerpc/kvm/booke_interrupts.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/booke_interrupts.S
+++ powerpc-test/arch/powerpc/kvm/booke_interrupts.S
@@ -34,7 +34,8 @@
 #define HOST_R2         12
 #define HOST_CR         16
 #define HOST_NV_GPRS    20
-#define HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * 4))
+#define __HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * 4))
+#define HOST_NV_GPR(n)  __HOST_NV_GPR(__REG_##n)
 #define HOST_MIN_STACK_SIZE (HOST_NV_GPR(R31) + 4)
 #define HOST_STACK_SIZE (((HOST_MIN_STACK_SIZE + 15) / 16) * 16) /* Align. */
 #define HOST_STACK_LR   (HOST_STACK_SIZE + 4) /* In caller stack frame. */
