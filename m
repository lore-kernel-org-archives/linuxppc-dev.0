Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E8716DDF3D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:41:27 +1100 (EST)
Message-ID: <47846B38.7010409@am.sony.com>
Date: Tue, 08 Jan 2008 22:35:36 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/4 v2] PS3: Add logical performance monitor repository
	routines
References: <477EF59C.2070809@am.sony.com>
In-Reply-To: <477EF59C.2070809@am.sony.com>
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

Add repository routines for the PS3 Logical Performance Monitor (lpm).

Signed-off-by: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: correct Yamamoto-san's mail addr.

 arch/powerpc/platforms/ps3/platform.h   |    7 ++++
 arch/powerpc/platforms/ps3/repository.c |   48 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -189,7 +189,7 @@ int ps3_repository_read_stor_dev_region(
 /* repository pu and memory info */
 
 int ps3_repository_read_num_pu(unsigned int *num_pu);
-int ps3_repository_read_ppe_id(unsigned int *pu_index, unsigned int *ppe_id);
+int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id);
 int ps3_repository_read_rm_base(unsigned int ppe_id, u64 *rm_base);
 int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
 int ps3_repository_read_region_total(u64 *region_total);
@@ -203,6 +203,11 @@ int ps3_repository_read_be_node_id(unsig
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
@@ -902,6 +902,54 @@ int ps3_repository_read_be_tb_freq(unsig
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
+int ps3_repository_read_num_pu(unsigned int *num_pu)
+{
+	int result;
+	u64 v1;
+
+	v1 = 0;
+	result = read_node(PS3_LPAR_ID_CURRENT,
+			   make_first_field("bi", 0),
+			   make_field("pun", 0),
+			   0, 0,
+			   &v1, NULL);
+	*num_pu = v1;
+	return result;
+}
+
+int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id)
+{
+	int result;
+	u64 v1;
+
+	v1 = 0;
+	result = read_node(PS3_LPAR_ID_CURRENT,
+		make_first_field("bi", 0),
+		make_field("pu", pu_index),
+		0, 0,
+		&v1, NULL);
+	*pu_id = v1;
+	return result;
+}
+
 #if defined(DEBUG)
 
 int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
