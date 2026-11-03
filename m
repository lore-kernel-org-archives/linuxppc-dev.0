Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F78606D833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nR1QZlFn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtq74LBbz2xdX;
	Wed, 04 Nov 2026 03:11:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722275;
	cv=none; b=WVJno25qI4g5bhbPItihrjSxZ0tl3LX+5I4eq8i4ouXQVCP+QhT8lsUfQV8LAdd9yvwsee8CEPZ4DL/fj14hu1rnbYGHMW6uqODKUbMWHePZYBmxCNFGxqsnt5LLY527SZQEs2O+EDPF7hlc8KDFfzWxl/QOwPAxDZ48tqUqs+VUZdzJp6e8DpzI6SqT6qXZMUvbJOpeiM/jEOctS/Ba+vdJniClqITeK9eueqmV0cg8F/KSeNFHEqGNJcdF9dwi1Hp0Ur8xM5x0zMuv1jLT+0cLuolcxpPVnhqGwpe44eug+BX2XUwM/S+2fQcQIh0iXpwHzHfH+SVVzG56FQdhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722275; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0P7XwTkfZ8RLHvcJ5P6crnaByZEgl5Mk3BmqsiSf7GPX+x3TQNPQWwmKmw4b58FVxsKEN3ev67zD1zAuBiEgeaySgAdI8lltNA8c2+efk8Jn19etiM2u05+brkiJo+G0NCn+huGJLvKNg+4C1jg5maWjq994+ibA1edUnY3+xx/UDsSmdRXeDKx5jewK/5E0u59QYzVSmL+i0HwW1hQpLmxQu3xnYBkzyS+VpyMO+bYGUbpECsAOOKVsqGhQ4ZDiYws6uZozWkmtG3MJopwKiFMaqoezdEgZu4wOig9ucyzN8ruEGrIyMEVaTMrDgzXU3AJ71AErewTRXHJHGKvCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nR1QZlFn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nR1QZlFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtq54VFNz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:13 +1100 (AEDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-85c1135c286so2789895a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722271; x=1794327071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=nR1QZlFnPaDYcYY45ed/bH6NaZIk99gn88b4s6qAPasItFYy/5zRGyGSrNvBV+Yd8L
         l1bP7ChxhbWeB3OFjUKimszIV/oV2uRUo0ash/A4V7W6tM8BxiIr/S96Q4hL03rt/GRV
         DjNtvCv/9dMmjWpoSqI9Pdoxqg5ADV425jVEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722271; x=1794327071;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=v44ca36ROm1J2G/4F6p22fhpTy3oPS+hbNfLmnWjO45PnFejw/ed58vHxcI08+5PEZ
         B9JYG2nv5N9Ke4zGlmI86jRp5zfSdLSdkWNSm3W42veo9r5jZ3gGm8WVkLA7kGgu9LAT
         Y1iTHPqs77CD5Fd+LAcvdAYOAQ8qAyvHEXTdLKG/Vy4VgVMFnK0vuSBbQb1N5QdgmmxB
         H4G/KoWBwn0KrLO14v5r4ACY4bk6xsLRZkBtiOxn5YZfDxR/L46u28myZhUbAAgcPSZo
         tNLWU5JtseTZX7ZMIn+KYRn/JeVbmoa3Jm3O3rMothrPLEhCz8ooH3NOZsd3aa2LhwBW
         ULlg==
X-Forwarded-Encrypted: i=1; AKwUvBy/uwJ2DeGQlsJjWoJsc8oBhFfFlysGmbRDJTbrItGT11JVITpkqb8TqrBO3s4P1vNHg806C5J+qR02obs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+TChwEvwwEF33rcJ5H4v6YQNtkJNVmlEUF3j9d2aSB7I9XNawV
	uHdwDugbvWMQqIeMigHC462nE60p5m95s9NaSUqzdpZG7DJSllGVIWqSs++r0mTZKA==
X-Gm-Gg: AYBFou101EhZhytvkZ8yhFPHKtT1CfSD/NviDohfmI/0VijQKsbS/+xofpk/Utd9bMw
	+oxaQJbpsQaKEO3uVDoptskziDqFCcIu2dmFTFYWd8BNRaK6J/6U5pGBdXzTPTAx5tjkRTv2OiT
	o/pV/R4M3pAUZ/aEUNOr2YEQf8SoYI2iNXJupTHO9ZjyLvZpAu3peP+p/rRnG1uFCNMOquu/CD4
	2+atwIhH3Gj68ytSr/U2DA9n7d39fb+6GdEOrXDO5yAPDuExXYUqm1lqvHXMYoqU2W837JBFwHu
	/JFAR1F4EQChjhHYNCNppIsx0psZoRImd+STfjWUTU9+zg8f43mWEKpD1tFQAv8aTOetqRzLgBe
	MO72iDhyWdKVwCOcAFUacKMAqiJS56irHOKa7nazPwa1xI2yMxcPuqoyZiMULkH4oB3MCpNq3Xu
	nE99+SkHsaxflT7qJrYz+7CBBRdHztBCZQeuJKkxE9oxAL1jTa62JpSgh2ioPIvdTQvfYuo4kng
	8wwgktEl4rs+5lOqwStghoz9Oo40EW+8oi79KgI1wk0XZc2QTSwDS+2tQefv8P0guhPtR4EwxiZ
	tiueXgBijhO56ffc9W+HJZ0e8kwpP1B7lMhgo/deLFbGzWqoZ9uvpPQ/n5sQaHuLjJR8UowH49Y
	km/BPP4GsryEFMM4Dbj0a+gTONeyaNTWcBHze
X-Received: by 2002:a05:6808:3a0e:b0:4cb:f21b:6f8b with SMTP id 5614622812f47-5640dd9d763mr8688402b6e.30.1793722270713;
        Tue, 03 Nov 2026 08:11:10 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:08 -0800 (PST)
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
Subject: Re: [PATCH v9 1/8] serial: 8250_omap: separate locked TX DMA completion processing
Date: Tue,  3 Nov 2026 09:10:57 -0700
Message-ID: <20261103161104.2449407-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

