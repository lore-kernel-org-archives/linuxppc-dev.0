Return-Path: <dja@axtens.net>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2zC73GBzDqJp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:21:59 +1000 (AEST)
Received: by mail-wr0-x244.google.com with SMTP id g32so2693192wrd.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 03:21:59 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>, Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
Date: Fri,  4 Aug 2017 20:20:33 +1000
Message-Id: <20170804102033.27731-4-dja@axtens.net>
In-Reply-To: <20170804102033.27731-1-dja@axtens.net>
References: <20170804102033.27731-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we do a PCI fixup to mark a default card so that Xorg
autoconfiguration works.

There is a new generic method to do this sort of vga fixup, and
it occurs by default.

Drop our old method.

This method is different:
 - it will only mark a card as default if a driver is bound
 - the marking will happen at late_initcall time, or even later
   if a card is enabled later on (via an ENABLE hook). Currently
   things are enabled in a FINAL hook.

This *does* change behaviour under some circumstances.

For example, pseries_le_defconfig doesn't have DRM drivers for
many of the qemu GPU models, including the 'standard' vga. So
when a VM with that GPU boots, no driver binds the GPU, and
it does *not* get marked as default. Previously, it would have
been marked as default.

As it turns out Xorg (at least Xorg v1.19.3) can still
autoconfigure it, as Xorg is smart about OpenFirmware
framebuffer devices.

If the right GPU driver is available, and the OpenFirmware fb
driver is removed, the device *is* marked as a boot GPU. (If the
OpenFirmware driver is around, it enables the PCI device but
doesn't bind to it, making it ineligible to be the default card.
Then, when the right driver is loaded, the enable hook doesn't fire
because the card has already been enabled. Fun!) So everything
works as intended, I guess.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This would benefit from some tests on real hardware.
---
 arch/powerpc/kernel/pci-common.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 6cfaec107374..65cd5bad5ad6 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -31,7 +31,6 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-#include <linux/vga_default.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1741,18 +1740,3 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
-
-static void fixup_vga(struct pci_dev *pdev)
-{
-	u16 cmd;
-
-	if (vga_default_device())
-		return;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
-		vga_set_default_device(pdev);
-
-}
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
-- 
2.11.0
