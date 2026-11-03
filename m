Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F3606D818
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lhcRXeV1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtqC17r8z2xSS;
	Wed, 04 Nov 2026 03:11:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722279;
	cv=none; b=WIjC6Ez/LyU+cvkREe8Q/xe1VVgR30utmw6F+8jJRnmSLpclzOnIYSBR508jR2dgm/dkzw5//jylcfiBWeLTL8Q+Ao4yfv3rZhxBndGKaLMw6PCa03VSffIRglzHVmCZ+HeHqZBYGV2Pyn240/NQ34kj5DJmbmmoiKY6MkIYOD8+ICjqwA4/zFssnuhvMp4998Xxf9infDCvXWO6GsrBDqeKeZtpV3262pNX1jU/BXeJjk8bn2AGgYzQV+98xqWFmjcv3DwUY7axownVMz8TWUJ8BQXnsGw+VQJR+8guE4jm4ygOsyUD0UkiyDfLmp6buBgkTVj4SLtJncVQqDtFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722279; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUtuj5ZAsBWPfHR4dUdsoGyi8LRfhff/blFolb9gSz9ZzRwDqGVKqESBJIsHh6Rjv56XO40eWTdDI6K7KfbjgCy7zlWzmiYPsXak94YA7b0WWzObZfu2RvwH8bzxfI4/rtJNcmd1KpKCkx9mkrE8g25YyD0SpU4uD0lGMq6Vv+K8DWzm7EuWItg+AmWUitKr6oPyXGz0opFOcKtj+mxKe8YxMm7tMZpIrjZ/zaKAg3jbAMkUmFXVtXi6nU+XS9NuYv3+Gb6PrQFdqBuTGEXTgefBwtOY6gEPVzGXkfL9affpp7ldJKwr+vSKloRDYATP3RfKMzeGco9X7l9BwMrVKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lhcRXeV1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lhcRXeV1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtqB26R2z2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:18 +1100 (AEDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-4f48d91ba7dso2549336b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722276; x=1794327076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=lhcRXeV1TC42qJaQp+5COPcrdnB6DhXsf7P+yNyRwD7wDsq3utjWYZUQeQqWmOGHWK
         JcF0cdIDNtkswMBJa35sEpbiYfi+fBM+MrXgzFLjj6t7oIYOtc5Lb+XU8jHWlhQON1rG
         ogjHsYBdHUblV4Ym8xUBmIdMYV9IkgFdc8bqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722276; x=1794327076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=tR8/VchP67FCvijDCgR0HFOAgZO1j11fXH4vi/w7BH/SdUF1JN+CG1TXUeAqXQG0JC
         AD+4JeBhCBUDU/+JxLZBZXuGC3H8lwTcwrCKGE0WChOekCs6tEqPpwZZfStXDbuYo4OS
         h6aWAAjCk593SjjAum7oDPyD+5CHL9MI7v5hR/dE+je2bLhL65dNSxUOgiqN7WBY5m/K
         GTp7x8PVawVoTqSEn31mBKDZ4uHlYSxI+63I6GVro9L2HlxoRNl45TKUD0qBSMGZxEnf
         I8xBZNHJ7T1c3wqDYD9Qb22sdtQlMIP+a/AFpkZmmZe+VcajpILV5VR/kA8B2NXE2mwd
         kukQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKBdnkJ+gJSWadJLpxJ7n0MKdSk+YtThDmU98Z71ZUJxeMr99mOcbMWLnWeht3J/Bd0DznUWhlqAxve2g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/cExmMdUcBZdFTbA1QohRXxfHkDmiZtCOCKuJNOh83w6pzYatO
	ENe4cgm2dzwmnv7ijtl8hYKUmlrBWz/Wrgszcfjil4CUcY1sPmrGEv5/7Bx990ZCFQ==
X-Gm-Gg: AYBFou0yIUt0XuvvcaYJyZQYPXq/0aEmii6QlX4qARlIeuzi3gD31odN42Lztdpz85Y
	7sGgVev1z/F6l27s5uguwuRuj6MFRBWeY76pcRBAlBQgwGGJHYICKMgbl66W3Vdna8MyQXlGjeA
	zejKBw9/qC8D1lUms5m/GoqDzA+JlPnuHLLiu7k9rftu/cZNuDASpHhDeJln4w2r0HLXLpI6qE6
	coYQUCVxAeO4CBKFMf8Z9cnPCzyDNVUYBnMnVPiYW8R5gZSFgUhLsp00qmztkbFtqPP9FuWXyyn
	YA35xFlAajD82np9+DpvDfXoRURkMAH1szb4MmNFdL819i7sgZms6ZCW3woO41mOQiaj45wVNZr
	Ve6aabru///Fy5aMyTRv5w/CbicQhproT4vXWOPcDuk8RgweAFE06qDL9daLiV8EKxUEmN5h59O
	DbqahnCT+D68J+XkEvLkmEIdEm1uKtToToGWX8fC6LpTvt/119oTLHz0UHo19d5PYsDXgddHqsk
	tIQYmLwK/wrI7PS3ZliXS0unDbhdfss/LhnjtTLRTes/4ilsiLhUNGNGbsop0mUrci3ayV5jDyA
	TmwTG8EgvFti8X18/HGvpbyATQd4c4SDlX0CSgHzG6hUQgXlWC3rtHxcDmslFFG4q79Mlq/g6KC
	dXqZhNuKPCFU8p7s=
X-Received: by 2002:a05:6808:1691:b0:4f1:7c39:8a7c with SMTP id 5614622812f47-5640df628e8mr8758951b6e.62.1793722275736;
        Tue, 03 Nov 2026 08:11:15 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:15 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 4/8] serial: 8250_omap: quiesce DMA IRQ handling before shutdown
Date: Tue,  3 Nov 2026 09:11:00 -0700
Message-ID: <20261103161104.2449407-4-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

