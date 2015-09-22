Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id E47661A074C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:53 +1000 (AEST)
Message-Id: <cb26118572adb9976f6870b22a0e5ef4c67f50db.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/25] powerpc/8xx: map 16M RAM at startup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:50 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On recent kernels, with some debug options like for instance
CONFIG_LOCKDEP, the BSS requires more than 8M memory, allthough
the kernel code fits in the first 8M.
Today, it is necessary to activate CONFIG_PIN_TLB to get more than 8M
at startup, allthough pinning TLB is not necessary for that.

This patch adds a second 8M page to the initial mapping in order to
have 16M mapped regardless of CONFIG_PIN_TLB, like several other
32 bits PPC (40x, 601, ...)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/kernel/head_8xx.S | 2 ++
 arch/powerpc/mm/8xx_mmu.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 41b5d1b..1238fbe 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -871,6 +871,7 @@ initial_mmu:
 	*/
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
+#endif
 
 	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
 	addis	r8, r8, 0x0080		/* Add 8M */
@@ -883,6 +884,7 @@ initial_mmu:
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
 
+#ifdef CONFIG_PIN_TLB
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index eeca14b..28283e2 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -144,7 +144,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* 8xx can only access 24MB at the moment */
 	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
 #else
-	/* 8xx can only access 8MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
+	/* 8xx can only access 16MB at the moment */
+	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000));
 #endif
 }
-- 
2.1.0
