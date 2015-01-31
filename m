Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22e.google.com (mail-yh0-x22e.google.com
 [IPv6:2607:f8b0:4002:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33D2B1A10C9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:46 +1100 (AEDT)
Received: by mail-yh0-f46.google.com with SMTP id c41so12952446yho.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:44 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 09/15] fbdev: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:39 +0800
Message-Id: <1422712065-9403-10-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 55161dd4b931..027f9b685b5b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -479,7 +479,7 @@ config FB_ATARI
 
 config FB_OF
 	bool "Open Firmware frame buffer device support"
-	depends on (FB = y) && (PPC64 || PPC_OF) && (!PPC_PSERIES || PCI)
+	depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.9.3
