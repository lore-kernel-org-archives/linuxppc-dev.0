Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GNpn3fqTzF3Mv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 03:22:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KHEorB057268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 13:22:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mmcrh0ug0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 13:22:54 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 20 Sep 2018 11:22:54 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v8 3/3] powerpc/sysfs: Add
 topology/smallcore_thread_siblings[_list]
Date: Thu, 20 Sep 2018 22:52:39 +0530
In-Reply-To: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This patch adds two sysfs attributes named smallcore_thread_siblings
and smallcore_thread_siblings_list to the "topology" attribute group
for each CPU device.

The read-only attributes
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings and
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings_list
will the online siblings of CPU N that share the L1 cache with it on
big-core configurations in cpumask format and cpu-list format
respectively.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 ++++
 arch/powerpc/kernel/sysfs.c                        | 88 ++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 7331822..2a80dc2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,3 +511,17 @@ Description:	Control Symetric Multi Threading (SMT)
 
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
+
+What:		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings
+		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings_list
+Date:		Sept 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description: 	CPU topology files that describe the thread siblings of a
+		logical CPU that share the L1-cache with it on POWER9
+		big-core configurations.
+
+		smallcore_thread_siblings: internal kernel map of
+		cpu#'s hardware threads that share L1-cache with cpu#.
+
+		smallcore_thread_siblings_list: human-readable list of
+		cpu#'s hardware threads that share L1-cache with cpu#.
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..f9c7d96 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/cputhreads.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -714,6 +715,62 @@ static void sysfs_create_dscr_default(void)
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+static ssize_t smallcore_thread_siblings_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings);
+
+static ssize_t smallcore_thread_siblings_list_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings_list);
+
+static struct attribute *smallcore_attrs[] = {
+	&dev_attr_smallcore_thread_siblings.attr,
+	&dev_attr_smallcore_thread_siblings_list.attr,
+	NULL
+};
+
+static const struct attribute_group smallcore_attr_group = {
+	.name = "topology",
+	.attrs = smallcore_attrs
+};
+
+static int smallcore_register_cpu_online(unsigned int cpu)
+{
+	int err;
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	err = sysfs_merge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return err;
+}
+
+static int smallcore_unregister_cpu_online(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	sysfs_unmerge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return 0;
+}
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -1060,3 +1117,34 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
+
+/*
+ * NOTE: The smallcore_register_cpu_online
+ *       (resp. smallcore_unregister_cpu_online) callback will merge
+ *       (resp. unmerge) a couple of additional attributes to the
+ *       "topology" attribute group of a CPU device when the CPU comes
+ *       online (resp. goes offline).
+ *
+ *       Hence, the registration of these callbacks must happen after
+ *       topology_sysfs_init() is called so that the topology
+ *       attribute group is created before these additional attributes
+ *       can be merged/unmerged. We cannot register these callbacks in
+ *       topology_init() since this function is called before
+ *       topology_sysfs_init(). Hence we define the following
+ *       late_initcall for this purpose.
+ */
+static int __init smallcore_topology_init(void)
+{
+	int r;
+
+	if (!has_big_cores)
+		return 0;
+
+	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			      "powerpc/topology/smallcore:online",
+			      smallcore_register_cpu_online,
+			      smallcore_unregister_cpu_online);
+	WARN_ON(r < 0);
+	return 0;
+}
+late_initcall(smallcore_topology_init);
-- 
1.9.4
