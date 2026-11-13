Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58D606A89B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yw2XiMIS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQsyc1RSMz2yFb;
	Fri, 13 Nov 2026 20:53:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563608;
	cv=none; b=In9aHk4Om08dz7Xo5qISrCxQ+YqJ4Chi3zAG/SI/CyOVGAURzbvf0w9EtyGahd4dmYkQ4cdN30Q5MmKwpVw5Cm51kGkcZ6BJYAMt19zCYwPjivvxXO7Tr9Gri+9TWX5skkRMHBgHcq6VvDF5y5E15QEXc75A6MKh1QAb7R0f9xZVTmq++Oq4M/FLQGFtskn97Ma/8iIeRNMJkDhXrjI9bff1D+5tFDCEfhaE+ExUUMViUYx8WZel7HfzXGe8RqCqdkPnsrJ6RMoqL502lWXsFU6oZE2ETo7+JVOOqq4fb3f0dm5Wrohk3OxwCMrSGxiSx2ub0MIO5TRc04Co56t1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563608; c=relaxed/relaxed;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfzHj8jWhY6G5pq5k2NgV2uDOnbU34/2O6m0w7BECzoURtgqHyfhyrTxizb820vAXHBxlmKMlwrVhNIb/grjPWcJVz5pHX3mkBrIzYDC8KFM/C+o4g5E4FhqeSFrLaTcj57N2J4wv8P1S7wzL+rL3cC+zALjAYD/HRU/XU7SwAf/Rk0HxbuqiqBmQg/sDEt9ZVatF12EA7OW9KuAqwkZLvp4E6Onin1pfdqPIi66bQZt9qOt4AwTgsTBJsDlxJwEUg2sTHYvDWQBTJKV2rPlfjcYVhFaBcax++57VfcvMR65blffrU3rJEMDLzaNAE7f93r32ERLVxgymh6mWXfZOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yw2XiMIS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yw2XiMIS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQsyZ5gpbz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:53:26 +1100 (AEDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-4ed6d69bdfaso1117541b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563604; x=1795168404; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=yw2XiMISda94LzzOc4ZXYEYZ/nnzXOid5F9lnANIwYYJp1wMUflWAY/9XJQsrSNH0l
         28dGpFQOsE4cey84xYKgzSUNSnJ+fzwR+lu/0vmGPM6F8iib0iHX4A+EO8Ce9F3Zye7+
         J7WfwLdXWZgqjHMW99av65x3qKWDc5vT67jCriRgKf6GVu1K293xZvqmdIJ1bsOcMw9Q
         kYLU4GN6zqCRGTZH4Q72/+aELw+SXGtilftpssteQMA4HCx+vOb0BM1T6rV3uTxcephb
         GsdjR+YET7jpeGoxFnuibUSUBWfQFbmoqmYgJ+7gEe4nq23RVT04cp1a7UZX7Hn6+HkW
         yJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563604; x=1795168404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=PMYOxChEmBprY4yOXsZ5y7OLfS6iDBEb/COJwX7p5z+JxdtZuFLO/haw4x5rGX/8CI
         PLsUMhQdSRoySPnOanMry8AyJohIvqOvugELxt7NWS/x4svFBqELHULSn5uCXqXVsndc
         QV/tYgP6sus1GSl8ewt8hMBHywOb1gb9ccRgNFC/zVUX3nbXfZaT98HoyuHbMaTMnFsN
         vaUnhTZFDx1KezYVhtoiDKbxVXugjg1jZHzFsEeh+blSqxYpMjxWYKglFdIWlBIRysEm
         DLz/4NBZ4he/3hxEAyTA8YfDylYSvYk5zuX9EnDWzLFmCN/U7exkoHjybTmdKegWHIej
         lE9g==
X-Forwarded-Encrypted: i=1; AL+hErF99Lpd4osRDRef3CSmTWY/P40r+XagjmXNkJdOD2k7C30h3yQzcWr7A16S6w2NihU4HGRGt90M+FWwnQk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9bIC/mXc49hpf1oOdnUJaRP3FtZDgrq5AAI6Ttf4Ih6zLAhXiP
	/H0JL2ZVnDqjhl2eL5RaVadW7uzBuCpQ/0JLGXLaedXoBoihES40ME1S
X-Gm-Gg: AYBFou0BlikBt5lexLdjSP2bcmndlo85+NAPQNYgvV5avrkK/x67Kh6JjRi8CtEkqoI
	xbnnyJ/Gm5N24XkEF2QUhG+oZJTbrdAm7k+PBttzVmYJY38RSFqUPFfska0+8+MbXcFHJ1+eNCy
	ES2lV9fFKNhoYRJYZENo+jgipazs9jqCcSRvVFIx+50Y/hCR61I4x3jjZblBevTzBEswL8DRJIB
	bQWcT72LpqbeZJetSdZW8/00JA3Xls1G+yzuhUWcHlW9ht4pEHlHjIPhtyVdHWcUbgBj5X5iDU4
	AYFdXh19M48kc8YJrGoH/azOBTh7tFf+XHuFtUQrw/2wBooH8DsdJgHcVLT4O2LVVKZ8y3HOf8u
	uUXJQSv7I5DrbvwIINgoyXFmyXsAkzctJRj+vIu4x2iiuHLUxQBEfAdTEYepRH7a6/rkJ5E90b0
	dvkIXA6+WdVQun3VpKabOaBVmx/s/gkmouy645UMX/2HREo0Z7W/JHlBvhemx3Cg4mw8K5+QZai
	OHaGZMVcdh5RgZmB5DFPHwjabP7L2HWv6mCN1pVBo/e3CFi51WSzBsJTCs3MCaHXa0NtTnuliHd
	iQ5PvM5zZ36q/RF1Z6yN6cXehLx2HxnsX561wlMROpEiwfmBZMoi/4IA3JTp0mAasHRenHRY+wG
	FUpkjOtwSsu7RoPZidZA4ubA3rKihQr4Q4+vsXETWtrYYrgeSIk1JVcPj5HBQy+JdXJ/CziapJg
	OOTdjamaWqbrPHu7LnYq3n4QcE+MVa0HVbdw2gOlO7yyJF6ncdKhYtSizLR9Tx9a0RFUvymOgY
X-Received: by 2002:a05:6808:c1b4:b0:4d5:27da:a492 with SMTP id 5614622812f47-56e65a26806mr1379942b6e.44.1794563604182;
        Fri, 13 Nov 2026 01:53:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:14 -0700
Subject: [PATCH v13 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-1-b857f2617ece@gmail.com>
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


