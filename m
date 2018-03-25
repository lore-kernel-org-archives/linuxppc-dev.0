Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0058.outbound.protection.outlook.com [104.47.40.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408PxG2cQCzF1wG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 04:52:18 +1100 (AEDT)
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Date: Sun, 25 Mar 2018 20:50:04 +0300
Message-Id: <20180325175004.28162-3-ynorov@caviumnetworks.com>
In-Reply-To: <20180325175004.28162-1-ynorov@caviumnetworks.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
If CPU is in extended quiescent state (idle task or nohz_full userspace), this
work may be done at the exit of this state. Delaying synchronization helps to
save power if CPU is in idle state and decrease latency for real-time tasks.

This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
code to delay syncronization.

For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
isolated task would be fatal, as it breaks isolation. The approach with delaying
of synchronization work helps to maintain isolated state.

I've tested it with test from task isolation series on ThunderX2 for more than
10 hours (10k giga-ticks) without breaking isolation.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/insn.c |  2 +-
 include/linux/smp.h      |  2 ++
 kernel/smp.c             | 24 ++++++++++++++++++++++++
 mm/slab.c                |  2 +-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 2718a77da165..9d7c492e920e 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 			 * synchronization.
 			 */
 			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
-			kick_all_cpus_sync();
+			kick_active_cpus_sync();
 			return ret;
 		}
 	}
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9fb239e12b82..27215e22240d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
 
 void kick_all_cpus_sync(void);
+void kick_active_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
 /*
@@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 }
 
 static inline void kick_all_cpus_sync(void) {  }
+static inline void kick_active_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
diff --git a/kernel/smp.c b/kernel/smp.c
index 084c8b3a2681..0358d6673850 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
+/**
+ * kick_active_cpus_sync - Force CPUs that are not in extended
+ * quiescent state (idle or nohz_full userspace) sync by sending
+ * IPI. Extended quiescent state CPUs will sync at the exit of
+ * that state.
+ */
+void kick_active_cpus_sync(void)
+{
+	int cpu;
+	struct cpumask kernel_cpus;
+
+	smp_mb();
+
+	cpumask_clear(&kernel_cpus);
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		if (!rcu_eqs_special_set(cpu))
+			cpumask_set_cpu(cpu, &kernel_cpus);
+	}
+	smp_call_function_many(&kernel_cpus, do_nothing, NULL, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kick_active_cpus_sync);
+
 /**
  * wake_up_all_idle_cpus - break all cpus out of idle
  * wake_up_all_idle_cpus try to break all cpus which is in idle state even
diff --git a/mm/slab.c b/mm/slab.c
index 324446621b3e..678d5dbd6f46 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3856,7 +3856,7 @@ static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
 	 * cpus, so skip the IPIs.
 	 */
 	if (prev)
-		kick_all_cpus_sync();
+		kick_active_cpus_sync();
 
 	check_irq_on();
 	cachep->batchcount = batchcount;
-- 
2.14.1
