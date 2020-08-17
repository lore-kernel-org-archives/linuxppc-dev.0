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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0790C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 08:40:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702F720758
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD0jFjVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702F720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVSDk08czzDqGW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GD0jFjVi; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVRtn3xyGzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:25:21 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id f10so7130012plj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T6lw+n9mQmkGn1p4WLHa0fO/vue0T8wJx0TGHG4/TuE=;
 b=GD0jFjVi/z5Qdah7xQgj1sPqFYzpZzvzuXxRK6j9Ts6HatcSx8QcxeClItWCnE9yPM
 TneoDWoc1aDFZUV/C7XdZN01xNS5gKlqaWa8qFqGwTRcLQpFjGLZtoeDgvTAsU3Tu2H4
 HxKcwnAidW6Xj3zSP9sA6h3W0oJ406IcX6vPGuUID3oa18sIQ0t8Pv3JufwgJS5rDnu7
 +C3GyY+cjMGWxpQTHTFRgp/prP8LhGiZErDB+Q4h5ZMFbxgxxFxgU7oA9DwWSdQ+YGQP
 TGppYZKTVNwYSmSX7L7A6KlSmqdibrdDbNAeuEJp+t5SyfsggLkehmwHjgLPyedU7cDz
 Bx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T6lw+n9mQmkGn1p4WLHa0fO/vue0T8wJx0TGHG4/TuE=;
 b=O9u0OCUSLlbDSOi8Lyk/quGaXo1t9iBR+R+YVzDOfps25N6r/VUBNU2QKy+EaKFHyw
 hshoSgqLDKuJJ9Q7XvqIX8MVUvlGK0nFfRxEk/vveMT+t1isZUZMtLoy2V6AlGlswTmI
 Kh8iHqhD1xEPnI0jzaJ1sDXW5JKvmxetWqdV1cyau/euSv14vX657/VphXxborAw0bDd
 dyTlqT2X9mAU8xeC2cux7KAYJ+OSEBi9qwGD3fCDzsymb9Bbj7Lj8kqoxE4ZCyP1sLHV
 ncvwhIPMV9CylOCwm46cay1BzA681uoYU5Ml7GUtiPndTiL42msWCxeuIIJGLsfgIF2N
 QQtQ==
X-Gm-Message-State: AOAM5317oV0F6/sHbYCqISIXa21sQRyCX6QwbxKZdBE5aNQhyDIbSAXL
 ndv7sBHpE0X9odbwC7nQDk8=
X-Google-Smtp-Source: ABdhPJwDu5TYQAHATbCMVLUlf01g8fgt2E844DH0xvZjDgKdXuiUZDlH44A95OBtxXadmTX7B9NAlg==
X-Received: by 2002:a17:902:343:: with SMTP id
 61mr7899243pld.274.1597652718233; 
 Mon, 17 Aug 2020 01:25:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id r186sm19928482pfr.162.2020.08.17.01.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:25:17 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
 kda@linux-powerpc.org, dougmill@linux.ibm.com, cooldavid@cooldavid.org,
 mlindner@marvell.com, borisp@mellanox.com
Subject: [PATCH 04/20] ethernet: cadence: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 13:54:18 +0530
Message-Id: <20200817082434.21176-6-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817082434.21176-1-allen.lkml@gmail.com>
References: <20200817082434.21176-1-allen.lkml@gmail.com>
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
Cc: keescook@chromium.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
 oss-drivers@netronome.com, Romain Perier <romain.perier@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-acenic@sunsite.dk,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6761f404b8aa..830c537bc08c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1466,9 +1466,9 @@ static int macb_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void macb_hresp_error_task(unsigned long data)
+static void macb_hresp_error_task(struct tasklet_struct *t)
 {
-	struct macb *bp = (struct macb *)data;
+	struct macb *bp = from_tasklet(bp, t, hresp_err_tasklet);
 	struct net_device *dev = bp->dev;
 	struct macb_queue *queue;
 	unsigned int q;
@@ -4560,8 +4560,7 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_unregister_mdio;
 	}
 
-	tasklet_init(&bp->hresp_err_tasklet, macb_hresp_error_task,
-		     (unsigned long)bp);
+	tasklet_setup(&bp->hresp_err_tasklet, macb_hresp_error_task);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
-- 
2.17.1

