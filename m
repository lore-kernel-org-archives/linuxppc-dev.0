Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45c1YlLzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:52 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so4713563pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:52 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 03/14] powerpc: build-time fixup alternate feature relative
 addresses
Date: Thu, 21 Jul 2016 16:44:02 +1000
Message-Id: <1469083453-9279-4-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement build-time fixup of alternate feature relative addresses for
the out-of-line ("else") patch code. This is done post-link with a new
powerpc build tool that parses relocations and fixup structures, and
adjusts branch instructions.

The "else" part of the feature patching system currently requires the
linker generate correct relative addresses for the linked location. The
the kernel instruction patching code copies instructions delta bytes to
runtime location, and applies negative delta to relative branches as it
does.

This is nice and simple, however the requirement to generate valid
relative addresses at the linked location is constraining:

- Sometimes it can't be done. Particularly in exception handlers
  that have fixed locations, and when both if and else parts of the
  fixup have relative references to the same code. This has caused
  headaches in the exception code, where things have to be juggled
  around until they work.

- It requires patch code to be placed near its destination location,
  despite never being executed in-place. This compounds real estate
  shortage in exception code, and puts this unused code near to
  (likely) performance critical code, which is not ideal.

- Alternate patch code can't be discarded after alt fixups are completed.
  Not a significant problem in practice, but it's tidy to have it, and the
  feature patching stuff is likely to see increased usage in future.

With this change, the relative branch adjustment is done at build, so
patch code branches are correct for their destination location. Kernel
runtime patching just moves the instructions.

__ftr_alt sections get moved out of the main text section and into an init
region, which stops them cluttering the runtime text and allows them to be
discarded at boot time.

Relative branches in the alt sections still need the linker to be happy
otherwise it will fail the link. So the alt sections are made allocatable
and executable, so branch stub trampolines for these branches can be added
for them. The relocation and patching system simply ignores these branch
stubs.

Relocations have to be included in the vmlinux file after linking, so
--emit-relocs is added to the build. XXX: These should be stripped afterwards?

fixup_entry data could be stripped at build time after this change.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                      |  15 +-
 arch/powerpc/include/asm/feature-fixups.h  |   5 +-
 arch/powerpc/kernel/vmlinux.lds.S          |  12 +-
 arch/powerpc/lib/feature-fixups.c          |  19 +-
 arch/powerpc/tools/Makefile                |   3 +
 arch/powerpc/tools/relocs/.gitignore       |   1 +
 arch/powerpc/tools/relocs/Makefile         |   9 +
 arch/powerpc/tools/relocs/code-patching.c  |  82 ++++++
 arch/powerpc/tools/relocs/code-patching.h  |   7 +
 arch/powerpc/tools/relocs/elf_sections.c   | 337 ++++++++++++++++++++++
 arch/powerpc/tools/relocs/elf_sections.h   |  50 ++++
 arch/powerpc/tools/relocs/process_relocs.c | 437 +++++++++++++++++++++++++++++
 12 files changed, 959 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/tools/Makefile
 create mode 100644 arch/powerpc/tools/relocs/.gitignore
 create mode 100644 arch/powerpc/tools/relocs/Makefile
 create mode 100644 arch/powerpc/tools/relocs/code-patching.c
 create mode 100644 arch/powerpc/tools/relocs/code-patching.h
 create mode 100644 arch/powerpc/tools/relocs/elf_sections.c
 create mode 100644 arch/powerpc/tools/relocs/elf_sections.h
 create mode 100644 arch/powerpc/tools/relocs/process_relocs.c

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index d8d30fc..ca82aa2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -99,6 +99,10 @@ endif
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
+# --emit-relocs required for post-link fixup of alternate feature
+# text section relocations.
+LDFLAGS_vmlinux	+= --emit-relocs
+KBUILD_LDFLAGS_MODULE += --emit-relocs
 
 ifeq ($(CONFIG_PPC64),y)
 ifeq ($(call cc-option-yn,-mcmodel=medium),y)
@@ -277,6 +281,16 @@ relocs_check: arch/powerpc/tools/relocs_check.sh vmlinux
 zImage: relocs_check
 endif
 
+CMD_PROCESS_RELOCS = arch/powerpc/tools/relocs/process_relocs
+quiet_cmd_process_relocs = CALL    $@
+      cmd_process_relocs = $(CMD_PROCESS_RELOCS) $(obj)/vmlinux
+PHONY += process_relocs
+process_relocs: vmlinux FORCE
+	$(call if_changed,process_relocs)
+zImage: process_relocs
+
+KBUILD_MODPOST_TOOL := $(CMD_PROCESS_RELOCS)
+
 $(BOOT_TARGETS1): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 $(BOOT_TARGETS2): vmlinux
@@ -419,4 +433,3 @@ checkbin:
 
 
 CLEAN_FILES += $(TOUT)
-
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 9a67a38..160f7b1 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -16,6 +16,9 @@
  * useable with the vdso shared library. There is also an assumption
  * that values will be negative, that is, the fixup table has to be
  * located after the code it fixes up.
+ *
+ * Please ensure that new section names, modifications to FTR_ENTRY
+ * encoding, etc., is handled by arch/powerpc/tools/relocs/ code.
  */
 #if defined(CONFIG_PPC64) && !defined(__powerpc64__)
 /* 64 bits kernel, 32 bits code (ie. vdso32) */
@@ -33,7 +36,7 @@
 
 #define FTR_SECTION_ELSE_NESTED(label)			\
 label##2:						\
-	.pushsection __ftr_alt_##label,"a";		\
+	.pushsection __ftr_alt_##label,"ax";		\
 	.align 2;					\
 label##3:
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2dd91f7..552dcbc 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -49,8 +49,7 @@ SECTIONS
 		ALIGN_FUNCTION();
 		HEAD_TEXT
 		_text = .;
-		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text .fixup .ref.text)
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
@@ -63,7 +62,6 @@ SECTIONS
 		*(.got2)
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
-
 	} :kernel
 
 	. = ALIGN(PAGE_SIZE);
@@ -92,6 +90,10 @@ SECTIONS
 	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE) :kernel
 
+	.__ftr_alternates.text : AT(ADDR(.__ftr_alternates.text) - LOAD_OFFSET) {
+		*(__ftr_alt*);
+	}
+
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
 	 */
@@ -123,6 +125,10 @@ SECTIONS
 
 	SECURITY_INIT
 
+	/*
+	 * The _ftr_fixup sections could be discarded after the relocation
+	 * pass, which would save a few bytes.
+	 */
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 7ce3870..15aeda1 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -44,20 +44,13 @@ static unsigned int *calc_addr(struct fixup_entry *fcur, long offset)
 static int patch_alt_instruction(unsigned int *src, unsigned int *dest,
 				 unsigned int *alt_start, unsigned int *alt_end)
 {
-	unsigned int instr;
+	unsigned int instr = *src;
 
-	instr = *src;
-
-	if (instr_is_relative_branch(*src)) {
-		unsigned int *target = (unsigned int *)branch_target(src);
-
-		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >= alt_end) {
-			instr = translate_branch(dest, src);
-			if (!instr)
-				return 1;
-		}
-	}
+	/*
+	 * We used to translate relative branches here, however we now
+	 * do that by fixing up relocations after link with process_relocs
+	 * tool in arch/powerpc/tools/relocs/
+	 */
 
 	patch_instruction(dest, instr);
 
diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
new file mode 100644
index 0000000..38dbf04
--- /dev/null
+++ b/arch/powerpc/tools/Makefile
@@ -0,0 +1,3 @@
+always		:= $(hostprogs-y) $(hostprogs-m)
+
+subdir-y	+= relocs
diff --git a/arch/powerpc/tools/relocs/.gitignore b/arch/powerpc/tools/relocs/.gitignore
new file mode 100644
index 0000000..5cf4382
--- /dev/null
+++ b/arch/powerpc/tools/relocs/.gitignore
@@ -0,0 +1 @@
+process_relocs
diff --git a/arch/powerpc/tools/relocs/Makefile b/arch/powerpc/tools/relocs/Makefile
new file mode 100644
index 0000000..c843b85
--- /dev/null
+++ b/arch/powerpc/tools/relocs/Makefile
@@ -0,0 +1,9 @@
+HOST_EXTRACFLAGS		+= -Wno-unused-function
+
+hostprogs-y			:= process_relocs
+
+process_relocs-objs		:= process_relocs.o elf_sections.o code-patching.o
+
+always				:= $(hostprogs-y)
+
+HOSTLOADLIBES_process_relocs	+= -lelf
diff --git a/arch/powerpc/tools/relocs/code-patching.c b/arch/powerpc/tools/relocs/code-patching.c
new file mode 100644
index 0000000..db564a0
--- /dev/null
+++ b/arch/powerpc/tools/relocs/code-patching.c
@@ -0,0 +1,82 @@
+/*
+ *  Copyright 2008 Michael Ellerman, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <inttypes.h>
+#include <errno.h>
+#include "code-patching.h"
+
+#define BRANCH_SET_LINK 0x1
+#define BRANCH_ABSOLUTE 0x2
+
+static int set_uncond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target)
+{
+	uint32_t i = *insn;
+	int64_t offset;
+
+	offset = target;
+	if (!(i & BRANCH_ABSOLUTE))
+		offset = offset - addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3)
+		return -EOVERFLOW;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	*insn = 0x48000000 | (i & 0x3) | (offset & 0x03FFFFFC);
+
+	return 0;
+}
+
+static int set_cond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target)
+{
+	uint32_t i = *insn;
+	int64_t offset;
+
+	offset = target;
+	if (!(i & BRANCH_ABSOLUTE))
+		offset = offset - addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x8000 || offset > 0x7FFF || offset & 0x3)
+		return -EOVERFLOW;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	*insn = 0x40000000 | (i & 0x3FF0003) | (offset & 0xFFFC);
+
+	return 0;
+}
+
+static uint32_t branch_opcode(uint32_t instr)
+{
+	return (instr >> 26) & 0x3F;
+}
+
+static int instr_is_branch_iform(uint32_t instr)
+{
+	return branch_opcode(instr) == 18;
+}
+
+static int instr_is_branch_bform(uint32_t instr)
+{
+	return branch_opcode(instr) == 16;
+}
+
+int set_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target)
+{
+	if (instr_is_branch_iform(*insn))
+		return set_uncond_branch_target(insn, addr, target);
+	else if (instr_is_branch_bform(*insn))
+		return set_cond_branch_target(insn, addr, target);
+
+	return -EINVAL;
+}
diff --git a/arch/powerpc/tools/relocs/code-patching.h b/arch/powerpc/tools/relocs/code-patching.h
new file mode 100644
index 0000000..1d3cbbe
--- /dev/null
+++ b/arch/powerpc/tools/relocs/code-patching.h
@@ -0,0 +1,7 @@
+#ifndef __CODE_PATCHING_H__
+#define __CODE_PATCHING_H__
+
+int set_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target);
+
+#endif
diff --git a/arch/powerpc/tools/relocs/elf_sections.c b/arch/powerpc/tools/relocs/elf_sections.c
new file mode 100644
index 0000000..718020d
--- /dev/null
+++ b/arch/powerpc/tools/relocs/elf_sections.c
@@ -0,0 +1,337 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <gelf.h>
+#include <elf.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include "elf_sections.h"
+
+#define dbg_printf(...)
+
+static const char *rel_type_name(unsigned int type)
+{
+	static const char *const type_name[] = {
+#define REL_TYPE(X)[X] = #X
+		REL_TYPE(R_PPC64_NONE),
+		REL_TYPE(R_PPC64_ADDR32),
+		REL_TYPE(R_PPC64_ADDR24),
+		REL_TYPE(R_PPC64_ADDR16),
+		REL_TYPE(R_PPC64_ADDR16_LO),
+		REL_TYPE(R_PPC64_ADDR16_HI),
+		REL_TYPE(R_PPC64_ADDR16_HA),
+		REL_TYPE(R_PPC64_ADDR14),
+		REL_TYPE(R_PPC64_ADDR14_BRTAKEN),
+		REL_TYPE(R_PPC64_ADDR14_BRNTAKEN),
+		REL_TYPE(R_PPC64_REL24),
+		REL_TYPE(R_PPC64_REL14),
+		REL_TYPE(R_PPC64_REL14_BRTAKEN),
+		REL_TYPE(R_PPC64_REL14_BRNTAKEN),
+		REL_TYPE(R_PPC64_GOT16),
+		REL_TYPE(R_PPC64_GOT16_LO),
+		REL_TYPE(R_PPC64_GOT16_HI),
+		REL_TYPE(R_PPC64_GOT16_HA),
+		REL_TYPE(R_PPC64_COPY),
+		REL_TYPE(R_PPC64_GLOB_DAT),
+		REL_TYPE(R_PPC64_JMP_SLOT),
+		REL_TYPE(R_PPC64_RELATIVE),
+		REL_TYPE(R_PPC64_UADDR32),
+		REL_TYPE(R_PPC64_UADDR16),
+		REL_TYPE(R_PPC64_REL32),
+		REL_TYPE(R_PPC64_PLT32),
+		REL_TYPE(R_PPC64_PLTREL32),
+		REL_TYPE(R_PPC64_PLT16_LO),
+		REL_TYPE(R_PPC64_PLT16_HI),
+		REL_TYPE(R_PPC64_PLT16_HA),
+		REL_TYPE(R_PPC64_SECTOFF),
+		REL_TYPE(R_PPC64_SECTOFF_LO),
+		REL_TYPE(R_PPC64_SECTOFF_HI),
+		REL_TYPE(R_PPC64_SECTOFF_HA),
+		REL_TYPE(R_PPC64_ADDR30),
+		REL_TYPE(R_PPC64_ADDR64),
+		REL_TYPE(R_PPC64_ADDR16_HIGHER),
+		REL_TYPE(R_PPC64_ADDR16_HIGHERA),
+		REL_TYPE(R_PPC64_ADDR16_HIGHEST),
+		REL_TYPE(R_PPC64_ADDR16_HIGHESTA),
+		REL_TYPE(R_PPC64_UADDR64),
+		REL_TYPE(R_PPC64_REL64),
+		REL_TYPE(R_PPC64_PLT64),
+		REL_TYPE(R_PPC64_PLTREL64),
+		REL_TYPE(R_PPC64_TOC16),
+		REL_TYPE(R_PPC64_TOC16_LO),
+		REL_TYPE(R_PPC64_TOC16_HI),
+		REL_TYPE(R_PPC64_TOC16_HA),
+		REL_TYPE(R_PPC64_TOC),
+		REL_TYPE(R_PPC64_PLTGOT16),
+		REL_TYPE(R_PPC64_PLTGOT16_LO),
+		REL_TYPE(R_PPC64_PLTGOT16_HI),
+		REL_TYPE(R_PPC64_PLTGOT16_HA),
+		REL_TYPE(R_PPC64_ADDR16_DS),
+		REL_TYPE(R_PPC64_ADDR16_LO_DS),
+		REL_TYPE(R_PPC64_GOT16_DS),
+		REL_TYPE(R_PPC64_GOT16_LO_DS),
+		REL_TYPE(R_PPC64_PLT16_LO_DS),
+		REL_TYPE(R_PPC64_SECTOFF_DS),
+		REL_TYPE(R_PPC64_SECTOFF_LO_DS),
+		REL_TYPE(R_PPC64_TOC16_DS),
+		REL_TYPE(R_PPC64_TOC16_LO_DS),
+		REL_TYPE(R_PPC64_PLTGOT16_DS),
+		REL_TYPE(R_PPC64_PLTGOT16_LO_DS),
+		REL_TYPE(R_PPC64_TLS),
+		REL_TYPE(R_PPC64_DTPMOD64),
+		REL_TYPE(R_PPC64_TPREL16),
+		REL_TYPE(R_PPC64_TPREL16_LO),
+		REL_TYPE(R_PPC64_TPREL16_HI),
+		REL_TYPE(R_PPC64_TPREL16_HA),
+		REL_TYPE(R_PPC64_TPREL64),
+		REL_TYPE(R_PPC64_DTPREL16),
+		REL_TYPE(R_PPC64_DTPREL16_LO),
+		REL_TYPE(R_PPC64_DTPREL16_HI),
+		REL_TYPE(R_PPC64_DTPREL16_HA),
+		REL_TYPE(R_PPC64_DTPREL64),
+		REL_TYPE(R_PPC64_GOT_TLSGD16),
+		REL_TYPE(R_PPC64_GOT_TLSGD16_LO),
+		REL_TYPE(R_PPC64_GOT_TLSGD16_HI),
+		REL_TYPE(R_PPC64_GOT_TLSGD16_HA),
+		REL_TYPE(R_PPC64_GOT_TLSLD16),
+		REL_TYPE(R_PPC64_GOT_TLSLD16_LO),
+		REL_TYPE(R_PPC64_GOT_TLSLD16_HI),
+		REL_TYPE(R_PPC64_GOT_TLSLD16_HA),
+		REL_TYPE(R_PPC64_GOT_TPREL16_DS),
+		REL_TYPE(R_PPC64_GOT_TPREL16_LO_DS),
+		REL_TYPE(R_PPC64_GOT_TPREL16_HI),
+		REL_TYPE(R_PPC64_GOT_TPREL16_HA),
+		REL_TYPE(R_PPC64_GOT_DTPREL16_DS),
+		REL_TYPE(R_PPC64_GOT_DTPREL16_LO_DS),
+		REL_TYPE(R_PPC64_GOT_DTPREL16_HI),
+		REL_TYPE(R_PPC64_GOT_DTPREL16_HA),
+		REL_TYPE(R_PPC64_TPREL16_DS),
+		REL_TYPE(R_PPC64_TPREL16_LO_DS),
+		REL_TYPE(R_PPC64_TPREL16_HIGHER),
+		REL_TYPE(R_PPC64_TPREL16_HIGHERA),
+		REL_TYPE(R_PPC64_TPREL16_HIGHEST),
+		REL_TYPE(R_PPC64_TPREL16_HIGHESTA),
+		REL_TYPE(R_PPC64_DTPREL16_DS),
+		REL_TYPE(R_PPC64_DTPREL16_LO_DS),
+		REL_TYPE(R_PPC64_DTPREL16_HIGHER),
+		REL_TYPE(R_PPC64_DTPREL16_HIGHERA),
+		REL_TYPE(R_PPC64_DTPREL16_HIGHEST),
+		REL_TYPE(R_PPC64_DTPREL16_HIGHESTA),
+		REL_TYPE(R_PPC64_TLSGD),
+		REL_TYPE(R_PPC64_TLSLD),
+		REL_TYPE(R_PPC64_TOCSAVE),
+/*		REL_TYPE(R_PPC64_ENTRY), */
+		REL_TYPE(R_PPC64_REL16),
+		REL_TYPE(R_PPC64_REL16_LO),
+		REL_TYPE(R_PPC64_REL16_HI),
+		REL_TYPE(R_PPC64_REL16_HA),
+#undef REL_TYPE
+	};
+	const char *name = "UNKNOWN";
+
+	if (type < sizeof(type_name) / sizeof(typeof(type_name[0])) && type_name[type])
+		name = type_name[type];
+	return name;
+}
+
+static struct section *get_section(struct elf *elf, Elf_Scn *scn)
+{
+	struct section *section;
+
+	section = malloc(sizeof(struct section));
+
+	section->scn = scn;
+
+	if (gelf_getshdr(scn, &section->shdr) == NULL) {
+		fprintf(stderr, "gelf_getshdr failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	section->name = elf_strptr(elf->elf, elf->shstrndx, section->shdr.sh_name);
+	if (section->name == NULL) {
+		fprintf(stderr, "gelf_strptr failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	section->data = elf_getdata(scn, NULL);
+	if (section->data) {
+		assert(elf_getdata(scn, section->data) == NULL);
+	}
+
+	section->symtab = NULL;
+	if (section->shdr.sh_type == SHT_SYMTAB)
+		goto no_symtab;
+	if (section->shdr.sh_type == SHT_DYNSYM)
+		goto no_symtab;
+	if (section->shdr.sh_type == SHT_DYNAMIC)
+		goto no_symtab;
+
+	/* printf("symtab index:%d\n", elf_scnshndx(scn)); ??? */
+	if (section->shdr.sh_link) {
+		Elf_Scn *link_scn;
+
+		link_scn = elf_getscn(elf->elf, section->shdr.sh_link);
+		section->symtab = get_section(elf, link_scn);
+
+		assert(section->symtab->shdr.sh_type == SHT_SYMTAB ||
+			section->symtab->shdr.sh_type == SHT_DYNSYM);
+	}
+
+no_symtab:
+	section->strtab = NULL;
+	if (section->symtab == NULL) {
+		if (section->shdr.sh_link) {
+			Elf_Scn *link_scn;
+
+			link_scn = elf_getscn(elf->elf, section->shdr.sh_link);
+			section->strtab = get_section(elf, link_scn);
+
+			assert(section->strtab->shdr.sh_type == SHT_STRTAB);
+		}
+	}
+
+	return section;
+}
+
+struct symbol *elf_sections_get_symbol(struct elf *elf, struct section *section, unsigned long nr)
+{
+	struct symbol *symbol;
+	Elf_Scn *scn;
+
+	symbol = malloc(sizeof(struct symbol));
+
+	if (gelf_getsym(section->symtab->data, nr, &symbol->sym) == NULL) {
+		fprintf(stderr, "gelf_getsym failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	scn = elf_getscn(elf->elf, symbol->sym.st_shndx);
+	symbol->section = get_section(elf, scn);
+	symbol->_name = symbol->section->name;
+	if (symbol->sym.st_name) {
+		symbol->name = elf_strptr(elf->elf, elf_ndxscn(section->symtab->strtab->scn), symbol->sym.st_name);
+		symbol->_name = symbol->name;
+	} else {
+		symbol->name = NULL;
+	}
+
+	return symbol;
+}
+
+struct relocation *elf_sections_get_reloc(struct elf *elf, struct section *section, size_t n)
+{
+	struct relocation *relocation;
+
+	relocation = malloc(sizeof(struct relocation));
+
+	if (section->shdr.sh_type == SHT_REL) {
+		if (gelf_getrel(section->data, n, &relocation->rel) != &relocation->rel) {
+			return NULL;
+		}
+
+		relocation->type_name = rel_type_name(GELF_R_TYPE(relocation->rel.r_info));
+		relocation->symbol = elf_sections_get_symbol(elf, section, GELF_R_SYM(relocation->rel.r_info));
+		relocation->offset = relocation->rel.r_offset;
+		relocation->target = relocation->symbol->sym.st_value;
+
+	} else if (section->shdr.sh_type == SHT_RELA) {
+		if (gelf_getrela(section->data, n, &relocation->rela) != &relocation->rela) {
+			return NULL;
+		}
+
+		relocation->type_name = rel_type_name(GELF_R_TYPE(relocation->rela.r_info));
+		relocation->symbol = elf_sections_get_symbol(elf, section, GELF_R_SYM(relocation->rela.r_info));
+		relocation->offset = relocation->rela.r_offset;
+		relocation->target = relocation->symbol->sym.st_value;
+		relocation->target += relocation->rela.r_addend;
+
+	}  else {
+		assert(0);
+	}
+
+	return relocation;
+}
+
+struct elf *elf_sections_init(int fd)
+{
+	struct elf *elf;
+	Elf_Scn *scn;
+
+	elf = malloc(sizeof(struct elf));
+	assert(elf);
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		fprintf(stderr, "libelf not initialized: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	if ((elf->elf = elf_begin(fd, ELF_C_READ, NULL)) == NULL) {
+		fprintf(stderr, "elf_begin failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	if (elf_kind(elf->elf) != ELF_K_ELF) {
+		fprintf(stderr, "Not an ELF object.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (gelf_getehdr(elf->elf, &elf->ehdr) == NULL) {
+		fprintf(stderr, "gelf_getehdr failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	if (elf->ehdr.e_version != EV_CURRENT) {
+		fprintf(stderr, "Unknown ELF version\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (elf->ehdr.e_machine != EM_PPC && elf->ehdr.e_machine != EM_PPC64) {
+		fprintf(stderr, "Not a PPC/PPC64 machine\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (elf_getshdrstrndx(elf->elf, &elf->shstrndx) != 0) {
+		fprintf(stderr, "elf_getshdrstrndx failed: %s\n", elf_errmsg(-1));
+		exit(EXIT_FAILURE);
+	}
+
+	scn = elf_getscn(elf->elf, elf->shstrndx);
+	elf->strtab = get_section(elf, scn);
+	assert(elf->strtab->shdr.sh_type == SHT_STRTAB);
+
+	return elf;
+}
+
+void elf_sections_exit(struct elf *elf)
+{
+	elf_end(elf->elf);
+}
+
+int elf_sections_processor(struct elf *elf,
+				int (*fn)(struct section *section, void *arg),
+				void *arg)
+{
+	Elf_Scn *scn;
+	int err;
+
+	scn = NULL ;
+	while ((scn = elf_nextscn(elf->elf, scn)) != NULL) {
+		struct section *section;
+
+		section = get_section(elf, scn);
+
+		err = fn(section, arg);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/tools/relocs/elf_sections.h b/arch/powerpc/tools/relocs/elf_sections.h
new file mode 100644
index 0000000..c3bc744
--- /dev/null
+++ b/arch/powerpc/tools/relocs/elf_sections.h
@@ -0,0 +1,50 @@
+#ifndef __ELF_SECTIONS_H__
+#define __ELF_SECTIONS_H__
+
+#include <gelf.h>
+#include <elf.h>
+
+struct section {
+	Elf_Scn *scn;
+	GElf_Shdr shdr;
+	const char *name;
+	Elf_Data *data;
+
+	struct section *symtab;
+	struct section *strtab;
+};
+
+struct symbol {
+	GElf_Sym sym;
+	struct section *section;
+	const char *name;
+	const char *_name;
+};
+
+struct relocation {
+	GElf_Rel rel;
+	GElf_Rela rela;
+
+	const char *type_name;
+	struct symbol *symbol;
+
+	uint64_t offset;
+	uint64_t target;
+};
+
+struct elf {
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	size_t shstrndx;
+	struct section *strtab;
+};
+
+struct symbol *elf_sections_get_symbol(struct elf *elf, struct section *section, unsigned long nr);
+struct relocation *elf_sections_get_reloc(struct elf *elf, struct section *section, size_t n);
+struct elf *elf_sections_init(int fd);
+void elf_sections_exit(struct elf *elf);
+int elf_sections_processor(struct elf *elf,
+				int (*fn)(struct section *section, void *arg),
+				void *arg);
+
+#endif
diff --git a/arch/powerpc/tools/relocs/process_relocs.c b/arch/powerpc/tools/relocs/process_relocs.c
new file mode 100644
index 0000000..912ab1f
--- /dev/null
+++ b/arch/powerpc/tools/relocs/process_relocs.c
@@ -0,0 +1,437 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <gelf.h>
+#include <elf.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <asm/byteorder.h>
+#include "elf_sections.h"
+#include "code-patching.h"
+
+/*
+ * This program runs through relocation data in PPC/PPC64 vmlinux ELF
+ * image generated with --emit-relocs, and performs some processing and
+ * checks.
+ *
+ * Presently, it has the following functions:
+ * 1. Fix relocations for branches inside alternate feature sections
+ *    (the "else" patches), so that they are correct for their destination
+ *    address. They never get executed at their linked location.
+ *
+ *    This is done by parsing all fixup_entry structures in the _ftr_fixup
+ *    sections, and keeping those with non-zero alternate patch. Then all
+ *    relocations in the .__ftr_alternates.text section are parsed, and those
+ *    matching addresses in our fixup_entry alternates patches get
+ *    struct insn_patch created for them. Finally, all struct insn_patch'es
+ *    are iterated and written to the image in-place.
+ */
+
+#define dbg_printf(...)
+
+struct fixup_entry_64 {
+	uint64_t mask;
+	uint64_t value;
+	uint64_t start_off;
+	uint64_t end_off;
+	uint64_t alt_start_off;
+	uint64_t alt_end_off;
+} __attribute__((packed));
+
+#define fixup_entry fixup_entry_64
+
+struct fixup_entry_32 {
+	uint32_t mask;
+	uint32_t value;
+	uint32_t start_off;
+	uint32_t end_off;
+	uint32_t alt_start_off;
+	uint32_t alt_end_off;
+} __attribute__((packed));
+
+struct insn_patch {
+	uint32_t	insn;		/* New instruction */
+	off_t		offset;		/* Image location to patch */
+};
+
+static int is_64bit(struct elf *elf)
+{
+	return elf->ehdr.e_ident[EI_CLASS] == ELFCLASS64;
+}
+
+static int is_32bit(struct elf *elf)
+{
+	return elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32;
+}
+
+static int is_le(struct elf *elf)
+{
+	return elf->ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
+}
+
+static int is_be(struct elf *elf)
+{
+	return elf->ehdr.e_ident[EI_DATA] == ELFDATA2MSB;
+}
+
+
+static struct elf *elf;
+
+static uint16_t f16_to_cpu(uint16_t val)
+{
+	if (is_le(elf))
+		return __le16_to_cpu(val);
+	else
+		return __be16_to_cpu(val);
+}
+
+static uint32_t f32_to_cpu(uint32_t val)
+{
+	if (is_le(elf))
+		return __le32_to_cpu(val);
+	else
+		return __be32_to_cpu(val);
+}
+
+static uint64_t f64_to_cpu(uint64_t val)
+{
+	if (is_le(elf))
+		return __le64_to_cpu(val);
+	else
+		return __be64_to_cpu(val);
+}
+
+static uint16_t cpu_to_f16(uint16_t val)
+{
+	if (is_le(elf))
+		return __cpu_to_le16(val);
+	else
+		return __cpu_to_be16(val);
+}
+
+static uint32_t cpu_to_f32(uint32_t val)
+{
+	if (is_le(elf))
+		return __cpu_to_le32(val);
+	else
+		return __cpu_to_be32(val);
+}
+
+static uint64_t cpu_to_f64(uint64_t val)
+{
+	if (is_le(elf))
+		return __cpu_to_le64(val);
+	else
+		return __cpu_to_be64(val);
+}
+
+static struct section *ftr_alt;
+
+static unsigned int nr_fes = 0;
+static struct fixup_entry *fes = NULL;
+
+static struct fixup_entry *find_fe_altaddr(uint64_t addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_fes; i++) {
+		if (addr >= fes[i].alt_start_off && addr < fes[i].alt_end_off)
+			return &fes[i];
+	}
+	return NULL;
+}
+
+static unsigned int nr_ips = 0;
+static struct insn_patch *ips = NULL;
+
+static void create_branch_patch(struct relocation *relocation, struct fixup_entry *fe)
+{
+	struct insn_patch *ip;
+	uint64_t addr = relocation->offset;
+	uint64_t dst_addr;
+	uint64_t scn_delta;
+	uint64_t offset;
+	uint32_t insn;
+	uint32_t *i;
+
+	assert(addr >= ftr_alt->shdr.sh_addr &&
+		addr < ftr_alt->shdr.sh_addr + ftr_alt->shdr.sh_size);
+
+	scn_delta = addr - ftr_alt->shdr.sh_addr;
+
+	assert(scn_delta < ftr_alt->data->d_size);
+
+	i = ftr_alt->data->d_buf + scn_delta;
+
+	insn = f32_to_cpu(*i);
+
+	offset = ftr_alt->shdr.sh_offset + scn_delta;
+	dst_addr = addr - fe->alt_start_off + fe->start_off;
+
+	if (set_branch_target(&insn, dst_addr, relocation->target)) {
+		fprintf(stderr, "ftr_alt branch target out of range or not a branch\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (insn == *i) /* Nothing to do */
+		return;
+
+	ips = realloc(ips, (nr_ips + 1) * sizeof(struct insn_patch));
+	ip = &ips[nr_ips];
+	nr_ips++;
+
+	ip->insn = insn;
+	ip->offset = offset;
+
+	dbg_printf("update branch insn (%x->%x)\n", *i, ip->insn);
+}
+
+static int process_alt_data(struct section *section, void *arg)
+{
+	if (strcmp(section->name, ".__ftr_alternates.text") != 0)
+		return 0;
+
+	dbg_printf("section %-4.4jd %s\n", (uintmax_t)elf_ndxscn(section->scn), section->name);
+	assert(section->shdr.sh_type == SHT_PROGBITS);
+
+	ftr_alt = section;
+
+	return 0;
+}
+
+static int process_fixup_entries(struct section *section, void *arg)
+{
+	Elf_Data *data;
+	unsigned int nr, i;
+
+	if (strstr(section->name, "_ftr_fixup") == 0)
+		return 0;
+
+	if (section->shdr.sh_type != SHT_PROGBITS)
+		return 0;
+
+	dbg_printf("section %-4.4jd %s\n", (uintmax_t)elf_ndxscn(section->scn), section->name);
+
+	data = section->data;
+	assert(data);
+	assert(data->d_size > 0);
+
+	if (is_64bit(elf)) {
+		assert(data->d_size % sizeof(struct fixup_entry_64) == 0);
+		nr = data->d_size / sizeof(struct fixup_entry_64);
+	} else {
+		assert(data->d_size % sizeof(struct fixup_entry_32) == 0);
+		nr = data->d_size / sizeof(struct fixup_entry_32);
+	}
+
+	for (i = 0; i < nr; i++) {
+		struct fixup_entry *dst;
+		unsigned long idx;
+		unsigned long long off;
+
+		if (is_64bit(elf)) {
+			struct fixup_entry_64 *src;
+
+			idx = i * sizeof(struct fixup_entry_64);
+
+			off = section->shdr.sh_addr + data->d_off + idx;
+			src = data->d_buf + idx;
+
+			if (src->alt_start_off == src->alt_end_off)
+				continue;
+
+			fes = realloc(fes, (nr_fes + 1) * sizeof(struct fixup_entry));
+			dst = &fes[nr_fes];
+			nr_fes++;
+
+			dst->mask = f64_to_cpu(src->mask);
+			dst->value = f64_to_cpu(src->value);
+			dst->start_off = f64_to_cpu(src->start_off) + off;
+			dst->end_off = f64_to_cpu(src->end_off) + off;
+			dst->alt_start_off = f64_to_cpu(src->alt_start_off) + off;
+			dst->alt_end_off = f64_to_cpu(src->alt_end_off) + off;
+
+		} else {
+			struct fixup_entry_32 *src;
+
+			idx = i * sizeof(struct fixup_entry_32);
+
+			off = section->shdr.sh_addr + data->d_off + idx;
+			src = data->d_buf + idx;
+
+			if (src->alt_start_off == src->alt_end_off)
+				continue;
+
+			fes = realloc(fes, (nr_fes + 1) * sizeof(struct fixup_entry));
+			dst = &fes[nr_fes];
+			nr_fes++;
+
+			dst->mask = f32_to_cpu(src->mask);
+			dst->value = f32_to_cpu(src->value);
+			dst->start_off = f32_to_cpu(src->start_off) + off;
+			dst->end_off = f32_to_cpu(src->end_off) + off;
+			dst->alt_start_off = f32_to_cpu(src->alt_start_off) + off;
+			dst->alt_end_off = f32_to_cpu(src->alt_end_off) + off;
+
+		}
+
+		dbg_printf("%llx fixup entry %llx:%llx (%llx-%llx) <- (%llx-%llx)\n", off,
+			(unsigned long long)dst->mask, (unsigned long long)dst->value,
+			(unsigned long long)dst->start_off, (unsigned long long)dst->end_off,
+			(unsigned long long)dst->alt_start_off, (unsigned long long)dst->alt_end_off);
+	}
+
+	return 0;
+}
+
+static int process_alt_relocations(struct section *section, void *arg)
+{
+	struct relocation *relocation;
+	size_t n;
+
+	if (strcmp(section->name, ".rela.__ftr_alternates.text") != 0)
+		return 0;
+
+	assert(section->shdr.sh_type == SHT_RELA);
+
+	dbg_printf("section %-4.4jd %s\n", (uintmax_t)elf_ndxscn(section->scn), section->name);
+
+	n = 0;
+	while ((relocation = elf_sections_get_reloc(elf, section, n)) != NULL) {
+		struct fixup_entry *fe;
+
+		n++;
+
+		dbg_printf("%llx %s %s %llx + %llx\n",
+			(unsigned long long)relocation->offset,
+			relocation->type_name,
+			relocation->symbol->_name,
+			(unsigned long long)relocation->symbol->sym.st_value,
+			(unsigned long long)relocation->rela.r_addend);
+
+		fe = find_fe_altaddr(relocation->offset);
+		if (fe) {
+			dbg_printf("reloc has fe %llx:%llx (%llx-%llx) <- (%llx-%llx)\n",
+				(unsigned long long)fe->mask,
+				(unsigned long long)fe->value,
+				(unsigned long long)fe->start_off,
+				(unsigned long long)fe->end_off,
+				(unsigned long long)fe->alt_start_off,
+				(unsigned long long)fe->alt_end_off);
+
+			if (relocation->target >= fe->alt_start_off &&
+				relocation->target < fe->alt_end_off) {
+				dbg_printf("  reloc within patch code\n");
+				continue;
+			}
+
+			/*
+			 * We really should check for all branches either side
+			 * of fixup_entry from outside (including within
+			 * different fixup code). It's almost guaranteed to go
+			 * badly. Not just relocations, but branches too,
+			 * because nearby branches might get resolved without
+			 * a relocation.
+			 */
+			if (relocation->target >= ftr_alt->shdr.sh_addr &&
+				relocation->target < ftr_alt->shdr.sh_addr +
+						ftr_alt->shdr.sh_size) {
+				fprintf(stderr, "ftr_alt branch target is another ftr_alt region, which is not allowed\n");
+				exit(EXIT_FAILURE);
+			}
+
+			create_branch_patch(relocation, fe);
+		} else {
+			dbg_printf("  reloc has no fe\n");
+		}
+	}
+
+	return 0;
+}
+
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	int err;
+	unsigned int i;
+	struct stat stat;
+	void *mem;
+
+	if (argc != 2)
+		exit(EXIT_FAILURE);
+
+	fd = open(argv[1], O_RDONLY, 0);
+	if (fd == -1) {
+		fprintf(stderr, "open %s failed: %s\n", argv[1], strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	elf = elf_sections_init(fd);
+
+	err = elf_sections_processor(elf, process_alt_data, NULL);
+	assert(!err);
+
+	err = elf_sections_processor(elf, process_fixup_entries, NULL);
+	assert(!err);
+
+	err = elf_sections_processor(elf, process_alt_relocations, NULL);
+	assert(!err);
+
+	elf_sections_exit(elf);
+
+	if (close(fd) == -1) {
+		fprintf(stderr, "close %s failed: %s\n", argv[1], strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	if (!nr_ips) {
+		dbg_printf("Nothing to do.\n");
+		exit(EXIT_SUCCESS);
+	}
+
+	dbg_printf("%u instructions to patch.\n", nr_ips);
+
+	fd = open(argv[1], O_RDWR, 0);
+	if (fd == -1) {
+		fprintf(stderr, "open %s failed: %s\n", argv[1], strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	if (fstat(fd, &stat) == -1) {
+		perror("stat");
+		exit(EXIT_FAILURE);
+	}
+
+	mem = mmap(0, stat.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED) {
+		perror("mmap");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < nr_ips; i++) {
+		struct insn_patch *ip = &ips[i];
+
+		assert(ip->offset < stat.st_size);
+		*(uint32_t *)(mem + ip->offset) = ip->insn;
+	}
+
+	if (munmap(mem, stat.st_size) == -1) {
+		perror("mmap");
+		exit(EXIT_FAILURE);
+	}
+
+	if (close(fd) == -1) {
+		fprintf(stderr, "close %s failed: %s\n", argv[1], strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.8.1
