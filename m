Return-Path: <linuxppc-dev+bounces-22729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE23ACD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:00:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg1BZ0ftvz2xjd;
	Wed, 17 Jun 2026 08:00:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781647222;
	cv=none; b=X/UW+ousaMmvNNwJgK2Z5yRAPsWWhnfnSb4V30Au863COkKv75FDfNm2RO2OYGUb4Ut6uHKnjee6VQjeqPkMlSU9u423XlbdordbP2+yP46u89PfjrGEacIBBdbmva7o0HD+QO/lvv/D28WSeEwKCvfAE1YUAwrSLgG0Q6bha+K+h5AQSjqfnzhnzcDhyOnCZ5k41HIzfnWzkRxHjQnH1Jrma/tBGLvZnAjWKkA6/p07UxHauVu10SeH7j+rTJkkqKFn50uepUQhdCIOsN1ZH9AtMZcvCqRBZJejMRywLVPiPwrE1Y/P3+BU91uthPVIP/tjP0MQeJvnfmWAz1muBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781647222; c=relaxed/relaxed;
	bh=ga1OeZSzR83I+bdZkALtFqlm11Tz5ZprDN2LnllVuuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dfye5HP8GVb8i5owhWLx8rymH8nNdXZA90NSa4hA4VDswsmSQGqTxrAnCwRSlRs5BjZ/D2gfqnR3WzyFV7tsMKgTH67/ijbDX6cEOVmo9s0aJj/q/F/F0ZapntuxdzaOzC/gUNIyKyZXk/6k3ZZxlS+vtUhmSQ47jf4Zdt8hkVl8fj8dt2hZKx7hlcs0l0yGow+te7oACVMMEyDaPOwrsr93tRGgfQubd+rG/eDb76VisP4v5WTZxbXC1tvBR1I5eithv+ECzMNHRFgvqywdnl/H9pc/s2OUvjFZbS9X4HfGH3pxuCIlMHvUJ2pLCVBnhHRx1l0KZL5iMah1eCoKnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1H0XPZ/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1H0XPZ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg1BY0Grtz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 08:00:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 38D61600AA;
	Tue, 16 Jun 2026 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11601F000E9;
	Tue, 16 Jun 2026 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647217;
	bh=ga1OeZSzR83I+bdZkALtFqlm11Tz5ZprDN2LnllVuuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m1H0XPZ/YZbBgyH3tnrJ6j1r2M6+6elhCGuK0pN6k5a+sJSKsxxgIBnYMzgNBg+aw
	 8al1mUPkhgyi2bTVabXIYMFi/z5l4yV3wd6csAqc8I2mwclV8BxOmBPlGOcMtIo/ZG
	 wEg/r+6LoZPDh2ODMtYPbSPzrG48yfugOVhBI97AdZ7c8txuTlA276H8jaEnUntKSY
	 KgWy5tWRv1vQI8NErJqgroIv1pfhFiKdw2BZck/RCdw7Phs4t5+P6SaatWwO4rYFIQ
	 HTGCnonB9DyI7WfMUOqJG00HcUeqNVm1R+0aEbhZQHFrTqOfaICHHS4LarNk2bCyyi
	 Nrq80K5Jm6ssA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A13930C2B;
	Tue, 16 Jun 2026 22:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164721213.1257010.7015290603652926955.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:00:12 +0000
References: <20260615222935.947233-1-kuba@kernel.org>
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 15:29:33 -0700 you wrote:
> This tiny series moves appletalk out of tree, to:
> 
>   https://github.com/linux-netdev/mod-orphan
> 
> Core maintainainers are unable to keep up with the rate of security
> bug reports and fixes. Nobody seems to care about appletalk enough
> to review the patches.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] appletalk: stop storing per-interface state in struct net_device
    https://git.kernel.org/netdev/net-next/c/023f9b0f2f4f
  - [net-next,2/2] appletalk: move the protocol out of tree
    https://git.kernel.org/netdev/net-next/c/8a398a0c189e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



