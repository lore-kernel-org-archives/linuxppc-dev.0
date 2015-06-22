Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A92591A1015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 06:59:25 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 14:59:23 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2F3CE3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:59:21 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5MKwgkE41746562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 13:58:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5MKxLWu012784
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:59:21 -0600
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5MKxKI2012772
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:59:20 -0600
Message-ID: <55887728.4030709@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 15:59:20 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] pseries: Update CPU hotplug error recovery
References: <558875FF.2040000@linux.vnet.ibm.com>
In-Reply-To: <558875FF.2040000@linux.vnet.ibm.com>
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
a failure occurs during the add/remove operation. This includes adding
some pr_info and pr_debug statements.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   34 +++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f58d902..7890b2f 100644
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
@@ -386,22 +388,35 @@ static ssize_t dlpar_cpu_add(struct device_node *parent, u32 drc_index)
 	struct device_node *dn;
 	int rc;
 
+	pr_info("Attempting to add CPU, drc index %x\n", drc_index);
+
 	rc = dlpar_acquire_drc(drc_index);
 	if (rc)
 		return -EINVAL;
 
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
-	if (!dn)
+	if (!dn) {
+		pr_debug("Failed call to configure-connector\n");
+		dlpar_release_drc(drc_index);
 		return -EINVAL;
+	}
 
 	rc = dlpar_attach_node(dn);
 	if (rc) {
+		pr_debug("Failed to attach node (%d)\n", rc);
 		dlpar_release_drc(drc_index);
 		dlpar_free_cc_nodes(dn);
 		return rc;
 	}
 
 	rc = dlpar_online_cpu(dn);
+	if (rc) {
+		pr_debug("Failed to online cpu (%d)\n", rc);
+		dlpar_detach_node(dn);
+		dlpar_release_drc(drc_index);
+	}
+
+	pr_info("Successfully added CPU, drc index %x\n", drc_index);
 	return rc;
 }
 
@@ -465,18 +480,29 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 {
 	int rc;
 
+	pr_info("Attemping to remove CPU, drc index %x\n", drc_index);
+
 	rc = dlpar_offline_cpu(dn);
-	if (rc)
+	if (rc) {
+		pr_debug("Failed top offline cpu (%d)\n", rc);
 		return -EINVAL;
+	}
 
 	rc = dlpar_release_drc(drc_index);
-	if (rc)
+	if (rc) {
+		pr_debug("Failed to release drc (%d)\n", rc);
+		dlpar_online_cpu(dn);
 		return rc;
+	}
 
 	rc = dlpar_detach_node(dn);
-	if (rc)
+	if (rc) {
+		pr_debug("Failed to detach cpu node (%d)\n", rc);
 		dlpar_acquire_drc(drc_index);
+		dlpar_online_cpu(dn);
+	}
 
+	pr_info("Successfully removed CPU, drc index %x\n", drc_index);
 	return rc;
 }
 
