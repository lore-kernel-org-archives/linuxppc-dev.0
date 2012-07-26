Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 13/18] powerpc/ps3: Replace virt_to_abs() with __pa()
Date: Thu, 26 Jul 2012 17:19:59 +1000
Message-Id: <1343287204-7700-13-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

virt_to_abs() is just a wrapper around __pa(), call __pa() directly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/video/ps3fb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 213fbbc..4e292f2 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -31,7 +31,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 
-#include <asm/abs_addr.h>
 #include <asm/cell-regs.h>
 #include <asm/lv1call.h>
 #include <asm/ps3av.h>
@@ -1141,7 +1140,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	 */
 	fb_start = ps3fb_videomemory.address + GPU_FB_START;
 	info->screen_base = (char __force __iomem *)fb_start;
-	info->fix.smem_start = virt_to_abs(fb_start);
+	info->fix.smem_start = __pa(fb_start);
 	info->fix.smem_len = ps3fb_videomemory.size - GPU_FB_START;
 
 	info->pseudo_palette = par->pseudo_palette;
-- 
1.7.9.5
