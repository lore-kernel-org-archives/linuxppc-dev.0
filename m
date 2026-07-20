Return-Path: <linuxppc-dev+bounces-24524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCC4C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 16:34:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3mLv1nCQz2ySN;
	Tue, 21 Jul 2026 02:34:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784565271;
	cv=none; b=TU2h7q8RuKvGnYZlIQEcdZ66hp5tn27tqv2SCIJDBofr3MgG+4U0faodVSZbOU0a4+xuEA0/M1JZ/+HG9Xp3kfbCYhRk7rSrUY4gyS9d7nt+Rr0isPlo6Wmut/ah358UZJT3tTbVFqaZiDsGPw3URyre/gVNCTR3Ur0VpJfz7iQHWKCULg5M9VJoPWLELz9nzgi/+WIcNec8pwvbagH0XnxvAY35ahX5irIWpgim45EsUVHAeTMphgU9HieNqudLDPK7lyBon+X4RkcdIc82wiy8BSobysJ62YxKmc6puqjd3SkIeTWIqQhJq0uSJLNItJ5eyWATkaw0XC1rsQ7i9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784565271; c=relaxed/relaxed;
	bh=I5pCJCNSlRvnmOb1Hy/xPjzYh4HxX+Ti5n4ExHAyluw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4kGguAWEXR5iulYDUdUa5h5+OqrOeBqiQEbWxQXVFHRn2PL1qpl60K3iqdZmyFx4XzoUDtanqhsh/u7+YZ1aOvv8dy6lH0hOyjvC/3S2RQ8eqZuTmHLdnClEC5d+1A8L5XKjih45YXDHP2oTlBUOR4lhzwZ8E9mmvG/P0eDngPnIBt7YerLkfgvoAN15VnksY0lVwxSLT7nx9oVsf8Uht+/ql3he2Ma5QTFQ2OeXdUmt8iP7jspZhIBLrNIraxm7HaoV42eJzxaMiWpZno25iXdaKtW9ruf+g7TNUWltU4jNB9pP4fO2iCKcY3UK6k0E8xd+dLPmPLJOWmDS+B/Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lV4Vupgv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lV4Vupgv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3mLt4RYwz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 02:34:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89A2C402F1;
	Mon, 20 Jul 2026 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ED11F000E9;
	Mon, 20 Jul 2026 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565267;
	bh=I5pCJCNSlRvnmOb1Hy/xPjzYh4HxX+Ti5n4ExHAyluw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lV4VupgvJObQ9qrv/YBl2S8GZ12F5T+H4ddshJCJv37k4Aesv5z1vJ8aaf4oU3wyk
	 jaSw3X+8nwIpDv6DheHiYWqccp5GXQRnlQ3cFvyPPPpqotdJvU8kuYoQqGx3tXCAC4
	 s2kHQDyLBGQkKcDf2WXUP6WVEnYhkk/gnJC+MsJIgz3yB1l0sSOTzluhedUknD0FPP
	 pjnzujGT4rms2Mis9cTk4/dYGuNEHbNX5UHfa9QwW4NCndbYQTaXCoznf5NTG8iHzL
	 vrI/evAXi9Nka0LH2lUVTwZ/JXtSTQ2NOITtjE1g473fGRjUUHC2LCIFuz0sG4BU3N
	 JIGNhYPfAinfQ==
Date: Mon, 20 Jul 2026 22:04:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 phy-next 8/8] phy: lynx-10g: use RCW override
 procedure for dynamic protocol change
Message-ID: <al5ODzYhpE-wHSSN@vaman>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
 <20260720133642.136324-9-vladimir.oltean@nxp.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720133642.136324-9-vladimir.oltean@nxp.com>

On 20-07-26, 16:36, Vladimir Oltean wrote:
> Up until this patch, the only protocol change supported was between
> 1000Base-X/SGMII and 2500Base-X. The others require an RCW override
> procedure which was lacking.
> 
> Since now the guts driver provides the means of applying this procedure,
> make use of it and remove any comment which mentioned the limitation.

lgtm, is there any dependency. If not I can pick it

-- 
~Vinod

