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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6737C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:29:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2053A20786
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8e7p5A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2053A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVYJX1nBVzDqXK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:29:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Y8e7p5A+; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSk85Z72zDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 19:02:56 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id y206so7893142pfb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9gjqpRS8olyjc/G08W3tsbKuo7w0JyAKTnFiPDwOnLs=;
 b=Y8e7p5A+U70fs8zMCX99v4qWd6fhAwzqCgzVw6MybAu0YKzv985Gzz88KVzjlO00kH
 ZAjoOPBR7uVDqzY14l50NCRxWKxebE4hCuLp3K82NcoayY1F4MmINy2f5odh9eHAndnu
 C2NiQKq3ADK50JyGQPJa+npJ4re/v4TtPyhWg9Ji4D+RO3dxkLFyhA1P0wFFg7kTBxd1
 b7RqHitiCauEPujt1dsnfyTsWUKed/bl9Yh7l8IX1Jvl2G6n9K6la8snK/umY1tdQSgW
 KDOIL8eRZTWF6bSt4eI8gJuznMohjSDQ+jTZsbLhNXvtsfB7P7kVvBJ+6WNyPH7oaPwN
 8b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9gjqpRS8olyjc/G08W3tsbKuo7w0JyAKTnFiPDwOnLs=;
 b=IHUcTME4MYrktcSMjOjgFWDav7NHMwiGJPlbktLWUyDBBTYadtNmBX6pld3Ioz5RwK
 AW60+zKhbNju9qgtonJikhTEXUTqlCskEFkSC51POGV/T9tts/06uVb1GBdCpXVj1TOm
 ifIWw5pT1sJOqggbIrnvJGlO2fI9UJuS0AVqdMnzBgQraKZPM8LGOYF0IYC/jHzfiPMj
 XVLlgACiNofb59oXQMLxAKyk4EGSDBvXVp3nOPtRuUXTgstQDKKro6MnJI/mjSzZyDaO
 9BG5deU44ZaXips4NaL42p7nkkO3UIF4qE02AE8lcuET4CifHcjGmeE7rtRPaU1BMGJJ
 0xCw==
X-Gm-Message-State: AOAM533uEx+9bwon8sjJAMvk0sFY2nbt17b4DO1UhM1CgqQ/pDAwMAQ0
 MEnprbjWW6IUMz0CVmYFPZg=
X-Google-Smtp-Source: ABdhPJwCbYSaFDUdxe1jOJYWD7q8rFdA3Zk4x0wFc5VcGkSDok1smRFfy3wXDtC7EEtu4HiZJA6q+w==
X-Received: by 2002:aa7:9ecd:: with SMTP id r13mr7291913pfq.317.1597654973506; 
 Mon, 17 Aug 2020 02:02:53 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 02:02:52 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: duncan.sands@free.fr, gregkh@linuxfoundation.org, jacmet@sunsite.dk,
 balbi@kernel.org, leoyang.li@nxp.com, johan@kernel.org
Subject: [PATCH 6/7] usb: xhci: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:32:08 +0530
Message-Id: <20200817090209.26351-7-allen.cryptic@gmail.com>
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
 drivers/usb/host/xhci-dbgtty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b8918f73a432..ae4e4ab638b5 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -288,14 +288,14 @@ static const struct tty_operations dbc_tty_ops = {
 	.unthrottle		= dbc_tty_unthrottle,
 };
 
-static void dbc_rx_push(unsigned long _port)
+static void dbc_rx_push(struct tasklet_struct *t)
 {
 	struct dbc_request	*req;
 	struct tty_struct	*tty;
 	unsigned long		flags;
 	bool			do_push = false;
 	bool			disconnect = false;
-	struct dbc_port		*port = (void *)_port;
+	struct dbc_port		*port = from_tasklet(port, t, push);
 	struct list_head	*queue = &port->read_queue;
 
 	spin_lock_irqsave(&port->port_lock, flags);
@@ -382,7 +382,7 @@ xhci_dbc_tty_init_port(struct xhci_dbc *dbc, struct dbc_port *port)
 {
 	tty_port_init(&port->port);
 	spin_lock_init(&port->port_lock);
-	tasklet_init(&port->push, dbc_rx_push, (unsigned long)port);
+	tasklet_setup(&port->push, dbc_rx_push);
 	INIT_LIST_HEAD(&port->read_pool);
 	INIT_LIST_HEAD(&port->read_queue);
 	INIT_LIST_HEAD(&port->write_pool);
-- 
2.17.1

