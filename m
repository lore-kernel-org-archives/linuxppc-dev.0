Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqF7c44jRzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:14:52 +1000 (AEST)
Date: Wed, 13 Jul 2016 13:14:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Li Yang <leoli@freescale.com>, Xie Xiaobo <X.Xie@freescale.com>
Cc: Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [patch] usb: gadget: fsl_qe_udc: off by one in setup_received_handle()
Message-ID: <20160713101433.GI29468@mwanda>
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

The udc->eps[] array has USB_MAX_ENDPOINTS elements so > should be >=.

Fixes: 3948f0e0c999 ('usb: add Freescale QE/CPM USB peripheral controller driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 93d28cb..cf8819a 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2053,7 +2053,7 @@ static void setup_received_handle(struct qe_udc *udc,
 			struct qe_ep *ep;
 
 			if (wValue != 0 || wLength != 0
-				|| pipe > USB_MAX_ENDPOINTS)
+				|| pipe >= USB_MAX_ENDPOINTS)
 				break;
 			ep = &udc->eps[pipe];
 
