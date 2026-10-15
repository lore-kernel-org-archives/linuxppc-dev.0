Return-Path: <linuxppc-dev+bounces-29571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC37C2D0A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:58:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5G5g1NbPz2xHG;
	Fri, 16 Oct 2026 04:58:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792087111;
	cv=none; b=ILSRFEKhbpeF2xFh9Tya/ABYvFeqUVgC7UEXMbmdA2OT0uqv8XbJg7+YJlc2XiL46691/szU16f1Mfa3Ur6Hdg/9dDHkyWdE6hVhlKIKFDmLunNA8SuKe6uG5vOsFw5+Dn+HMtMa6ELFqFL79vOCFAtOpKSkZN7hqpK4vEGimxe0dHZJq6j9SkE/I391XH3rvj87/kgFYs5jOyA5uGTY4eVHYqPEZgsi9Fv8J5N9Mkj55/CQ8M7RtEkFTTff90ngfmvTv0hDeRn8qwGJetArD5vrF/Yc4hwcWfg9Os8wsauwB6p9pVdiA6rWucqm5c/j9emr7bZ6ivUHvS1yHflDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792087111; c=relaxed/relaxed;
	bh=sw5Vs35NHiaOZ7dr1okYjwaIOYOwhFc/brSVUiHaWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE6c6/be5hZ5ritrWa7bkD9X3lgtJrwRgG5qMM+56mHTKDloYjJx8ccN/bBzItxMrVDLSB+CbH8elXk1iTdbuxgofawW5QCXfLtXFFoCYud6LdXXSazv0KTxmgFWAsg8cpfXrh9htTBMH5SIq2xwzA1H1z4+brrmnVYOd1+gcIYND7+fz4J5eE631tEv/YQcPH6aE2J1wEOxbgAcWekosATz4W0Yz6odjjRxsGCyUJ1Fhm2VIC9d4P93xOcsU3UYuszndGqbPvGzpMySYZat7sA0WfWCOirdtHz+YhYkKlQaE267k5DUK4ZWJ+t1jbax1IPqGU3k4MI04e2vfFGTzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+BYtSrj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+BYtSrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5G5f2PvWz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 04:58:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6356260200;
	Thu, 15 Oct 2026 17:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178CF1F000C4;
	Thu, 15 Oct 2026 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792087107;
	bh=sw5Vs35NHiaOZ7dr1okYjwaIOYOwhFc/brSVUiHaWv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M+BYtSrjlClM7TXreyMdxE+xstViocEmiak/TbwCFFCvktQOhci+9Gywo+ijccSnB
	 6OTF3Ps/9DioxA0L6HeYBSDO3NntO2HyAR8DbFoZXbeSrNyLlRAQ2HilkaTB++WF7K
	 6aM329sP3dqdyj/vqZDuQzoImAfaMSBK+/UA6zckbvIhaZNzsOnyb7vllQ/qmjkROU
	 X6atAnnSx4s2bmmuiSrPDQCFJbDf5KbCkfmevi621I/rS2zRJvpl4GTjYWOKmYqkcB
	 hhpZY22kfVWKgNe2YMuveV7/ZQzxrqWU7jG35aaRuasr90tcohMG0KrcTN2DTwKIHz
	 E7h1P+/zBl5qA==
Date: Thu, 15 Oct 2026 10:58:26 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Brad Spengler <spender@grsecurity.net>,
	PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <202610151056.DB82177C@keescook>
References: <20261015165959.i.798-kees@kernel.org>
 <202610151006.E2F587A60@keescook>
 <20261015103410.15ae1b8e@kernel.org>
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
In-Reply-To: <20261015103410.15ae1b8e@kernel.org>

On Thu, Oct 15, 2026 at 10:34:10AM -0700, Jakub Kicinski wrote:
> On Thu, 15 Oct 2026 10:07:06 -0700 Kees Cook wrote:
> > geh, for the subject "net" and "net-next" glitch: I've poked my 
> > subject-building tooling again, this should be for "net", not
> > "net-next"... 
> 
> :) Ack. Just missed today's PR but looks like this is 2 releases 
> old so not _extremely_ urgent. If you think it is we can also ask
> Linus to take it direct

This is only hitting one place (currently), but as it went unnoticed for
a while (GCC has been bugged for a few releases, it seems), I think the
urgency isn't high.

-- 
Kees Cook

