Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220BD60A2600
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XzPF+peL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNtGz69QHz30V6;
	Tue, 10 Nov 2026 15:00:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794283243;
	cv=none; b=Ij3DYoaLk2dzA19sYJjT6UxN7cEOM02yD3EzxOxLRwTuhfrKXshcQh7O4YlYA7UIq84vztbjKW0z96rd1c8vwH+p842ieb0c4Eu2NildlBmUzFWz3pDTGVn4o4mDnxzR3MEY76gaz7Znf6YVn1wFjFObkrC7UPf2wuFP6kj4g3lRY6Tj9IGUqXXUekHcj0zqcnDfUb7PG4OqboVCBN5bIAk4aNnC/GLXFsyyVfRTZsZ17CpKiQxRnNk7rCobPTec6FUuL1Lj0i4pkCNb+wtXTpVx3tAr6sI2syr2Fyr9FQ4MuYAMLsBj8qGX7L0QoQwWh9XeSHcL3Q5c8QptDx2cCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794283243; c=relaxed/relaxed;
	bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqmMgDVqWMUdkshjXVuc5RbV2gg3P2KvUNrRcUzBc8wkxQWGI/chO2Cu3+hj3yTg3y00qnKO6ka/94jRm1WWzi7gcSUM8+e7x9f50Hxu6eyX/ElAB3fcI9UOhN326CsdDw5+3Bo2nPwuC9Wo+hCTNi1RefbwEgeQtUVC4ASUFT7MwkMZCJ0chknkSWiJt3Mo+DuD+KEWufA7u75mg6MoPIr3XfEvRtBvwHFaY8fNA3fzp55okszzJqLktq0cMEpSKvums4yTx6akdamDUn7cSDEXVj42WAbSgmQo6lH3tvwx6MAJUrtQiTlRcbgKsffhdBtEs8eGCBovF9ZNPauaQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XzPF+peL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XzPF+peL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNtGy3Qvtz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 15:00:42 +1100 (AEDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-717034b331dso916825eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283240; x=1794888040; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=XzPF+peL4D4GftVHdy5ap0wD543c0c6P3blud+zocH8fci4SqSs1QOliYGntUEhAnc
         WysRjrXsmjHTohKwY5sSUO/Ydj/+U3dN+Z2ZYvg7NLFVnHbiA2BZFTN1wM5eUxwkrM1n
         ui0j9OW8FKvlz1w7Z5WvYYscqxR5087WDSfmQBvUG2epteHkwq2rPiGIkREo44HDkbgR
         D0cbXA0awJb8Ak5IdmhQHZImYh0WguawFHSSFs5HEMXZHmRbFKmbxxWAjDFw0aCWUqa8
         OrM17U0/s6ONEUKk8n4NU29N4OXGxIBFGhAZ5LVGq9sn/zp4SWzqpqYY9Jvp57I2OqZN
         ieDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283240; x=1794888040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=Op1Cf3cxQ4j00SrXLG+6doiAToQkY0/dWgOj2IfLZ7iNyNGpC/dKv2PiTjm9X6nVn2
         tPCLmn+5tp1uQw/2vhJGjn6hNEnOXySLOGf9WshXhkam9+9/48FvYO2QZMrCVtZ2A60k
         Q7jA8NS3NqBBd3Drjo4keWbl/EaiNcUQWZzkriRossnlXzBli1/QowW6tGpN9anOkQB2
         tUzgi6A1AM6m3qBwWE4g1OlrbkNehlmlC5UP5CrV/oZvo+Cv5cEly/0NlgVv2/VmEkX9
         5TETVYOyMfua5PDsyQ9NSY/I/DNq9PjAGIg42MDYPM5Qqj8RGGgtaAK9/bnuVO8vxF+5
         7kqQ==
X-Forwarded-Encrypted: i=1; AL+hErGkdk78tbtb1u0q0BTINV/jyZxrhSRhiRWOrrfmjZItmuEOhFtnat26QQqujXpPX+MxTH8k1hitu5kMHAk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9xxqrQKGW7l1zXLv9+FXRuELZbMFiXtgP6C+UfyttOSeGivVf9
	Sba2VyUsHIJ99doCR7qzXmHrwZ7ZuqTTHG7lbHueCKpWjxFa4gwpO0pq
X-Gm-Gg: AYBFou2JoWUatmJpoUDopdhfU4paDnB6NXR4k/Rnh2Hu4lKOl5ftlL8KP1aKovYSizO
	zshR52Jdt9+USZ6/qiiVkr3TT7c2Ep9GlCS+IRpBjPO4AR4mwRG8tOonlHiZ2RpSUTFDMz1hzix
	zWKWnhrZd7/4M1fAfcKUF1gUPVuHcpyygI2uvl/f4AymekxFN97GYJzbcHFVq4saGLRbxhQWBjI
	I9Vgukr/831eNcNUbwaCS6NJd7OPv21+kiOISvKvhtUuyrIZXwyqOYPSh2L2c6tdtmhU3ebewh+
	xhoxZHIGgN7BOwx6nxAUZ9NIiHzyKRqR6XA4w/XRe/ack1Hx169EFbkAxldIB8DE9qnMT7TeraH
	7ii9BAWfZQZdEsESFnCoh8y9oael45mcbyydh3ivhBGu8AVYQV9Ccprv7SwWQCo/AHNJcEoRVdI
	EOgP6QolwGbvhNMFUEAH/X3WS6WR0RTowtpquauGXGAWkYYErsGI24z94D6KAsUOa2Y0t56hAnP
	OvtDjUf4zJ+DRgGKXjIcX5EN0PWBSlpyYXxzCWt/b5+tjwO3A6NKtEGIk8OVjMwOdrM728enMEX
	LNtUl8xBtxGuTPNevMiVQLShjzHLxuDFLHhMt0EQ8Z1nkdyKy4r7DhL5mdGGSrk6GZy7Xr8TL/s
	Myge9HdLyFCDfMaqnENwlKT3if+XhSlYA4Zqogu/dWy32vvZ4E35HIgLVd0lzjDJzEZPKS2RjHE
	gEerbC3sdPgoFKOEuqSH0BKc7d8NGcuWFnkEwkHTKT+6w40AFuPsqFmzPekMJ3PLkONe5GAwm9
X-Received: by 2002:a05:6820:f02a:b0:703:3ff5:ddc4 with SMTP id 006d021491bc7-718a188120cmr678015eaf.11.1794283239825;
        Mon, 09 Nov 2026 20:00:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:19 -0700
Subject: [PATCH v11 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-4-6364edca63d6@gmail.com>
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


