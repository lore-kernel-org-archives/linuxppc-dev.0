Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdQqs4t0QzDvP3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 03:57:45 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Remove FIX_SRR1
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20161213165738.9FCCD675BF@localhost.localdomain>
Date: Tue, 13 Dec 2016 17:57:38 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FIX_SRR1() is defined as blank. Last useful instance of FIX_SRR1()
was removed by commit 40ef8cbc6d360 ("powerpc: Get 64-bit configs to
compile with ARCH=powerpc") in 2005.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc_asm.h | 1 -
 arch/powerpc/kernel/entry_32.S     | 4 ----
 arch/powerpc/kernel/head_32.S      | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 025833b..359c443 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -505,7 +505,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define MTMSRD(r)	mtmsrd	r
 #define MTMSR_EERI(reg)	mtmsrd	reg,1
 #else
-#define FIX_SRR1(ra, rb)
 #ifndef CONFIG_40x
 #define	RFI		rfi
 #else
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 5742dbd..980626a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -292,7 +292,6 @@ stack_ovf:
 	lis	r9,StackOverflow@ha
 	addi	r9,r9,StackOverflow@l
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
-	FIX_SRR1(r10,r12)
 	mtspr	SPRN_SRR0,r9
 	mtspr	SPRN_SRR1,r10
 	SYNC
@@ -417,7 +416,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	mtlr	r4
 	mtcr	r5
 	lwz	r7,_NIP(r1)
-	FIX_SRR1(r8, r0)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
 	mtspr	SPRN_SRR0,r7
@@ -951,7 +949,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r12,_NIP(r1)
-	FIX_SRR1(r9,r10)
 	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r9
 	REST_4GPRS(9, r1)
@@ -1294,7 +1291,6 @@ _GLOBAL(enter_rtas)
 1:	tophys(r9,r1)
 	lwz	r8,INT_FRAME_SIZE+4(r9)	/* get return address */
 	lwz	r9,8(r9)	/* original msr value */
-	FIX_SRR1(r9,r0)
 	addi	r1,r1,INT_FRAME_SIZE
 	li	r0,0
 	mtspr	SPRN_SPRG_RTAS,r0
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9d96354..1607be7 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -869,7 +869,6 @@ __secondary_start:
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
-	FIX_SRR1(r4,r5)
 	lis	r3,start_secondary@h
 	ori	r3,r3,start_secondary@l
 	mtspr	SPRN_SRR0,r3
@@ -977,7 +976,6 @@ start_here:
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
 	li	r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
-	FIX_SRR1(r3,r5)
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
 	SYNC
@@ -1001,7 +999,6 @@ start_here:
 
 /* Now turn on the MMU for real! */
 	li	r4,MSR_KERNEL
-	FIX_SRR1(r4,r5)
 	lis	r3,start_kernel@h
 	ori	r3,r3,start_kernel@l
 	mtspr	SPRN_SRR0,r3
-- 
2.10.1
