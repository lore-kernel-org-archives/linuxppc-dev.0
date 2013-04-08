Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BCF22C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 18:15:50 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] powerpc/fsl-pci Make PCIe hotplug work with
 Freescale
Date: Mon, 08 Apr 2013 10:15:28 +0200
Message-ID: <1636993.nIfPQTmF8g@pcimr>
In-Reply-To: <CE155C19-35DF-4394-9608-BF923B5DA6EB@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <2139831.oouZXZo4xk@pcimr>
 <CE155C19-35DF-4394-9608-BF923B5DA6EB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Up to now the PCIe link status on Freescale PCIe controllers was only
checked once at boot time. So hotplug did not work. With this patch the
link status is checked on every config read. PCIe devices not present at
boot time are found after doing 'echo 1 >/sys/bus/pci/rescan'.

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
---
 arch/powerpc/include/asm/pci-bridge.h |    6 ++++
 arch/powerpc/sysdev/fsl_pci.c         |   51 +++++++++++++++++++++++++++++-----
 arch/powerpc/sysdev/indirect_pci.c    |   10 ++----
 3 files changed, 54 insertions(+), 13 deletions(-)

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
index 83918c3..82e3317 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -54,12 +54,22 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
 	return;
 }
 
-static int __init fsl_pcie_check_link(struct pci_controller *hose)
+static int fsl_indirect_read_config(struct pci_bus *, unsigned int,
+				    int, int, u32 *);
+
+static int fsl_pcie_check_link(struct pci_controller *hose)
 {
-	u32 val;
+	u32 val = 0;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
+		if (hose->ops->read == fsl_indirect_read_config) {
+			struct pci_bus bus;
+			bus.number = 0;
+			bus.sysdata = hose;
+			bus.ops = hose->ops;
+			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
+		} else
+			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
 		if (val < PCIE_LTSSM_L0)
 			return 1;
 	} else {
@@ -74,6 +84,33 @@ static int __init fsl_pcie_check_link(struct pci_controller *hose)
 	return 0;
 }
 
+static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	
+	if (fsl_pcie_check_link(hose))
+		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	else
+		hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	
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
@@ -469,8 +506,8 @@ int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	if (!hose->private_data)
 		goto no_bridge;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-		PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
+			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
 
 	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
 		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
@@ -779,8 +816,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
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

---
1.8.1.5
