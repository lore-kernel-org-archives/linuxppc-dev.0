Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [83.217.33.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D193EDE189
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 06:41:11 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/7] POWERPC 8xx: platform specific mmu updates
Date: Wed, 24 Jan 2007 22:40:57 +0300
Message-ID: <20070124194057.3385.11660.stgit@localhost.localdomain>
In-Reply-To: <20070124193402.3385.79090.stgit@localhost.localdomain>
References: <20070124193402.3385.79090.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

In a nutshell, the board is nearly stuck without this, yet without any
visible failure - being just very slow.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/mm/mem.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d1c0758..c85eda6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -490,19 +490,19 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
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
