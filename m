Return-Path: <linuxppc-dev+bounces-6360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840BCC021AA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2025 23:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YysdT0RSbz2xrv;
	Thu, 20 Feb 2025 10:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740006813;
	cv=none; b=GgydDnNB83mZJYPfkb5ZqwMDJZ2HYZz6Rc4b2lR+SquOzwhhbpT0wTWBaSCOWPxGcgTvEXeobmTkodsTbzeqgZ/27yWBDoeeKftLZNALbo2FCOLuX2qpsUOOLg/r54RBWI2NRxc8A3Zsgxtaw1f8jhZnRFXVG2gTftOH7m+TP85UcOK3KSx6ZVt4GdwKVzlPx0nuaF3No0wfoddGOb3vnchJVhXLgcUeJWpu8JAaxKdlKRyVdpw2UeDHzQZhaLmC+th7byQlHqOT4DAOSGBEQlJlmrju8dlH/gTcNG5Py8Ivb/MqqEW3vypuOzWiPzK9T1CSyGw9EsRLm9fhM1dyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740006813; c=relaxed/relaxed;
	bh=VUHNUTl21u97chEzY34N2q7kVnPmyYXeAitv/c3TEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxgYaaOvSiKcpUoQWi+iH0BKTLjce/9mLNCIXqpjQ+RovfOqmokmYL3H/uZ0lqDjmi/xqGy25u5sILkmcG1JjovLasdNmH3WNDkDnFVbxXUrUKb0MAXOLp/V/J5GKHp8vQW8RR7fMPbb1gppsRErOl2kJi9UOPlreb+LQriN09lPzK9RQ/+y+H5H4v4njrMlEzcgxW+TLtoOT/6T6KbDqWC0CFoKBZTnQXhrWJsBeVC3W8dY/OviZ9YQ4OiE/uAoVvtqHFD2HenoiPEGb1zzngKHN9URzbl5o48fXnzq4B9Km7ECoL/Z0UhLYh0tA6X8n+7djWysLyx8/a9EjQanzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XzKjMpVZ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XzKjMpVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YysdS14SMz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2025 10:13:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FCC55C57DA;
	Wed, 19 Feb 2025 23:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDA2C4CED1;
	Wed, 19 Feb 2025 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006809;
	bh=1hogxnuECIzSV/Tm1A6DPdaKyUbceozlacoXk8KBzwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzKjMpVZTHiOg2EJoOlVL4olptH5P+B4qffLfXz7wGY66guDlrYX+4e5KUQkW9sKY
	 6R2AFlEJugpdEnFSQ/H2mlGKdXx+tdG3k60h6YqhneYWj1cIjubwOvc8uf0lWHFl24
	 GgA+JrgVRpMpG56fLXy48jK7Wbe8yPsBC/s9M8RoqDFRCgNcV26n7c4r9PLszkqtr3
	 F58GOyDBrW/fBfUUInEQz3HpjhKovHygjHOpeEinKTG+VCqsXO3B0oT61JLltE1rMQ
	 BxWYAOUo22Dhf1nKmmHbXpWSW9L7WEbKobvm/IhASjJ5FS/bntuL24BQh7wgdjowg6
	 A+oCUMMd+oG3Q==
Date: Wed, 19 Feb 2025 17:13:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, festevam@gmail.com, krzk+dt@kernel.org,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org,
	tiwai@suse.com, nicoleotsuka@gmail.com, conor+dt@kernel.org,
	perex@perex.cz, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, Xiubo.Lee@gmail.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: imx-card: Add playback-only
 and capture-only property
Message-ID: <174000680771.3151442.2014916167117128565.robh@kernel.org>
References: <20250217021715.284951-1-shengjiu.wang@nxp.com>
 <20250217021715.284951-2-shengjiu.wang@nxp.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217021715.284951-2-shengjiu.wang@nxp.com>


On Mon, 17 Feb 2025 10:17:14 +0800, Shengjiu Wang wrote:
> Refer to audio graph card, add playback-only and capture-only property
> for imx-audio-card.yaml for the case that only playback or capture is
> supported.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-card.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


