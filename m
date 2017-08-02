Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMyjf02SwzDsXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 02:06:29 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Li Yang <leoyang.li@nxp.com>
Cc: kernel-janitors@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] usb: gadget: fsl_qe_udc: constify qe_ep0_desc
Date: Wed,  2 Aug 2017 17:29:27 +0200
Message-Id: <1501687767-12768-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

qe_ep0_desc is only passed as the second argument to qe_ep_init, which is
const, so qe_ep0_desc can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I got a lot of warnings when compiling this file, but none seemed to be
related to the change.

 drivers/usb/gadget/udc/fsl_qe_udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 303328ce..a3e72d6 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -62,7 +62,7 @@
 	"ep3",
 };
 
-static struct usb_endpoint_descriptor qe_ep0_desc = {
+static const struct usb_endpoint_descriptor qe_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
 
