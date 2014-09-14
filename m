Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by lists.ozlabs.org (Postfix) with ESMTP id BD88F1A0076
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Sep 2014 20:00:30 +1000 (EST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [195.130.132.51])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 127BE34B3E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Sep 2014 11:48:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] video: valkyriefb: Fix unused variable warning in
 set_valkyrie_clock()
Date: Sun, 14 Sep 2014 11:48:30 +0200
Message-Id: <1410688110-11042-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_ADB_CUDA=n:

drivers/video/fbdev/valkyriefb.c: In function ‘set_valkyrie_clock’:
drivers/video/fbdev/valkyriefb.c:267: warning: unused variable ‘i’
drivers/video/fbdev/valkyriefb.c:266: warning: unused variable ‘req’

Move the variable declarations inside the existing #ifdef section to fix
this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/valkyriefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 97cb9bd1d1dd..b6ed09f16355 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -263,10 +263,10 @@ static inline int valkyrie_vram_reqd(int video_mode, int color_mode)
 
 static void set_valkyrie_clock(unsigned char *params)
 {
+#ifdef CONFIG_ADB_CUDA
 	struct adb_request req;
 	int i;
 
-#ifdef CONFIG_ADB_CUDA
 	for (i = 0; i < 3; ++i) {
 		cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC,
 			     0x50, i + 1, params[i]);
-- 
1.9.1
