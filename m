Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrVPQ2zkqzDrgs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 21:16:10 +1000 (AEST)
Date: Fri, 15 Jul 2016 14:15:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Li Yang <leoli@freescale.com>
Cc: Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [patch] usb: gadget: fsl_qe_udc: signedness bug in qe_get_frame()
Message-ID: <20160715111547.GF9258@mwanda>
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

We can't assign -EINVAL to a u16.

Fixes: 3948f0e0c999 ('usb: add Freescale QE/CPM USB peripheral controller driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 93d28cb..901366f 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1878,11 +1878,8 @@ static int qe_get_frame(struct usb_gadget *gadget)
 
 	tmp = in_be16(&udc->usb_param->frame_n);
 	if (tmp & 0x8000)
-		tmp = tmp & 0x07ff;
-	else
-		tmp = -EINVAL;
-
-	return (int)tmp;
+		return tmp & 0x07ff;
+	return -EINVAL;
 }
 
 static int fsl_qe_start(struct usb_gadget *gadget,
