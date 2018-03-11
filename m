Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzgfP1m1tzDrc7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 23:39:08 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id a20so9510884wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 05:39:08 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v8 3/6] module: use relative references for __ksymtab entries
Date: Sun, 11 Mar 2018 12:38:12 +0000
Message-Id: <20180311123815.17916-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
entries, each consisting of two 64-bit fields containing absolute
references, to the symbol itself and to a char array containing
its name, respectively.

When we build the same configuration with KASLR enabled, we end
up with an additional ~192 KB of relocations in the .init section,
i.e., one 24 byte entry for each absolute reference, which all need
to be processed at boot time.

Given how the struct kernel_symbol that describes each entry is
completely local to module.c (except for the references emitted
by EXPORT_SYMBOL() itself), we can easily modify it to contain
two 32-bit relative references instead. This reduces the size of
the __ksymtab section by 50% for all 64-bit architectures, and
gets rid of the runtime relocations entirely for architectures
implementing KASLR, either via standard PIE linking (arm64) or
using custom host tools (x86).

Note that the binary search involving __ksymtab contents relies
on each section being sorted by symbol name. This is implemented
based on the input section names, not the names in the ksymtab
entries, so this patch does not interfere with that.

Given that the use of place-relative relocations requires support
both in the toolchain and in the module loader, we cannot enable
this feature for all architectures. So make it dependent on whether
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Nicolas Pitre <nico@linaro.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/Kbuild   |  1 +
 arch/x86/include/asm/export.h |  5 ---
 include/asm-generic/export.h  | 12 ++++-
 include/linux/compiler.h      | 19 ++++++++
 include/linux/export.h        | 46 +++++++++++++++-----
 kernel/module.c               | 32 +++++++++++---
 6 files changed, 91 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index de690c2d2e33..a0ab9ab61c75 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,5 +8,6 @@ generated-y += xen-hypercalls.h
 
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
+generic-y += export.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
deleted file mode 100644
index 2a51d66689c5..000000000000
--- a/arch/x86/include/asm/export.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_64BIT
-#define KSYM_ALIGN 16
-#endif
-#include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db1968d81..97ce606459ae 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -5,12 +5,10 @@
 #define KSYM_FUNC(x) x
 #endif
 #ifdef CONFIG_64BIT
-#define __put .quad
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 8
 #endif
 #else
-#define __put .long
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
@@ -25,6 +23,16 @@
 #define KSYM(name) name
 #endif
 
+.macro __put, val, name
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	.long	\val - ., \name - .
+#elif defined(CONFIG_64BIT)
+	.quad	\val, \name
+#else
+	.long	\val, \name
+#endif
+.endm
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..0a9328ea9dbd 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -280,6 +280,25 @@ unsigned long read_word_at_a_time(const void *addr)
 
 #endif /* __KERNEL__ */
 
+/*
+ * Force the compiler to emit 'sym' as a symbol, so that we can reference
+ * it from inline assembler. Necessary in case 'sym' could be inlined
+ * otherwise, or eliminated entirely due to lack of references that are
+ * visible to the compiler.
+ */
+#define __ADDRESSABLE(sym) \
+	static void * const __attribute__((section(".discard"), used))	\
+		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+
+/**
+ * offset_to_ptr - convert a relative memory offset to an absolute pointer
+ * @off:	the address of the 32-bit offset value
+ */
+static inline void *offset_to_ptr(const int *off)
+{
+	return (void *)((unsigned long)off + *off);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #ifndef __optimize
diff --git a/include/linux/export.h b/include/linux/export.h
index 25005b55b079..04c78e6bfec9 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -24,12 +24,6 @@
 #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
 
 #ifndef __ASSEMBLY__
-struct kernel_symbol
-{
-	unsigned long value;
-	const char *name;
-};
-
 #ifdef MODULE
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
@@ -60,17 +54,47 @@ extern struct module __this_module;
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#include <linux/compiler.h>
+/*
+ * Emit the ksymtab entry as a pair of relative references: this reduces
+ * the size by half on 64-bit architectures, and eliminates the need for
+ * absolute relocations that require runtime processing on relocatable
+ * kernels.
+ */
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	__ADDRESSABLE(sym)						\
+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.balign	8					\n"	\
+	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
+	    "	.previous					\n")
+
+struct kernel_symbol {
+	int value_offset;
+	int name_offset;
+};
+#else
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	static const struct kernel_symbol __ksymtab_##sym		\
+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	= { (unsigned long)&sym, __kstrtab_##sym }
+
+struct kernel_symbol {
+	unsigned long value;
+	const char *name;
+};
+#endif
+
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define ___EXPORT_SYMBOL(sym, sec)					\
 	extern typeof(sym) sym;						\
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
 	= VMLINUX_SYMBOL_STR(sym);					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__used								\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__DISABLE_EXPORTS)
 
diff --git a/kernel/module.c b/kernel/module.c
index ad2d420024f6..b4782cfbb79b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -549,12 +549,30 @@ static bool check_symbol(const struct symsearch *syms,
 	return true;
 }
 
+static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (unsigned long)offset_to_ptr(&sym->value_offset);
+#else
+	return sym->value;
+#endif
+}
+
+static const char *kernel_symbol_name(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return offset_to_ptr(&sym->name_offset);
+#else
+	return sym->name;
+#endif
+}
+
 static int cmp_name(const void *va, const void *vb)
 {
 	const char *a;
 	const struct kernel_symbol *b;
 	a = va; b = vb;
-	return strcmp(a, b->name);
+	return strcmp(a, kernel_symbol_name(b));
 }
 
 static bool find_symbol_in_section(const struct symsearch *syms,
@@ -2198,7 +2216,7 @@ void *__symbol_get(const char *symbol)
 		sym = NULL;
 	preempt_enable();
 
-	return sym ? (void *)sym->value : NULL;
+	return sym ? (void *)kernel_symbol_value(sym) : NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
@@ -2228,10 +2246,12 @@ static int verify_export_symbols(struct module *mod)
 
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			if (find_symbol(s->name, &owner, NULL, true, false)) {
+			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
+					true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
-				       mod->name, s->name, module_name(owner));
+				       mod->name, kernel_symbol_name(s),
+				       module_name(owner));
 				return -ENOEXEC;
 			}
 		}
@@ -2280,7 +2300,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			ksym = resolve_symbol_wait(mod, info, name);
 			/* Ok if resolved.  */
 			if (ksym && !IS_ERR(ksym)) {
-				sym[i].st_value = ksym->value;
+				sym[i].st_value = kernel_symbol_value(ksym);
 				break;
 			}
 
@@ -2540,7 +2560,7 @@ static int is_exported(const char *name, unsigned long value,
 		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
 	else
 		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
-	return ks != NULL && ks->value == value;
+	return ks != NULL && kernel_symbol_value(ks) == value;
 }
 
 /* As per nm */
-- 
2.15.1
