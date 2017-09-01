Return-Path: <dja@axtens.net>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk9p35KzbzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 17:28:27 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id r25so1195694pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 00:28:27 -0700 (PDT)
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
Subject: [PATCH v3 1/3] drm: split default display handler out of VGA arbiter
Date: Fri,  1 Sep 2017 17:27:42 +1000
Message-Id: <20170901072744.2409-2-dja@axtens.net>
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

Split the small bit of code that does default VGA handling out from
the arbiter. Add a Kconfig option to allow the kernel to be built
with just the default handling, or the arbiter and default handling.

While doing this, rename the functions from vga_(set_)default_device
to pci_(set_)default_display. This makes it clear that these functions
do not rely on legacy VGA access: they're about the default PCI display.
(The device still needs to be a member of PCI_CLASS_DISPLAY_VGA.)

This should not introduce any functional change.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

I know this adds another config option and that's a bit sad, but
we can't include it unconditionally as it depends on PCI.
Suggestions welcome.

v3: split from the part where we add functionality
    rename functions
---
 arch/ia64/pci/fixup.c             |  6 +--
 arch/powerpc/kernel/pci-common.c  |  6 +--
 arch/x86/pci/fixup.c              |  6 +--
 arch/x86/video/fbdev.c            |  4 +-
 drivers/gpu/vga/Kconfig           | 12 ++++++
 drivers/gpu/vga/Makefile          |  1 +
 drivers/gpu/vga/default_display.c | 86 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/vga/vga_switcheroo.c  |  8 ++--
 drivers/gpu/vga/vgaarb.c          | 61 ++++++---------------------
 drivers/pci/pci-sysfs.c           |  4 +-
 include/linux/default_display.h   | 44 ++++++++++++++++++++
 include/linux/vgaarb.h            | 15 -------
 12 files changed, 173 insertions(+), 80 deletions(-)
 create mode 100644 drivers/gpu/vga/default_display.c
 create mode 100644 include/linux/default_display.h

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index 41caa99add51..a5f35e767c84 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -5,7 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 #include <linux/screen_info.h>
 
 #include <asm/machvec.h>
@@ -22,7 +22,7 @@
  * card with this copy. On laptops this copy has to be used since
  * the main ROM may be compressed or combined with another image.
  * See pci_map_rom() for use of this flag. Before marking the device
- * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
+ * with IORESOURCE_ROM_SHADOW check if a pci_default_display is already set
  * by either arch code or vga-arbitration; if so only apply the fixup to this
  * already-determined primary video card.
  */
@@ -59,7 +59,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 		bus = bus->parent;
 	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
+	if (!pci_default_display() || pdev == pci_default_display()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			res = &pdev->resource[PCI_ROM_RESOURCE];
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 341a7469cab8..9f82f13ac531 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -31,7 +31,7 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1747,8 +1747,8 @@ static void fixup_vga(struct pci_dev *pdev)
 	u16 cmd;
 
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
-		vga_set_default_device(pdev);
+	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !pci_default_display())
+		pci_set_default_display(pdev);
 
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 11e407489db0..7e32a2a80383 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -5,7 +5,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
@@ -302,7 +302,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_r
  * card with this copy. On laptops this copy has to be used since
  * the main ROM may be compressed or combined with another image.
  * See pci_map_rom() for use of this flag. Before marking the device
- * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
+ * with IORESOURCE_ROM_SHADOW check if a pci_default_display is already set
  * by either arch code or vga-arbitration; if so only apply the fixup to this
  * already-determined primary video card.
  */
@@ -334,7 +334,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 		bus = bus->parent;
 	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
+	if (!pci_default_display() || pdev == pci_default_display()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			res = &pdev->resource[PCI_ROM_RESOURCE];
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 9fd24846d094..114bd9ac95d0 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -9,12 +9,12 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 
 int fb_is_primary_device(struct fb_info *info)
 {
 	struct device *device = info->device;
-	struct pci_dev *default_device = vga_default_device();
+	struct pci_dev *default_device = pci_default_display();
 	struct pci_dev *pci_dev;
 	struct resource *res;
 
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 29437eabe095..8e6edfb6d160 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -1,3 +1,14 @@
+config DEFAULT_DISPLAY
+	bool "Default Display Device Support" if EXPERT
+	default y
+	depends on PCI
+	help
+	  Some programs find it helpful to know what PCI display device is the
+	  default. On platforms like x86 this means the device used by the BIOS
+	  to show early boot messages. On other platforms this may be an arbitrary
+	  PCI graphics card. Select this to have a default device recorded within
+	  the kernel and exposed to userspace through sysfs.
+
 config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
@@ -22,6 +33,7 @@ config VGA_SWITCHEROO
 	depends on X86
 	depends on ACPI
 	select VGA_ARB
+	select DEFAULT_DISPLAY
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
 	  to switch between them. This adds support for dynamic switching when
diff --git a/drivers/gpu/vga/Makefile b/drivers/gpu/vga/Makefile
index 14ca30b75d0a..3abf32c26de5 100644
--- a/drivers/gpu/vga/Makefile
+++ b/drivers/gpu/vga/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_VGA_ARB)  += vgaarb.o
+obj-$(CONFIG_DEFAULT_DISPLAY) += default_display.o
 obj-$(CONFIG_VGA_SWITCHEROO) += vga_switcheroo.o
diff --git a/drivers/gpu/vga/default_display.c b/drivers/gpu/vga/default_display.c
new file mode 100644
index 000000000000..99e4723360da
--- /dev/null
+++ b/drivers/gpu/vga/default_display.c
@@ -0,0 +1,86 @@
+/*
+ * default_display.c: What is the default/boot PCI VGA device?
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
+/**
+ * DOC: overview
+ *
+ * What device should a graphics system draw to?
+ *
+ * It is helpful to have a concept of a default or boot device (for
+ * example, for autoconfiguration where there is no device speficied
+ * by the user). That should be:
+ *
+ *  1) If the platform has a concept of a boot device for early boot
+ *     messages (think BIOS displays on x86), that device.
+ *
+ *  2) Anything specified by an arch hook,
+ *     e.g. arch/powerpc/kernel/pci-common.c::fixup_vga()
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <linux/default_display.h>
+
+static struct pci_dev *vga_default;
+
+/**
+ * pci_default_display - return the default display device
+ *
+ * This represents the default or boot device.
+ *
+ * The default implementation is rather dumb and will probably only
+ * work properly on single vga card setups and/or x86 platforms.
+ */
+struct pci_dev *pci_default_display(void)
+{
+	return vga_default;
+}
+EXPORT_SYMBOL_GPL(pci_default_display);
+
+/**
+ * pci_set_default_display - set the default display device
+ * @pdev: pci device to set as default
+ *
+ * Idempotent - safe to call with the same device repeatedly.
+ *
+ * Drops a reference to the old default, if applicable. Takes a
+ * reference to the new device.
+ */
+void pci_set_default_display(struct pci_dev *pdev)
+{
+	if (vga_default == pdev)
+		return;
+
+	pci_dev_put(vga_default);
+	vga_default = pci_dev_get(pdev);
+}
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 3cd153c6d271..beefefc288f9 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -41,7 +41,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 #include <linux/vga_switcheroo.h>
 
 /**
@@ -320,7 +320,7 @@ int vga_switcheroo_register_client(struct pci_dev *pdev,
 				   bool driver_power_control)
 {
 	return register_client(pdev, ops, VGA_SWITCHEROO_UNKNOWN_ID,
-			       pdev == vga_default_device(),
+			       pdev == pci_default_display(),
 			       driver_power_control);
 }
 EXPORT_SYMBOL(vga_switcheroo_register_client);
@@ -397,7 +397,7 @@ bool vga_switcheroo_client_probe_defer(struct pci_dev *pdev)
 		 * apple-gmux is needed on pre-retina MacBook Pro
 		 * to probe the panel if pdev is the inactive GPU.
 		 */
-		if (apple_gmux_present() && pdev != vga_default_device() &&
+		if (apple_gmux_present() && pdev != pci_default_display() &&
 		    !vgasr_priv.handler_flags)
 			return true;
 	}
@@ -659,7 +659,7 @@ static int vga_switchto_stage1(struct vga_switcheroo_client *new_client)
 	if (new_client->pwr_state == VGA_SWITCHEROO_OFF)
 		vga_switchon(new_client);
 
-	vga_set_default_device(new_client->pdev);
+	pci_set_default_display(new_client->pdev);
 	return 0;
 }
 
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 76875f6299b8..7654bb678587 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -51,6 +51,7 @@
 
 #include <linux/uaccess.h>
 
+#include <linux/default_display.h>
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
@@ -423,7 +388,7 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
 	vga_check_first_use();
 	/* The one who calls us should check for this, but lets be sure... */
 	if (pdev == NULL)
-		pdev = vga_default_device();
+		pdev = pci_default_display();
 	if (pdev == NULL)
 		return 0;
 
@@ -490,7 +455,7 @@ int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 
 	/* The one who calls us should check for this, but lets be sure... */
 	if (pdev == NULL)
-		pdev = vga_default_device();
+		pdev = pci_default_display();
 	if (pdev == NULL)
 		return 0;
 	spin_lock_irqsave(&vga_lock, flags);
@@ -524,7 +489,7 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 
 	/* The one who calls us should check for this, but lets be sure... */
 	if (pdev == NULL)
-		pdev = vga_default_device();
+		pdev = pci_default_display();
 	if (pdev == NULL)
 		return;
 	spin_lock_irqsave(&vga_lock, flags);
@@ -667,10 +632,10 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default == NULL &&
+	if (pci_default_display() == NULL &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
-		vga_set_default_device(pdev);
+		pci_set_default_display(pdev);
 	}
 
 	vga_arbiter_check_bridge_sharing(vgadev);
@@ -704,8 +669,8 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 		goto bail;
 	}
 
-	if (vga_default == pdev)
-		vga_set_default_device(NULL);
+	if (pci_default_display() == pdev)
+		pci_set_default_display(NULL);
 
 	if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
 		vga_decode_count--;
@@ -1182,7 +1147,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		pr_debug("client 0x%p called 'target'\n", priv);
 		/* if target is default */
 		if (!strncmp(curr_pos, "default", 7))
-			pdev = pci_dev_get(vga_default_device());
+			pdev = pci_dev_get(pci_default_display());
 		else {
 			if (!vga_pci_str_to_vars(curr_pos, remaining,
 						 &domain, &bus, &devfn)) {
@@ -1292,7 +1257,7 @@ static int vga_arb_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&vga_user_lock, flags);
 
 	/* Set the client' lists of locks */
-	priv->target = vga_default_device(); /* Maybe this is still null! */
+	priv->target = pci_default_display(); /* Maybe this is still null! */
 	priv->cards[0].pdev = priv->target;
 	priv->cards[0].io_cnt = 0;
 	priv->cards[0].mem_cnt = 0;
@@ -1455,11 +1420,11 @@ static int __init vga_arb_device_init(void)
 			if (screen_info.lfb_base < start || limit >= end)
 				continue;
 
-			if (!vga_default_device())
+			if (!pci_default_display())
 				vgaarb_info(dev, "setting as boot device\n");
-			else if (vgadev->pdev != vga_default_device())
+			else if (vgadev->pdev != pci_default_display())
 				vgaarb_info(dev, "overriding boot device\n");
-			vga_set_default_device(vgadev->pdev);
+			pci_set_default_display(vgadev->pdev);
 		}
 #endif
 		if (vgadev->bridge_has_one_vga)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1eecfa301f7f..31a37178fa8a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -27,7 +27,7 @@
 #include <linux/security.h>
 #include <linux/pci-aspm.h>
 #include <linux/slab.h>
-#include <linux/vgaarb.h>
+#include <linux/default_display.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include "pci.h"
@@ -785,7 +785,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *vga_dev = vga_default_device();
+	struct pci_dev *vga_dev = pci_default_display();
 
 	if (vga_dev)
 		return sprintf(buf, "%u\n", (pdev == vga_dev));
diff --git a/include/linux/default_display.h b/include/linux/default_display.h
new file mode 100644
index 000000000000..5ccebde96b6a
--- /dev/null
+++ b/include/linux/default_display.h
@@ -0,0 +1,44 @@
+/*
+ * default_display.h: What is the default/boot PCI VGA device?
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
+#ifndef LINUX_DEFAULT_DISPLAY_H
+#define LINUX_DEFAULT_DISPLAY_H
+
+struct pci_dev;
+
+#ifdef CONFIG_DEFAULT_DISPLAY
+extern struct pci_dev *pci_default_display(void);
+extern void pci_set_default_display(struct pci_dev *pdev);
+#else
+static inline struct pci_dev *pci_default_display(void) { return NULL; };
+static inline void pci_set_default_display(struct pci_dev *pdev) { };
+#endif
+
+#endif
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index ee162e3e879b..5434ad4af32d 100644
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
@@ -121,15 +115,6 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #define vga_put(pdev, rsrc)
 #endif
 
-
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
