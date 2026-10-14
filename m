Return-Path: <linuxppc-dev+bounces-29486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC65CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:22:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4ZhB6MWGz2ynZ;
	Thu, 15 Oct 2026 02:22:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791991354;
	cv=none; b=NAjMO2zdMth8o/8qy1Z3V3cUfjpPam0QIPpt/dLqn/zTsYFM84TraQiknDgB2lc3O1ThkWhCm++Anu3EmGmOltY135zoEfVKJJADby/zh5Cg7LlbsikgSlbwT6H9dR2kSK3SP2RF3MzkZMTHUPxrrTZwerwDmE9ggx0ORqKSiu8N90fDokS53EBU1EfC4fz7BtZ63XZ13lPJ1GKKBfeF4bRbvWs+isJ00kFZggZ3c+KppzHpzQIUpV7LtFM3Z86F1TMRKKUPIvLUSB7JiB/mjuZc990oyuhzJToxfZL4h7/gJXk9tJGa67q+O2EG6ObiL0B4C/5ZyWNYL05bOpMKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791991354; c=relaxed/relaxed;
	bh=Js2yXAKJLVFgb+YsCYrtsAgVcbxI+5CvJwak5knEqR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6jH+wVRFzxWp8Po9TtSDZ12N9+hqizQbA8B8+rY14QLFyquhSlFvX5qARvCoa7eaAv+xt4Bo0iCtMSqNkd+evqRUtOBkWjjB8lP06IBxE+5QBJ3qh7u/RHAyxFK96z1v8bUhag1DmP4Nswe70eoEAqIMvAFm1dta04PCvzbMwIdsXr3R8PF8Jl6sOQDvaTMwhn9b/ykXqmac5qRFwNpk/j2D9k5EedseznrGK1w65vXtHr55dVm48UeTAjK0UQOCRSxuba067Jkq0Lw3FGSks2ePsPAcUIRXDw9g+EJOm2gUlOVVbC4EnOHEMswGreDr0dGJu4BcISRH5zMqAaRtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=fxJkqf2w; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=fxJkqf2w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4Zh84fB8z2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 02:22:31 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so38942295e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1791991346; x=1792596146; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Js2yXAKJLVFgb+YsCYrtsAgVcbxI+5CvJwak5knEqR8=;
        b=fxJkqf2wh+j19s+tBXK5BT9C8veaJaGPB1mGuskcwS/LKxj0VtOUQ35Z2NRe0/mnF5
         llBxBKq26b8dMNJEvYcmjPdoGZ72/q4GMrGaypmLifeMI2fiL5poBadBU9VTdzaGZiAi
         GXXmI6vl89Wzy3k0exO2KNQMtlrP5UefKcF/apevI4MM2zJvmidosarlZO4fzVJ9qqsf
         ljOWXgXyaWhZ71icnd/5EDnZ3TlPxX42P+J7m2CMzJ/usACmaVsyWE7xe/vDTYRP0EgN
         TgP/iNqHOiZhLiiBs7od/vuWQr5YVEjkeS6taiFsyAJ8VKjHLN8K8Wy3vroeqO9F3043
         sBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991347; x=1792596147;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Js2yXAKJLVFgb+YsCYrtsAgVcbxI+5CvJwak5knEqR8=;
        b=qw/O+zxb5A3Y4aEOkdz4vA2uDYUdiPi0OOhKD3UdFKyp18ItvQEhw3iDc5u+oZW7aE
         9WqiM3lYS6K3Z0zicZgw3iwE29UtUL8nGZMndtzRQzbTZy8hPHll4KPXRqae6zl129yn
         swzQt+AXwHCJ5hOC9FvSRfmwtsVt8NiFPoG4oMpi2jLwDcK7ntOEKXgqikqboMx3Hiz8
         oO73YySc1kdjKsKV+0EOi6DXAO/iv37W55xMQq5H4KK7Ay/AVVkIei4xXakDjbmbNbO4
         UW+1TbXKoIVhMPvvKS8O5Wo62sNmFK67JI4T2nsj0MpAhuYsN97mWlB4ZpnVoPy5ZX+b
         c1NA==
X-Forwarded-Encrypted: i=1; AKwUvBws95KIZse7+1yX4kzVSRRdRbGJVDURF1skyL5Y8oTDEOTEJqG9MkwLvQMO7uKBplpTiYp0cQ6evgO0wZM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKdrgbMtXogEauVwBaXLT1f2TjuUZc0GgJEM7EXrhND3iOZr9Ti
	pXYdSRe1gQgpFqDTqLUy0gAdpjuCgRu3MrVt7c2el+uDixzLlQfDP/v47G1cPgHdfyQ=
X-Gm-Gg: AYBFou0s7RRwlpbjfdyg6msRrPp2UBmfBCuYtyKNGiGO/+QDhBoY+HopF+XLiTG637F
	3JvErUOwJrZmZuU6fjOnLHGtac1ALOjDov4XPWJRtxozDJRkQVwszOocO/tORROjbK6eaTCiEeZ
	t2stSMy7+EYxJbF46gP9YNPvx7mDPQ45C7+nhOHpG5JO11mw3+1AUD33XM47LwmC8p/5SE9sQV3
	fvjevQ8J+glTaygQ9vckIIkHQ3rflQOkSQu5CGg1bwZqX96vYE6p5nwnF8AonLn1dfYedWs49ww
	/X11WGAUYdJRcihsp7dnLQIxbF+fJAYIHDL2qUkLMlZ181Sl/VkJz/8ecOhPFWLvW6/gsmi/iAg
	RYSL4tiHi8QvTwmCrS5xzjT+RALWn5cj2QyRKCgomPvdWLAPMdE0NiuEm/0pJB3OGYOPNLVHnhE
	29bcStIuPTKB5He5DaSoVPTW9habEoxep35LNybI3CeJiX4p5PytST9dk/eNat8FHkUUiTlAXD3
	OUQd/4=
X-Received: by 2002:a05:600c:3507:b0:4a1:afcd:3919 with SMTP id 5b1f17b1804b1-4a1afcd393emr93408495e9.7.1791991346614;
        Wed, 14 Oct 2026 08:22:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd67502asm974715e9.3.2026.10.14.08.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:22:25 -0700 (PDT)
Message-ID: <3a6759c7-84bc-46ff-93f1-965c7e8dd4d0@tuxon.dev>
Date: Wed, 14 Oct 2026 18:22:21 +0300
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
Subject: Re: [PATCH 21/24] ASoC: renesas: msiof: Fix msiof_close() being
 skipped on rollback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Bui Duc Phuc <phucduc.bui@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Heiko Stuebner <heiko@sntech.de>, Kees Cook <kees@kernel.org>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
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
 <20261008103831.542533-22-phucduc.bui@gmail.com>
 <87o6cyxyau.wl-kuninori.morimoto.gx@renesas.com>
 <CAABR9nHvCfabGfBu85bm1r=hP3b0ZiCsgZfShhOv3gNUfjjhGg@mail.gmail.com>
 <87se2aw3ot.wl-kuninori.morimoto.gx@renesas.com>
 <CAABR9nG-YJZEdj6pVD-gbGU6J2EfRMQYsKd7u0UTgfrWOyAPXA@mail.gmail.com>
 <87qzhtyxw6.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <87qzhtyxw6.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Morimoto-san, Bui,

On 10/14/26 02:38, Kuninori Morimoto wrote:
> 
> Hi Bui, Claudiu
> 
>> For rz-ssi: in DMA mode, the driver registers the generic dmaengine
>> PCM component, whose .open callback already applies the integer
>> PERIODS constraint via snd_dmaengine_pcm_open().
>>
>> Could we drop rz_ssi_pcm_open_dma() instead, and keep the return
>> value fix only for rz_ssi_pcm_open_pio()?
> 
> It seems fine, but I don't know detail of rz-ssi.
> Claudiu, what do you think ?

That should work. I'll test v2 once it's out.

Thank you,
Claudiu

