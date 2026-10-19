Return-Path: <linuxppc-dev+bounces-29703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E654CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:37:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7c6D6zq5z2yfD;
	Tue, 20 Oct 2026 00:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792417028;
	cv=none; b=fRUoFwyIwc8zS080IgQkdCC7h8YHO+ZefOVAGSjoqwHkgvptZH0mvaXtfNWE92obTztNMKRxpeQIYYYOLMPu7/6WJ4CEBIVX3B3j0v/xRKHD7exwggm1BTgnuYkFnrPlMNonIzQPV4T0Yx7j0Yc07girnSjUDvJrqx9OnohHX8wL7Vd1KvnrjSQ9Anv8nD88dG96iCpVVt8uH3ggDtR94j8I4+E3SuLifTbZ7aaVUU16A9LpVfu8iixhIeQmTH8BEQsWGDzm++IurbYB7RRmpDTGwsjbwT/836QeHxrXLRmhj4FaFTwcRdwiE98J9nZfn4RM0VuFpJlf26CHBnMGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792417028; c=relaxed/relaxed;
	bh=kc0HBa20pNgTgn9A/dNG9MRjR4EzrI7cz68avvggZvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVTl4w98DcecD7Dkum3cHueO+MgwXExDRPkT/DDYHGkFsuoWtj/dLWqaoSTr73d3Fzbx/wP85kYAFfkAqv5yEp1PP9ZXZOXladZZv+eoEeyUEvJGTjT1qVvaMjqf4CcZXOM6XLMrXM36Jx4HXu5es2NKMS3ZTvQhv1Qz8Pvnxs9s+ERoXszpFN5CdEKk/1QkwIUy0/TpM+jIWlIc59Is5R0mjxBI53H+L4gLE/WOktLTw/L4zaODL84PdMKg5EoK4lIF71Gfhj2Ltv1AtqUXHmV2bOKLgAkO2Os/ju7+BpE34kswBmRPhFD44I8cChS8JrU94JilGXnADRE2jiijAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=amYcAiBl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=amYcAiBl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7c6C6b1Pz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 00:37:07 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso3043771a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792417024; x=1793021824; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kc0HBa20pNgTgn9A/dNG9MRjR4EzrI7cz68avvggZvk=;
        b=amYcAiBlnZNWFKqvbuIV9i6OUiGS+/WSsbu6dTXwtYSs02lRc9H8Z5TJuH3RxwqwVm
         L5SFcbznhEs/jehCj6a3zdynrl2scO/2YxQs2/dqknHyipKSl2RVt5R6UFmAh7Bt8OEO
         CqoDNk0HrrsDJgxT/x4OiLRET+lm30nmUvaRGrzqsXLy5DCcxfcmefxbUWbm87CzFPuN
         5+a0/vJYIeJNNte/4F/4ltuqZVyi5HwUM+EFP/TsseOm9gl4ErlK3nZTvzcadsCKU1PB
         t2F2E4HhkKn5HnHLR+e8WIqHN+bBVwoGj7jPUbstry27q+0pKKtNOExn2jfvzGpyHdGR
         4QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417024; x=1793021824;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kc0HBa20pNgTgn9A/dNG9MRjR4EzrI7cz68avvggZvk=;
        b=yVS5EK/7Ar2tsSQOsBljvUx+j+ZB/ambN9miiGOrUUZncXFhejACC/F86WBLnmgI2/
         70cYatVdfTJ/jTlFokDs9PqLdu8oaK6uBnm2x8LHJufZ+iSyWzOR6pHABpNMafT09biy
         a30ximn6Y4mUWlQPw0IPwMmEgpmLMaIyj0StroYW/S3XETedzAqMKZZdee9h5AfScjbk
         b05g1/zuMq2dy5Qjbdqbc+K+hJvi0BqDkBtjESr3ABCSzILii6P5w7Flq2Ui4Bh0pJFJ
         bcpp6EzsqgN2xrkcIs8sfoMN+iMML6G2+FB+JsXTTilJCH7Cob0Pox8uXn4LUMBsKs5B
         OniQ==
X-Forwarded-Encrypted: i=1; AKwUvBxl+6Sn0cAQcrjdPOAxb6DE1CbUhw6cjOKOhLsOfi7HpiNRTw8Z5v80ACTC8W49t3agndHKugLX93FOnXg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJnCxX/PfGVVuiO4v1m+W/JYPDdB59yhJ8QVLOLWciMMxE5YJWg
	OSwhdCMIH45H1oqoQ3+3txQHY+c/xsORY2hr9diYcu5mqzabx0vNJjZRKLbTotbajj0=
X-Gm-Gg: AYBFou19PWcxvEeH5xzmDtUhEWdfOtwhFnJqZq3cxmRHAmuIdbIPwQACfx0Bcqht0Ch
	1p+Np7ADzHnTlh2i4d4nG6Jqf+h4s8PVu//zkBTw1CqXPtTEf/9GntqF/76jePXOBW0Uf3MsSlX
	a2D/CNE1Ut3rMebXyLXvqnzgDlPIOHATW55C3xlO6hZHDFZUD+0ZXcLhmivi+2zeZiedeeS8Kte
	NMSljGfECK9etkACWRRlIcFesS215VCy7lqEF1R0W8gy+yBVuYlFD5rPrIQZGs51d/0IfWzp4rh
	F0t1gN9J8tuX0T4j+azeRsxZwX9NUG2Vdydmx0TBucNRtg7YDVMZxoutwLSR/AVXK0lmUADp72/
	ImYXhSgTkZbE8VLGalsrvumvhgfqOM+VJPa0iHaVfp2ExXLT64vi261ZQ7NUARz6d2hFJX60ZXW
	1xBWLw3nCaNYAdw5hzl8wVpAllI8jzhGkedhIjxgYjtup0QruJQwJ/aGIMPeLXpsc7a1WEq5wae
	vNdotU=
X-Received: by 2002:a05:6402:5489:b0:6af:8a4b:7aad with SMTP id 4fb4d7f45d1cf-6b3a81a6d00mr4333695a12.28.1792417023411;
        Mon, 19 Oct 2026 06:37:03 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm22897379f8f.30.2026.10.19.06.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:37:01 -0700 (PDT)
Message-ID: <14f60932-9a85-45ee-ad87-593c20cc116b@tuxon.dev>
Date: Mon, 19 Oct 2026 16:36:57 +0300
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
Subject: Re: [PATCH 10/11] ASoC: renesas: rz-ssi: Remove redundant component
 open callback
To: phucduc.bui@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 povik+lin@cutebit.org, Andrei Simion <andrei.simion@microchip.com>,
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
 Sang-Heon Jeon <ekffu200098@gmail.com>, Bo Shen <voice.shen@atmel.com>,
 Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
 <20261016040946.521195-11-phucduc.bui@gmail.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261016040946.521195-11-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 07:09, phucduc.bui@gmail.com wrote:
> From: bui duc phuc<phucduc.bui@gmail.com>
> 
> In DMA mode, the generic dmaengine PCM component already applies
> the integer PERIODS constraint in snd_dmaengine_pcm_open().
> 
> Since rz_ssi_pcm_open_dma() only applies this constraint, remove
> the redundant component .open callback.
> 
> Signed-off-by: bui duc phuc<phucduc.bui@gmail.com>

FTR:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>


