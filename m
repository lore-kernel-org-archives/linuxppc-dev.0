Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXr95YdnzDqfM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 01:00:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsUmP042001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:07 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23je2ke2fe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:07 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 12:00:05 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8FDCD1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:55 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EF01xf48889912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:01 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EF01XJ018928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:01 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Torsten Duwe <duwe@suse.de>
Subject: [PATCH v2 5/9] powerpc: Generalize elf64_apply_relocate_add.
Date: Tue, 14 Jun 2016 11:59:05 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-6-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When apply_relocate_add is called, modules are already loaded at their
final location in memory so Elf64_Shdr.sh_addr can be used for accessing
the section contents as well as the base address for relocations.

This is not the case for kexec's purgatory, because it will only be
copied to its final location right before being executed. Therefore,
it needs to be relocated while it is still in a temporary buffer. In
this case, Elf64_Shdr.sh_addr can't be used to access the sections'
contents.

This patch allows elf64_apply_relocate_add to be used when the ELF
binary is not yet at its final location by adding an addr_base argument
to specify the address at which the section will be loaded, and rela,
loc_base and syms_base to point to the sections' contents.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Torsten Duwe <duwe@suse.de>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/elf_util.h |  6 ++--
 arch/powerpc/kernel/elf_util_64.c   | 63 +++++++++++++++++++++++++------------
 arch/powerpc/kernel/module_64.c     | 17 ++++++++--
 3 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
index 13d3ca113299..19ff3335d17d 100644
--- a/arch/powerpc/include/asm/elf_util.h
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -64,7 +64,9 @@ static inline unsigned long my_r2(const struct elf_info *elf_info)
 }
 
 int elf64_apply_relocate_add(const struct elf_info *elf_info,
-			     const char *strtab, unsigned int symindex,
-			     unsigned int relsec, const char *obj_name);
+			     const char *strtab, const Elf64_Rela *rela,
+			     unsigned int num_rela, void *syms_base,
+			     void *loc_base, Elf64_Addr addr_base,
+			     const char *obj_name);
 
 #endif /* _ASM_POWERPC_ELF_UTIL_H */
diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
index b53b3959a605..cde0420add9e 100644
--- a/arch/powerpc/kernel/elf_util_64.c
+++ b/arch/powerpc/kernel/elf_util_64.c
@@ -69,33 +69,56 @@ static void squash_toc_save_inst(const char *name, unsigned long addr) { }
  * elf64_apply_relocate_add - apply 64 bit RELA relocations
  * @elf_info:		Support information for the ELF binary being relocated.
  * @strtab:		String table for the associated symbol table.
- * @symindex:		Section header index for the associated symbol table.
- * @relsec:		Section header index for the relocations to apply.
+ * @rela:		Contents of the section with the relocations to apply.
+ * @num_rela:		Number of relocation entries in the section.
+ * @syms_base:		Contents of the associated symbol table.
+ * @loc_base:		Contents of the section to which relocations apply.
+ * @addr_base:		The address where the section will be loaded in memory.
  * @obj_name:		The name of the ELF binary, for information messages.
+ *
+ * Applies RELA relocations to an ELF file already at its final location
+ * in memory (in which case loc_base == addr_base), or still in a temporary
+ * buffer.
  */
 int elf64_apply_relocate_add(const struct elf_info *elf_info,
-			     const char *strtab, unsigned int symindex,
-			     unsigned int relsec, const char *obj_name)
+			     const char *strtab, const Elf64_Rela *rela,
+			     unsigned int num_rela, void *syms_base,
+			     void *loc_base, Elf64_Addr addr_base,
+			     const char *obj_name)
 {
 	unsigned int i;
-	Elf64_Shdr *sechdrs = elf_info->sechdrs;
-	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
-	Elf64_Sym *sym;
 	unsigned long *location;
+	unsigned long address;
 	unsigned long value;
+	const char *name;
+	Elf64_Sym *sym;
+
+	for (i = 0; i < num_rela; i++) {
+		/*
+		 * rels[i].r_offset contains the byte offset from the beginning
+		 * of section to the storage unit affected.
+		 *
+		 * This is the location to update in the temporary buffer where
+		 * the section is currently loaded. The section will finally
+		 * be loaded to a different address later, pointed to by
+		 * addr_base.
+		 */
+		location = loc_base + rela[i].r_offset;
+
+		/* Final address of the location. */
+		address = addr_base + rela[i].r_offset;
 
+		/* This is the symbol the relocation is referring to. */
+		sym = (Elf64_Sym *) syms_base + ELF64_R_SYM(rela[i].r_info);
 
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rela[i].r_offset;
-		/* This is the symbol it is referring to */
-		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
-			+ ELF64_R_SYM(rela[i].r_info);
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else
+			name = "<unnamed symbol>";
 
 		pr_debug("RELOC at %p: %li-type as %s (0x%lx) + %li\n",
 		       location, (long)ELF64_R_TYPE(rela[i].r_info),
-		       strtab + sym->st_name, (unsigned long)sym->st_value,
+		       name, (unsigned long)sym->st_value,
 		       (long)rela[i].r_addend);
 
 		/* `Everything is relative'. */
@@ -187,7 +210,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				value += local_entry_offset(sym);
 
 			/* Convert value to relative */
-			value -= (unsigned long)location;
+			value -= address;
 			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
 				pr_err("%s: REL24 %li out of range!\n",
 				       obj_name, (long int)value);
@@ -202,7 +225,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 
 		case R_PPC64_REL64:
 			/* 64 bits relative (used by features fixups) */
-			*location = value - (unsigned long)location;
+			*location = value - address;
 			break;
 
 		case R_PPC64_TOCSAVE:
@@ -218,7 +241,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			 * Optimize ELFv2 large code model entry point if
 			 * the TOC is within 2GB range of current location.
 			 */
-			value = my_r2(elf_info) - (unsigned long)location;
+			value = my_r2(elf_info) - address;
 			if (value + 0x80008000 > 0xffffffff)
 				break;
 			/*
@@ -242,7 +265,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 
 		case R_PPC64_REL16_HA:
 			/* Subtract location pointer */
-			value -= (unsigned long)location;
+			value -= address;
 			value = ((value + 0x8000) >> 16);
 			*((uint16_t *) location)
 				= (*((uint16_t *) location) & ~0xffff)
@@ -251,7 +274,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 
 		case R_PPC64_REL16_LO:
 			/* Subtract location pointer */
-			value -= (unsigned long)location;
+			value -= address;
 			*((uint16_t *) location)
 				= (*((uint16_t *) location) & ~0xffff)
 				| (value & 0xffff);
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 5f2eeab93651..a3cb0f6e83bb 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -438,16 +438,26 @@ int restore_r2(u32 *instruction, const char *obj_name)
 	return 1;
 }
 
+/*
+ * When this function is called, the module is already at its final location in
+ * memory, so Elf64_Shdr.sh_addr can be used for accessing the section
+ * contents as well as the base address for relocations.
+ */
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
 		       unsigned int relsec,
 		       struct module *me)
 {
+	Elf64_Shdr *rel_section = &sechdrs[relsec];
+	void *syms_base = (void *) sechdrs[symindex].sh_addr;
+	Elf64_Addr addr_base = sechdrs[rel_section->sh_info].sh_addr;
+	const Elf64_Rela *rela = (const Elf64_Rela *) rel_section->sh_addr;
+	unsigned int num_rela = rel_section->sh_size / sizeof(Elf64_Rela);
 	Elf64_Sym *sym;
 
 	pr_debug("Applying ADD relocate section %u to %u\n", relsec,
-	       sechdrs[relsec].sh_info);
+		 rel_section->sh_info);
 
 	/* First time we're called, we can fix up .TOC. */
 	if (!me->arch.toc_fixed) {
@@ -459,8 +469,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		me->arch.toc_fixed = true;
 	}
 
-	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, symindex,
-					relsec, me->name);
+	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, rela,
+					num_rela, syms_base, (void *) addr_base,
+					addr_base, me->name);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
1.9.1
