Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2129606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HEm0RLgX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSxmm6tZCz2y71;
	Tue, 17 Nov 2026 05:52:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794855128;
	cv=none; b=GlsnMX+W6Jmv8aF6b9aNUe56zuwWkwIFa30AZn7iadQVECIqcfiDrkf6XeiJsufjWgigZDADx1M0RLDJyZ8hwVtCq3eHELKMSQy3b45PpVgenK/p6vXpckulJYZQqIxbk4Yfo7I/7qAxn/mlrz4HEJAaRk/ddY/UDjlPwjcsE4vGSJgFP0W36gcbQMq/1c0RuHhFih+p6R/4/kqhdQFWsaGyG7TxW24Iz0eDlzdBX6GSHJa/KTatjdTVKlcFAANHtM0U1HagKJHeAJnaVTdzp670bBOKDiUjNwHE7wPY1YIap0X4FO8ReYrfUSCe1HaeG9yYRwOXya2P2LInKJDvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794855128; c=relaxed/relaxed;
	bh=Sh2nmNQTVOWP3szEFLOBn84NAH4nPLsfx0J4lAR1HLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT4SDudWVakWXx/VK1ZW3uEaPT7wvF/CEAuuXNOweEzLhkdNV60Uovh/wKS7dbljXxTfvpzzAKSKlLYnkAgb1plPQ9XUKJM1OaY30/u2C00PnCsps5Lpp9xRB+2c2ndh1r723hSPykdaKP5wOdRUrBpzd+IhR6ak+hHQa2gmWZ5y941+OPnL1UGBCoF5qNq7U8oF38FDX3XiLzNpSIwDWszUfWvwKxq5uSpm+MVDDesO2ygpBDoIjmO7PbkeNIWlCYgwL52EFtuK19ClvFkzPB9p+x/ab17gIMwV3sclEPwBNPhIW1N0iGCl4NMnuoeouArWNCFW938VWAa5Zxu60Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HEm0RLgX; dkim-atps=neutral; spf=pass (client-ip=212.27.42.2; helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HEm0RLgX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.2; helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSxml57XCz2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 05:52:06 +1100 (AEDT)
Received: from l3017729.home (unknown [IPv6:2a01:e0a:ac2:22b0:3d85:8d5d:9362:361])
	(Authenticated sender: vjardin@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0D9C9200433;
	Mon, 16 Nov 2026 19:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794855120;
	bh=Cs4uDxAEdjU0yi/6Yx0YrRf3kzhxHuE7ljq+oh0YydI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEm0RLgXzcQkeMQMm5ajqLQ9UEKOvOUoWOl5Pc5Q0lkeqQge4PXgMTfi5oQs3R821
	 fs3+vi2x7Od996DyW9jGedzsoPGf57zVtZfhANZPXCrhJtPtql+njrXQTm33d7GDpe
	 fwbdKUpT9sbWzvDCSZQmID7MYyXvgK8DmDc2P1NFUDtmOmjBHBYHAxTIsy9Hhtdfbd
	 fHjljJW8FpE0OAInxyP93ShSWSTQ4Ot18Fp8YetBuzfM1+FPYTt5cd53i0GEugDumd
	 5XEGVgr+4Ki/mAd45/57SNNYyMsQVCyrQHjuLTfWNabg5RGEGpYCVNTCpw7VDpc0Uw
	 NymSo4NXmIbNw==
Date: Mon, 16 Nov 2026 19:51:29 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Linus Walleij <linusw@kernel.org>
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
Subject: Re: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avtQsSmnMtzj4JZS@l3017729.home>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
 <avs62BhLjlpouTwQ@lxl00025.wbi.nxp.com>
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
In-Reply-To: <avs62BhLjlpouTwQ@lxl00025.wbi.nxp.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

regarding Vladimir's question:

> (which they're not - iic2 is a group consisting of SCL and SDA, whose
> function cannot be selected independently, which is why you've grouped
> them together).
> 
> I suppose this is OK? Not really a pinctrl expert here (and it predates
> your work - pinctrl-simple worked the same way).

either way is ok for me too, I do not properly understand the guidelines
that would fit best the kernel. What would you prefer ?
  - muxes per pad ?
  - 1 pin per field ?

thank you,
  Vincent

