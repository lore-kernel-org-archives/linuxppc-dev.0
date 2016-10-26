Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4VF03cW8zDsxW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:50:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REnQev034754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:50:42 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bkgc8yp0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:50:42 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 08:50:40 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8F3913E40048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:37 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9REobKR16646632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:37 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AF11BE04A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:37 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP id 5EB4FBE03E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:37 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 50762C203E1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 10:24:49 -0500 (CDT)
Subject: [PATCH V8 4/8] pseries/hotplug init: Convert new DRC memory
 property for hotplug runtime
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 26 Oct 2016 10:24:49 -0500
In-Reply-To: <147749538075.195514.2242191562019252303.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <147749538075.195514.2242191562019252303.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147749547848.195514.18035617854277917815.stgit@powerkvm6.aus.stglabs.ibm.com>
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

[V2: Revise contant names.]
[V3: Replace use of in-code compile flag encompassing file by Makefile mod.]
[V4: Remove unneeded code braces.
     Simplify allocation of a couple of loop index variables.]
[V5: Resynchronize/resubmit]
[V6: No change]
[V7: Correct mail threading]
[v8: Insert more useful variable names]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Makefile         |    4 -
 arch/powerpc/platforms/pseries/hotplug-memory.c |   93 +++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fedc2ccf0..e74cf6c 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -5,14 +5,14 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   of_helpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
-			   pci.o pci_dlpar.o eeh_pseries.o msi.o
+			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
+			   hotplug-memory.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
-obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 76ec104..461f883 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -24,6 +24,8 @@
 #include <asm/sparsemem.h>
 #include "pseries.h"
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+
 static bool rtas_hp_event;
 
 unsigned long pseries_memory_block_size(void)
@@ -887,11 +889,102 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 static struct notifier_block pseries_mem_nb = {
 	.notifier_call = pseries_memory_notifier,
 };
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
+static int pseries_rewrite_dynamic_memory_v2(void)
+{
+	unsigned long memblock_size;
+	struct device_node *dn;
+	struct property *prop, *prop_v2;
+	__be32 *p;
+	struct of_drconf_cell *lmbs;
+	u32 num_lmb_desc_sets, num_lmbs;
+	int i, j, k;
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
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+	prop->name = kstrdup("ibm,dynamic-memory", GFP_KERNEL);
+	prop->length = dyn_mem_v2_len(num_lmbs);
+	prop->value = kzalloc(prop->length, GFP_KERNEL);
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
+	for (i = 0, k = 0; i < num_lmb_desc_sets; i++) {
+		struct of_drconf_cell_v2 drmem;
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
+	powerpc_firmware_features &= ~FW_FEATURE_DYN_MEM_V2;
+
+	return 0;
+}
 
 static int __init pseries_memory_hotplug_init(void)
 {
+	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2))
+		pseries_rewrite_dynamic_memory_v2();
+#ifdef CONFIG_MEMORY_HOTPLUG
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		of_reconfig_notifier_register(&pseries_mem_nb);
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 	return 0;
 }
