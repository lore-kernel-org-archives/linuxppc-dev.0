Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sXNZ6tp6zF1P7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:51:10 +1000 (AEST)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/modules: remove unused mod_arch_specific.toc field
Date: Thu, 24 May 2018 22:48:34 -0500
Message-Id: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The toc field in the mod_arch_specific struct isn't actually used
anywhere, so remove it.

Also the ftrace-specific fields are now common between 32-bit and
64-bit, so simplify the struct definition a bit by moving them out of
the __powerpc64__ #ifdef.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/powerpc/include/asm/module.h | 13 +++++--------
 arch/powerpc/kernel/module_64.c   |  1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 18f7214d68b7..d8374f984f39 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -50,13 +50,6 @@ struct mod_arch_specific {
 	unsigned int stubs_section;	/* Index of stubs section in module */
 	unsigned int toc_section;	/* What section is the TOC? */
 	bool toc_fixed;			/* Have we fixed up .TOC.? */
-#ifdef CONFIG_DYNAMIC_FTRACE
-	unsigned long toc;
-	unsigned long tramp;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	unsigned long tramp_regs;
-#endif
-#endif
 
 	/* For module function descriptor dereference */
 	unsigned long start_opd;
@@ -65,10 +58,14 @@ struct mod_arch_specific {
 	/* Indices of PLT sections within module. */
 	unsigned int core_plt_section;
 	unsigned int init_plt_section;
+#endif /* powerpc64 */
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned long tramp;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	unsigned long tramp_regs;
+#endif
 #endif
-#endif /* powerpc64 */
 
 	/* List of BUG addresses, source line numbers and filenames */
 	struct list_head bug_list;
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f7667e2ebfcb..1b7419579820 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -823,7 +823,6 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs,
 
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 {
-	mod->arch.toc = my_r2(sechdrs, mod);
 	mod->arch.tramp = create_ftrace_stub(sechdrs, mod,
 					(unsigned long)ftrace_caller);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-- 
2.17.0
