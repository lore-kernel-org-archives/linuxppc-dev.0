Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC1606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGQ8dyVy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7wr61flgz2yjp;
	Tue, 20 Oct 2026 13:11:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792462262;
	cv=pass; b=NInKorbsAvdOZZmLE/gvmjN/MDQVg9IEtcHisVVAcAFxWYLq/98wrbCT12aLNgvDlG/xBubGqU1IJskgh2dE4aRholVf9RB9p1bDXu6/fPSw5bssFRce/p63XezXxS7hTDvqR+ZtdZo39MKy3RCegrJY5t/KPJxrLSsF5uuf8uKXLuMAOP6t5CyKab8pj1l9gNkkz4mwCrHiXg5mQnK86G4pf0VSZoxYX408odn0VSVgDjh3l+rYxmWNSDqdb0e25Kbu4s5djtCIsw+ifFKjx9FAgbh1j4bEuxL1tqampWT62jO9gVTwYyrJf21gnwK1Uvw2Pqhe43uBd633QhEp7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792462262; c=relaxed/relaxed;
	bh=J2awcyyaXtld8u9NUvdPyChgRrjEUxgKgS4S5LDKLZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cq0z/HM+yyPpuUzBBakL7jqyNFCtXPEAz7Hq/Pk6okGWveL8P5sk8Xf62NPpus1/PZ7wNa+HKZ2VtFGXXW1CsK4a2cg/77YCbeJnMkUx3j3JD0iABmk55l4ZhNrv1+yilagRe5ZnBAzkc7umY+co7OSCgsf5YRIpM+oR0q1Bdxfn4wXbr6tLgKXyyJD4C2gMdALavg/PU8mAkSOgHQ8Lc/QqhXyc+n8/enidBwuUkba5InEFAki2aMWF4QS22z1Ezbriu/u7aFydw1qcmZk0/yp+0TfUU99aMfhTe4ZxATErobomUmL5w0m0zfdjXDM75BtsL4123RZlr6Fm0qHj5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGQ8dyVy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGQ8dyVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7wr42pxKz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 13:10:59 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e831e86ebfso12819585ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 19:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792462257; cv=none;
        d=google.com; s=arc-20260327;
        b=AtOshRpmeVhdM4uuWo7ch0Ea1WBambtUVFFaY8xeF+Ye2g6lnmZb5U4dam/SUjguAO
         CfHewToy95GWn+vohTYi2R9eXjxBQb+sAKXt/TVsvvPHbowWCawa3++bmqh3A0YoCCpR
         XGsrQQ22T+sIFTGUIegiVbE+EfYytmaWJkRtVEtYA/5SgTi6TIqH4km2lg6TeIB1aXFa
         NmJB7uV6aDukUch7zq2Lo2WvZsrjZ9kE3vnsl3VupoxolTIwLgqF8FXlJIqfAXl7iqCg
         iUT+QZ+IN/AHr1/+GDJRliqPUvHXq1Z48o48jo8HIOj1Iue14HuEOO7rcBZM2tocp6fo
         XsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J2awcyyaXtld8u9NUvdPyChgRrjEUxgKgS4S5LDKLZg=;
        fh=l0RgT/7xWi/pD5TJFzWE3eMxWDxeKOL1TRFJsezGQnw=;
        b=WG7323T/IfMrhBI8UtudrVnWoOsYQx8B+oUoRsr9nT6qPlG7c9QdYvP1vGSksbnuUM
         x+1t1bUhiUFaLh1SoHan7HZyS5sOozb/iMzVGzvhK/QfqB4mB8ekxI4Lz/XAA5i9PwwW
         lAL6d2sLGqGuXb3nJgyYINr5iiyTFZJj6GA0sb3eKC/qdnajXSKdWO+skcnuY9/m2MwQ
         1hOkMu1LM9h0gfEjh4Zamraguk3XJwp2zW+2Ttuq1jHtm+4Aqxc/LlvNN3tNzXF8Mhad
         4fjLXrAGafMUwrfIIYL8Khvd7j/n0svjMV7lv//+r1Z2Bj8W9U60kbTXHHl98cW3de19
         7uOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792462257; x=1793067057; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2awcyyaXtld8u9NUvdPyChgRrjEUxgKgS4S5LDKLZg=;
        b=pGQ8dyVyxWgPFS5EoggAIwRLmE9QRwHE03uV/sIvzXdnZLLyLgp2QA1kKCcSCjbnow
         cuatpic8dLOMGAMRLYR//v/4dtMFj/BzvC7WcWAQ8iHRosIH7xtaUJIQf4jsNxCqt9Is
         AUTQnxJDWfMRZYtCq02OaULRcw93esFaeOpvfix7Te1iWP9P60T3OTUyaWvCtqmNDPqP
         zJjA99pnhDZ+b8bCRcgIv3vjh/SqYgskX1DJ3PxFKkE2hVzV2sQ/1rzCoD/kKFnEwWpK
         O7Bs+fRnnPlDq2K7XMfmXvR/lPZs2NM2Xv570EWV+Q1/F61wgkq8TyFIhcDy+/2bAcJG
         o/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792462257; x=1793067057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J2awcyyaXtld8u9NUvdPyChgRrjEUxgKgS4S5LDKLZg=;
        b=yVcYmQkqUlnzXEiq3svtj8VnoHUD2cSKn7lyvpa+pvFO4l2/bVfmZVNzvLuzj88WiU
         4BgoKSaBcVPuJkvAlUttjaS89wKImrLEpo+MvBpzPGMqoxObnqPSUVq9KNj7BFf/hGU/
         ZtlavMZpbBy/b69oIG4I+Lkucs7ZFv6EgwFnrkr9AGFlsexpd9pk9G3ZNAbV7Gl+Uzu9
         rkpjXFNa9HzEjhUmt48COdocu1F1Sl0DM/u9MWvVhx9sqXhZeNMZj3n5MAyBxLO6gID2
         2p+jBI8OY0rgfkinXQBp2tZX3Eb+D3OFgaHnxJDohQC/wF5iO/cjKOSfghsL2gVQ1zHf
         de9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxrUadPiXecV+PJxvIuGnJAqmhPNSG0j6jr2KgkFFCJLgGSLB3d4RF55jPkv13Nb7pfb4PCJ4IlTuOkd1Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKpRnOv+YxPZVEo/nBu2eXpdWheh9fUHfymkQzrKLGkGC7vMAFE
	XNoWTQfP7mY6WE5QRWm/MD79M/oDHhN5WFbpaOaEoOLizidZt3qzyN0Sg8bECNsXLX/MgLln7e1
	EfSLHQiASxwF3jZ5qvHRtEzHyQpiqcmY=
X-Gm-Gg: AYBFou1vbbNW6qmTUtr1RJo6eWVoM4ilG/CDoo08eahwq5FUEPANhCcdIG0zVQIbmKF
	G3Oe938M/S+RLuT/UTulw/+1r/2D5pCLWozrs3aZVvY3mzuL5eCloyiWNoUlMqLnKMu9M6xfAUM
	1tSL+H3P2BPs1xtSnVcovlkM7e+kUD6c4pq4hcgv6ilbSeELRz0Z+EiLTX7cBh0ezV3hFxHBBT4
	BhwTKf2GmB6uXIGkBIPexkuJsQg3w+L6uN3Wdj14yg1Th52nP5k0R2bpIoZlNHkmugTl2+uL78Z
	6ZICeaGkOPA5u515BTCqvddrWsKNVifzcXcRrVMYxprU9OpXPzfnWuRAjdgkonO1PajLLxeyk2P
	Q+dJqgviW0M3NK2ig9BQWPhnMYDlVK8STnO9rMV0NQhL4xcK5llzP5NoNH7ZwmUYC+5c=
X-Received: by 2002:a17:902:e547:b0:2e8:93b5:c555 with SMTP id
 d9443c01a7336-2e9a6e5296emr76192995ad.61.1792462257434; Mon, 19 Oct 2026
 19:10:57 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
 <20261016040946.521195-11-phucduc.bui@gmail.com> <14f60932-9a85-45ee-ad87-593c20cc116b@tuxon.dev>
In-Reply-To: <14f60932-9a85-45ee-ad87-593c20cc116b@tuxon.dev>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 20 Oct 2026 09:10:45 +0700
X-Gm-Features: AclHuK-OxoOqEZe9QHO9PQT5BaN1GB4IUM0kwzQZDjYp5iThqBCJWYOaobvziFs
Message-ID: <CAABR9nGOmx6zvost-Y9Zd2nzQa+ZMYxt2PtZ8xYPLZqZVGHegg@mail.gmail.com>
Subject: Re: [PATCH 10/11] ASoC: renesas: rz-ssi: Remove redundant component
 open callback
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Claudiu,


> > In DMA mode, the generic dmaengine PCM component already applies
> > the integer PERIODS constraint in snd_dmaengine_pcm_open().
> >
> > Since rz_ssi_pcm_open_dma() only applies this constraint, remove
> > the redundant component .open callback.
> >
> > Signed-off-by: bui duc phuc<phucduc.bui@gmail.com>
>
> FTR:
>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>

Thanks for reviewing and testing!

Best regards,
Phuc

