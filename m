Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1AB7B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 20:11:54 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <stern@rowland.harvard.edu>, <agust@denx.de>
Subject: [RFC] usb: Fix build error due to dma_mask is not at pdev_archdata at
 ARM
Date: Tue, 14 Feb 2012 17:11:35 +0800
Message-ID: <1329210695-14492-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: fabio.estevam@freescale.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de, B31383@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When build i.mx platform with imx_v6_v7_defconfig, and after adding
USB Gadget support, it has below build error:

CC      drivers/usb/host/fsl-mph-dr-of.o
drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata'
has no member named 'dma_mask'

It has discussed at: http://www.spinics.net/lists/linux-usb/msg57302.html

For PowerPC, there is dma_mask at struct pdev_archdata, but there is
no dma_mask at struct pdev_archdata for ARM. The pdev_archdata is
related to specific platform, it should NOT be accessed by
cross platform drivers, like USB.

The code for pdev_archdata should be useless, as for PowerPC,
it has already gotten the value for pdev->dev.dma_mask at function
arch_setup_pdev_archdata of arch/powerpc/kernel/setup-common.c.

Anyone who has PowerPC hardware with USB host enabled, and uses this code
can help me a test? Thank you

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/host/fsl-mph-dr-of.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 7916e56..ab333ac 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -94,7 +94,6 @@ struct platform_device * __devinit fsl_usb2_device_register(
 	pdev->dev.parent = &ofdev->dev;
 
 	pdev->dev.coherent_dma_mask = ofdev->dev.coherent_dma_mask;
-	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
 	*pdev->dev.dma_mask = *ofdev->dev.dma_mask;
 
 	retval = platform_device_add_data(pdev, pdata, sizeof(*pdata));
-- 
1.7.0.4
