Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAC262C00EC
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 04:33:06 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:33:00 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2AF616E81FB
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:32:00 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIVRpB285060
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:31:27 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIVQ4e003856
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:31:26 -0400
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIVQmh003830
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:31:26 -0400
Message-ID: <517581D4.7020104@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:30:44 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/12] Create a powerpc update_devicetree interface
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer firmware on Power systems can transparently reassign platform resources
(CPU and Memory) in use. For instance, if a processor or memory unit is
predicted to fail, the platform may transparently move the processing to an
equivalent unused processor or the memory state to an equivalent unused
memory unit. However, reassigning resources across NUMA boundaries may alter
the performance of the partition. When such reassignment is necessary, the
Platform Resource Reassignment Notification (PRRN) option provides a
mechanism to inform the Linux kernel of changes to the NUMA affinity of
its platform resources.

When rtasd receives a PRRN event, it needs to make a series of RTAS
calls (ibm,update-nodes and ibm,update-properties) to retrieve the
updated device tree information. These calls are already handled in the
pseries_devtree_update() routine used in partition migration.

This patch exposes a method for updating the device tree via
ppc_md.update_devicetree that takes a single 32-bit value as a parameter.
For pseries platforms this is the existing pseries_devicetree_update routine
which is updated to take the new parameter which is a scope value
to indicate the the reason for making the rtas calls. This parameter is
required by the ibm,update-nodes/ibm,update-properties RTAS calls, and
the appropriate value is contained within the RTAS event for PRRN
notifications. In pseries_devicetree_update() it was previously
hard-coded to 1, the scope value for partition migration.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    2 ++
 arch/powerpc/include/asm/rtas.h           |    1 +
 arch/powerpc/kernel/rtas.c                |   10 ++++++++++
 arch/powerpc/platforms/pseries/mobility.c |   24 +++++++++++++++---------
 4 files changed, 28 insertions(+), 9 deletions(-)

Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-04-15 09:18:10.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-04-17 12:58:33.000000000 -0500
@@ -276,6 +276,7 @@
 		const char *uname, int depth, void *data);
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
+extern int update_devicetree(s32 scope);
 
 #ifdef CONFIG_PPC_RTAS_DAEMON
 extern void rtas_cancel_event_scan(void);
Index: powerpc/arch/powerpc/platforms/pseries/mobility.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/mobility.c	2013-04-15 09:18:10.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/mobility.c	2013-04-17 13:01:08.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include <asm/rtas.h>
+#include <asm/machdep.h>
 #include "pseries.h"
 
 static struct kobject *mobility_kobj;
@@ -37,14 +38,16 @@
 #define UPDATE_DT_NODE	0x02000000
 #define ADD_DT_NODE	0x03000000
 
-static int mobility_rtas_call(int token, char *buf)
+#define MIGRATION_SCOPE	(1)
+
+static int mobility_rtas_call(int token, char *buf, s32 scope)
 {
 	int rc;
 
 	spin_lock(&rtas_data_buf_lock);
 
 	memcpy(rtas_data_buf, buf, RTAS_DATA_BUF_SIZE);
-	rc = rtas_call(token, 2, 1, NULL, rtas_data_buf, 1);
+	rc = rtas_call(token, 2, 1, NULL, rtas_data_buf, scope);
 	memcpy(buf, rtas_data_buf, RTAS_DATA_BUF_SIZE);
 
 	spin_unlock(&rtas_data_buf_lock);
@@ -123,7 +126,7 @@
 	return 0;
 }
 
-static int update_dt_node(u32 phandle)
+static int update_dt_node(u32 phandle, s32 scope)
 {
 	struct update_props_workarea *upwa;
 	struct device_node *dn;
@@ -151,7 +154,8 @@
 	upwa->phandle = phandle;
 
 	do {
-		rc = mobility_rtas_call(update_properties_token, rtas_buf);
+		rc = mobility_rtas_call(update_properties_token, rtas_buf,
+					scope);
 		if (rc < 0)
 			break;
 
@@ -219,7 +223,7 @@
 	return rc;
 }
 
-static int pseries_devicetree_update(void)
+static int pseries_devicetree_update(s32 scope)
 {
 	char *rtas_buf;
 	u32 *data;
@@ -235,7 +239,7 @@
 		return -ENOMEM;
 
 	do {
-		rc = mobility_rtas_call(update_nodes_token, rtas_buf);
+		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
 		if (rc && rc != 1)
 			break;
 
@@ -256,7 +260,7 @@
 					delete_dt_node(phandle);
 					break;
 				case UPDATE_DT_NODE:
-					update_dt_node(phandle);
+					update_dt_node(phandle, scope);
 					break;
 				case ADD_DT_NODE:
 					drc_index = *data++;
@@ -276,7 +280,7 @@
 	int rc;
 	int activate_fw_token;
 
-	rc = pseries_devicetree_update();
+	rc = pseries_devicetree_update(MIGRATION_SCOPE);
 	if (rc) {
 		printk(KERN_ERR "Initial post-mobility device tree update "
 		       "failed: %d\n", rc);
@@ -292,7 +296,7 @@
 
 	rc = rtas_call(activate_fw_token, 0, 1, NULL);
 	if (!rc) {
-		rc = pseries_devicetree_update();
+		rc = pseries_devicetree_update(MIGRATION_SCOPE);
 		if (rc)
 			printk(KERN_ERR "Secondary post-mobility device tree "
 			       "update failed: %d\n", rc);
@@ -346,6 +350,8 @@
 {
 	int rc;
 
+	ppc_md.update_devicetree = pseries_devicetree_update;
+
 	mobility_kobj = kobject_create_and_add("mobility", kernel_kobj);
 	if (!mobility_kobj)
 		return -ENOMEM;
Index: powerpc/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/machdep.h	2013-04-17 13:04:57.000000000 -0500
@@ -256,6 +256,8 @@
 	ssize_t (*cpu_probe)(const char *, size_t);
 	ssize_t (*cpu_release)(const char *, size_t);
 #endif
+
+	int (*update_devicetree)(s32);
 };
 
 extern void e500_idle(void);
Index: powerpc/arch/powerpc/kernel/rtas.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtas.c	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/kernel/rtas.c	2013-04-17 13:02:29.000000000 -0500
@@ -1085,3 +1085,13 @@
 	timebase = 0;
 	arch_spin_unlock(&timebase_lock);
 }
+
+int update_devicetree(s32 scope)
+{
+	int rc = 0;
+
+	if (ppc_md.update_devicetree)
+		rc = ppc_md.update_devicetree(scope);
+
+	return rc;
+}
