Return-Path: <linuxppc-dev+bounces-26164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E1CC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWVN24jWTz2y2T;
	Fri, 28 Aug 2026 17:27:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787902066;
	cv=none; b=Dj3YAjsk58p6zsRLOOVrPqGIWW74Ye4uDjkuTaKFn8LqtTKj2qrOAukqS5vG71RCVLv3uGEtGBAOH3Da4TngeUddLiPZpBY0dUpvFlwtVMn5eNcyBvVeO6VnJThRnK5MqCDlOjBTwdWG2XWG5AZ+6kOqzMCcVmd/0RymqBnCBa1NmhWLbeOSjV3zkUW4XDZTPUopvxRQsr/KFNVKJ5IQ+rpGSALJcXF9PvApOHkDQUDgxDF2oOomqYI7biobJjtfuaXaqaq/xHD9IFI1nDsDpfyiiipVwoD8833VPiV635q//vg7di22jSpPHpbZ/DwBYVSR3d5nE++7Uvo2HopLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787902066; c=relaxed/relaxed;
	bh=Wp8Cfi0TykYT6FODsDy0pOVzbapztWfE+Fg8egS0CPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhXkmg/cc29OzStXKG+H9O0xkseeBiMj0wIh0f13LYqOVfHUsEDW87Z/dcku81Uhq2cUklH+6VwMSqexfM20q/Qs7cPFAiZ7amSKa9p9QNfB7Z48SsJetIZya3DLI7AWDOE1fB18ZUK0zd/dEzAIqy6flmPp1LwwLljyiZuHPS5bZ7Xe6hIo4Ic2WgNEZPtHOP4tPLxhZYqE7B2itQsQfNlB1bFDooKB7ZSdGmyVyvGpY/6YkBLlRA45rwXv6aQc6IzQ6WroFOYERpYpKhY+ZCHW/pQ8fyPO68uGWuJEEClAt0RFuTR0YVL6pxKQU8kicWAVTl8GmhZShlLaT2BeuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yNS5dyAB; dkim-atps=neutral; spf=pass (client-ip=195.10.208.51; helo=mout-b-206.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=mandelbit.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yNS5dyAB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mandelbit.com (client-ip=195.10.208.51; helo=mout-b-206.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org)
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWVN13w7Tz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 17:27:45 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hWVMw6C0yzJF;
	Fri, 28 Aug 2026 09:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787902060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wp8Cfi0TykYT6FODsDy0pOVzbapztWfE+Fg8egS0CPY=;
	b=yNS5dyAByIsjlxBeOsUbRNFbYm4Uoq+VfB6pjKhIVzgvMVAbjUD5dq1V5m4NiJvtonwknH
	gbqgbW9bn7dWghveeHVd0KYjBDlnvcg3d6RjWwr5eeU3QlVBBUBdNJIn/RC22SKmmVgfaN
	Q9kp4plCBY1eyon/alJUS9jVG9/dWi1Ly+sCg94XgesPWfcwV9yIRKypLGWwMAI9LrTrub
	iRfh8v+YV6GsqR7gn6+rVdrmE6TkaBmAw/7Hl/y1bazLhiYhisZmt69boKlgrq/4pSM4qe
	0fXvyvhL7MBexxYYXM/gTqYsHm6JBDtZS6LgrmhEs/CnuexKA/nL4GmX9oFBag==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: stable@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 09:27:27 +0200
Message-ID: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4hWVMw6C0yzJF

This reverts commit 319f7a85b3c4e34ac2fe083eb146fe129a556317.

The reverted commit uses disable_delayed_work_sync, which was introduced
by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items") in v6.10. The function is therefore unavailable
in 6.6.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
to build.

The upstream commit is unaffected; only its incompatible stable backport
is being reverted.

Fixes: 319f7a85b3c4 ("usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal")
Link: https://lore.kernel.org/stable/20260827154302.706689-1-ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 552899fa985e..79617bb0a70e 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -987,7 +987,6 @@ static void fsl_otg_remove(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	disable_delayed_work_sync(&fsl_otg_dev->otg_event);
 	usb_remove_phy(&fsl_otg_dev->phy);
 	free_irq(fsl_otg_dev->irq, fsl_otg_dev);
 

base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.55.0


