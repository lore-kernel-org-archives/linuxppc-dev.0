Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22B2F1A1B54
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 07:52:45 +1100 (AEDT)
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 15:52:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBGKqewR26673228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 20:52:40 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBGKqe8Q012839
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:52:40 -0500
Received: from [9.41.105.164] ([9.41.105.164])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBGKqdws012789
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:52:40 -0500
Subject: [PATCH v3 3/6] powerpc/pseries: Update CPU hotplug error recovery
To: linuxppc-dev@lists.ozlabs.org
References: <5671CD8A.8000500@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <5671CF17.4070708@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 14:52:39 -0600
MIME-Version: 1.0
In-Reply-To: <5671CD8A.8000500@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the cpu dlpar add/remove paths to do better error recovery when
a failure occurs during the add/remove operation.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
v2:
 - Corrected some pr_* statements moving pr_info to pr_debug statements
   and pr_debug to pr_warn statements.

 arch/powerpc/platforms/pseries/hotplug-cpu.c |   76 ++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index d6cb184..f080e81 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -18,6 +18,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#define pr_fmt(fmt)     "pseries-hotplug-cpu: " fmt
+
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -410,38 +412,67 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 static ssize_t dlpar_cpu_add(u32 drc_index)
 {
 	struct device_node *dn, *parent;
-	int rc;
+	int rc, saved_rc;
+
+	pr_debug("Attempting to add CPU, drc index: %x\n", drc_index);
 
 	parent = of_find_node_by_path("/cpus");
-	if (!parent)
+	if (!parent) {
+		pr_warn("Failed to find CPU root node \"/cpus\"\n");
 		return -ENODEV;
+	}
 
 	if (dlpar_cpu_exists(parent, drc_index)) {
 		of_node_put(parent);
-		printk(KERN_WARNING "CPU with drc index %x already exists\n",
-		       drc_index);
+		pr_warn("CPU with drc index %x already exists\n", drc_index);
 		return -EINVAL;
 	}
 
 	rc = dlpar_acquire_drc(drc_index);
 	if (rc) {
+		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
+			rc, drc_index);
 		of_node_put(parent);
 		return -EINVAL;
 	}
 
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	of_node_put(parent);
-	if (!dn)
+	if (!dn) {
+		pr_warn("Failed call to configure-connector, drc index: %x\n",
+			drc_index);
+		dlpar_release_drc(drc_index);
 		return -EINVAL;
+	}
 
 	rc = dlpar_attach_node(dn);
 	if (rc) {
-		dlpar_release_drc(drc_index);
-		dlpar_free_cc_nodes(dn);
-		return rc;
+		saved_rc = rc;
+		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
+			dn->name, rc, drc_index);
+
+		rc = dlpar_release_drc(drc_index);
+		if (!rc)
+			dlpar_free_cc_nodes(dn);
+
+		return saved_rc;
 	}
 
 	rc = dlpar_online_cpu(dn);
+	if (rc) {
+		saved_rc = rc;
+		pr_warn("Failed to online cpu %s, rc: %d, drc index: %x\n",
+			dn->name, rc, drc_index);
+
+		rc = dlpar_detach_node(dn);
+		if (!rc)
+			dlpar_release_drc(drc_index);
+
+		return saved_rc;
+	}
+
+	pr_debug("Successfully added CPU %s, drc index: %x\n", dn->name,
+		 drc_index);
 	return rc;
 }
 
@@ -505,19 +536,38 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 {
 	int rc;
 
+	pr_debug("Attemping to remove CPU %s, drc index: %x\n",
+		 dn->name, drc_index);
+
 	rc = dlpar_offline_cpu(dn);
-	if (rc)
+	if (rc) {
+		pr_warn("Failed to offline CPU %s, rc: %d\n", dn->name, rc);
 		return -EINVAL;
+	}
 
 	rc = dlpar_release_drc(drc_index);
-	if (rc)
+	if (rc) {
+		pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
+			drc_index, dn->name, rc);
+		dlpar_online_cpu(dn);
 		return rc;
+	}
 
 	rc = dlpar_detach_node(dn);
-	if (rc)
-		dlpar_acquire_drc(drc_index);
+	if (rc) {
+		int saved_rc = rc;
 
-	return rc;
+		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
+
+		rc = dlpar_acquire_drc(drc_index);
+		if (!rc)
+			dlpar_online_cpu(dn);
+
+		return saved_rc;
+	}
+
+	pr_debug("Successfully removed CPU, drc index: %x\n", drc_index);
+	return 0;
 }
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
