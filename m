Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mLdf5nMqzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 18:14:46 +1000 (AEST)
Message-Id: <da0c182b76c27988b88ebd35ee284f5be5882dd1.1533802042.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/lib: Use patch_site to patch copy_32 functions once
 cache is enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  9 Aug 2018 08:14:41 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The symbol memcpy_nocache_branch defined in order to allow patching
of memset function once cache is enabled leads to confusing reports
by perf tool.

Using the new patch_site functionality solves this issue.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 +
 arch/powerpc/kernel/setup_32.c            | 7 +++----
 arch/powerpc/lib/copy_32.S                | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 70fdc5b9b9fb..1f4691ce4126 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -146,6 +146,7 @@ void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
 /* Patch sites */
 extern s32 patch__call_flush_count_cache;
 extern s32 patch__flush_count_cache_return;
+extern s32 patch__memset_nocache, patch__memcpy_nocache;
 
 extern long flush_count_cache;
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 0e3743343280..ba969278bf4d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -97,11 +97,10 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * We do the initial parsing of the flat device-tree and prepares
  * for the MMU to be fully initialized.
  */
-extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
-
 notrace void __init machine_init(u64 dt_ptr)
 {
-	unsigned int *addr = &memset_nocache_branch;
+	unsigned int *addr = (unsigned int *)((unsigned long)&patch__memset_nocache +
+					       patch__memset_nocache);
 	unsigned long insn;
 
 	/* Configure static keys first, now that we're relocated. */
@@ -110,7 +109,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
-	patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
+	patch_instruction_site(&patch__memcpy_nocache, PPC_INST_NOP);
 
 	insn = create_cond_branch(addr, branch_target(addr), 0x820000);
 	patch_instruction(addr, insn);	/* replace b by bne cr0 */
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index da425bb6b369..ba66846fe973 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -13,6 +13,7 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/code-patching-asm.h>
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -107,8 +108,8 @@ _GLOBAL(memset)
 	 * Skip optimised bloc until cache is enabled. Will be replaced
 	 * by 'bne' during boot to use normal procedure if r4 is not zero
 	 */
-_GLOBAL(memset_nocache_branch)
-	b	2f
+5:	b	2f
+	patch_site	5b, patch__memset_nocache
 
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
@@ -168,7 +169,9 @@ _GLOBAL(memmove)
 	/* fall through */
 
 _GLOBAL(memcpy)
-	b	generic_memcpy
+1:	b	generic_memcpy
+	patch_site	1b, patch__memcpy_nocache
+
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
-- 
2.13.3
