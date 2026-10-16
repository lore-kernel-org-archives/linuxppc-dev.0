Return-Path: <linuxppc-dev+bounces-29604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA63CCA462
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5jLX2yndz30Tf;
	Fri, 16 Oct 2026 22:26:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::633" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792149972;
	cv=pass; b=WsQatS2RU4zr6ujvNRrmVMt/e/wjfbqOlA98g11+LSMq3eBucRc3RmQVVQB/kqBh7AswvkVQ0L+paw+xFL5h23HHB+193CFQTM1SKorXYcgXQWP2woMsVQXgL3HIgw4SL7PLfFToGcx/IByAp/vYopt8hswruaLjPsvRlhw44dmrBKXfWGRhh1rc5P0H6USU+ZUTRohy8L8gFrjAceGURwHzQPG9Rof23CI6RbJUXY3473wYFQhHM7hbkLZoqpRhyYTNWsrQfLx4fv6lS4kpWww4O6ogNpAGGSVEKSk9sOHEKOQOcRbENF1kRLPc3dSPXIZQV8HJQUhtEyDFqChSCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792149972; c=relaxed/relaxed;
	bh=vApPRxEqpGQADna5mwyiV+wtnRS+6fLHQ7GBxAw9kX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWFaru3rVIfwEgFLDRwhyhlCjWDTnQOOgmGEUVIARFPSF0XNTTOvv+8I/QKADTy+tVslIWdZu7K6uAnoRLf261rH/Fz/Wu39GJ9DsCq5OjP5uEcIC+QUWQfykrlic+KDAig/jb3W9mdtAR8EfwSYHMBMvsm2ffRhcbVRVYyDMrH4TaOKCmlqKkDXkuV3ihqZlKwYYhWNyR33SJLSIcczSSXyg6A9QLMroQkyZyoqmpFi2ojhlfMyiFNxOjz+8i22hHBeXKFWiGIhYHF6t3WYkkAClgFM1yaTiV0gBCG3KxSe9yoEFgMkBMioiVx/d8OAodxFNSii8TSZoIwpAmeqxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ek0TV6ha; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ek0TV6ha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5jLV54bHz30TP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:26:10 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2db80fcdf8bso37339665ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 04:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792149968; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWQiWfd0iOb6wqvXksi5oXgispma2hUFxe+z6hTCfJEklVPg9bYLKv8zoxjsZ5gKka
         5myRoYiAaNJaBF8nGXwLvf686jKEOojNU6PJ6BvzNToBTBBSvkInQbVE0SJJ6Glvqojf
         Xdu1ikORTL60a3TLj/bQspYw7Ho/Va/W/jR+QUDSGJcpQ/cBQLButQZ16aCHgNEyTEWf
         pLliFnWkE/VEghlkNryl+nh1ftA2ttozWtcKw9fBqiEEj3nci/f+0F60MNwYa5AvRsiZ
         +TRe65W58qfx4ZDbgnwQRwXy8hDxU/+fhLJTCvITwUKtuIVqiD098GBf7BhrgWk1uxxY
         S4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vApPRxEqpGQADna5mwyiV+wtnRS+6fLHQ7GBxAw9kX8=;
        fh=RjOJbQhobvHf94tfJ6AfOpa+bA3yCZqYcpzUCe/PD6A=;
        b=WE6Qxar/11u4XeztqIrUK5u10NZLXn3OACWg9AhQImWbAWgdIvtHkzIVJo4m36wGen
         cR7rlp9EP3ZT30D50awj043ibNX/h6ySibLp83mCqAu0s6ybhp4oqZFBE4+pXjHPGTLP
         SfX4OmS3kqnl8WXwrEDLSMcz/FC6W0Fe0ziuqUwKAepXw1ItAO+w38fp/LOydYVjqIyL
         Wc4K3sZeqwQ6LKA8fPyyuMr7BpOBKCblQQIYpA+MxU+YcbWbT99hqHethX4Tj/9hKBFJ
         0xtP14jAasbyH828T7xEFAAeNCkUg0mEU0MMvQFeaH9a1Q3L9hT4LULogU2iMALaylO3
         ARiw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792149968; x=1792754768; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vApPRxEqpGQADna5mwyiV+wtnRS+6fLHQ7GBxAw9kX8=;
        b=Ek0TV6ha/QvY29QHaocBYKS4D84jKYBhLWXlVM4zxbySW5QwX6bAqja5cUnEQG42F+
         +KLtRtXMPirQ10m0sXfDx4Wj2rsm6ifs9KUu1S4FlGevH7p8czpW5fOeUR0Kaxdexz7P
         uVS0RCe6LZkaI+Cl8bGB2MgUDGBDSvhKt1SObURskWQ6fB+28xSXVHit73kTCANctwHV
         IpOXYX2H3Aqvjbh3mVm6BvNJA4POVNZZ8yeFFmL24/khPJz9m/HDmZfSD9hkl+zQeYnm
         4H2hVIBCIranSOHLXGvpg5YSsQP/DbvBtPU3OXTyEI8Z+L1i2PLZbGbAbpTE0RIqVbjA
         AfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149968; x=1792754768;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vApPRxEqpGQADna5mwyiV+wtnRS+6fLHQ7GBxAw9kX8=;
        b=l6ZCRUB7/eEdQgiaNWZbsWHpjuvA/Bi5e6U/Ec8eV9Gx8pd8l2i3bKRKLwRwaxbsVW
         iIvStVuw6Ie1QNspLk3TRn+InjB8VDiubRUJoLiyL+mV+TJEROt84STs1OVbFofh5mM9
         vQtliYfbPxCWy3nGGfKewi6intMxnh4GKUP12X+7zXFPxxLKNMG3f48wSKDjDKRhZ/ku
         Twtaxh7lbSOS7bwNzuDNKPXMnz16ugLdnwW7e5sXfx/iw48zMddqNkX0uyZKD/yK2rNz
         69Ca15I0C5hcJdwK1DmYKikkzidCzzUzv2sl8LQLozf/GZ0czPqJqw9HWJy1lQ1rt2zy
         TWTA==
X-Forwarded-Encrypted: i=1; AKwUvBwM369bEn5gJXo70vqtHoUER793mJclhKD7K0fc/3RqyfcLeT0dNQahcTPyKOFVlgiBK0/v94GE6z3ox60=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIekXzGFvFZNyRyzp2uxEsbFeYA46vdU8koOGCXCpjroNelXZIA
	mDfGt1Lg+D1EJ3AdXlfOC+diTSAZlOKB3x1KYjs0zfI//yJiVL3qOVIU8TXOKPQ+alMZXSfQjms
	h7DzsvZpoj+IK3WupQIZ/0vxy1/MJCtE=
X-Gm-Gg: AYBFou2MRd3MD4npCMmsZKzR4ry6qYeIAbnTExw0c2waxQJlyHtZNpVF8P+qR9xhgsH
	C8kLEIiSCJVyfk20k2KAYy292HahohfrHBnDJSqxHy3koFz9zTokJ6qAkv9xgn8uiYEIGSqx6bt
	GAA/Pi1iMb0KtQx8rQBqllkEw1yHGHg8I6do8Az2+pGLAxljVFB3Wt+lnbpXSnTIuIHVjKH5CQv
	5t27BVFsuPsEV03rfhUn03dzHi0x/TKePTHh4OAy0QCjJ3uUheHTobE0nz3BnWBLFhzIK+VGUZn
	LBZA6OT6+9Pjh5a3Jcct20oCwPryGsZrEO9U0PUzgNhe9t/HQF34lcIka0Nji+e36DpUTBQyBVi
	dKoTbnxiqs6ruwTAyvefKxhpUXJ4HgjrcR3zY0WTm/ys9l9YZRY0LoeYuw9zH+70MKR0r
X-Received: by 2002:a17:903:11ce:b0:2e9:4e83:1979 with SMTP id
 d9443c01a7336-2e94e836527mr62789995ad.32.1792149967287; Fri, 16 Oct 2026
 04:26:07 -0700 (PDT)
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
References: <20261015014324.5569-1-phucduc.bui@gmail.com> <20261016040048.506531-1-phucduc.bui@gmail.com>
 <46a96bc8-2ee7-4c6f-ad8e-94321f8b9630@sirena.org.uk>
In-Reply-To: <46a96bc8-2ee7-4c6f-ad8e-94321f8b9630@sirena.org.uk>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 16 Oct 2026 18:25:56 +0700
X-Gm-Features: AclHuK9bobvuHZz0ZvKJfKfhAJdiG3c7XQlmqU2uHEyUuNfyFRrkKv-rn3SiKZ0
Message-ID: <CAABR9nG8PeQS4GBGwENfHTRBUnroKYQiEu29iztix+py=Arprg@mail.gmail.com>
Subject: Re: [PATCH v2 25/25] ASoC: rockchip: rockchip_max98090: Mark the link
 as started on success
To: Mark Brown <broonie@kernel.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, povik+lin@cutebit.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrei Simion <andrei.simion@microchip.com>, 
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

Hi Mark,

> Can you please resubmit this as a separate patch as a new thread without
> the series numbering?  This is really going to mess with the tooling :(
>
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.
>
> Series numbering only makes sense within a series for ordering, if
> you're sending something separately to a series or a new series then
> preserving the ordering of the series just causes confusion.

Sorry for the inconvenience.

This was patch 25 of v2. I had only managed to send the first 24
patches previously.
Patch 25 failed to send due to an error, so I sent it afterward to
complete the series history.

Link to v2:
https://lore.kernel.org/all/20261015014324.5569-1-phucduc.bui@gmail.com/

Since you had already applied v1, this patch does not necessarily need
to be resubmitted,
so please feel free to ignore it.

Link v1 :
https://lore.kernel.org/all/20261008103831.542533-1-phucduc.bui@gmail.com/

I have also sent the incremental changes in a separate thread, as you requested:

https://lore.kernel.org/all/20261016040946.521195-1-phucduc.bui@gmail.com/

Best regards,
Phuc

