Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF926083619
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=byR4iSN2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtq908pXz2yDD;
	Wed, 04 Nov 2026 03:11:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722276;
	cv=none; b=eSkBVJ5afokd9n0KPBZhema1pR0r1tjua3bs+RmIJl1NPQqHNCVybYKr9p52lJHUCk3UVogd/41Sb+ttSRmaCEibyLjJBskvEadTC7dzkB+LensKW3mAnWb1enkC6eEiS1RwPvIyToXxZzB5szYN3QcEtw5UQONbRK8gdkgINzo5ONnNbMf9hoAHg51FHsAf/dmoRIwPB/3zUHbXtxuR8U0OXJmmNuESBn8qEzwP3fo4z9rZBap6dN/lpB1vyFeumIzDxaViu8YHigTd8BXZHj+tDj7vqRa6bnYWEP/2bzdslH2bav59W8/OkvzhTjeDldXDvnUHdh84I+ObwYk6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722276; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1gbRzPRtKHQCUMV9aIsnXrWf/nEuZirnH1mLL0xnPdwchunuZh9gyjI7JSdeTq0oy+FRDziMERoQ0FB3w/Ecdgy4TI2NbyrBIIqPvbfXTdGWjhSP5+LBD8Yjh9HYB5LFIJ54mCHmX3i7KO5HMgE7NVqwGPVakvu97cWD8W/aKcY6cGnddqRvAoVznTHlVIy6zc5iMT811Aed+C5cwyuihBqsdy1iMr0mx5ZLUz0nINqw3TrOKpIJFVZDlWzsyWohfpKguNKE+Es9k4vSNeI+kCLuk3LEWyDMm7Jq3pZh2jBjDYE3eRy4NaWYSVRpCiU5TLlZfL+hVjVP+++Vb7LIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=byR4iSN2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=byR4iSN2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtq808Bfz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:15 +1100 (AEDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-4d7034a99a9so2735366b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722273; x=1794327073; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=byR4iSN2rErMx69X/Lac6QXn+mLmvbCEfSChGPDMgFfbLgoItQo+nDKeUme7VgrpRD
         GHgQcIBtHfCir6NlBdLqdFzky+tU0l9sBcRIrScz826QjEoCaBm9PIHUI2Q3a2/lyg8a
         3yw+hIjuUdDCff+LGmvn9eA72dEWweT0bRbYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722273; x=1794327073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=aVxW1trihgAwwwFzPf/iQdjD8Dl0TzoZ0RJ0a04hBcpGU5jBejUxf3Viqt2bKuPZ4d
         gGSPaiKFulY8gR7NjhpY/e7Qziec0wObtLda2CrKn7e8m9ximUeQVDFIj6G3M3Z7Rio7
         2XR4icRplKKjv5FpIx8MM3jp4ktSmEW8qjbu3oSzWyYiYDJ/YwNwmqjx7BBW4JpKik9f
         9bMjKXTsWrUDOgbQ3cKfC3K8didnsicnyiR3PAHlVe6AkMLTQhOyeBGd0oOutl9j+b96
         FIImw0kDFN+VUJ5xQYBLmAOfyRHVSWYw1YTAUo5fBSPqK/efZSjvHOXeFaHQD0Z/8BuQ
         2vtw==
X-Forwarded-Encrypted: i=1; AKwUvBwE8cgmzRz2g4B7KzIRFYyPYWZ9QqoMuhle6ncpXCWUzsh4/lM1e6BCOAvz3Hr1IVEJ9sHrHpeYnjzvdek=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+oqI8Riugi+WtylpFiZmA0AxdL06SETryDAlgNoNoTUx/JuV92
	6E299axFMx2irVNxDbx6MmJYPSrPD0B7D1R8mIrOc4gU/YJY7AtyPICEteDmcBqpzQ==
X-Gm-Gg: AYBFou25yetbaUV8FdD2MZ7a1GLNaEiK+keISElzG9Ce7U6VTC+uOHgd12ewk0v3XjK
	mTQJhZp5bQYm6AthvGXCXJweVOYIztsG1V4IxjOhfdjj7WD7Dmkwtu4C9/1H7tqASsNR7t62B+b
	iEq8fn3gq7RK7cl0YQ3CXxpjlO2/aP/Cwv8kOACQHSyqQm18JG+/hu3wtb6C259HKOs9Rgm67Tf
	B6mp1+rSJPDV/dA5GAdYv2NCizUJ3iRM3bXlB/P6uPfFSdXx2wN5SErVdbvkoDNnF2lLj/dklLI
	2F+CCukRlAtSsoSi3sAAQse+lw/qhIucR+QEyFuskgNXEICORI1uBlzRAzCe6tpb9MeKF6CTN4l
	En6eQ7k7GQcSCnC4m/SkJLr9tZ+O8jIY9z/EZEJBkuSRJOIjk+M/TtTgyq3xPfp706/dC9EHuDF
	t4bQjrIggkWPJGOD68Nn6/ilZ/pot6vYvo0KXQItWo79w2xFkYmMCxMtlQ+MmW8r80WI60xmi+4
	t2bF5RQZUx1lWdexHkS7nY4ue7/1OVjZe4aLn8ZR33PNnK2OqGauhEn1ve5RLXEpdob/uCE+xSe
	7xzaPfJ/8NSEq0K61DUZZQVLjTyPuQOk5yU8x5bDy+mC8ZDrIVPOdneSFqPMi75kWrx7g8kNNh6
	AoubeA2Yl8wax1SKu
X-Received: by 2002:a05:6808:3a0d:b0:4b9:e6ab:d085 with SMTP id 5614622812f47-5640dd277b1mr9216799b6e.37.1793722273221;
        Tue, 03 Nov 2026 08:11:13 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:12 -0800 (PST)
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
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups with the port lock
Date: Tue,  3 Nov 2026 09:10:58 -0700
Message-ID: <20261103161104.2449407-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
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

