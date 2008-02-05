Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 70613DE140
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 02:45:06 +1100 (EST)
Date: Tue, 5 Feb 2008 18:44:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: adaplas@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [POWERPC] offb: add support for foreign endianness
Message-ID: <20080205154445.GB8749@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/video/offb.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 452433d..d7b3dcc 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -248,7 +248,7 @@ static void __iomem *offb_map_reg(struct device_node *np, int index,
 static void __init offb_init_fb(const char *name, const char *full_name,
 				int width, int height, int depth,
 				int pitch, unsigned long address,
-				struct device_node *dp)
+				int foreign_endian, struct device_node *dp)
 {
 	unsigned long res_size = pitch * height * (depth + 7) / 8;
 	struct offb_par *par = &default_par;
@@ -397,7 +397,7 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->par = par;
 	info->pseudo_palette = (void *) (info + 1);
-	info->flags = FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | foreign_endian;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
@@ -424,6 +424,15 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	u64 rstart, address = OF_BAD_ADDR;
 	const u32 *pp, *addrp, *up;
 	u64 asize;
+	int foreign_endian = 0;
+
+#ifdef __BIG_ENDIAN
+	if (of_get_property(dp, "little-endian", NULL))
+		foreign_endian = FBINFO_FOREIGN_ENDIAN;
+#else
+	if (of_get_property(dp, "big-endian", NULL))
+		foreign_endian = FBINFO_FOREIGN_ENDIAN;
+#endif
 
 	pp = of_get_property(dp, "linux,bootx-depth", &len);
 	if (pp == NULL)
@@ -509,7 +518,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		offb_init_fb(no_real_node ? "bootx" : dp->name,
 			     no_real_node ? "display" : dp->full_name,
 			     width, height, depth, pitch, address,
-			     no_real_node ? NULL : dp);
+			     foreign_endian, no_real_node ? NULL : dp);
 	}
 }
 
-- 
1.5.2.2
