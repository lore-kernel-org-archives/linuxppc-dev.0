Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGCXC099MzDqxk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:23:23 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y129so10983978pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 00:23:22 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/xmon: support dumping software pagetables
Date: Mon, 24 Jul 2017 17:23:05 +1000
Message-Id: <20170724072305.10586-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It would be nice to be able to dump page tables in a
particular context.

Example use cases

Dumping PTE contents to see the keys (useful for debugging)

0:mon> dv 0x7ffff7f70000 c00000003b585080
PGD@0xc00000003ab651f8->0x000000003a255800
PUD@0xc00000003a255bf8->0x000000003aa84000
PMD@0xc00000003aa85fb8->0x000000003a823000
physical address->0x00000000012c0000, PTE->0xce800000012c0504
PTE flags A: :R: :

For Hugepages, the output shows the PMD as PTE

0:mon> dv 0x7ffff6000000 c00000003b585080
PGD@0xc00000003ab651f8->0x000000003a255800
PUD@0xc00000003a255bf8->0x000000003aa84000
physical address->0x0000000032000000, PTE->0xdc80000032002386
PTE flags A:D:R:W:

Dumping vmalloc space

0:mon> dv 0xd000000000000000
PGD@0xc0000000012b0000->0x00000000bc170400
PUD@0xc0000000bc170400->0x000000007e184000
PMD@0xc00000007e184000->0x00000000bc180000
physical address->0x000000003d2b0000, PTE->0xc08000003d2b018e
PTE flags A:D:R:W:

This patch does not replicate the complex code of dump_pagetable
and has no support for bolted linear mapping, thats why I've it's
called dump virtual page table support. The format of the PTE can
be expanded even further to add more useful information about the
flags in the PTE if required.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 5341556..c84448c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -126,6 +126,7 @@ static void byterev(unsigned char *, int);
 static void memex(void);
 static int bsesc(void);
 static void dump(void);
+static void show_pte(unsigned long);
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
@@ -233,6 +234,7 @@ Commands:\n\
 #endif
   "\
   dr	dump stream of raw bytes\n\
+  dv	dump virtual address translation \n\
   dt	dump the tracing buffers (uses printk)\n\
 "
 #ifdef CONFIG_PPC_POWERNV
@@ -2554,6 +2556,9 @@ dump(void)
 	} else if (c == 't') {
 		ftrace_dump(DUMP_ALL);
 		tracing_on();
+	} else if (c == 'v') {
+		/* dump virtual to physical translation */
+		show_pte(adrs);
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
@@ -2887,6 +2892,120 @@ static void show_task(struct task_struct *tsk)
 		tsk->comm);
 }
 
+static inline char *show_pte_flag(unsigned long pte, unsigned long flag,
+					char *str)
+{
+	if (pte & flag)
+		return str;
+	else
+		return " ";
+}
+
+void format_pte(unsigned long pte)
+{
+	unsigned long pa = pte & PTE_RPN_MASK;
+
+	printf("physical address->0x%016lx, PTE->0x%016lx\n", pa, pte);
+
+	printf("PTE flags %s:%s:%s:%s:%s\n",
+			show_pte_flag(pte, _PAGE_ACCESSED, "A"),
+			show_pte_flag(pte, _PAGE_DIRTY, "D"),
+			show_pte_flag(pte, _PAGE_READ, "R"),
+			show_pte_flag(pte, _PAGE_WRITE, "W"),
+			show_pte_flag(pte, _PAGE_EXEC, "X"));
+
+	/* TODO add KEY support once the bits are baked in */
+}
+
+static void show_pte(unsigned long addr)
+{
+	unsigned long tskv = 0;
+	struct task_struct *tsk = NULL;
+	struct mm_struct *mm;
+	pgd_t *pgdp;
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
+	if (mm == &init_mm)
+		pgdp = pgd_offset_k(addr);
+	else
+		pgdp = pgd_offset(mm, addr);
+
+	if (pgd_none(*pgdp)) {
+		printf("no linux page table for address\n");
+		return;
+	}
+
+	if (pgd_huge(*pgdp)) {
+		format_pte(pgd_val(*pgdp));
+		return;
+	}
+	printf("PGD@0x%016lx->0x%016lx\n", pgdp, pgd_val(*pgdp));
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
+		format_pte(pud_val(*pudp));
+		return;
+	}
+#endif
+
+	printf("PUD@0x%016lx->0x%016lx\n", pudp, pud_val(*pudp));
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
+		format_pte(pmd_val(*pmdp));
+		return;
+	}
+#endif
+	printf("PMD@0x%016lx->0x%016lx\n", pmdp, pmd_val(*pmdp));
+
+	/* pte_offset_map is the same as pte_offset_kernel */
+	ptep = pte_offset_kernel(pmdp, addr);
+	if (pte_none(*ptep)) {
+		printf("no valid PTE\n");
+		return;
+	}
+
+	format_pte(pte_val(*ptep));
+
+	sync();
+	__delay(200);
+	catch_memory_errors = 0;
+}
 static void show_tasks(void)
 {
 	unsigned long tskv;
-- 
2.9.4
