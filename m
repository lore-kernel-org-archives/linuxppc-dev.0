Return-Path: <xerofoify@gmail.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8B8E1A0359
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 11:48:52 +1000 (AEST)
Received: by iebmu5 with SMTP id mu5so96121396ieb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 18:48:50 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: leoli@freescale.com
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] udc:Make the function txcomplete have a return type of void
Date: Sat, 27 Jun 2015 21:48:44 -0400
Message-Id: <1435456124-28082-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes the function txcomplete have a return type of void
now due to this particular function always running successfully
nor its callers checking/using the return value from this particular
function in their own internal work.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index e0822f1..8c3a1ec 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1139,7 +1139,7 @@ static int qe_ep_tx(struct qe_ep *ep, struct qe_frame *frame)
 
 /* when a bd was transmitted, the function can
  * handle the tx_req, not include ep0           */
-static int txcomplete(struct qe_ep *ep, unsigned char restart)
+static void txcomplete(struct qe_ep *ep, unsigned char restart)
 {
 	if (ep->tx_req != NULL) {
 		struct qe_req *req = ep->tx_req;
@@ -1184,8 +1184,6 @@ static int txcomplete(struct qe_ep *ep, unsigned char restart)
 			ep->sent = 0;
 		}
 	}
-
-	return 0;
 }
 
 /* give a frame and a tx_req, send some data */
-- 
2.1.4
