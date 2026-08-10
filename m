Return-Path: <linuxppc-dev+bounces-25657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2297CC5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 07:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJQtg3f9yz305D;
	Mon, 10 Aug 2026 17:12:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786345947;
	cv=none; b=V4lGdIHsUJ9I7mgW5xgVUxqpEb1cyPo3cM/8qiKgo84wTzasB5ivARSZY2hTTjw0lEY8knk8P9SmuP53lYumr6M0xxcmKb2MR6pNR1Kcj3HxR4E1laYbwla7G2+OUAYpXphJiIWba+K2JKkGe1nBh0lSIsQ/wqNDejDyi6zduuTzcoaOaVDAAoa/LtnG9wJgM1Pp3Qccs5tqu7qh+FYFfWEcaDFwMzNvOcKPPC+RU7+/uzK4wsHSH+00zbwgOBPdjZAeHPo4uHY66RwXbgV6iA4R7MGsZ10wOL2sMPpDDoG6OtnZhFGeE12wSg+EtNl5AKmEQa5/hWwWAaIgRlsfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786345947; c=relaxed/relaxed;
	bh=COaUeTCLiC6/x/enOdcDm7m3J3BQbpu2C+HiphZ+rII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeyGDliMMI8iAUfusTpmg6t1YRUO8Jjt+fTWaYoGP65FTUy5+/MQFGcJmi2zLzbC7jOAqebiVzFvhtb5PBt76lObptVZo9g9V70v8G7jrgI5RgoT1m7ZNtqiLX4r7FQSNAeCt62OMUH6xR6yqrL0jTufCmkYQ2Oc7SBp3ERiAYQVR64Cn0+uCkLh7+uRx+ZhsHHCmevv3Xg0z/oTaHM0Yfusj7vixd1w/8BFQJF4vaMpBdDpvfhix6baqxJ+xJeRTAVVXieqJ2n2jRq9CYZbq5VStOlymZyENJ5kJHjaBYdzQ/g1CHAv3mbMrqIKXDNLvmBy8hlB5n0LEGdEQ8blkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUqmyhbf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUqmyhbf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJQtf4TgBz300M
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 17:12:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A902360120;
	Mon, 10 Aug 2026 07:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81821F000E9;
	Mon, 10 Aug 2026 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786345943;
	bh=COaUeTCLiC6/x/enOdcDm7m3J3BQbpu2C+HiphZ+rII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUqmyhbfMBOS1FXtoKdFP+hMikiAiRZebva27LL+5ide3tHHtTYOaz/xuo9YdJPr+
	 yJkLroRSTobte/93yBnmsugwgHF3OzGCZVAIAEIfub5qJJGzwe8OH+z01ym8JW6wiQ
	 5jx4ZgLMdIPEHKQXm/AxjrsWvQLubsjqFiE16VyODK4VrMdmfOXOuhTnicHhOXVqi/
	 nIUM6ZObJhU+KTiw5D8pQHsELpQL9+4zAaaw+4JGPGpdm6Bdtdpa6178a/tLpXwOWn
	 mfdUPkDdALWesk3UNN8aZToizZEO0/3lAqu7aKZ8HNhrFyhHHnbxk4eT2yWpYuj6he
	 GrwUXWKMoEHPA==
Date: Mon, 10 Aug 2026 09:12:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <20260810-magic-olive-gecko-5e8a36@quoll>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <anH5i7y3JkB1moee@SMW015318>
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
In-Reply-To: <anH5i7y3JkB1moee@SMW015318>

On Tue, Aug 04, 2026 at 09:39:07AM -0500, Frank Li wrote:
> On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > The existing binding exposed only a single generic audio-graph port,
> > which cannot represent independent conversion paths when multiple pairs
> > are in use simultaneously.
> >
> > Add a ports container that enumerates up to three sub-ports, each
> > representing an independent conversion path:
> >   port@0 -- conversion path 0
> >   port@1 -- conversion path 1
> >   port@2 -- conversion path 2
> >
> > Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> > are allocated dynamically at stream open time; each active stream
> > direction (playback or capture) on a port consumes one hardware pair.
> >
> > For backwards compatibility, keep the old single port property but mark
> > it deprecated. A schema constraint (not: required: [port, ports]) ensures
> > that both forms cannot be used at the same time. The binding example is
> > updated to show the preferred ports form.
> >
> > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > documented single 'port' node, so this change does not break any
> > in-tree device tree.
> 
> if no existing upstream DTS file use it, you can direct replace with ports

And what about all other users of this binding?

Best regards,
Krzysztof


