Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFBzZ2MBczDqCl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 20:54:34 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id v77so19569197wmv.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 01:54:34 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jeyu@redhat.com, rusty@rustcorp.com.au, mmarek@suse.com, mpe@ellerman.id.au
Cc: torvalds@linux-foundation.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 1/3] kbuild: modversions: add infrastructure for emitting
 relative CRCs
Date: Fri,  3 Feb 2017 09:54:05 +0000
Message-Id: <1486115647-27680-2-git-send-email-ard.biesheuvel@linaro.org>
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

This add the kbuild infrastructure that will allow architectures to emit
vmlinux symbol CRCs as 32-bit offsets to another location in the kernel
where the actual value is stored. This works around problems with CRCs
being mistaken for relocatable symbols on kernels that self relocate at
runtime (i.e., powerpc with CONFIG_RELOCATABLE=y)

For the kbuild side of things, this comes down to the following:
- introducing a Kconfig symbol MODULE_REL_CRCS
- adding a -R switch to genksyms to instruct it to emit the CRC symbols
  as references into the .rodata section
- making modpost distinguish such references from absolute CRC symbols by
  the section index (SHN_ABS)
- making kallsyms disregard non-absolute symbols with a __crc_ prefix

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 init/Kconfig                |  4 ++++
 scripts/Makefile.build      |  2 ++
 scripts/genksyms/genksyms.c | 19 ++++++++++++++-----
 scripts/kallsyms.c          | 12 ++++++++++++
 scripts/mod/modpost.c       | 10 ++++++++++
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index e1a937348a3e..4dd8bd232a1d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1987,6 +1987,10 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+config MODULE_REL_CRCS
+	bool
+	depends on MODVERSIONS
+
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index eadcd4d359d9..d883116ebaa4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -164,6 +164,7 @@ cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
+     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
 
@@ -337,6 +338,7 @@ cmd_gensymtypes_S =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
+     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
 
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 06121ce524a7..c9235d8340f1 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -44,7 +44,7 @@ char *cur_filename, *source_file;
 int in_source_file;
 
 static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
-	   flag_preserve, flag_warnings;
+	   flag_preserve, flag_warnings, flag_rel_crcs;
 static const char *mod_prefix = "";
 
 static int errors;
@@ -693,7 +693,10 @@ void export_symbol(const char *name)
 			fputs(">\n", debugfile);
 
 		/* Used as a linker script. */
-		printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
+		printf(!flag_rel_crcs ? "%s__crc_%s = 0x%08lx;\n" :
+		       "SECTIONS { .rodata : ALIGN(4) { "
+		       "%s__crc_%s = .; LONG(0x%08lx); } }\n",
+		       mod_prefix, name, crc);
 	}
 }
 
@@ -730,7 +733,7 @@ void error_with_pos(const char *fmt, ...)
 
 static void genksyms_usage(void)
 {
-	fputs("Usage:\n" "genksyms [-adDTwqhV] > /path/to/.tmp_obj.ver\n" "\n"
+	fputs("Usage:\n" "genksyms [-adDTwqhVR] > /path/to/.tmp_obj.ver\n" "\n"
 #ifdef __GNU_LIBRARY__
 	      "  -s, --symbol-prefix   Select symbol prefix\n"
 	      "  -d, --debug           Increment the debug level (repeatable)\n"
@@ -742,6 +745,7 @@ static void genksyms_usage(void)
 	      "  -q, --quiet           Disable warnings (default)\n"
 	      "  -h, --help            Print this message\n"
 	      "  -V, --version         Print the release version\n"
+	      "  -R, --relative-crc    Emit section relative symbol CRCs\n"
 #else				/* __GNU_LIBRARY__ */
 	      "  -s                    Select symbol prefix\n"
 	      "  -d                    Increment the debug level (repeatable)\n"
@@ -753,6 +757,7 @@ static void genksyms_usage(void)
 	      "  -q                    Disable warnings (default)\n"
 	      "  -h                    Print this message\n"
 	      "  -V                    Print the release version\n"
+	      "  -R                    Emit section relative symbol CRCs\n"
 #endif				/* __GNU_LIBRARY__ */
 	      , stderr);
 }
@@ -774,13 +779,14 @@ int main(int argc, char **argv)
 		{"preserve", 0, 0, 'p'},
 		{"version", 0, 0, 'V'},
 		{"help", 0, 0, 'h'},
+		{"relative-crc", 0, 0, 'R'},
 		{0, 0, 0, 0}
 	};
 
-	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:ph",
+	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:phR",
 				&long_opts[0], NULL)) != EOF)
 #else				/* __GNU_LIBRARY__ */
-	while ((o = getopt(argc, argv, "s:dwqVDr:T:ph")) != EOF)
+	while ((o = getopt(argc, argv, "s:dwqVDr:T:phR")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
 		case 's':
@@ -823,6 +829,9 @@ int main(int argc, char **argv)
 		case 'h':
 			genksyms_usage();
 			return 0;
+		case 'R':
+			flag_rel_crcs = 1;
+			break;
 		default:
 			genksyms_usage();
 			return 1;
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
index 29c89a6bad3d..4dedd0d3d3a7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -621,6 +621,16 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
 		is_crc = true;
 		crc = (unsigned int) sym->st_value;
+		if (sym->st_shndx != SHN_UNDEF && sym->st_shndx != SHN_ABS) {
+			unsigned int *crcp;
+
+			/* symbol points to the CRC in the ELF object */
+			crcp = (void *)info->hdr + sym->st_value +
+			       info->sechdrs[sym->st_shndx].sh_offset -
+			       (info->hdr->e_type != ET_REL ?
+				info->sechdrs[sym->st_shndx].sh_addr : 0);
+			crc = *crcp;
+		}
 		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
 				export);
 	}
-- 
2.7.4
