Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BE1F1A0A50
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 17:01:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Dec 2014 16:01:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A200E2BB0078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 17:01:00 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBB60x7236765876
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 17:01:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBB60xTX023924
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 17:00:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Remove pnv_pci_probe_mode()
Date: Thu, 11 Dec 2014 17:00:58 +1100
Message-Id: <1418277658-3541-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The callback (ppc_md.pci_probe_mode()) is used to determine if the
child PCI devices of the indicated PCI bus should be probed from
device-tree or hardware. On PowerNV platform, we always expect
probing PCI devices from hardware, which is PowerPC PCI core's
default behaviour. Also, the callback had some delay implemented
based on PHB's device node property "reset-clear-timestamp", which
wasn't exported from skiboot. So we don't need this function and
it's safe to remove it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4b20f2c..d346df2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -782,35 +782,6 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 
-static int pnv_pci_probe_mode(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	const __be64 *tstamp;
-	u64 now, target;
-
-
-	/* We hijack this as a way to ensure we have waited long
-	 * enough since the reset was lifted on the PCI bus
-	 */
-	if (bus != hose->bus)
-		return PCI_PROBE_NORMAL;
-	tstamp = of_get_property(hose->dn, "reset-clear-timestamp", NULL);
-	if (!tstamp || !*tstamp)
-		return PCI_PROBE_NORMAL;
-
-	now = mftb() / tb_ticks_per_usec;
-	target = (be64_to_cpup(tstamp) / tb_ticks_per_usec)
-		+ PCI_RESET_DELAY_US;
-
-	pr_devel("pci %04d: Reset target: 0x%llx now: 0x%llx\n",
-		 hose->global_number, target, now);
-
-	if (now < target)
-		msleep((target - now + 999) / 1000);
-
-	return PCI_PROBE_NORMAL;
-}
-
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
@@ -857,7 +828,6 @@ void __init pnv_pci_init(void)
 	ppc_md.tce_build_rm = pnv_tce_build_rm;
 	ppc_md.tce_free_rm = pnv_tce_free_rm;
 	ppc_md.tce_get = pnv_tce_get;
-	ppc_md.pci_probe_mode = pnv_pci_probe_mode;
 	set_pci_dma_ops(&dma_iommu_ops);
 
 	/* Configure MSIs */
-- 
1.8.3.2
