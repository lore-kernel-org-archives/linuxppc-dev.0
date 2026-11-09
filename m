Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF7606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vQEbEEng
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6X6Cfwz2xwL;
	Mon, 09 Nov 2026 14:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196276;
	cv=none; b=FK8mH+sdMK3f/OUHRYR7jmswOIFlKNB644Z8oa21BQozQuZ4n0Y1fIJmPStL8ikLOwnS5F3NuFTmKcNOQYyt1g1iqKVCemCT9uZkcfin9GancGcTV7XrFGyaQ9cJ3aHRClZ4U7Jm5qbPrF9b/cQILl4+tooyOW2ZvV1m/w2nZz/zKQ09lK/WWF+JCu0CU51xXLR27ZmWJLI39wuWd4FZQZRhMdgj4g2oLaPkaobWFL5bIQ3onX7Oym+TfVxnGnu9wlWZJ/LUEr+5e11wDVsVEOlosUgD1E4f6o8nz2nni1w+lt3G5wzQQ1lLOo/bnN0CBbFMXF6nXCseuiXUbNfFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196276; c=relaxed/relaxed;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpKyBa27aW7LcQqdLTBqaafhc6w6VSULP7xuvFyQPHiM2x+x5Gp6j0zfrxZ4UzeRT0VUaRsw2kHr3oMDF5EO5H4t0G2JQx7hgpf9JcErIfhhpEVylFz1azBIUWx8g9tSTyifolcUWv+Lk5J4RroD2hsNkAq9MXdIBZx6Rr3kuqJHuWEbV3zVXCA23blBB177u+HS2ykovo4wFqi7wImSBhWF8dfbKa25XS5BuDeKATKInFrCWFh43eAgDn41SFORYtI4GAEmYl5KVFwOKs8jBc5DXH36XFxHZ+hCASwC7Bvw36efvNGtAszIqZDVtVZgxArRIWduuZx5/baJmJgXAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vQEbEEng; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vQEbEEng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6W0mwWz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:14 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7f84a55e31aso210155a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196272; x=1794801072; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=vQEbEEngVuvXIh8xUxIZozEgi2xRIVAq4w3eIOJn7bmsGGz9TPY7J18z6UtR3Fz+rB
         Zz6v1uenKiTPqVr7laZnGoKwzg4vJcLvcZbkXNN58hKp62bOVwAmW+Z1K7shfPemnC+Q
         JZejXOALB+jE5B08N8xGxMN9urqlp617xDE972CgvYhfwruuN0bkPff4W8b8skdXmbxh
         85ORn0h/uAWw6yIKf11gZQQUH31C4KFHXaqznwGv1V4hdl80PpQ2x5rSCIzE/hoKVCa7
         fAeaR/K5XALFelHrSDLXKPdnGCP6UX93aulxlu9oD/wV7v4XE3eyu4kImzN2rPPxDayS
         Y1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196272; x=1794801072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=2W0QwXSsWS1iKc4sY3d/HUwfn2fA4xHIKgnE8+lwLiiT+OhUt4hCmQgd7HZZBc1krm
         IVZ236dbm5mjWMFyU3KXQLhp3Ns/n+q6+6jhxoWbEbVutXHr84IELUVJanb3anKIyj8m
         WqNgWcfp72CDrL9qejdF6Q6K5qKDzlhKaINgWFTNii1vy/OYEKGHdBb1Yx7A1jaimcue
         jWoTj60l8gJwHvIPIXjIkQkYF3Pd/MCX/9O58zsLLxp4H3PhuCJeclTtdsh2gS/ZmxVk
         6otNxd0DcGnxDkiNGtBw92Scltn93Yt6rrnUPRAaF4BTRdO0aU4JnnAaHB/uepE+EJOa
         iI0Q==
X-Forwarded-Encrypted: i=1; AL+hErEHpCOWWKNGhv6/I4vyhMYX/oiLVFza7RMKxFB54RcSo/qiKKjCTrt9vvwPGO+4T2z6bCfdXUOkQWrRfFs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9TBRGaZ51USZY4tNFmf5S6x5sw6/w9o6/tL5mOLJNHNHIiE2Ll
	lZzd4R5WgMwF0i+42fpTBnGoEF9lfYbL3j8AnZCwThlSbqbhr7XzyY3XBK4qrpXS
X-Gm-Gg: AYBFou2oq+h5etLjR1e3FzoZyRugZu+reQdULBGz0CAU6Gon1wks55oObRreqOhdDZN
	nLBdaD1wL0IFnXS6+NmTxqRTJ6DrJL396KS08+bRkeDgeYbmCj7/MUK26DegUrlvOc35iGUWVav
	jCW+PSYUzRGaFINOsUoEZwvoSXbdsPcDaM3Rc55G+YpCA9p3TufyWkeHDDNCNlM1lJnrMTOWEjr
	cpeD5iiHSuwR6fLaZcjj9KNO/tmfz3Kv35x9kgD6fMVlHo6+KwbJHDKPo9TvmTvGYpYnFAKQMbq
	UZROxn1yXlEjdRtAepQdgRRBQWk+6eNMo0TWumicY92SyDV4hqArVUtTpb2pyVaRLKSvzMoYq4v
	axdbLr6hjh8IS5NxNuxaag1BapQDn8awlG1vXLae2A28mlORfNMDIeiCVZkDGP7vetI2faEso+4
	GXFFnYLWlVLfFq6m0CbGT6Woc9M7i0BUqKF7ol05c8fXd0TScBnaQ+ZxOA+a0GH5LX5dk54jC/Z
	+NTxfoFuKfJQsMz4QDlnbQC4Sj/ILxsRQl3ai2lW5xwhGnuQ3EjFnaG6san/8oTwJ7ZxOpLYDsj
	do4RBGIwrbaBvkuqJtVuCIQjO97o4E7Lsc7A2750MgBhtI4mPZ0JkM8VyppR3/WhYSj+/T/Qs8x
	HDCW3kcpl2PqH4YREEI2PoajQoufWIM21oJrJAdRqW/NXr7nyHcGuQeh7MhFf52sMF1Eq1HUeu1
	7gHhYPmsOVZeQpSDZJNZjxZB9DW7OkEWEq1ERvJf2TzMY8zaao/+5x
X-Received: by 2002:a05:6830:2b22:b0:85f:49ec:c96b with SMTP id 46e09a7af769-85f507ef5eemr2216062a34.16.1794196272163;
        Sun, 08 Nov 2026 19:51:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:10 -0700
Subject: [PATCH v10 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-1-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
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

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
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


