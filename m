Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QWsx4vMYzF1Rs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 03:08:21 +1000 (AEST)
Message-Id: <a94e38e1dbe0c38ce5b363fac29ab6e65fd9985a.1523984745.git.christophe.leroy@c-s.fr>
In-Reply-To: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
References: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc/32be: use stmw/lmw for registers save/restore
 in asm
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 19:08:18 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/Makefile activates -mmultiple on BE PPC32 configs
in order to use multiple word instructions in functions entry/exit

The patch does the same for the asm parts, for consistency

On processors like the 8xx on which insn fetching is pretty slow,
this speeds up registers save/restore

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Swapped both patches in the serie to reduce number of impacted
     lines and added the same modification in ppc_save_regs()

 arch/powerpc/include/asm/ppc_asm.h  |  5 +++++
 arch/powerpc/kernel/misc.S          | 10 ++++++++++
 arch/powerpc/kernel/ppc_save_regs.S |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 13f7f4c0e1ea..4bb765d0b758 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -80,11 +80,16 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #else
 #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
 #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define SAVE_NVGPRS(base)	stmw	13, GPR0+4*13(base)
+#define REST_NVGPRS(base)	lmw	13, GPR0+4*13(base)
+#else
 #define SAVE_NVGPRS(base)	SAVE_GPR(13, base); SAVE_8GPRS(14, base); \
 				SAVE_10GPRS(22, base)
 #define REST_NVGPRS(base)	REST_GPR(13, base); REST_8GPRS(14, base); \
 				REST_10GPRS(22, base)
 #endif
+#endif
 
 #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
 #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 746ee0320ad4..a316d90a5c26 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -49,6 +49,10 @@ _GLOBAL(setjmp)
 	PPC_STL	r0,0(r3)
 	PPC_STL	r1,SZL(r3)
 	PPC_STL	r2,2*SZL(r3)
+#if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
+	mfcr	r12
+	stmw	r12, 3*SZL(r3)
+#else
 	mfcr	r0
 	PPC_STL	r0,3*SZL(r3)
 	PPC_STL	r13,4*SZL(r3)
@@ -70,10 +74,15 @@ _GLOBAL(setjmp)
 	PPC_STL	r29,20*SZL(r3)
 	PPC_STL	r30,21*SZL(r3)
 	PPC_STL	r31,22*SZL(r3)
+#endif
 	li	r3,0
 	blr
 
 _GLOBAL(longjmp)
+#if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
+	lmw	r12, 3*SZL(r3)
+	mtcrf	0x38, r12
+#else
 	PPC_LL	r13,4*SZL(r3)
 	PPC_LL	r14,5*SZL(r3)
 	PPC_LL	r15,6*SZL(r3)
@@ -95,6 +104,7 @@ _GLOBAL(longjmp)
 	PPC_LL	r31,22*SZL(r3)
 	PPC_LL	r0,3*SZL(r3)
 	mtcrf	0x38,r0
+#endif
 	PPC_LL	r0,0(r3)
 	PPC_LL	r1,SZL(r3)
 	PPC_LL	r2,2*SZL(r3)
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 1b1787d52896..d60316e70514 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -25,6 +25,9 @@
  */
 _GLOBAL(ppc_save_regs)
 	PPC_STL	r0,0*SZL(r3)
+#if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
+	stmw	r2, 2*SZL(r3)
+#else
 	PPC_STL	r2,2*SZL(r3)
 	PPC_STL	r3,3*SZL(r3)
 	PPC_STL	r4,4*SZL(r3)
@@ -55,6 +58,7 @@ _GLOBAL(ppc_save_regs)
 	PPC_STL	r29,29*SZL(r3)
 	PPC_STL	r30,30*SZL(r3)
 	PPC_STL	r31,31*SZL(r3)
+#endif
 	/* go up one stack frame for SP */
 	PPC_LL	r4,0(r1)
 	PPC_STL	r4,1*SZL(r3)
-- 
2.13.3
