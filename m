Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLFB4w5hzDsLy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:03:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Gs2Pq037917
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:03:07 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ekaxc8njd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:03:07 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:03:06 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H347n39518368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:03:04 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7102AC040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:01 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id AFD91AC03A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:01 -0500 (EST)
Subject: [PATCH V3 7/9] powerpc: Move of_drconf_cell struct to asm/drmem.h
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:47:42 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214685740.64022.7389133848012276351.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the powerpc code parses dynamic reconfiguration memory
LMB information from the LMB array and not the device tree
directly we can move the of_drconf_cell struct to drmem.h where
it fits better.

In addition, the struct is renamed to of_drconf_cell_v1 in
anticipation of upcoming support for version 2 of the dynamic
reconfiguration property and the members are typed as __be*
values to reflect how they exist in the device tree.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h                |   18 ++++++++++++++++++
 arch/powerpc/include/asm/prom.h                 |   16 ----------------
 arch/powerpc/mm/drmem.c                         |    4 ++--
 arch/powerpc/platforms/pseries/hotplug-memory.c |    6 +++---
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 96d7a908146f..afa7dce89a67 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -35,6 +35,24 @@ extern struct drmem_lmb_info *drmem_info;
 		&drmem_info->lmbs[0],				\
 		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
 
+/* The of_drconf_cell_v1 struct defines the layout of the LMB data
+ * specified in the ibm,dynamic-memory device tree property.
+ * The property itself is a 32-bit value specifying the number of
+ * LMBs followed by an array of of_drconf_cell_v1 entries, one
+ * per LMB.
+ */
+struct of_drconf_cell_v1 {
+	__be64	base_addr;
+	__be32	drc_index;
+	__be32	reserved;
+	__be32	aa_index;
+	__be32	flags;
+};
+
+#define DRCONF_MEM_ASSIGNED	0x00000008
+#define DRCONF_MEM_AI_INVALID	0x00000040
+#define DRCONF_MEM_RESERVED	0x00000080
+
 static inline u32 drmem_lmb_size(void)
 {
 	return drmem_info->lmb_size;
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 825bd5998701..f0a30a003bd8 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -80,22 +80,6 @@ extern void of_instantiate_rtc(void);
 
 extern int of_get_ibm_chip_id(struct device_node *np);
 
-/* The of_drconf_cell struct defines the layout of the LMB array
- * specified in the device tree property
- * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
- */
-struct of_drconf_cell {
-	u64	base_addr;
-	u32	drc_index;
-	u32	reserved;
-	u32	aa_index;
-	u32	flags;
-};
-
-#define DRCONF_MEM_ASSIGNED	0x00000008
-#define DRCONF_MEM_AI_INVALID	0x00000040
-#define DRCONF_MEM_RESERVED	0x00000080
-
 /*
  * There are two methods for telling firmware what our capabilities are.
  * Newer machines have an "ibm,client-architecture-support" method on the
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index e9cf79eb1257..5fe3944ebf28 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -65,7 +65,7 @@ static int drmem_update_dt_v1(struct device_node *memory,
 			      struct property *prop)
 {
 	struct property *new_prop;
-	struct of_drconf_cell *dr_cell;
+	struct of_drconf_cell_v1 *dr_cell;
 	struct drmem_lmb *lmb;
 	u32 *p;
 
@@ -76,7 +76,7 @@ static int drmem_update_dt_v1(struct device_node *memory,
 	p = new_prop->value;
 	*p++ = cpu_to_be32(drmem_info->n_lmbs);
 
-	dr_cell = (struct of_drconf_cell *)p;
+	dr_cell = (struct of_drconf_cell_v1 *)p;
 
 	for_each_drmem_lmb(lmb) {
 		dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2043bc2b77b3..c1578f54c626 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -996,7 +996,7 @@ static int pseries_add_mem_node(struct device_node *np)
 
 static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 {
-	struct of_drconf_cell *new_drmem, *old_drmem;
+	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
 	unsigned long memblock_size;
 	u32 entries;
 	__be32 *p;
@@ -1019,11 +1019,11 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	 * of_drconf_cell's.
 	 */
 	entries = be32_to_cpu(*p++);
-	old_drmem = (struct of_drconf_cell *)p;
+	old_drmem = (struct of_drconf_cell_v1 *)p;
 
 	p = (__be32 *)pr->prop->value;
 	p++;
-	new_drmem = (struct of_drconf_cell *)p;
+	new_drmem = (struct of_drconf_cell_v1 *)p;
 
 	for (i = 0; i < entries; i++) {
 		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
