Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A51606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFVvYq6N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFbgB2tSmz30Vm;
	Thu, 29 Oct 2026 18:37:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793259478;
	cv=none; b=UAczl5tE+BQs3Vg4rTLn1uW/wWxSI9US2au6T3cW8yRVFxXZK1kLfO9mZ+pgLIgcXXIWUfTTnVLL0kqVntJu1t2Gs5hxJawWwLiFondFc/dDwK57s/OGEDPaZCwggCJXkOrpKsRim3dR6ttnGO3S5Pv8h9BOEpHjMEra+m0Nmk2gfqjDPtNnaA7W8YWZvy339MaVlihNxUmQovQWYuFo8W9HeqjQ7AYYatg9VuuZPzZDR+mdmtpp2TtiGEV8ZFO2pNNt6yExD+e7GzvjXxnxJRjqAqFPaJ/nw0pNagWUCB9Dcaprg20Nyg2HwlTysEwkBiQX6EAfSsco0QgB9M9kew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793259478; c=relaxed/relaxed;
	bh=ITA8CLqHA1tbelgUq4iAlzoGpEjCOXHXMqP1J6A1uQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUmXTwKN9DptBp6kTbgw6Yr1mUHGXV1Ak5OQQDjoix5vkhjHZdZi9Z3EYFRnfiGJnKUw5nxe41Uovgo2utpy2D0866dbGSGMf4gPGo47Oxdc5uKFSii9SCAGLPOzW3AIJZaClTM2Jjiuz6ixC3Zh9J329WV/g4P6C+QhqFl3wuOrE7oLDsLGphjT3Y6XBy/JmUmP1L+ig+bVVG/CwLFcULAWtQ82MQZ+bxuss7qChDmsGloekL1IJnQ3ejsvyprr+ssuJVzi3M0l9AaDsKkFewI72Y/GLkSxthQeq0SWdLgEdIXWc4wNYq6Ctv8UBDkLyosND5BKz+xzM86A5HqwNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFVvYq6N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFVvYq6N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFbg83Q56z30gC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 18:37:55 +1100 (AEDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-823b938464fso1250633a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 00:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259473; x=1793864273; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITA8CLqHA1tbelgUq4iAlzoGpEjCOXHXMqP1J6A1uQ0=;
        b=HFVvYq6NGxPvA4kTdi5B2mJI5ck3chX2xPTVa9ZAmuHDOBswRhnR0cFHGZQl1Ej2Sg
         FSlmuheM3ma+atlopmK0qsOwvPIaTmcTxc8sP3itx8NcAI/FfnMQuBFQ+rj1A+Of9/AE
         9eUk6F+mHqScdTmfVw9k4VDhE9rh2a5tO9JS6YGqCPPRz8BeYtUZBZbN2YnmP1SbmshD
         tmJLi03dubNBx4Fj8t/QhhcrQb7V/2CpZA4Wq8DRYI0akNrLWsAfpbltQQoZ0tE31kwn
         CcKtGgj9PJ7jaS6XPBwtg8wut3nLG1UZIkOHMrykwlQu4HqtXKQdL31Deg8aOcHQYw3C
         5/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259473; x=1793864273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITA8CLqHA1tbelgUq4iAlzoGpEjCOXHXMqP1J6A1uQ0=;
        b=c6MSGOcYKYcR/0CzrTsgn+2tAflWWC+VxfCAgDNklbYLeKyN3M46CPU0HhE5E5Y4On
         OUI6XSjFQXcapIRI0dOgJriO3mRWDLWPBLdRroPUzffIXmJ9xMAaSL1k2/W7XCdeOZcH
         IqmnWCHAW1S9aMAnNt6iNWGTAkSCd4WdcheGfJgZK1xtj1cDD6ZFKoXI6x7GcJHlvLo6
         o01cY0/ts+bOLTPTGNPR3lZPC6iogBMRbe42QqGUS66TpFIK6S2p/45t8DpowTULjqwn
         OBT8P+4v/PvipV5zwC3hAFrWlUim0I06Ol22Jgs+usbmdbAIMf47NUxpfAT5GMjPKr6p
         ZB5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxUyOwhrM16K4Bey4I0WBEb4QytVhv+zsjJ09/mba5JXDsx0zdgkUBQ3LadmcSEI79APUDRfShVzaQKu8Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI9ZHs2ChiU5uHpEPvobqXHyMwLy9CUaXVbabbYjZHNZOlHbq5l
	fKUYunyZkBfHRu+Tm9MvDdscnvDJ5O1M4RAqd1Oe+NE+C+rLQqjzTMro
X-Gm-Gg: AYBFou1JFk/94sG52xgdaLrJyLW76rYlhCXGmHFnxpuTqCpMhheA/oqZi/rFezBtpl/
	jWXAtgKB/Ksn8HQphmRcB2SGPZA6INQKnV/2LveFgPg1+oJ0yt6pfp3qVCEmxDrUfTkAuFxyBlK
	cJiErS52T0m8HOGJnWgqOanJQw6PrPGK1sqWDYlfldBtGnbStH9yVgLAv2+fsEbHFy0dXlbE6iA
	uINI+BjreYtsK5KjtbGmaKbQSraznep0EkfTgdIsGzPpH/fMDq0dBHEn1NBReiEAKetfjUC9M8L
	/TMvPY9tKMqURk5JL6G3NumYaNfKwyBLeBh8LfmHZJzDLih/iSnLv3CDwpANzlyCjZn7k/ZvGJf
	lDj+R9smFTFZYCUUl/C6BpwCsF8ysf+bZFup1GnTqUFvnKxAfSCiSDykvrwr16VsED8K6yv4oYM
	XSV5yqV4icBsKUsJWXWSa21QKZN5BRe8Uruws8vqLH64NrcwvLvmHvJW0PHVeFuRNmJFe5tbYyg
	xDkmbDTXlH/01/MX/tumSzlnl7OoLUWdV2VkhOiW0OdvOAslrfYeLwG+NMXweWecwMCwpTPHaZs
	lG1vJBktunZ08ock0uWEBCh2Ll5DWurC6Bcy1tcLdIlchMLrlIQcFCWVX6B6b2/awIEHq4Yt7k9
	/Cf5AF15Fi85in5mfM1q53fBDtJ5dHWrcFUe+F1OIDBpRrWl649zB1Ewk4rfVvhuUnH3Y+09Sf9
	UWiMGLjoC7EAI0Xjjv1g6jzkPaupwxK7lJqoT+WELgpWdOblYfgEKnowKXTLrluMB9YuYJNfOoj
	Q==
X-Received: by 2002:a05:6808:11c8:b0:4d6:2545:b12a with SMTP id 5614622812f47-56382682108mr3199317b6e.26.1793259473449;
        Thu, 29 Oct 2026 00:37:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c3638604sm3321976b6e.1.2026.10.29.00.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:37:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 01:37:02 -0600
Subject: [PATCH v8 6/6] serial: 8250: retain DMA resources when termination
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
Message-Id: <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
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

A permanently failed DMA engine blocks close or removal. This deliberately
retains the buffers, mappings, channels and callback context until the
provider can establish that they are no longer in use.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dma.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index f980b4faf6a3..ff7574b1be40 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -505,6 +505,32 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	int rx_ret, tx_ret;
+
+	rx_ret = dmaengine_terminate_sync(dma->rxchan);
+	tx_ret = dmaengine_terminate_sync(dma->txchan);
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	while (rx_ret || tx_ret) {
+		dev_err_ratelimited(p->port.dev,
+				    "DMA termination failed: RX %d, TX %d; retrying\n",
+				    rx_ret, tx_ret);
+		msleep(100);
+		if (rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+	}
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -514,9 +540,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -528,7 +554,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0


