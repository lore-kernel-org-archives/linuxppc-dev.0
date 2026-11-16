Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9C606A33F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=gbLeb4W2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSvy8517Wz2y7p;
	Tue, 17 Nov 2026 04:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794850208;
	cv=none; b=eCu/mywrdlYUuzMN+/8MDsdBdu4WWy3kUB3KiFmMSaZTOnX51YCSkBVaQi4vxCiZefYBbSWuY5fROLSnoHTcodYpYxTquCN1yIzfW/HFdOD4MM0NxGTiTUIyRpMFe2VGJRO8xWGpuHPXDU1OjzubHpnsrDmJL9ZGiITqhY7SXZrKqGWG1a5stPRJ8t8i+MXvbfeHxJNsl04WjAGtgEULJIWnajzfHgJZlQk5fq3O871RYpt7lJhO8yQHX3ZczGGyo4cw6xY6STEIh4NFcGu+CK5wM0hYtuh4qjmLyhiwGbsQXiy1p4zx6NazGrx4Rb/HzSklx4rT4KLzSUeqEANu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794850208; c=relaxed/relaxed;
	bh=+TAV8zxCLaQRFWFko9N1+gmI6Hkj/Ua5ZfgjdQ0uN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2p9PwQQGeATdcBnP21djWwtMZ3j9XC8d9rMnMGg8c/V8TYw3Cb6Rd0fzCMXJ6ZqHgQjOsMJdngh7ZbSZpBeLJHI/5WqDEPO5DvCHGlqo/RZQZPnzKG/hF7hNY2MpaZNYMy2I9V6LBUsB/k9nHz27v1dnh/apIgcwpphXZr+07sJMjXsASmGwN3LSBBfF1iCUvBXDNwXdxcpUBi56Ns17GpY3wQp1jYs+Cm+dQxVhsaVUVTY91ZumIfxQLyGx/E+2e9xUiPzFurVQQZ3RVAGpI76APw0+YgYMxm+jQA/7S0+Lqycb4dasN8yfkgkJb1aXgRf1sIefX2knhWHwnEgTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=gbLeb4W2; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::11; helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=gbLeb4W2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::11; helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSvy46zP3z2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:30:04 +1100 (AEDT)
Received: from l3017729.home (unknown [IPv6:2a01:e0a:ac2:22b0:3d85:8d5d:9362:361])
	(Authenticated sender: vjardin@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 86EA52003B4;
	Mon, 16 Nov 2026 18:29:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794850198;
	bh=gf1KXaGSHMTIuSeGKV+TB854dq3D1ziSlvG87KmVRac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbLeb4W2rC8PAAvj8pCV3t044hT8rRb/fjjcJF0QXEsHHx5Wvl6EJRID9+XFgvan0
	 k/h/Zg2xuybp/Cr06X62gOXJkliBIwvDvO8DmPch0Y/x3jVshlJPaTlVT0ehLChUlh
	 Wrg4ArJ0gToAJCMhHGbY0n6sTSAzsDCgCc0Bq+QnQsYQ9T38S6LTr4Ev9EmBCdWtad
	 bWVAMmm25HKALgIbEKmkDUULK1ykDTAnRXj20z1oibWJ15IVVtLoa4tvBKhQK6PsmZ
	 AwTQkNuUAIPpXBVhxUE6dxwkTPf10NcpeIu0RI7k4q+m0zWOdSVe5c42c3WPqdCjVt
	 n1V2pqTzTqoQQ==
Date: Mon, 16 Nov 2026 18:29:34 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Frank Li <Frank.li@oss.nxp.com>
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
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 3/5] soc: fsl: guts: add the RCW override of the pad
 muxes
Message-ID: <avs9fmJqYShOIPMK@l3017729.home>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-3-fbdce4565a5c@free.fr>
 <avs4l1otw6ACW5P4@SMW015318>
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
In-Reply-To: <avs4l1otw6ACW5P4@SMW015318>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank, Vladimir, Christophe,

> > Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Signed-off-by: Vincent Jardin <vjardin@free.fr>
> > ---
> 
> You missed my tag?

Frank,

No, it was on purpose since I did many changes after Vladimir's comments.
The goal is still idempontent for lx2160, but the design is now more NXP
CPU generic.

Thanks for re-ack-ing.

Next, let's make sure that Vlaidmir is ok with 4/5 (if the driver is
generic enough).

And, let's Christophe review/ack the 3/5 regarding pinctrl.

I guess that 1/5 needs Rob on the devicetree, not sure ?

Then, since it was unclear for me if the patch 1..4 are through
pinctrl and 5 thru imx (please, Linus Walleij) ?

I hope it'll go thru the proper reviewers,
  Vincent

