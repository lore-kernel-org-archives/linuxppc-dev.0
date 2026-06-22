Return-Path: <linuxppc-dev+bounces-22871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97779CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:09:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkVSr0JPgz2xyh;
	Tue, 23 Jun 2026 00:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782137387;
	cv=none; b=htkrR6Uor6CIhnrLNLeUKNX5F4VLK06RYtj+iHCEnxP8ly0RwM9dMYAM5CoB4/2yYDLlwxyLCmTkx8+0P86qqPGqhpk27Yn5MbxJSIfDDMf5WF9xsZoNTiEfQZZdyQ/iylBmatGA0p1Qs7XvEQnAN7Khm/buGB+IgMaIe/L8cBdhQP0HTmDddJAVCDaGPpd4GI7Gr4mnhJ8WERQDszvS/f1RmGFpVoZDKnDmXVKbWkfhwf1neNq0b0GeQLKBrrRzq3oeMxyX4mIh2j7+2zjX0Aj5+GqsQGJJQ9BkrdJk+I6+q+h7w6Y9uwbtU9IvZ4BazLCEfAY88J9robtuVCGzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782137387; c=relaxed/relaxed;
	bh=Ne9oVkkKGKByPKqwL6AgLPGgyFLjAI/Z/ko7vMydqc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6dNc5gmrftkP9MS/Swm9swIq3uPaTAwvAbGZDThGUxMEW2gxZflmSwtRabplO9WBXslfV9aaoyi8LEXIFnk3w21pEtFZVord3Tnk4tn2pvqYFFDrCTmVvr+6zcIJKQnk3Ue6kfdPJWu+6gJ5/qT2DH362VLxOg4c6PLqTtbMikG2hOpTFqMiWEPdNcZEpcoCQAQ2KuTUHXddVlCYtnf20XUIMF5kwcH3J6eNT28IkGN5K/iddlhZA6GIvw/Sso+y+dqcA6iJ9bB2uFsNyJW413qEiZZzGe2TcxEjmq0DuNDm9pruwsDIJQ5V0YSf48/bPRUuJ/AJo3tNb4lncwD2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fyGBsOne; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fyGBsOne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkVSm2QNjz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 00:09:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ne
	9oVkkKGKByPKqwL6AgLPGgyFLjAI/Z/ko7vMydqc0=; b=fyGBsOne++o2fYHA27
	5uE1Fvrz6apy85Hse2OxwyWPKGxEIbpP98N7GyS9YWZJCrFhQ5L4WcPR4oq0nlUy
	GuXCi/9ehcpjyxuYDbyABJE5eHcQOoIH7tvpKRcFpg2QW18NTqIlISEZIS2xfOoH
	VQ0IxDrLdd6jz8f/SdaIV6IVY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHxF1TQTlq9u2HFA--.33214S2;
	Mon, 22 Jun 2026 22:06:13 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: gregkh@linuxfoundation.org,
	kees@kernel.org,
	balbi@ti.com,
	sebastian@breakpoint.cc
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@kernel.org
Subject: [PATCH] usb: gadget: fsl_qe_udc: fix gadget lifetime on registration failure
Date: Mon, 22 Jun 2026 22:06:10 +0800
Message-Id: <20260622140610.1140558-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wBHxF1TQTlq9u2HFA--.33214S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13tr4fXrWxGryUXw43KFg_yoW5ZFWxpF
	WkGayUGrWUArWqya17Aw1kZF1Fyws2yryS9rWxKFWSv3WrX34xX34UtF1SgF48ZFWkJF4j
	qa1DK3WrGrWkurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvJUUUUU=
X-Originating-IP: [240e:604:311:e68d:9586:9dd0:bd4b:6902]
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxRVOvGo5QVUm6wAA3o

usb_add_gadget_udc_release() drops the gadget device reference when
registration fails. This invokes qe_udc_release() while qe_udc_probe()
is still unwinding. Since udc->done is not initialized during probe,
the release callback dereferences NULL in complete(). It also frees
the qe_udc object before the remaining probe cleanup accesses it,
resulting in use-after-free and double-free risks.

Initialize the gadget device explicitly and register it with
usb_add_gadget(), which leaves the gadget reference owned by the
driver on failure. Unwind the IRQ, DMA mappings, endpoint resources
and registers before dropping that reference with usb_put_gadget().
Make the completion notification conditional because it is only
installed by the remove path.

Similarly, use usb_del_gadget() during removal so the final gadget
reference remains held while the controller resources are released.
Set the completion pointer immediately before dropping the reference,
then wait for the release callback to finish.

Fixes: d77c1198666d ("usb: gadget: fsl_qe_udc: convert to new style start/stop")
Cc: stable@kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index bf87285ad13c..f9a59b32e272 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2459,7 +2459,9 @@ static void qe_udc_release(struct device *dev)
 	struct qe_udc *udc = container_of(dev, struct qe_udc, gadget.dev);
 	int i;
 
-	complete(udc->done);
+	if (udc->done)
+		complete(udc->done);
+
 	cpm_muram_free(cpm_muram_offset(udc->ep_param[0]));
 	for (i = 0; i < USB_MAX_ENDPOINTS; i++)
 		udc->ep_param[i] = NULL;
@@ -2489,6 +2491,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 	}
 
+	usb_initialize_gadget(&ofdev->dev, &udc->gadget,
+						qe_udc_release);
+
 	udc->soc_type = (unsigned long)device_get_match_data(&ofdev->dev);
 	udc->usb_regs = of_iomap(np, 0);
 	if (!udc->usb_regs) {
@@ -2575,8 +2580,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		goto err4;
 	}
 
-	ret = usb_add_gadget_udc_release(&ofdev->dev, &udc->gadget,
-			qe_udc_release);
+	ret = usb_add_gadget(&udc->gadget);
 	if (ret)
 		goto err5;
 
@@ -2610,7 +2614,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 err2:
 	iounmap(udc->usb_regs);
 err1:
-	kfree(udc);
+	usb_put_gadget(&udc->gadget);
 	return ret;
 }
 
@@ -2633,9 +2637,8 @@ static void qe_udc_remove(struct platform_device *ofdev)
 	unsigned int size;
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	usb_del_gadget_udc(&udc->gadget);
+	usb_del_gadget(&udc->gadget);
 
-	udc->done = &done;
 	tasklet_disable(&udc->rx_tasklet);
 
 	if (udc->nullmap) {
@@ -2675,6 +2678,8 @@ static void qe_udc_remove(struct platform_device *ofdev)
 
 	iounmap(udc->usb_regs);
 
+	udc->done = &done;
+	usb_put_gadget(&udc->gadget);
 	/* wait for release() of gadget.dev to free udc */
 	wait_for_completion(&done);
 }
-- 
2.25.1


