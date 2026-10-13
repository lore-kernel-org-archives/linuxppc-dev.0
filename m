Return-Path: <linuxppc-dev+bounces-29350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A80CC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:12:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3qsP3lpfz3br5;
	Tue, 13 Oct 2026 21:12:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791886377;
	cv=pass; b=Q2eH0YVsTk566Z1CpStcjBT+Z6+OP9a5cNwT1kTLhmjcQpRxfo3AV8FXEWo0+0aSOBW010JLxyoOxkGPDL2okA6+1LPjz9oWYBdrgY6JNzdchcoa5v3yroiwjHaKlFAFOcesd+BPVpHzp1IjwjnwlfHX8Rwusg1kUxBUnglNlCmmgSW2d1PX8oqjffh0QyvjISBm2sextziMgg5uDoo81WRRdYHMuwC3u1mUcIqzxH4ey7o+NC/ZuvIfjvae2tMZA1ZgWOsJ8f2YhLGjpx7QUqPA0vQeYJ3CVe1oVsXgldVTxVK8BxfJA9bNOY4Ifu24dDSw6ZDcVDNWgk28TlMKfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791886377; c=relaxed/relaxed;
	bh=oYpuymV3tgk09qaaDkKOhd9dg2Zp4VCoofN6vnpJl7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMxN/h77799QH244NAWMOn6pjwPC82RZyxVehulMG+xtRr69cNZCumiQ76wvGfcHjgdHqXujm7oEpl8h/9DYpdkwLhQlmJh277Xj48AD01Jz8jCRpg723bYm32pSEONOCd90h0/LK4Ud7sdGRaNCBK1M/ENtI7S+idSE6lmIGYFa+eni6ZZcHovof3ZgeKwNOFJXAbdiIk0KGOSgOa7VKDOYxmK3h68cSN2ooZU+yq1qGRYW+u/lh9HdokRmZyZsYhPJeoJgcPpwe2w0iFUKsAz86gz08dGhk+7H0hxwMIjlVgDc1lWlhqhNJDBMOzAc/CYHCL0F8g/KXFSNexXE7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GyzRjX6f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GyzRjX6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3qsM4z3Mz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:12:54 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1170414a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 03:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791886372; cv=none;
        d=google.com; s=arc-20260327;
        b=YwvPuhPA6HrOsGY3z5qd8qVU9CWpq+rp9bpYJK04MNxWAIPtTh4GgTauROcDL9nOW0
         1v4vr/7OtRWesBscOFhDsMvgncmie6N7Js88KTwgUPxQXqIDNmtQ37KVaxN1wZj6Vtjm
         9E+vlO+GLuufMCwFh3804aG56abbLm/5rmQfnWM7CtXeZDESDP4fniHZOow6Wb/kvc1i
         2yy4DzkVtPltJoAnbloPSLKyTupcjAjaij0RLXAZX1qwgoiyggENGxmhb2Jd/2w0Ekw6
         E/Xbt9GSty8+nQ1K7zwHzGSK7WzGUtzwPj6dZ+1yc+EhwHbNzKHZISBKKVXYiGf6gdY1
         zzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oYpuymV3tgk09qaaDkKOhd9dg2Zp4VCoofN6vnpJl7A=;
        fh=c8w8ODJSd4RFPwf+TTfC73BgiUzOVudJ83U2rjxWXd4=;
        b=q2VSDcSwjRPqayJ09y9A/tePcIWGNesHZ0QyY++XSPtb20MoImOS+r+NyvdQS/M227
         iDe70vWtcDT7sIxFAPgM6cbAFqxLQDFGm79Vch++vQTyxAa1ZBFfwhDmIvKngeGgKDx0
         ijZQlKJirNdt03S6QOUOSgyKyoN85FSzOBwBCxD8wKE/KovaOYfwR2rSpkmtMvgnZ33Z
         9MJXBRxa9r6VqR2EFBuwxyhQ/Bs9ySkAxs+fezzBiSorD0PINlQsnRkiH+luMs1fCOWc
         qh1OI3q0spsRDCuxQlMDWRJqTK4cV/RWq5zEaeEFtaKk5Ioa/wl7ZbSLyIGV+hEbDDzM
         ZEaA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791886372; x=1792491172; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYpuymV3tgk09qaaDkKOhd9dg2Zp4VCoofN6vnpJl7A=;
        b=GyzRjX6f8pnmTx268Po/sg0O9t0Am+UJHAKokwAUFsULWq0TfTNUkas7lrbK80oMTK
         vUBnFCB43Q7zggoD7cjrJUsd4aKpdk31H1e4Wi4HG9zUex1roF1+FRB9EYlenL31yo2j
         Q3Hf7D/0TRxhz5mBPpiYteaSeUvj5LNriVo7rXR//W2f3PeYyGPJ3eJask37lQMeQm+x
         p9+ApJ3XVjuvTOL2s3oRP9f4/xZ6N4L4s+BwQXxbHDCOkE3p5lKSgfnmZbgJrBeWbjt/
         XqM4Rc6d9pFcXSb4XZFfX9jR+RHnpybUWWhd6OhVOS7ayEp4q0BhFUrRVzDMACuKLLpy
         Rmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886372; x=1792491172;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oYpuymV3tgk09qaaDkKOhd9dg2Zp4VCoofN6vnpJl7A=;
        b=P2G01dKkDcFbX4m9uR6jJxjB1BJiWXNeTrJRyk+S0fm1A0lNdxFZKuvcl0waqHU2Fh
         Ps/Xm1V5BWXCCnHSzStZpBuWF/qWgjVHrfCctA4GM7X/2cZxZ6nVNlW2YqSublJrTi3L
         bDO/fy0pLS72TRkahn7wpcVpKDDxA1x1q3mCCAE9sBhOtYYc7IcyHtZXe/NqA1wV5K3w
         CiqYvFuIE+uGy9TmeBXRzY8vRwToBt1Exzvn0jVJhw8pi5TFEkn1+QDJKyHVOr17pOGT
         Kb/F9aRbLHwsQhNr9RQN//bUojd38DnQdNyQTiarsHErhr5A1B/t5GINA8FrP28VXzNh
         LNOQ==
X-Forwarded-Encrypted: i=1; AKwUvBywKS8BqWmcy056WeWirMSVrlJcJQql9obtH81dscMv1zT45KfKZaRVgg+ZayUljFyXe9+evY6p0UB+Y00=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKd9QFlXVe51xgws2vnU1lM4Xw0NGUmOUGXqguCaAwOhJvTY/qM
	i6bmsMYZpXkd6pSTeDcm3StxIuCZCXq55BeRStCi4aLMifkPjfiHk7VYN3rrjuh2svTiClEUP6K
	7pWCA275iLAjPrukar4j6wDofy/gTApM=
X-Gm-Gg: AYBFou1LZc54+yrz2ynUYMV5UV1ku4oghuIkbH4pxwk932j+m6B8qbgYkt77SUF5enE
	gu9DgJ/R4SmciY3ZqhYskIghpjlubWGvrbcGW77vv9jyo2ZhQwRKPzcC/ylLeaLoJRRY2arvuLP
	cK5ULJ9xw5Sd2E9dunVgLhOsBzPJMj8sQm9HWCayzlARVHAUYEZYhDxzJm/kAy/PRjyWFqbo97c
	gvZoXrzYYmh8DGxOWmxnyuHFXu0yMdCvlZvHh/aDfZF0OhATjEFZk8lvRUi7qYOnvb1H9lyKdgs
	OdM5nhFNykrLGuolhmYYT6JyNhT6nxfDHV6rXNoRfdKhIeuytXauXhdxzt3+liR4qE8i483HNx2
	bwAaxwRkSpuFaEY1eXbn1VWPfP0PjfHiOaF21lSLSpeU5Z6JeXgVKGnvzGjpU5u79WIA=
X-Received: by 2002:a05:6300:6bc8:10b0:3e1:9071:acb1 with SMTP id
 adf61e73a8af0-3e19071d79emr3692539637.89.1791886371799; Tue, 13 Oct 2026
 03:12:51 -0700 (PDT)
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
 <CAABR9nHvCfabGfBu85bm1r=hP3b0ZiCsgZfShhOv3gNUfjjhGg@mail.gmail.com> <87se2aw3ot.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87se2aw3ot.wl-kuninori.morimoto.gx@renesas.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 13 Oct 2026 17:12:40 +0700
X-Gm-Features: AclHuK9ysK1Jav05byu2z6c82z-Prt9juV9RV67s1OGQmeMH_qLrceJ2TQNxX6U
Message-ID: <CAABR9nG-YJZEdj6pVD-gbGU6J2EfRMQYsKd7u0UTgfrWOyAPXA@mail.gmail.com>
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

Thank you for your confirmation.

> > For MSIOF, I noticed that snd_dmaengine_pcm_open() already calls
> > snd_pcm_hw_constraint_integer() for SNDRV_PCM_HW_PARAM_PERIODS,
> > so the call in msiof_open() seems redundant.
> >
> > Since the first call succeeds, the second call should return 0.
> > Would removing the redundant call be acceptable?
>
> Nice cache, yes please.
>

For rz-ssi: in DMA mode, the driver registers the generic dmaengine
PCM component, whose .open callback already applies the integer
PERIODS constraint via snd_dmaengine_pcm_open().

Could we drop rz_ssi_pcm_open_dma() instead, and keep the return
value fix only for rz_ssi_pcm_open_pio()?

Best regards,
Phuc

