Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404ZwV6v6yzF0wV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 23:23:20 +1100 (AEDT)
Message-Id: <8c39109dbf91dd464fee381da3d8ad3354273ed2.1521461897.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  1/2] powerpc/32be: use stmw/lmw for non volatile registers
 save/restore
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 19 Mar 2018 13:23:15 +0100 (CET)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc_asm.h |  5 +++++
 arch/powerpc/kernel/misc.S         | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ae94b3626b6c..3c39f7fa9540 100644
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
index 384357cb8bc0..739977a6be80 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -60,6 +60,10 @@ _GLOBAL(setjmp)
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
@@ -81,6 +85,7 @@ _GLOBAL(setjmp)
 	PPC_STL	r29,20*SZL(r3)
 	PPC_STL	r30,21*SZL(r3)
 	PPC_STL	r31,22*SZL(r3)
+#endif
 	li	r3,0
 	blr
 
@@ -88,6 +93,10 @@ _GLOBAL(longjmp)
 	PPC_LCMPI r4,0
 	bne	1f
 	li	r4,1
+#if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
+1:	lmw	r12, 3*SZL(r3)
+	mtcrf	0x38, r12
+#else
 1:	PPC_LL	r13,4*SZL(r3)
 	PPC_LL	r14,5*SZL(r3)
 	PPC_LL	r15,6*SZL(r3)
@@ -109,6 +118,7 @@ _GLOBAL(longjmp)
 	PPC_LL	r31,22*SZL(r3)
 	PPC_LL	r0,3*SZL(r3)
 	mtcrf	0x38,r0
+#endif
 	PPC_LL	r0,0(r3)
 	PPC_LL	r1,SZL(r3)
 	PPC_LL	r2,2*SZL(r3)
-- 
2.13.3
