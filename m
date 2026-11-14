Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF810606A334
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DRTkaIZa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRrQf754lz3cNP;
	Sun, 15 Nov 2026 10:47:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::12"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794700058;
	cv=none; b=kMVnuf7fu/UtHPcAmcmqu4ePn3JmaOgIK2VBq99tbA3Acns/mYTNMFq/6EGusjAkGm5ctIQ2Rhw4uV9CZhjoaPXzfqJ2aDInL9qjjnqb/YjyG3ha5DcqKl+a29/dBKW7Gx7NG5TcD7aEjSi1qsTq/8M2hArbL4jqRcFwyUtKcgsXWXEKLvwkTWaEVo8OieXgWCHuZbp0COEr6yv6DZXe1l73FWgBSqd+VN4IX9+AL9iRAkZnQbGN6KwvxJqXk9fp3xOwSOjlW8BzR2lyqEeUAydvMmCHO/PjKcHlm1wqXbbF2Devrhm+vlD+2f5ilP17q4hLzGrU3rH3hIH+6OTmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794700058; c=relaxed/relaxed;
	bh=+msR+L8hupIZu3L7AvrprWnt14EoIGonWEztPzERWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Tu5lxhBBbrhoT5n2MQd9yxeHTzfjUAL6PRY2sMACk0/KIF7VqDg5lF2QwFjDmOXhQFTkLtD1I7CNLre72sqWb7mCiW4PigfX4c6KbxupENkPHrrmuvX2H/G9u/lFFDthS2CMdeTWcts+qepXbMZUsKf/S+OuTaiTOnUHav6OPvUFn/gz4g1U2TmZekNkiqpE4IB2hha4PEQYewdsCJhmHWIQT59wLRLIlTI7W8jjqXVibfW1O7NOEQ4bbLGpSrnAoDPoV1f5tqvRpsAy2DUO1ULGVidjsq+TOFhkejAwuaCLxJu4LGRg+ADr2b6M1thdPDECN0v1KtJqPqSBSKoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DRTkaIZa; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DRTkaIZa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRrQd4gnSz3cH3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 10:47:36 +1100 (AEDT)
Received: from L30177.local (unknown [82.65.104.223])
	(Authenticated sender: vjardin@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id CE22313F880;
	Sun, 15 Nov 2026 00:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794700050;
	bh=3DuhsD14Zo+NE2HJ5h/Fip7dpWi29Qk67BwYWlaEb8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRTkaIZaYSzmqkoLQbhO9xlX4cTzmOA5DYPOCj96tq1OnyApDP1+kVRiRn+70PlFS
	 qPeIxbFJcwi4DDTbEXyVTBvyTdu2k4FJIFH4bZP1fpta8kqGcB0JzORI4dSFxiGcOV
	 uABtjcmX33/nN78SOb6wasOQcfzoVwBA5N01QCLOOqChMfBiDzGQHh1vtYbhkIgrk/
	 dhC1DmBpCenH82iUoBWmtDFmYoXRDRD3RSGpRhPyr7pRd3X08yAQQoZXCZeVvI76BW
	 gPESwU1Cs/6ksgLAgZ9AEsHDdSnkUArgMn7MxrmEENwElzAtUfBr7gcOf9F0eTwOC8
	 6QVVl55AxHdwg==
Date: Sun, 15 Nov 2026 00:47:06 +0100
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
Subject: Re: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avjy-lCL2A9gEhcL@L30177.local>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
 <avi9N8P34X5uel7a@skbuf>
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
In-Reply-To: <avi9N8P34X5uel7a@skbuf>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

> I cannot agree with your API proposal. It exports to the rest of the
> kernel a blanket API for RCW override of any RCWSR1-RCWSR31 register,
> *including* the SerDes fields for which the fsl_guts module already
> exposes an API. So with your proposal, what can be done with
> fsl_guts_lane_set_mode() can also be (un)done with fsl_guts_rcw_override().
> The possibilities of abusing this API design are endless, and I don't
> want to have to deal with them when I can avoid them.
> 
> At a minimum, I would recommend renaming the API as fsl_guts_pmux_override(),
> and make guts enforce which register fields it permits overriding via
> this API. Example:
> 
> static const struct fsl_soc_pmux_mask lx2160a_pmux[] = {
> 	{ 12, GENMASK(29, 0) }, /* IIC2..SDHC1_DIR */
> 	{ 13, GENMASK(29, 0) }, /* SDHC2_DAT74..EVT43 */
> 	{ 14, GENMASK(10, 0) }, /* EVT20..IIC1 */
> 	{ 27, GENMASK(7, 0) },  /* EC1, EC2, USB_EXT, GTX_CLK, SDHC1_DS <- your series is missing these */
> 	{}
> };

good idea, I'll apply it.

Thanks,
  Vincent

