Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E01F91A045E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:27:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH v3 2/8] powerpc/module: Only try to generate the
 ftrace_caller() stub once
Date: Thu,  3 Mar 2016 15:26:54 +1100
Message-Id: <1456979220-10931-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
References: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we generate the module stub for ftrace_caller() at the bottom
of apply_relocate_add(). However apply_relocate_add() is potentially
called more than once per module, which means we will try to generate
the ftrace_caller() stub multiple times.

Although the current code deals with that correctly, ie. it only
generates a stub the first time, it would be clearer to only try to
generate the stub once.

Note also on first reading it may appear that we generate a different
stub for each section that requires relocation, but that is not the
case. The code in stub_for_addr() that searches for an existing stub
uses sechdrs[me->arch.stubs_section], ie. the single stub section for
this module.

A cleaner approach is to only generate the ftrace_caller() stub once,
from module_finalize(). Although the original code didn't check to see
if the stub was actually generated correctly, it seems prudent to add a
check, so do that. And an additional benefit is we can clean the ifdefs
up a little.

Finally we must propagate the const'ness of some of the pointers passed
to module_finalize(), but that is also an improvement.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/module.h |  9 +++++++++
 arch/powerpc/kernel/module.c      |  5 +++++
 arch/powerpc/kernel/module_32.c   | 20 ++++++++++++++------
 arch/powerpc/kernel/module_64.c   | 22 ++++++++++++++--------
 4 files changed, 42 insertions(+), 14 deletions(-)

v3: Fix compile error on 32-bit ! :}
v2: Add error checking on 32-bit for consistency.

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index dcfcad139bcc..74d25a749018 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -82,6 +82,15 @@ bool is_module_trampoline(u32 *insns);
 int module_trampoline_target(struct module *mod, u32 *trampoline,
 			     unsigned long *target);
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs);
+#else
+static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
+{
+	return 0;
+}
+#endif
+
 struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
 		   struct exception_table_entry *finish);
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 9547381b631a..d1f1b35bf0c7 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -47,6 +47,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 		const Elf_Shdr *sechdrs, struct module *me)
 {
 	const Elf_Shdr *sect;
+	int rc;
+
+	rc = module_finalize_ftrace(me, sechdrs);
+	if (rc)
+		return rc;
 
 	/* Apply feature fixups */
 	sect = find_section(hdr, sechdrs, "__ftr_fixup");
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 2c01665eb410..5a7a78f12562 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -181,7 +181,7 @@ static inline int entry_matches(struct ppc_plt_entry *entry, Elf32_Addr val)
 /* Set up a trampoline in the PLT to bounce us to the distant function */
 static uint32_t do_plt_call(void *location,
 			    Elf32_Addr val,
-			    Elf32_Shdr *sechdrs,
+			    const Elf32_Shdr *sechdrs,
 			    struct module *mod)
 {
 	struct ppc_plt_entry *entry;
@@ -294,11 +294,19 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			return -ENOEXEC;
 		}
 	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
-	module->arch.tramp =
-		do_plt_call(module->core_layout.base,
-			    (unsigned long)ftrace_caller,
-			    sechdrs, module);
-#endif
+int module_finalize_ftrace(struct module *module, const Elf_Shdr *sechdrs)
+{
+	module->arch.tramp = do_plt_call(module->core_layout.base,
+					 (unsigned long)ftrace_caller,
+					 sechdrs, module);
+	if (!module->arch.tramp)
+		return -ENOENT;
+
 	return 0;
 }
+#endif
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 08b7a40de5f8..00314b31a0d4 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -413,7 +413,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 /* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
    gives the value maximum span in an instruction which uses a signed
    offset) */
-static inline unsigned long my_r2(Elf64_Shdr *sechdrs, struct module *me)
+static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
 {
 	return sechdrs[me->arch.toc_section].sh_addr + 0x8000;
 }
@@ -426,7 +426,7 @@ static inline unsigned long my_r2(Elf64_Shdr *sechdrs, struct module *me)
 #define PPC_HA(v) PPC_HI ((v) + 0x8000)
 
 /* Patch stub to reference function and correct r2 value. */
-static inline int create_stub(Elf64_Shdr *sechdrs,
+static inline int create_stub(const Elf64_Shdr *sechdrs,
 			      struct ppc64_stub_entry *entry,
 			      unsigned long addr,
 			      struct module *me)
@@ -452,7 +452,7 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 
 /* Create stub to jump to function described in this OPD/ptr: we need the
    stub to set up the TOC ptr (r2) for the function. */
-static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
+static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 				   unsigned long addr,
 				   struct module *me)
 {
@@ -693,12 +693,18 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		}
 	}
 
+	return 0;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
-	me->arch.toc = my_r2(sechdrs, me);
-	me->arch.tramp = stub_for_addr(sechdrs,
-				       (unsigned long)ftrace_caller,
-				       me);
-#endif
+int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
+{
+	mod->arch.toc = my_r2(sechdrs, mod);
+	mod->arch.tramp = stub_for_addr(sechdrs, (unsigned long)ftrace_caller, mod);
+
+	if (!mod->arch.tramp)
+		return -ENOENT;
 
 	return 0;
 }
+#endif
-- 
2.5.0
