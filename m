Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8L61V9NzF3Fl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:18 +1000 (AEST)
Message-Id: <cf998b9adc4b1aa452eebc7afdde1618a3b34bfc.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 06/20] powerpc/8xx: Temporarily disable 16k pages and 512k
 hugepages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:14 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation of making use of hardware assistance in TLB handlers,
this patch temporarily disables 16K pages and 512K pages. The reason
is that when using HW assistance in 4K pages mode, the linux model
fit with the HW model for 4K pages and 8M pages.

However for 16K pages and 512K mode some additional work is needed
to get linux model fit with HW model.

Therefore the 4K pages mode will be implemented first and without
support for 512k hugepages. Then the 512k hugepages will be brought
back. And the 16K pages will be implemented in further steps.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           |  2 +-
 arch/powerpc/kernel/head_8xx.S | 36 ------------------------------------
 arch/powerpc/mm/tlb_nohash.c   |  3 ---
 3 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..33931804c46f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -698,7 +698,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x || PPC_8xx
+	depends on 44x
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c203defe49a4..9b31721b522c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -363,7 +363,6 @@ InstructionTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -414,23 +413,8 @@ InstructionTLBMiss:
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
-#ifdef CONFIG_PPC_16K_PAGES
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
 	/* Level 2 base */
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
 	b	4b
 #endif
@@ -475,7 +459,6 @@ DataStoreTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -537,22 +520,8 @@ DataStoreTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
 	/* Extract level 2 index */
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
 	/* Level 2 base */
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
 	b	4b
 #endif
@@ -773,12 +742,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 
 	/* concat physical page address(r11) and page offset(r10) */
 200:
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT_8M - 2), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-#else
 	rlwinm	r11, r10, 0, ~HUGEPD_SHIFT_MASK
-#endif
 	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 15fe5f0c8665..49441963d285 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,9 +97,6 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
-	[MMU_PAGE_512K] = {
-		.shift	= 19,
-	},
 	[MMU_PAGE_8M] = {
 		.shift	= 23,
 	},
-- 
2.13.3
