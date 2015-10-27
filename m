Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 011F71A0D5F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:25:00 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 14:24:57 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 787B738C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:24:54 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIOs7O62521590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:24:54 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RIOsi7015381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:24:54 -0400
Received: from [9.41.105.89] ([9.41.105.89])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RIOqYd015213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:24:53 -0400
Subject: [PATCH v2 2/6] powerpc/pseries: Factor out common cpu hotplug code
To: linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562FC174.60905@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:24:52 -0500
MIME-Version: 1.0
In-Reply-To: <562FC0C3.7000303@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-factor the cpu hotplug code to support doing cpu hotplug completely in
the kernel and using the existing sysfs probe/release interfaces. This
patch pulls out pieces of existing cpu hotplug code into common routines,
dlpar_cpu_add() and dlpar_cpu_remove(), to be used by both interfaces.
There are no functional changes introduced.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   70 ++++++++++++++------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 10c2942..d6cb184 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -340,8 +340,6 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
@@ -409,16 +407,11 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
-static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+static ssize_t dlpar_cpu_add(u32 drc_index)
 {
 	struct device_node *dn, *parent;
-	u32 drc_index;
 	int rc;
 
-	rc = kstrtou32(buf, 0, &drc_index);
-	if (rc)
-		return -EINVAL;
-
 	parent = of_find_node_by_path("/cpus");
 	if (!parent)
 		return -ENODEV;
@@ -449,10 +442,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	}
 
 	rc = dlpar_online_cpu(dn);
-	if (rc)
-		return rc;
-
-	return count;
+	return rc;
 }
 
 static int dlpar_offline_cpu(struct device_node *dn)
@@ -511,6 +501,41 @@ out:
 
 }
 
+static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
+{
+	int rc;
+
+	rc = dlpar_offline_cpu(dn);
+	if (rc)
+		return -EINVAL;
+
+	rc = dlpar_release_drc(drc_index);
+	if (rc)
+		return rc;
+
+	rc = dlpar_detach_node(dn);
+	if (rc)
+		dlpar_acquire_drc(drc_index);
+
+	return rc;
+}
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+
+static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+{
+	u32 drc_index;
+	int rc;
+
+	rc = kstrtou32(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	rc = dlpar_cpu_add(drc_index);
+
+	return rc ? rc : count;
+}
+
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
@@ -527,27 +552,10 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
-	rc = dlpar_offline_cpu(dn);
-	if (rc) {
-		of_node_put(dn);
-		return -EINVAL;
-	}
-
-	rc = dlpar_release_drc(drc_index);
-	if (rc) {
-		of_node_put(dn);
-		return rc;
-	}
-
-	rc = dlpar_detach_node(dn);
-	if (rc) {
-		dlpar_acquire_drc(drc_index);
-		return rc;
-	}
-
+	rc = dlpar_cpu_remove(dn, drc_index);
 	of_node_put(dn);
 
-	return count;
+	return rc ? rc : count;
 }
 
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
