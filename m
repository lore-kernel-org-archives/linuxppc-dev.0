Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 12/33] powerpc: Use ppc_function_entry instead of open coding
 it
Date: Tue, 25 Mar 2014 22:44:18 +1100
Message-Id: <1395747879-5948-13-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace FUNCTION_TEXT with ppc_function_entry which can handle both
ABIv1 and ABIv2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/hash_utils_64.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d766d6e..49fc935 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -603,8 +603,6 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-#define FUNCTION_TEXT(A)	((*(unsigned long *)(A)))
-
 static void __init htab_finish_init(void)
 {
 	extern unsigned int *htab_call_hpte_insert1;
@@ -619,31 +617,31 @@ static void __init htab_finish_init(void)
 	extern unsigned int *ht64_call_hpte_updatepp;
 
 	patch_branch(ht64_call_hpte_insert1,
-		FUNCTION_TEXT(ppc_md.hpte_insert),
+		ppc_function_entry(ppc_md.hpte_insert),
 		BRANCH_SET_LINK);
 	patch_branch(ht64_call_hpte_insert2,
-		FUNCTION_TEXT(ppc_md.hpte_insert),
+		ppc_function_entry(ppc_md.hpte_insert),
 		BRANCH_SET_LINK);
 	patch_branch(ht64_call_hpte_remove,
-		FUNCTION_TEXT(ppc_md.hpte_remove),
+		ppc_function_entry(ppc_md.hpte_remove),
 		BRANCH_SET_LINK);
 	patch_branch(ht64_call_hpte_updatepp,
-		FUNCTION_TEXT(ppc_md.hpte_updatepp),
+		ppc_function_entry(ppc_md.hpte_updatepp),
 		BRANCH_SET_LINK);
 
 #endif /* CONFIG_PPC_HAS_HASH_64K */
 
 	patch_branch(htab_call_hpte_insert1,
-		FUNCTION_TEXT(ppc_md.hpte_insert),
+		ppc_function_entry(ppc_md.hpte_insert),
 		BRANCH_SET_LINK);
 	patch_branch(htab_call_hpte_insert2,
-		FUNCTION_TEXT(ppc_md.hpte_insert),
+		ppc_function_entry(ppc_md.hpte_insert),
 		BRANCH_SET_LINK);
 	patch_branch(htab_call_hpte_remove,
-		FUNCTION_TEXT(ppc_md.hpte_remove),
+		ppc_function_entry(ppc_md.hpte_remove),
 		BRANCH_SET_LINK);
 	patch_branch(htab_call_hpte_updatepp,
-		FUNCTION_TEXT(ppc_md.hpte_updatepp),
+		ppc_function_entry(ppc_md.hpte_updatepp),
 		BRANCH_SET_LINK);
 }
 
-- 
1.8.3.2
