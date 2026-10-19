Return-Path: <linuxppc-dev+bounces-29702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54178CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7c5J3TWqz2yb9;
	Tue, 20 Oct 2026 00:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792416980;
	cv=none; b=DA7ZDm4IG3S7aDJlhtLU4HjJiwQDOv59OkffsyhQ/T8qVnsFySa++N6Co61LsP4VFJlftDGjQv88k0rYdyhwXNx1bqgppxjvRhsWg5DkPwLsEysN2q290YdMWv2ZkRzLk4cntuwVjRkQ2UHtpEZsZTQUlD3Pi+NRp3rZwfNlVcySIQ4It5PiE02ghUlZ8U1K7IIYiOzNzlJ6TsG1CBwiNudjCI1VK7rmQWN+j41eXazHVKV/QekH4npDHZaSNY9/lh79izUhWFvdyEE3BaXpqXMpM+6BarUpXStwa3j87DZZWkgPF9oiZIQGdC3wReVSi0TH76WIkQ6a255TrgQDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792416980; c=relaxed/relaxed;
	bh=u7QI1RqFBazH73cHjUm3bJRQ468s8YNQSYzETjY7O2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmIcbwaFVa37fOIOa96rz6V25Y67Ap+0D+ECduV8sVyz232LHZJ7ME+hEcogyEcJanL4Ouw+IVhhxmK9ZDVVe7fFOOLBdy0ugrk3Th7GZsFQkrPQbO03z60Ve7CTlzCBDeu1k0yZ0vipHeypwgDUmnbkuQp4UE7DTWb+jCPAdchN8EIje6Vjaf00Gd0gKR01utvNr7RrxeFpwIQKkhl1J2ErDJJqmHj7GIwuqUnDAuSWg6FR4M2S3nHL7lbDmc+xmfF+Qd4syxvbvqW/ocZW40e1qNjEsaCPhjGXiS52YA911FPxMCc/JO1fd2KXXAW4wGaiH3SwQlRXCh4ApFIU8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=EZk8WDh4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=EZk8WDh4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7c5G2PXVz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 00:36:16 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so16024185e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792416968; x=1793021768; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7QI1RqFBazH73cHjUm3bJRQ468s8YNQSYzETjY7O2I=;
        b=EZk8WDh46kmQF+6CKvVZMSPf4Mefsc+GtzScv1udI4+HAuXHxnRQ1hbgRt2sZsC3IW
         dYgigUmeRqPqxnvI1+GJKLeE8GMivnYPFHdwnnqpKD74EvAy1R5YuAT3TStY2jYVTcIm
         KHrVDBbAIL2xHf7HNn0TsBLUu2vxQYYBmaOprrIe3MtVo6+lHL4xYeRdyk7+foA6uuMq
         o//CPS8utoJOZWCFVgD/q3CYG5TNzGRyTg1pjDPeZa2BnUJvL2B8SkJNHRXlF0MRE1uT
         D2gEfSvyqg4bko3o/lqc1wN0k8BVg2fwjy+AhrmpJBXTGhWlGbpl47Xw0MrQXzD5ngZq
         0wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416968; x=1793021768;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7QI1RqFBazH73cHjUm3bJRQ468s8YNQSYzETjY7O2I=;
        b=rRxLW13sSIJEjEBjeFLjYZF9dqLQ7sRwSumyoXUtv1vOjsRGb+gcVZkYgRuCNrooiX
         Pzrtw4iPCBGtmkEoaflX9tPKh0HAHQ07USXeTbQr7Ju4lGSkattfi9O1CyWZQbgVRkuP
         Qr7l7RKMXkaEW4OeOhltWjY4P7L2vuOgdqIhEoWXu3kZrBw5oAOAI3nj/ANUIlWh9Mkt
         i4Fz1OKmEQg0aIsna7ta9QEzfA+Ke2G3+dTdsx72ZEkYQ9tQ5JuHpTcHTdvzuP8xY1+m
         39tGK8rMPDUX/bWYDjqZJadErFbMlI0hHEu7zDb86nign4nt22o0XprtoZZk01pyf7Hm
         /2WA==
X-Forwarded-Encrypted: i=1; AKwUvByMq1Z51/clzint4TfNSWKwRE6Yhnpa5kBbJTxhHd9+/s38U9D3ln2M1J3WapICTXMx+CkN9SOY9XhBtYw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLX7HPYl6jR9s3+W4L735HuJlV7YgZq9l8mn3a9S9V7yvFRPxxT
	hTrahVDKPUtoHXkabIvW5Giyp9hmL6dvI7dOnN6fIM4P9ZrQFRNQAq1nEbRWVtDK4Kg=
X-Gm-Gg: AYBFou0n5M7QAn5RuSxPQghKmzBJ5aVCwMBBZm+SNboJ7131gmTjg8K7f+IpDqmH5Aw
	7Ldkr4T7zll4eGRtB1KMs/5XHRTt4Da289hBLxOGZ7/hOriPtPYElb9SOAPzSBgux++Wj3BNxMT
	ugIO2OXXAUzeMI0iAJnmVbpJIErpesvhe4XuMu4EXm4ENyuQGW471R687m4U0dfh03Z6BC0eC4G
	LPMwV9ev35C53vWEEMLAhmBejjSTnwGpCQDAJoLpWYi6cPISwYxC1/kbUQZXUDB+aw5QRNH4g8F
	wMClXyCubqvRby9gGFr3MpuN/s/Aq3qNxJ/8eFIVcloj2e99bk2mxW0wk/gYQwV8hBFDs0W1+SO
	wOhAQAUvOjFWVH39+dADQTPsNgIIfbIQ4i8t1zVLX/Oc9xeY3R6tEN+AprspIASeHCW3SHbv7hB
	CXOu99rgHqnGRZ+7v+5TQ8DiP0uMX8NffgZjqtNkfpCSD+QpgDKumv9RprEwbblksYmXiBG7+42
	w9fh45l
X-Received: by 2002:a05:600c:c168:b0:4a1:ed0c:f051 with SMTP id 5b1f17b1804b1-4a1ed0cf21dmr30497355e9.5.1792416967770;
        Mon, 19 Oct 2026 06:36:07 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8cfesm20387473f8f.37.2026.10.19.06.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:36:03 -0700 (PDT)
Message-ID: <0cf7bef8-42fd-475d-b47a-9cb8629644ed@tuxon.dev>
Date: Mon, 19 Oct 2026 16:35:59 +0300
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
Subject: Re: [PATCH 09/11] ASoC: renesas: rz-ssi: Explain component open
 return value handling
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
 <20261016040946.521195-10-phucduc.bui@gmail.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261016040946.521195-10-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 07:09, phucduc.bui@gmail.com wrote:
> From: bui duc phuc<phucduc.bui@gmail.com>
> 
> Add a comment explaining why .open() must return 0 on success
> to ensure the component is correctly marked as opened and
> prevent future changes from reintroducing the issue.
> 
> Signed-off-by: bui duc phuc<phucduc.bui@gmail.com>

FTR:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

