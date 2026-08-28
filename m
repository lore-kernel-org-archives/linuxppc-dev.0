Return-Path: <linuxppc-dev+bounces-26166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB117C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 08:36:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWWvT1Mlcz2y8F;
	Fri, 28 Aug 2026 18:36:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787906197;
	cv=none; b=Gaa3VKe47IudYqPfgFFkuvGlv/6HJHZ2svDPfyBlNtboi1rrBbEVhmhSJHdJ8mBYHN2fTogF+wzTz7qkq4zLr/rUQkQ9KgsoAKsfEtWWx959He4ET8Wn8Vw331GlLYhRbIP4lRrKmKxORXFHYHlX8qL4vQCNXT3FjNbVLrmdWpHqSg+J/B+7Qdl1Y3wMIfo2BtL6X7AJucT6sp8kd2bNfLUDNGM4WQyeebFADHdyuNqNH0G8ipi6ZAgb9XvsLsCvXGtXwAqVHvGfpFNT0nr+hDgdyoeqNMZ44D319E76BH9mYkOTUZDBHKi+OdtYC5Sm/0T/r6OSSJPSLj96DxvQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787906197; c=relaxed/relaxed;
	bh=ocS9LmuxOgbVn8i7YacgyhpElndmZBQEoyHNVEhpzQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6dWkiMu6fcyOkduVdcUuEsPh80ZmKnlCN+BPOFhFxDgG6vUu19DOpLeLlYCXL63xKioaAS7X++Cq0q1qFHJgj/dqCVAz4k+0CK5vQTDIXdlLviXe97WavlJ7RGG8Cv3ki9tRAxujvLxkKRl0bHB8KzM7awbIKr5KBopzYDOtjdqX1qRBi5Ps/F+1kfuTWc41q+ifmn7QdXfKP0gSJOUna5ZaNzbTmTn6GUPgq2iWQar/8nujCyS6wETD9R2GWS8qY5bKzOiEA6ZZiUtjHeWhtwmFdnQm7d2UhHgJzPzUwVXKOqjCCn1fxFrBTxWQHlKQtWZye0KlxVksDjQvsvKOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWWvQ5PjKz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 18:36:33 +1000 (AEST)
X-UUID: 618c94b8a2bb11f19a56ed5b684f684d-20260828
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d3c2faac-2398-4f14-9e11-70dbef2ada3c,IP:15,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:d3c2faac-2398-4f14-9e11-70dbef2ada3c,IP:15,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:36576e26400a3f964a10286cc98ed3b4,BulkI
	D:2608281635153C6BL0I1,BulkQuantity:0,SF:17|19|66|78|102|127|136|850|865|8
	98,TC:nil,Content:0|15|50,EDM:5|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 618c94b8a2bb11f19a56ed5b684f684d-20260828
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 485604598; Fri, 28 Aug 2026 16:35:10 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: haoxiang_li2024@163.com,
	kees@kernel.org,
	wangyan01@kylinos.cn,
	lihaofeng@kylinos.cn,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: fsl_qe_udc: bound RX frame copies to the request's remaining space
Date: Fri, 28 Aug 2026 16:34:45 +0800
Message-Id: <20260828083445.221036-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qe_ep_rxframe_handle() and ep_req_rx() copy the received USB frame into
the active gadget request with

    cp = req->req.buf + req->req.actual;
    if (cp) {
        memcpy(cp, pframe->data, fsize);
        req->req.actual += fsize;
        if (fsize < ep->ep.maxpacket || req->req.actual >= req->req.length)
            /* complete */
    }

where fsize = frame_get_length(pframe) = hardware-reported frame length
minus USB_CRC_SIZE (2).  The length comes from the received OUT packet
on the wire (host-controlled for a device in peripheral mode), while the
request buffer is sized by the gadget driver.  Nothing guarantees
fsize <= req->req.length - req->req.actual, so a frame bigger than the
request's remaining space is memcpy()'d past the buffer, and
req->req.actual is bumped past req->req.length.

Attack chain (device in USB gadget/peripheral mode; attacker is the USB
host):

    malicious host -> OUT packet on a QE/CPM endpoint
      -> qe_udc_irq() -> rx_irq() -> qe_ep0_rx()/qe_ep_rx()
      -> ep_rx_tasklet() -> qe_ep_rxframe_handle() (or ep_req_rx())
      -> fsize = packet length - 2 (e.g. 64 for a 66-byte frame)
      -> request has req.length = 64, req.actual = 63 (1 byte left)
      -> memcpy(req.buf + 63, pframe->data, 64)
      -> 63 bytes past the request buffer

The same correction applies to the ep_req_receive() -> ep_req_rx()
path.  The upstream requests are queued by the gadget layer (ep_queue);
nothing in __qe_ep_queue() guarantees the buffer can absorb one max
packet, so the short-request state is reachable with ordinary gadgets.

Reproduced deterministically (user-space ASAN re-extraction of the
exact source path; the fsl_qe_udc driver cannot be built/loaded on
x86_64 because USB_FSL_QE requires FSL_SOC/QUICC_ENGINE/CPM and
!64BIT): with req.buf = 64 bytes, req.actual = 63 and fsize = 64,
both extracted paths (oepparsing the kernel lines for
qe_ep_rxframe_handle() :914 and ep_req_rx() :1521) fail under
AddressSanitizer with

    ERROR: AddressSanitizer: heap-buffer-overflow ... WRITE of size 64
    located 0 bytes after 64-byte region

while the same code with the remaining-capacity check added produces no
ASAN report at all.

Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
Assisted-by: opencode:deepseek-v4-flash-free
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 64 ++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 603c77ff129f..bed7edd293a5 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -911,16 +911,37 @@ static int qe_ep_rxframe_handle(struct qe_ep *ep)
 
 		cp = (u8 *)(req->req.buf) + req->req.actual;
 		if (cp) {
-			memcpy(cp, pframe->data, fsize);
-			req->req.actual += fsize;
-			if ((fsize < ep->ep.maxpacket) ||
-					(req->req.actual >= req->req.length)) {
+			if (req->req.actual >= req->req.length ||
+			    fsize > req->req.length - req->req.actual) {
+				/*
+				 * The host sent a frame larger than the
+				 * request can hold; drop it and complete with
+				 * -EOVERFLOW instead of copying past the
+				 * request buffer.
+				 */
+				dev_err(ep->udc->dev,
+					"%s: rx frame %u exceeds remaining %u\n",
+					ep->name, fsize,
+					req->req.length - req->req.actual);
+				qe_frame_clean(pframe);
 				if (ep->epnum == 0)
 					ep0_req_complete(ep->udc, req);
 				else
-					done(ep, req, 0);
+					done(ep, req, -EOVERFLOW);
 				if (list_empty(&ep->queue) && ep->epnum != 0)
 					qe_eprx_nack(ep);
+			} else {
+				memcpy(cp, pframe->data, fsize);
+				req->req.actual += fsize;
+				if ((fsize < ep->ep.maxpacket) ||
+						(req->req.actual >= req->req.length)) {
+					if (ep->epnum == 0)
+						ep0_req_complete(ep->udc, req);
+					else
+						done(ep, req, 0);
+					if (list_empty(&ep->queue) && ep->epnum != 0)
+						qe_eprx_nack(ep);
+				}
 			}
 		}
 	}
@@ -1518,15 +1539,36 @@ static int ep_req_rx(struct qe_ep *ep, struct qe_req *req)
 
 				cp = (u8 *)(req->req.buf) + req->req.actual;
 				if (cp) {
-					memcpy(cp, pframe->data, fsize);
-					req->req.actual += fsize;
-					if ((fsize < ep->ep.maxpacket)
-						|| (req->req.actual >=
-							req->req.length)) {
+					if (req->req.actual >= req->req.length ||
+					    fsize > req->req.length - req->req.actual) {
+						/*
+						 * The host sent a frame
+						 * larger than the request
+						 * can hold; drop it and
+						 * complete with -EOVERFLOW
+						 * instead of copying past
+						 * the request buffer.
+						 */
+						dev_err(udc->dev,
+							"%s: rx frame %u exceeds remaining %u\n",
+							ep->name, fsize,
+							req->req.length - req->req.actual);
+						qe_frame_clean(pframe);
 						finish_req = 1;
-						done(ep, req, 0);
+						done(ep, req, -EOVERFLOW);
 						if (list_empty(&ep->queue))
 							qe_eprx_nack(ep);
+					} else {
+						memcpy(cp, pframe->data, fsize);
+						req->req.actual += fsize;
+						if ((fsize < ep->ep.maxpacket)
+							|| (req->req.actual >=
+								req->req.length)) {
+							finish_req = 1;
+							done(ep, req, 0);
+							if (list_empty(&ep->queue))
+								qe_eprx_nack(ep);
+						}
 					}
 				}
 				qe_ep_toggledata01(ep);
-- 
2.25.1


