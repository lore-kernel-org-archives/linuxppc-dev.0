Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D0401007D3
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 15:59:32 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 7 Nov 2011 04:48:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA74tGeL557238
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:55:16 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA74wDxX020792
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:58:13 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/powernv: Fixup p7ioc PCIe root complex class code
Date: Mon,  7 Nov 2011 15:56:00 +1100
Message-Id: <1320641761-4028-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
References: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It advertises "host bridge" instead of "PCI to PCI bridge" which confuses
the Linux probe code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 8b90d94..baef772 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -416,6 +416,13 @@ static void __devinit pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		pnv_pci_dma_fallback_setup(hose, pdev);
 }
 
+/* Fixup wrong class code in p7ioc root complex */
+static void __devinit pnv_p7ioc_rc_quirk(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
+
 static int pnv_pci_probe_mode(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-- 
1.7.7.1
