Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43210606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhLwUqiL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQsyj6DMrz3bfY;
	Fri, 13 Nov 2026 20:53:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563613;
	cv=none; b=D9txr/1MwnJPRYAUUSAkkCGmCvphUpttV6E5OMR2c+chH/SJ6YNmqEoioq9+QRPSVjYjBEfCWbxyiwRNlxeqD82hMRXfj4pKxCuTTyoQeeDQSWylu6QJWxroUE/8TaTIxE0iZVYgiMGxE28bHzsIFs0bdG0LaSiajwiWFH164dzrIUOqP8TP6OzR+Pi3p3Qy3Dh6ilhrt3seX2PLgSrWS1eW6fMhFZGBIX4PaEPaed2sznhk0x4GNuPvdB96QasfrAV98mJ9D6tS+os0Q+M/hQKo94SuVlW2c72COIN4KrsId2dnrVg2Bvpk5xzoPbLH5E910CTX3QhIbyVYDVL32A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563613; c=relaxed/relaxed;
	bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5QUHnHM0hBm0lOgbG8Y9XdlLTxuSf3/l3AQBRnhViiT2uAkin4ZPNd9hgovzHNk8yxtrThwuBm5Ss3EpKk82MKeLhVknVtzjM65aRnWTwlH9mAm0MtwVL13Uzb583IoeshP/0c801JzE6KSYCeNKJ6TJaE0KJpU6YwfvR2gViyjzgGu5Rybdp4ZgMfJLlGPcXbH9BnWCvpcjShAbdrqJ1M+F9WrPF0piGz9hZe/1ROheMZ0TqTDPR/vAPlk8eDWwd2ie0LH1lJy+BNBoECJTMU9LTxSdjiw+dbRyXTqyxuryb5Md39mApmfsWleRtXZ2TXVaM+fGeakpLE9pNXmRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhLwUqiL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhLwUqiL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQsyh4Ws1z3bcr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:53:32 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-8628b63dd60so185603a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563610; x=1795168410; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=KhLwUqiLuVHwUvsmU8JisX3kNQ/9bmC9Nf0zVJ6tJVhzdCR8JPdg2hHQTPFRsOM9l5
         6fEdPclZWw2e0h188enDaZ3JutaIZmHgXnqpNiulZ+cMf5vYQCEsPwluVLGgPEAufmwD
         /SZd1lC/a9VzQRKyA6mgmpAixRmTCbwjxHDE+8bgUVjd2xq7P2ElO25+lcDGhX7P6vRa
         KzOiuoCazBwawa+PtC5Ft0ObxQAJ4dL0gbHqN6cp5zSx1hlL7Q4xfyMkeqSjfdEg7WRx
         oMtBA/7sCadjo/PQ0Gr0KSCtugaOc9P76sPpNK4QeuqZmaLi5It85Dzm9RbSVl9RWoGX
         vIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563610; x=1795168410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=xKoTBLS4PTRfHtFb6E1aZs4CPo2idnfXqH8rhYNEeik7LFze13v4dHVsVkeZerKlPB
         SOdMX/PPayAWLZiichcjSB1fRBXXZf9dL4cIxLseue2I7Vkp1H4nDF3HuArwA7gN3DdV
         RNMMMghC9Mi1180JadbDbni7gEa6rHjB8MuWVN9hTeuGytuUIX484/ulGUIti/0iSr67
         5Aqtr08WgkCERUrmGhICuWq9JIPUo4sqBqyGosqPg+ZkEAPceSz4LUglo86Tk4G8h5Lt
         8rAuh8lujiKA1Z0+o5vU/hOci5cEBBO37tTXdMqyrj580MOT6meFD3rHtDtrFgSUJ1wx
         v9uw==
X-Forwarded-Encrypted: i=1; AL+hErHALoZXniPxmEbuB1JihBQNUE8hbHuQnqmAq+mcJakaz0D6OSeAVs0YGMINTDQD1ynjeWe6KL7pFYvrfao=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/bt/eYlfgPKO8tUwW4g9iw7MlAO2nXJTFZAVoXOuE2puuC//Au
	bMRMn8W2OhIATIvzSoxJ4gRKoLK8vuAfr4QOZhHtHROHa2JoV4WXZG7j4Aa05eCH
X-Gm-Gg: AYBFou1zvwtu+zCuFWi7YiT+EYNg1OFpreTNDETwtU0hCFKVM0rWIz2vXrny3D6kaCt
	eMxv4fYd8NW31dZXEeVsHovkqH6cX8V0l0g5eJZLZfcw9XmPQnJ06GedV1ZOCQ/OJyg32uPn1V1
	TrWiAtRzSJXHsaF5EvVOF/FmFoi49o2zinCGNXMK93pbl3f33PhRwn90SJNBdoonCkj4DvgZuYC
	GhtXfQWFqCrwXkp4RYru6caredpvDlXg4HXkPf54AMcoUcHtG2CiyeT7BfPGkuUlO98gRLZqGLG
	eJSvMtbXubwplyM1zHFsT1rvh6YpjPXwSp5oUMC7c34Hi4UH5XLivG3VHP8bfDwWRXkCwjTsDsN
	32vIN3kjQyhwEL3C8aOvi/mBUKqINeIcdh/fRwah+IyPwD94jHiKd4pnfT45a0AQmuH2wwReWJD
	xMfOQbAsUz2MYpOvAnd2eHB9aQuyAbfa+RkqOINe2maACZIaSat9venY0UbCVQMj1e0DRK1HnKj
	pxy4laR5UVnmoj5Zph65czJbntGaZh974j9eaqZyRSso5QMPFjyAUgX7m9+w8l9FNFxfFqlIkAN
	El480r6IQqY9R3Qaz74npQTpf1R8w/ie8GpsG4ZQFYRnVSb+mIwQiX9LlP5ShO7taK11QLZLTwr
	IllEmuTCMhHrS0N4a/0EOBjun8tSol0YzSLjuuT/c7XCLPLXaXhl2vnR89yBr0tLlTR/+/8SdtE
	6khQ9uhyD1BIBiLhwwa0FWKCmQYgh2GcIbcY07CVppZ9xwfMKIrsQPNzwPlTfuaTqyLQ/lObk/U
	g==
X-Received: by 2002:a05:6808:2207:b0:568:c71:5338 with SMTP id 5614622812f47-56e63ba982emr1490761b6e.18.1794563609933;
        Fri, 13 Nov 2026 01:53:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:17 -0700
Subject: [PATCH v13 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
 shutdown
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-4-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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

disable_irq_nosync() masks the UART interrupt without waiting for a
running handler. That handler can have observed up->dma and continue
using it while shutdown releases the DMA channels and clears the pointer.
Synchronizing the IRQ later in serial core does not protect those accesses.

Publish the DMA shutdown gate under the port lock before the final RX
flush and interrupt masking. Have DMA IRQ handling check the same gate
under the lock, so a queued interrupt cannot restart receive processing
after the final flush.

Drain the UART IRQ outside the port lock before releasing DMA state.
The lock excludes competing RX processing during the flush, while
disable_irq() also waits for a handler that observed up->dma before
acquiring the lock.

Clear EFR2 after draining the IRQ so an in-flight handler cannot restore
TIMEOUT_BEHAVE after shutdown has cleared it. This also waits for the PIO
timeout workaround, which updates EFR2 outside the port lock.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Closes: https://lore.kernel.org/r/sashiko-outbox-206203@kernel.org/
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5e114dd8f9bf..f1980c15f85a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,24 +771,24 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma) {
-		guard(uart_port_lock_irq)(port);
-		omap_8250_rx_dma_flush(up);
-	}
 
 	serial_out(up, UART_OMAP_WER, 0);
-	if (priv->habit & UART_HAS_EFR2)
-		serial_out(up, UART_OMAP_EFR2, 0x0);
 
 	/* Synchronize UART_IER access against the console. */
 	scoped_guard(uart_port_lock_irq, port) {
-		if (up->dma)
+		if (up->dma) {
 			up->dma->shutting_down = true;
+			omap_8250_rx_dma_flush(up);
+		}
 		up->ier = 0;
 		serial_out(up, UART_IER, 0);
 	}
 
-	disable_irq_nosync(port->irq);
+	/* An in-flight handler may still be using up->dma. */
+	disable_irq(port->irq);
+
+	if (priv->habit & UART_HAS_EFR2)
+		serial_out(up, UART_OMAP_EFR2, 0x0);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1330,6 +1330,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	uart_port_lock(port);
 
+	if (up->dma->shutting_down) {
+		uart_port_unlock(port);
+		return IRQ_HANDLED;
+	}
+
 	status = serial_port_in(port, UART_LSR);
 
 	if ((iir & 0x3f) != UART_IIR_THRI) {

-- 
2.53.0


