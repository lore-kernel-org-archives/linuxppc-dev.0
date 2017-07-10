Return-Path: <garsilva@embeddedor.com>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5Wp82nPXzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:05:20 +1000 (AEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 7F62914537
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jul 2017 22:15:48 -0500 (CDT)
Date: Sun, 9 Jul 2017 22:15:39 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] usb: gadget: fsl_udc_core: compress return logic into one line
Message-ID: <20170710031539.GA18282@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify return logic to avoid unnecessary variable assignment.

This issue was detected using Coccinelle and the following
semantic patch:

@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 6f2f71c..bf8ff5e 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1642,8 +1642,7 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
 		} else if (hc32_to_cpu(curr_td->size_ioc_sts)
 				& DTD_STATUS_ACTIVE) {
 			VDBG("Request not complete");
-			status = REQ_UNCOMPLETE;
-			return status;
+			return REQ_UNCOMPLETE;
 		} else if (remaining_length) {
 			if (direction) {
 				VDBG("Transmit dTD remaining length not zero");
-- 
2.5.0
