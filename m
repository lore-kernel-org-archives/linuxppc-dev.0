Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id B9DBD1A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 03:08:15 +1100 (AEDT)
Message-Id: <480e9d7dfc52f2dabd81ae25707a8d0a5bbd0310.1455032446.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1455032446.git.christophe.leroy@c-s.fr>
References: <cover.1455032446.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 13/23] powerpc/8xx: Add missing SPRN defines into reg_8xx.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 17:08:12 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing SPRN defines into reg_8xx.h
Some of them are defined in mmu-8xx.h, so we include mmu-8xx.h in
reg_8xx.h, for that we remove references to PAGE_SHIFT in mmu-8xx.h
to have it self sufficient, as includers of reg_8xx.h don't all
include asm/page.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: We just add missing ones, don't move anymore the ones from mmu-8xx.h
v4: no change
v5: no change
v6: no change
v8: no change

 arch/powerpc/include/asm/mmu-8xx.h |  4 ++--
 arch/powerpc/include/asm/reg_8xx.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index f05500a..0a566f1 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -171,9 +171,9 @@ typedef struct {
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
-#if (PAGE_SHIFT == 12)
+#if defined(CONFIG_PPC_4K_PAGES)
 #define mmu_virtual_psize	MMU_PAGE_4K
-#elif (PAGE_SHIFT == 14)
+#elif defined(CONFIG_PPC_16K_PAGES)
 #define mmu_virtual_psize	MMU_PAGE_16K
 #else
 #error "Unsupported PAGE_SIZE"
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index e8ea346..0f71c81 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -4,6 +4,8 @@
 #ifndef _ASM_POWERPC_REG_8xx_H
 #define _ASM_POWERPC_REG_8xx_H
 
+#include <asm/mmu-8xx.h>
+
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
  */
@@ -14,6 +16,15 @@
 #define SPRN_DC_ADR	569	/* Address needed for some commands */
 #define SPRN_DC_DAT	570	/* Read-only data register */
 
+/* Misc Debug */
+#define SPRN_DPDR	630
+#define SPRN_MI_CAM	816
+#define SPRN_MI_RAM0	817
+#define SPRN_MI_RAM1	818
+#define SPRN_MD_CAM	824
+#define SPRN_MD_RAM0	825
+#define SPRN_MD_RAM1	826
+
 /* Commands.  Only the first few are available to the instruction cache.
 */
 #define	IDC_ENABLE	0x02000000	/* Cache enable */
-- 
2.1.0
