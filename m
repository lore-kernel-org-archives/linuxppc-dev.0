Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528F606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4U1VFUE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDn646xswz2yjp;
	Wed, 28 Oct 2026 10:39:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793144396;
	cv=none; b=k41rs8QmEz9fA5BRKEJ2F6MnWT4sXs8a5LQigbBW69UHet3iik82evV+JwbGEILNheYfJH0oE5WGNt2zTyk0NAyqoTYNM5xYy+WcLLgjOnpxh0gg8jJrytKJq4MkuOac+DoPECEr6hwoCN1YLu59jhtUKdHkc7o5236veg69jIRztR9F8R+ESsl4wjSQhzyNNN8oBHnuVg85Rc8s8id2AdSnNh0csdvEh1XXRN+kAbjkytCh0DLfXLhXcgTylfQMKNLVJ/TpmohQ0zF654ci9KgSHfdNjUjO2vvFommk7uFSYdW7AS4vpdyG22cjYntaIrDm9J9VKqNi/b8VhTQclA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793144396; c=relaxed/relaxed;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhM9TbOhslqWowV4BL+E+yl5ESw7WfVSdOeKdw1fBtiQ9K318o7BQKDkde7VxgFo2OybptCah+K8c9fXGl//ZsegpoSaHjUu/Opftv06bjx269HGMf5Dmx9qv0uqLpwzoxFj662fTSzZUKnHtc6dbBPi4lZLUbqNN5dKxt3YBHeuHzKXr2BoWobeUDEpq3m2XpoZ43leL0d+EcifRsONzK6ty4eCouN5SDWN2yUyihuPmUxwC/oH1zoowu0Uoe1Npy7EXIzByru8lMUe/JhV4YCdlSCcCg9/snSF6qXLE0D6MZIQJ22fVkRJ/rzmL6gHF3R0ofJ/wGPb9O5THcZdxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4U1VFUE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4U1VFUE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDn640gwSz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 10:39:55 +1100 (AEDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-84621d8c7aaso204071a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144393; x=1793749193; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=w4U1VFUEp6KoULCqsDHHlP4B4jTDp4edvECKwgZ165lkZe2ebReTa1/5O0AB5EEph0
         Tkt/xvAhLUwgVlluw40Fi2ozPpF57OvuRs7nf0otLsznnxtNHi2iN4Jn/365RvWQr5oP
         pd0W8rYa0xQX8XnyQeD2I4dEYAtCSqmG2pbGxHISwFAvl4HRE9rvTaYhNcrmJ8VZY+ui
         j9J8ntshvsVB11X+89V1JLpZSTP/X3QoeS45H1EZLDQHVFfr+DiqfiJghwdzAvXuBIq/
         QcDkSSU2ZDOCHeJNta6+hEF3BemfjKYYhaxLJlqPO7wrmtGcOvx+x6kr9gKcCDGEC95l
         eQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144393; x=1793749193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=nHyImGrD24wP9PkjF3JUfZdDf+hXWHlndYikAgdAVlh5XclPB+yjqNN0SkEsAjoJyw
         L73VkseWbSsMo/BvOCjv3D3z3FQ7fKUyCMNoWZpTsGExnokLHdDZQ4Ivhk31App0gT0v
         CUS0HCsSlqheg1eDFZNwStXOPYdxPDyh3P90oai8y5bNgyjvJhuCoa9J0QPsThxZt7tF
         4+JpIo9RBU2Kxb7dAGuX0ZpJNhP9erwT/QxjHbSJDerSfplF8+BIZq8ZDAUg3Dc26EF4
         GxRVw2IxX0F3LS0ou9dsnsgbznl6d/eXIsZCkEa21QV5IHbyv+T/MCVdbpQkCBte88zA
         sHDA==
X-Forwarded-Encrypted: i=1; AKwUvBx56kikT80DeEPhPl0hvDBLnOxnRsxhMQuZDd1GLdymDZsj2KOLPHkXruQUQXUsPycZ5kKgRtWUpeCct/0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIov6hd/3Ozaq8S8GYYWmJJdTyLjI9ZKk9o12NppDQq+s/9MkO+
	qALeAzMn5ENBNR6N4+Xq9/dVUG8lKt6/6bOyZBA1n0ChUU3iU7qLpkrW
X-Gm-Gg: AYBFou1A0pN39sO2quiPEUdcZnG8S9rysU8gIoAskyP+tux4yIiRaM/77pq0WiYapnA
	VycE1js6jAZHA9HlvS1/6SDWH8tFkziZmrbwL+Wiu4gJYS4g+x1uuPmFzSD05C3fl6MtYkOmjdF
	uq1TOIzO3o6zECncQ44oqu7uLVDzA3beurtoZIl5ylXy3Fjh0WdbZFj33B5/C10GYF8ieMRjpae
	ke7MWRx6kpwglY4vZqSW1FGvH2uDu8bmxnO+gp2ZxVdetJm64q0fjOct/7UbYV7FHE+tOAwY70D
	EB8nfyB39Rd2q+S7R2PYlsXE7l36uBA0tTm+UpmwJUXLG7WIvgBLVJnJyW+/qy/vyk+XWtl7WLd
	/3TbCW3inFRWpBJJ6T1s98GQ8j0AxarCvOQOdoNcCaLoqiBVoY8cusc53kWIifB16fiv0pk0obm
	GWLxAyFjfpc6kpFGIiu+Hc+0zrlSzQkIE0SqKL1/ImvFp3iw2c8vHZJW6OB/2XXRkKJryolBgSt
	0oO8z6h0mG0HT+Xv6kj0DuDCxcSS46yrqxyCZMV4omt04O7/9UBUndrzCHy5E3YKv6XFcy9Yieq
	O+OuwnvdFMsjlGFL2OZY9AOPhYZzhT4pR3Q74rrDKv1/Sj3i1IIQTDl46xMj4OM5F3nyRxEyMqD
	uCOnwP4+FHzpw2TmpaJvZNUFPOOlTPQfW23hHlrMoLqwWZKZqvfY92Y2nKvAQH9G16rVGSXEjqR
	mEMoc=
X-Received: by 2002:a05:6830:25d1:b0:82f:5471:4dd7 with SMTP id 46e09a7af769-85ac11bfa1cmr895947a34.30.1793144393599;
        Tue, 27 Oct 2026 16:39:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd31a6fsm62836a34.18.2026.10.27.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:39:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:39:46 -0600
Subject: [PATCH v7 1/5] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261027-submit-serial-8250-dma-cancel-v1-v7-1-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
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


