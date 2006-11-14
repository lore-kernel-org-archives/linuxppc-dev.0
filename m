Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-40-144.msk.skylink.ru
	[83.217.40.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B4E367E1F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 12:59:48 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/5] [POWERPC] 8xx: platform-specific mmu updates
Date: Tue, 14 Nov 2006 04:28:12 +0300
Message-Id: <20061114012812.17455.32840.stgit@localhost.localdomain>
In-Reply-To: <20061114012504.17455.13833.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is just a straight port of the same done in arch/ppc
by Marcelo Tosatti. One used to be
[PATCH] ppc32 8xx: update_mmu_cache() needs unconditional tlbie,
commit eb07d964b4491d1bb5864cd3d7e7633ccdda9a53

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/mm/mem.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d1c0758..c85eda6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -490,19 +490,19 @@ #endif
 	    !cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    pfn_valid(pfn)) {
 		struct page *page = pfn_to_page(pfn);
+#ifdef CONFIG_8xx
+		/* On 8xx, cache control instructions (particularly
+		 * "dcbst" from flush_dcache_icache) fault as write
+		 * operation if there is an unpopulated TLB entry
+		 * for the address in question. To workaround that,
+		 * we invalidate the TLB here, thus avoiding dcbst
+		 * misbehaviour.
+		 */
+		_tlbie(address);
+#endif
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
 			if (vma->vm_mm == current->active_mm) {
-#ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly 
-		 	 * "dcbst" from flush_dcache_icache) fault as write 
-			 * operation if there is an unpopulated TLB entry 
-			 * for the address in question. To workaround that, 
-			 * we invalidate the TLB here, thus avoiding dcbst 
-			 * misbehaviour.
-			 */
-				_tlbie(address);
-#endif
 				__flush_dcache_icache((void *) address);
 			} else
 				flush_dcache_icache_page(page);
