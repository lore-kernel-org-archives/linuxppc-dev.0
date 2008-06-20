Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CAF5DDFA6
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 02:31:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5KGV1LA025925
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:31:02 -0500
Date: Fri, 20 Jun 2008 11:31:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Move common module code into its own file
Message-ID: <Pine.LNX.4.64.0806201130280.17834@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactor common code between ppc32 and ppc64 module handling into a
shared filed.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/module.c    |  110 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/module_32.c |   72 -------------------------
 arch/powerpc/kernel/module_64.c |   78 ---------------------------
 4 files changed, 111 insertions(+), 151 deletions(-)
 create mode 100644 arch/powerpc/kernel/module.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0e8f928..9ebeb24 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
 				   swsusp_$(CONFIG_WORD_SIZE).o
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
-obj-$(CONFIG_MODULES)		+= module_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o

 ifeq ($(CONFIG_PPC_MERGE),y)
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
new file mode 100644
index 0000000..40dd52d
--- /dev/null
+++ b/arch/powerpc/kernel/module.c
@@ -0,0 +1,110 @@
+/*  Kernel module help for powerpc.
+    Copyright (C) 2001, 2003 Rusty Russell IBM Corporation.
+    Copyright (C) 2008 Freescale Semiconductor, Inc.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+#include <linux/module.h>
+#include <linux/elf.h>
+#include <linux/moduleloader.h>
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+#include <linux/bug.h>
+#include <asm/module.h>
+#include <asm/uaccess.h>
+#include <asm/firmware.h>
+#include <linux/sort.h>
+
+#include "setup.h"
+
+LIST_HEAD(module_bug_list);
+
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+
+	return vmalloc_exec(size);
+}
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
+				    const Elf_Shdr *sechdrs,
+				    const char *name)
+{
+	char *secstrings;
+	unsigned int i;
+
+	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	for (i = 1; i < hdr->e_shnum; i++)
+		if (strcmp(secstrings+sechdrs[i].sh_name, name) == 0)
+			return &sechdrs[i];
+	return NULL;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		const Elf_Shdr *sechdrs, struct module *me)
+{
+	const Elf_Shdr *sect;
+	int err;
+
+	err = module_bug_finalize(hdr, sechdrs, me);
+	if (err)
+		return err;
+
+	/* Apply feature fixups */
+	sect = find_section(hdr, sechdrs, "__ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
+#ifdef CONFIG_PPC64
+	sect = find_section(hdr, sechdrs, "__fw_ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(powerpc_firmware_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+#endif
+
+	return 0;
+}
+
+void module_arch_cleanup(struct module *mod)
+{
+	module_bug_cleanup(mod);
+}
+
+struct bug_entry *module_find_bug(unsigned long bugaddr)
+{
+	struct mod_arch_specific *mod;
+	unsigned int i;
+	struct bug_entry *bug;
+
+	list_for_each_entry(mod, &module_bug_list, bug_list) {
+		bug = mod->bug_table;
+		for (i = 0; i < mod->num_bugs; ++i, ++bug)
+			if (bugaddr == bug->bug_addr)
+				return bug;
+	}
+	return NULL;
+}
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index eab3138..2df91a0 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -34,23 +34,6 @@
 #define DEBUGP(fmt , ...)
 #endif

-LIST_HEAD(module_bug_list);
-
-void *module_alloc(unsigned long size)
-{
-	if (size == 0)
-		return NULL;
-	return vmalloc(size);
-}
-
-/* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
-{
-	vfree(module_region);
-	/* FIXME: If module_region == mod->init_region, trim exception
-           table entries. */
-}
-
 /* Count how many different relocations (different symbol, different
    addend) */
 static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
@@ -325,58 +308,3 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 	}
 	return 0;
 }
-
-static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
-				    const Elf_Shdr *sechdrs,
-				    const char *name)
-{
-	char *secstrings;
-	unsigned int i;
-
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++)
-		if (strcmp(secstrings+sechdrs[i].sh_name, name) == 0)
-			return &sechdrs[i];
-	return NULL;
-}
-
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
-{
-	const Elf_Shdr *sect;
-	int err;
-
-	err = module_bug_finalize(hdr, sechdrs, me);
-	if (err)		/* never true, currently */
-		return err;
-
-	/* Apply feature fixups */
-	sect = find_section(hdr, sechdrs, "__ftr_fixup");
-	if (sect != NULL)
-		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  (void *)sect->sh_addr,
-				  (void *)sect->sh_addr + sect->sh_size);
-
-	return 0;
-}
-
-void module_arch_cleanup(struct module *mod)
-{
-	module_bug_cleanup(mod);
-}
-
-struct bug_entry *module_find_bug(unsigned long bugaddr)
-{
-	struct mod_arch_specific *mod;
-	unsigned int i;
-	struct bug_entry *bug;
-
-	list_for_each_entry(mod, &module_bug_list, bug_list) {
-		bug = mod->bug_table;
-		for (i = 0; i < mod->num_bugs; ++i, ++bug)
-			if (bugaddr == bug->bug_addr)
-				return bug;
-	}
-	return NULL;
-}
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 3a82b02..4803f2d 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -101,22 +101,6 @@ static unsigned int count_relocs(const Elf64_Rela *rela, unsigned int num)
 	return _count_relocs;
 }

-void *module_alloc(unsigned long size)
-{
-	if (size == 0)
-		return NULL;
-
-	return vmalloc_exec(size);
-}
-
-/* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
-{
-	vfree(module_region);
-	/* FIXME: If module_region == mod->init_region, trim exception
-           table entries. */
-}
-
 static int relacmp(const void *_x, const void *_y)
 {
 	const Elf64_Rela *x, *y;
@@ -466,65 +450,3 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,

 	return 0;
 }
-
-LIST_HEAD(module_bug_list);
-
-static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
-				    const Elf_Shdr *sechdrs,
-				    const char *name)
-{
-	char *secstrings;
-	unsigned int i;
-
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++)
-		if (strcmp(secstrings+sechdrs[i].sh_name, name) == 0)
-			return &sechdrs[i];
-	return NULL;
-}
-
-int module_finalize(const Elf_Ehdr *hdr,
-		const Elf_Shdr *sechdrs, struct module *me)
-{
-	const Elf_Shdr *sect;
-	int err;
-
-	err = module_bug_finalize(hdr, sechdrs, me);
-	if (err)
-		return err;
-
-	/* Apply feature fixups */
-	sect = find_section(hdr, sechdrs, "__ftr_fixup");
-	if (sect != NULL)
-		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  (void *)sect->sh_addr,
-				  (void *)sect->sh_addr + sect->sh_size);
-
-	sect = find_section(hdr, sechdrs, "__fw_ftr_fixup");
-	if (sect != NULL)
-		do_feature_fixups(powerpc_firmware_features,
-				  (void *)sect->sh_addr,
-				  (void *)sect->sh_addr + sect->sh_size);
-
-	return 0;
-}
-
-void module_arch_cleanup(struct module *mod)
-{
-	module_bug_cleanup(mod);
-}
-
-struct bug_entry *module_find_bug(unsigned long bugaddr)
-{
-	struct mod_arch_specific *mod;
-	unsigned int i;
-	struct bug_entry *bug;
-
-	list_for_each_entry(mod, &module_bug_list, bug_list) {
-		bug = mod->bug_table;
-		for (i = 0; i < mod->num_bugs; ++i, ++bug)
-			if (bugaddr == bug->bug_addr)
-				return bug;
-	}
-	return NULL;
-}
-- 
1.5.5.1
