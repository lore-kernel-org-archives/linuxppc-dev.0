Return-Path: <linuxppc-dev+bounces-29479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F4FCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:39:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Tkz5YCNz2yLY;
	Wed, 14 Oct 2026 22:39:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791977979;
	cv=pass; b=XVBL64O7KAveoCw4atZ3QrB3EDGi1+EVlZr/RWXeD+8+nkPF6+b1UloXVta/QP8R94jqSG2eHjdmwVH8wp/cYGan3p0qvw4dVkxT2aYe6ppQ2lj9Ps5mTTkQhfS4sjeefKHzO01NTU7/ZlWqbm4Rb9/8RXl0oUvCIoGZS95eTt7FWcBx3QhHb0K0+Hb0viAAWTTwN0hHr7ymHUSK0fQViunCh/e4UrgiZAHMuo+RBRMFhkFwQucQQTfn0FY6nkf2XgH65/j5B6BwWa4WItiy05x+4VBJLzcxDpx3dGviYoLIigwr4yCg8pXaqG6l2IuEgTUo5rKj96bvZTD0luzBZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791977979; c=relaxed/relaxed;
	bh=86HyIPwleJgWRq7xObrqY9hZQITORuKm8Ont8f8xwzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHoPS7FuIHYMYVONlbo2yhfdFMT/MdZzXcHMdBWS9XBJF3KWrsuUUFvTtKNnfqtov72qnhXwZIabRNkI4TjxSAj6wXigi4KwK5LZLZppxX8VKGBrSR92FoA+TDKruoTxh2f6l80P68gUbrSy/Zmh70Zc9K5MzYszUTDn8mfmWMudTb5FKkNQo3+3SsKkWG0H4lpkO+E69u4VfgPphsDuwW2uuMreIsKqV6SheM5G4HAaA8oWDlVqC/j83d+ZKPbQM2GQyE2A7qHX6PwmUzCxU0T/nsbpLVP5mBwKtctTs91K2DD3Xhss+Wbgo6eqrgjqqbocwlrZxv8644BrVuvRPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BbXOuPSm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BbXOuPSm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4Tky3bsZz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 22:39:37 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2e5fb79ce82so21913135ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 04:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977975; cv=none;
        d=google.com; s=arc-20260327;
        b=KCHKtKQ+Nryzi1YeC6sOWoVO4PNARi3D4RZkLvJW9fWCoMufIxtWvXoOMSmQzlFYjw
         vC6839Fg1M5nqcc3TjMt00WglYyzKRxCwiKjoV08yGYuXG/J9DQEuKWCpCA5D7vGFlhI
         de9uvoUVK2nfxtG7k+2sADTyKuiR2ScilWsi0B2IJtH3zp6nrgAq76OWUBo9zGe//Utl
         AzStHz/q6BnYGMBiBmovM8f3Ol9ACh93qxX+Ec5iC8FC//EY2IhorgH8z47mAiv5mU5z
         tKW8TXiBR3h8PugfCUtLxXhEH/ItqDvXtBJWjNUDVcVk3C1hXFt2xX6IFeXClenqoZaP
         5C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86HyIPwleJgWRq7xObrqY9hZQITORuKm8Ont8f8xwzw=;
        fh=gqWc5yDMCrdxuNBQHbFPd+xByMqo23NrVS1cyzpgPDI=;
        b=rMEuzoNlhuVWOOazzQG+AXCokewcwy0yQBuCQAR7diKJZVMC7UvoxnBRow74TkRtjT
         7RRQUE+D14qpBdV6aMZNgwN25dgEYt4Tsdu9JaKzEBPjNcIUHmcPwkJMV63v2m7Wse5A
         U/8QWSXC30Bpr4v6cPg+T2MRVI+w42VGoN3C5jEq+oXq5H12lOherNBWcUNYeMnwLnnU
         6AypKNmk6+c9HG72xl6uol0nH09EQUnDJkyHaG5o16wLbmgb+8yXFwaqZE20FlbdrCiQ
         QCqCVsgjS7f0mtMtChsqIsqOSyzwtVHKTvxXdNThBxs/Z+ShrTQw32iZUb87U7bgN2KO
         iFVQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977975; x=1792582775; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86HyIPwleJgWRq7xObrqY9hZQITORuKm8Ont8f8xwzw=;
        b=BbXOuPSm52Ga3eYQD12cRJ5MOkMJs7GzC86JywEvtyr0D/rEKotsPxlI4HyA6aG1be
         A5bJw/OePJKrPjqcivy1LIeU02FcZWSabP2BB/VkhfEx+tSw960m7IzT5veRJ+LxFBNR
         V4T0Avj8OOgM4gLYGUzUbH/BLvbt6a5eujblJ1CTVNFtGKHTh/dHUj+3wpZPiuls1G9M
         XHQW7ke3gL1gIw84khmII4qlWh2PaJn5lU5bfmRKxQa8mhNsnoy3IR/a57EnCJoeztzY
         vQSFsLQhkJlwymMQyvQLRl+Np5CFDQZoq6H01kRYuge7IxtyEH9dIP6cNKVuB62mtvXR
         tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977975; x=1792582775;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=86HyIPwleJgWRq7xObrqY9hZQITORuKm8Ont8f8xwzw=;
        b=e2T6dNgNq/mzmpFFLwt97UNR2F1hX74+YfYfJh27EQMI3Vp8OkeYLat6Js6wr55NnZ
         mFiQvnE+faeIpEBddCPynjaFjFOJAWAaoa54x57Y+xu6SfKyGj8eV7sD6yfjiHaLxZ4A
         r4VNxnZEMjYKtzQ6fWkYA0AJHTUIwEtrFMXPA3whmFXIRXjOeJGTrmsTAUkrGY99qDkI
         Dd1/QbZoDEisP6395M/SMHm91J8tksC5uWzQBh+R2XWvC3XLyLUpt7JtIVAG6yPer8HX
         RVOgQ0vFS4GWJ6HWio66KOiTakEsQrNLAQtvD6gOvOO1mNtMv1uCHspv9oT3C2EKNEiq
         IuCA==
X-Forwarded-Encrypted: i=1; AKwUvBwogNXSj8rUu1vNjgRttSMbsZdGPKyjG+QalVISQaBnWr8/0S3c0Mn65ZZvO9+z3j08ySIWFHvISjJ96Oo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKsAErpgUx0/v2ahB12z+TDqLHOgaIypNWyrX7IsAwhnKHG4yvq
	ntLnNOxr0m/NQ6DDBdFuR49b9TtkmLtQniMuI+2gdp1QGxjY7RDGQmBlRJ10kaHmJ2EVE3n3Ggo
	iE341yQm3hrMpBg7MmSKqZzGzpjd2G/g=
X-Gm-Gg: AYBFou0UtltLc/o5F52j7YuQy6wjhDDkDQYocru+l61tFK2Qn4yKD/oskLMjz03KYwN
	vgfZRSX14ASQdds8jL3hX3LnhTX8Py1nkp3o3v/A7oF0Vfbx/EGFxdqnFpoVes8J6CUjBxmSR35
	aLmAhUo8xwPbkYtTVh5DbJH6F1nryO/Gcd24wolERKu3g6n+brPTSi4533BOwKT6R1NlNjHmEIu
	rvznnpwSG3l09tAXPnFL6wzfMQDrOt77ORY/zodUaL1EQxEflMrgHfxcPi4lRO+l51uJT9A7muw
	d27qBBIfksrgJpae77wMlWtv4zVhdOvn2ewDE4Xgl8fz9ZoPtryBWwWNio5b4mEehLgtUYi+9XB
	grSbtHEz7QmxtCltuzmg4AT3zvqrKURySTfcjJ/DsOAl8MX0qhlZNVZ08QWgo0hGfZcQ=
X-Received: by 2002:a17:902:c946:b0:2e7:e73e:7091 with SMTP id
 d9443c01a7336-2e842bc6d99mr145871485ad.31.1791977975265; Wed, 14 Oct 2026
 04:39:35 -0700 (PDT)
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
References: <20261008103831.542533-1-phucduc.bui@gmail.com> <fc30ea4e-3c2f-4ba4-9ae2-054db9b49fd5@amd.com>
In-Reply-To: <fc30ea4e-3c2f-4ba4-9ae2-054db9b49fd5@amd.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 14 Oct 2026 18:39:23 +0700
X-Gm-Features: AclHuK9jgQVtz3xDN60LQFsNWM2GDbLorSH_eG4NihFn39vhGI4sDgE_b4KgxkY
Message-ID: <CAABR9nGbO1tBOL=fN90ZrYPkv767qh_sJG_UHP-FW5C7sBPpmw@mail.gmail.com>
Subject: Re: [PATCH 00/24] ASoC: Fix constraint return value handling
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrei Simion <andrei.simion@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, Bo Shen <voice.shen@atmel.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mukunda,

Thanks for the review.

> > Found by manual code inspection.
> For AMD patches:
>
> Reviewed-By: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

 I'll send v2 shortly with your Reviewed-by tag.

Best regards,
Phuc

