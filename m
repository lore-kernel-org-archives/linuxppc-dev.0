Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v42Xc0D4JzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 23:02:56 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id r126so286494853wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 04:02:55 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, arnd@arndb.de, rusty@rustcorp.com.au,
 jeyu@redhat.com, mpe@ellerman.id.au, viro@zeniv.linux.org.uk,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH v2] modversions: redefine kcrctab entries as relative CRC
 pointers
Date: Thu, 19 Jan 2017 12:02:45 +0000
Message-Id: <1484827365-8515-1-git-send-email-ard.biesheuvel@linaro.org>
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
- On architectures that support runtime relocation, a R_<arch>_RELATIVE
  relocation entry is emitted for each CRC value, which identifies it as
  a quantity that requires fixing up based on the actual runtime load
  offset of the kernel. This results in corrupted CRCs unless we
  explicitly undo the fixup (and this is currently being handled in the
  core module code),
- On 64 bit architectures, such runtime relocation entries take up 24
  bytes of __init space each, resulting in a x8 overhead in [uncompressed]
  kernel size for CRCs,
- The use of ELF symbols to represent things other than virtual addresses
  is poorly supported (and mostly untested) in GNU binutils.

So avoid these issues by redefining the kcrctab entries as signed relative
offsets pointing to the actual CRC value stored elsewhere in the kernel
image (or in the module). This removes all the ELF hackery involving
symbols and relocations, at the expense of 4 additional bytes of space per
CRC on 32-bit architectures. (On 64-bit architectures, each 8 byte CRC
symbol reference is replaced by a 4 byte relative offset and the 4 byte
CRC value elsewhere in the image)

Note that this mostly reverts commit d4703aefdbc8 ("module: handle ppc64
relocating kcrctabs when CONFIG_RELOCATABLE=y")

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: update modpost as well, so that genksyms no longer has to emit symbols
    for both the actual CRC value and the reference to where it is stored
    in the image

 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ----
 include/asm-generic/export.h      |  7 +--
 include/linux/export.h            |  9 ++--
 include/linux/module.h            | 14 +++---
 kernel/module.c                   | 50 +++++++++-----------
 scripts/genksyms/genksyms.c       |  4 +-
 scripts/kallsyms.c                | 12 +++++
 scripts/mod/modpost.c             |  9 +++-
 9 files changed, 58 insertions(+), 59 deletions(-)

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
index 63554e9f6e0c..ce63ea1a60c2 100644
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
@@ -52,7 +49,7 @@ KSYM(__kstrtab_\name):
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
 KSYM(__kcrctab_\name):
-	__put KSYM(__crc_\name)
+	.long KSYM(__crc_\name) - .
 	.weak KSYM(__crc_\name)
 	.previous
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index 2a0f61fbc731..efe0ce1c363a 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -44,11 +44,10 @@ extern struct module __this_module;
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
 #define __CRC_SYMBOL(sym, sec)						\
-	extern __visible void *__crc_##sym __attribute__((weak));	\
-	static const unsigned long __kcrctab_##sym			\
-	__used								\
-	__attribute__((section("___kcrctab" sec "+" #sym), used))	\
-	= (unsigned long) &__crc_##sym;
+	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
+	    "	.previous					\n");
 #else
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
index 5088784c0cf9..b1ede27fb124 100644
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
+static u32 resolve_crc(const s32 *crc)
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
@@ -1283,13 +1277,16 @@ static int check_version(Elf_Shdr *sechdrs,
 		/ sizeof(struct modversion_info);
 
 	for (i = 0; i < num_versions; i++) {
+		u32 crcval;
+
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == maybe_relocated(*crc, crc_owner))
+		crcval = resolve_crc(crc);
+		if (versions[i].crc == crcval)
 			return 1;
-		pr_debug("Found checksum %lX vs module %lX\n",
-		       maybe_relocated(*crc, crc_owner), versions[i].crc);
+		pr_debug("Found checksum %X vs module %lX\n",
+			 crcval, versions[i].crc);
 		goto bad_version;
 	}
 
@@ -1307,7 +1304,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 					  unsigned int versindex,
 					  struct module *mod)
 {
-	const unsigned long *crc;
+	const s32 *crc;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
@@ -1321,8 +1318,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 	}
 	preempt_enable();
 	return check_version(sechdrs, versindex,
-			     VMLINUX_SYMBOL_STR(module_layout), mod, crc,
-			     NULL);
+			     VMLINUX_SYMBOL_STR(module_layout), mod, crc);
 }
 
 /* First part is kernel version, which we ignore if module has crcs. */
@@ -1340,8 +1336,7 @@ static inline int check_version(Elf_Shdr *sechdrs,
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod,
-				const unsigned long *crc,
-				const struct module *crc_owner)
+				const s32 *crc)
 {
 	return 1;
 }
@@ -1368,7 +1363,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 {
 	struct module *owner;
 	const struct kernel_symbol *sym;
-	const unsigned long *crc;
+	const s32 *crc;
 	int err;
 
 	/*
@@ -1383,8 +1378,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (!sym)
 		goto unlock;
 
-	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc,
-			   owner)) {
+	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc)) {
 		sym = ERR_PTR(-EINVAL);
 		goto getname;
 	}
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 06121ce524a7..143a7013f5b8 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -693,7 +693,9 @@ void export_symbol(const char *name)
 			fputs(">\n", debugfile);
 
 		/* Used as a linker script. */
-		printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
+		printf("SECTIONS { .rodata.modver : ALIGN(4) { "
+		       "%s__crc_%s = .; LONG(0x%08lx); } }\n",
+		       mod_prefix, name, crc);
 	}
 }
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 299b92ca1ae0..5d554419170b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -219,6 +219,10 @@ static int symbol_valid(struct sym_entry *s)
 		"_SDA2_BASE_",		/* ppc */
 		NULL };
 
+	static char *special_prefixes[] = {
+		"__crc_",		/* modversions */
+		NULL };
+
 	static char *special_suffixes[] = {
 		"_veneer",		/* arm */
 		"_from_arm",		/* arm */
@@ -259,6 +263,14 @@ static int symbol_valid(struct sym_entry *s)
 		if (strcmp(sym_name, special_symbols[i]) == 0)
 			return 0;
 
+	for (i = 0; special_prefixes[i]; i++) {
+		int l = strlen(special_prefixes[i]);
+
+		if (l <= strlen(sym_name) &&
+		    strncmp(sym_name, special_prefixes[i], l) == 0)
+			return 0;
+	}
+
 	for (i = 0; special_suffixes[i]; i++) {
 		int l = strlen(sym_name) - strlen(special_suffixes[i]);
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29c89a6bad3d..d69f3ceae19e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -619,8 +619,15 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 
 	/* CRC'd symbol */
 	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
+		unsigned int *crcp = NULL;
+
+		if (sym->st_shndx != SHN_UNDEF)
+			crcp = (void *)info->hdr + sym->st_value +
+			       info->sechdrs[sym->st_shndx].sh_offset -
+			       info->sechdrs[sym->st_shndx].sh_addr;
+
 		is_crc = true;
-		crc = (unsigned int) sym->st_value;
+		crc = crcp ? *crcp : 0;
 		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
 				export);
 	}
-- 
2.7.4
