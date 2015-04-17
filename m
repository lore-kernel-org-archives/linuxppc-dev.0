Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 77A311A1B77
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 02:37:27 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH] powerpc/8xx: mmu_virtual_psize incorrect for 16k pages
Message-Id: <20150417163717.EFE071A242C@localhost.localdomain>
Date: Fri, 17 Apr 2015 18:37:17 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mmu_virtual_psize shall be set to MMU_PAGE_16K when 16k pages have
been selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/mmu-8xx.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 986b9e1..d41200c 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -145,7 +145,14 @@ typedef struct {
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
+#if (PAGE_SHIFT == 12)
 #define mmu_virtual_psize	MMU_PAGE_4K
+#elif (PAGE_SHIFT == 14)
+#define mmu_virtual_psize	MMU_PAGE_16K
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
 #define mmu_linear_psize	MMU_PAGE_8M
 
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
-- 
2.1.0
