Return-Path: <dja@axtens.net>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBzw54kbKzDrKP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 11:29:25 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id d193so4848924pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 18:29:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgass@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>, Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc: simplify and fix VGA default device behaviour
Date: Wed, 19 Jul 2017 11:28:34 +1000
Message-Id: <20170719012839.20124-2-dja@axtens.net>
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
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
