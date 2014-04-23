Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52583140153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 23:53:42 +1000 (EST)
Received: by mail-lb0-f181.google.com with SMTP id c11so781492lbj.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 06:53:38 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v12 2/7] dma: mpc512x: separate 'compatible' values for
 MPC512x and MPC8308
Date: Wed, 23 Apr 2014 17:53:24 +0400
Message-Id: <1398261209-5578-3-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC512x and MPC8308 have similar DMA controllers, but are independent SoCs.
DMA controller driver should have separate 'compatible' values for these SoCs.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 arch/powerpc/boot/dts/mpc8308_p1m.dts | 2 +-
 arch/powerpc/boot/dts/mpc8308rdb.dts  | 2 +-
 drivers/dma/mpc512x_dma.c             | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 651e4f5..57f86cd 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -296,7 +296,7 @@
 		};
 
 		dma@2c000 {
-			compatible = "fsl,mpc8308-dma", "fsl,mpc5121-dma";
+			compatible = "fsl,mpc8308-dma";
 			reg = <0x2c000 0x1800>;
 			interrupts = <3 0x8
 					94 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
index 9ce45f2..d0211f0 100644
--- a/arch/powerpc/boot/dts/mpc8308rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -265,7 +265,7 @@
 		};
 
 		dma@2c000 {
-			compatible = "fsl,mpc8308-dma", "fsl,mpc5121-dma";
+			compatible = "fsl,mpc8308-dma";
 			reg = <0x2c000 0x1800>;
 			interrupts = <3 0x8
 					94 0x8>;
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 2ce248b..0b17f4d 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -815,6 +815,7 @@ static int mpc_dma_remove(struct platform_device *op)
 
 static struct of_device_id mpc_dma_match[] = {
 	{ .compatible = "fsl,mpc5121-dma", },
+	{ .compatible = "fsl,mpc8308-dma", },
 	{},
 };
 
-- 
1.8.4.2
