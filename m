Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id CCDBE2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 16:15:16 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix 64K page size support for PPC44x
Date: Thu, 17 Oct 2013 16:15:10 +1100
Message-Id: <1381986910-16310-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC44x supports page sizes other than 4K however when 64K page sizes
are selected compilation fails. This is due to a change in the
definition of pgtable_t introduced by the following patch:

commit 5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
powerpc: Reduce PTE table memory wastage

The above patch only implements the new layout for PPC64 so it doesn't
compile for PPC32 with a 64K page size. Ideally we should implement
the same layout for PPC32 however for the meantime this patch reverts
the definition of pgtable_t for PPC32.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b9f4262..b142d58 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -403,7 +403,7 @@ void arch_free_page(struct page *page, int order);
 
 struct vm_area_struct;
 
-#ifdef CONFIG_PPC_64K_PAGES
+#if defined(CONFIG_PPC_64K_PAGES) && defined(PPC64)
 typedef pte_t *pgtable_t;
 #else
 typedef struct page *pgtable_t;
-- 
1.7.10.4
