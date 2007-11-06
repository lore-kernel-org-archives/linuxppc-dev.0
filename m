Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 95635DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 13:34:09 +1100 (EST)
Date: Mon, 5 Nov 2007 20:33:55 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: [RFC/PATCH] reduce load time for modules with lots of relocs
Message-ID: <20071106023355.GJ9695@localdomain>
References: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
	<20071101235728.GE9695@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071101235728.GE9695@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Medve Emilian-EMMEDVE1 wrote:
> > 
> > I have module with 36K relocation entries (I know, I know, how could
> > that be...) and the count_relocs() function takes ~17 seconds to crunch
> > through the relocation table from the .rela.text section. I don't think
> > I can reduce the number of entries in the relocation table (can I?) so
> > I'm thinking at improving the performance of count_relocs() (currently
> > O(n^2)). Does anybody have a simpler idea? Does anyone have any
> > constructive suggestion on how to improve the situation?
> 
> This seems to come up every few months.  There was a patch submitted
> here:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037641.html

I think this comes up often enough for us to fix it (IIRC unionfs
people complained about it long ago too), and it's kind of lame to
spend 17 seconds in the kernel without scheduling.  So I dug up some
old patches that should reduce the complexity to O(n logn), using the
sort() function, which IMO is preferable to doing our own hash thing
as that patch from June does.  Only the 64-bit code is tested.  Does
this help your situation?

 arch/powerpc/kernel/module_32.c |   85 +++++++++++++++++++++++++++++++---------
 arch/powerpc/kernel/module_64.c |   80 ++++++++++++++++++++++++++++++-------
 2 files changed, 132 insertions(+), 33 deletions(-)


diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 07a89a3..001b941 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/cache.h>
 #include <linux/bug.h>
+#include <linux/sort.h>
 
 #include "setup.h"
 
@@ -50,26 +51,64 @@ void module_free(struct module *mod, void *module_region)
            table entries. */
 }
 
+static int reloc_cmp(const void *_a, const void *_b)
+{
+	const Elf32_Rela *a = *(Elf32_Rela **)_a, *b = *(Elf32_Rela **)_b;
+
+	if (a->r_info < b->r_info)
+		return -1;
+	else if (a->r_info > b->r_info)
+		return 1;
+	else if (a->r_addend < b->r_addend)
+		return -1;
+	else if (a->r_addend > b->r_addend)
+		return 1;
+
+	return 0;
+}
+
+
 /* Count how many different relocations (different symbol, different
    addend) */
 static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
 {
-	unsigned int i, j, ret = 0;
+	unsigned int i, sorted_count = 0;
+	Elf32_Word last_info;
+	Elf32_Sword last_addend;
+	Elf32_Rela **sortbuf = NULL;
+
+	if (num == 0)
+		return 0;
+
+	sortbuf = vmalloc(num * sizeof(*sortbuf));
+
+	if (!sortbuf)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++)
+		sortbuf[i] = (Elf32_Rela *)&rela[i];
+
+	sort(sortbuf, i, sizeof(sortbuf[0]), reloc_cmp, NULL);
+
+	last_info = sortbuf[0]->r_info;
+	last_addend = sortbuf[0]->r_addend;
+	sorted_count = 1;
 
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
 	for (i = 0; i < num; i++) {
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (ELF32_R_SYM(rela[i].r_info)
-			    == ELF32_R_SYM(rela[j].r_info)
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
-		}
-		if (j == i) ret++;
+		/* If this r_info,r_addend tuple matches the previous
+		 * entry, don't count it again
+		 */
+		if (sortbuf[i]->r_info == last_info &&
+		    sortbuf[i]->r_addend == last_addend)
+			continue;
+
+		last_info = sortbuf[i]->r_info;
+		last_addend = sortbuf[i]->r_addend;
+		sorted_count++;
 	}
-	return ret;
+
+	vfree(sortbuf);
+	return sorted_count;
 }
 
 /* Get the potential trampolines size required of the init and
@@ -96,15 +135,19 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 			continue;
 
 		if (sechdrs[i].sh_type == SHT_RELA) {
+			int count;
 			DEBUGP("Found relocations in section %u\n", i);
 			DEBUGP("Ptr: %p.  Number: %u\n",
 			       (void *)hdr + sechdrs[i].sh_offset,
 			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
-			ret += count_relocs((void *)hdr
+			count = count_relocs((void *)hdr
 					     + sechdrs[i].sh_offset,
 					     sechdrs[i].sh_size
 					     / sizeof(Elf32_Rela))
 				* sizeof(struct ppc_plt_entry);
+			if (count < 0)
+				return count;
+			ret += count;
 		}
 	}
 
@@ -117,6 +160,7 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
 			      struct module *me)
 {
 	unsigned int i;
+	int ret;
 
 	/* Find .plt and .init.plt sections */
 	for (i = 0; i < hdr->e_shnum; i++) {
@@ -131,10 +175,15 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
 	}
 
 	/* Override their sizes */
-	sechdrs[me->arch.core_plt_section].sh_size
-		= get_plt_size(hdr, sechdrs, secstrings, 0);
-	sechdrs[me->arch.init_plt_section].sh_size
-		= get_plt_size(hdr, sechdrs, secstrings, 1);
+	ret = get_plt_size(hdr, sechdrs, secstrings, 0);
+	if (ret < 0)
+		return ret;
+	sechdrs[me->arch.core_plt_section].sh_size = ret;
+
+	ret = get_plt_size(hdr, sechdrs, secstrings, 1);
+	if (ret < 0)
+		return ret;
+	sechdrs[me->arch.init_plt_section].sh_size = ret;
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 75c7c4f..bfc5b98 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
+#include <linux/sort.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
 #include <asm/firmware.h>
@@ -77,28 +78,68 @@ static struct ppc64_stub_entry ppc64_stub =
 	0x4e, 0x80, 0x04, 0x20  /* bctr */
 } };
 
+static int reloc_cmp(const void *_a, const void *_b)
+{
+	const Elf64_Rela *a = *(Elf64_Rela **)_a, *b = *(Elf64_Rela **)_b;
+
+	if (a->r_info < b->r_info)
+		return -1;
+	else if (a->r_info > b->r_info)
+		return 1;
+	else if (a->r_addend < b->r_addend)
+		return -1;
+	else if (a->r_addend > b->r_addend)
+		return 1;
+
+	return 0;
+}
+
 /* Count how many different 24-bit relocations (different symbol,
    different addend) */
-static unsigned int count_relocs(const Elf64_Rela *rela, unsigned int num)
+static int count_relocs(const Elf64_Rela *rela, unsigned int num)
 {
 	unsigned int i, j, ret = 0;
+	Elf64_Xword last_info;
+	Elf64_Sxword last_addend;
+	Elf64_Rela **sortbuf = NULL;
+
+	if (num == 0)
+		return 0;
+
+	sortbuf = vmalloc(num * sizeof(*sortbuf));
 
-	/* FIXME: Only count external ones --RR */
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
-	for (i = 0; i < num; i++) {
+	if (!sortbuf)
+		return -ENOMEM;
+
+	for (j = 0, i = 0; i < num; i++) {
 		/* Only count 24-bit relocs, others don't need stubs */
 		if (ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24)
 			continue;
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (rela[i].r_info == rela[j].r_info
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
-		}
-		if (j == i) ret++;
+		sortbuf[j++] = (Elf64_Rela *)&rela[i];
 	}
+
+	if (j == 0)
+		goto out;
+
+	sort(sortbuf, j, sizeof(sortbuf[0]), reloc_cmp, NULL);
+
+	last_info = sortbuf[0]->r_info;
+	last_addend = sortbuf[0]->r_addend;
+	ret = 1;
+	for (i = 0; i < j; i++) {
+		/* If this r_info,r_addend tuple matches the previous
+		 * entry, don't count it again
+		 */
+		if (sortbuf[i]->r_info == last_info &&
+		    sortbuf[i]->r_addend == last_addend)
+			continue;
+
+		last_info = sortbuf[i]->r_info;
+		last_addend = sortbuf[i]->r_addend;
+		ret++;
+	}
+out:
+	vfree(sortbuf);
 	return ret;
 }
 
@@ -129,13 +170,17 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 	/* Every relocated section... */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type == SHT_RELA) {
+			int count;
 			DEBUGP("Found relocations in section %u\n", i);
 			DEBUGP("Ptr: %p.  Number: %lu\n",
 			       (void *)sechdrs[i].sh_addr,
 			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
-			relocs += count_relocs((void *)sechdrs[i].sh_addr,
+			count = count_relocs((void *)sechdrs[i].sh_addr,
 					       sechdrs[i].sh_size
 					       / sizeof(Elf64_Rela));
+			if (count < 0)
+				return count;
+			relocs += count;
 		}
 	}
 
@@ -173,6 +218,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			      struct module *me)
 {
 	unsigned int i;
+	int stubs_size;
 
 	/* Find .toc and .stubs sections, symtab and strtab */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -209,7 +255,11 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 		me->arch.toc_section = me->arch.stubs_section;
 
 	/* Override the stubs size */
-	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
+	stubs_size = get_stubs_size(hdr, sechdrs);
+	if (stubs_size < 0)
+		return stubs_size;
+
+	sechdrs[me->arch.stubs_section].sh_size = stubs_size;
 	return 0;
 }
 
