Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740A606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2r0fJ8F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyY70WNgz3bX3;
	Thu, 12 Nov 2026 09:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435402;
	cv=none; b=CB0LMckNCXm6kQnpp8qfiMChI4OYfw9Uj+CYOPq5Y1LiUGbmiQ7F+aaDcv+NbLQGnDVY0R3uz3dSyLWaGxjeK3SxhJn1QV8+YLZycoamEIE5CKJF33q8CYg8y97M/HvwdW47jygK+gTeeDpQWbMtfHnSVLq3KV89wXZF+LsZ+UhAQDS82x0Op0JJfpmN6T8AgXqGJsiTzOGwuiJ97D5KP+cm5dl9LwS7EdNTGi/6jOz5kV6R7xFqfnfuyh/dnLrB+8b8+r5JOEcJPRi/DsMGisTZYEXC+FZyA953F1oRM8AhsyrwMNKb6O5KwNEKvyU9VVBYeEvUGcu6vNUcaOXOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435402; c=relaxed/relaxed;
	bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fK2VhUjyzjzuq7AREPcdyGr813/yyzZ1rGZOgd/RR2Qt6HXgN6wjdcrU1bzHdnov91AMp/KY+ytMrb0haQ+TPYLxwwd63bfumYUdmEn/Hufrd3Xq6CM/aSVVxjFRDU+4dKeH/iHPHIO4BQu78m5ya5v/pBhPnsj5OsYaCvUCcHbMqZGPhO88eSvhIGicl6m3CxWfNpaTHd5I/AhGEFiZI6/YMUD2aBUw7UzwnpdXZTtqLWdW8kPW3X+ZkW9dBLbMvwjg9BNqgPFj1oMlgQEyoauP1t3TIhtIcNNXlCu6GQITzHk6PELkzknDD8m1gLjaUiSVZPhrXr2SALTuhHHdDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2r0fJ8F; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2r0fJ8F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyY55WYNz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:41 +1100 (AEDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-4877837890fso2016250fac.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435399; x=1795040199; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=d2r0fJ8Flx6sFzqTO8GmN51XlfuTC9BRoJkQavMjgWRW+C0h3RB2ps1R8BOMs2fXhd
         Uk8ZOzUK0l/aBqEmlUtjyIonEzyzoDW7by3mX17Z6ugIkwXc9qykHAlfAIPWsdn8s73R
         UEehaHCVEzNC2d5iNB8DaMsu23SsDO+OXhe/LpSvBgdJKnzj8Hvb1SbIT1pdOKyyVAVI
         9N0ZyxWAKOoVXdLR6jvPOCIex95aN7EChdFHd8hUFJguzjIhdRtdfTS2su+2Of4edjRs
         nwt6+tLRpWPHkGkrYFtasE4c3L4kdoDYVURwLBwW1xYGzUdpbQfslfQixHr/yJSYsObJ
         hZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435399; x=1795040199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=PTMHXsf08nq/FphLvbNsu9yyNi9Lbu9iUF2otArHSixDqnJXBUlLUSBkljcapNNWFg
         ZwApbpyKuS1UnxZWaXMLL3iWcqhz4xgvCPeuXFgsJzjclACLLhwI2Ibr9z71fMeEsKd/
         /Q4gZdQpPU6VqFI0SXlu7BUDpoU3K95GcGxNRuyEw0W8zvWjNt2QZyIrWaT2Gdh7rpTw
         WtA/q5vCU2Ag2QW4r+Ozlt/zJM2rFTpP+21OWhOT/M+F1GQ+OLkcPEDpyrqI1p6TSs6T
         tQKU2NR58sn4RSopuVW8dI4eWYGcxqxrEHusRXbjpqSE0cReqcXNZps4Q3tRwnIugr98
         BRcg==
X-Forwarded-Encrypted: i=1; AL+hErHTyZcIjQx9nVy14CoKnGKY34WFO/H19n7GHHAfQyNV/e/Kdvajmz+MBGWoI/du3JP3cj34t2U0LVC8gy8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z891Br2Qe9hNJ5o5+dqSg62gK2WztwdEhieGk6x+no5ia3/AX1E
	enYJlFj/dWx1A1Vr3v4KS9bzqic1DcG6ge+DyQIQvXNqo1bEiI8IKxe+
X-Gm-Gg: AYBFou2N82dFOn6piglM/RCglu0p8cWjEGnBOzNHHkgye90ddee60RZhjr+ioQ7gKaB
	MnTuLMICJtCAMkwTzbZxxy8LArXkSe7hKBJmpaLaukBstfrV3dN85SX8Lz8ie0G4K8WsjIYcy5Q
	fAwB2UZDI1dBzCpdouRfCmzy90Kj+1q948YaRoa6tqGIVVLsKJ/Jpi7Q4KTS3ZTWi055ykl764V
	gP5J/QUTjytvEf1DtFtQ0B3CoESrvy9IMcTGxE9zfRR5gj8e66ggTVqgg1CC/J7PGzrhsn5dAFO
	tRulOkgck77apDRS9TsgZkXQ+cLspSs2wkQ/oqnm4PF2TfNihR2pbbmPaNLZs6S3dhNrljGEH32
	CLEeLbvz1CA8Lh3Xlh2lVSUgSZPW8/to4QZgMRY645iygtsmas+Cc2gzw4aJRPYdp/vF5OGZEO3
	XfPSeh4KlqO2tm5zV4hPKTMNZIXVqJgpdGeVzGkDTNylmbvqXXP+UKcqjdQJo3Ou+SeKZ5liV2X
	OD9hq8AVYMRL+u15vom4RETkoy7WlPdama6VThPj9WEg1HaowsZJWycNDfOn6f7AXRbvFLleWqV
	OwGXJu34iyd9cbFWX9Jjt7AXNxoBRShu37zL/1ykyf+hkmv/O/nWyCKXRfW5bB7ihbZw17abZg9
	7eJt+QktANaceART8PftxKvQbVWKlM0+CW/PAkW8I+atS983a/arz5dVfJ8pMh0rvAX4XXukS8t
	6N24nf5MedjrCyJOuGVnQXk6jXQtacODSUbqpmr1DrCkVIDjLXU2w=
X-Received: by 2002:a05:6808:c123:b0:4f1:a873:6efc with SMTP id 5614622812f47-56b98c19490mr3627751b6e.64.1794435399114;
        Wed, 11 Nov 2026 14:16:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:29 -0700
Subject: [PATCH v12 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-4-9e3456bc2555@gmail.com>
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


