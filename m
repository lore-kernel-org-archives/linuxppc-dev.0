Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE084606D624
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HM6inVUr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR33y30lNz2xMt;
	Sat, 14 Nov 2026 03:43:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::12"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794588222;
	cv=none; b=iwe5JIpRjAXmCIWPStC23/fzmK7p47zf0KZPjs40cue7wgIUXFB1IW6LzYVuJvkXLQkBmYZGtD4Yttwotkg6Pdmo2hl3IVK5SUydSeJf7wEE4umh330ViCs0Pt2FtxWYSGboV0ft4O0FPFhmkuZZNNBWWB1pH3Pl9boWqsGyOPHkc56qdhqSSpniKPu2h+8Xc8Xdg1M7RsonJzu8ddKi0GfvVEYtF+8s7HZbM2/vjOWxwNJevI4/Chiv+saJV+oklEIIMD7cu4/2txL2CDvXzIs7VM50D9o5UI5tnANa5zc9ipCVF0bo7toCvdQNtp6RLcLf7+DhSUMnlCOmJcvM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794588222; c=relaxed/relaxed;
	bh=Von8RsBp854kjbWitsXhRdJUlu1QgEP7MszYVID9w9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pod06WQAfs8Bmru++FGgSjvgMTLZnJqc5eqCav/8gWSU3iP9cqSaF6g8Klb44mZE2RWAtq0o3uHkRrHeXCNg9cXGejjgGYWQHRu20H99qeoMXeqLBbjaJkMzuTjUQ0M40Jh5iEN2iIiwb3dQ6pb5wyo1IqroiTbuwIyzibmoHbmJ4IQOhNyUj8B1RyAZryUiAUULbnT1Av9Hs21m+u4fvt7ftbCNPGYMJZzj3ZrorJxs4DlLQGFZbnyQT4K7jbZI8g5XDyjzioHgN8Yt7zbW1F+RcAUOf3nOfTmS6jaIY6BfoDyp03HANXyx5GxwLsaosf0MUHlqoeCln+KFCu37Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HM6inVUr; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HM6inVUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR33x4Kvyz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 03:43:41 +1100 (AEDT)
Received: from L30177.local (unknown [158.255.110.170])
	(Authenticated sender: vjardin@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id AD61613F92C;
	Fri, 13 Nov 2026 17:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794588213;
	bh=5xzBNkaSBIwsby4+iTJvSunuWxT8nAvHfJoI83KVZUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HM6inVUr3h+5hT4j2wq5zg5TH/nz4NrbKLsWvdW8BDitD52J8P8MDhFA0EiO8bDmV
	 mCuBvX4M8HGeSD4Hn2JFl/MlJ+y962RUhxuAubENIx5f1Cu6ZNckGAqfu601STKc3J
	 dsH6aqzOPE5d5WQwxhWCT0OMZJQVVuV4hZWJ1Db0o9cr7q5Zqq2WbrX84oBMkMDoBh
	 mM96MfXiI5GqohedOQdIRui1XYqXe6A8ypHHL5WJdWUht1PxLFs1okuf0eFd3tO3H0
	 zgw38AiCs4gbZp9Gc4sU6SmJ9WA/IcEkgbTkax1N+eMdNlmu+UPQcitr/rU1VnMsNb
	 Uof0sAubw5Tww==
Date: Fri, 13 Nov 2026 17:43:09 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Frank Li <Frank.Li@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avc-HWnGVhhR3m8J@L30177.local>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-4-5a0063f1da9e@free.fr>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-4-5a0063f1da9e@free.fr>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank,

Le 08/11/26 11:06, Vincent Jardin via B4 Relay a écrit :
> From: Vincent Jardin <vjardin@free.fr>
> 
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW, read-only in RCWSR12..14 of DCFG and changed at
> runtime through the same fields of the override registers in its DCSR
> view, which read 0 until written.
> 
> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> gpio to support bus recovery") Linux drives them with pinctrl-single on
> the override registers, so its first pin state clears every other field
> of the word: a board whose RCW programs a non-zero pad mux loses those
> pads at the first I2C probe.
> 
> Add a driver for the pad mux as a child of the DCFG node: the fields
> of RCWSR12..14 and their encoding.
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.

Following the review on the patch 1 and 2, then can I have your advise
on this topic ?

I am looking for the review of this serie, then I'll adapt it
for u-boot along with the integration of Linux.

best regards,
  Vincent

