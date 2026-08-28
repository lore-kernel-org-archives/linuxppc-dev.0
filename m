Return-Path: <linuxppc-dev+bounces-26163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B1EC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWVMW2H3lz2y2T;
	Fri, 28 Aug 2026 17:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:102:465::201"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787902039;
	cv=none; b=X+GaLTjGfx7bY/FwYThkaWSZhRnIACIkyC0VlOnL6Kx9PZEgq0jf5JIzc5sw07cbLcEKTAse1wsRiMq/5T0w6bnaTtfYvn6k8fvKQwDlTu5G8VGdjigxt38qn86qGb++8SmF22/9WFxgQOmUqvsBTXo7cC3d0m2/3BF+Tpbwn1SRtqsLZLecXm9YtL2+np6UUoIuXwu0SuK33JKGwoRACLQr22cWYFBWWo875VeqMzeLbzV/7jeLi8o6mCBoPLazeBa3JfClGKvbCBOT1i2tVpt/bU7ro3yZXVN8d+RRxONoBVNnOXcC+7jFahy9SFfAsPBb+kOp0jjtDzcjkt2dWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787902039; c=relaxed/relaxed;
	bh=uu2quDv9BXIJXVAu8nYVgirdDkUUo0uu4AfJYmAk8Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeuSARqOAGg+UxIoXg6TZBIcCHXW6U6zM1URipPgBAXo3PybxUkfzW+1WwOgQvm9eDJ4zC3mOjlA/NHBb8LbnDUc9DqTR+9CEkN5DjALDCCvxu65SsbcBoL1I6qBsLSx9WzHmQUCLH88Dzs9IwYTg0ZflfdEBiIAsbjHBcEL7fXJiIkub+CMUFlOKNk+XfTcwdlyW1tK7rJm+d1wHoofpKWZJjcSPsLycnem1ooHcfN43OWlbpyrbsPnvBwhlxrZ7nAInrDrQkR94jSt3BgOkCZqLRAQYf4R1KVz1iGsyGxjORvw9gSGiybd7mEgA/jJBhOxY1Viglu7iSTd8ztWsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=nTKPEt/g; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:102:465::201; helo=mout-b-201.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=mandelbit.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=nTKPEt/g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mandelbit.com (client-ip=2001:67c:2050:102:465::201; helo=mout-b-201.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 56624 seconds by postgrey-1.37 at boromir; Fri, 28 Aug 2026 17:27:15 AEST
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [IPv6:2001:67c:2050:102:465::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWVMR5MhYz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 17:27:14 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hWVMD18qVzLlr8;
	Fri, 28 Aug 2026 09:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787902024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uu2quDv9BXIJXVAu8nYVgirdDkUUo0uu4AfJYmAk8Io=;
	b=nTKPEt/gXykPqT7gsEUv856eL0gw7J+sfgcroVjAb40gPzJr1OuG6pS7EmL3NxhIY1p7jA
	3CpQGTZuzzVQ9UMp5gfV4/ubCOisaxjQdslUaZwH9FCnKvX74RRtNgbox3VNcXoDLn2o9s
	8TmAUg49Tb1FWrPaI+1jZzb5+6NGCEEOIZq1wmW1UgOqd2M5tO294GjUYSg3e17wU81qbP
	IBhO8wAqBhcq2ZCO8czmdTnGzpKE9l3nUIke1e7q7/Izf135pjkA8N34VPUy/20/lfd7ii
	7ZfbwnAYdn7sXci1sx70CMAHwYCy31ODbG3Prqd8n579IaaUEqunueuZ7o4n0w==
From: Ralf Lici <ralf@mandelbit.com>
To: stable@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 6.1.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 09:26:45 +0200
Message-ID: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
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

This reverts commit 4476c73bbbb09b13a962176fca934b32d3954a2e.

The reverted commit uses disable_delayed_work_sync, which was introduced
by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items") in v6.10. The function is therefore unavailable
in 6.1.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
to build.

The upstream commit is unaffected; only its incompatible stable backport
is being reverted.

Fixes: 4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal")
Link: https://lore.kernel.org/stable/20260827154302.706689-1-ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index ab4df5819ef8..972704262b02 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -987,7 +987,6 @@ static int fsl_otg_remove(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	disable_delayed_work_sync(&fsl_otg_dev->otg_event);
 	usb_remove_phy(&fsl_otg_dev->phy);
 	free_irq(fsl_otg_dev->irq, fsl_otg_dev);
 

base-commit: d64a499eea6b62b5121beceed9e8a1f57b00d863
-- 
2.55.0


