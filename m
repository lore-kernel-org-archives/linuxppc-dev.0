Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5542C1A0F3F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 12:01:38 +1100 (AEDT)
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] module: remove mod arg from module_free,
 rename module_memfree().
Date: Thu,  8 Jan 2015 11:28:06 +1030
Message-Id: <1420678687-30548-3-git-send-email-rusty@rustcorp.com.au>
In-Reply-To: <1420678687-30548-1-git-send-email-rusty@rustcorp.com.au>
References: <1420678687-30548-1-git-send-email-rusty@rustcorp.com.au>
Cc: linux-mips@linux-mips.org, Jesper Nilsson <jesper.nilsson@axis.com>,
 x86@kernel.org, linux-cris-kernel@axis.com,
 Rusty Russell <rusty@rustcorp.com.au>, Alexei Starovoitov <ast@kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 Mikael Starvik <starvik@axis.com>, sparclinux@vger.kernel.org,
 Chris Metcalf <cmetcalf@ezchip.com>, netdev@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, nios2-dev@lists.rocketboards.org,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Ley Foon Tan <lftan@altera.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nothing needs the module pointer any more, and the next patch will
call it from RCU, where the module itself might no longer exist.
Removing the arg is the safest approach.

This just codifies the use of the module_alloc/module_free pattern
which ftrace and bpf use.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: linux-cris-kernel@axis.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: nios2-dev@lists.rocketboards.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 arch/cris/kernel/module.c       |  2 +-
 arch/mips/net/bpf_jit.c         |  2 +-
 arch/nios2/kernel/module.c      |  2 +-
 arch/powerpc/net/bpf_jit_comp.c |  2 +-
 arch/sparc/net/bpf_jit_comp.c   |  4 ++--
 arch/tile/kernel/module.c       |  2 +-
 arch/x86/kernel/ftrace.c        |  2 +-
 include/linux/moduleloader.h    |  2 +-
 kernel/bpf/core.c               |  2 +-
 kernel/kprobes.c                |  2 +-
 kernel/module.c                 | 14 +++++++-------
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/cris/kernel/module.c b/arch/cris/kernel/module.c
index 51123f985eb5..af04cb6b6dc9 100644
--- a/arch/cris/kernel/module.c
+++ b/arch/cris/kernel/module.c
@@ -36,7 +36,7 @@ void *module_alloc(unsigned long size)
 }
 
 /* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
+void module_memfree(void *module_region)
 {
 	kfree(module_region);
 }
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 9fd6834a2172..5d6139390bf8 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1388,7 +1388,7 @@ out:
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_free(NULL, fp->bpf_func);
+		module_memfree(fp->bpf_func);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
index cc924a38f22a..e2e3f13f98d5 100644
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -36,7 +36,7 @@ void *module_alloc(unsigned long size)
 }
 
 /* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
+void module_memfree(void *module_region)
 {
 	kfree(module_region);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 1ca125b9c226..d1916b577f2c 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -699,7 +699,7 @@ out:
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_free(NULL, fp->bpf_func);
+		module_memfree(fp->bpf_func);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index f33e7c7a3bf7..7931eeeb649a 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -776,7 +776,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 				if (unlikely(proglen + ilen > oldproglen)) {
 					pr_err("bpb_jit_compile fatal error\n");
 					kfree(addrs);
-					module_free(NULL, image);
+					module_memfree(image);
 					return;
 				}
 				memcpy(image + proglen, temp, ilen);
@@ -822,7 +822,7 @@ out:
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_free(NULL, fp->bpf_func);
+		module_memfree(fp->bpf_func);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/tile/kernel/module.c b/arch/tile/kernel/module.c
index 62a597e810d6..2305084c9b93 100644
--- a/arch/tile/kernel/module.c
+++ b/arch/tile/kernel/module.c
@@ -74,7 +74,7 @@ error:
 
 
 /* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
+void module_memfree(void *module_region)
 {
 	vfree(module_region);
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 2142376dc8c6..8b7b0a51e742 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -674,7 +674,7 @@ static inline void *alloc_tramp(unsigned long size)
 }
 static inline void tramp_free(void *tramp)
 {
-	module_free(NULL, tramp);
+	module_memfree(tramp);
 }
 #else
 /* Trampolines can only be created if modules are supported */
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 054eac853090..f7556261fe3c 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -26,7 +26,7 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
 void *module_alloc(unsigned long size);
 
 /* Free memory returned from module_alloc. */
-void module_free(struct module *mod, void *module_region);
+void module_memfree(void *module_region);
 
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d6594e457a25..a64e7a207d2b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -163,7 +163,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	module_free(NULL, hdr);
+	module_memfree(hdr);
 }
 #endif /* CONFIG_BPF_JIT */
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 06f58309fed2..ee619929cf90 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -127,7 +127,7 @@ static void *alloc_insn_page(void)
 
 static void free_insn_page(void *page)
 {
-	module_free(NULL, page);
+	module_memfree(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
diff --git a/kernel/module.c b/kernel/module.c
index 68be0b1f9e7f..1f85fd5c89d3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1795,7 +1795,7 @@ static void unset_module_core_ro_nx(struct module *mod) { }
 static void unset_module_init_ro_nx(struct module *mod) { }
 #endif
 
-void __weak module_free(struct module *mod, void *module_region)
+void __weak module_memfree(void *module_region)
 {
 	vfree(module_region);
 }
@@ -1846,7 +1846,7 @@ static void free_module(struct module *mod)
 	/* This may be NULL, but that's OK */
 	unset_module_init_ro_nx(mod);
 	module_arch_freeing_init(mod);
-	module_free(mod, mod->module_init);
+	module_memfree(mod->module_init);
 	kfree(mod->args);
 	percpu_modfree(mod);
 
@@ -1855,7 +1855,7 @@ static void free_module(struct module *mod)
 
 	/* Finally, free the core (containing the module structure) */
 	unset_module_core_ro_nx(mod);
-	module_free(mod, mod->module_core);
+	module_memfree(mod->module_core);
 
 #ifdef CONFIG_MPU
 	update_protections(current->mm);
@@ -2790,7 +2790,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		 */
 		kmemleak_ignore(ptr);
 		if (!ptr) {
-			module_free(mod, mod->module_core);
+			module_memfree(mod->module_core);
 			return -ENOMEM;
 		}
 		memset(ptr, 0, mod->init_size);
@@ -2936,8 +2936,8 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
-	module_free(mod, mod->module_init);
-	module_free(mod, mod->module_core);
+	module_memfree(mod->module_init);
+	module_memfree(mod->module_core);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
@@ -3062,7 +3062,7 @@ static int do_init_module(struct module *mod)
 #endif
 	unset_module_init_ro_nx(mod);
 	module_arch_freeing_init(mod);
-	module_free(mod, mod->module_init);
+	module_memfree(mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
 	mod->init_ro_size = 0;
-- 
2.1.0
