Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 739F7B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 01:24:13 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so3737013bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2012 08:24:10 -0700 (PDT)
Subject: [PATCH] usb: gadget: regression fix - useage of usb_ep
From: Christoph Fritz <chf.fritz@googlemail.com>
To: balbi@ti.com
In-Reply-To: <20120604145917.GM8002@arwen.pp.htv.fi>
References: <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi> <1338809424.3371.20.camel@mars>
 <20120604145917.GM8002@arwen.pp.htv.fi>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 04 Jun 2012 17:24:03 +0200
Message-ID: <1338823443.2979.3.camel@mars>
Mime-Version: 1.0
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Fabio Estevam <festevam@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Oliver Neukum <oneukum@suse.de>, Eric Miao <eric.y.miao@gmail.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes redundant pointer to struct usb_endpoint_descriptor which
were missed in commit 79149b8:

 usb: gadget: Update fsl_udc_core to use usb_endpoint_descriptor inside the
 struct usb_ep

Due to clock framework regressions, this patch is only compile tested!

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 +-
 drivers/usb/gadget/fsl_usb2_udc.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 2831685..678ec4d 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2575,7 +2575,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	/* for ep0: the desc defined here;
 	 * for other eps, gadget layer called ep_enable with defined desc
 	 */
-	udc_controller->eps[0].desc = &fsl_ep0_desc;
+	udc_controller->eps[0].ep.desc = &fsl_ep0_desc;
 	udc_controller->eps[0].ep.maxpacket = USB_MAX_CTRL_PAYLOAD;
 
 	/* setup the udc->eps[] for non-control endpoints and link
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index 5cd7b7e..f61a967 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -568,10 +568,10 @@ static void dump_msg(const char *label, const u8 * buf, unsigned int length)
 /*
  * ### internal used help routines.
  */
-#define ep_index(EP)		((EP)->desc->bEndpointAddress&0xF)
+#define ep_index(EP)		((EP)->ep.desc->bEndpointAddress&0xF)
 #define ep_maxpacket(EP)	((EP)->ep.maxpacket)
 #define ep_is_in(EP)	( (ep_index(EP) == 0) ? (EP->udc->ep0_dir == \
-			USB_DIR_IN ):((EP)->desc->bEndpointAddress \
+			USB_DIR_IN) : ((EP)->ep.desc->bEndpointAddress \
 			& USB_DIR_IN)==USB_DIR_IN)
 #define get_ep_by_pipe(udc, pipe)	((pipe == 1)? &udc->eps[0]: \
 					&udc->eps[pipe])
-- 
1.7.2.5
