Return-Path: <linuxppc-dev+bounces-29576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6EECC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 01:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5SdF30CHz2y2B;
	Fri, 16 Oct 2026 12:53:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792115585;
	cv=pass; b=cdaKOGe8pRIXcGXLHRy2faJksj6YvjpxvlRGGOVixY5CwAOwoZ/mb0CJbqnUFAwTotc5ChVYRVdtX0xNze3sv1GvjLivUY2B8IEuUZQVLJnRPqP7b/CZy7L0ITpx/BV0d2OJDx+ze1//3W0PKjtlslKLYCygLjgB8MLes53Et1zxOzFOXz7X6etWqbq+RXqgzVj5obi+4SirPYosVM1EuiCl9qwkho+Q4lmTu1XoK9fo8H2Nmqjoa7XOaLLuUfA9tCsiUbW19zbyM70ePQrJbPRHiXc6VOwWeAa1r9y3HQf4KvBjvlonXzJVU7HW5b3JcJJL59/IV6lwi9iIfcehMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792115585; c=relaxed/relaxed;
	bh=QzWh/mXf6G5Fr5INTJvXRytqPL/zBujlCdMkS18GyKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLEdTaQ83NArkZBrb96SV00lp11KQaKII8dWtgdOwoo0BlLc7bQLHrDR1JnqfAsEXoGtqxnWYfjRFogIexBmjA0azj0Oy8xqFQ/wkYrczzRrlbUxpTlLp+zZjTTbMQ5Db7C0zdo0YK9aoe033zycYBJwU1swg7W2dZf94CVbAfd0Fw7mz72uN9kS9VCEgViARyil0ZcqrNtO047GLeJ/So8hrqbc/jeAjdnZaJ/W35j4XXJYNcv5QQpoj5nRpzUmDVphOqm8qsT9qP7DD2Kf26eaZSDx64FCAbq3gj44qyFvGkuIM6ErlMED+6HyM1HvsHyckf6+98tgWZkxcYNLLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dlqqx3Op; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dlqqx3Op;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5SdD3nRHz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 12:53:04 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e95b3b52f2so8016225ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 18:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792115582; cv=none;
        d=google.com; s=arc-20260327;
        b=jxY/zwupMg9jmeFSUmJNVElbBbkGmrDNXXJADDcZo7LxVjV82heOxkWC6BJ/8bM3ZE
         tbuo70+oiyaiyRuz9itQ2GqpjA8YpKNd8FibmnsAoMPRSGAoqqPpHs6qYcnfbqYczchp
         Bv6eB5Fmr6Kn0IIPcowvq8vof7S2LNcTE215Xok0/FPEXYxGQ4VfuLMzRKQ81yrhTYDS
         /Vo3R1kKSVgNY1RZee1KY9Gs1bUJsoLpFAbiiAcNG8UA/tkXWbYg7j6CiTphATIF49Hm
         PaSszsViXon89RqYFuj0YSas7gINd5SB5D1OAOWNJxVRJf6gWAD77GEzXHIh3WoDjYdw
         UHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QzWh/mXf6G5Fr5INTJvXRytqPL/zBujlCdMkS18GyKQ=;
        fh=e/nCNzl4HM8Y+xymjRPN/EztWeELAqfcDPdFr5liuT0=;
        b=r+HCcESuQAwbfaOieZtuHRSd/XsNLkQhBSAUBJ3kBiuOxi1jhweNWv688E+pZioRm3
         sS0ZdTlqw/OA1PNCLgVuT6gBVAxvzSCp+IWUWRIMmUAzkZp0sPXQm4dadWX5TrR7YeIP
         zPiE1f9UZhNH3MeDJ/fC4sobKPIZpzIb5oLWazXzjS9S0F59pwRa8K38B8dN5DBg/6JK
         gx374dKSHMkI32JPzij4U3DdU55XD/trqUqLGshToNZSsq4AjkzN2Ykb+D6wjnwgbwaV
         5pwMiLzYLgl1b6bbpLjmHvQ79AOeGfge7AP+9IDpZFQKnyQrBE/Yw+H5y/vprwnhsIbh
         7gxQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792115582; x=1792720382; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzWh/mXf6G5Fr5INTJvXRytqPL/zBujlCdMkS18GyKQ=;
        b=dlqqx3OpjkYm3odnFKvoB8AN7LeJ/F+YukmWtkxl8Ilbhe5W+bECk5IplW7lUUZEt7
         f35FWVxPgV2bOJaKM5KSM/iFyp0wUzYo4xZwaMimxPbvpvVJv3+AbFxA9+lmZJymyyEv
         It2rj9b3ohZdSrj3KMH4562e6fSmoTDE+BTaySos5D0aQexlK1rcYHqkLQ1+m9/7bZy6
         9Ybdlu+EasleS2CLBP2n7qul0nNGbpzDhbZRbKeIjM2G+Ohpr0Igcg0wtBh7RR3FfsOD
         E8d2t8+Z+lOUZ+VhyZjGNtQw7qj1/5RFwxwK2if2/mYBj2FzvSK+pYGuWq8U5Wt7sMgR
         MTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792115582; x=1792720382;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QzWh/mXf6G5Fr5INTJvXRytqPL/zBujlCdMkS18GyKQ=;
        b=iyP/COwm6YaWXljuGMtDLvamkEG9kYZwkOg7kXqeOpyGL+fowaIA37S1TXQUDQjZ40
         IJpA4Gr004ID7//QXCdHGFGKd+YH/D7ptvnTVncyyrxywsj04gYbEzIVTNGiJTmZlo2F
         2eS0PXGrdJFq4kuBX4e+3YQMjMfXhkv3+j3Kn6NTMD8BZSruBx9Oi+tGGVtT/YPFjae8
         kfmdD8bDu1wGHDAplD/B1tDCUx49q2sSRY1BycXRgJx5yDEeRxQrlhX9iGkb8xj5Y+fj
         8zSKJ+5yfHGTXvLorzV6cq0s6UD7q17cz8Bm3K5osmtFDQV7Y0cq4DCEmxclbax6LB2R
         /+EA==
X-Forwarded-Encrypted: i=1; AKwUvBzgCYz1tb0vvGFRn51q/jWA5V6wEWUgpm7nLAt6gj+BAt87OedfeZW3kTmJvFlZIfSrjyFws1tD3PFHpkw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJUngp2w/kzRUHn7AM0haEZ8psw4nO9u2IoFlBWI/1/iqnsJPvx
	Ez72frt4BCSUwgK6FUFqPXQISIoI8SbVrDLTEOC3zD46hWCFIf3xKI7am6DqlUF0rcih6nb4y/v
	uvBJCZIWw4Hqprx3vcO++UFcsHZfxDPI=
X-Gm-Gg: AYBFou3Qihd6cCrmmEq15nyJdHFGSvsUmNVGrVC9yHCApSbNiOud0KZjpRCADxUpBfc
	G3tQ+8QIOeHmycIgjOxbShakvNdRV5c36YEA1rE7LW1ByAvO2hIE/gNbxFZiu//Z3xRA+HtrKyr
	GZIq6lvKshLC2/HGUS0zjBLMzDHXwFvaD6d/yS+5qlVVrfYY4CPIO/ywrc1r52BmZZiGmjjSWeS
	oJnlBHXTaJ1PmSL+Q5hc0ZX3XoyIrpfIISq3uMzMoNNdgB58kq05/oSs10dJw5e5gs+5gJPHaSV
	BRgV+KUx4zay4i5YjYdqzdu2kvXgjHJHRe/maHJYDrwF5KxjQvyCeADAHxII88fWIoNs7KoTC4M
	aeQXzp12Zn5tp5Dc9A6GjPCX3QY3+40BVjlf1JTunXbSbRmiW6MSvBUvi2bnZoKb1eJk=
X-Received: by 2002:a17:902:f641:b0:2e9:5714:608e with SMTP id
 d9443c01a7336-2e957148bb7mr48721225ad.49.1792115581670; Thu, 15 Oct 2026
 18:53:01 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20261015014324.5569-1-phucduc.bui@gmail.com> <ad722297-5ca5-42c5-a07e-59fa958387c1@sirena.org.uk>
In-Reply-To: <ad722297-5ca5-42c5-a07e-59fa958387c1@sirena.org.uk>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 16 Oct 2026 08:52:48 +0700
X-Gm-Features: AclHuK85_RuY5Eq4148HpcAJND7CX_R3cPSTmudMqJuFIrc_MXHUz5ZN3dyw0W4
Message-ID: <CAABR9nGU0qW6iMadffrXw86a=ty=FVhw_Ypoa4rQtwOCbepVWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] ASoC: Fix constraint return value handling
To: Mark Brown <broonie@kernel.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, povik+lin@cutebit.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrei Simion <andrei.simion@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Heiko Stuebner <heiko@sntech.de>, 
	Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>, 
	wangdicheng <wangdicheng@kylinos.cn>, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Neo Chang <YLCHANG2@nuvoton.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, u.kleine-koenig@baylibre.com, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Md Shofiqul Islam <shofiqtest@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Zain Aboobacker <zainaboobacker33@gmail.com>, Sang-Heon Jeon <ekffu200098@gmail.com>, 
	Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

> > Changes in v2:
> >  - Add Reviewed-by tags from Vijendar Mukunda and Chancel Liu.
> >  - Remove redundant integer constraints already applied by
> >    snd_dmaengine_pcm_open().
>
> v1 was applied, please send incremental changes for the differences.

Thank you for applying v1.
I'll prepare and send the incremental changes soon.

Best regards,
Phuc

