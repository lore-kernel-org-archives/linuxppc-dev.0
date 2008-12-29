Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 253E4DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 04:02:20 +1100 (EST)
Date: Mon, 29 Dec 2008 19:40:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc/32: Make clear_fixmap actually work
Message-ID: <20081229164035.GB8215@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The clear_fixmap() routine issues map_page() with flags set to 0.
Currently this causes a BUG_ON() inside the map_page(), as it assumes
that a PTE should be clear before mapping.

This patch makes the map_page() to trigger the BUG_ON() only if the
flags were set.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/mm/pgtable_32.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 3414724..23553a7 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -259,7 +259,8 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 		/* The PTE should never be already set nor present in the
 		 * hash table
 		 */
-		BUG_ON(pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE));
+		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
+		       flags);
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
 						     __pgprot(flags)));
 	}
-- 
1.5.6.5
