Return-Path: <dja@axtens.net>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2yf42mXzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:21:30 +1000 (AEST)
Received: by mail-wr0-x244.google.com with SMTP id g32so2692315wrd.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 03:21:30 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>, Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc: simplify and fix VGA default device behaviour
Date: Fri,  4 Aug 2017 20:20:31 +1000
Message-Id: <20170804102033.27731-2-dja@axtens.net>
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

Some powerpc devices provide a PCI display that isn't picked up by
the VGA arbiter, presumably because it doesn't support the PCI
legacy VGA ranges.

Commit c2e1d84523ad ("powerpc: Set default VGA device") introduced
an arch quirk to mark these devices as default to fix X autoconfig.

The commit message stated that the patch:

    Ensures a default VGA is always set if a graphics adapter is present,
    even if firmware did not initialize it. If more than one graphics
    adapter is present, ensure the one initialized by firmware is set
    as the default VGA device.

The patch used the following test to decide whether or not to mark
a device as default:

  pci_read_config_word(pdev, PCI_COMMAND, &cmd);
  if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
          vga_set_default_device(pdev);

This doesn't seem like it works quite as intended. Because of the
logical OR, the default device will be set in 2 cases:

 1) if there is no default device
OR
 2) if this device has normal memory/IO decoding turned on

This will work as intended if there is only one device, but if
there are multiple devices, we may override the device the VGA
arbiter picked.

Instead, set a device as default if there is no default device AND
this device decodes.

This will not change behaviour on single-headed systems.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested in TCG (the card provided by qemu doesn't automatically
register with vgaarb, so the relevant code path has been tested)
but I would appreciate any tests on real hardware.

Informal benh ack: https://patchwork.kernel.org/patch/9850235/
---
 arch/powerpc/kernel/pci-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 341a7469cab8..c95fdda3a2dc 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1746,8 +1746,11 @@ static void fixup_vga(struct pci_dev *pdev)
 {
 	u16 cmd;
 
+	if (vga_default_device())
+		return;
+
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 		vga_set_default_device(pdev);
 
 }
-- 
2.11.0
