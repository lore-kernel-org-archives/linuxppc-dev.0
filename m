Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 29/63] powerpc: Fix little endian lppaca,
 slb_shadow and dtl_entry
Date: Wed,  7 Aug 2013 02:01:46 +1000
Message-Id: <1375804940-22050-30-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lppaca, slb_shadow and dtl_entry hypervisor structures are
big endian, so we have to byte swap them in little endian builds.

LE KVM hosts will also need to be fixed but for now add an #error
to remind us.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/asm-compat.h           |  9 +++++++++
 arch/powerpc/include/asm/ppc_asm.h              |  3 ++-
 arch/powerpc/kernel/entry_64.S                  | 11 +++++++----
 arch/powerpc/kernel/lparcfg.c                   |  9 +++++----
 arch/powerpc/kernel/paca.c                      | 10 +++++-----
 arch/powerpc/kernel/time.c                      | 16 ++++++++--------
 arch/powerpc/kvm/book3s_64_slb.S                |  4 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S         |  4 ++++
 arch/powerpc/lib/locks.c                        |  4 ++--
 arch/powerpc/mm/fault.c                         |  6 +++++-
 arch/powerpc/mm/slb.c                           |  9 ++++++---
 arch/powerpc/platforms/pseries/dtl.c            |  2 +-
 arch/powerpc/platforms/pseries/lpar.c           |  2 +-
 arch/powerpc/platforms/pseries/processor_idle.c |  6 +++++-
 arch/powerpc/platforms/pseries/setup.c          |  2 +-
 15 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 6e82f5f..4b237aa 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -32,6 +32,15 @@
 #define PPC_MTOCRF(FXM, RS) MTOCRF((FXM), RS)
 #define PPC_LR_STKOFF	16
 #define PPC_MIN_STKFRM	112
+
+#ifdef __BIG_ENDIAN__
+#define LDX_BE	stringify_in_c(ldx)
+#define STDX_BE	stringify_in_c(stdx)
+#else
+#define LDX_BE	stringify_in_c(ldbrx)
+#define STDX_BE	stringify_in_c(stdbrx)
+#endif
+
 #else /* 32-bit */
 
 /* operations for longs and pointers */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index b5c85f1..4ebb4f8 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -54,7 +54,8 @@ BEGIN_FW_FTR_SECTION;							\
 	/* from user - see if there are any DTL entries to process */	\
 	ld	r10,PACALPPACAPTR(r13);	/* get ptr to VPA */		\
 	ld	r11,PACA_DTL_RIDX(r13);	/* get log read index */	\
-	ld	r10,LPPACA_DTLIDX(r10);	/* get log write index */	\
+	addi	r10,r10,LPPACA_DTLIDX;					\
+	LDX_BE	r10,0,r10;		/* get log write index */	\
 	cmpd	cr1,r11,r10;						\
 	beq+	cr1,33f;						\
 	bl	.accumulate_stolen_time;				\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ab15b8d..209e8ce 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -102,7 +102,8 @@ BEGIN_FW_FTR_SECTION
 	/* if from user, see if there are any DTL entries to process */
 	ld	r10,PACALPPACAPTR(r13)	/* get ptr to VPA */
 	ld	r11,PACA_DTL_RIDX(r13)	/* get log read index */
-	ld	r10,LPPACA_DTLIDX(r10)	/* get log write index */
+	addi	r10,r10,LPPACA_DTLIDX
+	LDX_BE	r10,0,r10		/* get log write index */
 	cmpd	cr1,r11,r10
 	beq+	cr1,33f
 	bl	.accumulate_stolen_time
@@ -531,9 +532,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	 */
 	ld	r9,PACA_SLBSHADOWPTR(r13)
 	li	r12,0
-	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
-	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
-	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
+	std	r12,SLBSHADOW_STACKESID(r9)	/* Clear ESID */
+	li	r12,SLBSHADOW_STACKVSID
+	STDX_BE	r7,r12,r9			/* Save VSID */
+	li	r12,SLBSHADOW_STACKESID
+	STDX_BE	r0,r12,r9			/* Save ESID */
 
 	/* No need to check for MMU_FTR_NO_SLBIE_B here, since when
 	 * we have 1TB segments, the only CPUs known to have the errata
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index e6024c2..0204089 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -387,8 +387,8 @@ static void pseries_cmo_data(struct seq_file *m)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		cmo_faults += lppaca_of(cpu).cmo_faults;
-		cmo_fault_time += lppaca_of(cpu).cmo_fault_time;
+		cmo_faults += be64_to_cpu(lppaca_of(cpu).cmo_faults);
+		cmo_fault_time += be64_to_cpu(lppaca_of(cpu).cmo_fault_time);
 	}
 
 	seq_printf(m, "cmo_faults=%lu\n", cmo_faults);
@@ -406,8 +406,9 @@ static void splpar_dispatch_data(struct seq_file *m)
 	unsigned long dispatch_dispersions = 0;
 
 	for_each_possible_cpu(cpu) {
-		dispatches += lppaca_of(cpu).yield_count;
-		dispatch_dispersions += lppaca_of(cpu).dispersion_count;
+		dispatches += be32_to_cpu(lppaca_of(cpu).yield_count);
+		dispatch_dispersions +=
+			be32_to_cpu(lppaca_of(cpu).dispersion_count);
 	}
 
 	seq_printf(m, "dispatches=%lu\n", dispatches);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f8f2468..3fc16e3 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -34,10 +34,10 @@ extern unsigned long __toc_start;
  */
 struct lppaca lppaca[] = {
 	[0 ... (NR_LPPACAS-1)] = {
-		.desc = 0xd397d781,	/* "LpPa" */
-		.size = sizeof(struct lppaca),
+		.desc = cpu_to_be32(0xd397d781),	/* "LpPa" */
+		.size = cpu_to_be16(sizeof(struct lppaca)),
 		.fpregs_in_use = 1,
-		.slb_count = 64,
+		.slb_count = cpu_to_be16(64),
 		.vmxregs_in_use = 0,
 		.page_ins = 0,
 	},
@@ -101,8 +101,8 @@ static inline void free_lppacas(void) { }
  */
 struct slb_shadow slb_shadow[] __cacheline_aligned = {
 	[0 ... (NR_CPUS-1)] = {
-		.persistent = SLB_NUM_BOLTED,
-		.buffer_length = sizeof(struct slb_shadow),
+		.persistent = cpu_to_be32(SLB_NUM_BOLTED),
+		.buffer_length = cpu_to_be32(sizeof(struct slb_shadow)),
 	},
 };
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index c863aa1..b2bcd34 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -210,18 +210,18 @@ static u64 scan_dispatch_log(u64 stop_tb)
 	if (!dtl)
 		return 0;
 
-	if (i == vpa->dtl_idx)
+	if (i == be64_to_cpu(vpa->dtl_idx))
 		return 0;
-	while (i < vpa->dtl_idx) {
+	while (i < be64_to_cpu(vpa->dtl_idx)) {
 		if (dtl_consumer)
 			dtl_consumer(dtl, i);
-		dtb = dtl->timebase;
-		tb_delta = dtl->enqueue_to_dispatch_time +
-			dtl->ready_to_enqueue_time;
+		dtb = be64_to_cpu(dtl->timebase);
+		tb_delta = be32_to_cpu(dtl->enqueue_to_dispatch_time) +
+			be32_to_cpu(dtl->ready_to_enqueue_time);
 		barrier();
-		if (i + N_DISPATCH_LOG < vpa->dtl_idx) {
+		if (i + N_DISPATCH_LOG < be64_to_cpu(vpa->dtl_idx)) {
 			/* buffer has overflowed */
-			i = vpa->dtl_idx - N_DISPATCH_LOG;
+			i = be64_to_cpu(vpa->dtl_idx) - N_DISPATCH_LOG;
 			dtl = local_paca->dispatch_log + (i % N_DISPATCH_LOG);
 			continue;
 		}
@@ -269,7 +269,7 @@ static inline u64 calculate_stolen_time(u64 stop_tb)
 {
 	u64 stolen = 0;
 
-	if (get_paca()->dtl_ridx != get_paca()->lppaca_ptr->dtl_idx) {
+	if (get_paca()->dtl_ridx != be64_to_cpu(get_lppaca()->dtl_idx)) {
 		stolen = scan_dispatch_log(stop_tb);
 		get_paca()->system_time -= stolen;
 	}
diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_slb.S
index 4f0caec..4f12e8f 100644
--- a/arch/powerpc/kvm/book3s_64_slb.S
+++ b/arch/powerpc/kvm/book3s_64_slb.S
@@ -17,6 +17,10 @@
  * Authors: Alexander Graf <agraf@suse.de>
  */
 
+#ifdef __LITTLE_ENDIAN__
+#error Need to fix SLB shadow accesses in little endian mode
+#endif
+
 #define SHADOW_SLB_ESID(num)	(SLBSHADOW_SAVEAREA + (num * 0x10))
 #define SHADOW_SLB_VSID(num)	(SLBSHADOW_SAVEAREA + (num * 0x10) + 0x8)
 #define UNBOLT_SLB_ENTRY(num) \
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b02f91e..20e7fcd 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -29,6 +29,10 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/mmu-hash64.h>
 
+#ifdef __LITTLE_ENDIAN__
+#error Need to fix lppaca and SLB shadow accesses in little endian mode
+#endif
+
 /*****************************************************************************
  *                                                                           *
  *        Real Mode handlers that need to be in the linear mapping           *
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index bb7cfec..0c9c8d7 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -32,7 +32,7 @@ void __spin_yield(arch_spinlock_t *lock)
 		return;
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = lppaca_of(holder_cpu).yield_count;
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
@@ -57,7 +57,7 @@ void __rw_yield(arch_rwlock_t *rw)
 		return;		/* no write lock at present */
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = lppaca_of(holder_cpu).yield_count;
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8726779..76d8e7c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -443,8 +443,12 @@ good_area:
 				      regs, address);
 #ifdef CONFIG_PPC_SMLPAR
 			if (firmware_has_feature(FW_FEATURE_CMO)) {
+				u32 page_ins;
+
 				preempt_disable();
-				get_lppaca()->page_ins += (1 << PAGE_FACTOR);
+				page_ins = be32_to_cpu(get_lppaca()->page_ins);
+				page_ins += 1 << PAGE_FACTOR;
+				get_lppaca()->page_ins = cpu_to_be32(page_ins);
 				preempt_enable();
 			}
 #endif /* CONFIG_PPC_SMLPAR */
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a538c80..9d1d33c 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -66,8 +66,10 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
 	get_slb_shadow()->save_area[entry].esid = 0;
-	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, ssize, flags);
-	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, ssize, entry);
+	get_slb_shadow()->save_area[entry].vsid =
+				cpu_to_be64(mk_vsid_data(ea, ssize, flags));
+	get_slb_shadow()->save_area[entry].esid =
+				cpu_to_be64(mk_esid_data(ea, ssize, entry));
 }
 
 static inline void slb_shadow_clear(unsigned long entry)
@@ -112,7 +114,8 @@ static void __slb_flush_and_rebolt(void)
 	} else {
 		/* Update stack entry; others don't change */
 		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
-		ksp_vsid_data = get_slb_shadow()->save_area[2].vsid;
+		ksp_vsid_data =
+			be64_to_cpu(get_slb_shadow()->save_area[2].vsid);
 	}
 
 	/* We need to do this all in asm, so we're sure we don't touch
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 0cc0ac0..238240e 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -87,7 +87,7 @@ static void consume_dtle(struct dtl_entry *dtle, u64 index)
 	barrier();
 
 	/* check for hypervisor ring buffer overflow, ignore this entry if so */
-	if (index + N_DISPATCH_LOG < vpa->dtl_idx)
+	if (index + N_DISPATCH_LOG < be64_to_cpu(vpa->dtl_idx))
 		return;
 
 	++wp;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 60b6f4e..0b7c86e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -106,7 +106,7 @@ void vpa_init(int cpu)
 		lppaca_of(cpu).dtl_idx = 0;
 
 		/* hypervisor reads buffer length from this field */
-		dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
+		dtl->enqueue_to_dispatch_time = cpu_to_be32(DISPATCH_LOG_BYTES);
 		ret = register_dtl(hwcpu, __pa(dtl));
 		if (ret)
 			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 92db881..14899b1 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -45,7 +45,11 @@ static inline void idle_loop_prolog(unsigned long *in_purr)
 
 static inline void idle_loop_epilog(unsigned long in_purr)
 {
-	get_lppaca()->wait_state_cycles += mfspr(SPRN_PURR) - in_purr;
+	u64 wait_cycles;
+
+	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
+	wait_cycles += mfspr(SPRN_PURR) - in_purr;
+	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
 	get_lppaca()->idle = 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b19cd83..33d6196 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -323,7 +323,7 @@ static int alloc_dispatch_logs(void)
 	get_paca()->lppaca_ptr->dtl_idx = 0;
 
 	/* hypervisor reads buffer length from this field */
-	dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
+	dtl->enqueue_to_dispatch_time = cpu_to_be32(DISPATCH_LOG_BYTES);
 	ret = register_dtl(hard_smp_processor_id(), __pa(dtl));
 	if (ret)
 		pr_err("WARNING: DTL registration of cpu %d (hw %d) failed "
-- 
1.8.1.2
