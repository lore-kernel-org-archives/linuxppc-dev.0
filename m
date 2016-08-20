Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sGL5Y3GsKzDr6p
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 10:18:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7K0DoPN040629
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:18:08 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wpdegv9s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:18:07 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 21:17:59 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1F60F3520068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:17:37 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7K0Hwal5136562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 21:17:58 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7K0Hv0e005258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 21:17:58 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v6 06/12] powerpc: Adapt elf64_apply_relocate_add for
 kexec_file_load.
Date: Fri, 19 Aug 2016 21:17:16 -0300
In-Reply-To: <1471652242-14436-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1471652242-14436-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1471652242-14436-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend elf64_apply_relocate_add to support relative symbols. This is
necessary because there is a difference between how the module loading
mechanism and the kexec purgatory loading code use Elf64_Sym.st_value
at relocation time: the former changes st_value to point to the absolute
memory address before relocating the module, while the latter does that
adjustment during relocation of the purgatory.

Also, add a check_symbols argument so that the kexec code can be stricter
about undefined symbols.

Finally, add relocation types used by the purgatory.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/elf_util.h |   2 +
 arch/powerpc/kernel/elf_util_64.c   | 100 +++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/module_64.c     |   6 ++-
 3 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
index a012ba03282d..5a27e8ceb88a 100644
--- a/arch/powerpc/include/asm/elf_util.h
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -20,6 +20,7 @@
 #include <linux/elf.h>
 
 struct elf_info {
+	const struct elfhdr *ehdr;
 	struct elf_shdr *sechdrs;
 
 	/* Index of stubs section. */
@@ -67,6 +68,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name);
 
 #endif /* _ASM_POWERPC_ELF_UTIL_H */
diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
index 8e5d400ac9f2..0a56b0faf3c8 100644
--- a/arch/powerpc/kernel/elf_util_64.c
+++ b/arch/powerpc/kernel/elf_util_64.c
@@ -74,6 +74,8 @@ static void squash_toc_save_inst(const char *name, unsigned long addr) { }
  * @syms_base:		Contents of the associated symbol table.
  * @loc_base:		Contents of the section to which relocations apply.
  * @addr_base:		The address where the section will be loaded in memory.
+ * @relative_symbols:	Are the symbols' st_value members relative?
+ * @check_symbols:	Fail if an unexpected symbol is found?
  * @obj_name:		The name of the ELF binary, for information messages.
  *
  * Applies RELA relocations to an ELF file already at its final location
@@ -84,12 +86,15 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name)
 {
 	unsigned int i;
 	unsigned long *location;
 	unsigned long address;
+	unsigned long sec_base;
 	unsigned long value;
+	int reloc_type;
 	const char *name;
 	Elf64_Sym *sym;
 
@@ -116,15 +121,45 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 		else
 			name = "<unnamed symbol>";
 
-		pr_debug("RELOC at %p: %li-type as %s (0x%lx) + %li\n",
-		       location, (long)ELF64_R_TYPE(rela[i].r_info),
-		       name, (unsigned long)sym->st_value,
+		reloc_type = ELF64_R_TYPE(rela[i].r_info);
+
+		pr_debug("RELOC at %p: %i-type as %s (0x%lx) + %li\n",
+		       location, reloc_type, name, (unsigned long)sym->st_value,
 		       (long)rela[i].r_addend);
 
+		if (check_symbols) {
+			/*
+			 * TOC symbols appear as undefined but should be
+			 * resolved as well, so allow them to be processed.
+			 */
+			if (sym->st_shndx == SHN_UNDEF &&
+					strcmp(name, ".TOC.") != 0 &&
+					reloc_type != R_PPC64_TOC) {
+				pr_err("Undefined symbol: %s\n", name);
+				return -ENOEXEC;
+			} else if (sym->st_shndx == SHN_COMMON) {
+				pr_err("Symbol '%s' in common section.\n", name);
+				return -ENOEXEC;
+			}
+		}
+
+		if (relative_symbols && sym->st_shndx != SHN_ABS) {
+			if (sym->st_shndx >= elf_info->ehdr->e_shnum) {
+				pr_err("Invalid section %d for symbol %s\n",
+				       sym->st_shndx, name);
+				return -ENOEXEC;
+			} else {
+				struct elf_shdr *sechdrs = elf_info->sechdrs;
+
+				sec_base = sechdrs[sym->st_shndx].sh_addr;
+			}
+		} else
+			sec_base = 0;
+
 		/* `Everything is relative'. */
-		value = sym->st_value + rela[i].r_addend;
+		value = sym->st_value + sec_base + rela[i].r_addend;
 
-		switch (ELF64_R_TYPE(rela[i].r_info)) {
+		switch (reloc_type) {
 		case R_PPC64_ADDR32:
 			/* Simply set it */
 			*(u32 *)location = value;
@@ -135,6 +170,10 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			*(unsigned long *)location = value;
 			break;
 
+		case R_PPC64_REL32:
+			*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
+			break;
+
 		case R_PPC64_TOC:
 			*(unsigned long *)location = my_r2(elf_info);
 			break;
@@ -186,6 +225,14 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xfffc);
 			break;
 
+		case R_PPC64_TOC16_HI:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			value = value >> 16;
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+
 		case R_PPC64_TOC16_HA:
 			/* Subtract TOC pointer */
 			value -= my_r2(elf_info);
@@ -195,6 +242,21 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xffff);
 			break;
 
+		case R_PPC64_REL14:
+			/* Convert value to relative */
+			value -= address;
+			if (value + 0x8000 > 0xffff || (value & 3) != 0) {
+				pr_err("%s: REL14 %li out of range!\n", obj_name,
+				       (long int)value);
+				return -ENOEXEC;
+			}
+
+			/* Only replace bits 2 through 16 */
+			*(uint32_t *)location
+				= (*(uint32_t *)location & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
 			if (sym->st_shndx == SHN_UNDEF) {
@@ -263,6 +325,29 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
 			break;
 
+		case R_PPC64_ADDR16_LO:
+			*(uint16_t *)location = value & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HI:
+			*(uint16_t *)location = (value >> 16) & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HA:
+			*(uint16_t *)location = (((value + 0x8000) >> 16) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHER:
+			*(uint16_t *)location = (((uint64_t)value >> 32) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHEST:
+			*(uint16_t *)location = (((uint64_t)value >> 48) &
+							0xffff);
+			break;
+
 		case R_PPC64_REL16_HA:
 			/* Subtract location pointer */
 			value -= address;
@@ -281,9 +366,8 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			break;
 
 		default:
-			pr_err("%s: Unknown ADD relocation: %lu\n",
-			       obj_name,
-			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
+			pr_err("%s: Unknown ADD relocation: %d\n", obj_name,
+			       reloc_type);
 			return -ENOEXEC;
 		}
 	}
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 590e2413974f..ff9ab8194188 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -341,6 +341,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 	sechdrs[me->arch.elf_info.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
 
 	/* For the elf_util functions. */
+	me->arch.elf_info.ehdr = hdr;
 	me->arch.elf_info.sechdrs = sechdrs;
 
 	return 0;
@@ -443,6 +444,9 @@ int restore_r2(u32 *instruction, const char *obj_name)
  * When this function is called, the module is already at its final location in
  * memory, so Elf64_Shdr.sh_addr can be used for accessing the section
  * contents as well as the base address for relocations.
+ *
+ * Also, simplify_symbols already changed all symbols' st_value members
+ * to absolute addresses.
  */
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
@@ -472,7 +476,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, rela,
 					num_rela, syms_base, (void *) addr_base,
-					addr_base, me->name);
+					addr_base, false, false, me->name);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
1.9.1
