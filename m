Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v30TT0WkMzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 06:26:37 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id r126so215163440wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 11:26:36 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	jeyu@redhat.com
Cc: rusty@rustcorp.com.au, suzuki.poulose@arm.com, will.deacon@arm.com,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 arnd@arndb.de, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 3/3] modversions: treat symbol CRCs as 32 bit quantities on
 64 bit archs
Date: Tue, 17 Jan 2017 19:26:13 +0000
Message-Id: <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
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
emitted as runtime relocatable quantities, even if the value resolves to
a build time constant. However, these can easily be distinguished from
variables that do need fixing up, and the CRCs can be emitted correctly
in the arch specific runtime relocation routines right off the bat.

So redefine all CRC fields and variables as u32, and redefine the
__CRC_SYMBOL() macro for 64 bit builds to emit the CRC reference using
inline assembler (which is necessary since 64-bit C code cannot use
32-bit types to hold memory addresses, even if they are ultimately
resolved using values that do not exceed 0xffffffff.

Note that this mostly reverts commit d4703aefdbc8 ("module: handle ppc64
relocating kcrctabs when CONFIG_RELOCATABLE=y")

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ----
 include/asm-generic/export.h      |  7 +--
 include/linux/export.h            |  8 ++++
 include/linux/module.h            | 14 +++---
 kernel/module.c                   | 47 +++++++-------------
 6 files changed, 33 insertions(+), 55 deletions(-)

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
index 63554e9f6e0c..e3508a3d6e53 100644
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
+	.long KSYM(__crc_\name)
 	.weak KSYM(__crc_\name)
 	.previous
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index 2a0f61fbc731..a000d421526d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -41,6 +41,7 @@ extern struct module __this_module;
 
 #if defined(__KERNEL__) && !defined(__GENKSYMS__)
 #ifdef CONFIG_MODVERSIONS
+#ifndef CONFIG_64BIT
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
 #define __CRC_SYMBOL(sym, sec)						\
@@ -50,6 +51,13 @@ extern struct module __this_module;
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
index 7c84273d60b9..4b65b9df3de2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -346,7 +346,7 @@ struct module {
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
+	const u32 *crcs;
 	unsigned int num_syms;
 
 	/* Kernel parameters. */
@@ -359,18 +359,18 @@ struct module {
 	/* GPL-only exported symbols. */
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
-	const unsigned long *gpl_crcs;
+	const u32 *gpl_crcs;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
 	const struct kernel_symbol *unused_syms;
-	const unsigned long *unused_crcs;
+	const u32 *unused_crcs;
 	unsigned int num_unused_syms;
 
 	/* GPL-only, unused exported symbols. */
 	unsigned int num_unused_gpl_syms;
 	const struct kernel_symbol *unused_gpl_syms;
-	const unsigned long *unused_gpl_crcs;
+	const u32 *unused_gpl_crcs;
 #endif
 
 #ifdef CONFIG_MODULE_SIG
@@ -382,7 +382,7 @@ struct module {
 
 	/* symbols that will be GPL-only in the near future. */
 	const struct kernel_symbol *gpl_future_syms;
-	const unsigned long *gpl_future_crcs;
+	const u32 *gpl_future_crcs;
 	unsigned int num_gpl_future_syms;
 
 	/* Exception table */
@@ -523,7 +523,7 @@ struct module *find_module(const char *name);
 
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
-	const unsigned long *crcs;
+	const u32 *crcs;
 	enum {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
@@ -539,7 +539,7 @@ struct symsearch {
  */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const u32 **crc,
 					bool gplok,
 					bool warn);
 
diff --git a/kernel/module.c b/kernel/module.c
index 5088784c0cf9..43d1478975a1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -389,16 +389,16 @@ extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __start___kcrctab_gpl_future[];
+extern const u32 __start___kcrctab[];
+extern const u32 __start___kcrctab_gpl[];
+extern const u32 __start___kcrctab_gpl_future[];
 #ifdef CONFIG_UNUSED_SYMBOLS
 extern const struct kernel_symbol __start___ksymtab_unused[];
 extern const struct kernel_symbol __stop___ksymtab_unused[];
 extern const struct kernel_symbol __start___ksymtab_unused_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_unused_gpl[];
-extern const unsigned long __start___kcrctab_unused[];
-extern const unsigned long __start___kcrctab_unused_gpl[];
+extern const u32 __start___kcrctab_unused[];
+extern const u32 __start___kcrctab_unused_gpl[];
 #endif
 
 #ifndef CONFIG_MODVERSIONS
@@ -497,7 +497,7 @@ struct find_symbol_arg {
 
 	/* Output */
 	struct module *owner;
-	const unsigned long *crc;
+	const u32 *crc;
 	const struct kernel_symbol *sym;
 };
 
@@ -563,7 +563,7 @@ static bool find_symbol_in_section(const struct symsearch *syms,
  * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const u32 **crc,
 					bool gplok,
 					bool warn)
 {
@@ -1249,23 +1249,11 @@ static int try_to_force_load(struct module *mod, const char *reason)
 }
 
 #ifdef CONFIG_MODVERSIONS
-/* If the arch applies (non-zero) relocations to kernel kcrctab, unapply it. */
-static unsigned long maybe_relocated(unsigned long crc,
-				     const struct module *crc_owner)
-{
-#ifdef ARCH_RELOCATES_KCRCTAB
-	if (crc_owner == NULL)
-		return crc - (unsigned long)reloc_start;
-#endif
-	return crc;
-}
-
 static int check_version(Elf_Shdr *sechdrs,
 			 unsigned int versindex,
 			 const char *symname,
 			 struct module *mod,
-			 const unsigned long *crc,
-			 const struct module *crc_owner)
+			 const u32 *crc)
 {
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
@@ -1286,10 +1274,10 @@ static int check_version(Elf_Shdr *sechdrs,
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == maybe_relocated(*crc, crc_owner))
+		if (versions[i].crc == *crc)
 			return 1;
-		pr_debug("Found checksum %lX vs module %lX\n",
-		       maybe_relocated(*crc, crc_owner), versions[i].crc);
+		pr_debug("Found checksum %X vs module %lX\n",
+		       *crc, versions[i].crc);
 		goto bad_version;
 	}
 
@@ -1307,7 +1295,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 					  unsigned int versindex,
 					  struct module *mod)
 {
-	const unsigned long *crc;
+	const u32 *crc;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
@@ -1321,8 +1309,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 	}
 	preempt_enable();
 	return check_version(sechdrs, versindex,
-			     VMLINUX_SYMBOL_STR(module_layout), mod, crc,
-			     NULL);
+			     VMLINUX_SYMBOL_STR(module_layout), mod, crc);
 }
 
 /* First part is kernel version, which we ignore if module has crcs. */
@@ -1340,8 +1327,7 @@ static inline int check_version(Elf_Shdr *sechdrs,
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod,
-				const unsigned long *crc,
-				const struct module *crc_owner)
+				const u32 *crc)
 {
 	return 1;
 }
@@ -1368,7 +1354,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 {
 	struct module *owner;
 	const struct kernel_symbol *sym;
-	const unsigned long *crc;
+	const u32 *crc;
 	int err;
 
 	/*
@@ -1383,8 +1369,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
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
