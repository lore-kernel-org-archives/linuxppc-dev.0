Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk9pB3jrjzDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 17:28:34 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id r133so1243028pgr.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 00:28:34 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgaas@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, lukas@wunner.de,
 ard.biesheuvel@linaro.org, lorenzo.pieralisi@arm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 2/3] drm: add fallback default device detection
Date: Fri,  1 Sep 2017 17:27:43 +1000
Message-Id: <20170901072744.2409-3-dja@axtens.net>
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VGA arbiter selects a default VGA device that is enabled and
reachable via the legacy VGA resources (mem 0xa0000-0xbffff, io
0x3b0-0x3bb, io 0x3c0-0x3df, etc).

(As a special case for x86 and IA64, this can be overridden by
EFI.)

If there is no such device, e.g., because there's no enabled VGA
device, the host bridge doesn't support access to those legacy
resources, or a PCI-PCI bridge doesn't have VGA Enable set, a
platform may select an arbitrary device by calling
pci_set_default_display(). powerpc does this, for example.

If there is also no platform hook, there will be no default
device nominated. This is not necessarily what we want.

Add handling for devices that aren't handled by the vga arbiter or
platform by adding a late initcall and a class enable hook. If there
is no default from vgaarb or the platform then the first VGA card
that is enabled, has a driver bound, and can decode memory or I/O
will be marked as default.

This means single-card setups on systems without access to legacy
areas and without arch hooks will work. Multi-card setups on these
systems will nominate an arbitrary device, rather than no devices.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v3:

Split out from re-organisation for simplicity.
Add better description and better documentaion.

Thanks to (in no particular order), Daniel Vetter, Lorenzo Pieralisi,
Ard Biesheuvel and Dave Airlie. Special thanks to Ben Herrenschmidt
and Bjorn Helgass, whose prose I have borrowed.

v1:

Tested on:
 - x86_64 laptop
 - arm64 D05 board with hibmc card
 - qemu powerpc with tcg and bochs std-vga

I know this adds another config option and that's a bit sad, but
we can't include it unconditionally as it depends on PCI.
Suggestions welcome.
---
 drivers/gpu/vga/default_display.c | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/gpu/vga/default_display.c b/drivers/gpu/vga/default_display.c
index 99e4723360da..b8e4a5af38e8 100644
--- a/drivers/gpu/vga/default_display.c
+++ b/drivers/gpu/vga/default_display.c
@@ -42,6 +42,10 @@
  *
  *  2) Anything specified by an arch hook,
  *     e.g. arch/powerpc/kernel/pci-common.c::fixup_vga()
+ *
+ *  3) If neither of those, then we still want to pick something. For
+ *     now, pick the first PCI VGA device with a driver bound and with
+ *     memory or I/O control on.
  */
 
 #include <linux/module.h>
@@ -53,6 +57,12 @@
 
 static struct pci_dev *vga_default;
 
+/*
+ * only go active after the late initcall so as not to interfere with
+ * the arbiter
+ */
+static bool vga_default_active = false;
+
 /**
  * pci_default_display - return the default display device
  *
@@ -84,3 +94,70 @@ void pci_set_default_display(struct pci_dev *pdev)
 	pci_dev_put(vga_default);
 	vga_default = pci_dev_get(pdev);
 }
+
+static bool vga_default_try_device(struct pci_dev *pdev)
+{
+	u16 cmd;
+
+	/* Only deal with VGA class devices */
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return false;
+
+	/* Only deal with devices with drivers bound */
+	if (!pdev->driver)
+		return false;
+
+	/* Require I/O or memory control */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (!(cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)))
+		return false;
+
+	dev_info(&pdev->dev, "vga_default: setting as default device\n");
+	pci_set_default_display(pdev);
+	return true;
+}
+
+static int __init vga_default_init(void)
+{
+	struct pci_dev *pdev;
+
+	vga_default_active = true;
+
+	if (pci_default_display())
+		return 0;
+
+	pdev = NULL;
+	while ((pdev =
+		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_ANY_ID, pdev)) != NULL) {
+		if (vga_default_try_device(pdev))
+			return 0;
+	}
+
+	return 0;
+}
+late_initcall(vga_default_init);
+
+/*
+ * A driver could be loaded much later than late_initcall, for example
+ * if it's in a module.
+ *
+ * We want to pick that up. However, we want to make sure this does
+ * not interfere with the arbiter - it should only activate if the
+ * arbiter has already had a chance to operate. To ensure this, we set
+ * vga_default_active in the late_initcall: as the vga arbiter is a
+ * subsys initcall, it is guaranteed to fire first.
+ */
+static void vga_default_enable_hook(struct pci_dev *pdev)
+{
+       if (!vga_default_active)
+	       return;
+
+       if (pci_default_display())
+               return;
+
+       vga_default_try_device(pdev);
+}
+DECLARE_PCI_FIXUP_CLASS_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8,
+			       vga_default_enable_hook)
-- 
2.11.0
