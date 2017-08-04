Return-Path: <dja@axtens.net>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2yz0334zDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:21:47 +1000 (AEST)
Received: by mail-wr0-x243.google.com with SMTP id c24so2691867wra.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 03:21:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
Date: Fri,  4 Aug 2017 20:20:32 +1000
Message-Id: <20170804102033.27731-3-dja@axtens.net>
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

A system without PCI legacy resources (e.g. ARM64, powerpc) may
find that no default/boot VGA device has been marked, because the
VGA arbiter checks for legacy resource decoding before marking a
card as default.

Split the small bit of code that does default VGA handling out from
the arbiter. Add a Kconfig option to allow the kernel to be built
with just the default handling, or the arbiter and default handling.
(You can try with the arbiter and no default handling - I can't see
why that wouldn't work but it seems a bit odd to try.)

Add handling for devices that should be marked as default but aren't
handled by the vga arbiter by adding a late initcall and a class
enable hook. If there is no default from vgaarb then the first card
that is enabled, has a driver bound, and can decode memory or I/O
will be marked as default.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

I haven't tested this particularly deeply just yet as I wanted to
see if anyone had Strong Feelings before I put too much time into
testing. I have verified that it works on ppc with qemu TCG, both
with and without the following patch.

I know this adds another config option and that's a bit sad, but
we can't include it unconditionally as it depends on PCI.
Suggestions welcome.
---
 arch/ia64/pci/fixup.c            |   2 +-
 arch/powerpc/kernel/pci-common.c |   2 +-
 arch/x86/pci/fixup.c             |   2 +-
 arch/x86/video/fbdev.c           |   2 +-
 drivers/gpu/vga/Kconfig          |  12 +++
 drivers/gpu/vga/Makefile         |   1 +
 drivers/gpu/vga/vga_default.c    | 159 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/vga/vga_switcheroo.c |   2 +-
 drivers/gpu/vga/vgaarb.c         |  41 +---------
 drivers/pci/pci-sysfs.c          |   2 +-
 include/linux/vga_default.h      |  44 +++++++++++
 include/linux/vgaarb.h           |  14 ----
 12 files changed, 225 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/vga/vga_default.c
 create mode 100644 include/linux/vga_default.h

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index 41caa99add51..b35d1cf4501a 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -5,7 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 #include <linux/screen_info.h>
 
 #include <asm/machvec.h>
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c95fdda3a2dc..6cfaec107374 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -31,7 +31,7 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 11e407489db0..b1254bc09a45 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -5,7 +5,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 9fd24846d094..62cfa74ea86e 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -9,7 +9,7 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 
 int fb_is_primary_device(struct fb_info *info)
 {
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 29437eabe095..81d4105aecf6 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -1,3 +1,14 @@
+config VGA_DEFAULT
+	bool "VGA Default Device Support" if EXPERT
+	default y
+	depends on PCI
+	help
+	  Some programs find it helpful to know what VGA device is the default.
+	  On platforms like x86 this means the device used by the BIOS to show
+	  early boot messages. On other platforms this may be an arbitrary PCI
+	  graphics card. Select this to have a default device recorded within
+	  the kernel and exposed to userspace through sysfs.
+
 config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
@@ -22,6 +33,7 @@ config VGA_SWITCHEROO
 	depends on X86
 	depends on ACPI
 	select VGA_ARB
+	select VGA_DEFAULT
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
 	  to switch between them. This adds support for dynamic switching when
diff --git a/drivers/gpu/vga/Makefile b/drivers/gpu/vga/Makefile
index 14ca30b75d0a..1e30f90d40fb 100644
--- a/drivers/gpu/vga/Makefile
+++ b/drivers/gpu/vga/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_VGA_ARB)  += vgaarb.o
+obj-$(CONFIG_VGA_DEFAULT) += vga_default.o
 obj-$(CONFIG_VGA_SWITCHEROO) += vga_switcheroo.o
diff --git a/drivers/gpu/vga/vga_default.c b/drivers/gpu/vga/vga_default.c
new file mode 100644
index 000000000000..f6fcb0eb1507
--- /dev/null
+++ b/drivers/gpu/vga/vga_default.c
@@ -0,0 +1,159 @@
+/*
+ * vga_default.c: What is the default/boot PCI VGA device?
+ *
+ * (C) Copyright 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * (C) Copyright 2007 Paulo R. Zanoni <przanoni@gmail.com>
+ * (C) Copyright 2007, 2009 Tiago Vignatti <vignatti@freedesktop.org>
+ * (C) Copyright 2017 Canonical Ltd. (Author: Daniel Axtens <dja@axtens.net>)
+ *
+ * (License from vgaarb.c)
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+/*
+ * What device should a graphics system draw to? In order of priority:
+ *
+ *  1) Any devices configured specifically by the user (think
+ *     xorg.conf).
+ *
+ *  2) If the platform has a concept of a boot device for early boot
+ *     messages (think BIOS displays on x86), that device.
+ *
+ *  3) If the platform does not have the concept of a boot device,
+ *     then we still want to pick something. For now, pick the first
+ *     PCI VGA device with a driver bound and with memory or I/O
+ *     control on.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <linux/vga_default.h>
+
+static struct pci_dev *vga_default;
+/*
+ * only go active after the late initcall so as not to interfere with
+ * the arbiter
+ */
+static bool vga_default_active = false;
+
+/**
+ * vga_default_device - return the default VGA device
+ *
+ * This can be defined by the platform. The default implementation
+ * is rather dumb and will probably only work properly on single
+ * vga card setups and/or x86 platforms.
+ *
+ * If your VGA default device is not PCI, you'll have to return
+ * NULL here. In this case, I assume it will not conflict with
+ * any PCI card. If this is not true, I'll have to define two archs
+ * hooks for enabling/disabling the VGA default device if that is
+ * possible. This may be a problem with real _ISA_ VGA cards, in
+ * addition to a PCI one. I don't know at this point how to deal
+ * with that card. Can theirs IOs be disabled at all ? If not, then
+ * I suppose it's a matter of having the proper arch hook telling
+ * us about it, so we basically never allow anybody to succeed a
+ * vga_get()...
+ */
+
+struct pci_dev *vga_default_device(void)
+{
+	return vga_default;
+}
+EXPORT_SYMBOL_GPL(vga_default_device);
+
+void vga_set_default_device(struct pci_dev *pdev)
+{
+	if (vga_default == pdev)
+		return;
+
+	pci_dev_put(vga_default);
+	vga_default = pci_dev_get(pdev);
+}
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
+	vga_set_default_device(pdev);
+	return true;
+}
+
+static int __init vga_default_init(void)
+{
+	struct pci_dev *pdev;
+
+	vga_default_active = true;
+
+	if (vga_default_device())
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
+       if (vga_default_device())
+               return;
+
+       vga_default_try_device(pdev);
+}
+DECLARE_PCI_FIXUP_CLASS_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8,
+			       vga_default_enable_hook)
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 3cd153c6d271..6612ec7981b6 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -41,7 +41,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 #include <linux/vga_switcheroo.h>
 
 /**
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 76875f6299b8..74683286f5f8 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -51,6 +51,7 @@
 
 #include <linux/uaccess.h>
 
+#include <linux/vga_default.h>
 #include <linux/vgaarb.h>
 
 static void vga_arbiter_notify_clients(void);
@@ -119,9 +120,6 @@ static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
 	return 1;
 }
 
-/* this is only used a cookie - it should not be dereferenced */
-static struct pci_dev *vga_default;
-
 static void vga_arb_device_card_gone(struct pci_dev *pdev);
 
 /* Find somebody in our list */
@@ -135,39 +133,6 @@ static struct vga_device *vgadev_find(struct pci_dev *pdev)
 	return NULL;
 }
 
-/**
- * vga_default_device - return the default VGA device, for vgacon
- *
- * This can be defined by the platform. The default implementation
- * is rather dumb and will probably only work properly on single
- * vga card setups and/or x86 platforms.
- *
- * If your VGA default device is not PCI, you'll have to return
- * NULL here. In this case, I assume it will not conflict with
- * any PCI card. If this is not true, I'll have to define two archs
- * hooks for enabling/disabling the VGA default device if that is
- * possible. This may be a problem with real _ISA_ VGA cards, in
- * addition to a PCI one. I don't know at this point how to deal
- * with that card. Can theirs IOs be disabled at all ? If not, then
- * I suppose it's a matter of having the proper arch hook telling
- * us about it, so we basically never allow anybody to succeed a
- * vga_get()...
- */
-struct pci_dev *vga_default_device(void)
-{
-	return vga_default;
-}
-EXPORT_SYMBOL_GPL(vga_default_device);
-
-void vga_set_default_device(struct pci_dev *pdev)
-{
-	if (vga_default == pdev)
-		return;
-
-	pci_dev_put(vga_default);
-	vga_default = pci_dev_get(pdev);
-}
-
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
 	if (vgadev->irq_set_state)
@@ -667,7 +632,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default == NULL &&
+	if (vga_default_device() == NULL &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
 		vga_set_default_device(pdev);
@@ -704,7 +669,7 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 		goto bail;
 	}
 
-	if (vga_default == pdev)
+	if (vga_default_device() == pdev)
 		vga_set_default_device(NULL);
 
 	if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b50723..c174b427ea2b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -27,7 +27,7 @@
 #include <linux/security.h>
 #include <linux/pci-aspm.h>
 #include <linux/slab.h>
-#include <linux/vgaarb.h>
+#include <linux/vga_default.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include "pci.h"
diff --git a/include/linux/vga_default.h b/include/linux/vga_default.h
new file mode 100644
index 000000000000..78df6a2a194c
--- /dev/null
+++ b/include/linux/vga_default.h
@@ -0,0 +1,44 @@
+/*
+ * vga_default.h: What is the default/boot PCI VGA device?
+ *
+ * (C) Copyright 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * (C) Copyright 2007 Paulo R. Zanoni <przanoni@gmail.com>
+ * (C) Copyright 2007, 2009 Tiago Vignatti <vignatti@freedesktop.org>
+ * (C) Copyright 2017 Canonical Ltd. (Author: Daniel Axtens <dja@axtens.net>)
+ *
+ * (License from vgaarb.h)
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef LINUX_VGA_DEFAULT_H
+#define LINUX_VGA_DEFAULT_H
+
+struct pci_dev;
+
+#ifdef CONFIG_VGA_DEFAULT
+extern struct pci_dev *vga_default_device(void);
+extern void vga_set_default_device(struct pci_dev *pdev);
+#else
+static inline struct pci_dev *vga_default_device(void) { return NULL; };
+static inline void vga_set_default_device(struct pci_dev *pdev) { };
+#endif
+
+#endif
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index ee162e3e879b..953e1955efbe 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -42,12 +42,6 @@
 #define VGA_RSRC_NORMAL_IO     0x04
 #define VGA_RSRC_NORMAL_MEM    0x08
 
-/* Passing that instead of a pci_dev to use the system "default"
- * device, that is the one used by vgacon. Archs will probably
- * have to provide their own vga_default_device();
- */
-#define VGA_DEFAULT_DEVICE     (NULL)
-
 struct pci_dev;
 
 /* For use by clients */
@@ -122,14 +116,6 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #endif
 
 
-#ifdef CONFIG_VGA_ARB
-extern struct pci_dev *vga_default_device(void);
-extern void vga_set_default_device(struct pci_dev *pdev);
-#else
-static inline struct pci_dev *vga_default_device(void) { return NULL; };
-static inline void vga_set_default_device(struct pci_dev *pdev) { };
-#endif
-
 /*
  * Architectures should define this if they have several
  * independent PCI domains that can afford concurrent VGA
-- 
2.11.0
