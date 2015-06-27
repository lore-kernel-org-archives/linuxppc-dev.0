Return-Path: <xerofoify@gmail.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 617CA1A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 06:48:11 +1000 (AEST)
Received: by iebrt9 with SMTP id rt9so94592124ieb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 13:48:09 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: leoli@freescale.com
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] udc:Make various functions have a return type of void in the
 file fsl_qe_udc.c
Date: Sat, 27 Jun 2015 16:48:02 -0400
Message-Id: <1435438082-15378-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes various USB and Endpoint manipulation functions have a
return type of void now due to these particular functions always
running to completion successfully nor their callers putting the
return value when calling one of these functions into a variable
to check/use later in their own intended internal function work.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index e0822f1..d1e4354 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -143,7 +143,7 @@ static void nuke(struct qe_ep *ep, int status)
  * USB and Endpoint manipulate process, include parameter and register       *
  *---------------------------------------------------------------------------*/
 /* @value: 1--set stall 0--clean stall */
-static int qe_eprx_stall_change(struct qe_ep *ep, int value)
+static void qe_eprx_stall_change(struct qe_ep *ep, int value)
 {
 	u16 tem_usep;
 	u8 epnum = ep->epnum;
@@ -157,10 +157,9 @@ static int qe_eprx_stall_change(struct qe_ep *ep, int value)
 		tem_usep |= USB_RHS_IGNORE_OUT;
 
 	out_be16(&udc->usb_regs->usb_usep[epnum], tem_usep);
-	return 0;
 }
 
-static int qe_eptx_stall_change(struct qe_ep *ep, int value)
+static void qe_eptx_stall_change(struct qe_ep *ep, int value)
 {
 	u16 tem_usep;
 	u8 epnum = ep->epnum;
@@ -175,19 +174,17 @@ static int qe_eptx_stall_change(struct qe_ep *ep, int value)
 
 	out_be16(&udc->usb_regs->usb_usep[epnum], tem_usep);
 
-	return 0;
 }
 
-static int qe_ep0_stall(struct qe_udc *udc)
+static void qe_ep0_stall(struct qe_udc *udc)
 {
 	qe_eptx_stall_change(&udc->eps[0], 1);
 	qe_eprx_stall_change(&udc->eps[0], 1);
 	udc->ep0_state = WAIT_FOR_SETUP;
 	udc->ep0_dir = 0;
-	return 0;
 }
 
-static int qe_eprx_nack(struct qe_ep *ep)
+static void qe_eprx_nack(struct qe_ep *ep)
 {
 	u8 epnum = ep->epnum;
 	struct qe_udc *udc = ep->udc;
@@ -203,10 +200,9 @@ static int qe_eprx_nack(struct qe_ep *ep)
 
 		ep->state = EP_STATE_NACK;
 	}
-	return 0;
 }
 
-static int qe_eprx_normal(struct qe_ep *ep)
+static void qe_eprx_normal(struct qe_ep *ep)
 {
 	struct qe_udc *udc = ep->udc;
 
@@ -224,10 +220,9 @@ static int qe_eprx_normal(struct qe_ep *ep)
 		ep->has_data = 0;
 	}
 
-	return 0;
 }
 
-static int qe_ep_cmd_stoptx(struct qe_ep *ep)
+static void qe_ep_cmd_stoptx(struct qe_ep *ep)
 {
 	if (ep->udc->soc_type == PORT_CPM)
 		cpm_command(CPM_USB_STOP_TX | (ep->epnum << CPM_USB_EP_SHIFT),
@@ -236,10 +231,9 @@ static int qe_ep_cmd_stoptx(struct qe_ep *ep)
 		qe_issue_cmd(QE_USB_STOP_TX, QE_CR_SUBBLOCK_USB,
 				ep->epnum, 0);
 
-	return 0;
 }
 
-static int qe_ep_cmd_restarttx(struct qe_ep *ep)
+static void qe_ep_cmd_restarttx(struct qe_ep *ep)
 {
 	if (ep->udc->soc_type == PORT_CPM)
 		cpm_command(CPM_USB_RESTART_TX | (ep->epnum <<
@@ -248,10 +242,9 @@ static int qe_ep_cmd_restarttx(struct qe_ep *ep)
 		qe_issue_cmd(QE_USB_RESTART_TX, QE_CR_SUBBLOCK_USB,
 				ep->epnum, 0);
 
-	return 0;
 }
 
-static int qe_ep_flushtxfifo(struct qe_ep *ep)
+static void qe_ep_flushtxfifo(struct qe_ep *ep)
 {
 	struct qe_udc *udc = ep->udc;
 	int i;
@@ -268,19 +261,17 @@ static int qe_ep_flushtxfifo(struct qe_ep *ep)
 	ep->c_txbd = ep->txbase;
 	ep->n_txbd = ep->txbase;
 	qe_ep_cmd_restarttx(ep);
-	return 0;
 }
 
-static int qe_ep_filltxfifo(struct qe_ep *ep)
+static void qe_ep_filltxfifo(struct qe_ep *ep)
 {
 	struct qe_udc *udc = ep->udc;
 
 	out_8(&udc->usb_regs->usb_uscom,
 			USB_CMD_STR_FIFO | (USB_CMD_EP_MASK & (ep->epnum)));
-	return 0;
 }
 
-static int qe_epbds_reset(struct qe_udc *udc, int pipe_num)
+static void qe_epbds_reset(struct qe_udc *udc, int pipe_num)
 {
 	struct qe_ep *ep;
 	u32 bdring_len;
@@ -309,10 +300,9 @@ static int qe_epbds_reset(struct qe_udc *udc, int pipe_num)
 	}
 	out_be32((u32 __iomem *)bd, T_W);
 
-	return 0;
 }
 
-static int qe_ep_reset(struct qe_udc *udc, int pipe_num)
+static void qe_ep_reset(struct qe_udc *udc, int pipe_num)
 {
 	struct qe_ep *ep;
 	u16 tmpusep;
@@ -339,13 +329,11 @@ static int qe_ep_reset(struct qe_udc *udc, int pipe_num)
 
 	qe_epbds_reset(udc, pipe_num);
 
-	return 0;
 }
 
-static int qe_ep_toggledata01(struct qe_ep *ep)
+static void qe_ep_toggledata01(struct qe_ep *ep)
 {
 	ep->data01 ^= 0x1;
-	return 0;
 }
 
 static int qe_ep_bd_init(struct qe_udc *udc, unsigned char pipe_num)
-- 
2.1.4
