Return-Path: <linuxppc-dev+bounces-29480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC83CCC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:42:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4TpV34YPz2yLY;
	Wed, 14 Oct 2026 22:42:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791978162;
	cv=pass; b=jpTuli5qnQ3COIsK1tjF6D/SVbzT/YVFxdoOMGJso5G9EZzLfFlP5DE4rjo27ef4/wmpmFFZ59lo0YKPCXKu1vs1mPxtGPlMiYc73GbQ8udElFZDB77RP5kYZQ1AyUa2AD40qjxeRkMH/eTP2xL+rHQYUrTqveVHYcJRYaCsEFhYvu7mtzqUmFYDAPOXfBtLQ9yvfMf/P5ZJZmmDQZZoU3n6Q2tm53LjByGoeQqWXNPAEdvvuQRukI3S7IKJHGR0VZkPSLSPqmHx1ssi03PI15BHn6MnnvNXRuTQmKYnL0JPaSqxeyk74ge8FYz2gIVvOcDVChbZG+uS3F/dqW9e9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791978162; c=relaxed/relaxed;
	bh=SExSlJOtRhRzpIj7eRr0FWRac1iKGklAYskw7N+LI/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZWGpHKVay214fS2FMwxYDbGJBRJjuJ3xAJJyv4Db8tg6VyRUxA/h5Dqy5g441nozj7DxZxcMUQw5a5Q3k+87Sr9ouba+FgNSwICZM4pYXCtKqy/XXqEqsoiShWnMnbMmfsbsE37U1jvi7Hdp0h+D7ju4HU4UesTfiugt9iz9W6mbeVHqTmQdswGIn1aU+mZw+sQ7yQFuTYzd9MNf9VPFMro0B4ZK+CBoFesjUSYHN7CUrioiPrN9v42mHlRaMeWkpLDfL7teiIe7tqveF0fTVWxkqSRnZrdNPfwptZCsQMs5SDnJt0G35pJIiFbU++G73I4kfS4IOlnZfvJSD4/zA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G9fJF3dP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G9fJF3dP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4TpT4P1qz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 22:42:40 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso14835945ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 04:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791978158; cv=none;
        d=google.com; s=arc-20260327;
        b=rdSvPdKjlxXSXwQFVkaD9Rsv9rZUR9GoKXuT8H5oQOTkwbdn8VQ8tZC1HlybUQsXim
         EeCqG9D0vzjnA8KckfHhYY0arZepI5oMvgLTGzdt28bq4dlI2ZUHMOTQRH5JBWp2OZOE
         6o7cS0BE+IHxU5SrRCXhFuRXKaL37uqgJlSyK59XbwnCMuDF1dyhc/KQ7RtpfLe/z2xr
         A/ofhc7UdloQblcBsyUjCvTrh+pAcq/3IiqzUTjWUYRxVHttXMsVqvWJqPnP4vwipnWd
         Tud5Xf2fIkpMUzFvv3Veh9INwcGzSU1M+cc4pSGDsbWVL2hJdbkXnBjqXIexzrhRS4ut
         IKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SExSlJOtRhRzpIj7eRr0FWRac1iKGklAYskw7N+LI/0=;
        fh=6q/y2pfQE8r4jQud9DF2hJnXgho1G/puLJWTAZWDQT4=;
        b=S72xMf0v54EUV/DTm29hcVINwelj8SR0LpsnBXsFO6lHz/gxRQL6EI0Pq/7JRZbRcU
         wEGJXvTL/CzMSJAy6P0BXnPStnY3sUJYl6tCi5OyVQS+vUc6ZGkArBkM++p0SxQ96n4z
         sK8Ijb/CJGMR16AV6CyWpBNpjJ0kVIvGdh+2l1kqswvMTU3+2zrWu/d+Bs83kz2vPv0g
         2X9EsEtX1eJSSJ8HtPSwWn8FfkxkbFUQTlKk0wHvulTl0rWU1+WkjTktrSpPt8V6ym/O
         PFqz9lvMYnO9CufenAU5Vw5hL7SpKfsvw256RXp1elly0IcyoZAMkNliP5DMnlSH6bwb
         O7dA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791978158; x=1792582958; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SExSlJOtRhRzpIj7eRr0FWRac1iKGklAYskw7N+LI/0=;
        b=G9fJF3dPdHP0Sr613KpOlCwIOXDCkmIlQ+n0Ck0ST1sqXD8EPdKALPcZW05jLN4o56
         purV9OY2aBlWY53Z7jjDi3iyKa/0yKmi4gvJO62byfKzANVrW2jy/b3iVxWxUSmq2eEK
         a3dg0bOt/BP07PHLUTDQJXTT5vUqMejGzqKNxsPQlyE31FvII69gataS0Iju9f1g3XE7
         6pvignd+iUKHPdXSf35iAcN60BBv8vcI97NTL4ou4ikCXsi+jZD63+MXKNcxH1o1otmh
         df9TbiaaJ+EwhFjGTIjRIy5ihTTTictFIUMKfPQHwmJOIw6oZem6MH0NJP7e0y+mo5kO
         9K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978158; x=1792582958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SExSlJOtRhRzpIj7eRr0FWRac1iKGklAYskw7N+LI/0=;
        b=tRnJ5VIDHD/r5TpO9CLISN1ErWsc01SDWlkZljQ0DL2yHGJ2E01oveN+TxRj5H3YE3
         cVrQyVKv13UPhV2qp7Q3M+K704I8rJNs9xlH41gy52aHXZ5ZzJKJo/Z9mIXY8XRWZ6Ek
         ZcPx+hlFUgMT0cIYJJ/Tf3L2VODomOB69tQaIHeuw3qjl3mNgQbTx89ij/I6J5B7FBM/
         fJi5gbJ0vzyOtcSS2ke8wZuithUPh7vYgIZ1S0/93mY9Kfq126ltjg1i6jiAlEG/CNjY
         F9EEEkAjWy0s0NjKXetR5r2MxIUt2DWT5tIECZB6BfBQR0GL3vgGXu4ZKZy8BImPB162
         gkcw==
X-Forwarded-Encrypted: i=1; AKwUvBylern/eFR5XRt8WWiSHFBVy4V8TZ+sgGti7Vo3TPJE/cwCxa9Atu7Z/pqz5I9RfPpXzLrNh9JCOq9fwPw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJS+F/rdN05zQROT3H5N8b9l+puaRkpvvN2i633us3zJR48QjGU
	IhPga+ZigyXgJl6bHh2loTX8EEX4oO72DvMrt8r6DhaZy1lZU9f6YbkBZDLDOXth1q5mYoKX3ia
	EOdNDPYMJoO5ybYq9/Ai3NNWXY127Kg0=
X-Gm-Gg: AYBFou0yGOWzDhEAxYsfMy76zVQO08r9AxY2M8qnPLrjJ7JeimKZoh515d5Q5gRfpsi
	H7zCFbWEJJC9cXDKp5ET4e4gvwEAakfxCSyBaHyK/PQzGlApR47dClV7/HEyrEJSIWisdTW6Lv5
	mMfcac3Ui0Q+Xr8GwqpoIhYH5kA4O67mcW+wGro8khhE5Ephrsfw0YN78tthtSjCR/8l5j1OGnI
	tjhkkpu5FKEv5Unpg6ltBoDDm7QSQlmp5QIWXKCMmFL1SesSFJAOb37O9tn6NCdkBBDwiV2Ynz3
	BBeZooSVx0SK6+hTYA9fMS5PKuxDtGZOY5MLnpR31wBGkKO+3rJ17QUBQtzuapBjg5NrpJmSwfw
	NzCsB72HJdxSG+8jtYeKZL6B+4GPU/hGJXAP2JzC2Zv1xV0zRQ33IfImJ6Nj9pckkSIE=
X-Received: by 2002:a17:902:db0b:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2e8427efd9dmr151731365ad.5.1791978158291; Wed, 14 Oct 2026
 04:42:38 -0700 (PDT)
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
 <20261008103831.542533-19-phucduc.bui@gmail.com> <14bbf027-4a16-4bac-b530-d4654ed38d4a@gmail.com>
In-Reply-To: <14bbf027-4a16-4bac-b530-d4654ed38d4a@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 14 Oct 2026 18:42:26 +0700
X-Gm-Features: AclHuK--pm1YXW-dAVCk4mePmFKUqLdOhzguEaV2jSOsxf_MJ7HFDWxjeVZGb_U
Message-ID: <CAABR9nHyso5GHpc5Gg-KLF3hJkCHQCYz_mK_i3_0fWDEimLEtw@mail.gmail.com>
Subject: Re: [PATCH 18/24] ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close()
 being skipped on rollback
To: Chancel Liu <chancel.liu@gmail.com>
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

Hi Liu,


>
> Reviewed-by: Chancel Liu <chancel.liu@gmail.com>
>

Thank you for your review.

Best regards,
Phuc

