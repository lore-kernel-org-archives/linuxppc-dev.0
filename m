Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove tlb batching hack for nighthawk
Date: Fri, 21 Sep 2012 18:08:28 +1000
Message-Id: <1348214908-32605-1-git-send-email-michael@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In hpte_init_native() we call tlb_batching_enabled() to decide if we
should setup ppc_md.flush_hash_range.

tlb_batching_enabled() checks the _unflattened_ device tree, to see
if we are running on a nighthawk.

Since commit a223535 ("dont allow pSeries_probe to succeed without
initialising MMU", Dec 2006), hpte_init_native() has been called from
pSeries_probe() - at which point we have not yet unflattened the
device tree.

This means tlb_batching_enabled() will always return true, so the hack
has effectively been disabled since Dec 2006. Ergo, I think we can
drop it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/hash_native_64.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index f21e8ce..60c21a8 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -539,29 +539,6 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_PPC_PSERIES
-/* Disable TLB batching on nighthawk */
-static inline int tlb_batching_enabled(void)
-{
-	struct device_node *root = of_find_node_by_path("/");
-	int enabled = 1;
-
-	if (root) {
-		const char *model = of_get_property(root, "model", NULL);
-		if (model && !strcmp(model, "IBM,9076-N81"))
-			enabled = 0;
-		of_node_put(root);
-	}
-
-	return enabled;
-}
-#else
-static inline int tlb_batching_enabled(void)
-{
-	return 1;
-}
-#endif
-
 void __init hpte_init_native(void)
 {
 	ppc_md.hpte_invalidate	= native_hpte_invalidate;
@@ -570,6 +547,5 @@ void __init hpte_init_native(void)
 	ppc_md.hpte_insert	= native_hpte_insert;
 	ppc_md.hpte_remove	= native_hpte_remove;
 	ppc_md.hpte_clear_all	= native_hpte_clear;
-	if (tlb_batching_enabled())
-		ppc_md.flush_hash_range = native_flush_hash_range;
+	ppc_md.flush_hash_range = native_flush_hash_range;
 }
-- 
1.7.9.5
