Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 8421CB6F16
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 09:54:38 +1100 (EST)
Date: Tue, 8 Dec 2009 01:54:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl_pci: Fix P2P bridge handling for MPC83xx PCIe
	controllers
Message-ID: <20091207225435.GA18485@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, "B.J. Buchalter" <bj@mhlabs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears that we wrongly calculate dev_base for type1 config cycles.
The thing is: we shouldn't subtract hose->first_busno because PCI core
sets PCI primary, secondary and subordinate bus numbers, and PCIe
controller actually takes the registers into account. So we should use
just bus->number.

Also, according to MPC8315 reference manual, primary bus number should
always remain 0. We have PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS quirk
in indirect_pci.c, but since 83xx is somewhat special, it doesn't use
indirect_pci.c routines, so we have to implement the quirk specifically
for 83xx PCIe controllers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This fixes the issue similar to http://www.pubbs.net/linuxppc/200908/22024/
i.e. lspci reports:

0000:00:00.0 Power PC: Freescale Semiconductor Inc Device 00b4 (rev 11)
0002:02:00.0 PCI bridge: Freescale Semiconductor Inc Device 00b4 (rev 11)
0002:03:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
0002:04:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
0002:04:01.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
0002:04:02.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
...

While it should be:

0000:00:00.0 Power PC: Freescale Semiconductor Inc Device 00b4 (rev 11)
0002:02:00.0 PCI bridge: Freescale Semiconductor Inc Device 00b4 (rev 11)
0002:03:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
0002:04:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

 arch/powerpc/sysdev/fsl_pci.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ae88b14..0c11aa6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -450,8 +450,7 @@ static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct mpc83xx_pcie_priv *pcie = hose->dn->data;
-	u8 bus_no = bus->number - hose->first_busno;
-	u32 dev_base = bus_no << 24 | devfn << 16;
+	u32 dev_base = bus->number << 24 | devfn << 16;
 	int ret;
 
 	ret = mpc83xx_pcie_exclude_device(bus, devfn);
@@ -501,12 +500,17 @@ static int mpc83xx_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 static int mpc83xx_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 				     int offset, int len, u32 val)
 {
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	void __iomem *cfg_addr;
 
 	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
 	if (!cfg_addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	/* PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS */
+	if (offset == PCI_PRIMARY_BUS && bus->number == hose->first_busno)
+		val &= 0xffffff00;
+
 	switch (len) {
 	case 1:
 		out_8(cfg_addr, val);
-- 
1.6.3.3
