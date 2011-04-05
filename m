Return-Path: <anton@samba.org>
Date: Tue, 5 Apr 2011 19:56:18 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: Replace open coded instruction patching with
	patch_instruction/patch_branch
Message-ID: <20110405195618.2fb40ad5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


There are a few places we patch instructions without using
patch_instruction and patch_branch, probably because they
predated it. Fix it.
 
Signed-off-by: Anton Blanchard <anton@samba.org> 
---

Index: powerpc.git/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/hash_utils_64.c	2011-02-25 14:15:49.972437235 +1100
+++ powerpc.git/arch/powerpc/mm/hash_utils_64.c	2011-04-05 18:43:33.860987967 +1000
@@ -53,6 +53,7 @@
 #include <asm/sections.h>
 #include <asm/spu.h>
 #include <asm/udbg.h>
+#include <asm/code-patching.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -547,15 +548,7 @@ int remove_section_mapping(unsigned long
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
+#define FUNCTION_TEXT(A)	((*(unsigned long *)(A)))
 
 static void __init htab_finish_init(void)
 {
@@ -570,16 +563,33 @@ static void __init htab_finish_init(void
 	extern unsigned int *ht64_call_hpte_remove;
 	extern unsigned int *ht64_call_hpte_updatepp;
 
-	make_bl(ht64_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
+	patch_branch(ht64_call_hpte_insert1,
+		FUNCTION_TEXT(ppc_md.hpte_insert),
+		BRANCH_SET_LINK);
+	patch_branch(ht64_call_hpte_insert2,
+		FUNCTION_TEXT(ppc_md.hpte_insert),
+		BRANCH_SET_LINK);
+	patch_branch(ht64_call_hpte_remove,
+		FUNCTION_TEXT(ppc_md.hpte_remove),
+		BRANCH_SET_LINK);
+	patch_branch(ht64_call_hpte_updatepp,
+		FUNCTION_TEXT(ppc_md.hpte_updatepp),
+		BRANCH_SET_LINK);
+
 #endif /* CONFIG_PPC_HAS_HASH_64K */
 
-	make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
+	patch_branch(htab_call_hpte_insert1,
+		FUNCTION_TEXT(ppc_md.hpte_insert),
+		BRANCH_SET_LINK);
+	patch_branch(htab_call_hpte_insert2,
+		FUNCTION_TEXT(ppc_md.hpte_insert),
+		BRANCH_SET_LINK);
+	patch_branch(htab_call_hpte_remove,
+		FUNCTION_TEXT(ppc_md.hpte_remove),
+		BRANCH_SET_LINK);
+	patch_branch(htab_call_hpte_updatepp,
+		FUNCTION_TEXT(ppc_md.hpte_updatepp),
+		BRANCH_SET_LINK);
 }
 
 static void __init htab_initialize(void)
Index: powerpc.git/arch/powerpc/mm/slb.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/slb.c	2011-02-25 14:15:49.952435267 +1100
+++ powerpc.git/arch/powerpc/mm/slb.c	2011-04-05 18:42:27.018630388 +1000
@@ -24,6 +24,7 @@
 #include <asm/firmware.h>
 #include <linux/compiler.h>
 #include <asm/udbg.h>
+#include <asm/code-patching.h>
 
 
 extern void slb_allocate_realmode(unsigned long ea);
@@ -249,9 +250,8 @@ void switch_slb(struct task_struct *tsk,
 static inline void patch_slb_encoding(unsigned int *insn_addr,
 				      unsigned int immed)
 {
-	*insn_addr = (*insn_addr & 0xffff0000) | immed;
-	flush_icache_range((unsigned long)insn_addr, 4+
-			   (unsigned long)insn_addr);
+	int insn = (*insn_addr & 0xffff0000) | immed;
+	patch_instruction(insn_addr, insn);
 }
 
 void slb_set_size(u16 size)
