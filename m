Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E51ECDDF75
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:29:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l54MTr1r009369
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:29:53 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MTqIF021832
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:29:53 -0500 (CDT)
Subject: [PATCH v2 1/9] Remove the errata fix codes for MPC8641 silicon ver
	1.0 which is end of life.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996192.9632.69.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:29:52 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Remove the errata fix codes for MPC8641 silicon ver 1.0 which
is end of life.

The MPC8641 silicon ver 1.0 is not fully support PCI/PCI Express
specifications. The revision 2.0 fixes all of these errata
and the rev 1.0 silicon is end of life. So errata codes are removed.

Now, The chip is full compatible with PCI/PCI Express
specifications. The generic PCI code is used.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/Kconfig                  |    3 +--
 arch/powerpc/platforms/86xx/mpc86xx.h |    6 ------
 arch/powerpc/platforms/86xx/pci.c     |   10 +---------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 56d3c0d..e683668 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -183,7 +183,6 @@ config PPC_86xx
 	bool "Freescale 86xx"
 	select 6xx
 	select FSL_SOC
-	select FSL_PCIE
 	select PPC_FPU
 	select ALTIVEC
 	help
@@ -675,7 +674,7 @@ config FSL_SOC
 
 config FSL_PCIE
 	bool
-	depends on PPC_86xx
+	depends on PPC_85xx
 
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index 2834462..740b300 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -19,12 +19,6 @@ extern int add_bridge(struct device_node *dev);
 
 extern int mpc86xx_exclude_device(u_char bus, u_char devfn);
 
-extern void setup_indirect_pcie(struct pci_controller *hose,
-				       u32 cfg_addr, u32 cfg_data);
-extern void setup_indirect_pcie_nomap(struct pci_controller *hose,
-					     void __iomem *cfg_addr,
-					     void __iomem *cfg_data);
-
 extern void __init mpc86xx_smp_init(void);
 
 #endif	/* __MPC86XX_H__ */
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 8235c56..7efae7c 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -133,18 +133,10 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
 
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-
-	/* PCIE Bus, Fix the MPC8641D host bridge's location to bus 0xFF. */
-	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &temps);
-	temps = (temps & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
-	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
 }
 
 int mpc86xx_exclude_device(u_char bus, u_char devfn)
 {
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -178,7 +170,7 @@ int __init add_bridge(struct device_node *dev)
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xfe;
 
-	setup_indirect_pcie(hose, rsrc.start, rsrc.start + 0x4);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
 
 	/* Setup the PCIE host controller. */
 	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
-- 
1.5.0.3
