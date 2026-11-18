Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48674606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oaQnw3aV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTxrz2Dmfz2xdV;
	Wed, 18 Nov 2026 20:59:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794995955;
	cv=none; b=l6WdJRZYuiNETjytV22OqMuQ+HJxJMWBqnLToVz2Ldn1qgaDRRBzkBhidZIc4H5a8wBTTWdaJ0pT6G3898uia1X3d4TTibn5J3TUeQP7CDE1e9CCzFZFAhskF/d7U1w4Nr0OLerhFpTrop/BwKC2NGEgv0tuDi2g4eTTitXi8Y9mnS7APcDpKmSWcL1Ww9ypnXmOOJPVwHd0wjzrfoG47ncg/WxL3Ttr0qlmy11+7BBbIwz/f7rY6VsH4B7307gc5vi1LF3XvH0veHCw4oKcXoFFCd9TuS03ydktFswR+a51jvQg+u8p/n9bMo3GAg1DNRg9WOxgGWTFPsI315VN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794995955; c=relaxed/relaxed;
	bh=wVxSIi4bRaqI2NNvgQHyFiPGPX0+mZZDkHVHA/9ddgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK1q6AnIjvK1ENP1I9qIM0q/bW1uvwkOh3BAstKC6pl8RWdW/wdSUjfje/QaewVFQddMmmAwgcuaMzOIY9kv8P34kFT4ohPvBKPKkR0Kn3JwxWYvFBJcY4GgrFsFzkeZlGbO18Pa6OvLswRZrsl2ZgoTamcAeGSDNzTTjaDSU3yRaxczFhSUDB4V4r3msvVsO5noheQ7eBYmEJsf9ZsFUNi7oD5swKvq1f74rotVt8Q0nXor+a0ddb5bMZvcQFRBkNZ2lJKwppIrFC8iYyItzMaMO1Zz9Pg2znWRIqh8AaIelYayorv9aWbAz3bOvb0xwfeb3WNzHxl6OEL4gw9KKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oaQnw3aV; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oaQnw3aV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTxrx2kv2z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 20:59:11 +1100 (AEDT)
Received: from L30177.local (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5A024780331;
	Wed, 18 Nov 2026 10:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794995946;
	bh=PWhoRlLKNjf+e4xV0f2mSPdPAM1c5SfrVYrUMaV3T4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaQnw3aVfnOts8ga92P93O8AsnQL0oPXuJ2clCNHXXjkpLKYQe43SdAtntcQBrCVG
	 TsEz074ulTs4/KGu+ZYB0bkpWZpFkESyq8Uv7ovgeaLAvLNjEqZ8I82QZfygu8hMiQ
	 0Q6ipzXv/xH/91tlCu9+GOjPNHQvE0j1kPxmP5IViu4koP/AOtBRG4AGv+wImgdnO2
	 030X2btsdTzQ8xSttdiJK22GJfzm6z4YLXY8HEbcQmnj/k3xhsq4JcCCsP1FKnoETK
	 aLaLKCGzr/OYT1etXlU8MOuD7ubI5ppHt8Bc3xqUiDZQUo9Iif4h3gUmjQeGO64DmV
	 UziCaH6xhDHvg==
Date: Wed, 18 Nov 2026 10:58:41 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <av120SMcb31YLAWK@L30177.local>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <avzBgDksGfXb-MxZ@lxl00025.wbi.nxp.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avzBgDksGfXb-MxZ@lxl00025.wbi.nxp.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

> It's a bit difficult to manually follow all the constraints, which are
> listed in the opposite way as the RM would have them (function -> valid pads
> rather than pad -> valid functions), but AI says it's OK and I'm not
> spotting any obvious problems either.

I am trying a small update into the yaml file, that should be easier to
follow. You are right that this serie is having an heritage that
should be simplified to ease the maintenance. I'd prefer to improve
it before merging it.

I'll send the update later today.

best regards,
  Vincent

