Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0084.outbound.protection.outlook.com [104.47.0.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZF3m2cwNzF26Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 16:28:35 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
 robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 gregkh@linuxfoundation.org
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for other
 devices too
Date: Mon, 30 Apr 2018 11:57:17 +0530
Message-Id: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c |   5 +--
 drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/irq.c         |   5 +--
 drivers/pci/of.c         | 101 ----------------------------------------------
 include/linux/of.h       |  11 +++++
 include/linux/of_pci.h   |  10 -----
 6 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..811e160 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -149,9 +149,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549..c7aac81 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1995,3 +1995,105 @@ int of_find_last_cache_level(unsigned int cpu)
 
 	return cache_level;
 }
+
+/**
+ * of_map_rid - Translate a requester ID through a downstream mapping.
+ * @np: root complex device node.
+ * @rid: device requester ID to map.
+ * @map_name: property name of the map to use.
+ * @map_mask_name: optional property name of the mask to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a device requester ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
+ * @id_out may be NULL if only the other is required. If @target points to
+ * a non-NULL device node pointer, only entries targeting that node will be
+ * matched; if it points to a NULL value, it will receive the device node of
+ * the first matching target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out)
+{
+	u32 map_mask, masked_rid;
+	int map_len;
+	const __be32 *map = NULL;
+
+	if (!np || !map_name || (!target && !id_out))
+		return -EINVAL;
+
+	map = of_get_property(np, map_name, &map_len);
+	if (!map) {
+		if (target)
+			return -ENODEV;
+		/* Otherwise, no map implies no translation */
+		*id_out = rid;
+		return 0;
+	}
+
+	if (!map_len || map_len % (4 * sizeof(*map))) {
+		pr_err("%pOF: Error: Bad %s length: %d\n", np,
+			map_name, map_len);
+		return -EINVAL;
+	}
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "{iommu,msi}-map-mask" property.
+	 * If of_property_read_u32() fails, the default is used.
+	 */
+	if (map_mask_name)
+		of_property_read_u32(np, map_mask_name, &map_mask);
+
+	masked_rid = map_mask & rid;
+	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+		struct device_node *phandle_node;
+		u32 rid_base = be32_to_cpup(map + 0);
+		u32 phandle = be32_to_cpup(map + 1);
+		u32 out_base = be32_to_cpup(map + 2);
+		u32 rid_len = be32_to_cpup(map + 3);
+
+		if (rid_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+				np, map_name, map_name,
+				map_mask, rid_base);
+			return -EFAULT;
+		}
+
+		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+			continue;
+
+		phandle_node = of_find_node_by_phandle(phandle);
+		if (!phandle_node)
+			return -ENODEV;
+
+		if (target) {
+			if (*target)
+				of_node_put(phandle_node);
+			else
+				*target = phandle_node;
+
+			if (*target != phandle_node)
+				continue;
+		}
+
+		if (id_out)
+			*id_out = masked_rid - rid_base + out_base;
+
+		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
+			np, map_name, map_mask, rid_base, out_base,
+			rid_len, rid, masked_rid - rid_base + out_base);
+		return 0;
+	}
+
+	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
+		np, map_name, rid, target && *target ? *target : NULL);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(of_map_rid);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..e1f6f39 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +587,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
-				    "msi-map-mask", np, &rid_out))
+		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a28355c..d2cebbe 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -362,107 +362,6 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
-/**
- * of_pci_map_rid - Translate a requester ID through a downstream mapping.
- * @np: root complex device node.
- * @rid: PCI requester ID to map.
- * @map_name: property name of the map to use.
- * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
- *
- * Given a PCI requester ID, look up the appropriate implementation-defined
- * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
- *
- * Return: 0 on success or a standard error code on failure.
- */
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out)
-{
-	u32 map_mask, masked_rid;
-	int map_len;
-	const __be32 *map = NULL;
-
-	if (!np || !map_name || (!target && !id_out))
-		return -EINVAL;
-
-	map = of_get_property(np, map_name, &map_len);
-	if (!map) {
-		if (target)
-			return -ENODEV;
-		/* Otherwise, no map implies no translation */
-		*id_out = rid;
-		return 0;
-	}
-
-	if (!map_len || map_len % (4 * sizeof(*map))) {
-		pr_err("%pOF: Error: Bad %s length: %d\n", np,
-			map_name, map_len);
-		return -EINVAL;
-	}
-
-	/* The default is to select all bits. */
-	map_mask = 0xffffffff;
-
-	/*
-	 * Can be overridden by "{iommu,msi}-map-mask" property.
-	 * If of_property_read_u32() fails, the default is used.
-	 */
-	if (map_mask_name)
-		of_property_read_u32(np, map_mask_name, &map_mask);
-
-	masked_rid = map_mask & rid;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
-		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
-		u32 phandle = be32_to_cpup(map + 1);
-		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
-
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
-				np, map_name, map_name,
-				map_mask, rid_base);
-			return -EFAULT;
-		}
-
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
-			continue;
-
-		phandle_node = of_find_node_by_phandle(phandle);
-		if (!phandle_node)
-			return -ENODEV;
-
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
-
-			if (*target != phandle_node)
-				continue;
-		}
-
-		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
-
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
-		return 0;
-	}
-
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
-}
-
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f..f4251c3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -545,6 +545,10 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -931,6 +935,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 091033a..a23b44a 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -17,9 +17,6 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
 void of_pci_check_probe_only(void);
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -44,13 +41,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -1;
 }
 
-static inline int of_pci_map_rid(struct device_node *np, u32 rid,
-			const char *map_name, const char *map_mask_name,
-			struct device_node **target, u32 *id_out)
-{
-	return -EINVAL;
-}
-
 static inline int
 of_pci_get_max_link_speed(struct device_node *node)
 {
-- 
1.9.1
