Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F96E1A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 06:59:47 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 12:59:45 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B6F0E1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 12:50:52 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t24Jw6Lt29425828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 12:58:06 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t24JxekN014018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 12:59:41 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Patch v2] powerpc/pseries: Little endian fixes for post mobility
 device tree update
Date: Wed,  4 Mar 2015 11:59:33 -0800
Message-Id: <1425499173-19216-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Cyril Bur <cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently use the device tree update code in the kernel after resuming
from a suspend operation to re-sync the kernels view of the device tree with
that of the hypervisor. The code as it stands is not endian safe as it relies
on parsing buffers returned by RTAS calls that thusly contains data in big
endian format.

This patch annotates variables and structure members with __be types as well
as performing necessary byte swaps to cpu endian for data that needs to be
parsed.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: stable@vger.kernel.org
---

Changes in v2:
- Addresed Cyril's comments as follows:
- Added __be32 annotation to phandle parameter of delete_dt_node()
- Byte swapped phandle to cpu endian for of_find_node_by_phandle()

 arch/powerpc/platforms/pseries/mobility.c | 44 ++++++++++++++++---------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 90cf3dc..8f35d52 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -25,10 +25,10 @@
 static struct kobject *mobility_kobj;
 
 struct update_props_workarea {
-	u32 phandle;
-	u32 state;
-	u64 reserved;
-	u32 nprops;
+	__be32 phandle;
+	__be32 state;
+	__be64 reserved;
+	__be32 nprops;
 } __packed;
 
 #define NODE_ACTION_MASK	0xff000000
@@ -54,11 +54,11 @@ static int mobility_rtas_call(int token, char *buf, s32 scope)
 	return rc;
 }
 
-static int delete_dt_node(u32 phandle)
+static int delete_dt_node(__be32 phandle)
 {
 	struct device_node *dn;
 
-	dn = of_find_node_by_phandle(phandle);
+	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
 	if (!dn)
 		return -ENOENT;
 
@@ -127,7 +127,7 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
 	return 0;
 }
 
-static int update_dt_node(u32 phandle, s32 scope)
+static int update_dt_node(__be32 phandle, s32 scope)
 {
 	struct update_props_workarea *upwa;
 	struct device_node *dn;
@@ -136,6 +136,7 @@ static int update_dt_node(u32 phandle, s32 scope)
 	char *prop_data;
 	char *rtas_buf;
 	int update_properties_token;
+	u32 nprops;
 	u32 vd;
 
 	update_properties_token = rtas_token("ibm,update-properties");
@@ -146,7 +147,7 @@ static int update_dt_node(u32 phandle, s32 scope)
 	if (!rtas_buf)
 		return -ENOMEM;
 
-	dn = of_find_node_by_phandle(phandle);
+	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
 	if (!dn) {
 		kfree(rtas_buf);
 		return -ENOENT;
@@ -162,6 +163,7 @@ static int update_dt_node(u32 phandle, s32 scope)
 			break;
 
 		prop_data = rtas_buf + sizeof(*upwa);
+		nprops = be32_to_cpu(upwa->nprops);
 
 		/* On the first call to ibm,update-properties for a node the
 		 * the first property value descriptor contains an empty
@@ -170,17 +172,17 @@ static int update_dt_node(u32 phandle, s32 scope)
 		 */
 		if (*prop_data == 0) {
 			prop_data++;
-			vd = *(u32 *)prop_data;
+			vd = be32_to_cpu(*(__be32 *)prop_data);
 			prop_data += vd + sizeof(vd);
-			upwa->nprops--;
+			nprops--;
 		}
 
-		for (i = 0; i < upwa->nprops; i++) {
+		for (i = 0; i < nprops; i++) {
 			char *prop_name;
 
 			prop_name = prop_data;
 			prop_data += strlen(prop_name) + 1;
-			vd = *(u32 *)prop_data;
+			vd = be32_to_cpu(*(__be32 *)prop_data);
 			prop_data += sizeof(vd);
 
 			switch (vd) {
@@ -212,13 +214,13 @@ static int update_dt_node(u32 phandle, s32 scope)
 	return 0;
 }
 
-static int add_dt_node(u32 parent_phandle, u32 drc_index)
+static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 {
 	struct device_node *dn;
 	struct device_node *parent_dn;
 	int rc;
 
-	parent_dn = of_find_node_by_phandle(parent_phandle);
+	parent_dn = of_find_node_by_phandle(be32_to_cpu(parent_phandle));
 	if (!parent_dn)
 		return -ENOENT;
 
@@ -237,7 +239,7 @@ static int add_dt_node(u32 parent_phandle, u32 drc_index)
 int pseries_devicetree_update(s32 scope)
 {
 	char *rtas_buf;
-	u32 *data;
+	__be32 *data;
 	int update_nodes_token;
 	int rc;
 
@@ -254,17 +256,17 @@ int pseries_devicetree_update(s32 scope)
 		if (rc && rc != 1)
 			break;
 
-		data = (u32 *)rtas_buf + 4;
-		while (*data & NODE_ACTION_MASK) {
+		data = (__be32 *)rtas_buf + 4;
+		while (be32_to_cpu(*data) & NODE_ACTION_MASK) {
 			int i;
-			u32 action = *data & NODE_ACTION_MASK;
-			int node_count = *data & NODE_COUNT_MASK;
+			u32 action = be32_to_cpu(*data) & NODE_ACTION_MASK;
+			u32 node_count = be32_to_cpu(*data) & NODE_COUNT_MASK;
 
 			data++;
 
 			for (i = 0; i < node_count; i++) {
-				u32 phandle = *data++;
-				u32 drc_index;
+				__be32 phandle = *data++;
+				__be32 drc_index;
 
 				switch (action) {
 				case DELETE_DT_NODE:
-- 
1.7.12.2
