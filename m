Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 277441A08EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:24 +1100 (AEDT)
Received: by yhai57 with SMTP id i57so8028996yha.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:22 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 5/9] fbdev: nvidia: remove the dependency on PPC_OF
Date: Thu, 12 Mar 2015 20:32:46 +0800
Message-Id: <1426163570-10281-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
References: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OF functionality has moved to a common place and be used by many
archs. So we don't need to include the ppc arch specific header files
and depend on PPC_OF option any more. This is a preparation for
killing PPC_OF.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/nvidia/Makefile   | 3 +--
 drivers/video/fbdev/nvidia/nv_of.c    | 3 ---
 drivers/video/fbdev/nvidia/nv_proto.h | 8 --------
 drivers/video/fbdev/nvidia/nvidia.c   | 4 ----
 4 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/Makefile b/drivers/video/fbdev/nvidia/Makefile
index ca47432113e0..917d3eb05feb 100644
--- a/drivers/video/fbdev/nvidia/Makefile
+++ b/drivers/video/fbdev/nvidia/Makefile
@@ -5,9 +5,8 @@
 obj-$(CONFIG_FB_NVIDIA)          += nvidiafb.o
 
 nvidiafb-y                       := nvidia.o nv_hw.o nv_setup.o \
-			            nv_accel.o
+			            nv_accel.o nv_of.o
 nvidiafb-$(CONFIG_FB_NVIDIA_I2C) += nv_i2c.o
 nvidiafb-$(CONFIG_FB_NVIDIA_BACKLIGHT)  += nv_backlight.o
-nvidiafb-$(CONFIG_PPC_OF)	 += nv_of.o
 
 nvidiafb-objs                    := $(nvidiafb-y)
diff --git a/drivers/video/fbdev/nvidia/nv_of.c b/drivers/video/fbdev/nvidia/nv_of.c
index 3bc13df4b120..5f3e5179c25a 100644
--- a/drivers/video/fbdev/nvidia/nv_of.c
+++ b/drivers/video/fbdev/nvidia/nv_of.c
@@ -19,9 +19,6 @@
 
 #include <asm/io.h>
 
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-
 #include "nv_type.h"
 #include "nv_local.h"
 #include "nv_proto.h"
diff --git a/drivers/video/fbdev/nvidia/nv_proto.h b/drivers/video/fbdev/nvidia/nv_proto.h
index ff5c410355ea..878a5ce02299 100644
--- a/drivers/video/fbdev/nvidia/nv_proto.h
+++ b/drivers/video/fbdev/nvidia/nv_proto.h
@@ -42,16 +42,8 @@ int nvidia_probe_i2c_connector(struct fb_info *info, int conn,
 #define nvidia_probe_i2c_connector(p, c, edid) (-1)
 #endif
 
-#ifdef CONFIG_PPC_OF
 int nvidia_probe_of_connector(struct fb_info *info, int conn,
 			      u8 ** out_edid);
-#else
-static inline int nvidia_probe_of_connector(struct fb_info *info, int conn,
-				      u8 ** out_edid)
-{
-	return -1;
-}
-#endif
 
 /* in nv_accel.c */
 extern void NVResetGraphics(struct fb_info *info);
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index def041204676..4273c6ee8cf6 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -24,10 +24,6 @@
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif
 #ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
-- 
2.1.0
