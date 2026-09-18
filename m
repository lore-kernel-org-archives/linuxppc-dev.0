Return-Path: <linuxppc-dev+bounces-27691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A8DC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:31:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmS6d3wNBz2y7r;
	Fri, 18 Sep 2026 19:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789723865;
	cv=none; b=YOUvpT/H5ljau1fBHbN3RzgrcZTQBL2RaLsfAo7fOYiojN3J2j5nAv051HpM+xuWSknMHfj+7bbvndRIaYZdT1v87kyZXVwq6qL8dFaT6zA5Ac26yEDTLXnDZ9QO/F09apgQ/u/0YZqwo9Q84y7JkT7q4SlOb12+yAm5Yp9d713r6pvTQ8GMjU3dol1HIO0/FubjcHnIfjERKBMJHSF2N1XRdqt+GFufdqVODoJxgqPGESCTPHyg4veRsLWCs8fxpGBavgbYDWgH/c2vM8ouv8doBnf4FjEI6XTn7JnBipYYNSOB9Az0CtDOd9Sc1E9AUBTZIy7t+usWyr6nCi5lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789723865; c=relaxed/relaxed;
	bh=jUkv5B4pUOLxWKcrJ90ETrNmPqz8J2MnsOKX2jmyHv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxHPFzEaIGen613o1Lgw6VGPFGZcjx0apCX5PxR0nROWJVMOdBlWK3HsAY4nsmbNbKeVjBnMtsAv5evy2Uy/awHyAmgiMezkgcKGsUjpGDMc3dNau0+LGuBF4PrKHdLcPLWNgm2oYQwEQECIScfaZhkXhftJ+utZmBNx2ZMFI9A2jf5WxsmxNnuIHIKDNAlQbmwvNy62d0MeqB0qIgxQTPzHmFnMaDUaLSsaLiU/DV4Xs6JXAXut152ofSprkfKGwaJz8ZqULQDyUXGxuABgDkaQgkQQED6fo6EtdxxjAoOPzHp3P2Gb9G7riIcZ/WOLXm9LXq1XyTlh1EH7ue92Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1uBqEnN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1uBqEnN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmS6c5XKpz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 19:31:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30625405FF;
	Fri, 18 Sep 2026 09:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538861F000FF;
	Fri, 18 Sep 2026 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723862;
	bh=jUkv5B4pUOLxWKcrJ90ETrNmPqz8J2MnsOKX2jmyHv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1uBqEnNDp4mapzjtRXODSu6/BBte8RVWokujt+OS4A12yrHyExHF0j7OXoB0U0LO
	 VCwOZBeCBbPPusOtU+vU+Lk6/uEc6GfXvxkQjTBvIsrYP+IO7yDC5ceHdu7LXCpn5u
	 BpMNelI/Z2NsM/MxxtaiFMsJtx5LBCKOATr1qAorj6Jt6jzowkjovGJCQ/rIVyaAxI
	 fxs4Dn/bWwSPqytRV8RRsmCxGu1bMYFg8/mdPvuVeJnOW/TObFWznWQjMU7RSRZ5Ds
	 u7AP4mTm1GTBzAznQTTvD+Rs4gkjOtJzpXhzX5zH8xsoLxS//lK9aeBIg9ZeCBvZRE
	 IojTcHoJa044A==
Date: Fri, 18 Sep 2026 10:30:56 +0100
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fs_enet: fix platform info memory leak on remove
Message-ID: <20260918093056.GG51261@horms.kernel.org>
References: <20260916031414.2875022-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20260916031414.2875022-1-lgs201920130244@gmail.com>

On Wed, Sep 16, 2026 at 11:14:14AM +0800, Guangshuo Li wrote:
> fs_enet_probe() allocates the platform information structure with
> kzalloc_obj() and stores it in fep->fpi.
> 
> The probe failure paths release this allocation with kfree(). However,
> after a successful probe, fs_enet_remove() tears down the network
> device without freeing fep->fpi, leaving the platform information
> structure allocated after driver removal.
> 
> Free fep->fpi before releasing the network device.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


