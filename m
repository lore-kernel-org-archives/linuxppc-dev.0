Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBzwC455pzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 11:29:31 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id z1so4871031pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 18:29:31 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgass@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/4] vgaarb: allow non-legacy cards to be marked as default
Date: Wed, 19 Jul 2017 11:28:35 +1000
Message-Id: <20170719012839.20124-3-dja@axtens.net>
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

The VGA arbiter currently only selects a card as default if it can
decode legacy I/O and memory ranges.

However, on some architectures, legacy PCI resources are not used.
This has lead to a powerpc quirk, and issues on arm64.

Allow architectures to select ARCH_WANT_VGA_ARB_FALLBACK.
When that symbol is selected, add a PCI_FIXUP_CLASS_ENABLE hook,
which will mark the first card that is enabled and that can control
I/O and memory as the default card.

Behaviour is unchanged unless arches opt-in by selecting the
Kconfig option.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/gpu/vga/Kconfig  |  7 +++++++
 drivers/gpu/vga/vgaarb.c | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 29437eabe095..1205c6cc1ff5 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -17,6 +17,13 @@ config VGA_ARB_MAX_GPUS
 	  Reserves space in the kernel to maintain resource locking for
 	  multiple GPUS.  The overhead for each GPU is very small.
 
+config ARCH_WANT_VGA_ARB_FALLBACK
+	bool
+	help
+	  Some architectures don't have a concept of "legacy" PCI addresses
+	  which the VGA arbiter relies on. Instead, they can fall back to
+	  selecting the first device that decodes memory and I/O.
+
 config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
 	depends on X86
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 76875f6299b8..2135b04759c5 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1472,3 +1472,24 @@ static int __init vga_arb_device_init(void)
 	return rc;
 }
 subsys_initcall(vga_arb_device_init);
+
+#if defined(CONFIG_ARCH_WANT_VGA_ARB_FALLBACK)
+static void vga_arb_fallback_fixup(struct pci_dev *pdev)
+{
+	u16 cmd;
+
+	if (vga_default_device())
+		return;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		vgaarb_info(&pdev->dev, "[fallback]"
+			    " setting as default device\n");
+		vga_set_default_device(pdev);
+	}
+
+}
+DECLARE_PCI_FIXUP_CLASS_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8,
+			       vga_arb_fallback_fixup);
+#endif
-- 
2.11.0
