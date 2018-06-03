Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zTYX38X8zF143
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 06:04:32 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w53K3p8l103225
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2018 16:04:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jc8tjm7ua-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jun 2018 16:04:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 3 Jun 2018 14:04:28 -0600
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v9 1/4] hotplug/cpu: Conditionally acquire/release DRC index
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <95c97180-37b7-85da-a82f-17dbc73f5ed6@linux.vnet.ibm.com>
Date: Sun, 3 Jun 2018 15:04:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <56181db1-0696-27d9-5060-30bd29c05788@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Testing delayed due to internal SAN problems.]

powerpc/cpu: Modify dlpar_cpu_add and dlpar_cpu_remove to allow the
skipping of DRC index acquire or release operations during the CPU
add or remove operations.  This is intended to support subsequent
changes to provide a 'CPU readd' operation.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in RFC:
  -- Move new validity check added to pseries_smp_notifier
     to another patch
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   68 +++++++++++++++-----------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6ef77ca..3632db2 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -432,7 +432,7 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
-static ssize_t dlpar_cpu_add(u32 drc_index)
+static ssize_t dlpar_cpu_add(u32 drc_index, bool acquire_drc)
 {
 	struct device_node *dn, *parent;
 	int rc, saved_rc;
@@ -457,19 +457,22 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return -EINVAL;
 	}
 
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc) {
-		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
-			rc, drc_index);
-		of_node_put(parent);
-		return -EINVAL;
+	if (acquire_drc) {
+		rc = dlpar_acquire_drc(drc_index);
+		if (rc) {
+			pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
+				rc, drc_index);
+			of_node_put(parent);
+			return -EINVAL;
+		}
 	}
 
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	if (!dn) {
 		pr_warn("Failed call to configure-connector, drc index: %x\n",
 			drc_index);
-		dlpar_release_drc(drc_index);
+		if (acquire_drc)
+			dlpar_release_drc(drc_index);
 		of_node_put(parent);
 		return -EINVAL;
 	}
@@ -484,8 +487,9 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
 			dn->name, rc, drc_index);
 
-		rc = dlpar_release_drc(drc_index);
-		if (!rc)
+		if (acquire_drc)
+			rc = dlpar_release_drc(drc_index);
+		if (!rc || acquire_drc)
 			dlpar_free_cc_nodes(dn);
 
 		return saved_rc;
@@ -498,7 +502,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 			dn->name, rc, drc_index);
 
 		rc = dlpar_detach_node(dn);
-		if (!rc)
+		if (!rc && acquire_drc)
 			dlpar_release_drc(drc_index);
 
 		return saved_rc;
@@ -566,7 +570,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
 
 }
 
-static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
+static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
+				bool release_drc)
 {
 	int rc;
 
@@ -579,12 +584,14 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(drc_index);
-	if (rc) {
-		pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
-			drc_index, dn->name, rc);
-		dlpar_online_cpu(dn);
-		return rc;
+	if (release_drc) {
+		rc = dlpar_release_drc(drc_index);
+		if (rc) {
+			pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
+				drc_index, dn->name, rc);
+			dlpar_online_cpu(dn);
+			return rc;
+		}
 	}
 
 	rc = dlpar_detach_node(dn);
@@ -593,7 +600,10 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 
 		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
 
-		rc = dlpar_acquire_drc(drc_index);
+		if (release_drc)
+			rc = dlpar_acquire_drc(drc_index);
+		else
+			rc = 0;
 		if (!rc)
 			dlpar_online_cpu(dn);
 
@@ -622,7 +632,7 @@ static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
 	return dn;
 }
 
-static int dlpar_cpu_remove_by_index(u32 drc_index)
+static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
 {
 	struct device_node *dn;
 	int rc;
@@ -634,7 +644,7 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
 		return -ENODEV;
 	}
 
-	rc = dlpar_cpu_remove(dn, drc_index);
+	rc = dlpar_cpu_remove(dn, drc_index, release_drc);
 	of_node_put(dn);
 	return rc;
 }
@@ -699,7 +709,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	}
 
 	for (i = 0; i < cpus_to_remove; i++) {
-		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
+		rc = dlpar_cpu_remove_by_index(cpu_drcs[i], true);
 		if (rc)
 			break;
 
@@ -710,7 +720,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
 
 		for (i = 0; i < cpus_removed; i++)
-			dlpar_cpu_add(cpu_drcs[i]);
+			dlpar_cpu_add(cpu_drcs[i], true);
 
 		rc = -EINVAL;
 	} else {
@@ -780,7 +790,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	}
 
 	for (i = 0; i < cpus_to_add; i++) {
-		rc = dlpar_cpu_add(cpu_drcs[i]);
+		rc = dlpar_cpu_add(cpu_drcs[i], true);
 		if (rc)
 			break;
 
@@ -791,7 +801,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 		pr_warn("CPU hot-add failed, removing any added CPUs\n");
 
 		for (i = 0; i < cpus_added; i++)
-			dlpar_cpu_remove_by_index(cpu_drcs[i]);
+			dlpar_cpu_remove_by_index(cpu_drcs[i], true);
 
 		rc = -EINVAL;
 	} else {
@@ -817,7 +827,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
 			rc = dlpar_cpu_remove_by_count(count);
 		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_cpu_remove_by_index(drc_index);
+			rc = dlpar_cpu_remove_by_index(drc_index, true);
 		else
 			rc = -EINVAL;
 		break;
@@ -825,7 +835,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
 			rc = dlpar_cpu_add_by_count(count);
 		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_cpu_add(drc_index);
+			rc = dlpar_cpu_add(drc_index, true);
 		else
 			rc = -EINVAL;
 		break;
@@ -850,7 +860,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (rc)
 		return -EINVAL;
 
-	rc = dlpar_cpu_add(drc_index);
+	rc = dlpar_cpu_add(drc_index, true);
 
 	return rc ? rc : count;
 }
@@ -871,7 +881,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
-	rc = dlpar_cpu_remove(dn, drc_index);
+	rc = dlpar_cpu_remove(dn, drc_index, true);
 	of_node_put(dn);
 
 	return rc ? rc : count;
