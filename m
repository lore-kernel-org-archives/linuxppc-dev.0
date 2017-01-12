Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzlBh0d3RzDqZP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:17:31 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 28/37] dt-bindings: PCI: dra7xx: Add dt bindings for pci
 dra7xx EP mode
Date: Thu, 12 Jan 2017 15:56:17 +0530
Message-ID: <1484216786-17292-29-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
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

Add device tree binding documentation for pci dra7xx EP mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |   37 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60e2516..62f5f59 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,17 +1,22 @@
 TI PCI Controllers
 
 PCIe Designware Controller
- - compatible: Should be "ti,dra7-pcie""
- - reg : Two register ranges as listed in the reg-names property
- - reg-names : The first entry must be "ti-conf" for the TI specific registers
-	       The second entry must be "rc-dbics" for the designware pcie
-	       registers
-	       The third entry must be "config" for the PCIe configuration space
+ - compatible: Should be "ti,dra7-pcie" for RC
+	       Should be "ti,dra7-pcie-ep" for EP
  - phys : list of PHY specifiers (used by generic PHY framework)
  - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
 	       number of PHYs as specified in *phys* property.
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
+ - num-lanes as specified in ../designware-pcie.txt
+
+HOST MODE
+=========
+ - reg : Two register ranges as listed in the reg-names property
+ - reg-names : The first entry must be "ti-conf" for the TI specific registers
+	       The second entry must be "rc-dbics" for the designware pcie
+	       registers
+	       The third entry must be "config" for the PCIe configuration space
  - interrupts : Two interrupt entries must be specified. The first one is for
 		main interrupt line and the second for MSI interrupt line.
  - #address-cells,
@@ -19,13 +24,31 @@ PCIe Designware Controller
    #interrupt-cells,
    device_type,
    ranges,
-   num-lanes,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
 
+DEVICE MODE
+===========
+ - reg : Four register ranges as listed in the reg-names property
+ - reg-names : "ti-conf" for the TI specific registers
+	       "ep_dbics" for the standard configuration registers as
+		they are locally accessed within the DIF CS space
+	       "ep_dbics2" for the standard configuration registers as
+		they are locally accessed within the DIF CS2 space
+	       "addr_space" used to map remote RC address space
+ - interrupts : one interrupt entries must be specified for main interrupt.
+ - num-ib-windows : number of inbound address translation windows
+ - num-ob-windows : number of outbound address translation windows
+
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
 
+NOTE: Two dt nodes should be added for each PCI controller; one for host
+mode and another for device mode. So in order for PCI to
+work in host mode, EP mode dt node should be disabled and in order to PCI to
+work in EP mode, host mode dt node should be disabled. And host mode and EP
+mode are mutually exclusive.
+
 Example:
 axi {
 	compatible = "simple-bus";
-- 
1.7.9.5
