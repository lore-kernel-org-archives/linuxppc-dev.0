Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsGQ0qc9zDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:53:01 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so1678151oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:53:01 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:07 -0500
Message-Id: <20180828015252.28511-6-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/44x/fsp2.c             |  8 +++---
 arch/powerpc/platforms/cell/spu_manage.c      |  4 +--
 arch/powerpc/platforms/embedded6xx/wii.c      |  2 +-
 .../powerpc/platforms/powernv/opal-powercap.c |  3 +-
 .../platforms/powernv/opal-sensor-groups.c    |  4 +--
 .../powerpc/platforms/powernv/opal-sysparam.c |  2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c  | 28 +++++++++----------
 arch/powerpc/platforms/pseries/ibmebus.c      |  2 +-
 arch/powerpc/platforms/pseries/vio.c          | 27 +++++++++---------
 9 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index 04f0c73a9b4f..7a507f775308 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -210,15 +210,15 @@ static void node_irq_request(const char *compat, irq_handler_t errirq_handler)
 	for_each_compatible_node(np, NULL, compat) {
 		irq = irq_of_parse_and_map(np, 0);
 		if (irq == NO_IRQ) {
-			pr_err("device tree node %s is missing a interrupt",
-			      np->name);
+			pr_err("device tree node %pOFn is missing a interrupt",
+			      np);
 			return;
 		}
 
 		rc = request_irq(irq, errirq_handler, 0, np->name, np);
 		if (rc) {
-			pr_err("fsp_of_probe: request_irq failed: np=%s rc=%d",
-			      np->full_name, rc);
+			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
+			      np, rc);
 			return;
 		}
 	}
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 5c409c98cca8..71ebf7f1bd62 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -295,8 +295,8 @@ static int __init of_enumerate_spus(int (*fn)(void *data))
 	for_each_node_by_type(node, "spe") {
 		ret = fn(node);
 		if (ret) {
-			printk(KERN_WARNING "%s: Error initializing %s\n",
-				__func__, node->name);
+			printk(KERN_WARNING "%s: Error initializing %pOFn\n",
+				__func__, node);
 			of_node_put(node);
 			break;
 		}
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 403523c061ba..ecf703ee3a76 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -112,7 +112,7 @@ static void __iomem *wii_ioremap_hw_regs(char *name, char *compatible)
 	}
 	error = of_address_to_resource(np, 0, &res);
 	if (error) {
-		pr_err("no valid reg found for %s\n", np->name);
+		pr_err("no valid reg found for %pOFn\n", np);
 		goto out_put;
 	}
 
diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
index badb29bde93f..d90ee4fc2c6a 100644
--- a/arch/powerpc/platforms/powernv/opal-powercap.c
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -199,7 +199,7 @@ void __init opal_powercap_init(void)
 		}
 
 		j = 0;
-		pcaps[i].pg.name = node->name;
+		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
 		if (has_min) {
 			powercap_add_attr(min, "powercap-min",
 					  &pcaps[i].pattrs[j]);
@@ -237,6 +237,7 @@ void __init opal_powercap_init(void)
 	while (--i >= 0) {
 		kfree(pcaps[i].pattrs);
 		kfree(pcaps[i].pg.attrs);
+		kfree(pcaps[i].pg.name);
 	}
 	kobject_put(powercap_kobj);
 out_pcaps:
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index f7d04b6a2d7a..179609220e6f 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -214,9 +214,9 @@ void __init opal_sensor_groups_init(void)
 		}
 
 		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
-			sprintf(sgs[i].name, "%s%d", node->name, chipid);
+			sprintf(sgs[i].name, "%pOFn%d", node, chipid);
 		else
-			sprintf(sgs[i].name, "%s", node->name);
+			sprintf(sgs[i].name, "%pOFn", node);
 
 		sgs[i].sg.name = sgs[i].name;
 		if (add_attr_group(ops, len, &sgs[i], sgid)) {
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 9aa87df114fd..916a4b7b1bb5 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -194,7 +194,7 @@ void __init opal_sys_param_init(void)
 	count = of_property_count_strings(sysparam, "param-name");
 	if (count < 0) {
 		pr_err("SYSPARAM: No string found of property param-name in "
-				"the node %s\n", sysparam->name);
+				"the node %pOFn\n", sysparam);
 		goto out_param_buf;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6ef77caf7bcf..2f8e62163602 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -287,7 +287,7 @@ static int pseries_add_processor(struct device_node *np)
 
 	if (cpumask_empty(tmp)) {
 		printk(KERN_ERR "Unable to find space in cpu_present_mask for"
-		       " processor %s with %d thread(s)\n", np->name,
+		       " processor %pOFn with %d thread(s)\n", np,
 		       nthreads);
 		goto out_unlock;
 	}
@@ -481,8 +481,8 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 
 	if (rc) {
 		saved_rc = rc;
-		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
-			dn->name, rc, drc_index);
+		pr_warn("Failed to attach node %pOFn, rc: %d, drc index: %x\n",
+			dn, rc, drc_index);
 
 		rc = dlpar_release_drc(drc_index);
 		if (!rc)
@@ -494,8 +494,8 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 	rc = dlpar_online_cpu(dn);
 	if (rc) {
 		saved_rc = rc;
-		pr_warn("Failed to online cpu %s, rc: %d, drc index: %x\n",
-			dn->name, rc, drc_index);
+		pr_warn("Failed to online cpu %pOFn, rc: %d, drc index: %x\n",
+			dn, rc, drc_index);
 
 		rc = dlpar_detach_node(dn);
 		if (!rc)
@@ -504,7 +504,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return saved_rc;
 	}
 
-	pr_debug("Successfully added CPU %s, drc index: %x\n", dn->name,
+	pr_debug("Successfully added CPU %pOFn, drc index: %x\n", dn,
 		 drc_index);
 	return rc;
 }
@@ -570,19 +570,19 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 {
 	int rc;
 
-	pr_debug("Attempting to remove CPU %s, drc index: %x\n",
-		 dn->name, drc_index);
+	pr_debug("Attempting to remove CPU %pOFn, drc index: %x\n",
+		 dn, drc_index);
 
 	rc = dlpar_offline_cpu(dn);
 	if (rc) {
-		pr_warn("Failed to offline CPU %s, rc: %d\n", dn->name, rc);
+		pr_warn("Failed to offline CPU %pOFn, rc: %d\n", dn, rc);
 		return -EINVAL;
 	}
 
 	rc = dlpar_release_drc(drc_index);
 	if (rc) {
-		pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
-			drc_index, dn->name, rc);
+		pr_warn("Failed to release drc (%x) for CPU %pOFn, rc: %d\n",
+			drc_index, dn, rc);
 		dlpar_online_cpu(dn);
 		return rc;
 	}
@@ -591,7 +591,7 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 	if (rc) {
 		int saved_rc = rc;
 
-		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
+		pr_warn("Failed to detach CPU %pOFn, rc: %d", dn, rc);
 
 		rc = dlpar_acquire_drc(drc_index);
 		if (!rc)
@@ -662,8 +662,8 @@ static int find_dlpar_cpus_to_remove(u32 *cpu_drcs, int cpus_to_remove)
 		rc = of_property_read_u32(dn, "ibm,my-drc-index",
 					  &cpu_drcs[cpus_found - 1]);
 		if (rc) {
-			pr_warn("Error occurred getting drc-index for %s\n",
-				dn->name);
+			pr_warn("Error occurred getting drc-index for %pOFn\n",
+				dn);
 			of_node_put(dn);
 			return -1;
 		}
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index c7c1140c13b6..5b4a56131904 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -404,7 +404,7 @@ static ssize_t name_show(struct device *dev,
 	struct platform_device *ofdev;
 
 	ofdev = to_platform_device(dev);
-	return sprintf(buf, "%s\n", ofdev->dev.of_node->name);
+	return sprintf(buf, "%pOFn\n", ofdev->dev.of_node);
 }
 static DEVICE_ATTR_RO(name);
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 49e04ec19238..88f1ad1d6309 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1349,7 +1349,6 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	struct device_node *parent_node;
 	const __be32 *prop;
 	enum vio_dev_family family;
-	const char *of_node_name = of_node->name ? of_node->name : "<unknown>";
 
 	/*
 	 * Determine if this node is a under the /vdevice node or under the
@@ -1362,24 +1361,24 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		else if (!strcmp(parent_node->type, "vdevice"))
 			family = VDEVICE;
 		else {
-			pr_warn("%s: parent(%pOF) of %s not recognized.\n",
+			pr_warn("%s: parent(%pOF) of %pOFn not recognized.\n",
 					__func__,
 					parent_node,
-					of_node_name);
+					of_node);
 			of_node_put(parent_node);
 			return NULL;
 		}
 		of_node_put(parent_node);
 	} else {
-		pr_warn("%s: could not determine the parent of node %s.\n",
-				__func__, of_node_name);
+		pr_warn("%s: could not determine the parent of node %pOFn.\n",
+				__func__, of_node);
 		return NULL;
 	}
 
 	if (family == PFO) {
 		if (of_get_property(of_node, "interrupt-controller", NULL)) {
-			pr_debug("%s: Skipping the interrupt controller %s.\n",
-					__func__, of_node_name);
+			pr_debug("%s: Skipping the interrupt controller %pOFn.\n",
+					__func__, of_node);
 			return NULL;
 		}
 	}
@@ -1399,15 +1398,15 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		if (of_node->type != NULL)
 			viodev->type = of_node->type;
 		else {
-			pr_warn("%s: node %s is missing the 'device_type' "
-					"property.\n", __func__, of_node_name);
+			pr_warn("%s: node %pOFn is missing the 'device_type' "
+					"property.\n", __func__, of_node);
 			goto out;
 		}
 
 		prop = of_get_property(of_node, "reg", NULL);
 		if (prop == NULL) {
-			pr_warn("%s: node %s missing 'reg'\n",
-					__func__, of_node_name);
+			pr_warn("%s: node %pOFn missing 'reg'\n",
+					__func__, of_node);
 			goto out;
 		}
 		unit_address = of_read_number(prop, 1);
@@ -1422,8 +1421,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		if (prop != NULL)
 			viodev->resource_id = of_read_number(prop, 1);
 
-		dev_set_name(&viodev->dev, "%s", of_node_name);
-		viodev->type = of_node_name;
+		dev_set_name(&viodev->dev, "%pOFn", of_node);
+		viodev->type = dev_name(&viodev->dev);
 		viodev->irq = 0;
 	}
 
@@ -1694,7 +1693,7 @@ struct vio_dev *vio_find_node(struct device_node *vnode)
 		snprintf(kobj_name, sizeof(kobj_name), "%x",
 			 (uint32_t)of_read_number(prop, 1));
 	} else if (!strcmp(dev_type, "ibm,platform-facilities"))
-		snprintf(kobj_name, sizeof(kobj_name), "%s", vnode->name);
+		snprintf(kobj_name, sizeof(kobj_name), "%pOFn", vnode);
 	else
 		return NULL;
 
-- 
2.17.1
