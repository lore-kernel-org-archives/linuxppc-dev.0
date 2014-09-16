Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4E41A0319
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:45 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Tue, 16 Sep 2014 10:25:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 074562BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8G0R9It29163666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:27:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8G0PfAw019942
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:41 +1000
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/pseries: fix endian bugs in mobility RTAS calls
Date: Tue, 16 Sep 2014 10:25:27 +1000
Message-Id: <1410827128-6876-2-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1410827128-6876-1-git-send-email-cyril.bur@au1.ibm.com>
References: <1410827128-6876-1-git-send-email-cyril.bur@au1.ibm.com>
Cc: Cyril Bur <cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These calls use a buffer shared memory buffer to comunicate device tree
updates.

PAPR specifies that RTAS buffers are to be written in big endian.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 50 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index e7cb6d4..09bef23 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -40,7 +40,7 @@ struct update_props_workarea {
 
 #define MIGRATION_SCOPE	(1)
 
-static int mobility_rtas_call(int token, char *buf, s32 scope)
+static int mobility_rtas_call(int token, __be32 *buf, s32 scope)
 {
 	int rc;
 
@@ -129,14 +129,14 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
 
 static int update_dt_node(u32 phandle, s32 scope)
 {
-	struct update_props_workarea *upwa;
+	struct update_props_workarea upwa;
 	struct device_node *dn;
 	struct property *prop = NULL;
 	int i, rc, rtas_rc;
-	char *prop_data;
-	char *rtas_buf;
 	int update_properties_token;
+	char *prop_data;
 	u32 vd;
+	__be32 *rtas_buf;
 
 	update_properties_token = rtas_token("ibm,update-properties");
 	if (update_properties_token == RTAS_UNKNOWN_SERVICE)
@@ -152,16 +152,17 @@ static int update_dt_node(u32 phandle, s32 scope)
 		return -ENOENT;
 	}
 
-	upwa = (struct update_props_workarea *)&rtas_buf[0];
-	upwa->phandle = phandle;
-
+	*rtas_buf = cpu_to_be32(phandle);
 	do {
 		rtas_rc = mobility_rtas_call(update_properties_token, rtas_buf,
 					scope);
 		if (rtas_rc < 0)
 			break;
-
-		prop_data = rtas_buf + sizeof(*upwa);
+		upwa.phandle = be32_to_cpu(*rtas_buf);
+		upwa.state = be32_to_cpu(*(rtas_buf + 1));
+		upwa.reserved = be64_to_cpu(*((__be64 *)(rtas_buf + 2)));
+		upwa.nprops = be32_to_cpu(*(rtas_buf + 4));
+		prop_data = ((char *)rtas_buf) + sizeof(upwa);
 
 		/* On the first call to ibm,update-properties for a node the
 		 * the first property value descriptor contains an empty
@@ -169,18 +170,18 @@ static int update_dt_node(u32 phandle, s32 scope)
 		 * and the property value is the node path being updated.
 		 */
 		if (*prop_data == 0) {
-			prop_data++;
-			vd = *(u32 *)prop_data;
+			prop_data += sizeof(u32);
+			vd = be32_to_cpu(*(__be32 *)prop_data);
 			prop_data += vd + sizeof(vd);
-			upwa->nprops--;
+			upwa.nprops--;
 		}
 
-		for (i = 0; i < upwa->nprops; i++) {
+		for (i = 0; i < upwa.nprops; i++) {
 			char *prop_name;
 
 			prop_name = prop_data;
 			prop_data += strlen(prop_name) + 1;
-			vd = *(u32 *)prop_data;
+			vd = be32_to_cpu(*(__be32 *)prop_data);
 			prop_data += sizeof(vd);
 
 			switch (vd) {
@@ -236,10 +237,11 @@ static int add_dt_node(u32 parent_phandle, u32 drc_index)
 
 int pseries_devicetree_update(s32 scope)
 {
-	char *rtas_buf;
-	u32 *data;
+	__be32 *rtas_buf;
 	int update_nodes_token;
 	int rc;
+	__be32 *data;
+	u32 node;
 
 	update_nodes_token = rtas_token("ibm,update-nodes");
 	if (update_nodes_token == RTAS_UNKNOWN_SERVICE)
@@ -253,17 +255,16 @@ int pseries_devicetree_update(s32 scope)
 		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
 		if (rc && rc != 1)
 			break;
+		data = rtas_buf + 4;
+		node = be32_to_cpu(*data++);
 
-		data = (u32 *)rtas_buf + 4;
-		while (*data & NODE_ACTION_MASK) {
+		while (node & NODE_ACTION_MASK) {
 			int i;
-			u32 action = *data & NODE_ACTION_MASK;
-			int node_count = *data & NODE_COUNT_MASK;
-
-			data++;
+			u32 action = node & NODE_ACTION_MASK;
+			int node_count = node & NODE_COUNT_MASK;
 
 			for (i = 0; i < node_count; i++) {
-				u32 phandle = *data++;
+				u32 phandle = be32_to_cpu(*data++);
 				u32 drc_index;
 
 				switch (action) {
@@ -274,11 +275,12 @@ int pseries_devicetree_update(s32 scope)
 					update_dt_node(phandle, scope);
 					break;
 				case ADD_DT_NODE:
-					drc_index = *data++;
+					drc_index = be32_to_cpu(*data++);
 					add_dt_node(phandle, drc_index);
 					break;
 				}
 			}
+			node = be32_to_cpu(*data++);
 		}
 	} while (rc == 1);
 
-- 
1.9.1
