Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C0LV3N2czF0q0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 23:49:51 +1000 (AEST)
Message-Id: <f3a64e8451cd539f8a2e864045576ad99598160d.1529589663.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: fix missing prototypes in slice.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 malat@debian.org, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 22 Jun 2018 13:49:48 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the following warnings (obtained with make W=1).

arch/powerpc/mm/slice.c: At top level:
arch/powerpc/mm/slice.c:682:15: error: no previous prototype for 'arch_get_unmapped_area' [-Werror=missing-prototypes]
 unsigned long arch_get_unmapped_area(struct file *filp,
               ^
arch/powerpc/mm/slice.c:692:15: error: no previous prototype for 'arch_get_unmapped_area_topdown' [-Werror=missing-prototypes]
 unsigned long arch_get_unmapped_area_topdown(struct file *filp,
               ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..9530c6db406a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/hugetlb.h>
+#include <linux/sched/mm.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/copro.h>
-- 
2.13.3
