Return-Path: <linuxppc-dev+bounces-29515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA6DCC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:39:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rNT4lSQz2yqT;
	Thu, 15 Oct 2026 12:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028393;
	cv=pass; b=ETviT5wGDLSd/HOf1SNOt6MnqVF0giMEg0ZXSTLqcUaFsKtXqBaiVK5xZCqQ9bqshXm/yJRHBizcJSV2vhSyN0pLzIeP6ehLPZObzUEM5DoK3GvOnbfqUWkIGpEC1XxqngJKqV+L4kHicF0tonQxFEVDYRPgM0rRNTM//AZnnaiSnDesvM+oYAbX0lBN486vnqTepOAExXsO/TyPZOJ7ZZEqkLVKET1HZvEwVHXRKAjVt8PHqmJlOeptBiHyX021w1xuMhG5y1tx5hDJ/VdOsMnhkOQ1xpc2uKyx34Mx98bWV2AV0K9N0XoE+Z4MD3xvkj3hOruK2TC1/ThDIEzpCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028393; c=relaxed/relaxed;
	bh=7UAKkSVFiLjeCKqwwiBA8/TCsyeb/yPhvR9ZVVpCVjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBliGjnVdZLVsb6psRLIm2b020Ze4yLLSS0T+La92pVEPSCyNhW673hXDfwsEsTKPFnvBtEK7EfpPVWX2WUC1I3dBsM2AVmCEfZ9BwbmQ/zHR0Pi9Kq65xvEl+3zInMWqxuby/UlR0VfiLo/OgZNmETH3ubL7zhFgffY+sfuUyEGn3OvtvWleaHQePJvFP7kTyJvat60Ty2X4IdioMiVdYNiEkuXqznqvNW6PVj+qbyCqUrLJowJhLJoZMPg1NLEsTfmVbz5Coz8mA2tEDqClgoI8ZDAHq4mGlLpyXse9i2LYG3DIp0NK+yH+1QwO0I6QOdhpOXUWgzi3Krfr0+Wrw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExRgJ11e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExRgJ11e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rNR5Jljz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:39:50 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1918048a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792028383; cv=none;
        d=google.com; s=arc-20260327;
        b=H3b+wvsMTHlUtbUymyuvprM5UBFpIalQePPjgZeEQ57I7ePe8341ey2mg6yS3ouHf9
         1ntfOApkje6QvFAlej6I+VBYs9Bu+yHgsQ4yoEsp1ePN/XV1xqNgWOoP0qTrCyeE7jgq
         S6NMLERVFHxH0qQ6+iRE7pkQDC0i3b2xWRxzH2bTI3JErPT6MW23JvLUjakPq6Nfk30A
         XLv4R9zm6vBRp83TV5F01eKFJsmXe9zxp7vZbXXmSKQCoPXTiWoXdlm+XbWAHliDt78Q
         +J8n0DF3bc0/IhqBsokROltPYRJSE0YAsUdhw/zi9hwkgeHlR65PP8saW2NCEdUUZsG/
         5qBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7UAKkSVFiLjeCKqwwiBA8/TCsyeb/yPhvR9ZVVpCVjM=;
        fh=2MvqwDOQOGkfLX/A/YIXJoXU8a9rTPGY7yA7SFHzwT0=;
        b=AgAFrobzmsDv50l22m0X/voCBzg9RpDyYm+xKDryJDDPUoE7D6Kp5c0nlmf+D5rX2Q
         Af+uiuA2C0UCtqrCFawEyOK4xd/aE43iGz1nYSHJPsr8C9w2pzebPtamw1Mpv/ilNpdk
         phcIhZmQrLWN6B3ulwM/pkOtbOEVzx/3icAYHOzN7FywC2cl/QaprifNW0oRjpdcQ3wk
         KB28VUXPxMIJF66jXt4P8nlRWfDEHwBBKSfMatKUbqfSVlkfY3jsuItWNYgEkctbzbzm
         vjwOVySE3SwGgqy0ujPISF1YMaFZqVFcviT+B7Ei9CcQhpthO3xdPqla2VqOcA9ltQJA
         aCeQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028383; x=1792633183; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UAKkSVFiLjeCKqwwiBA8/TCsyeb/yPhvR9ZVVpCVjM=;
        b=ExRgJ11ewFYhwCX+1ndYVDyCS/oHcFrml7YN8aXki3ZCHB1A9fE7u4K3Rk1GGYWvmL
         urGVYSV75ybIWzDVYo7gWrI5u1CUuKeZgwbg1cQ+P59csH+y5fChsMHkWyYNdv+hXcRf
         RAZNOkBjz+4KnM/Eg0+VJeQm5+Tq92J25rx1L5WRyyHfQx8lkHG7yLY42qvFs+tFqVoF
         iZzUuWMKgNMw1yrn6WvDrusb5uiHhtD+g/FRL0ATe9ewHflF4YfkxvIx0CdFDt0/7Rrg
         w0/0yr6h+JfCiSJc72IMpcHDswuHsSEd9QWXqM4OA8Rbv1AwUBfzOZDwXiFzeQ489XoY
         D4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028383; x=1792633183;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7UAKkSVFiLjeCKqwwiBA8/TCsyeb/yPhvR9ZVVpCVjM=;
        b=IBg+oWiqCpKXrUo+MDtmiVraUUqt4QmBgqwV5/NPvU4EpgCLsCI3WY5fgtDe3OwEwd
         1noGceEkKugUMsSdxfJ20Ic/8Tvfe2R4w406NTEjmyg7ctGmu3vdILHdE5riRa0+5rux
         PryxbciLUgTZoMasVuf+T9/l2hvN6GE6j41Jg3ws6Zut4SIf1sUN2YjETjP8dtJYv8Uy
         9mG/oIIBpQhAQUQzefx5UyPlvrvb2xAi0cJWTPpT7o+HRIeXkV5UADZqj7uuXFlx+Mov
         J2l0ufZdh+wo8kQ+PD5qhw9Dnwt1Ty6UAJzaa6jZ3Q5S7RxOT11WeG6JkCgT62KSzDeZ
         tqfw==
X-Forwarded-Encrypted: i=1; AKwUvBx18bIGBfPuw5z8+I3YC2zhucrlxUrdea6VoCaJpq3ZLRIV9q5Q9CHEVtpoD/pav6Pcc4WD6X/Nm1R3eec=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIQAHKARrsB05eK3QVUFRUizuUyOFxXpmlg9qIELfGQq68EC683
	Am9WQnXguN00/MMJ6PWQxTu2lOlHcuCoqFK4hyQyHNeUf9y7qvemSqT1lbuGfQVzWi3NvLqYFKG
	vzMGVzBgQkx3Wa8i+pqf2468m38dI2TU=
X-Gm-Gg: AYBFou1X27PopRI6guK0Y1pUWKEAHLUje6qbdVeBnNBL4yYaMqsachmiJ7EepOOQ04E
	JZ583d9MUHEtE4POaqanMMrHEkibyXfohcXkmw1A4zwmpvUeJkwwCw8DPlwAb5T2KpfIBDUQtDk
	eYqCr2mqWuHJJgJSk4AF7JNtaipTKulmLVM/GaGoCPyEljQi4dOVh9M9LgMSCti+d0gzgxcXIEp
	dm/LDXlSnkQ+n5Mn00VD6fd/lwE1761D5PmR2lpvrpfMad0OwXVOY+rW4giBiAq+XGTFZZNu/Py
	OwJTw9bJZqyfq5CUqMN7rqlUukKEXw6+1nA2mLKLrgUSXf6Ouf9hN567BkE+AxDYcmnO1KwgHxO
	zjRBVglr4RIhNR+nLQVr/8Pt0mJzmmiXrl9XDbiUmIdRmlwvHpMJG/L3BOT394pSqDbU=
X-Received: by 2002:a17:90b:4acc:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3ab3a60ac9amr16312045a91.12.1792028382966; Wed, 14 Oct 2026
 18:39:42 -0700 (PDT)
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
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
 <20261008103831.542533-22-phucduc.bui@gmail.com> <87o6cyxyau.wl-kuninori.morimoto.gx@renesas.com>
 <CAABR9nHvCfabGfBu85bm1r=hP3b0ZiCsgZfShhOv3gNUfjjhGg@mail.gmail.com>
 <87se2aw3ot.wl-kuninori.morimoto.gx@renesas.com> <CAABR9nG-YJZEdj6pVD-gbGU6J2EfRMQYsKd7u0UTgfrWOyAPXA@mail.gmail.com>
 <87qzhtyxw6.wl-kuninori.morimoto.gx@renesas.com> <3a6759c7-84bc-46ff-93f1-965c7e8dd4d0@tuxon.dev>
In-Reply-To: <3a6759c7-84bc-46ff-93f1-965c7e8dd4d0@tuxon.dev>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 15 Oct 2026 08:39:29 +0700
X-Gm-Features: AclHuK8C1u90VDPCucQhY3afyuLfcxP0SCIJrlA3M2hLxVwcjMsqinLCGr2nhSI
Message-ID: <CAABR9nFA5p=5hnMoxFHLtmGEj4kvfrN6M6UFPnm9hRQv_CAP6Q@mail.gmail.com>
Subject: Re: [PATCH 21/24] ASoC: renesas: msiof: Fix msiof_close() being
 skipped on rollback
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	povik+lin@cutebit.org, Andrei Simion <andrei.simion@microchip.com>, 
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, Bo Shen <voice.shen@atmel.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu, Morimoto-san,

> >
> >> For rz-ssi: in DMA mode, the driver registers the generic dmaengine
> >> PCM component, whose .open callback already applies the integer
> >> PERIODS constraint via snd_dmaengine_pcm_open().
> >>
> >> Could we drop rz_ssi_pcm_open_dma() instead, and keep the return
> >> value fix only for rz_ssi_pcm_open_pio()?
> >
> > It seems fine, but I don't know detail of rz-ssi.
> > Claudiu, what do you think ?
>
> That should work. I'll test v2 once it's out.
>

Thanks for your help and feedback. I'll send v2 now.

Best regards,
Phuc

