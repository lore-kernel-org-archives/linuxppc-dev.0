Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22CF22C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 23:10:44 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 14:10:41 +0100
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E546A38C8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 09:10:35 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5SDAaPE59703296
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 09:10:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5SDAZB9028138
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 10:10:35 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
Date: Fri, 28 Jun 2013 21:10:30 +0800
Message-Id: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Yuanquan.Chen@freescale.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The issue was introduced by commit 37f02195 ("powerpc/pci: fix
PCI-e devices rescan issue on powerpc platform"). The field
(struct pci_dev::irq) is reused by PCI core to trace the base
MSI interrupt number if the MSI stuff is enabled on the corresponding
device. When running to pcibios_setup_device(), we possibly still
have enabled MSI interrupt on the device. That means "pci_dev->irq"
still have the base MSI interrupt number and it will be overwritten
if we're going fix "pci_dev->irq" again by pci_read_irq_line().
Eventually, when we enable the device, it runs to kernel crash caused
by fetching the the MSI interrupt descriptor (struct msi_desc) from
non-MSI interrupt and using the NULL descriptor.

The patch adds more check inside pcibios_setup_device() and don't
fix the interrupt number if we already had MSI interrupt enabled on
the device.

Unable to handle kernel paging request for data at address 0x00000008
Faulting instruction address: 0xc0000000004177ac
cpu 0x6: Vector: 300 (Data Access) at [c000000fa24b7690]
    pc: c0000000004177ac: .pci_restore_msi_state+0x30c/0x3b0
    lr: c00000000041777c: .pci_restore_msi_state+0x2dc/0x3b0
    sp: c000000fa24b7910
   msr: 8000000000009032
   dar: 8
 dsisr: 40000000
  current = 0xc000000fb68542c0
  paca    = 0xc00000000ecd1500	 softe: 0	 irq_happened: 0x00
    pid   = 5367, comm = eehd
enter ? for help
[c000000fa24b79b0] c000000000405d2c .pci_restore_state.part.27+0x11c/0x2a0
[c000000fa24b7a40] c0000000005ea128 .e1000_io_slot_reset+0xa8/0x230
[c000000fa24b7ad0] c00000000005fcd4 .eeh_report_reset+0x94/0x120
[c000000fa24b7b60] c00000000005e97c .eeh_pe_dev_traverse+0x9c/0x190
[c000000fa24b7c10] c000000000060078 .eeh_handle_event+0x218/0x330
[c000000fa24b7ca0] c0000000000602c0 .eeh_event_handler+0x130/0x1a0
[c000000fa24b7d30] c0000000000ad6f8 .kthread+0xe8/0xf0
[c000000fa24b7e30] c00000000000a05c .ret_from_kernel_thread+0x5c/0x80

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index eabeec9..d3a00e8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1009,10 +1009,18 @@ void pcibios_setup_device(struct pci_dev *dev)
 	if (ppc_md.pci_dma_dev_setup)
 		ppc_md.pci_dma_dev_setup(dev);
 
-	/* Read default IRQs and fixup if necessary */
-	pci_read_irq_line(dev);
-	if (ppc_md.pci_irq_fixup)
-		ppc_md.pci_irq_fixup(dev);
+	/*
+	 * Read default IRQs and fixup if necessary. We probably
+	 * has MSI interrupt enabled on the device and that hasn't
+	 * been unloaded yet. For that case, "dev->irq" is tracing
+	 * the base MSI interrupt number and it's going to overrite
+	 * the MSI interrupt number to fix "dev->irq" here.
+	 */
+	if (!dev->msi_enabled) {
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
 }
 
 void pcibios_setup_bus_devices(struct pci_bus *bus)
-- 
1.7.5.4
