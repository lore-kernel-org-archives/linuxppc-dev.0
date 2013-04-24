Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FEA92C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 01:48:26 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 11:48:24 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8B124C90025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:48:21 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OFmJ7J216788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:48:20 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OFmHNI006537
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:48:17 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OFlLTl031044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:47:21 -0600
Message-ID: <5177FE7F.6060800@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 10:47:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/13] Expose pseries devicetree_update()
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
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
pseries_devicetree_update() routine used in partition migration.

This patch exposes pseries_devicetree_update() to make it accessible
to other pseries routines, this patch also updates pseries_devicetree_update()
to take a 32-bit scope parameter. The scope value, which was previously hard
coded to 1 for partition migration, is used for the RTAS calls 
ibm,update-nodes/properties to update the device tree.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h           |    4 ++++
 arch/powerpc/platforms/pseries/mobility.c |   21 ++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/mobility.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/mobility.c	2013-04-15 09:18:10.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/mobility.c	2013-04-23 13:22:05.000000000 -0500
@@ -37,14 +37,16 @@
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
@@ -123,7 +125,7 @@
 	return 0;
 }
 
-static int update_dt_node(u32 phandle)
+static int update_dt_node(u32 phandle, s32 scope)
 {
 	struct update_props_workarea *upwa;
 	struct device_node *dn;
@@ -151,7 +153,8 @@
 	upwa->phandle = phandle;
 
 	do {
-		rc = mobility_rtas_call(update_properties_token, rtas_buf);
+		rc = mobility_rtas_call(update_properties_token, rtas_buf,
+					scope);
 		if (rc < 0)
 			break;
 
@@ -219,7 +222,7 @@
 	return rc;
 }
 
-static int pseries_devicetree_update(void)
+int pseries_devicetree_update(s32 scope)
 {
 	char *rtas_buf;
 	u32 *data;
@@ -235,7 +238,7 @@
 		return -ENOMEM;
 
 	do {
-		rc = mobility_rtas_call(update_nodes_token, rtas_buf);
+		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
 		if (rc && rc != 1)
 			break;
 
@@ -256,7 +259,7 @@
 					delete_dt_node(phandle);
 					break;
 				case UPDATE_DT_NODE:
-					update_dt_node(phandle);
+					update_dt_node(phandle, scope);
 					break;
 				case ADD_DT_NODE:
 					drc_index = *data++;
@@ -276,7 +279,7 @@
 	int rc;
 	int activate_fw_token;
 
-	rc = pseries_devicetree_update();
+	rc = pseries_devicetree_update(MIGRATION_SCOPE);
 	if (rc) {
 		printk(KERN_ERR "Initial post-mobility device tree update "
 		       "failed: %d\n", rc);
@@ -292,7 +295,7 @@
 
 	rc = rtas_call(activate_fw_token, 0, 1, NULL);
 	if (!rc) {
-		rc = pseries_devicetree_update();
+		rc = pseries_devicetree_update(MIGRATION_SCOPE);
 		if (rc)
 			printk(KERN_ERR "Secondary post-mobility device tree "
 			       "update failed: %d\n", rc);
Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-04-15 09:18:10.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-04-23 13:22:37.000000000 -0500
@@ -277,6 +277,10 @@
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
+#ifdef CONFIG_PPC_PSERIES
+extern int pseries_devicetree_update(s32 scope);
+#endif
+
 #ifdef CONFIG_PPC_RTAS_DAEMON
 extern void rtas_cancel_event_scan(void);
 #else
