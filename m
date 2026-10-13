Return-Path: <linuxppc-dev+bounces-29344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B67CC6B0A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 06:04:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3kLx29Ffz2y8f;
	Tue, 13 Oct 2026 17:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791871481;
	cv=none; b=NiUImHkMKYzxstN1oJR3o1BaPuMZ+POX+cqf+WZnsb/rilmPg3kvDtlEztRpv+BqIlr5jewLFy1yWg80QAAMo2lnlQ251ABzyio0p2AbC3xuQgM0i8/RjUYZc94Ye1dC8SQ/C018JTEeGl0Vc/M6DYpUBkOrLYtoOIJp0NpMN4DSIm3mrBLCT4OwTOPTDpIs+xWAh5f4DpUGec7GCFUFSY/9gV8Ac+a7krFfM2nZvC1gJKc8tFKsh+ThcgUlbLD6G/8e8zT6RBYOpXbBaW9M4/TV8umLfWQJAXwaC6dyMP/iJQ3g13ygdOUf8ZjY/WAW8c5ileeSdvWfVdszf2Lq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791871481; c=relaxed/relaxed;
	bh=acEtVgfuadFdXlisXUuNZxKScLo0hQqEFXfuOZQe1a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMqFxmuG0cOEL2H80CCV1IJUinbQGXsKjxFVYWnsN7IceIRawNPFBDbkujE6IB/djF7+Ygz+fOxKabCrx7WcgpjkG1fXU5xb31XNMDXXQ4iERqwoYnGP8xHTQx/Z7HeA3TjxrPJGnIlqIaXR602xjf4jg91Ojz2gLPbjRJql79M3TLSxSjGMIEjtB1PWA/zcQo5PgrYMXM61zUIq5MtF0IuD7GIellsNvwoFPqinYJ1LSweSkgtrwayHLNHEv0tQJiJnt5iyH+ysMtEouRSrBtxNYbTfPk3T3Ry2nFyZoeVRO1F/UVcKQ6YEz5b/Xg0rEmGAQbKsyzOAwqCgUVB81g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlgV3fEf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlgV3fEf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3kLv4HW5z2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 17:04:38 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-381b831d535so3040716a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791871475; x=1792476275; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acEtVgfuadFdXlisXUuNZxKScLo0hQqEFXfuOZQe1a4=;
        b=mlgV3fEfeTsQUMYBIUWPkanfz5mSXZXZaE4nB9z73aEHuCZTx81xw/m1RhkFvyofnM
         NZzgn5KS/pGdfkIZNVxudAAsV6C6D5oQ2HttronCUU6VWwmaI4DTyjaMvOLPT/pPCl+E
         BXjFIa53DVFmp6rBy7+2K1eVTbzbYCpZXf/UomFl8K2J3dp44RYhEoI4gykJW9k0PmbD
         V3jSMwkEQtgp0e2HWsRlUIav3FXT82JG3agac1H5jGjBorcedMYdYpop0KnhbhA2Qec+
         gKiHQlK+LvfbYMDGmw+qLCcQOZzsf+hV206IiSZYIQGel9p7TmqOGSdQt0e4GweK2hIv
         ayEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791871475; x=1792476275;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acEtVgfuadFdXlisXUuNZxKScLo0hQqEFXfuOZQe1a4=;
        b=1o3b/hzM3H98waesvHOjp4Mr62gI7BIkyVcqj6nZK3M2va79bunYU8AXxy8gS/69mT
         mk7F52hJ0Vzxdowz1561ozMjmeLpg1lm7SqhXT2bBoaDh2aW3Iky9w5+M0Hzti/ID+k6
         WXJmx5qVndNGnMrOOZiDqT+dhvuJXxo97UNHglU4cUPFFsIhkxP4h95eVGUKKFx+q7kJ
         Z78BgyQxHT1dq+ffyZNj9YtQD1EqcAk9MRTGVvRsZiPueNU3GIS3nAys55xkVvzXup+w
         Q8pOIh6MfUvxwpzTjApgdvStsVStc9XwLN8Z9PRdwsANJCGOlwRe50mWGKKeYb7gE7ej
         E4Qg==
X-Forwarded-Encrypted: i=1; AKwUvBygw7eemvjtc6welpacxwPr47D2XXEPae8oZyFPJP/ZiQnFcg8Uinja036kOOr8U2Bn/PRhIGVtYdsCLFg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKDJJV/4BdPWn8BWMsI+KW2J2ZlL7erO5TaHSI2YNt+JJye88aq
	kggRjZy7tNy6tA2ePBNRJH/lY62Z6A9v4a0U7NIrvYA5zVvxXi03NtGm
X-Gm-Gg: AYBFou0o3cCb9aUFlAsHwhR57A0E4etDDlX0/UQaKHbw28rGOxTcIH3W58XvDbu44KU
	sSi+kfNvo4G01XimlQSi+K8flZXPnH+U3/f9UNU+RVmtSB3sdE1ERlP2ega8ut5UDkkcOkJJUmd
	WhS47AsfhIYbzuRU2ndcQQmHgvXVQmYFyPBNxj5DkXKURlfwNxFz/oGiYWylqL8PZj6Rh8yBl6H
	0hA4RpN5n6jKlc/7OPo+iRwILZbPMPgDU4nLt+Q8EfB/wgbJvCl6I88ipyl0tzTOnFKiES9W4PT
	vw/pTcwL2xThTFIN4QUWkroiNihOnKIa9Q28ZGxUONqIwRCx/1yFywXq9vTINv99ZQlNo8mDB1+
	urt8ub2n9qwtBfTNoCtyjlM5Z59JvYCCrcMDK5Y1us18Fdw4Sj9/2pCYdrlStrmshuSWk3Gfa04
	R6BVKcXQOUZ08i/DNjIDAW/QfWvrpDUU+9jlflAUmLAKh8rz1v4GU3GWsQIWYv+uw1R7ajXOvyK
	TdaWfAG8cI3XlxmgUo=
X-Received: by 2002:a17:90b:4d86:b0:3a8:6571:b43f with SMTP id 98e67ed59e1d1-3ab3a9f7f28mr9589394a91.29.1791871475585;
        Mon, 12 Oct 2026 23:04:35 -0700 (PDT)
Received: from [10.25.160.252] ([165.85.154.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm23035084a91.11.2026.10.12.23.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:04:34 -0700 (PDT)
Message-ID: <14bbf027-4a16-4bac-b530-d4654ed38d4a@gmail.com>
Date: Tue, 13 Oct 2026 14:04:10 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close()
 being skipped on rollback
To: phucduc.bui@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrei Simion <andrei.simion@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>,
 wangdicheng <wangdicheng@kylinos.cn>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Neo Chang <YLCHANG2@nuvoton.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Hemanth Selam <hemanth.selam@gmail.com>,
 Md Shofiqul Islam <shofiqtest@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Zain Aboobacker <zainaboobacker33@gmail.com>,
 Sang-Heon Jeon <ekffu200098@gmail.com>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>,
 linux-sound@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
 <20261008103831.542533-19-phucduc.bui@gmail.com>
Content-Language: en-US
From: Chancel Liu <chancel.liu@gmail.com>
In-Reply-To: <20261008103831.542533-19-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/2026 6:38 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> snd_pcm_hw_constraint_integer() may return 1, which is then returned
> from imx_rpmsg_pcm_open(). ASoC only marks the component as opened
> when .open() returns 0, so .close() can be skipped on rollback.
> 
> Return 0 explicitly on success.
> 
> Fixes: 3c00eceb2a53 ("ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Chancel Liu <chancel.liu@gmail.com>

Regards,
Chancel Liu

