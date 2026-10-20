Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7A606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlVIDa9w
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8Mv63MbRz2xjv;
	Wed, 21 Oct 2026 06:30:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792524610;
	cv=none; b=kL0Z8OcFJM+t/T7MVqCWZ5s7B47TyGilJdJHPcM1CniGUdcSfim6Y3szLt5I04WurIBtox/LvVP05CZBm0/IS1QdZlavftNurUBQqO3OgGILBtjIXAtuKa4dunCS1bkTM56dBGtXk07uUmG4dCXmsCp8wuGBZoesk9cMorpndNA45O/yPoiqlrXu7UefQxalpkpYpJNzDh2Z07teL0idA0JUTuwS9ojVUT78QZ80762HnLnqTsiCwn9Qk9xWDZlqFF/Ue5WR8fIqceiO7VUI6Wh8kjkkpQA30awOChyc2CREM+l8c9Lvopz2WaQskxOa6abXLTbif967bdL1t3rcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792524610; c=relaxed/relaxed;
	bh=wYg9cotcoU0u6A8/hr+EYwsFGArgBF9NN7BKO2SM0po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PDynyBZHtnj8BuxapKGpNZkSzv1oRSDuwBm/sZaZYKWGcvE/C2U3Tb/ZjS4746yJZMxpdrRLN2cM2rndDcImNDv3UlII44d+tvaz/oaxlc5epEfwTXYWznOHyS3btLaG25KS2kg6abYiPBxTYoofWkXeHrDJEcFIBAEu3aTpT9zua0MMacqj3IyfbVtSSMPTS4R/rOCJ+J5LcgyKhTP3zUCHDgKz1ZqnwAiegTMxklrvS4vJNQirNLXFtkSa71MiSl+1YUjX0XEO7RyhAb34Cf3TahdZj0WRkUFfbRe+D/XAfFpchxc1tvCR6vgV2FkUiuzLToRY+y4eBpdSiqT+dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlVIDa9w; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlVIDa9w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8Mv55vcyz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 06:30:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28F9D409F1;
	Tue, 20 Oct 2026 19:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073011F000C9;
	Tue, 20 Oct 2026 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524607;
	bh=wYg9cotcoU0u6A8/hr+EYwsFGArgBF9NN7BKO2SM0po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nlVIDa9wW+uOYT5mUetEGavF0EsvitauQHKUabhlYAb6qwusxhS8KE5M1t5uxENXZ
	 6CtgWcWfha3GUBpEsM5MODslh+VxjuuYO5OwwhBnAz8xsZndVB4qnjD+onfF9t4m/k
	 Yuimsl9hw0WqOKBJsS2ie90qujWCs01rLX5yzk9Lj6F16URCtkbxbYxjToW1UtGT3P
	 3O53QD56IORCzQ+sP9lkzV5PPJWDjXUdi5Y1BlGr9HRHywvbWiF02M2IfiSvK0TfwQ
	 At1B9Y0mL6BT5IHaQ1URvaCwEScR6NmgErOmNrQAYG+3KJVCB/SImnL75QnRAqOIA1
	 c0JlfOitYGesg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15B33808209;
	Tue, 20 Oct 2026 19:30:06 +0000 (UTC)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC
 in netdev_from_priv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252460578.172302.12338872662372096525.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:30:05 +0000
References: <20261015165959.i.798-kees@kernel.org>
In-Reply-To: <20261015165959.i.798-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 gustavoars@kernel.org, qingfang.deng@linux.dev, jiri@resnulli.us,
 spender@grsecurity.net, pageexec@gmail.com, morbo@google.com,
 justinstitt@google.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 yeswanth@linux.ibm.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 10:00:03 -0700 you wrote:
> GCC 15.1 and later can compute an object size of 0 for a pointer that
> container_of() derives from a pointer into a __counted_by flexible array
> member[1]; Clang gets it right. netdev_from_priv() does this with struct
> net_device's "priv" array, so when GCC can see that its argument came
> from netdev_priv(), FORTIFY_SOURCE sees a zero-sized net_device. Since
> commit 9027497a25e3c ("team: use netdev_from_priv()"), adding a port of
> another type to a team device can then fail the memcpy() to
> "dev->broadcast" in team_setup_by_port(), which GCC sees through after
> inlining team_port_add() into team_add_slave():
> 
> [...]

Here is the summary with links:
  - [net-next,net] netdev: Hide the netdev_priv() origin from GCC in netdev_from_priv()
    https://git.kernel.org/netdev/net-next/c/56f8d919739b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



