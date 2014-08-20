Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 911D91A0068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 09:53:53 +1000 (EST)
Date: Wed, 20 Aug 2014 18:51:44 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <1884375274.96749.1408578481814.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit prevents the MPC8548E on the XPedite5200 PrPMC
module from enumerating its PCI/PCI-X bus, though it was previously
able to:

    powerpc/fsl-pci: use 'Header Type' to identify PCIE mode

The previous patch prevents any Freescale PCI-X bridge from enumerating
the bus, if it is hardware strapped into Agent mode.

In PCI-X, the Host is responsible for driving the PCI-X initialization
pattern to devices on the bus, so that they know whether to operate in
conventional PCI or PCI-X mode as well as what the bus timing will be.
For a PCI-X PrPMC, the pattern is driven by the mezzanine carrier it is
installed onto. Therefore, PrPMCs are PCI-X Agents, but they may still
enumerate the bus.

This patch depends on firmware to determine if the bridge should
perform enumeration based on factors other than the Host/Agent mode,
such as the state of the VITA 32-defined MONARCH# signal. If firmware
has determined that enumeration should be allowed, then it will set the
bridge's Bus Master bit in the Command register.

Without firmware intervention, the Bus Master bit defaults to 1 in Host
mode and 0 in Agent mode.

Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4bd091a..88d8844 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -463,7 +463,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
-	u8 hdr_type, progif;
+	u8 hdr_type;
 	struct device_node *dev;
 	struct ccsr_pci __iomem *pci;
 
@@ -520,9 +520,22 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 			goto no_bridge;
 
 	} else {
-		/* For PCI read PROG to identify controller mode */
-		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
-		if ((progif & 1) == 1)
+		u16 master;
+
+		/*
+		 * If the controller is PCI-X, then Host mode refers to a
+		 * bridge that drives the PCI-X initialization pattern to
+		 * indicate bus operating mode/frequency to devices on the bus.
+		 * Some hardware (specifically PrPMC modules) are Agents, since
+		 * the mezzanine carrier is responsible for driving the
+		 * pattern, but they still may perform bus enumeration.
+		 *
+		 * Allow the bridge to be used for enumeration, if hardware
+		 * strapping (Host mode) or firmware (Agent mode) has enabled
+		 * bus mastering.
+		 */
+		early_read_config_word(hose, 0, 0, PCI_COMMAND, &master);
+		if (!(master & PCI_COMMAND_MASTER))
 			goto no_bridge;
 	}
 
-- 
1.9.1
