Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EC232C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 05:51:44 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 14:51:41 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 35DEF6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:51:37 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PIpdbv247524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:51:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PIpd4b018857
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:51:39 -0400
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PIpcLl018698
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:51:38 -0400
Message-ID: <51509CBA.9010101@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 13:51:38 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/11] Expose pseries devicetree_update()
References: <51509AE8.8070803@linux.vnet.ibm.com>
In-Reply-To: <51509AE8.8070803@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

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

This patch simply exposes pseries_devicetree_update() so it can be
called by rtasd. pseries_devicetree_update() and supporting functions
are also modified to take a 32-bit 'scope' parameter. This parameter is
required by the ibm,update-nodes/ibm,update-properties RTAS calls, and
the appropriate value is contained within the RTAS event for PRRN
notifications. In pseries_devicetree_update() it was previously
hard-coded to 1, the scope value for partition migration.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h           |    1 +
 arch/powerpc/platforms/pseries/mobility.c |   21 ++++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-03-20 08:24:15.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-03-20 08:51:59.000000000 -0500
@@ -276,6 +276,7 @@
 		const char *uname, int depth, void *data);
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
+extern int pseries_devicetree_update(s32 scope);
 
 #ifdef CONFIG_PPC_RTAS_DAEMON
 extern void rtas_cancel_event_scan(void);
Index: powerpc/arch/powerpc/platforms/pseries/mobility.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/mobility.c	2013-03-20 08:24:15.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/mobility.c	2013-03-20 08:51:59.000000000 -0500
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
