Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 157F9B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 19:17:27 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 1 Mar 2012 13:47:22 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q218H1B84014204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 13:47:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q218Gx8h031898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 13:47:01 +0530
Message-ID: <4F4F307A.7040105@linux.vnet.ibm.com>
Date: Thu, 01 Mar 2012 13:46:58 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2/3] CPU hotplug,
 arch/powerpc: Fix CPU hotplug callback registration
References: <87ehtf3lqh.fsf@rustcorp.com.au>
 <20120227155338.7b5110cd.akpm@linux-foundation.org>
 <20120228084359.GJ21106@elte.hu>
 <20120228132719.f375071a.akpm@linux-foundation.org>
 <4F4DBB26.2060907@linux.vnet.ibm.com> <20120229091732.GA11505@elte.hu>
 <4F4E083A.2080304@linux.vnet.ibm.com> <4F4F2F7F.5040207@linux.vnet.ibm.com>
In-Reply-To: <4F4F2F7F.5040207@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andi Kleen <ak@linux.intel.com>, Nick Piggin <npiggin@kernel.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan.van.de.ven@intel.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Restructure CPU hotplug setup and callback registration in topology_init
so as to be race-free.

---

 arch/powerpc/kernel/sysfs.c |   44 +++++++++++++++++++++++++++++++++++--------
 arch/powerpc/mm/numa.c      |   11 ++++++++---
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 883e74c..5838b33 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -496,6 +496,38 @@ ssize_t arch_cpu_release(const char *buf, size_t count)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static void cpu_register_helper(struct cpu *c, int cpu)
+{
+	register_cpu(c, cpu);
+	device_create_file(&c->dev, &dev_attr_physical_id);
+}
+
+static int __cpuinit sysfs_cpu_notify_first_time(struct notifier_block *self,
+				      unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)(long)hcpu;
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	if (action == CPU_ONLINE)
+		if (!c->hotpluggable) /* Avoid duplicate registrations */
+			cpu_register_helper(c, cpu);
+		register_cpu_online(cpu);
+	}
+	return NOTIFY_OK;
+}
+static int __cpuinit sysfs_cpu_notify_setup(void)
+{
+	int cpu;
+
+	/*
+	 * We don't race with CPU hotplug because we are called from
+	 * the CPU hotplug callback registration function.
+	 */
+	for_each_online_cpu(cpu)
+		sysfs_cpu_notify_first_time(NULL, CPU_ONLINE, cpu);
+
+	return 0;
+}
 static int __cpuinit sysfs_cpu_notify(struct notifier_block *self,
 				      unsigned long action, void *hcpu)
 {
@@ -637,7 +669,6 @@ static int __init topology_init(void)
 	int cpu;
 
 	register_nodes();
-	register_cpu_notifier(&sysfs_cpu_nb);
 
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -652,15 +683,12 @@ static int __init topology_init(void)
 		if (ppc_md.cpu_die)
 			c->hotpluggable = 1;
 
-		if (cpu_online(cpu) || c->hotpluggable) {
-			register_cpu(c, cpu);
+		if (c->hotpluggable)
+			cpu_register_helper(c, cpu);
+	}
 
-			device_create_file(&c->dev, &dev_attr_physical_id);
-		}
+	register_allcpu_notifier(&sysfs_cpu_nb, true, &sysfs_cpu_notify_setup);
 
-		if (cpu_online(cpu))
-			register_cpu_online(cpu);
-	}
 #ifdef CONFIG_PPC64
 	sysfs_create_dscr_default();
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3feefc3..e326455 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1014,6 +1014,13 @@ static void __init mark_reserved_regions_for_nid(int nid)
 	}
 }
 
+static int __cpuinit cpu_numa_callback_setup(void)
+{
+	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
+			(void *)(unsigned long)boot_cpuid);
+	return 0;
+}
+
 
 void __init do_init_bootmem(void)
 {
@@ -1088,9 +1095,7 @@ void __init do_init_bootmem(void)
 	 */
 	setup_node_to_cpumask_map();
 
-	register_cpu_notifier(&ppc64_numa_nb);
-	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
-			  (void *)(unsigned long)boot_cpuid);
+	register_allcpu_notifier(&ppc64_numa_nb, true, &cpu_numa_callback_setup);
 }
 
 void __init paging_init(void)
