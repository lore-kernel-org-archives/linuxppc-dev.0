Date: Fri, 26 Mar 2004 14:32:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Toru UCHIYAMA <uchi@cs.fujitsu.co.jp>,
	linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: [PATCH] Fix memory leak on PPC44x/kernel 2.6.5-rc2-bk
Message-ID: <20040326143251.B21727@home.com>
References: <200403260934.i2Q9YY324825@stbrain.utsfd.cs.fujitsu.co.jp> <20040326122425.A21727@home.com> <20040326210304.GA16601@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040326210304.GA16601@gate.ebshome.net>; from ebs@ebshome.net on Fri, Mar 26, 2004 at 01:03:04PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 26, 2004 at 01:03:04PM -0800, Eugene Surovegin wrote:
> On Fri, Mar 26, 2004 at 12:24:25PM -0700, Matt Porter wrote:
> >
> > Paul: Ok to send to akpm?
> >
>
> Maybe we should get rid of clear_page in misc.S and make it an inline:
>
> static inline void clear_page(void* page) { clear_pages(page, 0); }

Yep, much better.  Here's the improved version.

-Matt

===== arch/ppc/kernel/misc.S 1.54 vs edited =====
--- 1.54/arch/ppc/kernel/misc.S	Tue Mar 23 15:46:40 2004
+++ edited/arch/ppc/kernel/misc.S	Fri Mar 26 14:25:25 2004
@@ -738,12 +738,15 @@
 	blr

 /*
- * Clear a page using the dcbz instruction, which doesn't cause any
+ * Clear pages using the dcbz instruction, which doesn't cause any
  * memory traffic (except to write out any cache lines which get
  * displaced).  This only works on cacheable memory.
+ *
+ * void clear_pages(void *page, int order) ;
  */
-_GLOBAL(clear_page)
+_GLOBAL(clear_pages)
 	li	r0,4096/L1_CACHE_LINE_SIZE
+	slw	r0,r0,r4
 	mtctr	r0
 #ifdef CONFIG_8xx
 	li	r4, 0
===== arch/ppc/mm/pgtable.c 1.16 vs edited =====
--- 1.16/arch/ppc/mm/pgtable.c	Wed Feb  4 21:58:08 2004
+++ edited/arch/ppc/mm/pgtable.c	Fri Mar 26 11:54:37 2004
@@ -71,13 +71,13 @@
 	pgd_t *ret;

 	if ((ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGDIR_ORDER)) != NULL)
-		clear_page(ret);
+		clear_pages(ret, PGDIR_ORDER);
 	return ret;
 }

 void pgd_free(pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
+	free_pages((unsigned long)pgd, PGDIR_ORDER);
 }

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
===== include/asm-ppc/page.h 1.15 vs edited =====
--- 1.15/include/asm-ppc/page.h	Fri Sep 12 09:26:56 2003
+++ edited/include/asm-ppc/page.h	Fri Mar 26 14:22:30 2004
@@ -84,7 +84,8 @@
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)

 struct page;
-extern void clear_page(void *page);
+extern void clear_pages(void *page, int order);
+static inline clear_page(void *page) { clear_pages(page, 0); }
 extern void copy_page(void *to, void *from);
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
