Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31C1E1A0F71
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 06:58:16 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 16:58:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1FE18C90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:49:19 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5MKwC0p49676400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 20:58:12 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5MKwCGv032214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:58:12 -0400
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5MKwCI3032178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:58:12 -0400
Message-ID: <558876E4.9080707@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 15:58:12 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] pseries: Factor out common cpu hotplug code
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

Re-factor the cpu hotplug code to support cpu hotplug completely in
the kernel and using the existing sysfs probe/release interface. Move
pieces of the existing cpu hotplug code that will be common to both
interfaces into common routines. This patch does not introduce any
functional changes.
    
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   83 ++++++++++++++------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index c55cdbc..f58d902 100644
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
@@ -383,26 +381,16 @@ out:
 
 }
 
-static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+static ssize_t dlpar_cpu_add(struct device_node *parent, u32 drc_index)
 {
-	struct device_node *dn, *parent;
-	u32 drc_index;
+	struct device_node *dn;
 	int rc;
 
-	rc = kstrtou32(buf, 0, &drc_index);
-	if (rc)
-		return -EINVAL;
-
 	rc = dlpar_acquire_drc(drc_index);
 	if (rc)
 		return -EINVAL;
 
-	parent = of_find_node_by_path("/cpus");
-	if (!parent)
-		return -ENODEV;
-
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
-	of_node_put(parent);
 	if (!dn)
 		return -EINVAL;
 
@@ -414,10 +402,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	}
 
 	rc = dlpar_online_cpu(dn);
-	if (rc)
-		return rc;
-
-	return count;
+	return rc;
 }
 
 static int dlpar_offline_cpu(struct device_node *dn)
@@ -476,6 +461,47 @@ out:
 
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
+	struct device_node *parent;
+	u32 drc_index;
+	int rc;
+
+	rc = kstrtou32(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return -ENODEV;
+
+	rc = dlpar_cpu_add(parent, drc_index);
+	of_node_put(parent);
+
+	return rc ? rc : count;
+}
+
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
@@ -492,27 +518,10 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
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
