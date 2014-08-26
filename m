Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A25151A003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 07:48:23 +1000 (EST)
Date: Tue, 26 Aug 2014 16:46:11 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1671876277.447905.1409089571181.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <225331217.447792.1409089347911.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH v3] powerpc: fsl_pci: Add forced PCI Agent enumeration
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, devicetree@vger.kernel.org,
 Minghuan Lian <minghuan.lian@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit prevents the MPC8548E on the XPedite5200 PrPMC
module from enumerating its PCI/PCI-X bus:

    powerpc/fsl-pci: use 'Header Type' to identify PCIE mode

The previous patch prevents any Freescale PCI-X bridge from enumerating
the bus, if it is hardware strapped into Agent mode.

In PCI-X, the Host is responsible for driving the PCI-X initialization
pattern to devices on the bus, so that they know whether to operate in
conventional PCI or PCI-X mode as well as what the bus timing will be.
For a PCI-X PrPMC, the pattern is driven by the mezzanine carrier it is
installed onto. Therefore, PrPMCs are PCI-X Agents, but one per system
may still enumerate the bus.

This patch causes the device node of any PCI/PCI-X bridge strapped into
Agent mode to be checked for the fsl,pci-agent-force-enum property. If
the property is present in the node, the bridge will be allowed to
enumerate the bus.

Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 Documentation/devicetree/bindings/pci/fsl,pci.txt | 27 +++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.c                     |  3 ++-
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,pci.txt b/Documentation/devicetree/bindings/pci/fsl,pci.txt
new file mode 100644
index 0000000..d8ac4a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,pci.txt
@@ -0,0 +1,27 @@
+* Bus Enumeration by Freescale PCI-X Agent
+
+Typically any Freescale PCI-X bridge hardware strapped into Agent mode
+is prevented from enumerating the bus. The PrPMC form-factor requires
+all mezzanines to be PCI-X Agents, but one per system may still
+enumerate the bus.
+
+The property defined below will allow a PCI-X bridge to be used for bus
+enumeration despite being strapped into Agent mode.
+
+Required properties:
+- fsl,pci-agent-force-enum : There is no value associated with this
+  property. The property itself is treated as a boolean.
+
+Example:
+
+	/* PCI-X bridge known to be PrPMC Monarch */
+	pci0: pci@ef008000 {
+		fsl,pci-agent-force-enum;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		...
+		...
+	};
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4bd091a..d13663f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -522,7 +522,8 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	} else {
 		/* For PCI read PROG to identify controller mode */
 		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
-		if ((progif & 1) == 1)
+		if ((progif & 1) &&
+		    !of_property_read_bool(dev, "fsl,pci-agent-force-enum"))
 			goto no_bridge;
 	}
 
-- 
1.9.1
