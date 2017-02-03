Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFBzf6rqWzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 20:54:38 +1100 (AEDT)
Received: by mail-wm0-x22f.google.com with SMTP id b65so20307757wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 01:54:38 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jeyu@redhat.com, rusty@rustcorp.com.au, mmarek@suse.com, mpe@ellerman.id.au
Cc: torvalds@linux-foundation.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 2/3] modversions: treat symbol CRCs as 32 bit quantities
Date: Fri,  3 Feb 2017 09:54:06 +0000
Message-Id: <1486115647-27680-3-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The modversion symbol CRCs are emitted as ELF symbols, which allows us to
easily populate the kcrctab sections by relying on the linker to associate
each kcrctab slot with the correct value.

This has a couple of downsides:
- Given that the CRCs are treated as memory addresses, we waste 4 bytes
  for each CRC on 64 bit architectures,
- On architectures that support runtime relocation, a R_<arch>_RELATIVE
  relocation entry is emitted for each CRC value, which identifies it as
  a quantity that requires fixing up based on the actual runtime load
  offset of the kernel. This results in corrupted CRCs unless we
  explicitly undo the fixup (and this is currently being handled in the
  core module code)
- Such runtime relocation entries take up 24 bytes of __init space each,
  resulting in a x8 overhead in [uncompressed] kernel size for CRCs.

Switching to explicit 32 bit values on 64 bit architectures fixes most
of these issues, given that 32 bit values are not treated as quantities
that require fixing up based on the actual runtime load offset. Note that
on some ELF64 architectures [such as PPC64], these 32-bit values are still
emitted as [absolute] runtime relocatable quantities, even if the value
resolves to a build time constant. Since relative relocations are always
resolved at build time, this patch enables MODULE_REL_CRCS on powerpc when
CONFIG_RELOCATABLE=y, which turns the absolute CRC references into relative
references into .rodata where the actual CRC value is stored.

So redefine all CRC fields and variables as u32, and redefine the
__CRC_SYMBOL() macro for 64 bit builds to emit the CRC reference using
inline assembler (which is necessary since 64-bit C code cannot use
32-bit types to hold memory addresses, even if they are ultimately
resolved using values that do not exceed 0xffffffff). To avoid potential
problems with legacy 32-bit architectures using legacy toolchains, the
equivalent C definition of the kcrctab entry is retained for 32-bit
architectures.

Note that this mostly reverts commit d4703aefdbc8 ("module: handle ppc64
relocating kcrctabs when CONFIG_RELOCATABLE=y")

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ---
 include/asm-generic/export.h      | 11 ++--
 include/linux/export.h            | 14 ++++++
 include/linux/module.h            | 14 +++---
 kernel/module.c                   | 53 +++++++++-----------
 7 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a8ee573fe610..db8a1ef6bfaf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -484,6 +484,7 @@ config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
 	select NONSTATIC_KERNEL
+	select MODULE_REL_CRCS if MODVERSIONS
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at. For ppc32, there is no any
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index cc12c61ef315..53885512b8d3 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -90,9 +90,5 @@ static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sec
 }
 #endif
 
-#if defined(CONFIG_MODVERSIONS) && defined(CONFIG_PPC64)
-#define ARCH_RELOCATES_KCRCTAB
-#define reloc_start PHYSICAL_START
-#endif
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_MODULE_H */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index bb1807184bad..0b0f89685b67 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -286,14 +286,6 @@ static void dedotify_versions(struct modversion_info *vers,
 	for (end = (void *)vers + size; vers < end; vers++)
 		if (vers->name[0] == '.') {
 			memmove(vers->name, vers->name+1, strlen(vers->name));
-#ifdef ARCH_RELOCATES_KCRCTAB
-			/* The TOC symbol has no CRC computed. To avoid CRC
-			 * check failing, we must force it to the expected
-			 * value (see CRC check in module.c).
-			 */
-			if (!strcmp(vers->name, "TOC."))
-				vers->crc = -(unsigned long)reloc_start;
-#endif
 		}
 }
 
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 63554e9f6e0c..719db1968d81 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -9,18 +9,15 @@
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 8
 #endif
-#ifndef KCRC_ALIGN
-#define KCRC_ALIGN 8
-#endif
 #else
 #define __put .long
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
+#endif
 #ifndef KCRC_ALIGN
 #define KCRC_ALIGN 4
 #endif
-#endif
 
 #ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
 #define KSYM(name) _##name
@@ -52,7 +49,11 @@ KSYM(__kstrtab_\name):
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
 KSYM(__kcrctab_\name):
-	__put KSYM(__crc_\name)
+#if defined(CONFIG_MODULE_REL_CRCS)
+	.long KSYM(__crc_\name) - .
+#else
+	.long KSYM(__crc_\name)
+#endif
 	.weak KSYM(__crc_\name)
 	.previous
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index 2a0f61fbc731..7473fba6a60c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -43,6 +43,13 @@ extern struct module __this_module;
 #ifdef CONFIG_MODVERSIONS
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
+#if defined(CONFIG_MODULE_REL_CRCS)
+#define __CRC_SYMBOL(sym, sec)						\
+	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
+	    "	.previous					\n");
+#elif !defined(CONFIG_64BIT)
 #define __CRC_SYMBOL(sym, sec)						\
 	extern __visible void *__crc_##sym __attribute__((weak));	\
 	static const unsigned long __kcrctab_##sym			\
@@ -50,6 +57,13 @@ extern struct module __this_module;
 	__attribute__((section("___kcrctab" sec "+" #sym), used))	\
 	= (unsigned long) &__crc_##sym;
 #else
+#define __CRC_SYMBOL(sym, sec)						\
+	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.previous					\n");
+#endif
+#else
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 7c84273d60b9..cc7cba219b20 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -346,7 +346,7 @@ struct module {
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
+	const s32 *crcs;
 	unsigned int num_syms;
 
 	/* Kernel parameters. */
@@ -359,18 +359,18 @@ struct module {
 	/* GPL-only exported symbols. */
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
-	const unsigned long *gpl_crcs;
+	const s32 *gpl_crcs;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
 	const struct kernel_symbol *unused_syms;
-	const unsigned long *unused_crcs;
+	const s32 *unused_crcs;
 	unsigned int num_unused_syms;
 
 	/* GPL-only, unused exported symbols. */
 	unsigned int num_unused_gpl_syms;
 	const struct kernel_symbol *unused_gpl_syms;
-	const unsigned long *unused_gpl_crcs;
+	const s32 *unused_gpl_crcs;
 #endif
 
 #ifdef CONFIG_MODULE_SIG
@@ -382,7 +382,7 @@ struct module {
 
 	/* symbols that will be GPL-only in the near future. */
 	const struct kernel_symbol *gpl_future_syms;
-	const unsigned long *gpl_future_crcs;
+	const s32 *gpl_future_crcs;
 	unsigned int num_gpl_future_syms;
 
 	/* Exception table */
@@ -523,7 +523,7 @@ struct module *find_module(const char *name);
 
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
-	const unsigned long *crcs;
+	const s32 *crcs;
 	enum {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
@@ -539,7 +539,7 @@ struct symsearch {
  */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const s32 **crc,
 					bool gplok,
 					bool warn);
 
diff --git a/kernel/module.c b/kernel/module.c
index 5088784c0cf9..9f9e31f015ba 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -389,16 +389,16 @@ extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __start___kcrctab_gpl_future[];
+extern const s32 __start___kcrctab[];
+extern const s32 __start___kcrctab_gpl[];
+extern const s32 __start___kcrctab_gpl_future[];
 #ifdef CONFIG_UNUSED_SYMBOLS
 extern const struct kernel_symbol __start___ksymtab_unused[];
 extern const struct kernel_symbol __stop___ksymtab_unused[];
 extern const struct kernel_symbol __start___ksymtab_unused_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_unused_gpl[];
-extern const unsigned long __start___kcrctab_unused[];
-extern const unsigned long __start___kcrctab_unused_gpl[];
+extern const s32 __start___kcrctab_unused[];
+extern const s32 __start___kcrctab_unused_gpl[];
 #endif
 
 #ifndef CONFIG_MODVERSIONS
@@ -497,7 +497,7 @@ struct find_symbol_arg {
 
 	/* Output */
 	struct module *owner;
-	const unsigned long *crc;
+	const s32 *crc;
 	const struct kernel_symbol *sym;
 };
 
@@ -563,7 +563,7 @@ static bool find_symbol_in_section(const struct symsearch *syms,
  * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const s32 **crc,
 					bool gplok,
 					bool warn)
 {
@@ -1249,23 +1249,17 @@ static int try_to_force_load(struct module *mod, const char *reason)
 }
 
 #ifdef CONFIG_MODVERSIONS
-/* If the arch applies (non-zero) relocations to kernel kcrctab, unapply it. */
-static unsigned long maybe_relocated(unsigned long crc,
-				     const struct module *crc_owner)
+
+static u32 resolve_rel_crc(const s32 *crc)
 {
-#ifdef ARCH_RELOCATES_KCRCTAB
-	if (crc_owner == NULL)
-		return crc - (unsigned long)reloc_start;
-#endif
-	return crc;
+	return *(u32 *)((void *)crc + *crc);
 }
 
 static int check_version(Elf_Shdr *sechdrs,
 			 unsigned int versindex,
 			 const char *symname,
 			 struct module *mod,
-			 const unsigned long *crc,
-			 const struct module *crc_owner)
+			 const s32 *crc)
 {
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
@@ -1283,13 +1277,19 @@ static int check_version(Elf_Shdr *sechdrs,
 		/ sizeof(struct modversion_info);
 
 	for (i = 0; i < num_versions; i++) {
+		u32 crcval;
+
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == maybe_relocated(*crc, crc_owner))
+		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
+			crcval = resolve_rel_crc(crc);
+		else
+			crcval = *crc;
+		if (versions[i].crc == crcval)
 			return 1;
-		pr_debug("Found checksum %lX vs module %lX\n",
-		       maybe_relocated(*crc, crc_owner), versions[i].crc);
+		pr_debug("Found checksum %X vs module %lX\n",
+			 crcval, versions[i].crc);
 		goto bad_version;
 	}
 
@@ -1307,7 +1307,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 					  unsigned int versindex,
 					  struct module *mod)
 {
-	const unsigned long *crc;
+	const s32 *crc;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
@@ -1321,8 +1321,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 	}
 	preempt_enable();
 	return check_version(sechdrs, versindex,
-			     VMLINUX_SYMBOL_STR(module_layout), mod, crc,
-			     NULL);
+			     VMLINUX_SYMBOL_STR(module_layout), mod, crc);
 }
 
 /* First part is kernel version, which we ignore if module has crcs. */
@@ -1340,8 +1339,7 @@ static inline int check_version(Elf_Shdr *sechdrs,
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod,
-				const unsigned long *crc,
-				const struct module *crc_owner)
+				const s32 *crc)
 {
 	return 1;
 }
@@ -1368,7 +1366,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 {
 	struct module *owner;
 	const struct kernel_symbol *sym;
-	const unsigned long *crc;
+	const s32 *crc;
 	int err;
 
 	/*
@@ -1383,8 +1381,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (!sym)
 		goto unlock;
 
-	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc,
-			   owner)) {
+	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc)) {
 		sym = ERR_PTR(-EINVAL);
 		goto getname;
 	}
-- 
2.7.4
