Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D21411A002C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 05:09:17 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 15:09:15 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B4875C90026
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 15:09:03 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85J9Ccl61145150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 19:09:12 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s85J9B2Y017757
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 15:09:11 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pseries: Fix endianness in cpu hotplug and hotremove
Date: Fri,  5 Sep 2014 14:09:06 -0500
Message-Id: <1409944146-6813-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch attempts to ensure that all values are in the proper
endianness format when both hotadding and hotremoving cpus.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c       | 56 ++++++++++++++--------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 20 +++++-----
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a2450b8..c1d7e40 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -24,11 +24,11 @@
 #include <asm/rtas.h>
 
 struct cc_workarea {
-	u32	drc_index;
-	u32	zero;
-	u32	name_offset;
-	u32	prop_length;
-	u32	prop_offset;
+	__be32	drc_index;
+	__be32	zero;
+	__be32	name_offset;
+	__be32	prop_length;
+	__be32	prop_offset;
 };
 
 void dlpar_free_cc_property(struct property *prop)
@@ -48,11 +48,11 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 	if (!prop)
 		return NULL;
 
-	name = (char *)ccwa + ccwa->name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
 	prop->name = kstrdup(name, GFP_KERNEL);
 
-	prop->length = ccwa->prop_length;
-	value = (char *)ccwa + ccwa->prop_offset;
+	prop->length = be32_to_cpu(ccwa->prop_length);
+	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
 	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
 	if (!prop->value) {
 		dlpar_free_cc_property(prop);
@@ -78,7 +78,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
 	if (!dn)
 		return NULL;
 
-	name = (char *)ccwa + ccwa->name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
 	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
 	if (!dn->full_name) {
 		kfree(dn);
@@ -148,7 +148,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index,
 		return NULL;
 
 	ccwa = (struct cc_workarea *)&data_buf[0];
-	ccwa->drc_index = drc_index;
+	ccwa->drc_index = cpu_to_be32(drc_index);
 	ccwa->zero = 0;
 
 	do {
@@ -363,10 +363,10 @@ static int dlpar_online_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
+	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv_be)
 		return -EINVAL;
 
 	nthreads = len / sizeof(u32);
@@ -374,7 +374,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
@@ -388,7 +388,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 
@@ -442,18 +442,17 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
+	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv_be)
 		return -EINVAL;
 
 	nthreads = len / sizeof(u32);
-
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
@@ -469,20 +468,19 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				break;
 
 			}
-
 			/*
 			 * The cpu is in CPU_STATE_INACTIVE.
 			 * Upgrade it's state to CPU_STATE_OFFLINE.
 			 */
 			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+			BUG_ON(plpar_hcall_norets(H_PROD, be32_to_cpu(intserv_be[i]))
 								!= H_SUCCESS);
 			__cpu_die(cpu);
 			break;
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 
@@ -494,26 +492,28 @@ out:
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
-	const u32 *drc_index;
+	const __be32 *drc_index_be;
+	u32 drc_index;
 	int rc;
 
 	dn = of_find_node_by_path(buf);
 	if (!dn)
 		return -EINVAL;
 
-	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!drc_index) {
+	drc_index_be = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!drc_index_be) {
 		of_node_put(dn);
 		return -EINVAL;
 	}
 
+	drc_index = be32_to_cpup(drc_index_be);
 	rc = dlpar_offline_cpu(dn);
 	if (rc) {
 		of_node_put(dn);
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(*drc_index);
+	rc = dlpar_release_drc(drc_index);
 	if (rc) {
 		of_node_put(dn);
 		return rc;
@@ -521,7 +521,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 
 	rc = dlpar_detach_node(dn);
 	if (rc) {
-		dlpar_acquire_drc(*drc_index);
+		dlpar_acquire_drc(drc_index);
 		return rc;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 20d6297..fc9c2cd 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -90,7 +90,7 @@ static void rtas_stop_self(void)
 {
 	static struct rtas_args args = {
 		.nargs = 0,
-		.nret = 1,
+		.nret = cpu_to_be32(1),
 		.rets = &args.args[0],
 	};
 
@@ -247,10 +247,10 @@ static int pseries_add_processor(struct device_node *np)
 	unsigned int cpu;
 	cpumask_var_t candidate_mask, tmp;
 	int err = -ENOSPC, len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
+	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv_be)
 		return 0;
 
 	zalloc_cpumask_var(&candidate_mask, GFP_KERNEL);
@@ -293,7 +293,7 @@ static int pseries_add_processor(struct device_node *np)
 	for_each_cpu(cpu, tmp) {
 		BUG_ON(cpu_present(cpu));
 		set_cpu_present(cpu, true);
-		set_hard_smp_processor_id(cpu, *intserv++);
+		set_hard_smp_processor_id(cpu, be32_to_cpu(*intserv_be++));
 	}
 	err = 0;
 out_unlock:
@@ -312,10 +312,10 @@ static void pseries_remove_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
+	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv_be)
 		return;
 
 	nthreads = len / sizeof(u32);
@@ -323,7 +323,7 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
@@ -332,7 +332,7 @@ static void pseries_remove_processor(struct device_node *np)
 		}
 		if (cpu >= nr_cpu_ids)
 			printk(KERN_WARNING "Could not find cpu to remove "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 }
-- 
1.8.5.2
