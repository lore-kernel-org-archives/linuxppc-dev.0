Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYxR2FVVzDrKk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:13:14 +1100 (AEDT)
Subject: [PATCH 2/3] powerpc-opal: Improve 12 size determinations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bhumika Goyal <bhumirks@gmail.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5fb4f314-cd23-c439-ab13-96b8188070e0@users.sourceforge.net>
Message-ID: <a650ec8d-8c53-2d19-22b3-5f7f5b5ced00@users.sourceforge.net>
Date: Tue, 17 Oct 2017 14:12:54 +0200
MIME-Version: 1.0
In-Reply-To: <5fb4f314-cd23-c439-ab13-96b8188070e0@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Oct 2017 13:20:19 +0200

Replace the specification of data types by variable references
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powernv/opal-flash.c         |  4 ++--
 arch/powerpc/platforms/powernv/opal-hmi.c           |  2 +-
 arch/powerpc/platforms/powernv/opal-imc.c           | 10 +++++-----
 arch/powerpc/platforms/powernv/opal-memory-errors.c |  2 +-
 arch/powerpc/platforms/powernv/opal-psr.c           |  2 +-
 arch/powerpc/platforms/powernv/opal-sensor-groups.c |  4 ++--
 arch/powerpc/platforms/powernv/opal-xscom.c         |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 77d564266a59..9c6b54c86d71 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -418,12 +418,12 @@ static int alloc_image_buf(char *buffer, size_t count)
 	void *addr;
 	int size;
 
-	if (count < sizeof(struct image_header_t)) {
+	if (count < sizeof(image_header)) {
 		pr_warn("FLASH: Invalid candidate image\n");
 		return -EINVAL;
 	}
 
-	memcpy(&image_header, (void *)buffer, sizeof(struct image_header_t));
+	memcpy(&image_header, (void *)buffer, sizeof(image_header));
 	image_data.size = be32_to_cpu(image_header.size);
 	pr_debug("FLASH: Candidate image size = %u\n", image_data.size);
 
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index b7dfe41a0a96..92b1e12a7eed 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -313,7 +313,7 @@ static int opal_handle_hmi_event(struct notifier_block *nb,
 	if (!msg_node)
 		return -ENOMEM;
 
-	memcpy(&msg_node->hmi_evt, hmi_evt, sizeof(struct OpalHMIEvent));
+	memcpy(&msg_node->hmi_evt, hmi_evt, sizeof(*hmi_evt));
 
 	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
 	list_add(&msg_node->list, &opal_hmi_evt_list);
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 21f6531fae20..2302cfb953bd 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -38,11 +38,11 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 	if (nr_chips <= 0)
 		return -ENODEV;
 
-	base_addr_arr = kcalloc(nr_chips, sizeof(u64), GFP_KERNEL);
+	base_addr_arr = kcalloc(nr_chips, sizeof(*base_addr_arr), GFP_KERNEL);
 	if (!base_addr_arr)
 		return -ENOMEM;
 
-	chipid_arr = kcalloc(nr_chips, sizeof(u32), GFP_KERNEL);
+	chipid_arr = kcalloc(nr_chips, sizeof(*chipid_arr), GFP_KERNEL);
 	if (!chipid_arr)
 		return -ENOMEM;
 
@@ -53,8 +53,8 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 								nr_chips))
 		goto error;
 
-	pmu_ptr->mem_info = kcalloc(nr_chips, sizeof(struct imc_mem_info),
-								GFP_KERNEL);
+	pmu_ptr->mem_info = kcalloc(nr_chips, sizeof(*pmu_ptr->mem_info),
+				    GFP_KERNEL);
 	if (!pmu_ptr->mem_info)
 		goto error;
 
@@ -88,7 +88,7 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 	u32 offset;
 
 	/* memory for pmu */
-	pmu_ptr = kzalloc(sizeof(struct imc_pmu), GFP_KERNEL);
+	pmu_ptr = kzalloc(sizeof(*pmu_ptr), GFP_KERNEL);
 	if (!pmu_ptr)
 		return -ENOMEM;
 
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index 8d76c05252d1..875e80ab96d9 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -110,7 +110,7 @@ static int opal_memory_err_event(struct notifier_block *nb,
 	if (!msg_node)
 		return -ENOMEM;
 
-	memcpy(&msg_node->msg, msg, sizeof(struct opal_msg));
+	memcpy(&msg_node->msg, msg, sizeof(msg_node->msg));
 
 	spin_lock_irqsave(&opal_mem_err_lock, flags);
 	list_add(&msg_node->list, &opal_memory_err_list);
diff --git a/arch/powerpc/platforms/powernv/opal-psr.c b/arch/powerpc/platforms/powernv/opal-psr.c
index 7313b7fc9071..74986b35cf77 100644
--- a/arch/powerpc/platforms/powernv/opal-psr.c
+++ b/arch/powerpc/platforms/powernv/opal-psr.c
@@ -136,7 +136,7 @@ void __init opal_psr_init(void)
 		return;
 	}
 
-	psr_attrs = kcalloc(of_get_child_count(psr), sizeof(struct psr_attr),
+	psr_attrs = kcalloc(of_get_child_count(psr), sizeof(*psr_attrs),
 			    GFP_KERNEL);
 	if (!psr_attrs)
 		return;
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 7e5a235ebf76..541c9ea04a32 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -166,13 +166,13 @@ void __init opal_sensor_groups_init(void)
 		if (!nr_attrs)
 			continue;
 
-		sgs[i].sgattrs = kcalloc(nr_attrs, sizeof(struct sg_attr),
+		sgs[i].sgattrs = kcalloc(nr_attrs, sizeof(*sgs[i].sgattrs),
 					 GFP_KERNEL);
 		if (!sgs[i].sgattrs)
 			goto out_sgs_sgattrs;
 
 		sgs[i].sg.attrs = kcalloc(nr_attrs + 1,
-					  sizeof(struct attribute *),
+					  sizeof(*sgs[i].sg.attrs),
 					  GFP_KERNEL);
 
 		if (!sgs[i].sg.attrs) {
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 81c0a943dea9..22d5e1110dbb 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -46,7 +46,7 @@ static scom_map_t opal_scom_map(struct device_node *dev, u64 reg, u64 count)
 			__func__, dev);
 		return SCOM_MAP_INVALID;
 	}
-	m = kmalloc(sizeof(struct opal_scom_map), GFP_KERNEL);
+	m = kmalloc(sizeof(*m), GFP_KERNEL);
 	if (!m)
 		return NULL;
 	m->chip = be32_to_cpup(gcid);
-- 
2.14.2
