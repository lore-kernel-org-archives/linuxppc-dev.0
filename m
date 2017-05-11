Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNxWR6jZmzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:15:47 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u187so3918774pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:15:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Scott Wood <oss@buserror.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc/32: tlbie provide L operand explicitly
Date: Fri, 12 May 2017 01:15:21 +1000
Message-Id: <20170511151522.4772-2-npiggin@gmail.com>
In-Reply-To: <20170511151522.4772-1-npiggin@gmail.com>
References: <20170511151522.4772-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The single-operand form of tlbie used to be accepted as the second
operand (L) being implicitly 0. Newer binutils reject this.

Change remaining single-op tlbie instructions to have explicit 0
second argument.

Cc: Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ppc_asm.h      | 2 +-
 arch/powerpc/kernel/head_32.S           | 2 +-
 arch/powerpc/kernel/head_8xx.S          | 8 ++++----
 arch/powerpc/kernel/swsusp_32.S         | 2 +-
 arch/powerpc/mm/hash_low_32.S           | 8 ++++----
 arch/powerpc/mm/mmu_decl.h              | 2 +-
 arch/powerpc/platforms/powermac/sleep.S | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c44341761..6e250733912a 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -418,7 +418,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	lis	r4,KERNELBASE@h;		\
 	.machine push;				\
 	.machine "power4";			\
-0:	tlbie	r4;				\
+0:	tlbie	r4,0;				\
 	.machine pop;				\
 	addi	r4,r4,0x1000;			\
 	bdnz	0b
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index e22734278458..c0be7f9654ac 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1103,7 +1103,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 flush_tlbs:
 	lis	r10, 0x40
 1:	addic.	r10, r10, -0x1000
-	tlbie	r10
+	tlbie	r10,0
 	bgt	1b
 	sync
 	blr
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c032fe8c2d26..dda28cad8024 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -317,9 +317,9 @@ SystemCall:
 #ifdef CONFIG_8xx_CPU15
 #define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)	\
 	addi	tmp, addr, PAGE_SIZE;	\
-	tlbie	tmp;			\
+	tlbie	tmp,0;			\
 	addi	tmp, addr, -PAGE_SIZE;	\
-	tlbie	tmp
+	tlbie	tmp,0
 #else
 #define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)
 #endif
@@ -572,7 +572,7 @@ InstructionTLBError:
 	mr	r5,r9
 	andis.	r10,r5,0x4000
 	beq+	1f
-	tlbie	r4
+	tlbie	r4,0
 itlbie:
 	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
 1:	EXC_XFER_LITE(0x400, handle_page_fault)
@@ -597,7 +597,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	mfspr	r4,SPRN_DAR
 	andis.	r10,r5,0x4000
 	beq+	1f
-	tlbie	r4
+	tlbie	r4,0
 dtlbie:
 1:	li	r10,RPN_PATTERN
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
diff --git a/arch/powerpc/kernel/swsusp_32.S b/arch/powerpc/kernel/swsusp_32.S
index ba4dee3d233f..cb26ab39a8d5 100644
--- a/arch/powerpc/kernel/swsusp_32.S
+++ b/arch/powerpc/kernel/swsusp_32.S
@@ -302,7 +302,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	/* Flush all TLBs */
 	lis	r4,0x1000
 1:	addic.	r4,r4,-0x1000
-	tlbie	r4
+	tlbie	r4,0
 	bgt	1b
 	sync
 
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 6f962e5cb5e1..31dfbc51a3f1 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -350,7 +350,7 @@ _GLOBAL(hash_page_patch_A)
 	 */
 	andi.	r6,r6,_PAGE_HASHPTE
 	beq+	10f			/* no PTE: go look for an empty slot */
-	tlbie	r4
+	tlbie	r4,0
 
 	addis	r4,r7,htab_hash_searches@ha
 	lwz	r6,htab_hash_searches@l(r4)
@@ -610,7 +610,7 @@ _GLOBAL(flush_hash_patch_B)
 3:	li	r0,0
 	STPTE	r0,0(r12)		/* invalidate entry */
 4:	sync
-	tlbie	r4			/* in hw tlb too */
+	tlbie	r4,0			/* in hw tlb too */
 	sync
 
 8:	ble	cr1,9f			/* if all ptes checked */
@@ -659,7 +659,7 @@ _GLOBAL(_tlbie)
 	stwcx.	r8,0,r9
 	bne-	10b
 	eieio
-	tlbie	r3
+	tlbie	r3,0
 	sync
 	TLBSYNC
 	li	r0,0
@@ -668,7 +668,7 @@ _GLOBAL(_tlbie)
 	SYNC_601
 	isync
 #else /* CONFIG_SMP */
-	tlbie	r3
+	tlbie	r3,0
 	sync
 #endif /* CONFIG_SMP */
 	blr
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f988db655e5b..9b9e780b8003 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -55,7 +55,7 @@ extern void _tlbil_pid_noind(unsigned int pid);
 static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
 {
-	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
+	asm volatile ("tlbie %0,0; sync" : : "r" (address) : "memory");
 }
 #elif defined(CONFIG_PPC_BOOK3E)
 extern void _tlbil_va(unsigned long address, unsigned int pid,
diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
index 1c2802fabd57..7991ae5b83f6 100644
--- a/arch/powerpc/platforms/powermac/sleep.S
+++ b/arch/powerpc/platforms/powermac/sleep.S
@@ -347,7 +347,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	/* Flush all TLBs */
 	lis	r4,0x1000
 1:	addic.	r4,r4,-0x1000
-	tlbie	r4
+	tlbie	r4,0
 	blt	1b
 	sync
 
-- 
2.11.0
