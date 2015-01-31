Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com
 [IPv6:2607:f8b0:4002:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78DA31A1107
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:49 +1100 (AEDT)
Received: by mail-yh0-f45.google.com with SMTP id f73so12997097yha.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:47 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 10/15] gpio: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:40 +0800
Message-Id: <1422712065-9403-11-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kevin Hao <haokexin@gmail.com>
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
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ae5cb4d517c6..c1e2ca3d9a51 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -383,7 +383,7 @@ config GPIO_XGENE_SB
 
 config GPIO_XILINX
 	tristate "Xilinx GPIO support"
-	depends on OF_GPIO && (PPC_OF || MICROBLAZE || ARCH_ZYNQ || X86)
+	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
 	help
 	  Say yes here to support the Xilinx FPGA GPIO device
 
-- 
1.9.3
