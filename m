Return-Path: <linuxppc-dev+bounces-18451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183191090234
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 15:00:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc85054pkz2ypV;
	Fri, 20 Mar 2026 02:00:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773932420;
	cv=none; b=a6HHAsD70lt6UtiYqptZrxaV9z+QWdEN8b6Iq0wqThzmlh9ZRHcf3V2eVSC4ixTpmwHlXNCC8Wxi8gzuUx2W1WF4YGeUXUhNba6Afj15A8D3q7yh+VxJ6LPUsKF/rtAkA/f0MlSSMvmikGItQKPVIMR56tQ2eDqT7ZbJKUqHI413LbGxgtxZJ+xj7DFLhbj84SgaRxiN0rwnLDYoYVCB5BTdDidvv0G2bd6p1q3M8yyly9zc6p7rAoknhCBPC5wgEseZ+2hMdTSFUZDaYlpvo1cuJ84bFwdHIGE2Z8vDAUiAa2/09IifBgZ3wssxBVQKaKxDb8ffLK5I3jt6c4KXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773932420; c=relaxed/relaxed;
	bh=GyGuqsLiHr94UkB4qhqgG/5xZ+KFlONUdCnW/dGUudA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt3hl0iBt6at1CQYr3+N/nyJedRlAdZJaFzCjZjRkgwgPr+VN71Ilc/PlR4aM0njlStM4KrBntQdqBwFHk40m3Spfa3RsvqhKIk15kdY5I5rWqqCx2tJ3hKCDvuvc6jFKmy0KQQpKqCTQq6Mpv751dMWsTHSDYssyBFuucWZUUIMEjyXavU3I9d1pdcgXTaXNloQnNdpeuh4Pd+X51qYU1ybtnR0wcOc1VaXXOaprjlBuLvx6mrS3Astn0edEDsvjNUCm6w31bOdXXF4R2q2skf6VXgM0HhKrpWAhbAladqz2Alsvhdpc7WKmh8JrvrvTgdk0ZVmMys0T2uxT1rTpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RvfmUv0f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RvfmUv0f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc8500S41z2ynv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 02:00:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CFEAC6011F;
	Thu, 19 Mar 2026 15:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55284C19424;
	Thu, 19 Mar 2026 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932417;
	bh=CsP+MUt4iPBk3K+rHr/Zku37K/FzDX5EqoYMT/6dn4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvfmUv0fP1ZP2Re77fPUb/GXQjzo8D7jWEIc38AyaSZdJpxJQHg8kogIFo4y9Qr2F
	 ry2VLD6lNedLrUc15JjWWxxxAB+/LHfy5ZJay3lhJZ3QWnUREpd+5SFtJYK01SW6hQ
	 QkVpClLQdGbXoxFp7NEwtLfQh+xwDYxa79wazz1OAfI4vExg/DhOz9fESUEANouNyS
	 xwnKg7PMBjSkN9ZxuHFg6FgnA8stOY8ah2fUZlLKpPHmW8OkqaYqjWCQzP5nBkSMRv
	 yf+2DjIY8brPjHQMUaryO/pwKjpC5/GfFz8qE67Kqm7afes+i1Rb/SIMjWukmRY3bx
	 afXeZjFrQMFMg==
Date: Thu, 19 Mar 2026 15:00:10 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, wei.fang@nxp.com,
	netdev@vger.kernel.org, xiaoning.wang@nxp.com,
	vladimir.oltean@nxp.com, davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org, krzk+dt@kernel.org, frank.li@nxp.com,
	claudiu.manoil@nxp.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, imx@lists.linux.dev, pabeni@redhat.com,
	f.fainelli@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	conor+dt@kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table
 and implement flow-control
Message-ID: <20260319150010.GG1753385@horms.kernel.org>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
 <20260318145452.1898637-2-horms@kernel.org>
 <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
 <20260318152408.002d1bd6@kernel.org>
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
In-Reply-To: <20260318152408.002d1bd6@kernel.org>

On Wed, Mar 18, 2026 at 03:24:08PM -0700, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 15:56:39 +0100 Krzysztof Kozlowski wrote:
> > On 18/03/2026 15:54, Simon Horman wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > 
> > Why are you removing the "PATCH" part in the email subject?
> > 
> > This completely messes up with the filters and causes this email to pop
> > up in places it should not.
> 
> Sorry about that :/ We pull patch info form patchwork and for some
> reason patchwork uses this notation for the "name" of the patch
> when showing the list of patches in series info.
> 
> I'll hack up the scripts to fetch real thing from lore.

Thanks!

