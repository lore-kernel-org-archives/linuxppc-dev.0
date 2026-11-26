Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDF606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZIGQt0M8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb3jd0HLPz2y2h;
	Fri, 27 Nov 2026 04:40:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f35" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795714836;
	cv=pass; b=HWUh0EalY9MEO3dcGoupTisk6WugNYqWjXs91zr8/P9j8iEeJeU3z4P+pETVocTd5iORYVX47g+0DFC4GuP1CD/lt2VeBkn6eT6nrNetvfdus2zftRJYumI+TsQ1mdBiTD833VZPyVyRGxUd/Ag1pbclOYEj/TKvjkg9ZoqhSJWeDQrWPEGnlVMeIBJxpyqlAQw59V3CqKmNvC3Rnj0RLFr8cEEjklVANPmEOoKjGgfBgY1TZXeRHtCd+j1Z/gEvrldpprMGnOTEV33kaYLVY1FRQWQTpbzEXsOwGGGTj1nDudufr1afpSHy5DzY+6JJWESH4ZyyIRRqWAWJlU11mg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795714836; c=relaxed/relaxed;
	bh=WnUI0hkBPpSkdO9GvSJqBbk00QrZu2iiDVFhG7JTP+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9IN5FY4Od7rtlDvohJufFdUxf42iFvM09/sucSODd1kPtc6gUvdAvoWLNyEiqgJ/dgcllf07PoQU1wIKdkvWCrTFNbEmS/7Ps6WOhkwQTdWyHndOReSANdut0XYS6Ir/u3YksorqTv0wsnfpN6+4yxLbKsEcCm+1yDetVxIwY6X1/YKnY+Tmm7LnyA11W2S1LGUAXsz16naCzsC+kjGf9a5WZ+xyvJoNiSpxvhHvlrDmQ6ect6D6ifEHKiaj4/lBVpPV8mKGYF7WpdQDeI+fKiEQnqViPON8LtVYPPNG+NtupnH0yjYScRNjks7nqZw+3MGh5iISb6dzt1qjozIbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZIGQt0M8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZIGQt0M8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb3jb527pz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 04:40:34 +1100 (AEDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-9213e130a16so41773586d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 09:40:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795714832; cv=none;
        d=google.com; s=arc-20260327;
        b=MaIYk7RU+fvYCHYXZOy4tIrWl7LWaJRyXtcwideiHbAInFC55kaOMcOJxJDiq/5VGr
         lUzSL3kYRSdIN3XOPIqpS5KKaVsu1le9g8FaZEPf61nWB34FOyAhlvCOaMpRQ6flf81A
         hw5N06gGiF5yioRZAiDTgzR74XeXFareGLm/wWHzvU/upbL0svoVBIGsMzSkQ4MI1xWC
         2aWTx+X0mnRSbl6IoUaTVUvcDGWU1/hTl/RmuPM27nBwqf6FStnIj06UjhyPOaFYznGv
         ppaWT8D0k6TdETS9OlpXalFmaxlnVVsb15nmQfZViBEQjZScWIWOBn9NpfduNKQk1TP2
         ynfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WnUI0hkBPpSkdO9GvSJqBbk00QrZu2iiDVFhG7JTP+o=;
        fh=ItJAOar7XV1/usE4i3xwqjpkNYDU0JS6BpoRKymOydk=;
        b=YiA130pHNfgCogCGm+qpl2VWva8/6tHJ/Bp4/j2QHMsbw1B8OHLR5YV3z4Gwsyipyz
         KjSrprONtA4vkautJ8iYzXm+AD5n7NxbOGEvuRJndhi2Wxw4yr+WCgViz7FecYocWf2s
         pNt9Z1ZLBKAo3Oaw4ePRsVyUgqxaYuQz6KDIdO84bq/liE26OWU//SYADTF9dH985lgv
         HFcsjZNZ2NCXRACYuzJeZPvHUPAajFrE9TQPgN7HU6B7wiRdAUCMjPgv35cTimHs4TBf
         Kg6wapMMgrXTCjOtKyPxoYrtGJ2E2jYyeuAIZYs+4NcshJo7hd1Cdg3UsrzqD0kRHc+Y
         YidA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795714832; x=1796319632; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WnUI0hkBPpSkdO9GvSJqBbk00QrZu2iiDVFhG7JTP+o=;
        b=ZIGQt0M88rM8UrJeK5PEptfPiGsfqS7Q/C8ldN5UyWY61wE8ipNZlLXoT5jF7HVEig
         G1oePSeJ0dof4dnpkKQbl9UbvdXPy1J1S7gX6hqKTtmrNovebGAGncKymFcdCtimnLK6
         KzxAa3iY0FlcFVpsAI/N3Tqkz90TaVVRBbLfXTt18YHxi2CR9XeJyxJZnxh0hBmxhHJ5
         YHiU2y00yGSTekVHSkbIDbu4ElKmzUrlnkAPPMLjC3MAreBXGGYNz22Olb2jYvQLMa+y
         hErCms6V4C/irVpTtRzGuiSfUjzgOoW76pUpz1NbblFH/gLieHo61W/BYsg7fuEN0Ucp
         6vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795714832; x=1796319632;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WnUI0hkBPpSkdO9GvSJqBbk00QrZu2iiDVFhG7JTP+o=;
        b=Gpeji5sb8MpoTGiVdHOB5Y0kAP8qQagNvGosIi2/HFbtmUJHsSzvNGIO3TwWxcQZte
         OiRh0zw9yAyWxL2mjw41nLDAdRhdDPD0JSGH1WHkgI4BliiGGUeyfIzlxc2R4tA555jE
         3MiA34JZb8P1oBev/dTvzPBXVYYKIZ15li0cFlACfmGR2lDZcOJEBOR/1+7AB1omk+1t
         fbSsg61/9oAQe1NlpnV0BXeS7G1cRCnL85h23N770pjHSkb3pTG2rxDjYGR0xNnpvq+Q
         4dijuyjRY3Qu76lHlQiIs8ii71yJxbZqVOi+sG+391p0rN2800KfYq9af/fAozsQU6mz
         khpg==
X-Forwarded-Encrypted: i=1; AL+hErG7Uyq3sbDPEtflM0IReQknq9ONiwbJbrizrpM2ZgVcTJ1gYAHjEq1mDAy/Nsv71ojyz5Q25yMVSPJPIqU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8EzYHMaMwo4no2tG1+S1Z1vRrXY/wWG5Zi+9y1NA5ZDHoFQtW4
	biEQuFWcEiK4Kmcy3F4xrtba2Iujgaq0qeqIiM9UYkuU826a/4PZveHEhMKjgPxKbLtwDYsJ/i8
	LqJEsaB8KlN+3U57ibtoyXQs4j1xvD2kpxwFSc8tYKA==
X-Gm-Gg: AZFdTZfhjQUXJh3yxs79ltMCPqHtx/9j+BCi0Q4GGbYNDbdQ39Qip7N7C74ZHxGaI0C
	SUdeKLxO79NXPfF/kz98faEONz8gZZj2kzeL17n0uOCA3M/Beh5DZD7oweybvkuAFXV70EPiAMm
	DLcPFzGVZ5CftglAmgC90itxZUsCuB5boLGqaamKt8MYq1FOgtTamGSOTNzAmjeqaMe33FFWdKO
	XXXzI45mHVrXuDJ16mimFkk97luELLoMUFxBIf3Lo2CJ0eYHbJ+nZXKSJ2dRct4pI7oP5zHrqOz
	l+cMvL7NtZvmx7N1fyTb0GvQtk/LF3wnBHM9G6fyFprNKErwynOQFd1qfPP+vTeI3qy+GRj/zzy
	UV/DxoTYzrVx0bt/AFq/wOkLa8ar8hgeb/B6+Nbf4q3G+9MRxOgfE8Lf3MDHyqQv0QvxBVd4=
X-Received: by 2002:a05:6214:3c9d:b0:91c:9316:f4e8 with SMTP id
 6a1803df08f44-92134baab8amr374316166d6.54.1795714831544; Thu, 26 Nov 2026
 09:40:31 -0800 (PST)
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
References: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
 <awcZcuSbse5g3FWK@monoceros> <87v75jyiw2.fsf@bootlin.com> <awg4ubbFu0FksThB@monoceros>
 <87a4mvwv1b.fsf@bootlin.com>
In-Reply-To: <87a4mvwv1b.fsf@bootlin.com>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Thu, 26 Nov 2026 17:40:20 +0000
X-Gm-Features: Aa3M54pTYXahjqTv7_MT1I1wEAeHDvmXQpnCEn41MhhclxuSVrfOIbrke1NKz3k
Message-ID: <CAA6zWZKPY-wjq_sbheLBK-k1b6rCdXs353b7j-fTYB6vTGLmGA@mail.gmail.com>
Subject: Re: [PATCH 00/10] mtd: use desginated initializers in *_device_id arrays
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Joern Engel <joern@lazybastard.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Michal Simek <michal.simek@amd.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Han Xu <han.xu@nxp.com>, 
	Paul Cercueil <paul@crapouillou.net>, Harvey Hunt <harveyhuntnexus@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Liang Yang <liang.yang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Linus Walleij <linusw@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	imx@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Let me know what you intend to do.
I might as well address the nitpick since we are refactoring already,
so please wait for v2.

> Not related but since you were removing the /* sentinel */ comment
> sometimes, when do we get rid of those extra entries entirely?
I don't really know if there are any plans for that, I certainly will
not attempt that anytime soon.

Thanks,
Pawel

