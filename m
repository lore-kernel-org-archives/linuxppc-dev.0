From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 12 Feb 2003 13:31:20 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] vs. latest linuxppc_2_4_devel and linuxppc_2_4 for xmon
Message-ID: <20030212203120.GC12358@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allows printing of pgtables in xmon.  Mighty useful in both trees.

diff -Nru a/arch/ppc/xmon/xmon.c b/arch/ppc/xmon/xmon.c
--- a/arch/ppc/xmon/xmon.c	Wed Feb 12 13:28:51 2003
+++ b/arch/ppc/xmon/xmon.c	Wed Feb 12 13:28:51 2003
@@ -138,6 +138,7 @@
   ms	set a block of memory\n\
   md	compare two blocks of memory\n\
   M	print System.map\n\
+  p	print page tables for current\n\
   r	print registers\n\
   S	print special registers\n\
   t	print backtrace\n\
@@ -432,6 +433,9 @@
 		case 'M':
 			print_sysmap();
 			break;
+		case 'p':
+			print_pgtables();
+			break;
 		case 'S':
 			super_regs();
 			break;
@@ -689,6 +693,78 @@
 	}
 }

+
+/*
+ * Lookup page mappings for the current task and for the
+ * kernel and print them all.  -- Cort <cort@fsmlabs.com>
+ */
+static void
+print_pgtables(void)
+{
+	int i = 0;/* j = 0;*/
+	pgd_t *pgd;
+	pmd_t *pmd;
+	/*pte_t *pte;*/
+	struct mm_struct *mm = current->mm;
+
+	if (!mm) {
+		printf("!current->mm, using init_task\n");
+		mm = &init_mm;
+	}
+
+	printf("current %08x %s/%d\n", current, current->comm,
+	       current->pid);
+
+	printf("User mappings: ");
+again:
+	printf("->mm %08x ->context %08x\n",
+	       (ulong)mm, (ulong)mm->context);
+
+	if ( !mm->pgd ) {
+		printf("!mm->pgd\n");
+		return;
+	}
+
+	pgd = mm->pgd;
+
+	printf("PGD/PMD table spans %08x -> %08x\n",
+	       (ulong)mm->pgd,
+	       (ulong)mm->pgd+(PTRS_PER_PGD*sizeof(pgd_t)));
+
+
+	for ( i = 0 ; i < PTRS_PER_PGD; i++, pgd++ ) {
+		/* pmd is the same as the PGD on PPC -- Cort */
+		pmd = pmd_offset(pgd,0);
+
+		/* if there is a valid PMD (table of 1024 PTE's) */
+		if ( !pmd_none(*pmd) ) {
+			printf(" PMD %08x maps %08x,%08x (pmd_val %08x)\n",
+			       pgd, i*PGDIR_SIZE,
+			       (i*PGDIR_SIZE)+(PGDIR_SIZE-1),
+			       pmd_val(*pmd));
+#if 0
+			pte = (pte_t *)pmd_page(*pmd);
+
+			for ( j = 0; j < PTRS_PER_PTE; j++,pte++ )
+			{
+				if ( !pte || !pte_none(*pte) )
+					continue;
+				printf("   PTE %08x maps %08x,%08x\n",
+				       pte, (i*PGDIR_SIZE) + (j*PAGE_SIZE),
+				       (i*PGDIR_SIZE) + (j*PAGE_SIZE) + (PAGE_SIZE-1));
+			}
+#endif
+		}
+	}
+
+	/* do the swapper_pg_dir */
+	if ( mm != &init_mm ) {
+		printf("Kernel mappings: ");
+		mm = &init_mm;
+		goto again;
+	}
+}
+
 static void
 backtrace(struct pt_regs *excp)
 {

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
