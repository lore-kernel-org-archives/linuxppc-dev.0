Return-Path: <linuxppc-dev+bounces-29339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42045CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 04:18:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3h0j4wpVz3bqh;
	Tue, 13 Oct 2026 15:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::433" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791865125;
	cv=pass; b=Cazns8jHTbI4OGnqY6fs0BYXiMYt1kaVcUHVFEetMjiELE8VN9s6x8n3j93nqXU8VPus6veYriBsKB4CTB/sutBqkZ1OklBWW7gHw4AeIaY0TTfcfjyx7OZdrkq5X6/rrGFvFOWTxzhljSML1AekKum9AKwmFtFPPkF8KI/GJalqECHym+9LRc5oxIXNPE79Q6wv/DKi+yA5GVeR9Vwd/rRcPUFUswE5MsGVWTqQrMy4p3X3lQYkNoeoVA+88ggmrSY/fg5pinRu9SU+9iHau76Raa+c4npXtCu4Gzz5DMPoUho7xG2XZjPk6KNpS6aCD4/Qz2jQJ/WBVvyCBwfoog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791865125; c=relaxed/relaxed;
	bh=RXTMOQ3s/A/fpHZbZ7Z1yCnaHYebzC4eV4sd40V0Aoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZsE9fxEYOQAsrJ+xqNtAGEWS+ag/CINFtS1HGyJ2NBvXgnsJ9jDaHBngH7rEztyuP+XYuW3F8Luw3LGApIfWPxl4fEigVLpwFlawrJ2Dh04/aMU7U7eCwG6kYLs+KD4lrApWR+3oEeFlyKguk/JHUV1LtwG6s3z8NamDAB/lQda8rtXca07Vi4CGe6ysswOELROqAARTItkVn4GRW+sa8uO8j2vStn45TGXZ1D3Ng9EqpB5JH0w9rm9jLP1aikS4jO1WgJmLsSkwY8lmUymRFF1CYJGX+FYRs9tPPsPIaY7lDEtb9lioQo2qSIzDfs3F8QPQUOt/b3H7dszXiaeSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvHZgezx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvHZgezx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3h0h0P2Pz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:18:42 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-868b3248b2cso1873085b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791865120; cv=none;
        d=google.com; s=arc-20260327;
        b=JJhHi3wftu6u1xCYw74naBhzvscKnaEA+PAOm++lB4D7znat0kuYtB4AKgdx/4EM/g
         NeUX3pvHSEY4rWshAQ9LTy5f+oODpsQlTokfTcjQpG1bszff1bJ68MFeIAVV7Ucx3Y4K
         vX1OhfSOF0I83PMh90EiPgaeVKGzR7fqpe6j3bPfvDYOnI5JiJZ8OGZSn4Am2X5UHz8O
         NA0i+wSiEXBhTnOlBM1bModBPUDn3M4a8WLp9l0LOMm+DGcCDRfvcc4LcOtLP11iz1hB
         CmIGmX6Li/ciUCyTfQ+xaUadu9Io72fF0pp7bZ5pE4oQP5wGUHaW3PWmfXMuATzqWm0S
         mndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RXTMOQ3s/A/fpHZbZ7Z1yCnaHYebzC4eV4sd40V0Aoc=;
        fh=IFFnN57hEJqqXVBEed/ENMFUkCDVJs1D2pkZ2m0zlrE=;
        b=Pk/dxlRBJerfHYCOVNmmfCr2AXzLtcVBBafylKSXwldlcpKxH+O3+DNUtZX3ZTuzWn
         Ih9MKtOU6xP17US92SxEkUSEOCt9V7Ga6kAODTMlth2lQY4ytNFXQCY2rIqkbv8TPNfd
         sBKaxhgVzwuVxtpRvIGDrRffSxGF/4mfSZb/3eV9AInkGCsJE9BzfoOlnE6dWpC3AOtt
         OaUyRaf7/vvbnfr97xnnUQQiye4WiWdjikkUCCNxX7IRN58pZjrMnaOwOGImgbS81Pec
         EzHiJuss4l8QTxwGDtSY2PtD5jIcG8D2r421XbnIsEcJECESBQ7eG5hfwxyxi9vy7Y3B
         /N7g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865120; x=1792469920; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXTMOQ3s/A/fpHZbZ7Z1yCnaHYebzC4eV4sd40V0Aoc=;
        b=gvHZgezxGgg60XX/cv4ggU3aKjc6JxwrUiGnDAMjRVYSpKvCKxKx+8tLqqzkkOI1np
         0quSE3tqK7YLMF0MXm6cbqc0riIvaQ2lrfWb2bAirIXgxuVhFDB/jnG37B6JQkLPQWY/
         +mi/fMSFDYuzEBBgG1pjOZNjXMjOM0+I2R8iFC9nBmJmRtiG6fNWXRNl6PMfxagF0Z/B
         gFS1Drjl15mJjuCbBY9Jey+Rhj8DVbL4p/QC55gDOCuFWzimITsqsP0iWOaZpPHQ3n6s
         gZ2ldnadq6/nv1lPPBYEy2pPrqgN/Y81IzCFC5fSwEC+/JsDdRRUN7ODkP9Ar5m5dSWS
         qSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865120; x=1792469920;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RXTMOQ3s/A/fpHZbZ7Z1yCnaHYebzC4eV4sd40V0Aoc=;
        b=dtCEJpFDUBZHyaNP+Rik55J/7Jkp3qWg3fayN29SBgtoiQkGZHgwAvhJPMCfz5ak+D
         U/gyPGqb+8cK4CDTOhU8c5q5yeQaFcsIC1pXAa4FQDCMP1sOxv4bzFS5xlaVDjtfKMqc
         fr1hpF0aMP8akjy8yrjyMmFm7moqNq4zjasNdS7q39TOBefFPjKSyHNBOEbev/FSuk9N
         ye0pEraMygnRN4GCX2BfjWzyo9WJWbu2RiyG5NgwznEHDuINw5noG6xlxoWgF0zVk4f0
         zHJplwqK/cvLVXCSM/At3wC3qncHkIBLAoz/bDAsYyzWFx2QifmzOIzVt7z3m6ofUbLj
         +TdQ==
X-Forwarded-Encrypted: i=1; AKwUvByGtmr2S2pzkVulqKYFEGVWWG9YRBfv+M2eG1M6+BoQRL2Vwk1VEfuM9igt+mi6QcLfM5t1xppdi3arr0A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJiwjGhvBr+A1OQzXMUCh9RE2HweRnqIbxbDWFwpXCMgpQYd/18
	aTsjAKFh650e1NT2cddUbeF573U/tcZCI16jDfeFph++hjvdTh3thPARLWjEIMdvBTYIxhs9ERs
	tSBwzCVI6IjXRLgUX7W8O3cXqf7+1/84=
X-Gm-Gg: AYBFou09GUan3Eiy5Q07RF33PHBtFxz9CElHgHbg1g7vrIUqVPI4WjNPdi3Ndz1Eelb
	SVUQAvSErqkq/9kSIRd60GRwBbKc/rE62iYcG1XMLSLytJa2Zs4K0b30XAkXYTtSSlcbf8OTsgr
	49ATAwQINWKMC5DN5cEFP60TztMpOMzekPQCJZweznSX5FshxxaNxTz0dc6+AD8BJPbHMfiilQs
	rBUBX2Cr+Te8nWxWdKcSzU5Defyhoc9RbFuHV6IuXUZPJPp9xr8S5VaaN8Atqi54h0Hr80E9OJ/
	jpKnkFXHq5RSc8S9N1dZ5gFeuel4HACJMYu25MCKg4pR0+KRiT6p3aZDi31k+O71Vd6Jqol8SKM
	AxWZL9ZKy8QlNLtVTMEkVWsoxo034fYCkpQt2ES5g5QTmvJAYjEor4ngTT0GlrGCb6w4=
X-Received: by 2002:a05:6a21:4eab:b0:3e0:de06:126b with SMTP id
 adf61e73a8af0-3e16beff287mr10686193637.66.1791865120247; Mon, 12 Oct 2026
 21:18:40 -0700 (PDT)
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
In-Reply-To: <87o6cyxyau.wl-kuninori.morimoto.gx@renesas.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 13 Oct 2026 11:18:28 +0700
X-Gm-Features: AclHuK8E-95w9dmy_Nn8Ii2RGxOq8D0J-l4YT38o4WK2kAtoUqqhMqA48tZbgYk
Message-ID: <CAABR9nHvCfabGfBu85bm1r=hP3b0ZiCsgZfShhOv3gNUfjjhGg@mail.gmail.com>
Subject: Re: [PATCH 21/24] ASoC: renesas: msiof: Fix msiof_close() being
 skipped on rollback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
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

Hi Morimoto-san,

Thank you for your review.

>
> If so,

Although I don't have MSIOF hardware, I tested this on FSI hardware.

I added a .close() callback to fsi_soc_component and forced fsi_dai_startup()
to fail to trigger rollback in __soc_pcm_open().

When fsi_pcm_open() returned 1 from snd_pcm_hw_constraint_integer(),
 the .close() callback was skipped during rollback.
When it returned 0, the callback was called as expected.

>we would like to have such comment to indicate such background,
> because it is not intuitive for people.
> Otherwise, someone (maybe me :) will return to the original code.
>

I'll add a comment to explain why the return value must be normalized to 0
in the affected drivers.

For MSIOF, I noticed that snd_dmaengine_pcm_open() already calls
snd_pcm_hw_constraint_integer() for SNDRV_PCM_HW_PARAM_PERIODS,
so the call in msiof_open() seems redundant.

Since the first call succeeds, the second call should return 0.
Would removing the redundant call be acceptable?

Best regards,
Phuc

