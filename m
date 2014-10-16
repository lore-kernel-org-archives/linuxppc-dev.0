Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C0A21A03BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:51 +1100 (AEDT)
Received: by mail-ie0-f170.google.com with SMTP id rd18so2877354iec.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:48 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 03/11] powerpc: kvm: add interface to control kvm function on a
 core
Date: Thu, 16 Oct 2014 15:29:52 -0400
Message-Id: <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When kvm is enabled on a core, we migrate all external irq to primary
thread. Since currently, the kvmirq logic is handled by the primary
hwthread.

Todo: this patch lacks re-enable of irqbalance when kvm is disable on
the core

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c            | 39 ++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xics/xics-common.c | 12 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 67fd2fd..a2595dd 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -552,6 +552,45 @@ static void sysfs_create_dscr_default(void)
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
 }
+
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+#define NR_CORES	(CONFIG_NR_CPUS/threads_per_core)
+static DECLARE_BITMAP(kvm_on_core, NR_CORES) __read_mostly
+
+static ssize_t show_kvm_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+}
+
+static ssize_t __used store_kvm_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	struct cpumask stop_cpus;
+	unsigned long core, thr;
+
+	sscanf(buf, "%lx", &core);
+	if (core > NR_CORES)
+		return -1;
+	if (!test_bit(core, &kvm_on_core))
+		for (thr = 1; thr< threads_per_core; thr++)
+			if (cpu_online(thr * threads_per_core + thr))
+				cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);
+
+	stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
+	set_bit(core, &kvm_on_core);
+	return count;
+}
+
+static DEVICE_ATTR(kvm_enable, 0600,
+	show_kvm_enable, store_kvm_enable);
+
+static void sysfs_create_kvm_enable(void)
+{
+	device_create_file(cpu_subsys.dev_root, &dev_attr_kvm_enable);
+}
+#endif
+
 #endif /* CONFIG_PPC64 */
 
 #ifdef HAS_PPC_PMC_PA6T
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index fe0cca4..68b33d8 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -258,6 +258,18 @@ unlock:
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
+
+int xics_migrate_irqs_away_secondary(void *data)
+{
+	int cpu = smp_processor_id();
+	if(cpu%thread_per_core != 0) {
+		WARN(condition, format...);
+		return 0;
+	}
+	/* In fact, if we can migrate the primary, it will be more fine */
+	xics_migrate_irqs_away();
+	return 0;
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_SMP
-- 
1.8.3.1
