Return-Path: <behlendorf1@llnl.gov>
Received: from nspiron-1.llnl.gov (nspiron-1.llnl.gov [128.115.41.81])
	by ozlabs.org (Postfix) with ESMTP id 6CCA8DDD05
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 11:10:13 +1000 (EST)
From: Brian Behlendorf <behlendorf1@llnl.gov>
To: linuxppc-dev@ozlabs.org
Subject: PATCH improve worst case module load times
Date: Mon, 11 Jun 2007 18:00:19 -0700
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jAfbGs1zunqmYlL"
Message-Id: <200706111800.19111.behlendorf1@llnl.gov>
Reply-To: behlendorf1@llnl.gov
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_jAfbGs1zunqmYlL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Recently I ran in to an apparently well known ppc/ppc64 issue regarding slow 
module load times which I see was posted to lkml back on '05.

   http://lkml.org/lkml/2005/9/28/180

  In my environment I'm forced to live with a few very large kernel modules 
and frequent reboots so this was become a bit of an issue.  I took a look at 
the root cause and put together a patch to address the issue.  The proposed 
patch resolves the problem by removing the order(n^2) algorithm and replaces 
it with an order(n) chained hash.

  It works well for me but I'm not a powerpc guru so I'd appreciate a review 
of the patch.  I thought about posting it to lkml but after I learned there 
was a ppc dev list this seemed like the right place to post.
  
-- 
Thanks,
Brian Behlendorf
behlendorf1@llnl.gov

--Boundary-00=_jAfbGs1zunqmYlL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="powerpc-reloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="powerpc-reloc.diff"

Author: Brian Behlendorf <behlendorf1@llnl.gov>, LLNL
Date:   Mon Jun 11 2007

For ppc and ppc64 replace the O(N^2) algorithm used to calculate unique 
relocations with a O(N) chained hash.  The only significant downside to 
the new algorithm is that is requires at least one memory allocation.
Allocation size is limited to a single page and the kernel is given every
opportunity to satisfy the request.  In the unlikely event of a memory 
allocation failure the module will fail to load and -ENOMEM will be 
returned up the stack.  

The performance improvement on my embedded ppc dev system was dramatic.  
Without the patch it took 35 seconds to load the desired module stack
which contained a few worst case modules with a large number of 
relocatable symbols.  With the patch the time dropped to less than 1 
second.

While I didn't do any extensive testing the small module case may be
slightly impacted due to the addition of the page alloc.  If this is
a concern the patch could be reworked to choose either the O(N^2) or
O(N) algorithm based on the number of symbols.  This would give us
the best of both worlds.
    
Signed-off-by: Brian Behlendorf <behlendorf1@llnl.gov>

--- arch/powerpc/kernel/module_64.c.orig	2007-06-11 11:13:23.877345417 -0700
+++ arch/powerpc/kernel/module_64.c	2007-06-11 14:22:23.287707424 -0700
@@ -77,30 +77,15 @@
 	0x4e, 0x80, 0x04, 0x20  /* bctr */
 } };
 
-/* Count how many different 24-bit relocations (different symbol,
-   different addend) */
-static unsigned int count_relocs(const Elf64_Rela *rela, unsigned int num)
-{
-	unsigned int i, j, ret = 0;
-
-	/* FIXME: Only count external ones --RR */
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
-	for (i = 0; i < num; i++) {
-		/* Only count 24-bit relocs, others don't need stubs */
-		if (ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24)
-			continue;
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (rela[i].r_info == rela[j].r_info
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
-		}
-		if (j == i) ret++;
-	}
-	return ret;
-}
+#define HASH_RELOC_NEXT          (PAGE_SIZE / sizeof(Elf64_Rela *) - 1)
+
+struct hash_reloc {
+	/* Page full of Elf64_Rela pointers; increasing the hash depth is
+	 * accomplished by chaining pages of the ptr element in the page. */
+	Elf64_Rela **r_page;
+	int r_depth;
+	int r_duplicate;
+};
 
 void *module_alloc(unsigned long size)
 {
@@ -118,12 +103,112 @@
            table entries. */
 }
 
+/* Hash function for unique relocations */
+static unsigned hash_reloc_key(const Elf64_Rela *r)
+{
+	return ((ELF64_R_SYM(r->r_info) + r->r_addend) % HASH_RELOC_NEXT);
+}
+
+/* Hash insert can return -errno or number of inserted elements,
+ * duplicate elements will not be inserted in the hash and return 0. */
+static long hash_reloc_insert(struct hash_reloc *hash,
+			      Elf64_Rela *r1, unsigned key)
+{
+	Elf64_Rela **p1 = hash->r_page, **p2 = NULL;
+	unsigned i = 0;
+
+	while (p1 && p1[key]) {
+
+		/* Check for duplicates */
+		if ((r1->r_info == p1[key]->r_info) &&
+		    (r1->r_addend == p1[key]->r_addend)) {
+			hash->r_duplicate++;
+			return 0;
+		}
+
+		p2 = p1;
+		p1 = (Elf64_Rela **)p2[HASH_RELOC_NEXT];
+		i++;
+	}
+
+	if (i >= hash->r_depth) {
+		p1 = (Elf64_Rela **)get_zeroed_page(GFP_KERNEL);
+		if (!p1) {
+			printk("Unable to allocate memory for module\n");
+			return -ENOMEM;
+		}
+
+		hash->r_depth++;
+		p2[HASH_RELOC_NEXT] = (Elf64_Rela *)p1;
+	}
+
+	p1[key] = r1;
+	return 1;
+}
+
+static long hash_reloc_init(struct hash_reloc *hash)
+{
+	if (!(hash->r_page = (Elf64_Rela **)get_zeroed_page(GFP_KERNEL))) {
+		printk("Unable to allocate memory for module\n");
+		return -ENOMEM;
+	}
+
+	hash->r_depth = 1;
+	hash->r_duplicate = 0;
+	return 0;
+}
+
+static void hash_reloc_cleanup(struct hash_reloc *hash)
+{
+	Elf64_Rela **p1, **p2;
+
+	p1 = hash->r_page;
+	while (p1) {
+		p2 = (Elf64_Rela **)p1[HASH_RELOC_NEXT];
+		free_page((unsigned long)p1);
+		p1 = p2;
+	}
+}
+
+/* Count how many unique 24-bit relocations (different symbol and addend) */
+static long count_relocs(const Elf64_Rela *rela, unsigned int num)
+{
+	struct hash_reloc hash;
+	Elf64_Rela *r;
+	long rc, ret = 0;
+	unsigned i, key;
+
+	hash_reloc_init(&hash);
+
+	/* Use a chained hash with a uniform key for an order(N) algorithm */
+	for (i = 0; i < num; i++) {
+		r = (Elf64_Rela *)&rela[i];
+		key = hash_reloc_key(r);
+
+		/* Only count 24-bit relocs, others don't need stubs */
+		if (ELF64_R_TYPE(r->r_info) != R_PPC_REL24)
+			continue;
+
+		if ((rc = hash_reloc_insert(&hash, r, key)) < 0) {
+			ret = rc;
+			break;
+		}
+
+		ret += rc;
+	}
+
+	DEBUGP("Symbols %d, duplicates %d, depth %d\n",
+	       num, hash.r_duplicate, hash.r_depth);
+	hash_reloc_cleanup(&hash);
+	return ret;
+}
+
 /* Get size of potential trampolines required. */
-static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
-				    const Elf64_Shdr *sechdrs)
+static long get_stubs_size(const Elf64_Ehdr *hdr,
+			   const Elf64_Shdr *sechdrs)
 {
 	/* One extra reloc so it's always 0-funcaddr terminated */
-	unsigned long relocs = 1;
+	long rc, ret = sizeof(struct ppc64_stub_entry);
 	unsigned i;
 
 	/* Every relocated section... */
@@ -133,14 +218,17 @@
 			DEBUGP("Ptr: %p.  Number: %lu\n",
 			       (void *)sechdrs[i].sh_addr,
 			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
-			relocs += count_relocs((void *)sechdrs[i].sh_addr,
-					       sechdrs[i].sh_size
-					       / sizeof(Elf64_Rela));
+			rc = count_relocs((void *)sechdrs[i].sh_addr,
+					  sechdrs[i].sh_size /
+					  sizeof(Elf64_Rela));
+			if (rc < 0)
+				return rc;
+
+			ret += (rc * sizeof(struct ppc64_stub_entry));
 		}
 	}
 
-	DEBUGP("Looks like a total of %lu stubs, max\n", relocs);
-	return relocs * sizeof(struct ppc64_stub_entry);
+	return ret;
 }
 
 static void dedotify_versions(struct modversion_info *vers,
@@ -172,7 +260,8 @@
 			      char *secstrings,
 			      struct module *me)
 {
-	unsigned int i;
+	unsigned i;
+	long rc;
 
 	/* Find .toc and .stubs sections, symtab and strtab */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -209,7 +298,10 @@
 		me->arch.toc_section = me->arch.stubs_section;
 
 	/* Override the stubs size */
-	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
+	if ((rc = get_stubs_size(hdr, sechdrs)) < 0)
+		return rc;
+
+	sechdrs[me->arch.stubs_section].sh_size = rc;
 	return 0;
 }
 
--- arch/powerpc/kernel/module_32.c.orig	2007-06-11 13:24:52.440788813 -0700
+++ arch/powerpc/kernel/module_32.c	2007-06-11 14:13:07.998973232 -0700
@@ -35,6 +35,16 @@
 
 LIST_HEAD(module_bug_list);
 
+#define HASH_RELOC_NEXT          (PAGE_SIZE / sizeof(Elf32_Rela *) - 1)
+
+struct hash_reloc {
+	/* Page full of Elf32_Rela pointers; increasing the hash depth is
+	 * accomplished by chaining pages of the ptr element in the page. */
+	Elf32_Rela **r_page;
+	int r_depth;
+	int r_duplicate;
+};
+
 void *module_alloc(unsigned long size)
 {
 	if (size == 0)
@@ -50,36 +60,109 @@
            table entries. */
 }
 
-/* Count how many different relocations (different symbol, different
-   addend) */
-static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
+/* Hash function for unique relocations */
+static unsigned hash_reloc_key(const Elf32_Rela *r)
+{
+	return ((ELF32_R_SYM(r->r_info) + r->r_addend) % HASH_RELOC_NEXT);
+}
+
+/* Hash insert can return -errno or number of inserted elements,
+ * duplicate elements will not be inserted in the hash and return 0. */
+static long hash_reloc_insert(struct hash_reloc *hash,
+			      Elf32_Rela *r1, unsigned key)
+{
+	Elf32_Rela **p1 = hash->r_page, **p2 = NULL;
+	unsigned i = 0;
+
+	while (p1 && p1[key]) {
+
+		/* Check for duplicates */
+		if (ELF32_R_SYM(r1->r_info) == ELF32_R_SYM(p1[key]->r_info) &&
+		    r1->r_addend == p1[key]->r_addend) {
+			hash->r_duplicate++;
+			return 0;
+		}
+
+		p2 = p1;
+		p1 = (Elf32_Rela **)p2[HASH_RELOC_NEXT];
+		i++;
+	}
+
+	if (i >= hash->r_depth) {
+		p1 = (Elf32_Rela **)get_zeroed_page(GFP_KERNEL);
+		if (!p1) {
+			printk("Unable to allocate memory for module\n");
+			return -ENOMEM;
+		}
+
+		hash->r_depth++;
+		p2[HASH_RELOC_NEXT] = (Elf32_Rela *)p1;
+	}
+
+	p1[key] = r1;
+	return 1;
+}
+
+static long hash_reloc_init(struct hash_reloc *hash)
 {
-	unsigned int i, j, ret = 0;
+	if (!(hash->r_page = (Elf32_Rela **)get_zeroed_page(GFP_KERNEL))) {
+		printk("Unable to allocate memory for module\n");
+		return -ENOMEM;
+	}
 
-	/* Sure, this is order(n^2), but it's usually short, and not
-           time critical */
+	hash->r_depth = 1;
+	hash->r_duplicate = 0;
+	return 0;
+}
+
+static void hash_reloc_cleanup(struct hash_reloc *hash)
+{
+	Elf32_Rela **p1, **p2;
+
+	p1 = hash->r_page;
+	while (p1) {
+		p2 = (Elf32_Rela **)p1[HASH_RELOC_NEXT];
+		free_page((unsigned long)p1);
+		p1 = p2;
+	}
+}
+
+/* Count how many unique relocations (different symbol and addend) */
+static long count_relocs(const Elf32_Rela *rela, unsigned int num)
+{
+	struct hash_reloc hash;
+	Elf32_Rela *r;
+	long rc, ret = 0;
+	unsigned i, key;
+
+	hash_reloc_init(&hash);
+
+	/* Use a chained hash with a uniform key for an order(N) algorithm */
 	for (i = 0; i < num; i++) {
-		for (j = 0; j < i; j++) {
-			/* If this addend appeared before, it's
-                           already been counted */
-			if (ELF32_R_SYM(rela[i].r_info)
-			    == ELF32_R_SYM(rela[j].r_info)
-			    && rela[i].r_addend == rela[j].r_addend)
-				break;
+		r = (Elf32_Rela *)&rela[i];
+		key = hash_reloc_key(r);
+		if ((rc = hash_reloc_insert(&hash, r, key)) < 0) {
+			ret = rc;
+			break;
 		}
-		if (j == i) ret++;
+
+		ret += rc;
 	}
+
+	DEBUGP("Symbols %d, duplicates %d, depth %d\n",
+	       num, hash.r_duplicate, hash.r_depth);
+	hash_reloc_cleanup(&hash);
 	return ret;
 }
 
 /* Get the potential trampolines size required of the init and
    non-init sections */
-static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
+static long get_plt_size(const Elf32_Ehdr *hdr,
 				  const Elf32_Shdr *sechdrs,
 				  const char *secstrings,
 				  int is_init)
 {
-	unsigned long ret = 0;
+	long rc, ret = 0;
 	unsigned i;
 
 	/* Everything marked ALLOC (this includes the exported
@@ -100,11 +183,13 @@
 			DEBUGP("Ptr: %p.  Number: %u\n",
 			       (void *)hdr + sechdrs[i].sh_offset,
 			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
-			ret += count_relocs((void *)hdr
-					     + sechdrs[i].sh_offset,
-					     sechdrs[i].sh_size
-					     / sizeof(Elf32_Rela))
-				* sizeof(struct ppc_plt_entry);
+			rc = count_relocs((void *)hdr + sechdrs[i].sh_offset,
+			                  sechdrs[i].sh_size /
+					  sizeof(Elf32_Rela));
+			if (rc < 0)
+				return rc;
+
+			ret += (rc * sizeof(struct ppc_plt_entry));
 		}
 	}
 
@@ -116,7 +201,8 @@
 			      char *secstrings,
 			      struct module *me)
 {
-	unsigned int i;
+	unsigned i;
+	long rc;
 
 	/* Find .plt and .init.plt sections */
 	for (i = 0; i < hdr->e_shnum; i++) {
@@ -131,10 +217,15 @@
 	}
 
 	/* Override their sizes */
-	sechdrs[me->arch.core_plt_section].sh_size
-		= get_plt_size(hdr, sechdrs, secstrings, 0);
-	sechdrs[me->arch.init_plt_section].sh_size
-		= get_plt_size(hdr, sechdrs, secstrings, 1);
+	if ((rc = get_plt_size(hdr, sechdrs, secstrings, 0)) < 0)
+		return rc;
+
+	sechdrs[me->arch.core_plt_section].sh_size = rc;
+
+	if ((rc = get_plt_size(hdr, sechdrs, secstrings, 1)) < 0)
+		return rc;
+
+	sechdrs[me->arch.init_plt_section].sh_size = rc;
 	return 0;
 }
 

--Boundary-00=_jAfbGs1zunqmYlL--
