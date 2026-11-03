Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D7606D80F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=htbPpi9v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtq95zM0z2yb9;
	Wed, 04 Nov 2026 03:11:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722277;
	cv=none; b=KBLUwQPuZZhZQ0Dv6xnV0pW7LHES7SoGRi4IYbmYTWQsU67XObBYwo+shkw5qQCrneMp+GCN+XJhChf+nxOot9PmGe2ZEfUsWCDFamOwZ+oHhSxRStqcuUVtQrxXfqXwkhwoTgrgvycqJOZKRZmiY/bncQHdXn1lGYN+LfcugP1OB1osUAM4EVHTGwmVaA2fqDx7RTplgYS2fzWuOlXTgMYkb2+/2Jqizj3wGhRRbI4lapg1Omp1lNwGK8VVtNXltRNm2kBDYF02zdIfc6GicMjWzFxQ0LFQQI5JQN8WAWvK5rhpF5CVUvE1gwwg1xa1f8VUR3fE9n/z4lg2uZsm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722277; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfPJ1WosRaVpI83oS7fizopQBqUyp5+PJoHJrIMNeWGcAHGA5WFPraSU8KsXd9tqZRPAVhTzIikZsod3kY5Lhf+zpDN8ZKAgRJ2y9+YHxfuvQnm0dwrSXlyiJEEIBtEueL4c6ZiYSmYdlFBnOG7TnXuAE+21p4f7fAHPhhjF33IHIXale1gNtIWsTx7Fju+lWLFiRRTg4EhiPh5IrslhG9gyf2/VCVydExTMmNAqsNAyAX70/6Sj0vLS6krHTkpZiJXDUjAuUJW0KbQ6pJGulBjHpDWjdvwcWnMxFWkRqEp76RIwlE3M8OzOhjScyMd/dAd+NqcZzpxcFw3hv1migQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=htbPpi9v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=htbPpi9v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtq90PwCz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:16 +1100 (AEDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-55e0090c580so1463269b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722274; x=1794327074; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=htbPpi9vDWpKESBY5RCYgCa9Dqw86Jo0ILwN2rE+ZPh7i5/Aut/OI6rfmsA4+elloH
         Bv4uO7gnFC+r3/XeZZvbOWA3e6lf+SXf5ZIiLxdo6Hcd+anPCcrxipaiQDNAY+oZPf4B
         3DvtogquXEFmTVLwa1Pm9jy3Dx+BECKVw60TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722274; x=1794327074;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=yfWxf9Gn+K94FaudOHPj5kIrnuQHSmNw63yyPn9cy88yzO5GgBwKgFCmTAZtPdIns2
         kHdRtEM+ENhWrYJ4KkLC8fnAwxPihNRwyAk9MWQ2hVkixn0JkDnm53A2GmrmN6V44lEB
         0SGZoh39Yu+VhmfHBKS3Wdji42QvbgG9gCG/TpcPK4P5zlcBNFTJGjP8KdAz41JLnF99
         2OAYkwXkJGGEp74tw3nugzVKsrUp+SyXGtnaLmaxFDDpL79ydVTuXGG0dr+BWCvhoIs4
         m955WD41k/zPDLZx6NFGNpzrXummcaVddJXw03A1MoFaUSL1YmD3BZ1YBllCriuy3TAG
         xLVg==
X-Forwarded-Encrypted: i=1; AKwUvBxQo3SdvWBm5BKQkK/ZYoCnpAVYL94MEYa6vz2ojgchYFw0Vjkn6250ZcU0Du9gPPMLr09gjVwej+W+IN4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Fkz1z3pUsjhnnLTRG7ONJr0qweB+IqYkNv1GAYEJKTMbj6eB+
	FeBXazF+mGL1YyVuO6FRHAijW4wrWRZklN44eehQxA8RzS35J8NeeCtEOoWySySruQ==
X-Gm-Gg: AYBFou0fbBwL1Zy/pIdRo8kNYLsmi4dzUJz2P4zlUsHI8IqPypQImaDaQo3/+iZ0nyx
	j0zGHiD0tvM2EAhnGFIr15m4ROhUQKuiZINNMuo+jEabvOAYtKcBUA79XfceTXTypwFO2X+6RU4
	FlBvHvSgj3tf9AbVNPDDhVh6dLUgptiDftgIg4PJ+MOaXY3LN7lYg4NQZfJTtXvevdr/T019qKl
	dvEf+LBbWYXH47Vsaloz6ifKgg7jj1vB1OqDufdY5uZrIpVsSZUamUNqK30bqiw6djGoH9Kx7SO
	2zThqOadpQ/CPHBnqH2tA4Q7jfywjEFKgF9rGM22KxC2W2uUM+9LF+yOm3YVxiE5islc3Nd5SiJ
	9oXCSB/K7u2xgmAOuFGttmr9yWMPQnhGTz/GAWdJCnOi4WsmuIWyQqW8EisDgh6j6025f+GPLgd
	OQsqivnKRXU001KXo32IXjDurekIle/Mngt5WCmIG5zQ+O4jy4m4WwoosQm9H+uFungAozrcx30
	GOvwaDIduneNf0ykwryN2G4eAjoyLtlxjsocHNzcD+JLcC6PNsELQ2D+DmDRIBLK2maq4Tj7EI6
	WdyVkgwRlGe1wwFhStYR072yDfJBwGMDQsGBmQyiWTzx/wsH3onc3APw3P/lcGhCiPvFpPyx7se
	K7rVIU2amesdUQK0=
X-Received: by 2002:a05:6808:17a9:b0:4f5:7723:4c9c with SMTP id 5614622812f47-5640dd9c160mr9485684b6e.30.1793722274540;
        Tue, 03 Nov 2026 08:11:14 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:13 -0800 (PST)
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
Subject: Re: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion and flushing
Date: Tue,  3 Nov 2026 09:10:59 -0700
Message-ID: <20261103161104.2449407-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
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

