Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA65606D814
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWNbSgHo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJSGH2f4Mz3c9c;
	Tue, 03 Nov 2026 10:14:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793661287;
	cv=none; b=H7Pwxtsx4ktuJMBBauy1/SuOnqNMyFhbL2Y/V5K43ZSCYP6mE3nO9oFWQbvq+PNm59Lwe8ssTxPyINB6hCLSU+jHQSSoY2Y7VSzUUbTMP+l0p53RFxDdb/e6YvMXhbKW+7xsFTpOZadvw14W/PcOS5wMluE+8I+LQxWsW610cFOL7Kr7UJmTn+cy/sMldytE/+lQgZPUcmI1qH86EmWXLpJAHmlOEL9QY/hDNYKPcKVilKOYTZYKp0fa6ijZS7noybgZJZfR9I5Bcu3+flYKuj9SMfMRQqZXoe6kK+6E+xte5wEp+wzYM7lwXc1/1bbnitrq5g59EaAdzgmUvj5VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793661287; c=relaxed/relaxed;
	bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFlvRPi1W5psy+Yy29lyuVWjH9jHuIYyMXHGPZ7NGEH62cNBtPFEEIHBsjHn2O5dnNBSFzclHlynHqmH0C9nY/aclAF0qzIZgHWpjkEc5DIUGuCM7Be7i+JJilAiru7vI1R6BDKCxeoZM5a77/FS0rdBas+r4V63E66vzD1oYqUnxyp5xhOSXfANsVRB5eB5W9Jb6fCdQ4xVMIVYduzzi/RHfGWo9erDXhOhxXQ4O7lKllo8AtF4whaZQpAubKh+yF/YWb56pzTGBHjedRDBeoS8gxX5083rE/CjRnBGptu7ya5cGjS9hQn/aXYoHKJnPu6FeJItivSMHRvVGWIT7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWNbSgHo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWNbSgHo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJSGF6KGqz3c8l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:14:45 +1100 (AEDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-705cb6cedd5so78314eaf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661283; x=1794266083; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
        b=wWNbSgHo7JMZL4URWh5/hgATn/07hsvgONwTnFg5F5PSrE0i+GxL/sZQdXwe31EFEP
         3JB9a0dLUGHdhH/chfBRcdawbJnKXk1z9R6811p3fmeAIsSAegDEXFXepu9tDRwT99fm
         i+57q490SihNutKXnS5R+ltoKjYR/3xmxZegVPNubnIhq47sgEovbIPPEBKAQmBqkOe/
         caZQUe0VL4MxUev5lDJJBAKcss4cvngHGkYNijAjHB/gKbgORC/tmDoperVuMzMy2DHw
         zFLz/CKLrPIMu/qjEnon27rgHSUj9JLwrQRREmbzmoFiIm+DemvKFG/KSKvNi3U0O8JS
         k6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661283; x=1794266083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGWk144TqWPWYAhvtpbLeTIfJgjLiqjAQeYBDnQ9hsE=;
        b=C53gcNrw4j7tRzq66ZGt7BtwyhaclLCykv+qbbYLKl66DbBYers9vpgqF4As6J2T5g
         +pwYaE3QPYBuTktjqO1pPRIG6NgfVnZX/gaTmzTcm3cOOGjCQ41atTTi/xqHocj66QtD
         +GpCtU4stbPGcEEGw6m5/oER1r/K/GXfwMp6lBzokLf0SGZ0mChXrWI6nMiffeISxlYJ
         cRiRlOluYBLLQrT3fB96Jlq8EjbP7u9ORHZKzsDhCVe0PuneIw+sGZDNxqokS9wWwADp
         CQiPqL3Y0yTOictx4RJM2Xr55zdsgtGikAEdD8T5RlMLZd2h6f9P3jJyQrYNam7a5cur
         eXiw==
X-Forwarded-Encrypted: i=1; AKwUvBzhmQZK03WUb8CEYVGI/c4OWaUAk/Al7FcJPMZvMqrcc/GLQo8WNnSSNrDPJ9pQlGpqs1ZTnHsY453lN68=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLL3ZFYdhQvbacHcG3LvwrpDhbXRYETXjf6IuCbi5ExdgEbH/+I
	pBiVwJ/LVt3se21TuAyJatJcNVx6w5BKw9iv40QTyZT3ymv8P1RItnNt
X-Gm-Gg: AYBFou1nWk2inlVUFyvIGoevi2wzspaon7lonWv8ljWmN2Zr32Ix990JUnwjo37D6Go
	ZJvN92kl6qBjpUYTN5t73/xCVxmGdPyedyUFPP3l/+0CziXTCy3XI0zw5x1WfP359Tb9tkF2S/j
	SENAJnzaA6oKV9hAA7vvSGrBlCzqxH9bQpMKDp0Y2nrVxKxRY1Z+rIHPiN0gfcYnymYJdl+Dv9N
	vsu3BcOLEPelKef5rfIGkS6gOslhdX8bMbeVzzZ3oFh2xokSLJ2sZQTgAHLXnULv/XRYHytKQmv
	xO3+mwhcnNVOrJDUoT/GGNyw3hfEzxvXt4dTxK+9PIImHo8HGdfUZQNXA79nhe9eRWfAoVziO/6
	FYBcCp9zGpqAhuTFxeSZlwkIso4lyKfnlCVX+1MCxF9+4jAU8WsXG8piNj44QxuMBce5t/ac0eS
	qK5w0XluJ3E5ENChSijmPkppHYGOdGK81NpEWxHLEtXSlkJzfnnZuov87u1SB0ueFH+wX8mrYYI
	lXPj32BVC1OZo3y73ZkED1fAOX0k77arJLOX1sNoWlFo8R4FKHuoSlCpqfC8sD/TLM4KTWzcLZp
	ariIcFBw8DHGIwQvhFPDJ7onwytfxhO8WmmKgcz0m+OUtlvXbHUk7A5zr9Y6Sja941nHlSKjNJt
	dhO77rtMjwvWOR5v1N8ST1rFMapKdu2ZSYHaYdd7xosz8nbhcWB3sjIaT4Fp2qXtPVzFP7b0sKO
	oaiJ0Ib9DofqdV4OBAqtDTFbhOJ1ym5x46nNGH1GHkld2Yv9vXt7HYhOgoo0bsUHbd7MlPKB8L
X-Received: by 2002:a05:6820:571a:20b0:6f5:86e1:b020 with SMTP id 006d021491bc7-714f29fa61amr3266065eaf.26.1793661283331;
        Mon, 02 Nov 2026 15:14:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:31 -0700
Subject: [PATCH v9 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
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

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 322403cec2de..fc1a83d6fa7c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,10 +771,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma) {
-		guard(uart_port_lock_irq)(port);
-		omap_8250_rx_dma_flush(up);
-	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -782,13 +778,16 @@ static void omap_8250_shutdown(struct uart_port *port)
 
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
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1330,6 +1329,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
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


