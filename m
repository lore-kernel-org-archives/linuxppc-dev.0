Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E706606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DrKtvsdu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBsXN2cL3z2yTH;
	Sun, 25 Oct 2026 07:52:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792875156;
	cv=none; b=j2cyjjsB2GL5HaeRS0Rrld6995IrVzAbKBLBeM8vZLaMnA3UNbQbB5nzNYn3SRjNHkbDv0AnzfavGfOsst23TZ71+vKDk0pGcjEH6wk36ilahNcSfvYD/NNlHumc5daXVNHBijF4IxOOC/6agIcApwBZMYXqZoosiUsq5HRBjOvdQi5uehGN8RMFPRh/ID6C1L/ERJ+PbZrRAtnw7Cv2lPFi4k2V8tjDw86ebZnAOQlNZ6dq1rvhvRq5fRaj0fRlVC46JFF1Grv1quUvAS0IQFJSiUiJBJ7reLODdJlipVsb8Cf6nJcApt5RqwF051al5oB0mDZ8fPS8TZkollQxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792875156; c=relaxed/relaxed;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3gGOOBr9HyJZDLeGIiFZyCvK97tyi/qvql4dlj4RrAsFgQ4NELqPmaxYA19Rx8qOjay+9YkJ6Yl/pmCt6xzoLgG5rBvpHYq6+VFQ4oHjxNGP29qhQGRZo7ejdd5tCM3/VJ4QUtUT3AS/tVHlho38cIFjH/AKob7SP/rdnuzLKkyaPf5e3bqyWsj1oGtstyhfa5AdDggt9gp6LPjvi6JVfrNp1Om3kg5tGoy4bDllAnLIGpp+2aPCG3ZdKkewuuzbYedtD+aAxnzs4ZxZs+KZJpmTGpYHDDKyvOC/egALXNL4A70Up4wIi08GJJ+DTAF9c8DeHUd+pUqP6+Ffy7Lag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DrKtvsdu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DrKtvsdu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBsXM4mJCz2yFk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 07:52:35 +1100 (AEDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-833e671ee9fso1689262a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875153; x=1793479953; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=DrKtvsdu12pcCD0z92YGOGmok3NE2KG0gKeort5x+WTAmIzuXS7qaX1lyt4aqL3m8V
         mncmY8lvopUs7gjm8opYAo2hGdsrQntWJhtd5RaqDkjwU2L1NBcWAEFglHZG2Ugmo0ip
         LZUo2Sosh7JPbE/a4ImZcgyrWHFLv3NZ7pXPWwS9dyul2pg0Cid/yKIR62jYTcYlI4vV
         SQhmJni91/D8nFRu+VDbzhivQ6X6OXK5dYgVow+h2j0diXNYfpCoQO09rLJbtkEnbFzG
         M+kkpxDhHPx0Gaw4F5vqAPj5vOybxqtc2jFW1qa4B93tYuUsWAiTX/BjVC9r/I3zLYZ+
         Vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875153; x=1793479953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=L5HoS9jpLAo+SzaUvOQfkJh3kntR4n6nAmQVB+Y1M05eRRsAFoFiAr0rIKj36H/+WU
         o4ClYO5ZJxM3i7qvvE1deMyYZWuNzQh0Sa4aFEBTcmKPqSL0VdOuJgeoCpD1DflPQiZQ
         3IBa8eeVXsP4nGnSD1F/MMAITCpm1tiaR+nC4YEgm6otVtZeluUU5fldOQ4zBltLQ+iQ
         jPLjduegAXgbKdVP6B0aKdlv5NEHUpoED2mE0R4x0r8gSUDZ218E0+9jHqYoUWaphRAY
         miC/vG+8AJnG4CK1Is40TsGrEpZBjpjOa7P+AmkaGtFdriggwEk360JVDtBs/WPplVHj
         q8sg==
X-Forwarded-Encrypted: i=1; AKwUvByCcl2V/d9Zb8hNuTE3eYwrY6gDBtBRnrkT8c0EGqvKX0l9fVojETgC/MhhOr+xVHhAOFUNzXR3P+v107c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI0uAroKTR0/e8EW2MbPWSsSxs8FOoekOfenfUQetXUhCXHgQVz
	ulohOrAQ1C2ZEtw0XYDB1aFTWhIKh2Sc6U1TgqJPN//3M9p1LPmBeihq1oQuryfN
X-Gm-Gg: AYBFou2rjedxnAJSO1UIccv7t+flh8qOVTpJqHBJQ2Y7T8Wvg2SfS06YIVsQD3R7oRt
	WZmk7VGck2dfZPO+9XpDIAVgeJn2EnhBzAuudyUn2DgQrrpzVpteWzE0Kb/yikoqjczRzlxis2h
	IHamKGRwhbN0SZuDMY9KYP20hg63vN1NZeTd8P44qoT941egjjv9n8N0HjJwOFQJLOGGupxNz95
	XQRl8muOKbcRICvj9j/EB37Cu3VUZjMSl6AeynO9fAI+aNNumMUpt6HrRkzjYivqF/RgZXf3AMk
	YxoI0SGENhqAi4jufm4SXZxkzywU9Kp5tAKyVY4nG3g0Se+78+uYOTHEdbk3iXuKkEPp0JhVMcA
	MlJaS8UUWvgUpAolKvNQyGxhFcIB3S0PxRFtpye7sPgl0h3q9GxOE5cKkvkPzCmNyjrtWt5dz0B
	CAbSiKmZjz3ufq0DVXNrX/hVDGXlwGsr+emFYyrmhbd2jPNo3FuOmFayE51MTDTgBFA6s8WtaB6
	ajNyuEa+9WfmQaDYnmLn73oiupQRTVsCce/H3+pDIWYtffS3q8OF3fmfgtZZv4t2OTPo+s2uRax
	Wu9wanpJiu7XKCg6Hi6cV9cYC8a/eVpHrnSnPpbU+JVwoX3YSapSGVUwjb4Chp0rhG+N3F8JFgu
	VH6nbLGJvb9ys92Uj7HcjpTiS/xifl5jbIAvkW9fyygG9ax9FiMZg8k4VXLfD6H7AMtMENGwoj5
	EZ+g==
X-Received: by 2002:a05:6808:c1c8:b0:549:a550:8acf with SMTP id 5614622812f47-55c003426f1mr2007470b6e.50.1792875153162;
        Sat, 24 Oct 2026 13:52:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:52:26 -0600
Subject: [PATCH v6 1/5] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-1-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
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


