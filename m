Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D616B726B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:52 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3145fd5df21245d79ef43268b72f712dbbfe2dbe.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/7] powerpc: Use pr_devel() in do_dcache_icache_coherency()
Date: Thu, 18 Jun 2009 14:13:52 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   2036     368       8    2412     96c arch/powerpc/mm/pgtable.o

size after:
   text    data     bss     dec     hex filename
   1677     248       8    1933     78d arch/powerpc/mm/pgtable.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/pgtable.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ae1d67c..627767d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -129,12 +129,12 @@ static pte_t do_dcache_icache_coherency(pte_t pte)
 	page = pfn_to_page(pfn);
 
 	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)) {
-		pr_debug("do_dcache_icache_coherency... flushing\n");
+		pr_devel("do_dcache_icache_coherency... flushing\n");
 		flush_dcache_icache_page(page);
 		set_bit(PG_arch_1, &page->flags);
 	}
 	else
-		pr_debug("do_dcache_icache_coherency... already clean\n");
+		pr_devel("do_dcache_icache_coherency... already clean\n");
 	return __pte(pte_val(pte) | _PAGE_HWEXEC);
 }
 
-- 
1.6.2.1
