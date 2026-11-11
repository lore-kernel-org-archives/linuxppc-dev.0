Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A25606A8BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sh1T2Kw+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyY32Yyyz2ylm;
	Thu, 12 Nov 2026 09:16:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435399;
	cv=none; b=VkTZy7g2mKc9o/NgYaJ8NJo7CB31309w5iuBINujCOuF/ta7qPEs6Nc9jn+oAh0SF+3Idc7YdiwL2uf5WLvO1Q6If7Z8TlZsHwp/R3IAOwzTv5s7dTWWaDf+/8Q0uvV3lQoKVgv7pbcyyc9AUcsJal4cxSoxdJGigeUokfwsNvNmgbCZIMRT5fnfIwuBObSOXm3x+/9OydH+5g0TYfXRragYKuoLK8S1+q65/bgFdAryvDwGkp+X+eedjIndp4vtxwe6kdIJpSmY7jLE6v2rWpwptUygHAGQp2VgIv3GOvHiwd6947bqz2qTMJkdwenwoMQnYNQrEhfOTXxFk4Pa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435399; c=relaxed/relaxed;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yag1r9OrNgnwvws7+yTXra/0qQUf/xm5ppc0GVF+8Nd2gRlA1tUfsppKBA5tzG2+tXFUNXX87CH3aSO0YRFq1SK3Uzre6LWJJeExpt4XCg8Eo+VRLYHw/2nP4APkTQ/02xYds7JiQPePq3m5Feoy2nzRAXTCCO21BYew3F0yDUIvClnw2OVNiw/GxB84MkySLUbInn5GmdkIqIDgILfImQgcjw58hSI/+JzWia46EXivhXjyPGQocZaAOLHjOL7xG92809dH9QMfQ2PliFJTNNrce18B8xHeaX9nZC2OKNwP5XH+DqFrEDrST+FIj1NeAUNJAae60u+9/JkEyaXk6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sh1T2Kw+; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sh1T2Kw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyY23MZcz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:38 +1100 (AEDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-4ada9579947so2180925fac.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435395; x=1795040195; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=sh1T2Kw+Q6U/9cHTGRGhBeZiQZzRujtPeazSczVvSnBUy7k+M2BDPf9A2BMz4ZRkWV
         UXtDzYvxMQOWO7UhW/9lfpdDaoaTONl34b12z68ZFqY8NThz7k9rshf1/pA9dnKcv5ou
         0/YadOtlB305qiT6x9BdONEf8hyz1GPkMckww3bEtIWxyQDCsB//gtunho6GGAmNKrpH
         aOazM+2B5+MkCekcdDxTsi8dAN39nGb0a9tVrmFyVILNWiiAL9gl/aRv3F7mWBvVHWld
         avhPifGdg+Ju3h6ppEMxbk05GDjQDZUyiDxe/8C3YOw63tkKIJkqboIcS3PvsFu7vTGo
         MiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435395; x=1795040195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=E43BnPDwSBQAyRumCTIdObyuYJrSdf1NGVMtVhAtbI4KcfstHoH/R+ZVLeWGIQSMOw
         eG5vYJZICxVW3oleq3SzhWeLoyYCk+sZreBoVp6Hl8V+AztRf63Ljh4Ue1RGyd/AWSpc
         xoOlA+6yjm5gVwAGmHxRxkaQxd6X+cSZprtX7A5D9BpzP4XfUeUJuYs7p56Epp2nF580
         Z7FrrqN0Kvy55XV81NQuU59+Gig7czvZMRJ86F/a7ErITUkBq7qBqwkV0cJuzEGwD4K9
         oGFFF1KWF+b89I0aW4FdYc/TEhAQxIxRqLi5/Ns8ts6QcScEaVpDxVssg1jasf3EdeT8
         l2fw==
X-Forwarded-Encrypted: i=1; AL+hErHn6GKFuq89a79aHu9FkRgkhQlpJeTHf8MWg9RV3fHpenT5cvFPrj34qKzY4zUgCp5NKaZ42G3pQj2vgeE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8Nwk7Vhcy0AHaVwaThOCyyUX3nKRhY6dJAzKXmWwxO8AD3+G2w
	MOye1DfTIGVp7RLaGaMA9FG3y98D+Ws1D5gbNnsRYu4IJHpeLy3/66vU
X-Gm-Gg: AYBFou2e/hcNRApSuScBjwHgOlUsRsIL9dvw0iOV5BtB9r9NShZnCQTSqiE2LeNdmWI
	7TAb78F67CLx0YAC3RWOmSbuEHRBo9Q58lkGhIDfCnbEK/ib6s/Pm3m96lez2WcnBZAgys+gIYg
	tGmYDaQk3xqqN0mNSCAM5K8r4gGv75NHEq6ZcmoQCry2LjYVwTAF0zKTkWw2T3b4bpkuUOK/t6a
	n9SHiUaqXRzygyyGsXE+gVD7sAwsWvBqdDMTqGFmj1BlPhLRGQqOnDI5fYaVeEj4WRa+1JKQTrf
	7brSXk9ZC5oWPFSfnQBBptceBAGbtwQbu0RQZNpsuGzyzOuUOu+hHGNO8/f3l6b/1FKhQvn41oG
	pYsLYkRyF12WAzBPYf4ZQoyYeif94lUEAPTmvhk+mW9oeMcQeUDKCata/0wMKiqxbwXvMT70ENL
	ypIkjex7ZcbsK+3hHGkRXjOkdNjjOSSursPCXzEH/+k2rQ6dK1zPvOTXQmo2+Zzna88OLDzomBH
	EwJliHvj/NtkrsTTQn78SVn0y8x8FTN93rn2FO1lDfWwk0YR60uxMpodD5muI/r26gPgdiqA6Cc
	GsCEmDG3XAFOWLSjK7xCY0BqzaUEmo4ra36I5/IIyfP6VABCcFlT4qL9wZ7QpAnvy8xInXE+unJ
	OcsiRaPG96XgVx1s5yD94COtPAFD9NCMKWqT5Xjf2rU6mjW0kAQZtDTq08eh4rWXb49i3Y6XiKx
	eiEWEFr6l+yUXV2/JRF5a68/L2rdDWecQgEBjqDWFGz8BnZZeSBGyLRf1SeJPlzO/gqMHiOTl8
X-Received: by 2002:a05:6808:e8d:b0:4f1:7c39:8a7c with SMTP id 5614622812f47-56b982286b5mr3254065b6e.62.1794435394806;
        Wed, 11 Nov 2026 14:16:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:26 -0700
Subject: [PATCH v12 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-1-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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


