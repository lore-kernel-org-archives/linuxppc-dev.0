Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 30 Mar 2006 17:13:15 +1100
Subject: [PATCH 5/5] powerpc: Replace calls to make_bl() with
	create_function_call()
In-Reply-To: <1143699173.339118.857634197021.qpush@concordia>
Message-Id: <20060330061315.9EE2A67B80@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use create_function_call() instead of make_bl() in htab_finish_init().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_utils_64.c |   45 ++++++++++++++++------------------------
 1 files changed, 18 insertions(+), 27 deletions(-)

Index: to-merge/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_utils_64.c
+++ to-merge/arch/powerpc/mm/hash_utils_64.c
@@ -52,6 +52,7 @@
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
 #include <asm/sections.h>
+#include <asm/util.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -375,39 +376,29 @@ void create_section_mapping(unsigned lon
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-static inline void make_bl(unsigned int *insn_addr, void *func)
-{
-	unsigned long funcp = *((unsigned long *)func);
-	int offset = funcp - (unsigned long)insn_addr;
-
-	*insn_addr = (unsigned int)(0x48000001 | (offset & 0x03fffffc));
-	flush_icache_range((unsigned long)insn_addr, 4+
-			   (unsigned long)insn_addr);
-}
-
 static void __init htab_finish_init(void)
 {
-	extern unsigned int *htab_call_hpte_insert1;
-	extern unsigned int *htab_call_hpte_insert2;
-	extern unsigned int *htab_call_hpte_remove;
-	extern unsigned int *htab_call_hpte_updatepp;
+	extern unsigned long htab_call_hpte_insert1;
+	extern unsigned long htab_call_hpte_insert2;
+	extern unsigned long htab_call_hpte_remove;
+	extern unsigned long htab_call_hpte_updatepp;
 
 #ifdef CONFIG_PPC_64K_PAGES
-	extern unsigned int *ht64_call_hpte_insert1;
-	extern unsigned int *ht64_call_hpte_insert2;
-	extern unsigned int *ht64_call_hpte_remove;
-	extern unsigned int *ht64_call_hpte_updatepp;
-
-	make_bl(ht64_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
+	extern unsigned long ht64_call_hpte_insert1;
+	extern unsigned long ht64_call_hpte_insert2;
+	extern unsigned long ht64_call_hpte_remove;
+	extern unsigned long ht64_call_hpte_updatepp;
+
+	create_function_call(ht64_call_hpte_insert1, ppc_md.hpte_insert);
+	create_function_call(ht64_call_hpte_insert2, ppc_md.hpte_insert);
+	create_function_call(ht64_call_hpte_remove, ppc_md.hpte_remove);
+	create_function_call(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
+	create_function_call(htab_call_hpte_insert1, ppc_md.hpte_insert);
+	create_function_call(htab_call_hpte_insert2, ppc_md.hpte_insert);
+	create_function_call(htab_call_hpte_remove, ppc_md.hpte_remove);
+	create_function_call(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
 }
 
 void __init htab_initialize(void)
