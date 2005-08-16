Return-Path: <rolandd@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id AD92567F67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 07:06:55 +1000 (EST)
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 16 Aug 2005 13:56:49 -0700
Message-ID: <521x4tha7i.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] PPC: Don't sleep in flush_dcache_icache_page()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

flush_dcache_icache_page() will be called on an instruction page
fault.  We can't sleep in the fault handler, so use kmap_atomic()
instead of just kmap() for the Book-E case.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -560,8 +560,16 @@ void flush_dcache_page(struct page *page
 void flush_dcache_icache_page(struct page *page)
 {
 #ifdef CONFIG_BOOKE
-	__flush_dcache_icache(kmap(page));
-	kunmap(page);
+	unsigned long flags;
+	void *start;
+
+	local_irq_save(flags);
+
+	start = kmap_atomic(page, KM_PPC_SYNC_PAGE);
+	__flush_dcache_icache(start);
+	kunmap_atomic(start, KM_PPC_SYNC_PAGE);
+
+	local_irq_restore(flags);
 #elif CONFIG_8xx
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page)); 
