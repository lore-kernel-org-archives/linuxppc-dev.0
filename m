Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pdt51yVMzF1t4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 16:35:25 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id w12-v6so8545989plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 23:35:25 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCHv2 2/3] powerpc/cpu: dynmamically to create/destroy the file
 physical_id during hotplug
Date: Mon, 16 Apr 2018 14:35:07 +0800
Message-Id: <1523860508-19364-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
References: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to cope with the incoming patch [3/3], which causes the dir
/sys/../cpuX is created/destroyed during hotplug, we also need to create
the file cpuX/physical_id dynamically.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reported-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 04d0bbd..a05ab5e 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -716,6 +716,16 @@ static struct device_attribute pa6t_attrs[] = {
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+/* Only valid if CPU is present. */
+static ssize_t show_physical_id(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
+}
+static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -723,6 +733,8 @@ static int register_cpu_online(unsigned int cpu)
 	struct device_attribute *attrs, *pmc_attrs;
 	int i, nattrs;
 
+	device_create_file(&c->dev, &dev_attr_physical_id);
+
 	/* For cpus present at boot a reference was already grabbed in register_cpu() */
 	if (!s->of_node)
 		s->of_node = of_get_cpu_node(cpu, NULL);
@@ -816,6 +828,7 @@ static int unregister_cpu_online(unsigned int cpu)
 
 	BUG_ON(!c->hotpluggable);
 
+	device_remove_file(s, &dev_attr_physical_id);
 #ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_SMT))
 		device_remove_file(s, &dev_attr_smt_snooze_delay);
@@ -1017,16 +1030,6 @@ static void register_nodes(void)
 
 #endif
 
-/* Only valid if CPU is present. */
-static ssize_t show_physical_id(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-
-	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
-}
-static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
-
 static int __init topology_init(void)
 {
 	int cpu, r;
@@ -1049,7 +1052,6 @@ static int __init topology_init(void)
 		if (cpu_online(cpu) || c->hotpluggable) {
 			register_cpu(c, cpu);
 
-			device_create_file(&c->dev, &dev_attr_physical_id);
 		}
 	}
 	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
-- 
2.7.4
