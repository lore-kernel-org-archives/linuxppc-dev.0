Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rywhP2GNJzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 08:21:25 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PMJchL059005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:23 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c1h4vbp7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:22 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 16:21:22 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CF2EC1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:21:02 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 4/8] pseries/hotplug init: Convert new DRC memory property for
 hotplug runtime
Date: Mon, 25 Jul 2016 17:21:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ddf7a170-ff80-ce7d-f469-c176ef3aa0d9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hotplug_init: Simplify the code needed for runtime memory hotplug and
maintenance with a conversion routine that transforms the compressed
property "ibm,dynamic-memory-v2" to the form of "ibm,dynamic-memory"
within the "ibm,dynamic-reconfiguration-memory" property.  Thus only
a single set of routines should be required at runtime to parse, edit,
and manipulate the memory representation in the device tree.  Similarly,
any userspace applications that need this information will only need
to recognize the older format to be able to continue to operate.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2ce1385..f422dcb 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -839,6 +839,95 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	return rc;
 }
 
+static int pseries_rewrite_dynamic_memory_v2(void)
+{
+	unsigned long memblock_size;
+	struct device_node *dn;
+	struct property *prop, *prop_v2;
+	__be32 *p;
+	struct of_drconf_cell *lmbs;
+	u32 num_lmb_desc_sets, num_lmbs;
+	int i;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -EINVAL;
+
+	prop_v2 = of_find_property(dn, "ibm,dynamic-memory-v2", NULL);
+	if (!prop_v2)
+		return -EINVAL;
+
+	memblock_size = pseries_memory_block_size();
+	if (!memblock_size)
+		return -EINVAL;
+
+	/* The first int of the property is the number of lmb sets
+	 * described by the property.
+	 */
+	p = (__be32 *)prop_v2->value;
+	num_lmb_desc_sets = be32_to_cpu(*p++);
+
+	/* Count the number of LMBs for generating the alternate format
+	 */
+	for (i = 0, num_lmbs = 0; i < num_lmb_desc_sets; i++) {
+		struct of_drconf_cell_v2 drmem;
+
+		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
+		num_lmbs += drmem.num_seq_lmbs;
+	}
+
+	/* Create an empty copy of the new 'ibm,dynamic-memory' property
+	 */
+	{
+		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+		if (!prop)
+			return -ENOMEM;
+		prop->name = kstrdup("ibm,dynamic-memory", GFP_KERNEL);
+		prop->length = dyn_mem_v2_len(num_lmbs);
+		prop->value = kzalloc(prop->length, GFP_KERNEL);
+	}
+
+	/* Copy/expand the ibm,dynamic-memory-v2 format to produce the
+	 * ibm,dynamic-memory format.
+	 */
+	p = (__be32 *)prop->value;
+	*p = cpu_to_be32(num_lmbs);
+	p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	p = (__be32 *)prop_v2->value;
+	p++;
+
+	for (i = 0; i < num_lmb_desc_sets; i++) {
+		struct of_drconf_cell_v2 drmem;
+		int j, k = 0;
+
+		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
+
+		for (j = 0; j < drmem.num_seq_lmbs; j++) {
+			lmbs[k+j].base_addr = be64_to_cpu(drmem.base_addr);
+			lmbs[k+j].drc_index = be32_to_cpu(drmem.drc_index);
+			lmbs[k+j].reserved  = 0;
+			lmbs[k+j].aa_index  = be32_to_cpu(drmem.aa_index);
+			lmbs[k+i].flags     = be32_to_cpu(drmem.flags);
+
+			drmem.base_addr += memblock_size;
+			drmem.drc_index++;
+		}
+
+		k += drmem.num_seq_lmbs;
+	}
+
+	of_remove_property(dn, prop_v2);
+
+	of_add_property(dn, prop);
+
+	/* And disable feature flag since the property has gone away */
+	powerpc_firmware_features &= ~FW_FEATURE_RPS_DM2;
+
+	return 0;
+}
+
 static int pseries_memory_notifier(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -866,6 +952,8 @@ static struct notifier_block pseries_mem_nb = {
 
 static int __init pseries_memory_hotplug_init(void)
 {
+	if (firmware_has_feature(FW_FEATURE_RPS_DM2))
+		pseries_rewrite_dynamic_memory_v2();
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		of_reconfig_notifier_register(&pseries_mem_nb);
 
