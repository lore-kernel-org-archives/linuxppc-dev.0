Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17164606A33C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw0sBZBt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFbg30LDdz30St;
	Thu, 29 Oct 2026 18:37:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793259470;
	cv=none; b=Ke80CsZEkqwZXbxwVvecIZrnIbtei+XDN0zjTgxiIxw3RBz+n7WmMw8EY1Yi//MCSwXx/YCz5jYyCX2MUwmcXzscRswq99jX7gKIOEuYVcLbT3rYZtjOEV3hvDCojJKFNZT2GkKyAZF9kb3Y0zrajPyuYfWWlyc3d28ScVQ90oIo9YcgPplt3yL8R1NIEdwDbiu3IRGtGOQMnQAgGQDxMbuEVP0NS2M/aZjTBgBnvybaIhjJfcDEBNb6t2tj16N6KK4CPfNQdw+9YMqMAM/dXv4+fjKQdSOFh3Z/AHpzUAAevbReUch8wOPdonyefIWS2oEXvypLQgUVRNVDzqEaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793259470; c=relaxed/relaxed;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n09pBw730Ki/beSuh5jvlTopcklq4KjQ1XT+4oyMbD0byV4BTQiVt3DM+5mK+Kd0yTr9qDJX/PkjFWo3cTHTkCkJozAAmd+CWlfLXjYT00bUdwNXMtPxPDTwEnOwXiU+rWTAfyfqPMwfh/zx386Uf/pHHjkcSmhrZGavnaKN8jcJ0DUndqgARnPKaAJW2CqaJYFkanGXatqHQopc58gr/MueLCpxBmWgFqMTO2HErcbL0K1lV8/bnyf5rOKtuwBPXVen2Vr8YJTn1idxevkrEgVmj/iaj0C0Nb1VF0P4K1V73eKzDBXKkhLTY4hScVBieeOlsB1eAgunV0v2X+XGFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw0sBZBt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw0sBZBt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFbg13M7lz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 18:37:49 +1100 (AEDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-55651e7de9bso1096460b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259466; x=1793864266; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=tw0sBZBtFJXA8difsFV+LqsdTBL2Ib+U/C5D400x1ThRcn1vRV7Z3zVXgwUqWFOmh4
         31V/76WTqH2jAzFwml1M5tGNerd1XkXHgUuF8WoLQkBGufZhGpaUDjIN/r8BZGzb+n2Y
         iDpyjlIaB9hBrpdGosPROeSk+PVG4xSM0hpTMbS+bI5zs4ARDmLKju7riOx7mtRQloup
         NdqPV8j5Dllc3SBhnoHQryo0kdP7ne1iAML7fFPBU+/ZZvdwAeghpPcBAnRgKCkuhsts
         nL4pqCXPU5eQX5GsBuLz/Q0spFfzjQwEZV096Ae88sgpVB2CzjoUsI0BUr84jy9O/j0/
         d9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259466; x=1793864266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=KgKm2QPx7Y6k2eM0k1GfXvcuR37Lh1zKGrLoPFbyOcY6W6052MJAlHvQgDvTUOc8A4
         o2o2hWP/CzG5m+dx8+zoGWtG+Hi9rZrevXHJj8ohavEAjzim2rkO1ASdTJKb/jjaoXaR
         KybY3CXtCWyCm5EtToVCA8P+TaC0ddQT51m526B0QyaA0eLhzQpHHpyFOkctEFUCLO6S
         w8RhtUUU89QTk5uPzrilNdlYAMb6sIUsfgQg4kH57ydmedr3OeLw52bzUaOQPuZgs7Fe
         ggN9LaKxHpcRLDvDKnaRq/tza74oCSC1d6csosM2gpyOfPVgdy7PensO+JXJz8G1uMzY
         5U/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzN3kISqz3IpzaKZs4Al8KKyjWvfw2V6Tuu8CKlEvVZGbW5DG457AM0iM3cLV1EpaUzt13+UOWaFh/TlJE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIYtltKvPUbQ9X6zpJm+khku2tDEo9B6SOqDsjtgf1oNa5U8Qtu
	bJBV7czAoioNen18DRACD3t2eGqWMWeBcEupgFCUwSEt2NW+jXnUqstA
X-Gm-Gg: AYBFou3nzmfGIvEVDQkVn1grDmrm+USy2NyHxpDD3f0FmUpTylc+cI9MPCsUgOzymFr
	pLbihGC9QbgmwVF7w3W9kcGIBGmHP6BMSseJz4U1jJ89O4KDIvCVkx/QblvlGp68aDuQ2nrcrKM
	eaGNYA9+pwihtoRlLO3KLFdPmK91sCA7KfOTLuQmut+z6CuDWJvha8hDi4vj5MNeznZbEzkLz0+
	u6cPRCqqb8aAKtWDzq/XfxEezJZm7EKLoRWRpRC9Wpe6JpuOMjvPj5fsG7N/M2nz7FSwjgxIx4V
	eB+SPCNZRsUaB7cbHKA3OOX6Zt8DN/oCUffZkztS7i2n4KK2WQBSwLC8iB0ZX0VaUqgux3C7zHZ
	k1F4nezzTxgAp5OW0cInck/dvah/2YdpJKid2s3xufbXEqHqDZ+HShWKcv/0NM0U6pAOLZEO56p
	1G+qXS9R1nurBxxmZxXOO5lMfi/DApktOhPm/yzJ1wQKU0wkhYq4Nt9X6q076g3c6chda2llY1d
	KkTBkHvE+oHXUvv0rOGZ8xB0JsYGmhBtosWcPKnJYCXrppDWAuaz/nLxQaOr+Rzvf/XJIwXy5aw
	q24pAUNAXkLtbMFEhDIMVJ58a9kGSjNKo+i9ov6Q7TdhLsozd3GQKT30bYwQfMcOupzophmv48E
	dy2JqQ16tr75i8Q8jtL/5g10VFYRrxiqViNgz70hRkqg/tWxUOBRAUv0gmmzV0Y+vs79cvMztXq
	GxZ0UtgRZ4dtdjEjtZ0OmcuPCULzTcq9kWhwUOz/ZSbPoc4Wn+S+PNwSOhXZ6PlMSU3HP5ACTrK
	Q==
X-Received: by 2002:a05:6808:508a:b0:4d5:295c:a831 with SMTP id 5614622812f47-56384191e36mr3343729b6e.62.1793259466485;
        Thu, 29 Oct 2026 00:37:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c3638604sm3321976b6e.1.2026.10.29.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:37:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 01:36:57 -0600
Subject: [PATCH v8 1/6] serial: 8250_omap: separate locked TX DMA
 completion processing
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-submit-serial-8250-dma-cancel-v1-v8-1-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..b6f108d34854 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1080,18 +1080,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1123,6 +1118,18 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down)
+		return;
+	omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0


