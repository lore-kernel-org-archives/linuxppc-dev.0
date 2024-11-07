Return-Path: <linuxppc-dev+bounces-3003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0586D5D67D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2024 17:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkqLm1nNkz30f4;
	Fri,  8 Nov 2024 04:48:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731001728;
	cv=none; b=QwIaSJ4e/c317noaK2vYnnhswCDhBp/REiiMu4b+H1Rbb9Q/ZRpz9yrUuugpdIseQuDxe84sdRi2dicuW6husyYOb5F/kOaS4jRJsRPdWgy7orGklcFKXl0zUPu2KcL76vBqr2xwcdVgbCrdW/+PaVvPEibn2bwZLtDfigjtIoSPqqjYHLM3SWzJk6yqKMIoUrCUO5E9+JIdc41zm7PP67doEd/ZxaaXT4nVX5SeWiNJiOCVDwTR5THYeBAx78nefPr96gHc8nEQ42b3+vDcBEkMCJ2UxSzYUddhOMn0CKMwfWYN808w9QhQ5ijCpsGIzvvfiuqT3QQ4eDQ5vbwGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731001728; c=relaxed/relaxed;
	bh=Pkgq+RY7AQPvFR+4KdxNeNkDDn55db16uRcxckizCKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq0Cft28Ll2dRFhXk3NlHVYb3UKOBeoB2Y7K9aKUo0WhsTECiFbqEFw+Lu2XMwOP27zrsAdLjXBl6jw5RH3DT2Ojn/HSumt1O2+Ur8HYYXWNiTlpgOagjWSavbu+5vQ2fbl9C6n8VEePeoqoonZVBjSKu832Ua0TrnQX1cPLbg7xowObttW3G+i76sEv06FslgM+zMpKOaR2NOFody+hcWTcOiHONr3KC82m5brqr18tnUyq1thNQUBJ7hHOHDirBLlVGRftOw80Pc+PDO3+l79M+JycFTgOhahwUZXyI27G786AV0HYhTEAuBNcMy3luFJ50EOp3QTaFKel8I7bUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fcuL6baI; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fcuL6baI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkqLk2Pngz2ywR
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2024 04:48:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pkgq+RY7AQPvFR+4KdxNeNkDDn55db16uRcxckizCKs=; b=fcuL6baIaAxRq26mnxgBtCe6ga
	YpGmAWy6fOBBWxtoCARbREs+MQnMmsPmOaxRn4F0W176w3I6JONIcWfZYIVL8ZV+D/CZgQsL61QaZ
	fW+EEd42GoN/Inf9s7zdd0vQwlg4rC6Id2GR91KWmBjdwO9bYg8DMSoWMa0Ibr0QJaM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96OP-00CUOy-KK; Thu, 07 Nov 2024 18:34:01 +0100
Date: Thu, 7 Nov 2024 18:34:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 1/7] net: freescale: ucc_geth: Drop support for
 the "interface" DT property
Message-ID: <d3b999f1-5e6b-444e-a579-b0af4a39caa6@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-2-maxime.chevallier@bootlin.com>
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
In-Reply-To: <20241107170255.1058124-2-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:48PM +0100, Maxime Chevallier wrote:
> In april 2007, ucc_geth was converted to phylib with :
> 
> commit 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib").
> 
> In that commit, the device-tree property "interface", that could be used to
> retrieve the PHY interface mode was deprecated.
> 
> DTS files that still used that property were converted along the way, in
> the following commit, also dating from april 2007 :
> 
> commit 0fd8c47cccb1 ("[POWERPC] Replace undocumented interface properties in dts files")
> 
> 17 years later, there's no users of that property left and I hope it's
> safe to say we can remove support from that in the ucc_geth driver,
> making the probe() function a bit simpler.

17 years seems reasonable.

> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

