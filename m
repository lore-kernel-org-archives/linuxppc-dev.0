Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80d3NQZzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:53 +1000 (AEST)
Message-Id: <583e02f6096b413dc64450d6b9a9221fdfe997e9.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 12/14] powerpc/44x: remove page.h from mmu-44x.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:49 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mmu-44x.h doesn't need asm/page.h if PAGE_SHIFT are replaced by CONFIG_PPC_XX_PAGES

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-44x.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 9bdbe1d1c9b9..b2b8274037ea 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -5,7 +5,7 @@
  * PPC440 support
  */
 
-#include <asm/page.h>
+#include <asm/nohash/32/pgtable.h>
 #include <asm/asm-const.h>
 
 #define PPC44x_MMUCR_TID	0x000000ff
@@ -125,19 +125,19 @@ typedef struct {
 /* Size of the TLBs used for pinning in lowmem */
 #define PPC_PIN_SIZE	(1 << 28)	/* 256M */
 
-#if (PAGE_SHIFT == 12)
+#if defined(CONFIG_PPC_4K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_4K
 #define mmu_virtual_psize	MMU_PAGE_4K
-#elif (PAGE_SHIFT == 14)
+#elif defined(CONFIG_PPC_16K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_16K
 #define mmu_virtual_psize	MMU_PAGE_16K
-#elif (PAGE_SHIFT == 16)
+#elif defined(CONFIG_PPC_64K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_64K
 #define mmu_virtual_psize	MMU_PAGE_64K
-#elif (PAGE_SHIFT == 18)
+#elif defined(CONFIG_PPC_256K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
 #define mmu_virtual_psize	MMU_PAGE_256K
 #else
-- 
2.13.3
