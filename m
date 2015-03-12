Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F8571A092A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:33 +1100 (AEDT)
Received: by yhaf73 with SMTP id f73so8003463yha.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:31 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 8/9] fbdev: kconfig: replace PPC_OF with PPC
Date: Thu, 12 Mar 2015 20:32:49 +0800
Message-Id: <1426163570-10281-9-git-send-email-haokexin@gmail.com>
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

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 3b818d7a0983..109462303087 100644
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
2.1.0
