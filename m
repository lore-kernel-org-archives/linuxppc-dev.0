Return-Path: <linuxppc-dev+bounces-25838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F2BC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:21:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLtv63vLrz2yNj;
	Fri, 14 Aug 2026 17:21:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786692082;
	cv=none; b=ESycXv5GFNvbaEacrWURMwdn3Uf+WqaVah0Ul5Wsoltk9tdC1nwPxYoHg1ANlhkC204H335uA02gcLkojDdhDyI5IRP11qjH/e1kXWC52lHGiZop8FBmYDoA2NYxDeYdMpzDlUTvnXc2Q/p8/sNbaM9Oh7CZqc69PnbFlCr9krJgxfL6HkxISDXZaHgh8NS7GkYQ3an7Jl/OyfqgTnQoBOhuq4u+46++vRIq+/rV/fKtHOFyFJwtS9P6GNBT58Odf0fjDqeSVwMXT9BzI8M9T2fwsVvgnC9b3gQRskBX0CiJrTbpiHp21/DXFgkR5ojplr2I1HNfvLJr90uga3n3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786692082; c=relaxed/relaxed;
	bh=8yoJKjaYZwT3kC7Z+BcMIAXUq6iz8NORS15vjre6gIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kugabNAj69//DhCNnEpKQLvS40JvaeDEsXU1AegIpt1uu5TrsOF5W3Bsv9vuEH/u8/SsrIOscWLr7MwIQ8vsf5fOkspzhTanN3eFchYbje8DJELS5Lo19x0wTrcX9KvkWxPQ4w99EBLTLo6oQfGebXmC/Zk9XGPvJQEn10PPGML7cXh3Uc9LZkusztyYoxwGMTnkzprTN2yIrJRs6w6c6rnycj4NBy+HbnoJXsVKyTf3djDrIjBdRanRFnnuxxrnTPdjJxb5Gx1FQR+g1HZWGjD2Jtjde3PegGTpNTGlR+cPBf+DepJxZ5gTCtnavTj+1MMc1x9+AOhk06/FRdRC7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx1lDAS6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx1lDAS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLtv54s16z2y81
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:21:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51BEC60A63;
	Fri, 14 Aug 2026 07:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9CB1F00A3A;
	Fri, 14 Aug 2026 07:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692079;
	bh=8yoJKjaYZwT3kC7Z+BcMIAXUq6iz8NORS15vjre6gIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hx1lDAS615F21oEJLRKd/1lm1N/2JFVEQZaTxSBYxSiIli44zw5NBm4GCXg3f3o5H
	 fqZdNxeTjJ3wGSwDGJzM/zzbUgydnaK0qs+ScQU7j/8jc72hbT6vrH5zFmVaUZd+i2
	 BnZi/izwsueYRVq8cheOLfhaMR9gkwFSPq72CKe4eguJOR/bo7OXoQ3LHycqAuF2xY
	 yl66dizcw2yrWZxlXPoKoMlWxy678+kX38OcITVc2LEOL9wVwwWv9qOFRzh3Pp5rdf
	 P17BkykcZWcWQIx7pLahv+Zxuj7/3u/5byqZmStYZHMdaKJ9BlL4JBN2OXe6hrvE2T
	 eNnjrTgVcxuoA==
Date: Fri, 14 Aug 2026 09:21:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <20260814-lean-classy-hyrax-60aab2@quoll>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
 <20260813070020.719810-2-shengjiu.wang@oss.nxp.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813070020.719810-2-shengjiu.wang@oss.nxp.com>

On Thu, Aug 13, 2026 at 03:00:16PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).

Each one or only the newest? You will be getting the same questions.

> The existing binding exposed only a single generic audio-graph port,
> which cannot represent independent conversion paths when multiple pairs
> are in use simultaneously.

Best regards,
Krzysztof


