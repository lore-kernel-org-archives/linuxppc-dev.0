Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtx04nFlzDrLB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:44:52 +1000 (AEST)
Received: by mail-pg0-f67.google.com with SMTP id d193so4332856pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:44:52 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PCI: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:21 -0500
Message-Id: <20170718214339.7774-41-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/pci/host/pci-mvebu.c        | 8 ++++----
 drivers/pci/host/pci-tegra.c        | 3 +--
 drivers/pci/hotplug/pnv_php.c       | 4 ++--
 drivers/pci/hotplug/rpadlpar_core.c | 4 ++--
 drivers/pci/hotplug/rpaphp_core.c   | 2 +-
 drivers/pci/hotplug/rpaphp_pci.c    | 4 ++--
 drivers/pci/hotplug/rpaphp_slot.c   | 4 ++--
 drivers/pci/pci-sysfs.c             | 4 ++--
 drivers/pci/pci.c                   | 4 ++--
 9 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index f353a6eb2f01..424982997eb9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1054,8 +1054,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	port->pcie = pcie;

 	if (of_property_read_u32(child, "marvell,pcie-port", &port->port)) {
-		dev_warn(dev, "ignoring %s, missing pcie-port property\n",
-			 of_node_full_name(child));
+		dev_warn(dev, "ignoring %pOF, missing pcie-port property\n",
+			 child);
 		goto skip;
 	}

@@ -1106,8 +1106,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		}

 		if (flags & OF_GPIO_ACTIVE_LOW) {
-			dev_info(dev, "%s: reset gpio is active low\n",
-				 of_node_full_name(child));
+			dev_info(dev, "%pOF: reset gpio is active low\n",
+				 child);
 			gpio_flags = GPIOF_ACTIVE_LOW |
 				     GPIOF_OUT_INIT_LOW;
 		} else {
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index b3722b7709df..7eb9be5ae357 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1703,8 +1703,7 @@ static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
 		pcie->num_supplies = 2;

 	if (pcie->num_supplies == 0) {
-		dev_err(dev, "device %s not supported in legacy mode\n",
-			np->full_name);
+		dev_err(dev, "device %pOF not supported in legacy mode\n", np);
 		return -ENODEV;
 	}

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 7c203198b582..74f6a17e4614 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -163,8 +163,8 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
 		of_node_put(dn);
 		refcount = kref_read(&dn->kobj.kref);
 		if (refcount != 1)
-			pr_warn("Invalid refcount %d on <%s>\n",
-				refcount, of_node_full_name(dn));
+			pr_warn("Invalid refcount %d on <%pOF>\n",
+				refcount, dn);

 		of_detach_node(dn);
 	}
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 3f93a4e79595..a3449d717a99 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -150,8 +150,8 @@ static void dlpar_pci_add_bus(struct device_node *dn)
 	/* Add EADS device to PHB bus, adding new entry to bus->devices */
 	dev = of_create_pci_dev(dn, phb->bus, pdn->devfn);
 	if (!dev) {
-		printk(KERN_ERR "%s: failed to create pci dev for %s\n",
-				__func__, dn->full_name);
+		printk(KERN_ERR "%s: failed to create pci dev for %pOF\n",
+				__func__, dn);
 		return;
 	}

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 8d132024f06e..1e29abaaea08 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -318,7 +318,7 @@ int rpaphp_add_slot(struct device_node *dn)
 	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
 		return 0;

-	dbg("Entry %s: dn->full_name=%s\n", __func__, dn->full_name);
+	dbg("Entry %s: dn=%pOF\n", __func__, dn);

 	/* register PCI devices */
 	name = (char *) &names[1];
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index ea41ea1d3c00..32aabc533be8 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -95,7 +95,7 @@ int rpaphp_enable_slot(struct slot *slot)

 	bus = pci_find_bus_by_node(slot->dn);
 	if (!bus) {
-		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
+		err("%s: no pci_bus for dn %pOF\n", __func__, slot->dn);
 		return -EINVAL;
 	}

@@ -125,7 +125,7 @@ int rpaphp_enable_slot(struct slot *slot)

 		if (rpaphp_debug) {
 			struct pci_dev *dev;
-			dbg("%s: pci_devs of slot[%s]\n", __func__, slot->dn->full_name);
+			dbg("%s: pci_devs of slot[%pOF]\n", __func__, slot->dn);
 			list_for_each_entry(dev, &bus->devices, bus_list)
 				dbg("\t%s\n", pci_name(dev));
 		}
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 388c4d8fcdd1..489862360f2c 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -122,8 +122,8 @@ int rpaphp_register_slot(struct slot *slot)
 	int retval;
 	int slotno = -1;

-	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
-		__func__, slot->dn->full_name, slot->index, slot->name,
+	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
+		__func__, slot->dn, slot->index, slot->name,
 		slot->power_domain, slot->type);

 	/* should not try to register the same slot twice */
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b50723..33d4df7ed591 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -556,9 +556,9 @@ static ssize_t devspec_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct device_node *np = pci_device_to_OF_node(pdev);

-	if (np == NULL || np->full_name == NULL)
+	if (np == NULL)
 		return 0;
-	return sprintf(buf, "%s", np->full_name);
+	return sprintf(buf, "%pOF", np);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..e8e40dea2842 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5363,8 +5363,8 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
 	} else {
-		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node->full_name);
+		dev_err(parent, "Node %pOF has inconsistent \"linux,pci-domain\" property in DT\n",
+			parent->of_node);
 		domain = -1;
 	}

--
2.11.0
