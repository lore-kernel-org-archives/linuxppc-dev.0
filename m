Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCEFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:25:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5710C20658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFFetna8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5710C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVYCM4sjmzDq9S
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:25:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tFFetna8; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSk26lxZzDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 19:02:50 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id c6so7502396pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fyyx5l8JBWdsh/vzK9XkI9lqTabxVOq8Vrtc0Hw0vUw=;
 b=tFFetna8jRJGMqAQA4gg5CD4aJnfg7vJVX2XDgITV0TAHrZGa3EqUKCj9X6roVS5ua
 z/bDFWyUaKt5hZ8eLbEPXauBjLbr7vULyfh2HFpNOrOrHKQspo1GpKhj2CVYSiqlOz5C
 E1Ty/AgVyY+Jwc7oa/2GIpXxmmuWnm7GKDqOIB5MhOztkcPbFfDxayheFXZrohbg62XB
 3YGfCksc/u4epg7xhLM7TDqpQ+iPBG9DZ1GKR8YPry+Cy6xxc3eNwJo8i/lrFtKiW6jo
 cGlkep4oOA/E6A9HY5up7IdKcLTpd0CCE6MyIWeYwwaubVPlmp8tlZkmdmDxBBQDLqFu
 FnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fyyx5l8JBWdsh/vzK9XkI9lqTabxVOq8Vrtc0Hw0vUw=;
 b=dofmsyhcbjDWi+I2p8PLxtd2+tWwaZOe8Ug4ofLEvfiM2FlRV2kt/67pfy7k5rb+5W
 Eo5U7zvPfICoOjSMvrL3W9qI/bGxgM4pAspPuCVDLRZLa2kYu/hT+6SwRgJRBxHa4O+6
 Lb6eOWGI63bLVyUlP5rf7nU+UZ+xhssD7LGWf9j3375wgLweK73NoC3AC6RvixQE/jP4
 GMM+CkR9GUQgTgkSzBPQmu2KLy+Gtbq5H7ZZGQyrgGIYNCWs/a3qiWWK/Msb0e5n/35o
 Ef9XXmliXMb8W3Kxc3FU9MMR/NRHuAgFdo0sVaJa9nKVau5i9YVZjbG8CW1LaHIS1Ns9
 RStA==
X-Gm-Message-State: AOAM533nSb+ubKXZgwKPR6KRoYs+PeBENVRePtnz/8EPU865pyM+68Ks
 CbikLARZ/ZGQzPnKildz2pQ=
X-Google-Smtp-Source: ABdhPJzhCkInkV1nfo/rOzX+w0Rb6oz49Qjtqes/TFI+PpxRKs02Pp4T3OSKhx5YtGjO6CHHY4rWlA==
X-Received: by 2002:a17:902:d715:: with SMTP id
 w21mr10488997ply.197.1597654968699; 
 Mon, 17 Aug 2020 02:02:48 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 02:02:48 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: duncan.sands@free.fr, gregkh@linuxfoundation.org, jacmet@sunsite.dk,
 balbi@kernel.org, leoyang.li@nxp.com, johan@kernel.org
Subject: [PATCH 5/7] usb/gadget: fsl_qe_udc: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:32:07 +0530
Message-Id: <20200817090209.26351-6-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817090209.26351-1-allen.cryptic@gmail.com>
References: <20200817090209.26351-1-allen.cryptic@gmail.com>
X-Mailman-Approved-At: Mon, 17 Aug 2020 21:23:58 +1000
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
Cc: keescook@chromium.org, linux-usb@vger.kernel.org,
 Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 2707be628298..fa66449b3907 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -923,9 +923,9 @@ static int qe_ep_rxframe_handle(struct qe_ep *ep)
 	return 0;
 }
 
-static void ep_rx_tasklet(unsigned long data)
+static void ep_rx_tasklet(struct tasklet_struct *t)
 {
-	struct qe_udc *udc = (struct qe_udc *)data;
+	struct qe_udc *udc = from_tasklet(udc, t, rx_tasklet);
 	struct qe_ep *ep;
 	struct qe_frame *pframe;
 	struct qe_bd __iomem *bd;
@@ -2553,8 +2553,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 					DMA_TO_DEVICE);
 	}
 
-	tasklet_init(&udc->rx_tasklet, ep_rx_tasklet,
-			(unsigned long)udc);
+	tasklet_setup(&udc->rx_tasklet, ep_rx_tasklet);
 	/* request irq and disable DR  */
 	udc->usb_irq = irq_of_parse_and_map(np, 0);
 	if (!udc->usb_irq) {
-- 
2.17.1

