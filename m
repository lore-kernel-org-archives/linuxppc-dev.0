Message-Id: <200403260934.i2Q9YY324825@stbrain.utsfd.cs.fujitsu.co.jp>
Date: Fri, 26 Mar 2004 18:34:31 +0900
From: Toru UCHIYAMA <uchi@cs.fujitsu.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Fix memory leak on PPC44x/kernel 2.6.5-rc2-bk
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I found a memory leak problem in  pgd_free().
The following patch against 2.6.5-rc2 fix the problem.

Best regards,
Toru Uchiyama

2004-03-25  Toru Uchiyama  <uchi@cs.fujitsu.co.jp>,
                   Takeharu KATO <tkato@cs.fujitsu.co.jp>
    * arch/ppc/kernel/misc.S : Add clear_pages().
    * arch/ppc/mm/pgtable.c  : Use clear_pages
    * include/asm-ppc/page.h : Add prototype definition for clear_pages()


diff -Nru linux-ppc/arch/ppc/kernel/misc.S linux-ppc-debug/arch/ppc/kernel/misc.S
--- linux-ppc/arch/ppc/kernel/misc.S	2004-03-24 16:28:22.000000000 +0900
+++ linux-ppc-debug/arch/ppc/kernel/misc.S	2004-03-25 17:04:37.000000000 +0900
@@ -757,6 +757,26 @@
 	addi	r3,r3,L1_CACHE_LINE_SIZE
 	bdnz	1b
 	blr
+/*
+ * Clear  pages
+ * void clear_pages(void *page,int order) ;
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

 /*
  * Copy a whole page.  We use the dcbz instruction on the destination
diff -Nru linux-ppc/arch/ppc/mm/pgtable.c linux-ppc-debug/arch/ppc/mm/pgtable.c
--- linux-ppc/arch/ppc/mm/pgtable.c	2004-03-24 16:25:39.000000000 +0900
+++ linux-ppc-debug/arch/ppc/mm/pgtable.c	2004-03-25 17:04:57.000000000 +0900
@@ -69,15 +69,22 @@
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
-
 	if ((ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGDIR_ORDER)) != NULL)
+#if 0   /*  Relaced by Uchi and KATO 2004.3.25  - begin -  */
 		clear_page(ret);
+#else
+		clear_pages(ret,PGDIR_ORDER);
+#endif   /*  Relaced by Uchi and KATO 2004.3.25  - end -  */
 	return ret;
 }

 void pgd_free(pgd_t *pgd)
 {
+#if 0  /*  Relaced by Uchi and KATO 2004.3.25  - begin -  */
 	free_page((unsigned long)pgd);
+#else
+	free_pages((unsigned long)pgd,PGDIR_ORDER);
+#endif /*  Relaced by Uchi and KATO 2004.3.25  - end -  */
 }

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
diff -Nru linux-ppc/include/asm-ppc/page.h linux-ppc-debug/include/asm-ppc/page.h
--- linux-ppc/include/asm-ppc/page.h	2004-03-24 16:25:55.000000000 +0900
+++ linux-ppc-debug/include/asm-ppc/page.h	2004-03-25 17:03:42.000000000 +0900
@@ -85,6 +85,10 @@

 struct page;
 extern void clear_page(void *page);
+#if  1  /*  Relaced by Uchi and KATO 2004.3.25  - begin -  */
+/*  See arch/ppc/kernel/misc.S in detail.  */
+extern void clear_pages(void *page,int order);
+#endif  /*  Relaced by Uchi and KATO 2004.3.25  - end -  */
 extern void copy_page(void *to, void *from);
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
