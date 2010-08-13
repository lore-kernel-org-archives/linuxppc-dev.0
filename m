Return-Path: <paulus@ozlabs.org>
Date: Fri, 13 Aug 2010 16:18:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Dynamically allocate most lppaca structs
Message-ID: <20100813061848.GB30234@drongo>
References: <20100813061815.GA30234@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100813061815.GA30234@drongo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This arranges for the lppaca structs for most cpus to be dynamically
allocated in the same manner as the paca structs.  If we don't include
support for legacy iSeries, only the first lppaca is statically
allocated; the rest are dynamically allocated.  If we include legacy
iSeries support, then we statically allocate the first 64 lppaca
structs, since the iSeries hypervisor requires that the lppaca
structs be present in the data section of the kernel image, but
legacy iSeries supports at most 64 cpus.

With CONFIG_NR_CPUS, the kernel image size for a typical pSeries config
went from:

   text    data     bss     dec     hex filename
9524478 4734564 8469944 22728986        15ad11a ../test-1024/vmlinux

to:

   text    data     bss     dec     hex filename
9524482 3751508 8469944 21745934        14bd10e ../test-1024/vmlinux

a reduction of 983052 bytes overall.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/lppaca.h |    2 +-
 arch/powerpc/kernel/paca.c        |   70 +++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 6b73554..6d02624 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -153,7 +153,7 @@ struct lppaca {
 
 extern struct lppaca lppaca[];
 
-#define lppaca_of(cpu)	(lppaca[cpu])
+#define lppaca_of(cpu)	(*paca[cpu].lppaca_ptr)
 
 /*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d0a26f1..1e068a4 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -27,6 +27,20 @@ extern unsigned long __toc_start;
 #ifdef CONFIG_PPC_BOOK3S
 
 /*
+ * We only have to have statically allocated lppaca structs on
+ * legacy iSeries, which supports at most 64 cpus.
+ */
+#ifdef CONFIG_PPC_ISERIES
+#if NR_CPUS < 64
+#define NR_LPPACAS	NR_CPUS
+#else
+#define NR_LPPACAS	64
+#endif
+#else /* not iSeries */
+#define NR_LPPACAS	1
+#endif
+
+/*
  * The structure which the hypervisor knows about - this structure
  * should not cross a page boundary.  The vpa_init/register_vpa call
  * is now known to fail if the lppaca structure crosses a page
@@ -36,7 +50,7 @@ extern unsigned long __toc_start;
  * will suffice to ensure that it doesn't cross a page boundary.
  */
 struct lppaca lppaca[] = {
-	[0 ... (NR_CPUS-1)] = {
+	[0 ... (NR_LPPACAS-1)] = {
 		.desc = 0xd397d781,	/* "LpPa" */
 		.size = sizeof(struct lppaca),
 		.dyn_proc_status = 2,
@@ -49,6 +63,54 @@ struct lppaca lppaca[] = {
 	},
 };
 
+static struct lppaca *extra_lppacas;
+static long __initdata lppaca_size;
+
+static void allocate_lppacas(int nr_cpus, unsigned long limit)
+{
+	if (nr_cpus <= NR_LPPACAS)
+		return;
+
+	lppaca_size = PAGE_ALIGN(sizeof(struct lppaca) *
+				 (nr_cpus - NR_LPPACAS));
+	extra_lppacas = __va(memblock_alloc_base(lppaca_size,
+						 PAGE_SIZE, limit));
+}
+
+static struct lppaca *new_lppaca(int cpu)
+{
+	struct lppaca *lp;
+
+	if (cpu < NR_LPPACAS)
+		return &lppaca[cpu];
+
+	lp = extra_lppacas + (cpu - NR_LPPACAS);
+	*lp = lppaca[0];
+
+	return lp;
+}
+
+static void free_lppacas(void)
+{
+	long new_size = 0, nr;
+
+	if (!lppaca_size)
+		return;
+	nr = num_possible_cpus() - NR_LPPACAS;
+	if (nr > 0)
+		new_size = PAGE_ALIGN(nr * sizeof(struct lppaca));
+	if (new_size >= lppaca_size)
+		return;
+
+	memblock_free(__pa(extra_lppacas) + new_size, lppaca_size - new_size);
+	lppaca_size = new_size;
+}
+
+#else
+
+static inline void allocate_lppacas(int, unsigned long) { }
+static inline void free_lppacas(void) { }
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_STD_MMU_64
@@ -88,7 +150,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
 
 #ifdef CONFIG_PPC_BOOK3S
-	new_paca->lppaca_ptr = &lppaca[cpu];
+	new_paca->lppaca_ptr = new_lppaca(cpu);
 #else
 	new_paca->kernel_pgd = swapper_pg_dir;
 #endif
@@ -144,6 +206,8 @@ void __init allocate_pacas(void)
 	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
 		paca_size, nr_cpus, paca);
 
+	allocate_lppacas(nr_cpus, limit);
+
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
 	for (cpu = 0; cpu < nr_cpus; cpu++)
 		initialise_paca(&paca[cpu], cpu);
@@ -164,4 +228,6 @@ void __init free_unused_pacas(void)
 		paca_size - new_size);
 
 	paca_size = new_size;
+
+	free_lppacas();
 }
-- 
1.7.1
