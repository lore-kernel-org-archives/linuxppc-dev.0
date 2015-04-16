Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD6831A0034
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 10:40:51 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/mm: Don't call __flush_dcache_icache_phys() with PA>VA
Date: Wed, 15 Apr 2015 19:40:23 -0500
Message-ID: <1429144823-24820-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__flush_dcache_icache_phys() requires the ability to access the
memory with the MMU disabled, which means that on a 32-bit system
any memory above 4 GiB is inaccessible.  In particular, mpc86xx is
32-bit and can have more than 4 GiB of RAM.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/cacheflush.h |  7 ++++++-
 arch/powerpc/mm/mem.c                 | 14 +++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 30b35ff..6229e6b 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -40,7 +40,12 @@ extern void __flush_dcache_icache(void *page_va);
 extern void flush_dcache_icache_page(struct page *page);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_BOOKE)
 extern void __flush_dcache_icache_phys(unsigned long physaddr);
-#endif /* CONFIG_PPC32 && !CONFIG_BOOKE */
+#else
+static inline void __flush_dcache_icache_phys(unsigned long physaddr)
+{
+	BUG();
+}
+#endif
 
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b7285a5..7297d204 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -417,17 +417,17 @@ void flush_dcache_icache_page(struct page *page)
 		return;
 	}
 #endif
-#ifdef CONFIG_BOOKE
-	{
+#if defined(CONFIG_8xx) || defined(CONFIG_PPC64)
+	/* On 8xx there is no need to kmap since highmem is not supported */
+	__flush_dcache_icache(page_address(page));
+#else
+	if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
 		void *start = kmap_atomic(page);
 		__flush_dcache_icache(start);
 		kunmap_atomic(start);
+	} else {
+		__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
 	}
-#elif defined(CONFIG_8xx) || defined(CONFIG_PPC64)
-	/* On 8xx there is no need to kmap since highmem is not supported */
-	__flush_dcache_icache(page_address(page)); 
-#else
-	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
 #endif
 }
 EXPORT_SYMBOL(flush_dcache_icache_page);
-- 
2.1.0
