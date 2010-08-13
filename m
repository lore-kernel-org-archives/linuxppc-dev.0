Return-Path: <paulus@ozlabs.org>
Date: Fri, 13 Aug 2010 16:18:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Abstract indexing of lppaca structs
Message-ID: <20100813061815.GA30234@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have the lppaca structs as a simple array of NR_CPUS
entries, taking up space in the data section of the kernel image.
In future we would like to allocate them dynamically, so this
abstracts out the accesses to the array, making it easier to
change how we locate the lppaca for a given cpu in future.
Specifically, lppaca[cpu] changes to lppaca_of(cpu).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/lppaca.h     |    2 ++
 arch/powerpc/kernel/lparcfg.c         |   14 +++++++-------
 arch/powerpc/lib/locks.c              |    4 ++--
 arch/powerpc/platforms/iseries/dt.c   |    4 ++--
 arch/powerpc/platforms/iseries/smp.c  |    2 +-
 arch/powerpc/platforms/pseries/dtl.c  |    8 ++++----
 arch/powerpc/platforms/pseries/lpar.c |    4 ++--
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 14b592d..6b73554 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -153,6 +153,8 @@ struct lppaca {
 
 extern struct lppaca lppaca[];
 
+#define lppaca_of(cpu)	(lppaca[cpu])
+
 /*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
  * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 50362b6..8d9e3b9 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -56,7 +56,7 @@ static unsigned long get_purr(void)
 
 	for_each_possible_cpu(cpu) {
 		if (firmware_has_feature(FW_FEATURE_ISERIES))
-			sum_purr += lppaca[cpu].emulated_time_base;
+			sum_purr += lppaca_of(cpu).emulated_time_base;
 		else {
 			struct cpu_usage *cu;
 
@@ -263,7 +263,7 @@ static void parse_ppp_data(struct seq_file *m)
 	           ppp_data.active_system_procs);
 
 	/* pool related entries are apropriate for shared configs */
-	if (lppaca[0].shared_proc) {
+	if (lppaca_of(0).shared_proc) {
 		unsigned long pool_idle_time, pool_procs;
 
 		seq_printf(m, "pool=%d\n", ppp_data.pool_num);
@@ -460,8 +460,8 @@ static void pseries_cmo_data(struct seq_file *m)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		cmo_faults += lppaca[cpu].cmo_faults;
-		cmo_fault_time += lppaca[cpu].cmo_fault_time;
+		cmo_faults += lppaca_of(cpu).cmo_faults;
+		cmo_fault_time += lppaca_of(cpu).cmo_fault_time;
 	}
 
 	seq_printf(m, "cmo_faults=%lu\n", cmo_faults);
@@ -479,8 +479,8 @@ static void splpar_dispatch_data(struct seq_file *m)
 	unsigned long dispatch_dispersions = 0;
 
 	for_each_possible_cpu(cpu) {
-		dispatches += lppaca[cpu].yield_count;
-		dispatch_dispersions += lppaca[cpu].dispersion_count;
+		dispatches += lppaca_of(cpu).yield_count;
+		dispatch_dispersions += lppaca_of(cpu).dispersion_count;
 	}
 
 	seq_printf(m, "dispatches=%lu\n", dispatches);
@@ -545,7 +545,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	seq_printf(m, "partition_potential_processors=%d\n",
 		   partition_potential_processors);
 
-	seq_printf(m, "shared_processor_mode=%d\n", lppaca[0].shared_proc);
+	seq_printf(m, "shared_processor_mode=%d\n", lppaca_of(0).shared_proc);
 
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
 
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 58e14fb..9b8182e 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -34,7 +34,7 @@ void __spin_yield(arch_spinlock_t *lock)
 		return;
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = lppaca[holder_cpu].yield_count;
+	yield_count = lppaca_of(holder_cpu).yield_count;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
@@ -65,7 +65,7 @@ void __rw_yield(arch_rwlock_t *rw)
 		return;		/* no write lock at present */
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = lppaca[holder_cpu].yield_count;
+	yield_count = lppaca_of(holder_cpu).yield_count;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 7f45a51..fdb7384 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -243,7 +243,7 @@ static void __init dt_cpus(struct iseries_flat_dt *dt)
 	pft_size[1] = __ilog2(HvCallHpt_getHptPages() * HW_PAGE_SIZE);
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (lppaca[i].dyn_proc_status >= 2)
+		if (lppaca_of(i).dyn_proc_status >= 2)
 			continue;
 
 		snprintf(p, 32 - (p - buf), "@%d", i);
@@ -251,7 +251,7 @@ static void __init dt_cpus(struct iseries_flat_dt *dt)
 
 		dt_prop_str(dt, "device_type", device_type_cpu);
 
-		index = lppaca[i].dyn_hv_phys_proc_index;
+		index = lppaca_of(i).dyn_hv_phys_proc_index;
 		d = &xIoHriProcessorVpd[index];
 
 		dt_prop_u32(dt, "i-cache-size", d->xInstCacheSize * 1024);
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index 6590850..6c60299 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -91,7 +91,7 @@ static void smp_iSeries_kick_cpu(int nr)
 	BUG_ON((nr < 0) || (nr >= NR_CPUS));
 
 	/* Verify that our partition has a processor nr */
-	if (lppaca[nr].dyn_proc_status >= 2)
+	if (lppaca_of(nr).dyn_proc_status >= 2)
 		return;
 
 	/* The processor is currently spinning, waiting
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index a00addb..adfd544 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -107,14 +107,14 @@ static int dtl_enable(struct dtl *dtl)
 	}
 
 	/* set our initial buffer indices */
-	dtl->last_idx = lppaca[dtl->cpu].dtl_idx = 0;
+	dtl->last_idx = lppaca_of(dtl->cpu).dtl_idx = 0;
 
 	/* ensure that our updates to the lppaca fields have occurred before
 	 * we actually enable the logging */
 	smp_wmb();
 
 	/* enable event logging */
-	lppaca[dtl->cpu].dtl_enable_mask = dtl_event_mask;
+	lppaca_of(dtl->cpu).dtl_enable_mask = dtl_event_mask;
 
 	return 0;
 }
@@ -123,7 +123,7 @@ static void dtl_disable(struct dtl *dtl)
 {
 	int hwcpu = get_hard_smp_processor_id(dtl->cpu);
 
-	lppaca[dtl->cpu].dtl_enable_mask = 0x0;
+	lppaca_of(dtl->cpu).dtl_enable_mask = 0x0;
 
 	unregister_dtl(hwcpu, __pa(dtl->buf));
 
@@ -171,7 +171,7 @@ static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
 	/* actual number of entries read */
 	n_read = 0;
 
-	cur_idx = lppaca[dtl->cpu].dtl_idx;
+	cur_idx = lppaca_of(dtl->cpu).dtl_idx;
 	last_idx = dtl->last_idx;
 
 	if (cur_idx - last_idx > dtl->buf_entries) {
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index cf79b46..a17fe4a 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -250,9 +250,9 @@ void vpa_init(int cpu)
 	long ret;
 
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		lppaca[cpu].vmxregs_in_use = 1;
+		lppaca_of(cpu).vmxregs_in_use = 1;
 
-	addr = __pa(&lppaca[cpu]);
+	addr = __pa(&lppaca_of(cpu));
 	ret = register_vpa(hwcpu, addr);
 
 	if (ret) {
-- 
1.7.1
