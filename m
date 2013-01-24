Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A21302C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:45 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 30/32] usb: chipidea: register debugging syfs on our device
Date: Thu, 24 Jan 2013 17:46:08 +0200
Message-ID: <1359042370-4358-31-git-send-email-balbi@ti.com>
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

Don't register anything non-generic under
the gadget's device as we don't really *own*
it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/chipidea/udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..f64fbea 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1767,7 +1767,7 @@ static int udc_start(struct ci13xxx *ci)
 		goto put_transceiver;
 	}
 
-	retval = dbg_create_files(&ci->gadget.dev);
+	retval = dbg_create_files(ci->dev);
 	if (retval)
 		goto unreg_device;
 
@@ -1796,7 +1796,7 @@ remove_trans:
 
 	dev_err(dev, "error = %i\n", retval);
 remove_dbg:
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 unreg_device:
 	device_unregister(&ci->gadget.dev);
 put_transceiver:
@@ -1836,7 +1836,7 @@ static void udc_stop(struct ci13xxx *ci)
 		if (ci->global_phy)
 			usb_put_phy(ci->transceiver);
 	}
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 	device_unregister(&ci->gadget.dev);
 	/* my kobject is dynamic, I swear! */
 	memset(&ci->gadget, 0, sizeof(ci->gadget));
-- 
1.8.1.rc1.5.g7e0651a
