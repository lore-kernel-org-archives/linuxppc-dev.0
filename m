Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 791602C009D
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2013 06:07:20 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 2/2] powerpc/fsl-pci Make PCIe hotplug work with Freescale
Date: Wed, 13 Mar 2013 14:07:16 -0500
Message-Id: <1363201636-7318-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rojhalat Ibrahim <imr@rtschenk.de>

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci-bridge.h |    6 ++++++
 arch/powerpc/sysdev/fsl_pci.c         |   37 +++++++++++++++++++++++++++++----
 arch/powerpc/sysdev/indirect_pci.c    |   10 ++++-----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index c0278f0..ffbc5fd 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -120,6 +120,12 @@ extern void setup_indirect_pci(struct pci_controller* hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
 
+extern int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				int offset, int len, u32 *val);
+
+extern int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				 int offset, int len, u32 val);
+
 static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 {
 	return bus->sysdata;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 41bbcc4..b18c377 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -74,6 +74,35 @@ static int __init fsl_pcie_check_link(struct pci_controller *hose)
 	return 0;
 }
 
+static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	
+	/* check the link status */
+	if ((bus->number == hose->first_busno) && (devfn == 0)) {
+		if (fsl_pcie_check_link(hose))
+			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		else
+			hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	}
+	return indirect_read_config(bus, devfn, offset, len, val);
+}
+
+static struct pci_ops fsl_indirect_pci_ops =
+{
+	.read = fsl_indirect_read_config,
+	.write = indirect_write_config,
+};
+
+static void __init fsl_setup_indirect_pci(struct pci_controller* hose,
+					  resource_size_t cfg_addr,
+					  resource_size_t cfg_data, u32 flags)
+{
+	setup_indirect_pci(hose, cfg_addr, cfg_data, flags);
+	hose->ops = &fsl_indirect_pci_ops;
+}
+
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 
 #define MAX_PHYS_ADDR_BITS	40
@@ -469,8 +498,8 @@ int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	if (!hose->private_data)
 		goto no_bridge;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-		PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
+			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
 
 	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
 		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
@@ -779,8 +808,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		if (ret)
 			goto err0;
 	} else {
-		setup_indirect_pci(hose, rsrc_cfg.start,
-				   rsrc_cfg.start + 4, 0);
+		fsl_setup_indirect_pci(hose, rsrc_cfg.start,
+				       rsrc_cfg.start + 4, 0);
 	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 82fdad8..c6c8b52 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -20,9 +20,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 
-static int
-indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		     int len, u32 *val)
+int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+			 int offset, int len, u32 *val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	volatile void __iomem *cfg_data;
@@ -78,9 +77,8 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		      int len, u32 val)
+int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+			  int offset, int len, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	volatile void __iomem *cfg_data;
-- 
1.7.9.7
