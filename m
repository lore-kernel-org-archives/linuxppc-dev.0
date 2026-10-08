Return-Path: <linuxppc-dev+bounces-29054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B51CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 11:00:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0n8z46gnz30Wd;
	Thu, 08 Oct 2026 22:00:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791457251;
	cv=pass; b=RhjMnUeOkqR+t7n+AuvO4Ph3mMIzz71HFcOMNwlRMYT8v680hJoCZ+scyVDlVtOFyQI1m1gkoPxcEen8sVb1Z21wAgczP77sB9ro0AkVuAhJZjfI4zc5218NmCfOidA8dIPvp7VT9EPLB7T2oq60IaaYHHitl9JQLPK9ReC+97MbdLCTtRjYYq+NkauK44OjrkjvwdGG2f9iPUZvBWPxMQ6pft1+Lb3qHQ3i7jvOl8dJyFSU+xhYIyiAFbJpypR4CRiFLbWR3AkGCPvD6uHyfG5/1WtqHQu0AAGIcpwkQRAjlceL1P/RwkdASHhJjZSPZZ/wMu0aw+biO248t80v5A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791457251; c=relaxed/relaxed;
	bh=eIepTPV7DS9Aylyj+4CBDzvdvhaffPGskWIagcgTxBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+uct1Bezi0bMOXgaIcKM58V5NVB22kKV4K5StswG+GFxO6IEZclA8JccPy8fQ4O6/GK+ddxfqndfSdEd2H3UWcFs6xFrDy20F05E5bNF4B1c8ltLX8WQDStUrFQWx3W2Ykv6In6l+GftjqoGn7GWjCAMJGdXoljB1ecqt+yJuPO2xI1VnyqUfh/nd5UdauCq12l/+ussJm7WeqYYz6mxgBkhBWDUg4Eza8dL01mq/qo1W9KYgou04L9NwQBmonWNZGXM1iTbPJhYw3kw+j2G9lpAaDnpO4BZjony7hCQlkxJtwp7za0EVn4XeNLdg6tOhYIPV9are4teraeaylhqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sip//a0B; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sip//a0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0n8y1ByDz30WX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 22:00:49 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c315729ad50so406862566b.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 04:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457246; cv=none;
        d=google.com; s=arc-20260327;
        b=dWKAGGOgyGB9AjdMTsA+NlS9MLdvrb93Bzm0XrS0dQwGFplmG6Pbx1ubS0c+kLvAFK
         Y1gakt7KYBpoP5VhhtzVS8KxAWgr0Tcq16v8OaljovfarLEwNYv6Hue0xI7hTqPOtKmm
         uvE+FTaeICsQ0IhTFSiFfS5A87j6xw51AKsvGjzE4T8YPG0sOfa7iE4JfeM2rDQ60DLN
         BLmpb2iWmnK0twsw47wXSHRzym+IX1lEjG6sMSahtSlJySjVG3Zhr7Byi6hg4WcUg7/M
         mhlk6FUW7a6Uujmbw9SXV6GTHJ9pC6KhBYNEy5gNw7Qro2aX/3Um43xzvd0h4khN9K3L
         Fakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eIepTPV7DS9Aylyj+4CBDzvdvhaffPGskWIagcgTxBk=;
        fh=IXdKrCd/3dbMTLeIMTrtLPoXu1Cngj+3gEuAs1drhvA=;
        b=ji3fRJXr901fZwJaCM8nqPqaJGhvf/2KfBXSfg+H8DGMDpiwyfWqhADH79NV7VahTn
         GVY9SgxhHtuGN3pk07TV6KYL+ZZ2WUf4rP345aGoxcRrH6g32enZztO2HeVUVI25CgCN
         IQgFvUEMcA1uFtr2mp7nAN6wve4SNKo7GHUZPs6cBFmVziQThHC3sIfcAiUBoYQVZ410
         qRr7Abt4AAXWh9Et6QhmVYgKurUYNzJlTFQtSGpArh1VMkVrXy6E/jXbpVcdfuuufx/e
         gW8jbI7l1YD7q0vkAU5aW6K913B+ANYsZyp1V78RWlIAPPBu7z+KC9bJqs+hEi6pII9b
         ysEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457246; x=1792062046; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIepTPV7DS9Aylyj+4CBDzvdvhaffPGskWIagcgTxBk=;
        b=Sip//a0BkK/sTd/hrQJs1elS+qSEszsAi5EAuZRRuMigHG4zsGrQT+p9BLi4+Y2rki
         EMFF5BAGJ9dprHe8XKlzQN9LnzXqIm/1vq9FP5JkcbZZsg4N9bXX+jHH1B0i3aDY9W6p
         vhgHCsJyVz0tKwsXCg8/FKJrPpfxl0r7PXWxlpRMAeIaWGq4Z/+Pk0tTX9yNx1HH3RfV
         BVnxqIGRz0SqnJg3509pGnhycl+KTY/IZrh6wlpHBB4Re4ZIsFsO8ze3B0SnVPlLE3A/
         6Koxi5w+NuT2NWj/Ur3Jgd3YmFNkjuKO9TcdbfyznR1rspNiK2bc8nTq/giHLOkdjOME
         TF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457246; x=1792062046;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eIepTPV7DS9Aylyj+4CBDzvdvhaffPGskWIagcgTxBk=;
        b=lW8P/Qs2LY6FtMHqC6s9OOBRGv2ulbupLrn7XH/VC3rz3AxbO9Ea+XRUntatpk9JL1
         Hk74SWG27BnNIXqaisKueywDXTs+NxJ1++0CY3WNP1GxEQ4zvl7eY3dwMfPnnDXjKuQ3
         iigQeHa9ZMeQ+zt6O8nEWHRu5YHGyuUr0eUSJf/rXiD9AJzf6/CK1yJRue8dqWNrQ0IC
         0gNf50kq3+Bp3saiojp//oQ8YYruhJi+uR2DnT3Tu41wlmfStz9gx14576YV+nOKD8uD
         oGpw2GSxMlDbXgXsZFmSURNQVe6EJ4XeUEO/snBZcfYgFU9fhB/JHa9/VeRzUkkj3XvQ
         UeNg==
X-Forwarded-Encrypted: i=1; AKwUvBy0eXAr4ckwkFRPXUmsw1WmT0QHckkdOlcB/6aYhLwHmrUCTcD2yw7Ironbr7HIRUFNefuSpnoqWuPB2Dw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mkYWGvEf6KfSzni3Fq3F3LfKUPN7L6TIHg51eBdd2ZFCTk103q
	sKPn88WcwJ6MYM51Nx7fR3us/H4AleIMmqZchbQXoMSU93Gzg3s6Jaf/tZ5bvskmyTnscbD9m05
	ib0X4MtdVLJwKe1XdeJ3ut02lQFTtGSM=
X-Gm-Gg: AYBFou2HrwoL9H+kNi9e81Haef/1zbjR8zPUghmIY6dnMDyJSc1kz1s9B2nhjIEDkas
	soGvq8cy45xaCCTO96PatHBuxppd00RxTa+DBpOla/Q4vGAcdgk36suk/+5627mZqx35exUB9cs
	eqEDYfum88Xx4ZLYyiA5nIbI5dGPODIjnGip9YKUFVFJdTO77x9Qw2dsnE7tf6hw6VOgvqveUiN
	8UcB8ihqhXuYFHc+BEHNECSzc/pA4CQrQswT2wznAVSjNWhzwdOQ46s/EbwYlpFNxvt2AnsB01q
	MSAg14RLW3SWd30eeCSaKk1/8Pn3NwrS/ziEqf5mfQ0qEawt9ENxRXSr4rOiL1TG9aChMOie2VY
	DQ2Pk/j8tcjOTRdV/eAzH89/rhDygbFryGSUEMtBCuGeVjYgd6j4M8qwB95ne4qWxVSs=
X-Received: by 2002:a17:907:3f9b:b0:c26:1648:a062 with SMTP id
 a640c23a62f3a-c317be58e90mr502991266b.29.1791457245712; Thu, 08 Oct 2026
 04:00:45 -0700 (PDT)
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
 <20261008103831.542533-11-phucduc.bui@gmail.com> <fc7d2b73-e0a4-4a36-b6d4-8080ebb883f7@opensource.cirrus.com>
In-Reply-To: <fc7d2b73-e0a4-4a36-b6d4-8080ebb883f7@opensource.cirrus.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 8 Oct 2026 18:00:32 +0700
X-Gm-Features: AclHuK_K3qxrvyLSGGdbMZG2p4PEMizBkDvUHEpZw0j03bz-I49nzoxH95pIpWQ
Message-ID: <CAABR9nHx1Uwket5-co+e-LR3j=0Cww0ZqZgZsUbiDmHTEXp-PA@mail.gmail.com>
Subject: Re: [PATCH 10/24] ASoC: codecs: cs42l42: Ensure the DAI is marked as
 started on success
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrei Simion <andrei.simion@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, Bo Shen <voice.shen@atmel.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

Thank you for your review.

> Is there any reason why we can't change ASoC to mark the DAI as started
> if return is not an error?
>
>
> int snd_soc_dai_startup(struct snd_soc_dai *dai,
>                         struct snd_pcm_substream *substream)
> {
> <SNIP>
>
>         if (ret < 0)
>                 soc_dai_ret(dai, ret);
>
>         soc_dai_mark_push(dai, substream, startup);
>
>         return soc_dai_ret(dai, 0);
> }

I confirmed this with the maintainer here:
https://lore.kernel.org/all/CAABR9nEXM1OSnV6L4=N1YCbtWn5yMNr+OMEZ4p8h3WMaQXbgmA@mail.gmail.com/

It seems that the other ASoC callbacks consistently use 0 to indicate
success. The other call sites also handle the return values correctly.
The issue is limited to callbacks that directly return the result of
snd_pcm_hw_constraint_minmax() or snd_pcm_hw_constraint_integer(),
where the positive return value was overlooked.

Best regards,
Phuc

