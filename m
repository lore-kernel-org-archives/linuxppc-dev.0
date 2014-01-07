Return-Path: <Dongsheng.Wang@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FF562C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 19:07:30 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>
Subject: [PATCH 1/2] pci: Fix root port bus->self is NULL
Date: Tue, 7 Jan 2014 16:04:07 +0800
Message-ID: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: roy.zang@freescale.com, galak@codeaurora.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-pci@vger.kernel.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

the root port bus->self always NULL, so put root port pci device
into root port bus->self.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 38e403d..7f2d1ab 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	if (!dev->is_added)
 		nr++;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		bus->self = dev;
+
 	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
-- 
1.8.5
