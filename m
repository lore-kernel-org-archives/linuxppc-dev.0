Return-Path: <segooon@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id E93C1B6EEE
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 03:38:45 +1000 (EST)
Received: by eyh6 with SMTP id 6so4965863eyh.15
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 10:38:43 -0700 (PDT)
From: Kulikov Vasiliy <segooon@gmail.com>
To: kernel-janitors@vger.kernel.org
Subject: [PATCH 2/7] usb: fsl_udc_core: check return value of
	create_proc_read_entry()
Date: Sat, 31 Jul 2010 21:38:20 +0400
Message-Id: <1280597900-8405-1-git-send-email-segooon@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

create_proc_read_entry() may fail, if so return -ENOMEM.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 08a9a62..c3d1545 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2128,7 +2128,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 
 #else				/* !CONFIG_USB_GADGET_DEBUG_FILES */
 
-#define create_proc_file()	do {} while (0)
+#define create_proc_file()	({ (void *)1; })
 #define remove_proc_file()	do {} while (0)
 
 #endif				/* CONFIG_USB_GADGET_DEBUG_FILES */
@@ -2373,9 +2373,14 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_unregister;
 	}
-	create_proc_file();
+	if (create_proc_file() == 0) {
+		ret = -ENOMEM;
+		goto err_pool;
+	}
 	return 0;
 
+err_pool:
+	dma_pool_destroy(udc_controller->td_pool);
 err_unregister:
 	device_unregister(&udc_controller->gadget.dev);
 err_free_irq:
-- 
1.7.0.4
