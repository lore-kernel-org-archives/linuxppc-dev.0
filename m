Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E2606D81D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9CHcigA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJSGB2kK0z3c4t;
	Tue, 03 Nov 2026 10:14:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793661282;
	cv=none; b=ahQymu3P0reJXWvsGdtprTg8yy8EHSM6Zb0+xUKgd2vkdJgKM3J8rfrKXEi7Nf/URwK4OVZlVviP7XjkJyZID9ZkOeyZNsJtrfL1TxVgSbKMd9PsQCMmAWTVUleEABKx74BlU/vSCyQwliikFZdXxHWdXHM8nIudFeNB/DmDaavO8hZtKlaE6SG/cQmj+LtEny33l/NxfSDFPcP3tgJWSAf/dR5a2PthhEteaNGL0BrB7PUI+QbiYBSiW9h6eUUi5zBL5Zz9d+0dJA8hIlvMyRzjKcKSpcZfy4Uu/vV6IOGoFhbjVv/0aq/VhlWjnkWDrDFgGMtlRXKuktFqGjHBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793661282; c=relaxed/relaxed;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKN/CXfwq78VTVR74Tg0gG9hdzTxo5Ne8M2qjaLrckuFUZneLyzD4q17ZDl60UyJQu67gU+H2oqdN9Dy6JpwY+UOwjqceTOJG175z3m+PH2Jp40KdrvGeu6mck2+sBZlYEVhS/e+llrNRsMC7sfhcnqndPP5JbrSR2uB27UPAJIi8/AxGjMBcTLtKpnXHhflwOjKJjF8Rihd5eHQWQfdrGSD2s3jD9TLVOSLKKADH2o7yjv/KNjZaMrZEnRUNhHLv3mlKEzFjf1yro2ajfC6VdgQsx1aktc4Cgjoy6m03PBaYxZlVBn4tG73Lh3Lnj5noZfnPfXXUGx5qJ6WQlubDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9CHcigA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9CHcigA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJSG90jFWz3c4f
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:14:40 +1100 (AEDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-703be215729so1619011eaf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661278; x=1794266078; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=u9CHcigAm9qZREPSw3hHck9d37CCKAYWOJYZWDVTWP0ViXvRmnTveHXgEHNegO0CoR
         2JswhuSffxwoJ+QiGI98/vO17rTN2OX258e7Gl4SWxBS6iwdqnNVAwIa7gon6qq4pPR/
         VkBHz22pxGbpmvizx7T/cmQqVN6VZtz23lBNppGkbz1iPjlMgZb2oPpngH4n7tDvZxT7
         Y8HeuKNjVyvwFF00Hf0kY3gJzATHzVMwgF0ICNLmrkt4FMF/k33A4+ytIBpT1H9vZnmM
         kNTStfL6qGxYHHQF0MyuoVUct2u2ZbKrx9wrriZI9OztwbfCxtw4SjRxzJFgaVyNQ6jK
         gwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661278; x=1794266078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=SUBUVUSw5yKAB8SKAjsAjhEiB0rx071ngC7FRrK9qarHgohY7axnx+Twxuzwv+DEuP
         UAC7Zl72DINZO/yOPn0o7DXTQLv+JSd2LYlgYXxtieWwaVNI5SUrGPoi2KjLeCNcDCvk
         8ZQQCallCT2qSyR1px9xRcmBfAXWTTcOl7o/CZinJV7oRYx3jVLsFlK6a35BuDKWUTs+
         iyWUR5dh4fxyqH/pItm5Xid04QOrERSriniECHws16R9yEan+1pTKdpOcWAq0xk06L06
         1TgWmzDWRHVajU+7zs7twpP3eYmHrPxJldxeDWjAQS2u8poomvHyViVQqrJ5WtRvQTH7
         zCMQ==
X-Forwarded-Encrypted: i=1; AKwUvByspvjeaX1Me94c4vrWt+Nxgg0KEYWL6xlTWEi5Ufu8uLf4OXd4X90u61W+FiaPM7xZCHiey8X22/M4msI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLyVP2dsqyOwGaFimEese4Jfgy7M0BUzLWhfUAIpRiGMiIZWdXz
	C31wSk6PAoecUoA5FLW+Xy4HOozVsQXxHudAhwby6jJRivUEc3K1CE0Q
X-Gm-Gg: AYBFou2qczYaEVEZmjsZhb3+NM/jpkNrWCmWGD+aoXPJF3VP26VP1e350sTC1SfXKe8
	6eF9m4t4cNivwvcUnQc2ioUQdA63wXZPHgb19iJZPzsH/WM1+CO3xWimLcEeOTbCCvtBN9uK7FI
	PgxZjzdmPDJjJtyauwykU8bjeKJhzSLUZ3IYWRIljVMBypSMqL3TYkfDYh/hY3xSBeKmMR3bRz2
	8CRNxUIffMwpXW+G2RMnQpgamA3dZ8ycLNSEdD5y9xKtjZTiJu1HkIYBUsth/tT0zkuvbr4BB3K
	qYbmXdZQbYK+nPFGQgRvQCt/BWeGpaPS2kXZXesHJ//CcvnwulGg/VyfxDIh4ZOu/m/B0EAcG9D
	dKo2z8UJRrtPvnWnPbo8OFmnTx6buPRgelh8OZe5GLlFLADk6wmhDzFr9JBHC5GJBxdowk5D4H6
	BfAsSMcv9i3cdFfF+ABWByaSivTvdqgeg52WhXTQSgi5EknBo5kXmbyYcPYWK/K1RpNP+XisjNo
	dMKwdxj53zNGkpmw/uu/3AL8UfS5Cpm/4RbeJLCkXJhwV9h7eUhSVM0uzx43KcsMPJzixTQevdl
	+glA+cKrUZ1NAc0uwWUV+UXnKtjGXUPIARIH+DsWaK7hxyoDR+bF1Al+E9QuJ23nw9dd0bdGdWV
	0eMw1sX4ZmHarsGgR7mqLa0092sPKlkvBnGZunNTSkK8+rjOlWbidfDIaPrub5WnHd3iwSZrS+2
	M2WCMQ6t5fvb4ON2nrB6j2t2/4mhnfbCvQCXIk97f+J2j/00Jkg4c=
X-Received: by 2002:a05:6820:1621:b0:6b7:8396:f3cf with SMTP id 006d021491bc7-714f29e457fmr6317068eaf.49.1793661278004;
        Mon, 02 Nov 2026 15:14:38 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:28 -0700
Subject: [PATCH v9 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
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
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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


