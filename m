Return-Path: <SRS0=jKXk=YO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F03CA9EAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 10:23:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBC12084C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 10:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46xXmF0x2czDqmf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 21:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com; envelope-from=yinbo.zhu@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46xXjj70yGzDqMV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2019 21:21:25 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7689C200123;
 Mon, 21 Oct 2019 12:21:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A129200A5F;
 Mon, 21 Oct 2019 12:21:17 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1190D402F0;
 Mon, 21 Oct 2019 18:21:10 +0800 (SGT)
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: Li Yang <leoyang.li@nxp.com>,
	Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v1] usb: gadget: Correct NULL pointer checking in fsl gadget
Date: Mon, 21 Oct 2019 18:21:53 +0800
Message-Id: <20191021102153.16435-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021102153.16435-1-yinbo.zhu@nxp.com>
References: <20191021102153.16435-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nikhil Badola <nikhil.badola@freescale.com>, linux-usb@vger.kernel.org,
 xiaobo.xie@nxp.com, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
 Ran Wang <ran.wang_1@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 yinbo.zhu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nikhil Badola <nikhil.badola@freescale.com>

Correct NULL pointer checking for endpoint descriptor
before it gets dereferenced

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 381fdff12d4e..980cb1382851 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1052,10 +1052,11 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	u32 bitmask;
 	struct ep_queue_head *qh;
 
-	ep = container_of(_ep, struct fsl_ep, ep);
-	if (!_ep || (!ep->ep.desc && ep_index(ep) != 0))
+	if (!_ep || _ep->desc || !(_ep->desc->bEndpointAddress&0xF))
 		return -ENODEV;
 
+	ep = container_of(_ep, struct fsl_ep, ep);
+
 	udc = (struct fsl_udc *)ep->udc;
 
 	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
-- 
2.17.1

