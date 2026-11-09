Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C7606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6bV0dql
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6d09Wrz2ygK;
	Mon, 09 Nov 2026 14:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196280;
	cv=none; b=oxNtdSFQ8+yK9X1sdRsWG3vq5jZXwbuKJhcJ6RTBzc/FVI2YoYvu7SI15eGTkh4gRmAt+/42wDVMrMm+qBX/Eh1obJZ4KsQmUiz4A6av9OYFyUYjhobIzUwrZs+SVcWcOvOFbHkcYvbx4N/3vJzkv13aY1vhVrxVmbtA2Dx9ECu6u16i2r/lyMmafc9Qc1q11cqRv+Ta3JtB3LvKOL3374lE9WNSNlbzVXGTQoxfIO1VoMFLJlyKsCtmL9OcFrZL7bwTKGNiLg5NO4Wr5Y6ClZ9WQbzgttlVZlzF9zXzRgp0Rk8eHbSIWB9UEA3pqdnMia86HqtPKUGFNH0AgGsxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196280; c=relaxed/relaxed;
	bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b534neUxU1gfzIW1ZKGaOdgFPOp5zRInU9Hwn6UUp7q57CJJYki9O51Oed44nKjfeKsgYdzP/JSWo1lxyEzwyBqCXgZ3rE0qLsTHnX3LHSGfMdYN/Wat1AVNIPEw8C9ZRIBEckNP3e3xpg+xnfz8uyqBLGt0sCyypLLjuMHXPUs2GA9MIMDesNk6j2x2TEg3uYTb8dOaBLTgn3o4VAGAPSkm4z4w9raXYtANWnzTogYwKCd0nilmpWYtIfBlDZd6RtVsDkyAsoaOrds81mnq6QSI45wO0zKTdqTfHPemyBVwFdnYIiqfPJyhBVqsMYMSrDI7w8t5gCBBTaUm4iSR4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6bV0dql; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6bV0dql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6b4sh1z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:19 +1100 (AEDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-8490a7d6696so210678a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196277; x=1794801077; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=r6bV0dqlT66D04MuSVXZ9okMHQqjYsyk/8gL89/buWz9t9GeB0CTdmbUBbWM4YlOu4
         DFsq9QhJYtY+tkYSXfPLxpirUkusJpK6tdRvuht4oXC8Kt+DWWYYtn9Coq3de3ssJbm9
         khjy/qb8xjyCwx5Hn8/0dTadky1HqIGTnmp+pQ03o+bKKhzJqkbj/GuFGH/oQBmlXCDE
         rE7EQyap2N46xHX6u3Rimh8C0BFKSXNzOjexcEl17yL9jA2ilgPpjYrJfTFNUUXQ4Fgv
         YhCcCnmLUTFNAREEaoMzRVSuWEgP2iO7d8Gy654dwqElx3z6JYnxLW4TOtkdpRYCh9Us
         Hlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196277; x=1794801077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=ZEgo7G4bHDMyIG7J1dsRVJX46A06lNEcETkMVLiS/LolBKYgmSO1HM0Y7p2cDTagCx
         bHvWWZKpXBuRsg3ANzVEykV3etw3h0aOVLR5W1QQWWE7llzZU5780cnQq/0iTyFiGAsA
         F0K4dyZddk/qx0dD7rM5lVIiK9OMIQtxmp00Fq9y2DXttLFJMRD6J5j6HyCYaOoh0Oqy
         /hIGcLvoFWSkpK4Tlgye7qvzJaEnqH5OHOWgvqVxLxItSOGQHaC7UzeXvh/m6at0nXhc
         ZT9su2ymUVLI2rEEJUHTo68ZF8Lbj+7UhKSrueFmvOCu51x8t6G9C4zEHW9+hhJWMdVx
         aISQ==
X-Forwarded-Encrypted: i=1; AL+hErHX+BYUTP7Re2eaTh/YRpwTJ4BM7lEB+rOXnDGkwpVybr0flM1V4UdY23AUaNL9kCflEU8/I26/gNa9PqU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Tr3GwndAkzBsUxAusrBWfayepu1xG+Qt+YjxL/ifY16YGN0MA
	Fhrvs7/6XAEZ+p63VcyppEV8J58SiDUL4DGo0Koh+36Gfvla1JNvTxt7
X-Gm-Gg: AYBFou14uCV3ciW2W5AW1JYZF1OKd3sAhc+N33Yd1nyjZqJLz0rocu2VTOgxrQLNWpW
	n2bcjavOjffbsT5GEtd4o8ZYD9gHOT6Jfgwax4TZ7WcevHaLw5hrRl2CX7mAbVbIwZbUZ6mQFX4
	jeO3j5uI+eKM5AC4+ST3XQL4SelCvR9Dd5QXs6NOGomH34UJSa7+DEJfBWQTu+JNt5wpQat4R6Z
	usVXjYkbAEVs7i0cJSNYzDHvjDZ8lpYs7QUSqvLlUCtlJJ95F2VO4arwfQFGMMH4HU/yoSYgbqc
	8OtV9uxRv/ygW0/NAUwgJuSX+ZLDYyzg1Q+i7cVmm/6AbGLFR5antfcn/yRjfWi2EgpZADTN+Ut
	MiraiUmuZwesJv55ZkmaKW11tPv8RpVsDI8l4EomBayEQ0qkdEH2mY9sMaDbqf6caklvSLbs8vO
	152hNm8iFECTTdytVuTgCm0/86hJhPgPyxqweIrF7rZKQsvsDSueXbUDJ3QjyHGxPXSPQeC1ywS
	Uzo4Rb8mUhzmcAOt+wNQCl8zIW2OBJb3+uFMpB9dP6+u00gJNRlv9aOLtzcu/7ZKWpx7odYQE7a
	d70ZeU0a02SHYnICYLzDu4UCblmgI683IWZx/72VW9T+EWdBOwNqOKJIzMxR77IriLtRHVNtGPM
	K5zvYYF9M6irLUaM0tCzt7VaT3AgKzUBYeoYaZWHQbAnsdJ5k2dz/+XN4DzYRw79FUElhKQoL7p
	1KouVhhNiffhcSLh3feyQtXV1q8hmwTLR5UYBKmO8Rs1arv0dqMwuBuA==
X-Received: by 2002:a05:6830:34a8:b0:85d:44ee:607d with SMTP id 46e09a7af769-85f501a3163mr2198462a34.0.1794196277001;
        Sun, 08 Nov 2026 19:51:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:13 -0700
Subject: [PATCH v10 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-4-e6227ddb95b1@gmail.com>
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

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5e114dd8f9bf..51013dd2d851 100644
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


