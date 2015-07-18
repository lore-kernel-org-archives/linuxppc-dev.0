Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D6A21A19A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 05:25:25 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/fsl: Force coherent memory on e500mc derivatives
Date: Sat, 18 Jul 2015 14:24:58 -0500
Message-ID: <1437247498-6027-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437247498-6027-1-git-send-email-scottwood@freescale.com>
References: <1437247498-6027-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In CoreNet systems it is not allowed to mix M and non-M mappings to the
same memory, and coherent DMA accesses are considered to be M mappings
for this purpose.  Ignoring this has been observed to cause hard
lockups in non-SMP kernels on e6500.

Furthermore, e6500 implements the LRAT (logical to real address table)
which allows KVM guests to control the WIMGE bits.  This means that
KVM cannot force the M bit on the way it usually does, so the guest had
better set it itself.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/pte-common.h         |  3 ++-
 arch/powerpc/kernel/exceptions-64e.S          | 13 ++++++++-----
 arch/powerpc/kernel/fsl_booke_entry_mapping.S | 15 +++++++++------
 arch/powerpc/mm/fsl_booke_mmu.c               |  2 +-
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index b7c8d07..71537a3 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -109,7 +109,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  * the processor might need it for DMA coherency.
  */
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU) || \
+	defined(CONFIG_PPC_E500MC)
 #define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 #else
 #define _PAGE_BASE	(_PAGE_BASE_NC)
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3e68d1c..f3bd5e7 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1313,11 +1313,14 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	sync
 	isync
 
-/* The mapping only needs to be cache-coherent on SMP */
-#ifdef CONFIG_SMP
-#define M_IF_SMP	MAS2_M
+/*
+ * The mapping only needs to be cache-coherent on SMP, except on
+ * Freescale e500mc derivatives where it's also needed for coherent DMA.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define M_IF_NEEDED	MAS2_M
 #else
-#define M_IF_SMP	0
+#define M_IF_NEEDED	0
 #endif
 
 /* 6. Setup KERNELBASE mapping in TLB[0]
@@ -1332,7 +1335,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
 	mtspr	SPRN_MAS1,r6
 
-	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET | M_IF_SMP)
+	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET | M_IF_NEEDED)
 	mtspr	SPRN_MAS2,r6
 
 	rlwinm	r5,r5,0,0,25
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index f22e7e4..83dd0f6 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -152,11 +152,14 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbivax 0,r9
 	TLBSYNC
 
-/* The mapping only needs to be cache-coherent on SMP */
-#ifdef CONFIG_SMP
-#define M_IF_SMP	MAS2_M
+/*
+ * The mapping only needs to be cache-coherent on SMP, except on
+ * Freescale e500mc derivatives where it's also needed for coherent DMA.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define M_IF_NEEDED	MAS2_M
 #else
-#define M_IF_SMP	0
+#define M_IF_NEEDED	0
 #endif
 
 #if defined(ENTRY_MAPPING_BOOT_SETUP)
@@ -167,8 +170,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
 	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
 	mtspr	SPRN_MAS1,r6
-	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@h
-	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@l
+	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
+	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@l
 	mtspr	SPRN_MAS2,r6
 	mtspr	SPRN_MAS3,r8
 	tlbwe
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 9c90e66..354ba3c 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -112,7 +112,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 
 	tsize = __ilog2(size) - 10;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
 	if ((flags & _PAGE_NO_CACHE) == 0)
 		flags |= _PAGE_COHERENT;
 #endif
-- 
2.1.4
