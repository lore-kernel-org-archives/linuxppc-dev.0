Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 15:29:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Move bootwrapper ELF parsing routines to a file
Message-ID: <20070327222950.GB1266@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ELF parsing routines local to arch/powerpc/boot/main.c are useful
to other callers therefore move them to their own file.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

This is needed for some upcoming patches.

 Makefile   |    2 -
 elf.h      |    8 ++++++
 elf_util.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 main.c     |   66 ----------------------------------------------------
 4 files changed, 85 insertions(+), 67 deletions(-)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b1fc029..7665d9e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib)
+		gunzip_util.c elf_util.c $(zlib)
 src-plat := of.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
diff --git a/arch/powerpc/boot/elf.h b/arch/powerpc/boot/elf.h
index d4828fc..1941bc5 100644
--- a/arch/powerpc/boot/elf.h
+++ b/arch/powerpc/boot/elf.h
@@ -146,4 +146,12 @@ typedef struct elf64_phdr {
 #define ELFOSABI_NONE	0
 #define ELFOSABI_LINUX	3
 
+struct elf_info {
+	unsigned long loadsize;
+	unsigned long memsize;
+	unsigned long elfoffset;
+};
+int parse_elf64(void *hdr, struct elf_info *info);
+int parse_elf32(void *hdr, struct elf_info *info);
+
 #endif				/* _PPC_BOOT_ELF_H_ */
diff --git a/arch/powerpc/boot/elf_util.c b/arch/powerpc/boot/elf_util.c
new file mode 100644
index 0000000..7454aa4
--- /dev/null
+++ b/arch/powerpc/boot/elf_util.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * Updates for PPC64 by Todd Inglett, Dave Engebretsen & Peter Bergner.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "elf.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+
+int parse_elf64(void *hdr, struct elf_info *info)
+{
+	Elf64_Ehdr *elf64 = hdr;
+	Elf64_Phdr *elf64ph;
+	unsigned int i;
+
+	if (!(elf64->e_ident[EI_MAG0]  == ELFMAG0	&&
+	      elf64->e_ident[EI_MAG1]  == ELFMAG1	&&
+	      elf64->e_ident[EI_MAG2]  == ELFMAG2	&&
+	      elf64->e_ident[EI_MAG3]  == ELFMAG3	&&
+	      elf64->e_ident[EI_CLASS] == ELFCLASS64	&&
+	      elf64->e_ident[EI_DATA]  == ELFDATA2MSB	&&
+	      elf64->e_type            == ET_EXEC	&&
+	      elf64->e_machine         == EM_PPC64))
+		return 0;
+
+	elf64ph = (Elf64_Phdr *)((unsigned long)elf64 +
+				 (unsigned long)elf64->e_phoff);
+	for (i = 0; i < (unsigned int)elf64->e_phnum; i++, elf64ph++)
+		if (elf64ph->p_type == PT_LOAD)
+			break;
+	if (i >= (unsigned int)elf64->e_phnum)
+		return 0;
+
+	info->loadsize = (unsigned long)elf64ph->p_filesz;
+	info->memsize = (unsigned long)elf64ph->p_memsz;
+	info->elfoffset = (unsigned long)elf64ph->p_offset;
+
+	return 1;
+}
+
+int parse_elf32(void *hdr, struct elf_info *info)
+{
+	Elf32_Ehdr *elf32 = hdr;
+	Elf32_Phdr *elf32ph;
+	unsigned int i;
+
+	if (!(elf32->e_ident[EI_MAG0]  == ELFMAG0	&&
+	      elf32->e_ident[EI_MAG1]  == ELFMAG1	&&
+	      elf32->e_ident[EI_MAG2]  == ELFMAG2	&&
+	      elf32->e_ident[EI_MAG3]  == ELFMAG3	&&
+	      elf32->e_ident[EI_CLASS] == ELFCLASS32	&&
+	      elf32->e_ident[EI_DATA]  == ELFDATA2MSB	&&
+	      elf32->e_type            == ET_EXEC	&&
+	      elf32->e_machine         == EM_PPC))
+		return 0;
+
+	elf32ph = (Elf32_Phdr *) ((unsigned long)elf32 + elf32->e_phoff);
+	for (i = 0; i < elf32->e_phnum; i++, elf32ph++)
+		if (elf32ph->p_type == PT_LOAD)
+			break;
+	if (i >= elf32->e_phnum)
+		return 0;
+
+	info->loadsize = elf32ph->p_filesz;
+	info->memsize = elf32ph->p_memsz;
+	info->elfoffset = elf32ph->p_offset;
+	return 1;
+}
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 8a60e13..59943c5 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -37,76 +37,10 @@ struct addr_range {
 	unsigned long size;
 };
 
-struct elf_info {
-	unsigned long loadsize;
-	unsigned long memsize;
-	unsigned long elfoffset;
-};
-
 typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
 
 #undef DEBUG
 
-static int parse_elf64(void *hdr, struct elf_info *info)
-{
-	Elf64_Ehdr *elf64 = hdr;
-	Elf64_Phdr *elf64ph;
-	unsigned int i;
-
-	if (!(elf64->e_ident[EI_MAG0]  == ELFMAG0	&&
-	      elf64->e_ident[EI_MAG1]  == ELFMAG1	&&
-	      elf64->e_ident[EI_MAG2]  == ELFMAG2	&&
-	      elf64->e_ident[EI_MAG3]  == ELFMAG3	&&
-	      elf64->e_ident[EI_CLASS] == ELFCLASS64	&&
-	      elf64->e_ident[EI_DATA]  == ELFDATA2MSB	&&
-	      elf64->e_type            == ET_EXEC	&&
-	      elf64->e_machine         == EM_PPC64))
-		return 0;
-
-	elf64ph = (Elf64_Phdr *)((unsigned long)elf64 +
-				 (unsigned long)elf64->e_phoff);
-	for (i = 0; i < (unsigned int)elf64->e_phnum; i++, elf64ph++)
-		if (elf64ph->p_type == PT_LOAD)
-			break;
-	if (i >= (unsigned int)elf64->e_phnum)
-		return 0;
-
-	info->loadsize = (unsigned long)elf64ph->p_filesz;
-	info->memsize = (unsigned long)elf64ph->p_memsz;
-	info->elfoffset = (unsigned long)elf64ph->p_offset;
-
-	return 1;
-}
-
-static int parse_elf32(void *hdr, struct elf_info *info)
-{
-	Elf32_Ehdr *elf32 = hdr;
-	Elf32_Phdr *elf32ph;
-	unsigned int i;
-
-	if (!(elf32->e_ident[EI_MAG0]  == ELFMAG0	&&
-	      elf32->e_ident[EI_MAG1]  == ELFMAG1	&&
-	      elf32->e_ident[EI_MAG2]  == ELFMAG2	&&
-	      elf32->e_ident[EI_MAG3]  == ELFMAG3	&&
-	      elf32->e_ident[EI_CLASS] == ELFCLASS32	&&
-	      elf32->e_ident[EI_DATA]  == ELFDATA2MSB	&&
-	      elf32->e_type            == ET_EXEC	&&
-	      elf32->e_machine         == EM_PPC))
-		return 0;
-
-	elf32ph = (Elf32_Phdr *) ((unsigned long)elf32 + elf32->e_phoff);
-	for (i = 0; i < elf32->e_phnum; i++, elf32ph++)
-		if (elf32ph->p_type == PT_LOAD)
-			break;
-	if (i >= elf32->e_phnum)
-		return 0;
-
-	info->loadsize = elf32ph->p_filesz;
-	info->memsize = elf32ph->p_memsz;
-	info->elfoffset = elf32ph->p_offset;
-	return 1;
-}
-
 static struct addr_range prep_kernel(void)
 {
 	char elfheader[256];
