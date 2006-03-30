Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 30 Mar 2006 17:12:58 +1100
Subject: [PATCH 2/5] powerpc: Use ppc_md.hpte_insert() in htab_bolt_mapping()
In-Reply-To: <1143699173.339118.857634197021.qpush@concordia>
Message-Id: <20060330061258.C902167A45@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the ppc_md htab pointers setup earlier, we can use ppc_md.hpte_insert
in htab_bolt_mapping(), rather than deciding which version to call by hand.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_utils_64.c |   34 ++++++----------------------------
 1 files changed, 6 insertions(+), 28 deletions(-)

Index: to-merge/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_utils_64.c
+++ to-merge/arch/powerpc/mm/hash_utils_64.c
@@ -162,34 +162,12 @@ int htab_bolt_mapping(unsigned long vsta
 		hash = hpt_hash(va, shift);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
-		/* The crap below can be cleaned once ppd_md.probe() can
-		 * set up the hash callbacks, thus we can just used the
-		 * normal insert callback here.
-		 */
-#ifdef CONFIG_PPC_ISERIES
-		if (machine_is(iseries))
-			ret = iSeries_hpte_insert(hpteg, va,
-						  paddr,
-						  tmp_mode,
-						  HPTE_V_BOLTED,
-						  psize);
-		else
-#endif
-#ifdef CONFIG_PPC_PSERIES
-		if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR))
-			ret = pSeries_lpar_hpte_insert(hpteg, va,
-						       paddr,
-						       tmp_mode,
-						       HPTE_V_BOLTED,
-						       psize);
-		else
-#endif
-#ifdef CONFIG_PPC_MULTIPLATFORM
-			ret = native_hpte_insert(hpteg, va,
-						 paddr,
-						 tmp_mode, HPTE_V_BOLTED,
-						 psize);
-#endif
+		DBG("htab_bolt_mapping: calling %p\n", ppc_md.hpte_insert);
+
+		BUG_ON(!ppc_md.hpte_insert);
+		ret = ppc_md.hpte_insert(hpteg, va, paddr,
+				tmp_mode, HPTE_V_BOLTED, psize);
+
 		if (ret < 0)
 			break;
 	}
