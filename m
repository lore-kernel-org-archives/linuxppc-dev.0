Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313B60A381F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbfrehSq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyY601D9z3bSn;
	Thu, 12 Nov 2026 09:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435401;
	cv=none; b=c5XlOXC63qKOoLdgtWi7NjRwwZGTT6GbZsgOyiY1QBchs2y4LFds5Grh4orleeqmddagUQ+7GSXHS4qGpgXe3w372grTaOBL3Tjncfd08D5wozRUp21rqmqtPUJYyW3LkXOdSPWiO/7M/z+WipuvIvxnbw+XaIYbgS5Kun+12m96j+YY//cOHq1YNWW6cD3yHmp2jeKuY0IIwvkeRalQyL768Yr8s2SFwpDfx+9ePwhxkm7Lb9wC1Knuw1/rDp5fGZ+0iB7wUlCZBYDiaG3uSUCpcAR6K+v/Uih7uoKe0hyzs6/QoRUuiXPZmiH3QUUM3SFarcdcuKIaamrkYzQ3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435401; c=relaxed/relaxed;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5JC3/hKIoXELO79NruSptOOD3Pky2iMM1WorgefD2nuXJIxQzceCAG/QD+y2Hd8Fq3UWFjeB1HxuzSxDkOf6i5McnYyEkeDrpRycKK5ZihbZ+QGYlPJa7iMsoYvcS0m8vhh9Ha8y9ucccr4+rQmka87SLYLxx7mfNu1UAJNWI8t1rQqQPZ56S6JXv0i1hTIYL3dEgIJGi7aP0S7KvlYI6UGqWIvbJbR/tCPuBfrUBf83VnWmWAtnZqV1yDwpvNIQ5orRjhZrHI+UcdH+ECvNUXIrT60ZdfBsP2DeLdHr6Y9C3F79AFWSzqnoJj7Wz3dbmgwSAEgd1OT9MJsGPh1gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbfrehSq; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbfrehSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyY457Czz3bQm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:40 +1100 (AEDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-4adae3eb4d3so1536327fac.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435398; x=1795040198; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=vbfrehSqi3WRzPV8ESafaC3LXP3YhHjc0CouQLuWnJ6jk7IK4BkNwJds6VVCizUgW6
         5AwWl1psezoTLbecZRFmWjaOIg69mljU336z2eQChcUVoeIgJX/1GIjPGVXZXZ9a5STr
         S5689UY8FRwW+Rn2D2h7iQdbnz6MTNvzNKMDgqYRbW9fYpUIwS3nejkAbaXtieEHfSg6
         4tDLk6fgq4ZjEvsj/x/WxPtbcaNNEo2efnG4V2JDZfZtE4CvyTx8yHRM0MEJAxHgeIHE
         lzXK5nXUAjgvZyGcxmqS34qvP3ppGZbupC8g50v6jLwa4OOb3dz3rb531vElN+2BBEdN
         ZNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435398; x=1795040198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=uns2ByRiEpOjceb7aCHz9Nlt+r8gNMPNRDVV8MiXCRb2yEDpqIB5cf4vOhhj5pSWCp
         Q0zy+i2+qFrYJQXlTFCufWm8rhiuDHA+vEjF4aSC9YEDzrWJURuBO6ZgyYGwrBRNI8wt
         OTZBTs33slt1he7xohFHgdSOBbf+EN/r6yvn9xas1XGbJEl1xh6d7nv6cyFTzbLb85ky
         Gc/7PsU4yKuNnDXobi05olArj8sALNA+G1rqjYquwENe5yaeE1pWGwSsFDpFRrAVsuj6
         W8Z3jbsg3FvXp0QofiosKYn2y0QbrBcdVKUYcV1vkUKw30/0gx+4uaMcTpIARijqgU5A
         4u7g==
X-Forwarded-Encrypted: i=1; AL+hErFwU6feQdIzFFZ8b6IYA+nTlo3SwbHzglt31w+HXdwNUe24NcPbuPszdKijJr+b8AK+RBiCLDq0zw8bXqY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+hqgvAzOGT7n4XpdIRCc+sPuGlsbEqxyvbQ6Q4CUA7ho9yARNR
	tZw7HWlfJ2/7SlG/bbBM8r2L4E0mNt33h/yqsmKc5mqm5i38AdhsNcy8
X-Gm-Gg: AYBFou1pURG9lGWZUr5SKqBsNQjTBr01aMdKV7kEFq6i2kTz7wTTdYFs26ePtaxlfa0
	zR8NGEDZA4FT9GTBT85V0QfdzSm0tRm7N2bsSRNm7SsAxpwMCF5EnkmzHutMGd5NWTA5Bq/8F6a
	WYnZOXFP1hNr/u9yt0Kjt7GLBcts84SjAW6/yN3izpHAqlqad2nzzhsJwQuO7yLbbusncthWBqS
	mAc/hq8Jx18Br6ljwtLzbPBHLKaaumZ+aI+/i2UIb3QdysA7jcJFgJYZYZBRwkuJzdJGkrZ0Dn8
	wD+mIiqWuz5/Lw3g1xnvhac5V+4yAdQmChQde45O9VxX/ze7nEKmlqaj5qtF8FPsuqSKSaO3oTh
	oEkMacpyipQ+Z2TSiEhL3lKC8CbGIDL0xytHT8xaO7hvnPiWxnZCkVbLTjeypJSKLg7yGrjOsJQ
	bCe4qu6jE38nsCanPsdOwaTFPoSb2FmWaOV47KgWblJpcLLhATKVFvOq4rJ6OZPVOVb+xcvmL3N
	fNUfHnOLw4EJh9jBVjl07pvfxMNCI5/QApdbt8iL2VYxuE24tckVeM7lUSxaKMwkuvFXFn9zS1R
	DAhOAd694rqlCpRoeqpC65s4WfAvBqxf2F1u3MmqxqQeNrNOfY07hoEwWBYvyxAD22Sj1GP13iO
	yI4YxsreOsFi8DXO6Uaua5wj6+LV3098gg3YOn5QeO6CyNU6xgCHPfHsLyhnvEskfkvxIuHH9Mo
	hnkfMF0P0k2ES0FffSoZKlj7xZyy01nKNpEkZ8SWwQGmcqjFR6770=
X-Received: by 2002:a05:6808:1a01:b0:4d6:92d4:c806 with SMTP id 5614622812f47-56b987289b0mr3147119b6e.62.1794435397786;
        Wed, 11 Nov 2026 14:16:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:28 -0700
Subject: [PATCH v12 3/8] serial: 8250_omap: serialize RX DMA completion and
 flushing
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-3-9e3456bc2555@gmail.com>
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

Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
completion callback calling it without rx_dma_lock. Shutdown and runtime
suspend flush RX under rx_dma_lock but without the port lock, allowing
these paths to overlap the callback's buffer accounting and flip-buffer
insertion. RX submission and UART interrupt handling also require the
port lock.

Take rx_dma_lock inside the port lock in the completion callback. Hold
the port lock around the shutdown and runtime-suspend flushes, matching
the existing interrupt-path lock order. Assert both locks in the common
completion helper and the port lock at the flush entry point.

Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..5e114dd8f9bf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
+	if (up->dma) {
+		guard(uart_port_lock_irq)(port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Context: port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);

-- 
2.53.0


