Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 376A7DE01E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 12:03:46 +1100 (EST)
Message-ID: <47856E60.4060109@am.sony.com>
Date: Wed, 09 Jan 2008 17:01:20 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/4 v3] PS3: Add logical performance monitor repository
	routines
References: <477EF59C.2070809@am.sony.com> <47846B38.7010409@am.sony.com>
In-Reply-To: <47846B38.7010409@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>

Add repository routines for the PS3 logical performance monitor.

Signed-off-by: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: o Correct Yamamoto-san's mail addr.
v3: o Change num_pu and pu_id to type u64.
    o Add comments to describe some symbol names.

 arch/powerpc/platforms/ps3/platform.h   |   12 +++--
 arch/powerpc/platforms/ps3/repository.c |   75 +++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -186,10 +186,10 @@ int ps3_repository_read_stor_dev_region(
 	unsigned int dev_index, unsigned int region_index,
 	unsigned int *region_id, u64 *region_start, u64 *region_size);
 
-/* repository pu and memory info */
+/* repository logical pu and memory info */
 
-int ps3_repository_read_num_pu(unsigned int *num_pu);
-int ps3_repository_read_ppe_id(unsigned int *pu_index, unsigned int *ppe_id);
+int ps3_repository_read_num_pu(u64 *num_pu);
+int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id);
 int ps3_repository_read_rm_base(unsigned int ppe_id, u64 *rm_base);
 int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
 int ps3_repository_read_region_total(u64 *region_total);
@@ -200,9 +200,15 @@ int ps3_repository_read_mm_info(u64 *rm_
 
 int ps3_repository_read_num_be(unsigned int *num_be);
 int ps3_repository_read_be_node_id(unsigned int be_index, u64 *node_id);
+int ps3_repository_read_be_id(u64 node_id, u64 *be_id);
 int ps3_repository_read_tb_freq(u64 node_id, u64 *tb_freq);
 int ps3_repository_read_be_tb_freq(unsigned int be_index, u64 *tb_freq);
 
+/* repository performance monitor info */
+
+int ps3_repository_read_lpm_privileges(unsigned int be_index, u64 *lpar,
+	u64 *rights);
+
 /* repository 'Other OS' area */
 
 int ps3_repository_read_boot_dat_addr(u64 *lpar_addr);
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -684,6 +684,35 @@ int ps3_repository_read_stor_dev_region(
 	return result;
 }
 
+/**
+ * ps3_repository_read_num_pu - Number of logical PU processors for this lpar.
+ */
+
+int ps3_repository_read_num_pu(u64 *num_pu)
+{
+	*num_pu = 0;
+	return read_node(PS3_LPAR_ID_CURRENT,
+			   make_first_field("bi", 0),
+			   make_field("pun", 0),
+			   0, 0,
+			   num_pu, NULL);
+}
+
+/**
+ * ps3_repository_read_pu_id - Read the logical PU id.
+ * @pu_index: Zero based index.
+ * @pu_id: The logical PU id.
+ */
+
+int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id)
+{
+	return read_node(PS3_LPAR_ID_CURRENT,
+		make_first_field("bi", 0),
+		make_field("pu", pu_index),
+		0, 0,
+		pu_id, NULL);
+}
+
 int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size)
 {
 	return read_node(PS3_LPAR_ID_CURRENT,
@@ -856,6 +885,10 @@ int ps3_repository_read_boot_dat_info(u6
 		: ps3_repository_read_boot_dat_size(size);
 }
 
+/**
+ * ps3_repository_read_num_be - Number of physical BE processors in the system.
+ */
+
 int ps3_repository_read_num_be(unsigned int *num_be)
 {
 	int result;
@@ -871,6 +904,12 @@ int ps3_repository_read_num_be(unsigned 
 	return result;
 }
 
+/**
+ * ps3_repository_read_be_node_id - Read the physical BE processor node id.
+ * @be_index: Zero based index.
+ * @node_id: The BE processor node id.
+ */
+
 int ps3_repository_read_be_node_id(unsigned int be_index, u64 *node_id)
 {
 	return read_node(PS3_LPAR_ID_PME,
@@ -881,6 +920,22 @@ int ps3_repository_read_be_node_id(unsig
 		node_id, 0);
 }
 
+/**
+ * ps3_repository_read_be_id - Read the physical BE processor id.
+ * @node_id: The BE processor node id.
+ * @be_id: The BE processor id.
+ */
+
+int ps3_repository_read_be_id(u64 node_id, u64 *be_id)
+{
+	return read_node(PS3_LPAR_ID_PME,
+		make_first_field("be", 0),
+		node_id,
+		0,
+		0,
+		be_id, NULL);
+}
+
 int ps3_repository_read_tb_freq(u64 node_id, u64 *tb_freq)
 {
 	return read_node(PS3_LPAR_ID_PME,
@@ -897,11 +952,29 @@ int ps3_repository_read_be_tb_freq(unsig
 	u64 node_id;
 
 	*tb_freq = 0;
-	result = ps3_repository_read_be_node_id(0, &node_id);
+	result = ps3_repository_read_be_node_id(be_index, &node_id);
 	return result ? result
 		: ps3_repository_read_tb_freq(node_id, tb_freq);
 }
 
+int ps3_repository_read_lpm_privileges(unsigned int be_index, u64 *lpar,
+	u64 *rights)
+{
+	int result;
+	u64 node_id;
+
+	*lpar = 0;
+	*rights = 0;
+	result = ps3_repository_read_be_node_id(be_index, &node_id);
+	return result ? result
+		: read_node(PS3_LPAR_ID_PME,
+			    make_first_field("be", 0),
+			    node_id,
+			    make_field("lpm", 0),
+			    make_field("priv", 0),
+			    lpar, rights);
+}
+
 #if defined(DEBUG)
 
 int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
