Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 3311A1A1D2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:29 +1000 (AEST)
Message-Id: <95769284e459d5143f488999d4e219e01645b7ff.1439382637.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 16/20] powerpc/8xx: rewrite flush_instruction_cache() in C
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:25 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC8xx, flushing instruction cache is performed by writing
in register SPRN_IC_CST. This registers suffers CPU6 ERRATA.
The patch rewrites the fonction in C so that CPU6 ERRATA will
be handled transparently

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/misc_32.S | 10 ++++------
 arch/powerpc/mm/8xx_mmu.c     |  7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index ed3ab50..72fd7a7 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -296,12 +296,9 @@ _GLOBAL(real_writeb)
  * Flush instruction cache.
  * This is a no-op on the 601.
  */
+#ifndef CONFIG_PPC_8xx
 _GLOBAL(flush_instruction_cache)
-#if defined(CONFIG_8xx)
-	isync
-	lis	r5, IDC_INVALL@h
-	mtspr	SPRN_IC_CST, r5
-#elif defined(CONFIG_4xx)
+#if defined(CONFIG_4xx)
 #ifdef CONFIG_403GCX
 	li      r3, 512
 	mtctr   r3
@@ -334,9 +331,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
 	mfspr	r3,SPRN_HID0
 	ori	r3,r3,HID0_ICFI
 	mtspr	SPRN_HID0,r3
-#endif /* CONFIG_8xx/4xx */
+#endif /* CONFIG_4xx */
 	isync
 	blr
+#endif /* CONFIG_PPC_8xx */
 
 /*
  * Write any modified data cache blocks out to memory
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 15dce36..845b374 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -181,3 +181,10 @@ void set_context(unsigned long id, pgd_t *pgd)
 	mtspr(SPRN_M_CASID, id);
 	mb();
 }
+
+void flush_instruction_cache(void)
+{
+	isync();
+	mtspr(SPRN_IC_CST, IDC_INVALL);
+	isync();
+}
-- 
2.1.0
