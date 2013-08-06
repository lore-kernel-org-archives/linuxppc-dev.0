Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 09/63] powerpc: Stop using non-architected shared_proc field
 in lppaca
Date: Wed,  7 Aug 2013 02:01:26 +1000
Message-Id: <1375804940-22050-10-git-send-email-anton@samba.org>
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

Although the shared_proc field in the lppaca works today, it is
not architected. A shared processor partition will always have a non
zero yield_count so use that instead. Create a wrapper so users
don't have to know about the details.

In order for older kernels to continue to work on KVM we need
to set the shared_proc bit. While here, remove the ugly bitfield.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/lppaca.h               | 18 ++++++++++++++----
 arch/powerpc/include/asm/spinlock.h             |  2 +-
 arch/powerpc/kernel/lparcfg.c                   |  5 +++--
 arch/powerpc/kvm/book3s_hv.c                    |  2 +-
 arch/powerpc/mm/numa.c                          |  2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |  4 ++--
 arch/powerpc/platforms/pseries/processor_idle.c |  2 +-
 7 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 9b12f88..bc8def0 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -50,10 +50,8 @@ struct lppaca {
 
 	u32	desc;			/* Eye catcher 0xD397D781 */
 	u16	size;			/* Size of this struct */
-	u16	reserved1;
-	u16	reserved2:14;
-	u8	shared_proc:1;		/* Shared processor indicator */
-	u8	secondary_thread:1;	/* Secondary thread indicator */
+	u8	reserved1[3];
+	u8	__old_status;		/* Old status, including shared proc */
 	u8	reserved3[14];
 	volatile u32 dyn_hw_node_id;	/* Dynamic hardware node id */
 	volatile u32 dyn_hw_proc_id;	/* Dynamic hardware proc id */
@@ -108,6 +106,18 @@ extern struct lppaca lppaca[];
 #define lppaca_of(cpu)	(*paca[cpu].lppaca_ptr)
 
 /*
+ * Old kernels used a reserved bit in the VPA to determine if it was running
+ * in shared processor mode. New kernels look for a non zero yield count
+ * but KVM still needs to set the bit to keep the old stuff happy.
+ */
+#define LPPACA_OLD_SHARED_PROC		2
+
+static inline bool lppaca_shared_proc(struct lppaca *l)
+{
+	return l->yield_count != 0;
+}
+
+/*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
  * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
  * ESID is stored in the lower 64bits, then the VSID.
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 5b23f91..7c345b6 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -96,7 +96,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 #if defined(CONFIG_PPC_SPLPAR)
 /* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (local_paca->lppaca_ptr->shared_proc)
+#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index d92f387..e6024c2 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -165,7 +165,7 @@ static void parse_ppp_data(struct seq_file *m)
 	           ppp_data.active_system_procs);
 
 	/* pool related entries are appropriate for shared configs */
-	if (lppaca_of(0).shared_proc) {
+	if (lppaca_shared_proc(get_lppaca())) {
 		unsigned long pool_idle_time, pool_procs;
 
 		seq_printf(m, "pool=%d\n", ppp_data.pool_num);
@@ -473,7 +473,8 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	seq_printf(m, "partition_potential_processors=%d\n",
 		   partition_potential_processors);
 
-	seq_printf(m, "shared_processor_mode=%d\n", lppaca_of(0).shared_proc);
+	seq_printf(m, "shared_processor_mode=%d\n",
+		   lppaca_shared_proc(get_lppaca()));
 
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2efa9dd..cf39bf4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -217,7 +217,7 @@ struct kvm_vcpu *kvmppc_find_vcpu(struct kvm *kvm, int id)
 
 static void init_vpa(struct kvm_vcpu *vcpu, struct lppaca *vpa)
 {
-	vpa->shared_proc = 1;
+	vpa->__old_status |= LPPACA_OLD_SHARED_PROC;
 	vpa->yield_count = 1;
 }
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5850798..501e32c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1609,7 +1609,7 @@ int start_topology_update(void)
 #endif
 		}
 	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
-		   get_lppaca()->shared_proc) {
+		   lppaca_shared_proc(get_lppaca())) {
 		if (!vphn_enabled) {
 			prrn_enabled = 0;
 			vphn_enabled = 1;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 217ca5c..1e490cf 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -123,7 +123,7 @@ static void pseries_mach_cpu_die(void)
 		cede_latency_hint = 2;
 
 		get_lppaca()->idle = 1;
-		if (!get_lppaca()->shared_proc)
+		if (!lppaca_shared_proc(get_lppaca()))
 			get_lppaca()->donate_dedicated_cpu = 1;
 
 		while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
@@ -137,7 +137,7 @@ static void pseries_mach_cpu_die(void)
 
 		local_irq_disable();
 
-		if (!get_lppaca()->shared_proc)
+		if (!lppaca_shared_proc(get_lppaca()))
 			get_lppaca()->donate_dedicated_cpu = 0;
 		get_lppaca()->idle = 0;
 
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 4644efa0..92db881 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -308,7 +308,7 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
-	if (get_lppaca()->shared_proc)
+	if (lppaca_shared_proc(get_lppaca()))
 		cpuidle_state_table = shared_states;
 	else
 		cpuidle_state_table = dedicated_states;
-- 
1.8.1.2
