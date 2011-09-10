Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A320B7310
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:21:06 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 21/21] powerpc/powernv: Handle PCI-X/PCIe reset delay
Date: Sat, 10 Sep 2011 11:20:08 -0300
Message-Id: <1315664408-16797-21-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The firmware doesn't wait after lifting the PCI reset. However it does
timestamp it in the device tree. We use that to ensure we wait long
enough (3s is our current arbitrary setting) from that timestamp to
actually probing the bus.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f85fb13..1835db5 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -35,6 +35,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+/* Delay in usec */
+#define PCI_RESET_DELAY_US	3000000
 
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
@@ -353,6 +355,35 @@ static void __devinit pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		pnv_pci_dma_fallback_setup(hose, pdev);
 }
 
+static int pnv_pci_probe_mode(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	const __be64 *tstamp;
+	u64 now, target;
+
+
+	/* We hijack this as a way to ensure we have waited long
+	 * enough since the reset was lifted on the PCI bus
+	 */
+	if (bus != hose->bus)
+		return PCI_PROBE_NORMAL;
+	tstamp = of_get_property(hose->dn, "reset-clear-timestamp", NULL);
+	if (!tstamp || !*tstamp)
+		return PCI_PROBE_NORMAL;
+
+	now = mftb() / tb_ticks_per_usec;
+	target = (be64_to_cpup(tstamp) / tb_ticks_per_usec)
+		+ PCI_RESET_DELAY_US;
+
+	pr_devel("pci %04d: Reset target: 0x%llx now: 0x%llx\n",
+		 hose->global_number, target, now);
+
+	if (now < target)
+		msleep((target - now + 999) / 1000);
+
+	return PCI_PROBE_NORMAL;
+}
+
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
@@ -383,6 +414,7 @@ void __init pnv_pci_init(void)
 	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
 	ppc_md.tce_build = pnv_tce_build;
 	ppc_md.tce_free = pnv_tce_free;
+	ppc_md.pci_probe_mode = pnv_pci_probe_mode;
 	set_pci_dma_ops(&dma_iommu_ops);
 
 	/* Configure MSIs */
-- 
1.7.4.1
