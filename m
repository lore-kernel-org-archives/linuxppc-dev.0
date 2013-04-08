Return-Path: <brking@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F5E72C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 23:05:18 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 8 Apr 2013 09:05:13 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5B8A338C801A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 09:05:11 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r38D5B8L330662
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 09:05:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r38D5A7a000703
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 09:05:10 -0400
Message-Id: <201304081305.r38D58DO000500@d01av04.pok.ibm.com>
Subject: [PATCH 2/2] powerpc: Set default VGA device
To: linux-pci@vger.kernel.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 08 Apr 2013 08:05:10 -0500
Cc: klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 lucaskt@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add a PCI quirk for VGA devices on Power to set the default VGA device.
Ensures a default VGA is always set if a graphics adapter is present,
even if firmware did not initialize it. If more than one graphics
adapter is present, ensure the one initialized by firmware is set
as the default VGA device. This ensures that X autoconfiguration
will work.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/pci-common.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff -puN arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device arch/powerpc/kernel/pci-common.c
--- linux/arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device	2013-04-08 06:16:37.000000000 -0500
+++ linux-bjking1/arch/powerpc/kernel/pci-common.c	2013-04-08 06:16:37.000000000 -0500
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/vgaarb.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1725,3 +1726,15 @@ static void fixup_hide_host_resource_fsl
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
+
+static void fixup_vga(struct pci_dev *pdev)
+{
+	u16 cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
+		vga_set_default_device(pdev);
+
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
_
