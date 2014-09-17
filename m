Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F20E1A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:42 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/6] powerpc: Use pr_fmt in module loader code
Date: Wed, 17 Sep 2014 14:39:35 +1000
Message-Id: <1410928779-20938-2-git-send-email-anton@samba.org>
In-Reply-To: <1410928779-20938-1-git-send-email-anton@samba.org>
References: <1410928779-20938-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use pr_fmt to give some context to the error messages in the
module code, and convert open coded debug printk to pr_debug.

Use pr_err for error messages.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/module_32.c | 31 ++++++++++++++-----------------
 arch/powerpc/kernel/module_64.c | 36 +++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 6cff040..c94d2e0 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -15,6 +15,9 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
@@ -28,12 +31,6 @@
 #include <linux/sort.h>
 #include <asm/setup.h>
 
-#if 0
-#define DEBUGP printk
-#else
-#define DEBUGP(fmt , ...)
-#endif
-
 /* Count how many different relocations (different symbol, different
    addend) */
 static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
@@ -121,8 +118,8 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 			continue;
 
 		if (sechdrs[i].sh_type == SHT_RELA) {
-			DEBUGP("Found relocations in section %u\n", i);
-			DEBUGP("Ptr: %p.  Number: %u\n",
+			pr_debug("Found relocations in section %u\n", i);
+			pr_debug("Ptr: %p.  Number: %u\n",
 			       (void *)hdr + sechdrs[i].sh_offset,
 			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
 
@@ -161,7 +158,7 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
 			me->arch.core_plt_section = i;
 	}
 	if (!me->arch.core_plt_section || !me->arch.init_plt_section) {
-		printk("Module doesn't contain .plt or .init.plt sections.\n");
+		pr_err("Module doesn't contain .plt or .init.plt sections.\n");
 		return -ENOEXEC;
 	}
 
@@ -189,7 +186,7 @@ static uint32_t do_plt_call(void *location,
 {
 	struct ppc_plt_entry *entry;
 
-	DEBUGP("Doing plt for call to 0x%x at 0x%x\n", val, (unsigned int)location);
+	pr_debug("Doing plt for call to 0x%x at 0x%x\n", val, (unsigned int)location);
 	/* Init, or core PLT? */
 	if (location >= mod->module_core
 	    && location < mod->module_core + mod->core_size)
@@ -208,7 +205,7 @@ static uint32_t do_plt_call(void *location,
 	entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
 	entry->jump[3] = 0x4e800420;			/* bctr */
 
-	DEBUGP("Initialized plt for 0x%x at %p\n", val, entry);
+	pr_debug("Initialized plt for 0x%x at %p\n", val, entry);
 	return (uint32_t)entry;
 }
 
@@ -224,7 +221,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 	uint32_t *location;
 	uint32_t value;
 
-	DEBUGP("Applying ADD relocate section %u to %u\n", relsec,
+	pr_debug("Applying ADD relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
 		/* This is where to make the change */
@@ -268,17 +265,17 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 						    sechdrs, module);
 
 			/* Only replace bits 2 through 26 */
-			DEBUGP("REL24 value = %08X. location = %08X\n",
+			pr_debug("REL24 value = %08X. location = %08X\n",
 			       value, (uint32_t)location);
-			DEBUGP("Location before: %08X.\n",
+			pr_debug("Location before: %08X.\n",
 			       *(uint32_t *)location);
 			*(uint32_t *)location
 				= (*(uint32_t *)location & ~0x03fffffc)
 				| ((value - (uint32_t)location)
 				   & 0x03fffffc);
-			DEBUGP("Location after: %08X.\n",
+			pr_debug("Location after: %08X.\n",
 			       *(uint32_t *)location);
-			DEBUGP("ie. jump to %08X+%08X = %08X\n",
+			pr_debug("ie. jump to %08X+%08X = %08X\n",
 			       *(uint32_t *)location & 0x03fffffc,
 			       (uint32_t)location,
 			       (*(uint32_t *)location & 0x03fffffc)
@@ -291,7 +288,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			break;
 
 		default:
-			printk("%s: unknown ADD relocation: %u\n",
+			pr_err("%s: unknown ADD relocation: %u\n",
 			       module->name,
 			       ELF32_R_TYPE(rela[i].r_info));
 			return -ENOEXEC;
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index d807ee6..6838451 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -15,6 +15,9 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/elf.h>
 #include <linux/moduleloader.h>
@@ -36,11 +39,6 @@
    Using a magic allocator which places modules within 32MB solves
    this, and makes other things simpler.  Anton?
    --RR.  */
-#if 0
-#define DEBUGP printk
-#else
-#define DEBUGP(fmt , ...)
-#endif
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
 #define R2_STACK_OFFSET 24
@@ -279,8 +277,8 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 	/* Every relocated section... */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type == SHT_RELA) {
-			DEBUGP("Found relocations in section %u\n", i);
-			DEBUGP("Ptr: %p.  Number: %lu\n",
+			pr_debug("Found relocations in section %u\n", i);
+			pr_debug("Ptr: %p.  Number: %Lu\n",
 			       (void *)sechdrs[i].sh_addr,
 			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
 
@@ -304,7 +302,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 	relocs++;
 #endif
 
-	DEBUGP("Looks like a total of %lu stubs, max\n", relocs);
+	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
 	return relocs * sizeof(struct ppc64_stub_entry);
 }
 
@@ -390,7 +388,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 	}
 
 	if (!me->arch.stubs_section) {
-		printk("%s: doesn't contain .stubs.\n", me->name);
+		pr_err("%s: doesn't contain .stubs.\n", me->name);
 		return -ENOEXEC;
 	}
 
@@ -434,11 +432,11 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 	/* Stub uses address relative to r2. */
 	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
-		printk("%s: Address %p of stub out of range of %p.\n",
+		pr_err("%s: Address %p of stub out of range of %p.\n",
 		       me->name, (void *)reladdr, (void *)my_r2);
 		return 0;
 	}
-	DEBUGP("Stub %p get data from reladdr %li\n", entry, reladdr);
+	pr_debug("Stub %p get data from reladdr %li\n", entry, reladdr);
 
 	entry->jump[0] |= PPC_HA(reladdr);
 	entry->jump[1] |= PPC_LO(reladdr);
@@ -477,7 +475,7 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
-		printk("%s: Expect noop after relocate, got %08x\n",
+		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
 	}
@@ -498,7 +496,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	unsigned long *location;
 	unsigned long value;
 
-	DEBUGP("Applying ADD relocate section %u to %u\n", relsec,
+	pr_debug("Applying ADD relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 
 	/* First time we're called, we can fix up .TOC. */
@@ -519,7 +517,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rela[i].r_info);
 
-		DEBUGP("RELOC at %p: %li-type as %s (%lu) + %li\n",
+		pr_debug("RELOC at %p: %li-type as %s (0x%lx) + %li\n",
 		       location, (long)ELF64_R_TYPE(rela[i].r_info),
 		       strtab + sym->st_name, (unsigned long)sym->st_value,
 		       (long)rela[i].r_addend);
@@ -546,7 +544,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if (value + 0x8000 > 0xffff) {
-				printk("%s: bad TOC16 relocation (%lu)\n",
+				pr_err("%s: bad TOC16 relocation (0x%lx)\n",
 				       me->name, value);
 				return -ENOEXEC;
 			}
@@ -567,7 +565,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
-				printk("%s: bad TOC16_DS relocation (%lu)\n",
+				pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
 				       me->name, value);
 				return -ENOEXEC;
 			}
@@ -580,7 +578,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if ((value & 3) != 0) {
-				printk("%s: bad TOC16_LO_DS relocation (%lu)\n",
+				pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
 				       me->name, value);
 				return -ENOEXEC;
 			}
@@ -613,7 +611,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			/* Convert value to relative */
 			value -= (unsigned long)location;
 			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
-				printk("%s: REL24 %li out of range!\n",
+				pr_err("%s: REL24 %li out of range!\n",
 				       me->name, (long int)value);
 				return -ENOEXEC;
 			}
@@ -655,7 +653,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			break;
 
 		default:
-			printk("%s: Unknown ADD relocation: %lu\n",
+			pr_err("%s: Unknown ADD relocation: %lu\n",
 			       me->name,
 			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
 			return -ENOEXEC;
-- 
1.9.1
