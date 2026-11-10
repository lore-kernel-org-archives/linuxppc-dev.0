Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2C60A2624
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyTKNIVs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNtGt6JHhz2xnS;
	Tue, 10 Nov 2026 15:00:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794283238;
	cv=none; b=gsX+Koq+zLzUHba3z4LXqUdTy3xVhP6McgAJeFxD1ZcqLtV2loeNeUURdeNYhbRTG4ucE5FU2LkNCjCP3kzOpc+GRGbjQx7e0/slhJDjgVOdp8uWi3/2xXHfjiEJIhWuIaTwgHuwyxEdVmW2gwsymxcww9noIUIe2dIrLknWGjOBxFcob6/RjIqmryi/p6kgWQM7ceuvGzQDx7WR7ao6YTHg2zR2R0LCaqYS3QO1tiRpMWPkxun0f3R1k3i1eFfaVHL1jKherIbKdBmiZN4lmI86m5QoHmjRUMOJJtgkkH55ecNPWH9KMSH1sBgdNVEscDjAXE496/1kCggLT0haIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794283238; c=relaxed/relaxed;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EL/7gQLYRW1Oy1abw2NdsHvSMcO47Mh7X2Ltq/lm2vrknERqA6ba2PFTmJOrNM4v+WaUbpF3tJOqhIvSAI/7FAgr2hk0vUIChZIj4De64+O/pM0uzQS5o2vtdeXih4j/NLXOZMmPJaTLM7otaaRLXVXRIaHU4rlrPMGydfE99ty1dxAZuoc7c1qfrFuC3uLb/w+BJWHgnJ/I8aP6nZWN9mEkYc4+BWicOm5phG2E6n4ogiCqNx29CpZGQ05N5DkRPHDUxI4B1VgP9YGJ6jmpxGDrjBHD7aB4kry6IQ+jrim+ipPNt3POg697WSarN6fwATKVCUHvkaEyAYx7B9FlXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyTKNIVs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyTKNIVs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNtGs6Wwdz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 15:00:37 +1100 (AEDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-8479f46ecd8so803283a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283235; x=1794888035; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=EyTKNIVsBjHIsyn9GJlsmKCRiCfOiqX+9R2S7uxHAIInRLwfO2qWK13TnzfQbJ6gSr
         oDSf8f2yGewOv57cWoy6A0fSLGZGruYGwRaiLt5Jlz416O2s9BLWU4jYvhUZhIMCgso+
         CTAGWsq7hDzAfzXwrikxppE4NAjXJ31QJPFHcOZ8qZ8xTq87R74vtMnHvFsc49O6eg1L
         Obr7kcM0qQpzAzGQ2KHvNsdplaUG1MVMT+8EAkNdn9UixF9Pm5Nr/9QEYZf2hmO+z/TZ
         X+T89cRiNz2P1DunSc5NPkFlatIjlc5v4oe2fQxAfFnMSAYHirHk72Agg0psl7E64y7j
         OGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283235; x=1794888035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=DH8U/CQZtPM1xiSEu/XU1thk4mfLzMfaMpLV+cZ9jeK/TPFhbDsI2ZXPdd2Is6b1uI
         qyK4G66RTjqAiEDZ3kmsuDRajZvZ2hryL9KYnBQYVjEeaa2ljdOMWJbKXLbcks3A3ZI3
         VxCV21ocVL95sJz4is65H1Kz/6yCYCyTcG5ZM5PlMIhMzFleC8ahcBzdvOlvUe4ANZof
         PAzcEaT4OEwe4ovOOqZWw9ydhBS4JL5y9SyRq/iAvIVcJEPEDwRTyLPSvH8vdCgKket+
         HLTA2X3BOMs0LFI51r83yZW8N0kLGCDSOxVBzDiXtiYVEbRpYjw0HnPngP+Ib2Nnl4DM
         RVRQ==
X-Forwarded-Encrypted: i=1; AL+hErHXoFeYheQMYm8uZ/zTgkVUIycCEcMjYPkM2SFeLs4Za2WQriip6QSV4usV9xm45vBClB5j7YGfyscPwgc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+addQ4K2OiuF995nAWSty8jjt0Von7MsQTtHqfpnE9DoyTLV5A
	xWFO06kWioTqi3DdAo+x5AM2GWdO6PCUxsSJmm8EPR8RawvVCQtQeIE+
X-Gm-Gg: AYBFou1SUCymJVlP/QI2G/lPtCIE+KyD5sp9i5UTv0d7QsFfQOM58hiPmyVQ6qZEbTs
	hprreFgYRv4/IMVqVf/5f07K8lAqY/COKmtjX+e1ACHknvEEglGXHL8/bv6pHJOUN2JpFxqu7b+
	Mzhb9/nivhaSp7GgdJSUEZdR0aMIgcwFtOyQNG/48Ym+qysC5I9JadwiYmARBzkv9gLhD+dUSfb
	1EFeHR5tj3KXm1WdqPBuqoqHwA0yoOeY3QGW61FLUWLozbFFMqbvKtpEi2Fbh4M+gFsyD/dD0lz
	J93bSo2FZ1a+3KAC9cwwZljMSZmg74NZK4pmTAEYvZE+C2TTAH7ain/kCb4rDPV8BL7KqsX6eAV
	9EAnSVAyvporHAdqWusgehMm8fEGR4wBKgyFTHBS0fVE4yNtXTZtduFE+Zc1WnbHuKK9nZ9tjl8
	X+D2k76jbZlQatTjfZFDLGceZKQAXzAATyWebmqy1Ky5AHsKYKhl/QFKn/yhj70r/XdScdVgOmF
	QQy4K756aCIXyDMkSBzkFz2CcQr5Er/hqx9EG+941hI70JJy6vgFrKuykDif3Xtra27vsgoWEyG
	gTUIB0mdl5KuK2H4QplZW48jVky1Y6kx1cFSUbmggaVKMeimtLMoZkmT/z5FkKtwuCebkrT7Vv4
	a59Wazj9Z1JlZafMVDgKl6xxfyIP9mf5VwfCbtq5Fy75+GwpXP3cWjbxaJqL+NmX1gDdWkSEfSp
	Peo3bl4kzMRB5cHx48abrFT587DDyX9he+iX+WZS03iarJ/jx+QFrkhmYGisnJi+lwh/KlgzzJ
X-Received: by 2002:a05:6830:906:b0:844:4959:e856 with SMTP id 46e09a7af769-860dc7c3282mr1426887a34.11.1794283235287;
        Mon, 09 Nov 2026 20:00:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:16 -0700
Subject: [PATCH v11 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-1-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
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


