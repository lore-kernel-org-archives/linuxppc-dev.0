Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5PgY481TzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 21:28:09 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Remove CLR_TOP32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160805112801.075AE1A244A@localhost.localdomain>
Date: Fri,  5 Aug 2016 13:27:59 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CLR_TOP32() is defined as blank. Last useful instance of CLR_TOP32()
was removed by commit 40ef8cbc6d360 ("powerpc: Get 64-bit configs to
compile with ARCH=powerpc")

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc_asm.h | 1 -
 arch/powerpc/kernel/entry_32.S     | 1 -
 arch/powerpc/kernel/head_32.S      | 3 ---
 arch/powerpc/kernel/head_8xx.S     | 1 -
 4 files changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index d5d5b5e..bcd891f 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -527,7 +527,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #endif
 #define MTMSRD(r)	mtmsr	r
 #define MTMSR_EERI(reg)	mtmsr	reg
-#define CLR_TOP32(r)
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9899032..83428a2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -654,7 +654,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SMP */
 
 	tophys(r0,r4)
-	CLR_TOP32(r0)
 	mtspr	SPRN_SPRG_THREAD,r0	/* Update current THREAD phys addr */
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dc0488b..a3f821e 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -266,7 +266,6 @@ __secondary_hold_acknowledge:
 
 
 #define EXCEPTION_PROLOG_2	\
-	CLR_TOP32(r11);		\
 	stw	r10,_CCR(r11);		/* save registers */ \
 	stw	r12,GPR12(r11);	\
 	stw	r9,GPR9(r11);	\
@@ -862,7 +861,6 @@ __secondary_start:
 	/* ptr to phys current thread */
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
-	CLR_TOP32(r4)
 	mtspr	SPRN_SPRG_THREAD,r4
 	li	r3,0
 	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
@@ -949,7 +947,6 @@ start_here:
 	/* ptr to phys current thread */
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
-	CLR_TOP32(r4)
 	mtspr	SPRN_SPRG_THREAD,r4
 	li	r3,0
 	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 43ddaae..3a185c5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -151,7 +151,6 @@ turn_on_mmu:
 
 
 #define EXCEPTION_PROLOG_2	\
-	CLR_TOP32(r11);		\
 	stw	r10,_CCR(r11);		/* save registers */ \
 	stw	r12,GPR12(r11);	\
 	stw	r9,GPR9(r11);	\
-- 
2.1.0
