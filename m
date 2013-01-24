Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 590192C0164
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:07 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 06/32] usb: gadget: at91_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:44 +0200
Message-ID: <1359042370-4358-7-git-send-email-balbi@ti.com>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 nicolas.ferre@atmel.com, linux-geode@lists.infradead.org,
 haojian.zhuang@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By simply setting a flag, we can remove some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/at91_udc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 10f45fa..177b56d 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1726,6 +1726,7 @@ static int at91udc_probe(struct platform_device *pdev)
 
 	/* init software state */
 	udc = &controller;
+	udc->gadget.register_my_device = true;
 	udc->gadget.dev.parent = dev;
 	if (pdev->dev.of_node)
 		at91udc_of_init(udc, pdev->dev.of_node);
@@ -1780,13 +1781,7 @@ static int at91udc_probe(struct platform_device *pdev)
 		DBG("clocks missing\n");
 		retval = -ENODEV;
 		/* NOTE: we "know" here that refcounts on these are NOPs */
-		goto fail0b;
-	}
-
-	retval = device_register(&udc->gadget.dev);
-	if (retval < 0) {
-		put_device(&udc->gadget.dev);
-		goto fail0b;
+		goto fail1;
 	}
 
 	/* don't do anything until we have both gadget driver and VBUS */
@@ -1857,8 +1852,6 @@ fail3:
 fail2:
 	free_irq(udc->udp_irq, udc);
 fail1:
-	device_unregister(&udc->gadget.dev);
-fail0b:
 	iounmap(udc->udp_baseaddr);
 fail0a:
 	if (cpu_is_at91rm9200())
@@ -1892,8 +1885,6 @@ static int __exit at91udc_remove(struct platform_device *pdev)
 		gpio_free(udc->board.vbus_pin);
 	}
 	free_irq(udc->udp_irq, udc);
-	device_unregister(&udc->gadget.dev);
-
 	iounmap(udc->udp_baseaddr);
 
 	if (cpu_is_at91rm9200())
-- 
1.8.1.rc1.5.g7e0651a
