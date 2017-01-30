Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnB4SVfzDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:06 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 05/20] powerpc/64: Export pgtable_cache and
 pgtable_cache_add for KVM
Date: Mon, 30 Jan 2017 21:21:38 +1100
Message-Id: <1485771713-24801-6-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports the pgtable_cache array and the pgtable_cache_add
function so that HV KVM can use them for allocating radix page
tables for guests.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/init-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index a175cd8..2be5dc2 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -41,6 +41,7 @@ static void pmd_ctor(void *addr)
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
+EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 
 /*
  * Create a kmem_cache() for pagetables.  This is not used for PTE
@@ -82,7 +83,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	pgtable_cache[shift - 1] = new;
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
-
+EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-- 
2.7.4
