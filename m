Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E1606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PqwA5OAQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBdKV104xz2xnh;
	Sat, 24 Oct 2026 22:42:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792824055;
	cv=none; b=TzTOS2oCsmfJhWUkT3dQwOMm9pwM3WxzvKgW56oMotyS3wyU9T7nzZ93lmX5HYQijZUO+OGHp8Y3LUv70NCIjMXg9DnPXT98BllHqIXhSwy6I9vgWL9mVOWt0C5ATxOkKgF6phM0UOE8qtpkxZOH4xvopzf6IZrTrezAxkNPoa/XtjXeXWQ4Am6G7aVItOsZfsVJJueu9foK5X0GSbEfYC1vNGnrETFRK0R7Zdyb5c2KfVYJgxvBqdnOVrvWsb+f4Doqp9MMCRzi1kzWM7LNn6U8sVvNwIvhSw3vS+lZD/6/lDWvznzoNzvLidXIrfkyfV+SVYJDys16bnQRAcMVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792824055; c=relaxed/relaxed;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCtkL6Vwcm8cAmD5LmcJLb1fMDToREFfit8co6BKqxL2rxwGCznhvbC38dPOLGQhUGiIpIJ5KRxZIRWvFV+nkytXz33eTFGCfS9PcXTDZQU2BsU44gfv7NLFQ9HTV/yZV6Fq6sEsGBDdG3wywv2yGGOdFu3frKId7YdBCQDTUSXLwnRBjF/vPQ9DVdWzBfsKNzATqKGl3RYdZ9PAYZLirWFZ1WqbjmEaE6qRNMLxVA/bRuqgNcTXJarFk+EEfv85Vyc4GgFWZ5jixqqJ/9CcO5yK01Ja6k86lK3pUSvZkylQn4i4IBoEXtBOEEuFaDpLIDyWI4c3Pen/Nd8THShGgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PqwA5OAQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PqwA5OAQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBVdd679Bz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 17:40:53 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-82380b0f55dso638243a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 23:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824051; x=1793428851; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=PqwA5OAQniSB4YsiSN9XkC2vlf0wpNd75QL6zXa/bvrgmx/J5cGXpNa33XVKAxj2pV
         cYvJW9+UCe0F50idYnPrEDWVMnfpk++F57kTAAKnyl1AcDJl88mGZUM2A3OWQbj/0r47
         ffA3mOkNSQxieeqF19X/tR4pMGs3bLKenmwPyTAUTiJqFQedH4H45VVbsBdy2lnjxt8F
         j5gfE17OCgZvTLw47VUwb4ux2CwGs2vvFwfkvTB7UONYwoqCZDSCcDWbRxYuCHTZtcjO
         t592/QNd9cC8lzLLNqDH4tE1AIM62tv9JkBgJhZDq8uJf8OZ9PSmw4uQo85xzZRxFCfX
         OOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824051; x=1793428851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=RgFMbldRI1Duj4VjeXEgrZ2ONYyFJwKhoVOzJKp2MUFQvE/qMIBr7Oss5M3ymiujja
         0+ORiuwfhZQCm22XzT/LJV5JrSF+GhWwsgro1Qsba9q8prDeFKF6fMfm5Asu410m63h/
         1fyf+X+HhEz4gvA3JfHFefJp5k2jncDSHdP1nVrkR7BQM3m8K430Hc+xTTVme8a39FQM
         dJ5ALrA2nM0QWnp5qpfeL7TfeiArSOugFY+yD09RolbNEWPTRxoXDVuSniGZJWvDKI3A
         cel8b4wnNk+D57fhRdz98kD0coNd0uog1TX1b+kslefwLJ9fJ3DzXntwJ1R1ie1k45iS
         U6Dg==
X-Forwarded-Encrypted: i=1; AKwUvBxAT4S+WkCYpLX41gtik6gm6yzv08sNdmqmUHXj18biU62xhezz6P4BdQ6fY3DIrpBup3HHG65K3wJoNt0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK/ktfujO6p2F3PlZwq/aMuvonoBXwFz9wyKIjyRYwGwjj0fOl3
	6jOdgCFHmVAyKKnEvEtgvcbqehAKjP88Ej4K7Voj9tgd+zN9khof+b8M
X-Gm-Gg: AYBFou3DHIiu3GDuRmtF/gpIv6UtzODnEmo712OHn+pwuk2SGzWeqN2oGtav8OMkiSm
	jJobQTFOonh52bJAMhKt+YJ85RTGsAOBfg3C5taXBhRZs7DFBMNxzu1REsCqlgLSDPSvhDxs7SD
	dKVub+Sen0VEjwl1nG4NHZ4cmG3SuFg8xIlpXEInlw7M4Hl/j7zx7vtI9AUmLp4RT0pzG7ia0ri
	83SSS/nftG8q5I4qqZQmN+5tDqA7pYzk9A4ig4Bs6JMh8ph00DE2U6DDnr1FM5907IomKIZU6cO
	FaN6TVvbeoOTojb/MRUakJqkB94+ZsmsK5olU/6aE33fCi19R8DbIJe5Q6isnEK7DbTPf9Zzlc8
	zxBwlSlGa8urVzLvQ8lNx3la/MNDDYjXkkY/sWDCC4ScN+Z2f5w0I+WG2vvhtgtBBWZMEENsFlq
	nv7IumyOXfmfDFY/0r3Wh7EMnt2azAISp7GzC2qnCIptf9l9LMpznMgC2Q6vomSolNOS452gdPL
	4RlazE8Yp8dc1G/T6fNrwrDTk9IdLyKO5gWv7aeB13X5r0PKnl15YUS1IZX07yIAPZGrxZpy/Ji
	ynlScpkdQrUwSthT0IVveIxXBwU7ve9rZ7BC/7zUtK4DxRvTYprX1nDTpzNxES0tDe5nTlHw+Z7
	bvl+ydP3dKrSmmQ+EwoxnDsAM4VBiMazVooDHuax19ateCFARuqX6TJfoWF+/5Qta95FYZHNWjF
	/XZQdX9g/9VwcXfv5N/cmxSq0=
X-Received: by 2002:a05:6808:4fe3:b0:4f0:1f76:8ca0 with SMTP id 5614622812f47-55c003e9dbbmr788058b6e.56.1792824051160;
        Fri, 23 Oct 2026 23:40:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm864633b6e.9.2026.10.23.23.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:40:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 00:40:40 -0600
Subject: [PATCH v5 1/5] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v5-1-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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


