Return-Path: <rahul.ruikar@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id A90DBB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 15:42:10 +1000 (EST)
Received: by pxi1 with SMTP id 1so1286909pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 22:42:08 -0700 (PDT)
From: Rahul Ruikar <rahul.ruikar@gmail.com>
To: Li Yang <leoli@freescale.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] usb: gadget: fsl_udc_core: Fix error path
Date: Sat,  2 Oct 2010 11:11:36 +0530
Message-Id: <1285998096-3385-1-git-send-email-rahul.ruikar@gmail.com>
Cc: Rahul Ruikar <raul.ruikar@gmail.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Rahul Ruikar <rahul.ruikar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

call put_device() when device_register() fails.

Signed-off-by: Rahul Ruikar <raul.ruikar@gmail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 08a9a62..491fc7a 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2340,8 +2340,10 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.dev.release = fsl_udc_release;
 	udc_controller->gadget.dev.parent = &pdev->dev;
 	ret = device_register(&udc_controller->gadget.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		put_device(&udc_controller->gadget.dev);
 		goto err_free_irq;
+	}
 
 	/* setup QH and epctrl for ep0 */
 	ep0_setup(udc_controller);
-- 
1.7.2.3
