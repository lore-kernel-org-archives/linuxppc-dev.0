Return-Path: <linuxppc-dev+bounces-23403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7444C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:16:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grf7f2Xzzz2yjm;
	Fri, 03 Jul 2026 00:16:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783001774;
	cv=none; b=X9Z6w3OKezhYwzcot66RPEkCBgGs3KdhiyEiGkCfKMLWxH8H7TNKkT5q/cYcABTkBKOkK7OwL0eAErCxVEgYerVhooZldbCt4y8Bc4IimqZf1CLZSFoNj6CGh/bJngwDSTWVIbZDtPMQS+SqoXOkEIbvANt8jCZkgmGgGbNZGpBYfDSkPjQ7giv9lqfQ35HQZIwSQplBuzUOnVvvWvOuE0aY2g2M0Vlk7UBgozf5/9rdLhRI7jC7PnJR1KdwcNWirdKOCmwyZadFcnFoqSls3crdK1TVN9wIQE/i7E7rKqmBWga3hZIRj+qLOVLGSFDHWq4cNW/SoEO4mf580KWfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783001774; c=relaxed/relaxed;
	bh=upo0gek+32/vnIiAbTo2eqGMVX4+1vrtvizChE+eoC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndRL8dasVPQUEpucuV1yOFeNTMX/truF1hB6yTSjpRGRnE2/x9m3JH6YuFdTb9XMAsDDzwgHcyNHIEF3G41vbUi36NIyATFzJZ2k7LsXN44t/AqOxHvDcoEopFhjUF8R5xziIHjHV0au5nRjFdnrkLTWlW7sgi8SZ/l5jQs34nVrq6fhkkI7vsIS8pILEZE+MBGGOn2J9y1hb359wd7clS9DeTa5V+F4Lfx3U7W4zZfkAlU8wOdUZQTn4B6YRztnpTqI0UM4zwxt1jUeizhEp1xmVTE9Tbyaad1Narfl0l8rAg3p2JJoA0UA9mNx5hDB71NPf6LYbVj3djyDCDTZiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze7nh97P; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze7nh97P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grf7c1GhCz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:16:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 59266601E0;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAA1F000E9;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=upo0gek+32/vnIiAbTo2eqGMVX4+1vrtvizChE+eoC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ze7nh97PWyiX5v4zqZlRZlqwqPw8EnbWqpIMpLtGnwkj+IpG7hBwu2OJ9kV+Lii8i
	 tlVfOjILTURlP/+sO+aPe7xs4HRx1HTihVNOgBTcuDmZoycGieeisWKxZC06g/8TxW
	 sSPczmU6WPnSA6JSrgIedQOpVz9mr8V90Wc0JIwZeZP+v4rp513NSl6QoePYzpC/hd
	 3wSK3uWiHdjs1LIBRcIM0/NsN44WgMguDxZUQiai5nOZY+XK0vMc10sC8f8jIlY+Lu
	 YEeVsXbElwtsAhch03hhr+cdkmMJwBjR+UWg6StIBF/rYoggPLmwfKouCRooe8r3lu
	 0WO8fhtl4dJyA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Nec-2nzW;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] USB: gadget: snps-udc: fix device name leak on probe failure
Date: Thu,  2 Jul 2026 16:15:34 +0200
Message-ID: <20260702141536.90887-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702141536.90887-1-johan@kernel.org>
References: <20260702141536.90887-1-johan@kernel.org>
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

The gadget device name is set by UDC core when registering the gadget
and must not be set before to avoid leaking the name in intermediate
error paths (e.g. when detecting an older chip revision).

Fixes: 12ad0fcaf2fb ("usb: gadget: amd5536udc: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/snps_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 0e0db68e0b27..d506f9d92bca 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -3133,7 +3133,6 @@ int udc_probe(struct udc *dev)
 	/* device struct setup */
 	dev->gadget.ops = &udc_ops;
 
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
 
-- 
2.53.0


