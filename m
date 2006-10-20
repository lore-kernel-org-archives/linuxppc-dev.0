Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3480067BE1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:47:48 +1000 (EST)
Subject: [PATCH 4/5] powerpc: Support feature fixups in modules
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:47:19 +1000
Message-Id: <1161308839.10524.111.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for feature fixups in modules. This involves
adding support for R_PPC64_REL64 relocs to the 64 bits module loader.
It also modifies modpost.c to ignore the powerpc fixup sections (or it
would warn when used in .init.text).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Index: linux-cell/arch/powerpc/kernel/module_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/module_32.c	2006-10-13 16:00:26.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/module_32.c	2006-10-13 16:59:36.000000000 +1000
@@ -24,6 +24,8 @@
 #include <linux/kernel.h>
 #include <linux/cache.h>
 
+#include "setup.h"
+
 #if 0
 #define DEBUGP printk
 #else
@@ -269,33 +271,50 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return 0;
 }
 
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
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	char *secstrings;
-	unsigned int i;
+	const Elf_Shdr *sect;
 
 	me->arch.bug_table = NULL;
 	me->arch.num_bugs = 0;
 
 	/* Find the __bug_table section, if present */
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
-			continue;
-		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
-		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
-		break;
+	sect = find_section(hdr, sechdrs, "__bug_table");
+	if (sect != NULL) {
+		me->arch.bug_table = (void *) sect->sh_addr;
+		me->arch.num_bugs = sect->sh_size / sizeof(struct bug_entry);
 	}
 
-	/*
+ 	/*
 	 * Strictly speaking this should have a spinlock to protect against
 	 * traversals, but since we only traverse on BUG()s, a spinlock
 	 * could potentially lead to deadlock and thus be counter-productive.
 	 */
 	list_add(&me->arch.bug_list, &module_bug_list);
 
+	/* Apply feature fixups */
+	sect = find_section(hdr, sechdrs, "__ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
 	return 0;
 }
 
Index: linux-cell/arch/powerpc/kernel/module_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/module_64.c	2006-10-13 16:00:26.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/module_64.c	2006-10-13 16:59:36.000000000 +1000
@@ -22,6 +22,9 @@
 #include <linux/vmalloc.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
+#include <asm/firmware.h>
+
+#include "setup.h"
 
 /* FIXME: We don't do .init separately.  To do this, we'd need to have
    a separate r2 value in the init and core section, and stub between
@@ -400,6 +403,11 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				| (value & 0x03fffffc);
 			break;
 
+		case R_PPC64_REL64:
+			/* 64 bits relative (used by features fixups) */
+			*location = value - (unsigned long)location;
+			break;
+
 		default:
 			printk("%s: Unknown ADD relocation: %lu\n",
 			       me->name,
@@ -413,23 +421,33 @@ int apply_relocate_add(Elf64_Shdr *sechd
 
 LIST_HEAD(module_bug_list);
 
-int module_finalize(const Elf_Ehdr *hdr,
-		const Elf_Shdr *sechdrs, struct module *me)
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
+				    const Elf_Shdr *sechdrs,
+				    const char *name)
 {
 	char *secstrings;
 	unsigned int i;
 
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
+
 	me->arch.bug_table = NULL;
 	me->arch.num_bugs = 0;
 
 	/* Find the __bug_table section, if present */
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
-			continue;
-		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
-		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
-		break;
+	sect = find_section(hdr, sechdrs, "__bug_table");
+	if (sect != NULL) {
+		me->arch.bug_table = (void *) sect->sh_addr;
+		me->arch.num_bugs = sect->sh_size / sizeof(struct bug_entry);
 	}
 
 	/*
@@ -439,6 +457,19 @@ int module_finalize(const Elf_Ehdr *hdr,
 	 */
 	list_add(&me->arch.bug_list, &module_bug_list);
 
+	/* Apply feature fixups */
+	sect = find_section(hdr, sechdrs, "__ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
+	sect = find_section(hdr, sechdrs, "__fw_ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(powerpc_firmware_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
 	return 0;
 }
 
Index: linux-cell/scripts/mod/modpost.c
===================================================================
--- linux-cell.orig/scripts/mod/modpost.c	2006-10-06 13:48:29.000000000 +1000
+++ linux-cell/scripts/mod/modpost.c	2006-10-13 17:19:55.000000000 +1000
@@ -921,6 +921,8 @@ static int init_section_ref_ok(const cha
 		".fixup",
 		".smp_locks",
 		".plt",  /* seen on ARCH=um build on x86_64. Harmless */
+		"__ftr_fixup",		/* powerpc cpu feature fixup */
+		"__fw_ftr_fixup",	/* powerpc firmware feature fixup */
 		NULL
 	};
 	/* Start of section names */
