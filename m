Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 7E0B31A031D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 02:19:30 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] of/pci: Add of_pci_check_probe_only to parse "linux,
 pci-probe-only"
Date: Fri, 14 Aug 2015 17:19:16 +0100
Message-Id: <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
to engage the PCI_PROBE_ONLY mode, and both have a subtle bug that
can be triggered if the property has no parameter.

Provide a generic implementation that can be used by both.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/of_pci.c    | 30 ++++++++++++++++++++++++++++++
 include/linux/of_pci.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 5751dc5..a4e29ff 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -118,6 +118,36 @@ int of_get_pci_domain_nr(struct device_node *node)
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
 /**
+ * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
+ *                           is present and valid
+ *
+ * @node: device tree node that may contain the property (usually "chosen")
+ *
+ */
+void of_pci_check_probe_only(struct device_node *node)
+{
+	const int *prop;
+	int len;
+
+	if (!node)
+		return;
+
+	prop = of_get_property(node, "linux,pci-probe-only", &len);
+	if (prop) {
+		if (!len) {
+			pr_warn("linux,pci-probe-only set without value, ignoring\n");
+			return;
+		}
+
+		if (be32_to_cpup(prop))
+			pci_add_flags(PCI_PROBE_ONLY);
+		else
+			pci_clear_flags(PCI_PROBE_ONLY);
+	}
+}
+EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
+
+/**
  * of_pci_dma_configure - Setup DMA configuration
  * @dev: ptr to pci_dev struct of the PCI device
  *
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29fd3fe..4c0a617 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -17,6 +17,7 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 void of_pci_dma_configure(struct pci_dev *pci_dev);
+void of_pci_check_probe_only(struct device_node *node);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -53,6 +54,8 @@ of_get_pci_domain_nr(struct device_node *node)
 }
 
 static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
+
+static inline void of_pci_check_probe_only(struct device_node *node) { }
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-- 
2.1.4
