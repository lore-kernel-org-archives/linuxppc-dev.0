Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71C606A32F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJY4xDLC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJSGP33nGz3cMG;
	Tue, 03 Nov 2026 10:14:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793661293;
	cv=none; b=VmtZXrSI4RHaoe9sqxiZ92WAajvSO+GyosIazvTLXrYIcVAR6xlw5sy9sM+5po018eK0uptWTY6fJtZocEmUpeiKOY6aDzOmHRV4vTo6PI+tFTR6Fi3FFZjHc6P203IMpu/PSgxcf19tovJS9NpgLp/Qlyd+hiFh1nG7BaR7fJXmSEKOMU/dYHYFSNTsUlx4v/PFTWFBtcgpxTukxu9JXhHXsvAbAuXaS45kP57NrJ0ut1LQXK5ftZ1ERErL6Q4WuqaiLVJLfNrEuQSPG8yTCEL/taoPJIumT//YXxJvHeJdUnW48nGOaF+Ihmrrk8FEi8GP6pW2+ls2mWRYXJLC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793661293; c=relaxed/relaxed;
	bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zwqsy1+4WAzCp3I2TZaDdKkFq3qeE41MCqm7Gy083zotyKRTYw2AetTm+jGwLSp02kB6Xk10KisizudF49rN4EWwKHjsUNpqGkPM6/JOmJu0ogoElb49We+8NrIOI25LEgFPmRBepIPodgR3a2XnyaIniPtfH8C6c+GzfLkzK1P8xXD9gcGaJKpUr/IUumagrjWaWvBke8aTroHYc74srIkiGaJIZMVjOYtgK0M+RM51RsNZgMB0s7BherWqpKo8in3OikaUKjIgUJROgYwLkR9KQU6e+ZWdxZJLl0qe3fEb+igWaUkt3aRHzto4Fh2ooFYHgkhLTILQsc8UMzaLrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJY4xDLC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJY4xDLC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJSGN30Sdz3cH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:14:52 +1100 (AEDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6aa9606ddadso2777767eaf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661290; x=1794266090; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
        b=IJY4xDLCFRLH7cpxd+ptD/V6b0x/OyPmR/x+1o6T1+h4p4rJl194SS1FCL9VeDzrJp
         c0gjkbPMFARoTvvbZPLeKnP4YGPpVa6oKt8n34AnLy+aH//32ZHtOWI8//BN282fxLbO
         Whr/nrDStOqZgL7o8/pXeiVtIHRZhi+/sjX75grnC53ygZkw1OoY9XCBjAsc2Anz4CgD
         I4BJE5gIEH2Qbquo2OAQ9eZNn3ylnedxKuziZ6mNz5/pzzhbtZiJT5nX534PiWOhxOZu
         p2yz6Yj33j6nJ7uDPoCRvo3mpg2F/V/dGxmxrVwmVYhFXxhOaEOCbpry1EmULjp7AhI4
         piQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661290; x=1794266090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ORORHppGTPyJBRftk3KXjGyfdJJh/FdBHFC+AmjObY=;
        b=FO9gJYKf5CgyAQZWURaDLt8bq/WFFQQyX0ryw8SWuAJgOf94K2P1xP0hwbGA/mFb2N
         dq5NI6uOOHnNCatCkSO1bGN5qHvcj3b2srWMalg6PirgV0I6kVdnHF6KRmNyYmMgQVS0
         wv6nYrqJhcSH+H3CLuvzRCodsI55fhzEfDJffutOhe6G1U3yM1gllrWCePXLHG99GFms
         vfQwlOhtPOramhCyO7X6+AZyezCwXtzYr25I9yJrvhwRss+txsu4U8GrmRRKguq6almu
         UKCVREvs0q7ZBf5S+R7Py12TUQH+tCIhtu152RrnTBAzcwsptz9/J/x2pJnGbhdSmCQP
         k9OA==
X-Forwarded-Encrypted: i=1; AKwUvBy/Vv6dtAcaGf6rkilSQXCQTH/EzJi3kTHe/xH35S83dn93YukPVDIA7QjHTlLOkZ6UKU3w0+fccCm3K/w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ4f/uVDIhgCcuBfKq73REGqDl9caPajflBuyUIX1Rz0m8zV3R+
	cjZXORme0qHqE7SYHEgJF3v3BKF4ya3k5bX57ohoVMIrdrg91Ji8hqZ2
X-Gm-Gg: AYBFou0H+yiK0hs7DTqjRZlsXcELY8AOyuvNP3sFUmNHGupixxVhBpnbUfwxtZHJdY3
	N16sA5VjLMusM3+sdj8T1w6uqlUkO2FOaIYtDCLC5UJtYnmJ5XHDD/tvi0t0/a4pA+pxAlWF52+
	3K+mbHq+9iBKPmKSmDKaXBJupbFNsIkyCVj/EvvGDsqpzdfPsIUoR3F1n26BmMihbpCkXp2yJX1
	6+TTWfXFvob0ZoXL+conYLEK7g8UTFTNBIePzI6qibAH6RP97a+hpoyDS02hy1/QAzZdYme2BTa
	rqhgLUY6l6vKZCb96j+gw9bOvoWXRBE0s0w2azMRBAckjfoiaq2AhUStgRbH3PdNu09Gy/xOVq9
	6vU5bAECAeJaiYemXQdAuE9u8uVhzX6dAKF63Z+Y2X2JfCu3ASNO0zndiEECqwy0ElMhbm39UuW
	oitHepEl3Ko5a0uf+5EExWCSLF7h9Q0AFwfIhs/Jz4+ylYPq12/jBGzpF71dD/QtBxI+fq9IFWW
	AEu6X6BOHX7Uh4p8rBdfQwRm00ZeZhqQnMXYFEyYacxBK/tGmg92v/GMBsFFysqfpH3lyvJxLgS
	4zNkuDZBypnCyQQTJRoQflQiYzz6LiYvYtIRR/1q8KPsWfvs36O6JsicFRLwsQIvND/U3UR+bp7
	fH2f99YJvte/ZL+ieVHex1ozNr1STrSEK1JnPsQaPJelLukIQmlUD4okj6ExG6aZvzxyZhjdwGC
	Zt/Eb35DXnYHP5vNz+AGoMuBxIJ0YnRmmRjOaa4TZKXQZpSL44y/+l
X-Received: by 2002:a05:6820:a508:20b0:6cd:3fec:de76 with SMTP id 006d021491bc7-714f2ab9b3bmr4460157eaf.76.1793661289912;
        Mon, 02 Nov 2026 15:14:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:35 -0700
Subject: [PATCH v9 8/8] serial: 8250: retain DMA resources when termination
 fails
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

serial8250_release_dma() ignores the return from dmaengine_terminate_sync()
before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
the channels. If the provider fails to stop a channel, the DMAengine
wrapper returns the error without synchronizing its callbacks. Hardware
or a detached callback can then access the released storage and state.

Checking the error and returning early would not preserve their lifetime:
serial core frees the TX FIFO after the driver's shutdown callback returns,
and port removal can then release the callback context as well.

Require successful synchronous termination of both channels before
releasing any DMA resources. Retry failed channels after a sleep outside
the port lock, leaving channels that have already stopped and drained
alone. Keep the shutdown gate and storage reservation in place throughout
the retries.

Start retries with a 1 ms sleep and double it up to one second. This
makes short-lived failures responsive while bounding sustained retry
activity; neither delay is a hardware timeout. Report the initial failure,
rate-limit ongoing failures with the elapsed time and current RX/TX error
codes, and report recovery once both channels have stopped and drained.

A permanently failed DMA engine blocks close or removal. This deliberately
retains the buffers, mappings, channels and callback context until the
provider can establish that they are no longer in use.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dma.c | 43 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index fd2a0ed21165..6307d0261ceb 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -530,6 +530,46 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = USEC_PER_MSEC;
+	ktime_t start;
+	int rx_ret, tx_ret;
+
+	rx_ret = dmaengine_terminate_sync(dma->rxchan);
+	tx_ret = dmaengine_terminate_sync(dma->txchan);
+	if (!rx_ret && !tx_ret)
+		return;
+
+	start = ktime_get();
+	dev_err(p->port.dev,
+		"DMA termination failed: RX %d, TX %d; teardown blocked\n",
+		rx_ret, tx_ret);
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	while (rx_ret || tx_ret) {
+		fsleep(delay_us);
+		/* Retry promptly at first, then limit sustained retry activity. */
+		delay_us = min(delay_us * 2, USEC_PER_SEC);
+		if (rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret)
+			dev_err_ratelimited(p->port.dev,
+					    "DMA termination still failing after %lld ms: RX %d, TX %d\n",
+					    ktime_ms_delta(ktime_get(), start), rx_ret, tx_ret);
+	}
+	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+		 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -539,9 +579,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -553,7 +593,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0


