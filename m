Date: Fri, 26 Mar 2004 12:24:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Toru UCHIYAMA <uchi@cs.fujitsu.co.jp>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: [PATCH] Fix memory leak on PPC44x/kernel 2.6.5-rc2-bk
Message-ID: <20040326122425.A21727@home.com>
References: <200403260934.i2Q9YY324825@stbrain.utsfd.cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200403260934.i2Q9YY324825@stbrain.utsfd.cs.fujitsu.co.jp>; from uchi@cs.fujitsu.co.jp on Fri, Mar 26, 2004 at 06:34:31PM +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 26, 2004 at 06:34:31PM +0900, Toru UCHIYAMA wrote:
> Hi,
>
> I found a memory leak problem in  pgd_free().
> The following patch against 2.6.5-rc2 fix the problem.

Good catch.  I did some minor cleanup to submit it upstream.

Paul: Ok to send to akpm?

-Matt

===== arch/ppc/kernel/misc.S 1.54 vs edited =====
--- 1.54/arch/ppc/kernel/misc.S	Tue Mar 23 15:46:40 2004
+++ edited/arch/ppc/kernel/misc.S	Fri Mar 26 11:56:23 2004
@@ -759,6 +759,27 @@
 	blr

 /*
+ * Clear  pages
+ * void clear_pages(void *page, int order) ;
+ */
+_GLOBAL(clear_pages)
+	li	r0,4096/L1_CACHE_LINE_SIZE
+	slw	r0,r0,r4
+	mtctr	r0
+#ifdef CONFIG_8xx
+	li	r4, 0
+1:	stw	r4, 0(r3)
+	stw	r4, 4(r3)
+	stw	r4, 8(r3)
+	stw	r4, 12(r3)
+#else
+1:	dcbz	0,r3
+#endif
+	addi	r3,r3,L1_CACHE_LINE_SIZE
+	bdnz	1b
+	blr
+
+/*
  * Copy a whole page.  We use the dcbz instruction on the destination
  * to reduce memory traffic (it eliminates the unnecessary reads of
  * the destination into cache).  This requires that the destination
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
+++ edited/include/asm-ppc/page.h	Fri Mar 26 11:53:04 2004
@@ -85,6 +85,7 @@

 struct page;
 extern void clear_page(void *page);
+extern void clear_pages(void *page, int order);
 extern void copy_page(void *to, void *from);
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
