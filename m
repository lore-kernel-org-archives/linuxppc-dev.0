Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0knw4030009@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:18 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	rolandd@cisco.com
Subject: [patch 08/43] ppc: make phys_mem_access_prot() work with pfns
	instead of addresses
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Roland Dreier <rolandd@cisco.com>

Change the phys_mem_access_prot() function to take a pfn instead of an
address.  This allows mmap64() to work on /dev/mem for addresses above 4G
on 32-bit architectures.  We start with a pfn in mmap_mem(), so there's no
need to convert to an address; in fact, it's actively bad, since the
conversion can overflow when the address is above 4G.

Similarly fix the ppc32 page_is_ram() function to avoid a conversion to an
address by directly comparing to max_pfn.  Working with max_pfn instead of
high_memory fixes page_is_ram() to give the right answer for highmem pages.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/kernel/pci.c       |    5 +++--
 arch/ppc/mm/init.c          |   10 ++++------
 arch/ppc64/kernel/pci.c     |    5 +++--
 arch/ppc64/mm/init.c        |    6 +++---
 drivers/char/mem.c          |    4 +---
 drivers/video/fbmem.c       |    2 +-
 include/asm-ppc/machdep.h   |    2 +-
 include/asm-ppc/pci.h       |    2 +-
 include/asm-ppc/pgtable.h   |    2 +-
 include/asm-ppc64/machdep.h |    2 +-
 include/asm-ppc64/pci.h     |    2 +-
 include/asm-ppc64/pgtable.h |    2 +-
 12 files changed, 21 insertions(+), 23 deletions(-)

diff -puN arch/ppc64/kernel/pci.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of arch/ppc64/kernel/pci.c
--- devel/arch/ppc64/kernel/pci.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc64/kernel/pci.c	2005-10-28 17:44:02.000000000 -0700
@@ -727,16 +727,17 @@ static pgprot_t __pci_mmap_set_pgprot(st
  * above routine
  */
 pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long offset,
+				  unsigned long pfn,
 				  unsigned long size,
 				  pgprot_t protection)
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
 	unsigned long prot = pgprot_val(protection);
+	unsigned long offset = pfn << PAGE_SHIFT;
 	int i;
 
-	if (page_is_ram(offset >> PAGE_SHIFT))
+	if (page_is_ram(pfn))
 		return __pgprot(prot);
 
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
diff -puN arch/ppc64/mm/init.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of arch/ppc64/mm/init.c
--- devel/arch/ppc64/mm/init.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc64/mm/init.c	2005-10-28 17:44:02.000000000 -0700
@@ -855,13 +855,13 @@ void pgtable_cache_init(void)
 	}
 }
 
-pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
 	if (ppc_md.phys_mem_access_prot)
-		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(addr >> PAGE_SHIFT))
+	if (!page_is_ram(pfn))
 		vma_prot = __pgprot(pgprot_val(vma_prot)
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
diff -puN arch/ppc/kernel/pci.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of arch/ppc/kernel/pci.c
--- devel/arch/ppc/kernel/pci.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/kernel/pci.c	2005-10-28 17:44:02.000000000 -0700
@@ -1586,16 +1586,17 @@ static pgprot_t __pci_mmap_set_pgprot(st
  * above routine
  */
 pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long offset,
+				  unsigned long pfn,
 				  unsigned long size,
 				  pgprot_t protection)
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
 	unsigned long prot = pgprot_val(protection);
+	unsigned long offset = pfn << PAGE_SHIFT;
 	int i;
 
-	if (page_is_ram(offset >> PAGE_SHIFT))
+	if (page_is_ram(pfn))
 		return prot;
 
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
diff -puN arch/ppc/mm/init.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of arch/ppc/mm/init.c
--- devel/arch/ppc/mm/init.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/mm/init.c	2005-10-28 17:44:02.000000000 -0700
@@ -648,18 +648,16 @@ void update_mmu_cache(struct vm_area_str
  */
 int page_is_ram(unsigned long pfn)
 {
-	unsigned long paddr = (pfn << PAGE_SHIFT);
-
-	return paddr < __pa(high_memory);
+	return pfn < max_pfn;
 }
 
-pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
 	if (ppc_md.phys_mem_access_prot)
-		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(addr >> PAGE_SHIFT))
+	if (!page_is_ram(pfn))
 		vma_prot = __pgprot(pgprot_val(vma_prot)
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
diff -puN drivers/char/mem.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of drivers/char/mem.c
--- devel/drivers/char/mem.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/drivers/char/mem.c	2005-10-28 17:44:02.000000000 -0700
@@ -231,9 +231,7 @@ static ssize_t write_mem(struct file * f
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
 #if defined(__HAVE_PHYS_MEM_ACCESS_PROT)
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-
-	vma->vm_page_prot = phys_mem_access_prot(file, offset,
+	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
 #elif defined(pgprot_noncached)
diff -puN drivers/video/fbmem.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of drivers/video/fbmem.c
--- devel/drivers/video/fbmem.c~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/drivers/video/fbmem.c	2005-10-28 17:44:02.000000000 -0700
@@ -918,7 +918,7 @@ fb_mmap(struct file *file, struct vm_are
 	}
 #endif
 #elif defined(__powerpc__)
-	vma->vm_page_prot = phys_mem_access_prot(file, off,
+	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
 #elif defined(__alpha__)
diff -puN include/asm-ppc64/machdep.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc64/machdep.h
--- devel/include/asm-ppc64/machdep.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc64/machdep.h	2005-10-28 17:44:02.000000000 -0700
@@ -130,7 +130,7 @@ struct machdep_calls {
 	
 	/* Get access protection for /dev/mem */
 	pgprot_t	(*phys_mem_access_prot)(struct file *file,
-						unsigned long offset,
+						unsigned long pfn,
 						unsigned long size,
 						pgprot_t vma_prot);
 
diff -puN include/asm-ppc64/pci.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc64/pci.h
--- devel/include/asm-ppc64/pci.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc64/pci.h	2005-10-28 17:44:02.000000000 -0700
@@ -168,7 +168,7 @@ extern void pcibios_add_platform_entries
 
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
-					 unsigned long offset,
+					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
 
diff -puN include/asm-ppc64/pgtable.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc64/pgtable.h
--- devel/include/asm-ppc64/pgtable.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc64/pgtable.h	2005-10-28 17:44:02.000000000 -0700
@@ -471,7 +471,7 @@ static inline void __ptep_set_access_fla
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
 struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
diff -puN include/asm-ppc/machdep.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc/machdep.h
--- devel/include/asm-ppc/machdep.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc/machdep.h	2005-10-28 17:44:02.000000000 -0700
@@ -98,7 +98,7 @@ struct machdep_calls {
 
 	/* Get access protection for /dev/mem */
 	pgprot_t	(*phys_mem_access_prot)(struct file *file,
-						unsigned long offset,
+						unsigned long pfn,
 						unsigned long size,
 						pgprot_t vma_prot);
 
diff -puN include/asm-ppc/pci.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc/pci.h
--- devel/include/asm-ppc/pci.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc/pci.h	2005-10-28 17:44:02.000000000 -0700
@@ -126,7 +126,7 @@ extern void pcibios_add_platform_entries
 
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
-					 unsigned long offset,
+					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
 
diff -puN include/asm-ppc/pgtable.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of include/asm-ppc/pgtable.h
--- devel/include/asm-ppc/pgtable.h~ppc-make-phys_mem_access_prot-work-with-pfns-instead-of	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc/pgtable.h	2005-10-28 17:44:02.000000000 -0700
@@ -705,7 +705,7 @@ static inline void __ptep_set_access_fla
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
 struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
_
