Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DCEB2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 21:06:07 +1100 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Date: Wed, 13 Mar 2013 11:06:01 +0100
Message-ID: <1510128.fXMLXu3tfm@pcimr>
In-Reply-To: <B392DAB5-F9A7-4B1A-8CAE-015CA5AC2C33@kernel.crashing.org>
References: <3989200.gO920IVs04@pcimr>
 <92335390-A05A-4E1D-9D07-A69896768A57@kernel.crashing.org>
 <B392DAB5-F9A7-4B1A-8CAE-015CA5AC2C33@kernel.crashing.org>
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

On Tuesday 12 March 2013 15:48:01 Kumar Gala wrote:
> > I'd rather we just export indirect_read_config() & indirect_write_config()
> > from indirect_pci.c and call the functions directly.  Adding a global and
> > call them via a function pointer seems wrong to me.
> > 
> > - k
> 
> Also, can you base this patch on my powerpc.git next branch as fsl_pci.{c,h}
> have some changes in them.
> 
> - k
> 

Hi Kumar,

here's the patch with direct calls to indirect_{r,w}_config based on your powerpc.git next branch.

This does not work for PCIe IP rev 3.0 as I'm not sure how to handle "struct resource" aside from making it global or changing "struct pci_controller".

   Rojhalat


Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
---
 arch/powerpc/sysdev/fsl_pci.c      |   51 ++++++++++++++++++++++++++++++++++---
 arch/powerpc/sysdev/indirect_pci.c |   10 ++-----
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3271177..1d7da9d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,6 +36,11 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
+extern int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				int offset, int len, u32 *val);
+extern int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				 int offset, int len, u32 val);
+
 static void quirk_fsl_pcie_header(struct pci_dev *dev)
 {
 	u8 hdr_type;
@@ -86,6 +91,44 @@ static int __init fsl_pcie_check_link(struct pci_controller *hose,
 	return 0;
 }
 
+static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	
+	// check the link status
+	if ((bus->number == hose->first_busno) && (devfn == 0)) {
+		u32 ltssm = 0;
+		indirect_read_config(bus, 0, PCIE_LTSSM, 4, &ltssm);
+		if (ltssm < PCIE_LTSSM_L0) {
+			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		} else {
+			hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		}
+	}
+	return indirect_read_config(bus, devfn, offset, len, val);
+}
+
+static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 val)
+{
+	return indirect_write_config(bus, devfn, offset, len, val);
+}
+
+static struct pci_ops fsl_indirect_pci_ops =
+{
+	.read = fsl_indirect_read_config,
+	.write = fsl_indirect_write_config,
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
@@ -483,8 +526,8 @@ int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-		PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
+			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
 
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		/* For PCIE read HEADER_TYPE to identify controler mode */
@@ -788,8 +831,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
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
