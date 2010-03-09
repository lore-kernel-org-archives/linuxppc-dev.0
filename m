Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [139.142.54.143])
	by ozlabs.org (Postfix) with ESMTP id 2FAB5B7D1B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 07:12:02 +1100 (EST)
Date: Tue, 9 Mar 2010 12:35:00 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PPC32: Fixup pmd_page to work when ARCH_PFN_OFFSET is non-zero
Message-ID: <20100309193500.GE30462@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of referencing mem_map directly, use pfn_to_page. Otherwise
the kernel crashes when trying to start userspace if ARCH_PFN_OFFSET is
non-zero and CONFIG_BOOKE is not defined

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/powerpc/include/asm/pgtable-ppc32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

For reference, on powerpc 32 with CONFIG_FLATMEM:

#define pfn_to_page __pfn_to_page
#define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))

So the below patch has no effect if ARCH_PFN_OFFEST is 0.

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 55646ad..a7db96f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -287,7 +287,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
-- 
1.5.4.2
