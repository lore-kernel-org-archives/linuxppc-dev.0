Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6EC7CB7F7F
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 08:59:40 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] video: add support for getting video mode from device tree
Date: Sat, 27 Feb 2010 22:58:20 +0100
Message-Id: <1267307902-31939-2-git-send-email-agust@denx.de>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Framebuffer drivers may want to get panel timing info
from the device tree. This patch adds appropriate support.
Subsequent patch for FSL DIU frame buffer driver makes use
of this functionality.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/Kconfig  |    5 +++
 drivers/video/Makefile |    1 +
 drivers/video/ofmode.c |   95 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/ofmode.h |    6 +++
 4 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/ofmode.c
 create mode 100644 drivers/video/ofmode.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..dc1beb0 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -203,6 +203,11 @@ config FB_MACMODES
        depends on FB
        default n
 
+config FB_OF_MODE
+       tristate
+       depends on FB && OF
+       default n
+
 config FB_BACKLIGHT
 	bool
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 4ecb30c..c4a912b 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_FB_SVGALIB)       += svgalib.o
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
 obj-$(CONFIG_FB_DDC)           += fb_ddc.o
 obj-$(CONFIG_FB_DEFERRED_IO)   += fb_defio.o
+obj-$(CONFIG_FB_OF_MODE)       += ofmode.o
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
diff --git a/drivers/video/ofmode.c b/drivers/video/ofmode.c
new file mode 100644
index 0000000..78caad1
--- /dev/null
+++ b/drivers/video/ofmode.c
@@ -0,0 +1,95 @@
+/*
+ * Get video mode settings from Flattened Device Tree.
+ *
+ * Copyright (C) 2010 DENX Software Engineering.
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License version 2. See the file COPYING in the main directory
+ * of this archive for more details.
+ */
+
+#include <linux/fb.h>
+#include <linux/of.h>
+
+int __devinit of_get_video_mode(struct device_node *np,
+				struct fb_info *info)
+{
+	struct fb_videomode dt_mode;
+	const u32 *prop;
+	unsigned int len;
+
+	if (!np || !info)
+		return -EINVAL;
+
+	prop = of_get_property(np, "width", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.xres = *prop;
+
+	prop = of_get_property(np, "height", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.yres = *prop;
+
+	prop = of_get_property(np, "depth", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	info->var.bits_per_pixel = *prop;
+
+	prop = of_get_property(np, "linebytes", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	info->fix.line_length = *prop;
+
+	prop = of_get_property(np, "refresh", &len);
+	if (prop && len == sizeof(u32))
+		dt_mode.refresh = *prop; /* optional */
+
+	prop = of_get_property(np, "pixclock", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.pixclock = *prop;
+
+	prop = of_get_property(np, "left_margin", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.left_margin = *prop;
+
+	prop = of_get_property(np, "right_margin", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.right_margin = *prop;
+
+	prop = of_get_property(np, "upper_margin", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.upper_margin = *prop;
+
+	prop = of_get_property(np, "lower_margin", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.lower_margin = *prop;
+
+	prop = of_get_property(np, "hsync_len", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.hsync_len = *prop;
+
+	prop = of_get_property(np, "vsync_len", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.vsync_len = *prop;
+
+	prop = of_get_property(np, "sync", &len);
+	if (!prop || len != sizeof(u32))
+		goto err;
+	dt_mode.sync = *prop;
+
+	fb_videomode_to_var(&info->var, &dt_mode);
+
+	return 0;
+err:
+	pr_err("%s: Can't find expected mode entry\n", np->full_name);
+	return -EINVAL;
+}
diff --git a/drivers/video/ofmode.h b/drivers/video/ofmode.h
new file mode 100644
index 0000000..9a13bec
--- /dev/null
+++ b/drivers/video/ofmode.h
@@ -0,0 +1,6 @@
+#ifndef _OFMODE_H
+#define _OFMODE_H
+
+extern int __devinit of_get_video_mode(struct device_node *np,
+					struct fb_info *info);
+#endif
-- 
1.6.3.3
