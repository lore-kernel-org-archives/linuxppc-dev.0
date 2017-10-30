Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQWkZ4W7XzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 22:01:25 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id x7so10727408pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 04:01:25 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5] powerpc/xmon: Support dumping software pagetables
Date: Mon, 30 Oct 2017 22:01:12 +1100
Message-Id: <20171030110112.17634-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Changelog v5
	- Remove dependence on CONFIG_HUGETLB_PAGE and
	make the changes PPC_BOOK3S_64 dependent.

 arch/powerpc/xmon/xmon.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 83e7faf5b3d3..9d9899c85d7c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/ctype.h>
+#include <linux/highmem.h>
 
 #include <asm/debugfs.h>
 #include <asm/ptrace.h>
@@ -127,6 +128,9 @@ static void byterev(unsigned char *, int);
 static void memex(void);
 static int bsesc(void);
 static void dump(void);
+#ifdef CONFIG_PPC_BOOK3S_64
+static void show_pte(unsigned long);
+#endif
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
@@ -234,6 +238,7 @@ Commands:\n\
 #endif
   "\
   dr	dump stream of raw bytes\n\
+  dv	dump virtual address translation \n\
   dt	dump the tracing buffers (uses printk)\n\
   dtc	dump the tracing buffers for current CPU (uses printk)\n\
 "
@@ -2613,6 +2618,11 @@ dump(void)
 		dump_log_buf();
 	} else if (c == 'o') {
 		dump_opal_msglog();
+	} else if (c == 'v') {
+#ifdef CONFIG_PPC_BOOK3S_64
+		/* dump virtual to physical translation */
+		show_pte(adrs);
+#endif
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
@@ -2946,6 +2956,118 @@ static void show_task(struct task_struct *tsk)
 		tsk->comm);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void format_pte(void *ptep, unsigned long pte)
+{
+	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);
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
+	if (pud_huge(*pudp)) {
+		format_pte(pudp, pud_val(*pudp));
+		return;
+	}
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
+	if (pmd_huge(*pmdp)) {
+		format_pte(pmdp, pmd_val(*pmdp));
+		return;
+	}
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
+#else
+
+static void show_pte(unsigned long addr)
+{
+	printf("show_pte not yet implemented\n");
+}
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 static void show_tasks(void)
 {
 	unsigned long tskv;
-- 
2.13.6
