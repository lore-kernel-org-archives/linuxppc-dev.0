Return-Path: <paulus@ozlabs.org>
Date: Fri, 27 Aug 2010 15:56:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Account time using timebase rather than PURR
Message-ID: <20100827055643.GA19033@brick.ozlabs.ibm.com>
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

Currently, when CONFIG_VIRT_CPU_ACCOUNTING is enabled, we use the
PURR register for measuring the user and system time used by
processes, as well as other related times such as hardirq and
softirq times.  This turns out to be quite confusing for users
because it means that a program will often be measured as taking
less time when run on a multi-threaded processor (SMT2 or SMT4 mode)
than it does when run on a single-threaded processor (ST mode), even
though the program takes longer to finish.  The discrepancy is
accounted for as stolen time, which is also confusing, particularly
when there are no other partitions running.

This changes the accounting to use the timebase instead, meaning that
the reported user and system times are the actual number of real-time
seconds that the program was executing on the processor thread,
regardless of which SMT mode the processor is in.  Thus a program will
generally show greater user and system times when run on a
multi-threaded processor than on a single-threaded processor.

On pSeries systems on POWER5 or later processors, we measure the
stolen time (time when this partition wasn't running) using the
hypervisor dispatch trace log.  We check for new entries in the
log on every entry from user mode and on every transition from
kernel process context to soft or hard IRQ context (i.e. when
account_system_vtime() gets called).  So that we can correctly
distinguish time stolen from user time and time stolen from system
time, without having to check the log on every exit to user mode,
we store separate timestamps for exit to user mode and entry from
user mode.

On systems that have a SPURR (POWER6 and POWER7), we read the SPURR
in account_system_vtime() (as before), and then apportion the SPURR
ticks since the last time we read it between scaled user time and
scaled system time according to the relative proportions of user
time and system time over the same interval.  This avoids having to
read the SPURR on every kernel entry and exit.  On systems that have
PURR but not SPURR (i.e., POWER5), we do the same using the PURR
rather than the SPURR.

This disables the DTL user interface in /sys/debug/kernel/powerpc/dtl
for now since it conflicts with the use of the dispatch trace log
by the time accounting code.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This series goes on top of my "powerpc: Dynamically allocate most
lppaca structs" patch.

 arch/powerpc/include/asm/exception-64s.h |    3 +-
 arch/powerpc/include/asm/lppaca.h        |   19 ++
 arch/powerpc/include/asm/paca.h          |   10 +-
 arch/powerpc/include/asm/ppc_asm.h       |   50 ++++--
 arch/powerpc/include/asm/time.h          |    5 -
 arch/powerpc/kernel/asm-offsets.c        |    8 +-
 arch/powerpc/kernel/entry_64.S           |   18 ++
 arch/powerpc/kernel/process.c            |    1 -
 arch/powerpc/kernel/smp.c                |    5 -
 arch/powerpc/kernel/time.c               |  268 ++++++++++++++----------------
 arch/powerpc/platforms/pseries/dtl.c     |   24 +--
 arch/powerpc/platforms/pseries/lpar.c    |   21 +++
 arch/powerpc/platforms/pseries/setup.c   |   52 ++++++
 13 files changed, 290 insertions(+), 194 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 57c4000..7778d6f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -137,7 +137,8 @@
 	li	r10,0;							   \
 	ld	r11,exception_marker@toc(r2);				   \
 	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/ \
+	ACCOUNT_STOLEN_TIME
 
 /*
  * Exception vectors.
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 6d02624..cfb85ec 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -172,6 +172,25 @@ struct slb_shadow {
 
 extern struct slb_shadow slb_shadow[];
 
+/*
+ * Layout of entries in the hypervisor's dispatch trace log buffer.
+ */
+struct dtl_entry {
+	u8	dispatch_reason;
+	u8	preempt_reason;
+	u16	processor_id;
+	u32	enqueue_to_dispatch_time;
+	u32	ready_to_enqueue_time;
+	u32	waiting_to_ready_time;
+	u64	timebase;
+	u64	fault_addr;
+	u64	srr0;
+	u64	srr1;
+};
+
+#define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
+#define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
+
 #endif /* CONFIG_PPC_BOOK3S */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_LPPACA_H */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1ff6662..6af6c16 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -85,6 +85,8 @@ struct paca_struct {
 	u8 kexec_state;		/* set when kexec down has irqs off */
 #ifdef CONFIG_PPC_STD_MMU_64
 	struct slb_shadow *slb_shadow_ptr;
+	struct dtl_entry *dispatch_log;
+	struct dtl_entry *dispatch_log_end;
 
 	/*
 	 * Now, starting in cacheline 2, the exception save areas
@@ -134,8 +136,14 @@ struct paca_struct {
 	/* Stuff for accurate time accounting */
 	u64 user_time;			/* accumulated usermode TB ticks */
 	u64 system_time;		/* accumulated system TB ticks */
-	u64 startpurr;			/* PURR/TB value snapshot */
+	u64 user_time_scaled;		/* accumulated usermode SPURR ticks */
+	u64 starttime;			/* TB value snapshot */
+	u64 starttime_user;		/* TB value on exit to usermode */
 	u64 startspurr;			/* SPURR value snapshot */
+	u64 utime_sspurr;		/* ->user_time when ->startspurr set */
+	u64 stolen_time;		/* TB ticks taken by hypervisor */
+	u64 dtl_ridx;			/* read index in dispatch log */
+	struct dtl_entry *dtl_curr;	/* pointer corresponding to dtl_ridx */
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 	/* We use this to store guest state in */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 498fe09..9821006 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -9,6 +9,7 @@
 #include <asm/asm-compat.h>
 #include <asm/processor.h>
 #include <asm/ppc-opcode.h>
+#include <asm/firmware.h>
 
 #ifndef __ASSEMBLY__
 #error __FILE__ should only be used in assembler files
@@ -26,17 +27,13 @@
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 #define ACCOUNT_CPU_USER_ENTRY(ra, rb)
 #define ACCOUNT_CPU_USER_EXIT(ra, rb)
+#define ACCOUNT_STOLEN_TIME
 #else
 #define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
 	beq	2f;			/* if from kernel mode */	\
-BEGIN_FTR_SECTION;							\
-	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
-END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
-BEGIN_FTR_SECTION;							\
-	MFTB(ra);			/* or get TB if no PURR */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
-	ld	rb,PACA_STARTPURR(r13);					\
-	std	ra,PACA_STARTPURR(r13);					\
+	MFTB(ra);			/* get timebase */		\
+	ld	rb,PACA_STARTTIME_USER(r13);				\
+	std	ra,PACA_STARTTIME(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	ld	ra,PACA_USER_TIME(r13);					\
 	add	ra,ra,rb;		/* add on to user time */	\
@@ -44,19 +41,34 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
 2:
 
 #define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
-BEGIN_FTR_SECTION;							\
-	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
-END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
-BEGIN_FTR_SECTION;							\
-	MFTB(ra);			/* or get TB if no PURR */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
-	ld	rb,PACA_STARTPURR(r13);					\
-	std	ra,PACA_STARTPURR(r13);					\
+	MFTB(ra);			/* get timebase */		\
+	ld	rb,PACA_STARTTIME(r13);					\
+	std	ra,PACA_STARTTIME_USER(r13);				\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	ld	ra,PACA_SYSTEM_TIME(r13);				\
-	add	ra,ra,rb;		/* add on to user time */	\
-	std	ra,PACA_SYSTEM_TIME(r13);
-#endif
+	add	ra,ra,rb;		/* add on to system time */	\
+	std	ra,PACA_SYSTEM_TIME(r13)
+
+#ifdef CONFIG_PPC_SPLPAR
+#define ACCOUNT_STOLEN_TIME						\
+BEGIN_FW_FTR_SECTION;							\
+	beq	33f;							\
+	/* from user - see if there are any DTL entries to process */	\
+	ld	r10,PACALPPACAPTR(r13);	/* get ptr to VPA */		\
+	ld	r11,PACA_DTL_RIDX(r13);	/* get log read index */	\
+	ld	r10,LPPACA_DTLIDX(r10);	/* get log write index */	\
+	cmpd	cr1,r11,r10;						\
+	beq+	cr1,33f;						\
+	bl	.accumulate_stolen_time;				\
+33:									\
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
+
+#else  /* CONFIG_PPC_SPLPAR */
+#define ACCOUNT_STOLEN_TIME
+
+#endif /* CONFIG_PPC_SPLPAR */
+
+#endif /* CONFIG_VIRT_CPU_ACCOUNTING */
 
 /*
  * Macros for storing registers into and loading registers from
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index dc779df..fe6f7c2 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -34,7 +34,6 @@ extern void to_tm(int tim, struct rtc_time * tm);
 extern void GregorianDay(struct rtc_time *tm);
 
 extern void generic_calibrate_decr(void);
-extern void snapshot_timebase(void);
 
 extern void set_dec_cpu6(unsigned int val);
 
@@ -212,12 +211,8 @@ struct cpu_usage {
 DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
 
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING)
-extern void calculate_steal_time(void);
-extern void snapshot_timebases(void);
 #define account_process_vtime(tsk)		account_process_tick(tsk, 0)
 #else
-#define calculate_steal_time()			do { } while (0)
-#define snapshot_timebases()			do { } while (0)
 #define account_process_vtime(tsk)		do { } while (0)
 #endif
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 1c0607d..c634940 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -181,17 +181,19 @@ int main(void)
 	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
 	DEFINE(SLBSHADOW_STACKESID,
 	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid));
+	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
 	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
 	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
 	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
-	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
+	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
+	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
-	DEFINE(PACA_STARTPURR, offsetof(struct paca_struct, startpurr));
-	DEFINE(PACA_STARTSPURR, offsetof(struct paca_struct, startspurr));
+	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
+	DEFINE(PACA_STARTTIME_USER, offsetof(struct paca_struct, starttime_user));
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2f1a6be..eb02f24 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -97,6 +97,24 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+#if defined(CONFIG_VIRT_CPU_ACCOUNTING) && defined(CONFIG_PPC_SPLPAR)
+BEGIN_FW_FTR_SECTION
+	beq	33f
+	/* if from user, see if there are any DTL entries to process */
+	ld	r10,PACALPPACAPTR(r13)	/* get ptr to VPA */
+	ld	r11,PACA_DTL_RIDX(r13)	/* get log read index */
+	ld	r10,LPPACA_DTLIDX(r10)	/* get log write index */
+	cmpd	cr1,r11,r10
+	beq+	cr1,33f
+	bl	.accumulate_stolen_time
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+33:
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
+#endif /* CONFIG_VIRT_CPU_ACCOUNTING && CONFIG_PPC_SPLPAR */
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	.trace_hardirqs_on
 	REST_GPR(0,r1)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index feacfb7..806fa8a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -517,7 +517,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	account_system_vtime(current);
 	account_process_vtime(current);
-	calculate_steal_time();
 
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a61b3dd..af31c3f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -508,9 +508,6 @@ int __devinit start_secondary(void *unused)
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
-	if (system_state > SYSTEM_BOOTING)
-		snapshot_timebase();
-
 	secondary_cpu_time_init();
 
 	ipi_call_lock();
@@ -575,8 +572,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	free_cpumask_var(old_mask);
 
-	snapshot_timebases();
-
 	dump_numa_cpu_topology();
 }
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8533b3b..fca2064 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -164,8 +164,6 @@ unsigned long ppc_proc_freq;
 EXPORT_SYMBOL(ppc_proc_freq);
 unsigned long ppc_tb_freq;
 
-static DEFINE_PER_CPU(u64, last_jiffy);
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
  * Factors for converting from cputime_t (timebase ticks) to
@@ -200,62 +198,151 @@ static void calc_cputime_factors(void)
 }
 
 /*
- * Read the PURR on systems that have it, otherwise the timebase.
+ * Read the SPURR on systems that have it, otherwise the PURR,
+ * or if that doesn't exist return the timebase value passed in.
  */
-static u64 read_purr(void)
+static u64 read_spurr(u64 tb)
 {
+	if (cpu_has_feature(CPU_FTR_SPURR))
+		return mfspr(SPRN_SPURR);
 	if (cpu_has_feature(CPU_FTR_PURR))
 		return mfspr(SPRN_PURR);
-	return mftb();
+	return tb;
 }
 
+#ifdef CONFIG_PPC_SPLPAR
+
 /*
- * Read the SPURR on systems that have it, otherwise the purr
+ * Scan the dispatch trace log and count up the stolen time.
+ * Should be called with interrupts disabled.
  */
-static u64 read_spurr(u64 purr)
+static u64 scan_dispatch_log(u64 stop_tb)
 {
-	/*
-	 * cpus without PURR won't have a SPURR
-	 * We already know the former when we use this, so tell gcc
-	 */
-	if (cpu_has_feature(CPU_FTR_PURR) && cpu_has_feature(CPU_FTR_SPURR))
-		return mfspr(SPRN_SPURR);
-	return purr;
+	unsigned long i = local_paca->dtl_ridx;
+	struct dtl_entry *dtl = local_paca->dtl_curr;
+	struct dtl_entry *dtl_end = local_paca->dispatch_log_end;
+	struct lppaca *vpa = local_paca->lppaca_ptr;
+	u64 tb_delta;
+	u64 stolen = 0;
+	u64 dtb;
+
+	if (i == vpa->dtl_idx)
+		return 0;
+	while (i < vpa->dtl_idx) {
+		dtb = dtl->timebase;
+		tb_delta = dtl->enqueue_to_dispatch_time +
+			dtl->ready_to_enqueue_time;
+		barrier();
+		if (i + N_DISPATCH_LOG < vpa->dtl_idx) {
+			/* buffer has overflowed */
+			i = vpa->dtl_idx - N_DISPATCH_LOG;
+			dtl = local_paca->dispatch_log + (i % N_DISPATCH_LOG);
+			continue;
+		}
+		if (dtb > stop_tb)
+			break;
+		stolen += tb_delta;
+		++i;
+		++dtl;
+		if (dtl == dtl_end)
+			dtl = local_paca->dispatch_log;
+	}
+	local_paca->dtl_ridx = i;
+	local_paca->dtl_curr = dtl;
+	return stolen;
 }
 
 /*
+ * Accumulate stolen time by scanning the dispatch trace log.
+ * Called on entry from user mode.
+ */
+void accumulate_stolen_time(void)
+{
+	u64 sst, ust;
+
+	sst = scan_dispatch_log(get_paca()->starttime_user);
+	ust = scan_dispatch_log(get_paca()->starttime);
+	get_paca()->system_time -= sst;
+	get_paca()->user_time -= ust;
+	get_paca()->stolen_time += ust + sst;
+}
+
+static inline u64 calculate_stolen_time(u64 stop_tb)
+{
+	u64 stolen = 0;
+
+	if (get_paca()->dtl_ridx != get_paca()->lppaca_ptr->dtl_idx) {
+		stolen = scan_dispatch_log(stop_tb);
+		get_paca()->system_time -= stolen;
+	}
+
+	stolen += get_paca()->stolen_time;
+	get_paca()->stolen_time = 0;
+	return stolen;
+}
+
+#else /* CONFIG_PPC_SPLPAR */
+static inline u64 calculate_stolen_time(u64 stop_tb)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PPC_SPLPAR */
+
+/*
  * Account time for a transition between system, hard irq
  * or soft irq state.
  */
 void account_system_vtime(struct task_struct *tsk)
 {
-	u64 now, nowscaled, delta, deltascaled, sys_time;
+	u64 now, nowscaled, delta, deltascaled;
 	unsigned long flags;
+	u64 stolen, udelta, sys_scaled, user_scaled;
 
 	local_irq_save(flags);
-	now = read_purr();
+	now = mftb();
 	nowscaled = read_spurr(now);
-	delta = now - get_paca()->startpurr;
+	get_paca()->system_time += now - get_paca()->starttime;
+	get_paca()->starttime = now;
 	deltascaled = nowscaled - get_paca()->startspurr;
-	get_paca()->startpurr = now;
 	get_paca()->startspurr = nowscaled;
-	if (!in_interrupt()) {
-		/* deltascaled includes both user and system time.
-		 * Hence scale it based on the purr ratio to estimate
-		 * the system time */
-		sys_time = get_paca()->system_time;
-		if (get_paca()->user_time)
-			deltascaled = deltascaled * sys_time /
-			     (sys_time + get_paca()->user_time);
-		delta += sys_time;
-		get_paca()->system_time = 0;
+
+	stolen = calculate_stolen_time(now);
+
+	delta = get_paca()->system_time;
+	get_paca()->system_time = 0;
+	udelta = get_paca()->user_time - get_paca()->utime_sspurr;
+	get_paca()->utime_sspurr = get_paca()->user_time;
+
+	/*
+	 * Because we don't read the SPURR on every kernel entry/exit,
+	 * deltascaled includes both user and system SPURR ticks.
+	 * Apportion these ticks to system SPURR ticks and user
+	 * SPURR ticks in the same ratio as the system time (delta)
+	 * and user time (udelta) values obtained from the timebase
+	 * over the same interval.  The system ticks get accounted here;
+	 * the user ticks get saved up in paca->user_time_scaled to be
+	 * used by account_process_tick.
+	 */
+	sys_scaled = delta;
+	user_scaled = udelta;
+	if (deltascaled != delta + udelta) {
+		if (udelta) {
+			sys_scaled = deltascaled * delta / (delta + udelta);
+			user_scaled = deltascaled - sys_scaled;
+		} else {
+			sys_scaled = deltascaled;
+		}
+	}
+	get_paca()->user_time_scaled += user_scaled;
+
+	if (in_irq() || idle_task(smp_processor_id()) != tsk) {
+		account_system_time(tsk, 0, delta, sys_scaled);
+		if (stolen)
+			account_steal_time(stolen);
+	} else {
+		account_idle_time(delta + stolen);
 	}
-	if (in_irq() || idle_task(smp_processor_id()) != tsk)
-		account_system_time(tsk, 0, delta, deltascaled);
-	else
-		account_idle_time(delta);
-	__get_cpu_var(cputime_last_delta) = delta;
-	__get_cpu_var(cputime_scaled_last_delta) = deltascaled;
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
@@ -265,125 +352,26 @@ EXPORT_SYMBOL_GPL(account_system_vtime);
  * by the exception entry and exit code to the generic process
  * user and system time records.
  * Must be called with interrupts disabled.
+ * Assumes that account_system_vtime() has been called recently
+ * (i.e. since the last entry from usermode) so that
+ * get_paca()->user_time_scaled is up to date.
  */
 void account_process_tick(struct task_struct *tsk, int user_tick)
 {
 	cputime_t utime, utimescaled;
 
 	utime = get_paca()->user_time;
+	utimescaled = get_paca()->user_time_scaled;
 	get_paca()->user_time = 0;
-	utimescaled = cputime_to_scaled(utime);
+	get_paca()->user_time_scaled = 0;
+	get_paca()->utime_sspurr = 0;
 	account_user_time(tsk, utime, utimescaled);
 }
 
-/*
- * Stuff for accounting stolen time.
- */
-struct cpu_purr_data {
-	int	initialized;			/* thread is running */
-	u64	tb;			/* last TB value read */
-	u64	purr;			/* last PURR value read */
-	u64	spurr;			/* last SPURR value read */
-};
-
-/*
- * Each entry in the cpu_purr_data array is manipulated only by its
- * "owner" cpu -- usually in the timer interrupt but also occasionally
- * in process context for cpu online.  As long as cpus do not touch
- * each others' cpu_purr_data, disabling local interrupts is
- * sufficient to serialize accesses.
- */
-static DEFINE_PER_CPU(struct cpu_purr_data, cpu_purr_data);
-
-static void snapshot_tb_and_purr(void *data)
-{
-	unsigned long flags;
-	struct cpu_purr_data *p = &__get_cpu_var(cpu_purr_data);
-
-	local_irq_save(flags);
-	p->tb = get_tb_or_rtc();
-	p->purr = mfspr(SPRN_PURR);
-	wmb();
-	p->initialized = 1;
-	local_irq_restore(flags);
-}
-
-/*
- * Called during boot when all cpus have come up.
- */
-void snapshot_timebases(void)
-{
-	if (!cpu_has_feature(CPU_FTR_PURR))
-		return;
-	on_each_cpu(snapshot_tb_and_purr, NULL, 1);
-}
-
-/*
- * Must be called with interrupts disabled.
- */
-void calculate_steal_time(void)
-{
-	u64 tb, purr;
-	s64 stolen;
-	struct cpu_purr_data *pme;
-
-	pme = &__get_cpu_var(cpu_purr_data);
-	if (!pme->initialized)
-		return;		/* !CPU_FTR_PURR or early in early boot */
-	tb = mftb();
-	purr = mfspr(SPRN_PURR);
-	stolen = (tb - pme->tb) - (purr - pme->purr);
-	if (stolen > 0) {
-		if (idle_task(smp_processor_id()) != current)
-			account_steal_time(stolen);
-		else
-			account_idle_time(stolen);
-	}
-	pme->tb = tb;
-	pme->purr = purr;
-}
-
-#ifdef CONFIG_PPC_SPLPAR
-/*
- * Must be called before the cpu is added to the online map when
- * a cpu is being brought up at runtime.
- */
-static void snapshot_purr(void)
-{
-	struct cpu_purr_data *pme;
-	unsigned long flags;
-
-	if (!cpu_has_feature(CPU_FTR_PURR))
-		return;
-	local_irq_save(flags);
-	pme = &__get_cpu_var(cpu_purr_data);
-	pme->tb = mftb();
-	pme->purr = mfspr(SPRN_PURR);
-	pme->initialized = 1;
-	local_irq_restore(flags);
-}
-
-#endif /* CONFIG_PPC_SPLPAR */
-
 #else /* ! CONFIG_VIRT_CPU_ACCOUNTING */
 #define calc_cputime_factors()
-#define calculate_steal_time()		do { } while (0)
 #endif
 
-#if !(defined(CONFIG_VIRT_CPU_ACCOUNTING) && defined(CONFIG_PPC_SPLPAR))
-#define snapshot_purr()			do { } while (0)
-#endif
-
-/*
- * Called when a cpu comes up after the system has finished booting,
- * i.e. as a result of a hotplug cpu action.
- */
-void snapshot_timebase(void)
-{
-	__get_cpu_var(last_jiffy) = get_tb_or_rtc();
-	snapshot_purr();
-}
-
 void __delay(unsigned long loops)
 {
 	unsigned long start;
@@ -585,8 +573,6 @@ void timer_interrupt(struct pt_regs * regs)
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
-	calculate_steal_time();
-
 	if (test_perf_event_pending()) {
 		clear_perf_event_pending();
 		perf_event_do_pending();
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index adfd544..0357655 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -27,27 +27,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/firmware.h>
+#include <asm/lppaca.h>
 
 #include "plpar_wrappers.h"
 
-/*
- * Layout of entries in the hypervisor's DTL buffer. Although we don't
- * actually access the internals of an entry (we only need to know the size),
- * we might as well define it here for reference.
- */
-struct dtl_entry {
-	u8	dispatch_reason;
-	u8	preempt_reason;
-	u16	processor_id;
-	u32	enqueue_to_dispatch_time;
-	u32	ready_to_enqueue_time;
-	u32	waiting_to_ready_time;
-	u64	timebase;
-	u64	fault_addr;
-	u64	srr0;
-	u64	srr1;
-};
-
 struct dtl {
 	struct dtl_entry	*buf;
 	struct dentry		*file;
@@ -237,6 +220,11 @@ static int dtl_init(void)
 	struct dentry *event_mask_file, *buf_entries_file;
 	int rc, i;
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	/* disable this for now */
+	return -ENODEV;
+#endif
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -ENODEV;
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index a17fe4a..f129040 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -248,6 +248,8 @@ void vpa_init(int cpu)
 	int hwcpu = get_hard_smp_processor_id(cpu);
 	unsigned long addr;
 	long ret;
+	struct paca_struct *pp;
+	struct dtl_entry *dtl;
 
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca_of(cpu).vmxregs_in_use = 1;
@@ -274,6 +276,25 @@ void vpa_init(int cpu)
 			       "registration for cpu %d (hw %d) of area %lx "
 			       "returns %ld\n", cpu, hwcpu, addr, ret);
 	}
+
+	/*
+	 * Register dispatch trace log, if one has been allocated.
+	 */
+	pp = &paca[cpu];
+	dtl = pp->dispatch_log;
+	if (dtl) {
+		pp->dtl_ridx = 0;
+		pp->dtl_curr = dtl;
+		lppaca_of(cpu).dtl_idx = 0;
+
+		/* hypervisor reads buffer length from this field */
+		dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
+		ret = register_dtl(hwcpu, __pa(dtl));
+		if (ret)
+			pr_warn("DTL registration failed for cpu %d (%ld)\n",
+				cpu, ret);
+		lppaca_of(cpu).dtl_enable_mask = 2;
+	}
 }
 
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index a6d19e3..d345bfd 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -273,6 +273,58 @@ static struct notifier_block pci_dn_reconfig_nb = {
 	.notifier_call = pci_dn_reconfig_notifier,
 };
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+/*
+ * Allocate space for the dispatch trace log for all possible cpus
+ * and register the buffers with the hypervisor.  This is used for
+ * computing time stolen by the hypervisor.
+ */
+static int alloc_dispatch_logs(void)
+{
+	int cpu, ret;
+	struct paca_struct *pp;
+	struct dtl_entry *dtl;
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		pp = &paca[cpu];
+		dtl = kmalloc_node(DISPATCH_LOG_BYTES, GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!dtl) {
+			pr_warn("Failed to allocate dispatch trace log for cpu %d\n",
+				cpu);
+			pr_warn("Stolen time statistics will be unreliable\n");
+			break;
+		}
+
+		pp->dtl_ridx = 0;
+		pp->dispatch_log = dtl;
+		pp->dispatch_log_end = dtl + N_DISPATCH_LOG;
+		pp->dtl_curr = dtl;
+	}
+
+	/* Register the DTL for the current (boot) cpu */
+	dtl = get_paca()->dispatch_log;
+	get_paca()->dtl_ridx = 0;
+	get_paca()->dtl_curr = dtl;
+	get_paca()->lppaca_ptr->dtl_idx = 0;
+
+	/* hypervisor reads buffer length from this field */
+	dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
+	ret = register_dtl(hard_smp_processor_id(), __pa(dtl));
+	if (ret)
+		pr_warn("DTL registration failed for boot cpu %d (%d)\n",
+			smp_processor_id(), ret);
+	get_paca()->lppaca_ptr->dtl_enable_mask = 2;
+
+	return 0;
+}
+
+early_initcall(alloc_dispatch_logs);
+#endif /* CONFIG_VIRT_CPU_ACCOUNTING */
+
 static void __init pSeries_setup_arch(void)
 {
 	/* Discover PIC type and setup ppc_md accordingly */
-- 
1.7.1
