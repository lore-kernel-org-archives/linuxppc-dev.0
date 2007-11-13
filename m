Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
From: Emil Medve <Emilian.Medve@Freescale.com>
To: paulus@samba.org, rusty@rustcorp.com.au, ntl@pobox.com,
	sfr@canb.auug.org.au, behlendorf1@llnl.gov, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH v2] [POWERPC] Optimize counting distinct entries in the
	relocation sections
Date: Tue, 13 Nov 2007 10:24:04 -0600
Message-Id: <1194971044-28840-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When a module has relocation sections with tens of thousands worth of entries,
counting the distinct/unique entries only (i.e. no duplicates) at load time can
take tens of seconds and up to minutes. The sore point is the count_relocs()
function which is called as part of the architecture specific module loading
processing path:

	-> load_module()			generic
	   -> module_frob_arch_sections()	arch specific
	      -> get_plt_size()		32-bit
	      -> get_stubs_size()	64-bit
		 -> count_relocs()

(Not sure why the relocation tables could contain lots of duplicates and why
they are not trimmed at compile time by the linker. In some test cases, out of
35K relocation entries only 1.5K were distinct/unique)

The previous counting algorithm was having O(n^2) complexity. Basically two
solutions were proposed on the e-mail list: a hash based approach and a sort
based approach

The hash based approach is the fastest (O(n)) but the has it needs additional
memory and for certain corner cases it could take lots of memory due to the
degeneration of the hash. One such proposal was submitted here:

http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037641.html

In this proposal, the symbol + addendum are hashed to generate a key and a
pointer to the relocation entry will be stored in it. The hash is implemented as
a linked list of memory pages with PAGE_SIZE / sizeof(Elfxx_Rela *) entries. In
case of collisions in all the existing pages, a new page is added to the list to
accommodate the new distinct relocation entry

For 32-bit PowerPCs with 4K pages, a page can accommodate 1K worth of pointers
to relocation entries. In the 35K entries scenario, as much/little of six (6)
pages could be allocated using 24K of extra memory during the module load

The sort based approach is slower (O(n * log n + n)) but if the sorting is done
"in place" it doesn't need additional memory. A proposal was submitted here:

http://ozlabs.org/pipermail/linuxppc-dev/2007-November/045854.html
(http://patchwork.ozlabs.org/linuxppc/patch?filter=default&id=14573)

In this proposal an array of pointers to the relocation entries is built and
then is sorted using the kernel sort() utility function. This is basically a heap
sort algorithm with a stable O(n * log n) complexity. With this counting the
distinct/unique entries is just linear (O(n)) complexity. The problem is the
extra memory needed in this proposal, which in the 35K relocation entries test
case it can be as much as 140K (for 32-bit PowerPCs; double for 64-bit). This is
much more then the memory needed by the hash based approach described
above/earlier but it doesn't hide potential degenerative corner cases

The current patch is a happy compromise between the two proposals above:
O(n + n * log n) performance with no additional memory requirements due to
sorting in place the relocation table itself

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

This patch only tries to address counting the distinct R_PPC_REL24 entries for
the purpose of sizing the PLT. This operation was/can be detected by the proper
kernel logic as a soft lockup for large relocation tables

A related optimization (that could cause rewriting the this patch) is to
optimize the PLT search from do_plt_call() but that doesn't seem to be a
problem right now

The errors below are false positives due to the fact that Elfxx_Rela are
falsely assumed to be variables/operands instead of types:

linux-2.6> scripts/checkpatch.pl 0001-POWERPC-Optimize-counting-distinct-entries-in-the.patch 
ERROR: need consistent spacing around '*' (ctx:WxV)
#116: FILE: arch/powerpc/kernel/module_32.c:78:
+       const Elf32_Rela *x, *y;
                         ^

ERROR: need consistent spacing around '*' (ctx:WxV)
#228: FILE: arch/powerpc/kernel/module_64.c:122:
+       const Elf64_Rela *x, *y;
                         ^

total: 2 errors, 0 warnings, 218 lines checked
Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

 arch/powerpc/kernel/module_32.c |   77 ++++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/module_64.c |   81 ++++++++++++++++++++++++++++++--------
 2 files changed, 127 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 07a89a3..eab3138 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/cache.h>
 #include <linux/bug.h>
+#include <linux/sort.h>
 
 #include "setup.h"
 
@@ -54,22 +55,60 @@ void module_free(struct module *mod, void *module_region)
    addend) */
 static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
 {
-	unsigned int i, j, ret = 0;
-
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
-	for (i = 0; i < num; i++) {
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (ELF32_R_SYM(rela[i].r_info)
-			    == ELF32_R_SYM(rela[j].r_info)
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
+	unsigned int i, r_info, r_addend, _count_relocs;
+
+	_count_relocs = 0;
+	r_info = 0;
+	r_addend = 0;
+	for (i = 0; i < num; i++)
+		/* Only count 24-bit relocs, others don't need stubs */
+		if (ELF32_R_TYPE(rela[i].r_info) == R_PPC_REL24 &&
+		    (r_info != ELF32_R_SYM(rela[i].r_info) ||
+		     r_addend != rela[i].r_addend)) {
+			_count_relocs++;
+			r_info = ELF32_R_SYM(rela[i].r_info);
+			r_addend = rela[i].r_addend;
 		}
-		if (j == i) ret++;
+
+	return _count_relocs;
+}
+
+static int relacmp(const void *_x, const void *_y)
+{
+	const Elf32_Rela *x, *y;
+
+	y = (Elf32_Rela *)_x;
+	x = (Elf32_Rela *)_y;
+
+	/* Compare the entire r_info (as opposed to ELF32_R_SYM(r_info) only) to
+	 * make the comparison cheaper/faster. It won't affect the sorting or
+	 * the counting algorithms' performance
+	 */
+	if (x->r_info < y->r_info)
+		return -1;
+	else if (x->r_info > y->r_info)
+		return 1;
+	else if (x->r_addend < y->r_addend)
+		return -1;
+	else if (x->r_addend > y->r_addend)
+		return 1;
+	else
+		return 0;
+}
+
+static void relaswap(void *_x, void *_y, int size)
+{
+	uint32_t *x, *y, tmp;
+	int i;
+
+	y = (uint32_t *)_x;
+	x = (uint32_t *)_y;
+
+	for (i = 0; i < sizeof(Elf32_Rela) / sizeof(uint32_t); i++) {
+		tmp = x[i];
+		x[i] = y[i];
+		y[i] = tmp;
 	}
-	return ret;
 }
 
 /* Get the potential trampolines size required of the init and
@@ -100,6 +139,16 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 			DEBUGP("Ptr: %p.  Number: %u\n",
 			       (void *)hdr + sechdrs[i].sh_offset,
 			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
+
+			/* Sort the relocation information based on a symbol and
+			 * addend key. This is a stable O(n*log n) complexity
+			 * alogrithm but it will reduce the complexity of
+			 * count_relocs() to linear complexity O(n)
+			 */
+			sort((void *)hdr + sechdrs[i].sh_offset,
+			     sechdrs[i].sh_size / sizeof(Elf32_Rela),
+			     sizeof(Elf32_Rela), relacmp, relaswap);
+
 			ret += count_relocs((void *)hdr
 					     + sechdrs[i].sh_offset,
 					     sechdrs[i].sh_size
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 75c7c4f..3a82b02 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -24,6 +24,7 @@
 #include <asm/module.h>
 #include <asm/uaccess.h>
 #include <asm/firmware.h>
+#include <linux/sort.h>
 
 #include "setup.h"
 
@@ -81,25 +82,23 @@ static struct ppc64_stub_entry ppc64_stub =
    different addend) */
 static unsigned int count_relocs(const Elf64_Rela *rela, unsigned int num)
 {
-	unsigned int i, j, ret = 0;
+	unsigned int i, r_info, r_addend, _count_relocs;
 
 	/* FIXME: Only count external ones --RR */
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
-	for (i = 0; i < num; i++) {
+	_count_relocs = 0;
+	r_info = 0;
+	r_addend = 0;
+	for (i = 0; i < num; i++)
 		/* Only count 24-bit relocs, others don't need stubs */
-		if (ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24)
-			continue;
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (rela[i].r_info == rela[j].r_info
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
+		if (ELF64_R_TYPE(rela[i].r_info) == R_PPC_REL24 &&
+		    (r_info != ELF64_R_SYM(rela[i].r_info) ||
+		     r_addend != rela[i].r_addend)) {
+			_count_relocs++;
+			r_info = ELF64_R_SYM(rela[i].r_info);
+			r_addend = rela[i].r_addend;
 		}
-		if (j == i) ret++;
-	}
-	return ret;
+
+	return _count_relocs;
 }
 
 void *module_alloc(unsigned long size)
@@ -118,6 +117,44 @@ void module_free(struct module *mod, void *module_region)
            table entries. */
 }
 
+static int relacmp(const void *_x, const void *_y)
+{
+	const Elf64_Rela *x, *y;
+
+	y = (Elf64_Rela *)_x;
+	x = (Elf64_Rela *)_y;
+
+	/* Compare the entire r_info (as opposed to ELF64_R_SYM(r_info) only) to
+	 * make the comparison cheaper/faster. It won't affect the sorting or
+	 * the counting algorithms' performance
+	 */
+	if (x->r_info < y->r_info)
+		return -1;
+	else if (x->r_info > y->r_info)
+		return 1;
+	else if (x->r_addend < y->r_addend)
+		return -1;
+	else if (x->r_addend > y->r_addend)
+		return 1;
+	else
+		return 0;
+}
+
+static void relaswap(void *_x, void *_y, int size)
+{
+	uint64_t *x, *y, tmp;
+	int i;
+
+	y = (uint64_t *)_x;
+	x = (uint64_t *)_y;
+
+	for (i = 0; i < sizeof(Elf64_Rela) / sizeof(uint64_t); i++) {
+		tmp = x[i];
+		x[i] = y[i];
+		y[i] = tmp;
+	}
+}
+
 /* Get size of potential trampolines required. */
 static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 				    const Elf64_Shdr *sechdrs)
@@ -133,6 +170,16 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 			DEBUGP("Ptr: %p.  Number: %lu\n",
 			       (void *)sechdrs[i].sh_addr,
 			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
+
+			/* Sort the relocation information based on a symbol and
+			 * addend key. This is a stable O(n*log n) complexity
+			 * alogrithm but it will reduce the complexity of
+			 * count_relocs() to linear complexity O(n)
+			 */
+			sort((void *)sechdrs[i].sh_addr,
+			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
+			     sizeof(Elf64_Rela), relacmp, relaswap);
+
 			relocs += count_relocs((void *)sechdrs[i].sh_addr,
 					       sechdrs[i].sh_size
 					       / sizeof(Elf64_Rela));
@@ -343,7 +390,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			/* Simply set it */
 			*(u32 *)location = value;
 			break;
-			
+
 		case R_PPC64_ADDR64:
 			/* Simply set it */
 			*(unsigned long *)location = value;
@@ -399,7 +446,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			}
 
 			/* Only replace bits 2 through 26 */
-			*(uint32_t *)location 
+			*(uint32_t *)location
 				= (*(uint32_t *)location & ~0x03fffffc)
 				| (value & 0x03fffffc);
 			break;
-- 
1.5.3.GIT
