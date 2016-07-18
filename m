Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtQ434W4LzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 00:07:46 +1000 (AEST)
Date: Mon, 18 Jul 2016 16:07:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@kernel.org>,
 tglx@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 rt@linutronix.de, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2] powerpc/numa: Convert to hotplug state machine
Message-ID: <20160718140727.GA13132@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de>
 <20160715074257.7801cd00@kryten>
 <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
 <20160715102825.34d60395@kryten>
 <20160715162045.GE16938@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160715162045.GE16938@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

v1=E2=80=A6v2: manual callback invocation on boot-CPU (cpuhp is not up yet =
and
       we need them all before additional CPUs are up).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/powerpc/mm/numa.c     | 48 ++++++++++++++++++------------------------=
----
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e7fa76..6dc07ddbfd04 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -581,30 +581,22 @@ static void verify_cpu_node_mapping(int cpu, int node)
 	}
 }
=20
-static int cpu_numa_callback(struct notifier_block *nfb, unsigned long act=
ion,
-			     void *hcpu)
+/* Must run before sched domains notifier. */
+static int ppc_numa_cpu_prepare(unsigned int cpu)
 {
-	unsigned long lcpu =3D (unsigned long)hcpu;
-	int ret =3D NOTIFY_DONE, nid;
+	int nid;
=20
-	switch (action) {
-	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
-		nid =3D numa_setup_cpu(lcpu);
-		verify_cpu_node_mapping((int)lcpu, nid);
-		ret =3D NOTIFY_OK;
-		break;
+	nid =3D numa_setup_cpu(cpu);
+	verify_cpu_node_mapping(cpu, nid);
+	return 0;
+}
+
+static int ppc_numa_cpu_dead(unsigned int cpu)
+{
 #ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
-		unmap_cpu_from_node(lcpu);
-		ret =3D NOTIFY_OK;
-		break;
+	unmap_cpu_from_node(cpu);
 #endif
-	}
-	return ret;
+	return 0;
 }
=20
 /*
@@ -913,11 +905,6 @@ static void __init dump_numa_memory_topology(void)
 	}
 }
=20
-static struct notifier_block ppc64_numa_nb =3D {
-	.notifier_call =3D cpu_numa_callback,
-	.priority =3D 1 /* Must run before sched domains notifier. */
-};
-
 /* Initialize NODE_DATA for a node on the local memory */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
@@ -985,15 +972,18 @@ void __init initmem_init(void)
 	setup_node_to_cpumask_map();
=20
 	reset_numa_cpu_lookup_table();
-	register_cpu_notifier(&ppc64_numa_nb);
+
 	/*
 	 * We need the numa_cpu_lookup_table to be accurate for all CPUs,
 	 * even before we online them, so that we can use cpu_to_{node,mem}
 	 * early in boot, cf. smp_prepare_cpus().
+	 * _nocalls() + manual invocation is used because cpuhp is not yet
+	 * initialized for the boot CPU.
 	 */
-	for_each_present_cpu(cpu) {
-		numa_setup_cpu((unsigned long)cpu);
-	}
+	cpuhp_setup_state_nocalls(CPUHP_POWER_NUMA_PREPARE, "POWER_NUMA_PREPARE",
+				  ppc_numa_cpu_prepare, ppc_numa_cpu_dead);
+	for_each_present_cpu(cpu)
+		numa_setup_cpu(cpu);
 }
=20
 static int __init early_numa(char *p)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 09ef54bcba39..5015f463d314 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -15,6 +15,7 @@ enum cpuhp_state {
 	CPUHP_X86_HPET_DEAD,
 	CPUHP_X86_APB_DEAD,
 	CPUHP_WORKQUEUE_PREP,
+	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
 	CPUHP_PROFILE_PREPARE,
 	CPUHP_X2APIC_PREPARE,
--=20
2.8.1
