Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6B1DDE107
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 06:13:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7BKD52P002943
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:13:05 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7BKD5s2176078
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:13:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7BKD4mZ013044
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:13:05 -0600
Date: Tue, 12 Aug 2008 01:42:48 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] Extract list of relocation offsets
Message-ID: <20080811201248.GA26566@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201120.GA25283@in.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Extract list of relocation offsets

Extract list of offsets in the vmlinux file for which the relocation
delta has to be patched. Currently only following type of relocation
types are considered: R_PPC64_ADDR16_HI, R_PPC64_TOC and R_PPC64_ADDR64

The offsets are sorted according to the relocation type and this
information is appended to the normal vmlinux file by using the patch
relocation_build.patch

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/boot/relocs.c |  820 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 820 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/relocs.c

diff --git a/arch/powerpc/boot/relocs.c b/arch/powerpc/boot/relocs.c
new file mode 100644
index 0000000..aed90e5
--- /dev/null
+++ b/arch/powerpc/boot/relocs.c
@@ -0,0 +1,820 @@
+/*
+ *  PowerPC version
+ *
+ *  Adapted for 64bit PowerPC by Mohan Kumar M (mohan@in.ibm.com)
+ *
+ *  Written by Eric W Biederman(ebiederm@xmission.com) and
+ *  Vivek Goyal(vgoyal@redhat.com) for x86
+ *
+ *  Extract list of offsets in the vmlinux file for which the
+ *  relocation delta has to be patched.
+ *  Currently only following type of relocation types are
+ *  considered: R_PPC64_ADDR16_HI, R_PPC64_TOC and R_PPC64_ADDR64
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <elf.h>
+#include <byteswap.h>
+#define USE_BSD
+#include <endian.h>
+
+#define MAX_SHDRS 100
+static Elf64_Ehdr ehdr;
+static Elf64_Shdr shdr[MAX_SHDRS];
+static Elf64_Sym  *symtab[MAX_SHDRS];
+static Elf64_Rela  *reltaba[MAX_SHDRS];
+static char *strtab[MAX_SHDRS];
+static unsigned long reloc_count, reloc_idx;
+
+struct reloc_info {
+	unsigned int rel_type;
+	unsigned long long offset;
+};
+
+static struct reloc_info *relocs;
+
+/*
+ * Following symbols have been audited. There values are constant and do
+ * not change if bzImage is loaded at a different physical address than
+ * the address for which it has been compiled. Don't warn user about
+ * absolute relocations present w.r.t these symbols.
+ */
+static const char* safe_abs_relocs[] = {
+		"__kernel_vsyscall",
+		"__kernel_rt_sigreturn",
+		"__kernel_sigreturn",
+		"SYSENTER_RETURN",
+};
+
+static int is_safe_abs_reloc(const char* sym_name)
+{
+	int i, array_size;
+
+	array_size = sizeof(safe_abs_relocs)/sizeof(char*);
+
+	for(i = 0; i < array_size; i++) {
+		if (!strcmp(sym_name, safe_abs_relocs[i]))
+			/* Match found */
+			return 1;
+	}
+	if (strncmp(sym_name, "__crc_", 6) == 0)
+		return 1;
+	return 0;
+}
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static const char *sym_type(unsigned type)
+{
+	static const char *type_name[] = {
+#define SYM_TYPE(X) [X] = #X
+		SYM_TYPE(STT_NOTYPE),
+		SYM_TYPE(STT_OBJECT),
+		SYM_TYPE(STT_FUNC),
+		SYM_TYPE(STT_SECTION),
+		SYM_TYPE(STT_FILE),
+		SYM_TYPE(STT_COMMON),
+		SYM_TYPE(STT_TLS),
+#undef SYM_TYPE
+	};
+	const char *s_type = "unknown sym type name";
+	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+		s_type = type_name[type];
+	}
+	return s_type;
+}
+
+static const char *sym_bind(unsigned bind)
+{
+	static const char *bind_name[] = {
+#define SYM_BIND(X) [X] = #X
+		SYM_BIND(STB_LOCAL),
+		SYM_BIND(STB_GLOBAL),
+		SYM_BIND(STB_WEAK),
+#undef SYM_BIND
+	};
+	const char *s_bind = "unknown sym bind name";
+	if (bind < sizeof(bind_name)/sizeof(bind_name[0])) {
+		s_bind = bind_name[bind];
+	}
+	return s_bind;
+}
+
+static const char *sym_visibility(unsigned visibility)
+{
+	static const char *visibility_name[] = {
+#define SYM_VISIBILITY(X) [X] = #X
+		SYM_VISIBILITY(STV_DEFAULT),
+		SYM_VISIBILITY(STV_INTERNAL),
+		SYM_VISIBILITY(STV_HIDDEN),
+		SYM_VISIBILITY(STV_PROTECTED),
+#undef SYM_VISIBILITY
+	};
+	const char *name = "unknown sym visibility name";
+	if (visibility < sizeof(visibility_name)/sizeof(visibility_name[0])) {
+		name = visibility_name[visibility];
+	}
+	return name;
+}
+
+static const char *rel_type(unsigned type)
+{
+	static const char *type_name[] = {
+#define REL_TYPE(X) [X] = #X
+		REL_TYPE(R_PPC64_NONE),
+		REL_TYPE(R_PPC64_ADDR32),
+		REL_TYPE(R_PPC64_ADDR24),
+		REL_TYPE(R_PPC64_ADDR16),
+		REL_TYPE(R_PPC64_ADDR16_LO),
+		REL_TYPE(R_PPC64_ADDR16_HI),
+		REL_TYPE(R_PPC64_ADDR16_HA),
+		REL_TYPE(R_PPC64_ADDR14	),
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
+#undef REL_TYPE
+	};
+	const char *name = "unknown type rel type name";
+	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+		name = type_name[type];
+	}
+	return name;
+}
+
+static const char *sec_name(unsigned shndx)
+{
+	const char *sec_strtab;
+	const char *name;
+	sec_strtab = strtab[ehdr.e_shstrndx];
+	name = "<noname>";
+	if (shndx < ehdr.e_shnum) {
+		name = sec_strtab + shdr[shndx].sh_name;
+	}
+	else if (shndx == SHN_ABS) {
+		name = "ABSOLUTE";
+	}
+	else if (shndx == SHN_COMMON) {
+		name = "COMMON";
+	}
+	return name;
+}
+
+static const char *sym_name(const char *sym_strtab, Elf64_Sym *sym)
+{
+	const char *name;
+	name = "<noname>";
+	if (sym->st_name) {
+		name = sym_strtab + sym->st_name;
+	}
+	else {
+		name = sec_name(shdr[sym->st_shndx].sh_name);
+	}
+	return name;
+}
+
+
+
+#if BYTE_ORDER == BIG_ENDIAN
+#define be16_to_cpu(val) (val)
+#define be32_to_cpu(val) (val)
+#define be64_to_cpu(val) (val)
+#endif
+#if BYTE_ORDER == LITTLE_ENDIAN
+#define be16_to_cpu(val) bswap_16(val)
+#define be32_to_cpu(val) bswap_32(val)
+#define be64_to_cpu(val) bswap_64(val)
+#endif
+
+static uint16_t elf16_to_cpu(uint16_t val)
+{
+	return be16_to_cpu(val);
+}
+
+static uint32_t elf32_to_cpu(uint32_t val)
+{
+	return be32_to_cpu(val);
+}
+
+static uint64_t elf64_to_cpu(uint64_t val)
+{
+	return be64_to_cpu(val);
+}
+
+static void read_ehdr(FILE *fp)
+{
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
+		die("Cannot read ELF header: %s\n",
+			strerror(errno));
+	}
+	if (memcmp(ehdr.e_ident, ELFMAG, 4) != 0) {
+		die("No ELF magic\n");
+	}
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS64) {
+		die("Not a 64 bit executable\n");
+	}
+	if (ehdr.e_ident[EI_DATA] != ELFDATA2MSB) {
+		die("Not a MSB ELF executable\n");
+	}
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	/* Convert the fields to native endian */
+	ehdr.e_type      = elf16_to_cpu(ehdr.e_type);
+	ehdr.e_machine   = elf16_to_cpu(ehdr.e_machine);
+	ehdr.e_version   = elf32_to_cpu(ehdr.e_version);
+	ehdr.e_entry     = elf64_to_cpu(ehdr.e_entry);
+	ehdr.e_phoff     = elf64_to_cpu(ehdr.e_phoff);
+	ehdr.e_shoff     = elf64_to_cpu(ehdr.e_shoff);
+	ehdr.e_flags     = elf32_to_cpu(ehdr.e_flags);
+	ehdr.e_ehsize    = elf16_to_cpu(ehdr.e_ehsize);
+	ehdr.e_phentsize = elf16_to_cpu(ehdr.e_phentsize);
+	ehdr.e_phnum     = elf16_to_cpu(ehdr.e_phnum);
+	ehdr.e_shentsize = elf16_to_cpu(ehdr.e_shentsize);
+	ehdr.e_shnum     = elf16_to_cpu(ehdr.e_shnum);
+	ehdr.e_shstrndx  = elf16_to_cpu(ehdr.e_shstrndx);
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
+		die("Unsupported ELF header type\n");
+	}
+	if (ehdr.e_machine != EM_PPC64) {
+		die("Not for PPC64\n");
+	}
+	if (ehdr.e_version != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	if (ehdr.e_ehsize != sizeof(Elf64_Ehdr)) {
+		die("Bad Elf header size\n");
+	}
+	if (ehdr.e_phentsize != sizeof(Elf64_Phdr)) {
+		die("Bad program header entry\n");
+	}
+	if (ehdr.e_shentsize != sizeof(Elf64_Shdr)) {
+		die("Bad section header entry\n");
+	}
+	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+		die("String table index out of bounds\n");
+	}
+}
+
+static void read_shdrs(FILE *fp)
+{
+	int i;
+	if (ehdr.e_shnum > MAX_SHDRS) {
+		die("%d section headers supported: %d\n",
+			ehdr.e_shnum, MAX_SHDRS);
+	}
+	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
+		die("Seek to %d failed: %s\n",
+			ehdr.e_shoff, strerror(errno));
+	}
+	if (fread(&shdr, sizeof(shdr[0]), ehdr.e_shnum, fp) != ehdr.e_shnum) {
+		die("Cannot read ELF section headers: %s\n",
+			strerror(errno));
+	}
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		shdr[i].sh_name      = elf32_to_cpu(shdr[i].sh_name);
+		shdr[i].sh_type      = elf32_to_cpu(shdr[i].sh_type);
+		shdr[i].sh_flags     = elf64_to_cpu(shdr[i].sh_flags);
+		shdr[i].sh_addr      = elf64_to_cpu(shdr[i].sh_addr);
+		shdr[i].sh_offset    = elf64_to_cpu(shdr[i].sh_offset);
+		shdr[i].sh_size      = elf64_to_cpu(shdr[i].sh_size);
+		shdr[i].sh_link      = elf32_to_cpu(shdr[i].sh_link);
+		shdr[i].sh_info      = elf32_to_cpu(shdr[i].sh_info);
+		shdr[i].sh_addralign = elf64_to_cpu(shdr[i].sh_addralign);
+		shdr[i].sh_entsize   = elf64_to_cpu(shdr[i].sh_entsize);
+	}
+
+}
+
+static void read_strtabs(FILE *fp)
+{
+	int i;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_STRTAB) {
+			continue;
+		}
+		strtab[i] = malloc(shdr[i].sh_size);
+		if (!strtab[i]) {
+			die("malloc of %d bytes for strtab failed\n",
+				shdr[i].sh_size);
+		}
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+		}
+		if (fread(strtab[i], 1, shdr[i].sh_size, fp) != shdr[i].sh_size) {
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+		}
+	}
+}
+
+static void read_symtabs(FILE *fp)
+{
+	int i,j;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_SYMTAB) {
+			continue;
+		}
+		symtab[i] = malloc(shdr[i].sh_size);
+		if (!symtab[i]) {
+			die("malloc of %d bytes for symtab failed\n",
+				shdr[i].sh_size);
+		}
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+		}
+		if (fread(symtab[i], 1, shdr[i].sh_size, fp) != shdr[i].sh_size) {
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+		}
+		for(j = 0; j < shdr[i].sh_size/sizeof(symtab[i][0]); j++) {
+			symtab[i][j].st_name  = elf32_to_cpu(symtab[i][j].st_name);
+			symtab[i][j].st_value = elf64_to_cpu(symtab[i][j].st_value);
+			symtab[i][j].st_size  = elf64_to_cpu(symtab[i][j].st_size);
+			symtab[i][j].st_shndx = elf16_to_cpu(symtab[i][j].st_shndx);
+		}
+	}
+}
+
+
+static void read_relocs(FILE *fp)
+{
+	int i,j;
+	void *relp;
+
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_RELA)
+			continue;
+
+		reltaba[i] = malloc(shdr[i].sh_size);
+		if (!reltaba[i])
+			die("malloc of %d bytes for relocs failed\n",
+				shdr[i].sh_size);
+
+		relp = reltaba[i];
+
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+
+		if (fread(relp, 1, shdr[i].sh_size, fp) != shdr[i].sh_size)
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+
+		for(j = 0; j < shdr[i].sh_size/sizeof(reltaba[0][0]); j++) {
+			reltaba[i][j].r_offset = elf64_to_cpu(reltaba[i][j].r_offset);
+			reltaba[i][j].r_info   = elf64_to_cpu(reltaba[i][j].r_info);
+			reltaba[i][j].r_addend   = elf64_to_cpu(reltaba[i][j].r_addend);
+		}
+	}
+}
+
+
+static void print_absolute_symbols(void)
+{
+	int i;
+	printf("Absolute symbols\n");
+	printf(" Num:  Value            Size  Type       Bind        Visibility  Name\n");
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf64_Sym *sh_symtab;
+		int j;
+		if (shdr[i].sh_type != SHT_SYMTAB) {
+			continue;
+		}
+		sh_symtab = symtab[i];
+		sym_strtab = strtab[shdr[i].sh_link];
+		for(j = 0; j < shdr[i].sh_size/sizeof(symtab[0][0]); j++) {
+			Elf64_Sym *sym;
+			const char *name;
+			sym = &symtab[i][j];
+			name = sym_name(sym_strtab, sym);
+			if (sym->st_shndx != SHN_ABS) {
+				continue;
+			}
+			printf("type:[%s]\n",
+				sym_type(ELF64_ST_TYPE(sym->st_info)));
+			printf("%5d %016llx %5d type:%s bind:%10s %12s %s\n", \
+				j, sym->st_value, (int)(sym->st_size), \
+				sym_type(ELF64_ST_TYPE(sym->st_info)), \
+				sym_bind(ELF64_ST_BIND(sym->st_info)), \
+				sym_visibility(ELF64_ST_VISIBILITY(sym->st_other)), \
+				name);
+		}
+	}
+	printf("\n");
+}
+
+static void print_absolute_relocs(void)
+{
+	int i, printed = 0;
+	int nr;
+
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf64_Sym *sh_symtab;
+		unsigned sec_applies, sec_symtab;
+		int j;
+		if (shdr[i].sh_type != SHT_RELA)
+			continue;
+
+		sec_symtab  = shdr[i].sh_link;
+		sec_applies = shdr[i].sh_info;
+		if (!(shdr[sec_applies].sh_flags & SHF_ALLOC))
+			continue;
+
+		nr = shdr[i].sh_size/sizeof(reltaba[0][0]);
+
+		sh_symtab = symtab[sec_symtab];
+		sym_strtab = strtab[shdr[sec_symtab].sh_link];
+
+		for(j = 0; j < nr; j++) {
+			Elf64_Rela *rela;
+			Elf64_Sym *sym;
+			const char *name;
+
+			rela = &reltaba[i][j];
+			sym = &sh_symtab[ELF64_R_SYM(rela->r_info)];
+
+			name = sym_name(sym_strtab, sym);
+			if (sym->st_shndx != SHN_ABS)
+				continue;
+
+			/* Absolute symbols are not relocated if vmlinux is
+			 * loaded at a non-compiled address. Display a warning
+			 * to user at compile time about the absolute
+			 * relocations present.
+			 *
+			 * User need to audit the code to make sure
+			 * some symbols which should have been section
+			 * relative have not become absolute because of some
+			 * linker optimization or wrong programming usage.
+			 *
+			 * Before warning check if this absolute symbol
+			 * relocation is harmless.
+			 */
+			if (is_safe_abs_reloc(name))
+				continue;
+
+			if (!printed) {
+				printf("WARNING: Absolute relocations"
+					" present\n");
+				printf("Offset           Info             Type           Sym.Value        "
+					"Sym.Name\n");
+				printed = 1;
+			}
+
+			printf("%016llx %016llx %10s %016llx  %s\n",
+					rela->r_offset, rela->r_info,
+					rel_type(ELF64_R_TYPE(rela->r_info)),
+					sym->st_value, name);
+		}
+	}
+
+	if (printed)
+		printf("\n");
+}
+
+static void walk_relocs(void (*visit)(Elf64_Rela *rela, Elf64_Sym *sym))
+{
+	int i;
+	/* Walk through the relocations */
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf64_Sym *sh_symtab;
+		unsigned sec_applies, sec_symtab;
+		int j, nr_entries;
+		if (shdr[i].sh_type != SHT_RELA)
+			continue;
+
+		sec_symtab  = shdr[i].sh_link;
+		sec_applies = shdr[i].sh_info;
+		if (!(shdr[sec_applies].sh_flags & SHF_ALLOC))
+			continue;
+
+		sh_symtab = symtab[sec_symtab];
+		sym_strtab = strtab[shdr[sec_symtab].sh_link];
+		nr_entries = shdr[i].sh_size/sizeof(reltaba[0][0]);
+
+		for(j = 0; j < nr_entries; j++) {
+			Elf64_Rela *rela;
+			Elf64_Sym *sym;
+			void *relp;
+			unsigned r_type;
+
+
+			rela = &reltaba[i][j];
+			sym = &sh_symtab[ELF64_R_SYM(rela->r_info)];
+			r_type = ELF64_R_TYPE(rela->r_info);
+			relp = rela;
+			/* Don't visit relocations to absolute symbols */
+			if (sym->st_shndx == SHN_ABS)
+				continue;
+
+			/* PC relative relocations don't need to be adjusted */
+			switch (r_type) {
+				case R_PPC64_ADDR16_HI:
+				case R_PPC64_ADDR64:
+				case R_PPC64_TOC:
+					/* Visit relocations that need to be adjusted */
+					visit(rela, sym);
+					break;
+				/* Ignore these relocation types */
+				case R_PPC64_REL24:
+				case R_PPC64_ADDR16_HIGHEST:
+				case R_PPC64_ADDR16_HIGHER:
+				case R_PPC64_ADDR16_LO:
+				case R_PPC64_TOC16_DS:
+				case R_PPC64_REL14:
+				case R_PPC64_TOC16:
+				case R_PPC64_REL64:
+				case R_PPC64_ADDR16_LO_DS:
+					break;
+				case R_PPC64_GOT16_DS:
+				default:
+					die("unsupported relocation type %s(%d)\n", rel_type(r_type), r_type);
+					break;
+			}
+		}
+	}
+}
+
+static void count_reloc(Elf64_Rela *rela, Elf64_Sym *sym)
+{
+	reloc_count += 1;
+}
+
+static void collect_reloc(Elf64_Rela *rela, Elf64_Sym *sym)
+{
+	/* Remember the address that needs to be adjusted. */
+	relocs[reloc_idx].offset = rela->r_offset;
+	relocs[reloc_idx++].rel_type = ELF64_R_TYPE(rela->r_info);
+}
+
+static int cmp_relocs(const void *va, const void *vb)
+{
+	const struct reloc_info *a, *b;
+	a = va; b = vb;
+	return (a->rel_type == b->rel_type)? 0 : (a->rel_type > b->rel_type)? 1 : -1;
+}
+
+static void emit_relocs(int as_text)
+{
+	int i;
+	int prev_r_type;
+	/* Count how many relocations I have and allocate space for them. */
+	reloc_count = 0;
+	walk_relocs(count_reloc);
+	relocs = malloc(reloc_count * sizeof(relocs[0]));
+	if (!relocs)
+		die("malloc of %d entries for relocs failed\n",
+						reloc_count);
+
+	/* Collect up the relocations */
+	reloc_idx = 0;
+	walk_relocs(collect_reloc);
+
+	/* Order the relocations for more efficient processing */
+	qsort(relocs, reloc_count, sizeof(relocs[0]), cmp_relocs);
+
+	/* Print the relocations */
+	if (as_text) {
+		/* Print the relocations in a form suitable that
+		 * gas will like.
+		 */
+		printf(".section \".data.reloc\",\"a\"\n");
+		printf(".balign 4\n");
+
+		printf("\t .long 0x%016llx\n", relocs[0].offset);
+		prev_r_type = relocs[0].rel_type;
+
+		for(i = 1; i < reloc_count; i++) {
+			if (prev_r_type != relocs[i].rel_type && prev_r_type == R_PPC64_ADDR16_HI) {
+				printf("\t .long 0xffffffffffffffff\n");
+				prev_r_type = relocs[i].rel_type;
+			}
+			printf("\t .long 0x%016llx\n", relocs[i].offset);
+		}
+		printf("\n");
+	}
+	else {
+		unsigned char buf[8];
+		buf[0] = buf[1] = buf[2] = buf[3] = 0;
+		buf[4] = buf[5] = buf[6] = buf[7] = 0;
+
+		/* Print a stop */
+		printf("%c%c%c%c", buf[0], buf[1], buf[2], buf[3]);
+		printf("%c%c%c%c", buf[4], buf[5], buf[6], buf[7]);
+
+		buf[7] = (relocs[0].offset >>  0) & 0xff;
+		buf[6] = (relocs[0].offset >>  8) & 0xff;
+		buf[5] = (relocs[0].offset >> 16) & 0xff;
+		buf[4] = (relocs[0].offset >> 24) & 0xff;
+		buf[3] = (relocs[0].offset >> 32) & 0xff;
+		buf[2] = (relocs[0].offset >> 40) & 0xff;
+		buf[1] = (relocs[0].offset >> 48) & 0xff;
+		buf[0] = (relocs[0].offset >> 56) & 0xff;
+		printf("%c%c%c%c", buf[0], buf[1], buf[2], buf[3]);
+		printf("%c%c%c%c", buf[4], buf[5], buf[6], buf[7]);
+
+		prev_r_type = relocs[0].rel_type;
+
+		/* Now print each relocation */
+		for(i = 1; i < reloc_count; i++) {
+			if (prev_r_type != relocs[i].rel_type && prev_r_type == R_PPC64_ADDR16_HI) {
+				printf("%c%c%c%c", 0xff, 0xff, 0xff, 0xff);
+				printf("%c%c%c%c", 0xff, 0xff, 0xff, 0xff);
+				prev_r_type = relocs[i].rel_type;
+			}
+			buf[7] = (relocs[i].offset >>  0) & 0xff;
+			buf[6] = (relocs[i].offset >>  8) & 0xff;
+			buf[5] = (relocs[i].offset >> 16) & 0xff;
+			buf[4] = (relocs[i].offset >> 24) & 0xff;
+			buf[3] = (relocs[i].offset >> 32) & 0xff;
+			buf[2] = (relocs[i].offset >> 40) & 0xff;
+			buf[1] = (relocs[i].offset >> 48) & 0xff;
+			buf[0] = (relocs[i].offset >> 56) & 0xff;
+			printf("%c%c%c%c", buf[0], buf[1], buf[2], buf[3]);
+			printf("%c%c%c%c", buf[4], buf[5], buf[6], buf[7]);
+		}
+		buf[0] = buf[1] = buf[2] = buf[3] = 0;
+		buf[4] = buf[5] = buf[6] = buf[7] = 0;
+	}
+}
+
+static void usage(void)
+{
+	die("relocs [--abs-syms |--abs-relocs | --text] vmlinux\n");
+}
+
+int main(int argc, char **argv)
+{
+	int show_absolute_syms, show_absolute_relocs;
+	int as_text;
+	const char *fname;
+	FILE *fp;
+	int i;
+
+	show_absolute_syms = 0;
+	show_absolute_relocs = 0;
+	as_text = 0;
+	fname = NULL;
+	for(i = 1; i < argc; i++) {
+		char *arg = argv[i];
+		if (*arg == '-') {
+			if (strcmp(argv[1], "--abs-syms") == 0) {
+				show_absolute_syms = 1;
+				continue;
+			}
+
+			if (strcmp(argv[1], "--abs-relocs") == 0) {
+				show_absolute_relocs = 1;
+				continue;
+			}
+			else if (strcmp(argv[1], "--text") == 0) {
+				as_text = 1;
+				continue;
+			}
+		}
+		else if (!fname) {
+			fname = arg;
+			continue;
+		}
+		usage();
+	}
+	if (!fname) {
+		usage();
+	}
+	fp = fopen(fname, "r");
+	if (!fp) {
+		die("Cannot open %s: %s\n",
+			fname, strerror(errno));
+	}
+	read_ehdr(fp);
+	read_shdrs(fp);
+	read_strtabs(fp);
+	read_symtabs(fp);
+	read_relocs(fp);
+	if (show_absolute_syms) {
+		print_absolute_symbols();
+		return 0;
+	}
+	if (show_absolute_relocs) {
+		print_absolute_relocs();
+		return 0;
+	}
+	emit_relocs(as_text);
+	return 0;
+}
-- 
1.5.4
