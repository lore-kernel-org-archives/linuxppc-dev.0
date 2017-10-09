Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9cWl2XjCzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:52:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc/xmon: Support dumping software pagetables
Date: Mon,  9 Oct 2017 21:52:15 +1100
Message-Id: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

It would be nice to be able to dump page tables in a particular
context.

eg: dumping vmalloc space:

  0:mon> dv 0xd00037fffff00000
  pgd  @ 0xc0000000017c0000
  pgdp @ 0xc0000000017c00d8 = 0x00000000f10b1000
  pudp @ 0xc0000000f10b13f8 = 0x00000000f10d0000
  pmdp @ 0xc0000000f10d1ff8 = 0x00000000f1102000
  ptep @ 0xc0000000f1102780 = 0xc0000000f1ba018e
  Maps physical address = 0x00000000f1ba0000
  Flags = Accessed Dirty Read Write

This patch does not replicate the complex code of dump_pagetable and
has no support for bolted linear mapping, thats why I've it's called
dump virtual page table support. The format of the PTE can be expanded
even further to add more useful information about the flags in the PTE
if required.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Bike shed the output format, show the pgdir]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a41392dec822..d84bead0ac28 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -127,6 +127,7 @@ static void byterev(unsigned char *, int);
 static void memex(void);
 static int bsesc(void);
 static void dump(void);
+static void show_pte(unsigned long);
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
@@ -234,6 +235,7 @@ Commands:\n\
 #endif
   "\
   dr	dump stream of raw bytes\n\
+  dv	dump virtual address translation \n\
   dt	dump the tracing buffers (uses printk)\n\
   dtc	dump the tracing buffers for current CPU (uses printk)\n\
 "
@@ -2639,6 +2641,9 @@ dump(void)
 		dump_log_buf();
 	} else if (c == 'o') {
 		dump_opal_msglog();
+	} else if (c == 'v') {
+		/* dump virtual to physical translation */
+		show_pte(adrs);
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
@@ -2972,6 +2977,112 @@ static void show_task(struct task_struct *tsk)
 		tsk->comm);
 }
 
+void format_pte(void *ptep, unsigned long pte)
+{
+	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);;
+	printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
+
+	printf("Flags = %s%s%s%s%s\n",
+	       (pte & _PAGE_ACCESSED) ? "Accessed " : "",
+	       (pte & _PAGE_DIRTY)    ? "Dirty " : "",
+	       (pte & _PAGE_READ)     ? "Read " : "",
+	       (pte & _PAGE_WRITE)    ? "Write " : "",
+	       (pte & _PAGE_EXEC)     ? "Exec " : "");
+}
+
+static void show_pte(unsigned long addr)
+{
+	unsigned long tskv = 0;
+	struct task_struct *tsk = NULL;
+	struct mm_struct *mm;
+	pgd_t *pgdp, *pgdir;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	if (!scanhex(&tskv))
+		mm = &init_mm;
+	else
+		tsk = (struct task_struct *)tskv;
+
+	if (tsk == NULL)
+		mm = &init_mm;
+	else
+		mm = tsk->active_mm;
+
+	if (setjmp(bus_error_jmp) != 0) {
+		catch_memory_errors = 0;
+		printf("*** Error dumping pte for task %p\n", tsk);
+		return;
+	}
+
+	catch_memory_errors = 1;
+	sync();
+
+	if (mm == &init_mm) {
+		pgdp = pgd_offset_k(addr);
+		pgdir = pgd_offset_k(0);
+	} else {
+		pgdp = pgd_offset(mm, addr);
+		pgdir = pgd_offset(mm, 0);
+	}
+
+	if (pgd_none(*pgdp)) {
+		printf("no linux page table for address\n");
+		return;
+	}
+
+	printf("pgd  @ 0x%016lx\n", pgdir);
+
+	if (pgd_huge(*pgdp)) {
+		format_pte(pgdp, pgd_val(*pgdp));
+		return;
+	}
+	printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
+
+	pudp = pud_offset(pgdp, addr);
+
+	if (pud_none(*pudp)) {
+		printf("No valid PUD\n");
+		return;
+	}
+
+#ifdef CONFIG_HUGETLB_PAGE
+	if (pud_huge(*pudp)) {
+		format_pte(pudp, pud_val(*pudp));
+		return;
+	}
+#endif
+
+	printf("pudp @ 0x%016lx = 0x%016lx\n", pudp, pud_val(*pudp));
+
+	pmdp = pmd_offset(pudp, addr);
+
+	if (pmd_none(*pmdp)) {
+		printf("No valid PMD\n");
+		return;
+	}
+
+#ifdef CONFIG_HUGETLB_PAGE
+	if (pmd_huge(*pmdp)) {
+		format_pte(pmdp, pmd_val(*pmdp));
+		return;
+	}
+#endif
+	printf("pmdp @ 0x%016lx = 0x%016lx\n", pmdp, pmd_val(*pmdp));
+
+	ptep = pte_offset_map(pmdp, addr);
+	if (pte_none(*ptep)) {
+		printf("no valid PTE\n");
+		return;
+	}
+
+	format_pte(ptep, pte_val(*ptep));
+
+	sync();
+	__delay(200);
+	catch_memory_errors = 0;
+}
 static void show_tasks(void)
 {
 	unsigned long tskv;
-- 
2.7.4
