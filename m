Return-Path: <linuxppc-dev+bounces-7456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD467C36014
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Apr 2025 14:40:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZTh8c6skQz309h;
	Sat,  5 Apr 2025 01:40:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743777600;
	cv=none; b=n4vZIhBB+Xpej/EFYGSj/1EFb5khDQzEDSp5TMx9QK4bSnuusAG3K+IjtOrhEHLvp06e6btsOkYkUP4T4Lt8nkJAxhmk905jN6JwjEr/fJf0GJRJnlosaAp9rpdIqAuY33BhHoF/NA5xJLMtQLDydqVcocYRhjDD53124M/YxbPBNYw+27umg9ET+b19bfIojHfV7wnobeRc3mLoToHP5B8eQ/8t2om0Yq+bcx+CWEkkkw6IUwbx9u2QKntc6ci6MG3GgsjP5RbA7rSBKN1GkTRc4Y79KrnqA48wF2l0srtC7JwtLlNofg+jcm2pqOY3l+ewEtF+KzHFDRnYvABZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743777600; c=relaxed/relaxed;
	bh=rR5JQDug0zmO5fYsz8Veizyib1Bze1lLUJZTBHuICJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j1nh2MjsdTIf0bBYW1JfpcaDBG2FZQoMDcLj3WvOH4OZGLxDtQUIUuCEiSUm+YsrXOYRPMsWUJz0daTQGAv6QijaAQRge515TvB3E3t3Lb3Bv+z9pPbYZk5jfYSxfzUEsSzhnrTZKp7VAVsZ+HXn5Nad889MY6oORqOam54Ydw/YX8mNY6/RvhgcFLfm2K7SSAXJunOgznJDGbVQ4Njx32fBbVlgYb0dvcR8msaaLaHotDV0WPBl045G4LWsCcif/UfvLeIIQDc6eTGlKrAKTQrKL3Sov4M5vOpqY3c0mGDZj1MomMuST8sBOXtLAW5btO1OspzZJmsjRTEWN4mT6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iiiCKR2A; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iiiCKR2A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZTh8b621Sz2yrY
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2025 01:39:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B433440EA;
	Fri,  4 Apr 2025 14:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E645C4CEE8;
	Fri,  4 Apr 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777597;
	bh=UTmg5mV7vCXLiT3zkNeLxITmublMJSUfJwa8s/v4TQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iiiCKR2ASSO3sjosXlaD7+xVw+ItYEc1EoeIZFhVD6qbbeETYMqzFTBvPzdzOmPvy
	 tdigIN4IFRGtBWu5HWAlY+TxLFUWhPqniMWj0dpajywUyZ3NOYBIJ4f0GWpW9mB95f
	 DMqrLBmBmOZP+6uOZZSeGiZRBZ9IT+nr9H/jO5dGLDzHRtbJLQ15ZSgvDk8TZh2SLJ
	 N0J2jjjjbO7ZoBi5k6GJr2HXoD4FA6Fw6fyhL9EOa6U40dWApa/extBSG2CeiyFFZH
	 xDLxL3/B81lFYDhF8TB0iw4culcUSLprkkk/ACAh26/fNfRoLQKYR2aoz0cd0fPl0i
	 VP0p5OeLJLIyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7A73822D28;
	Fri,  4 Apr 2025 14:40:35 +0000 (UTC)
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ibmveth: make veth_pool_store stop hanging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377763424.3283451.909184370963487754.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:40:34 +0000
References: <20250402154403.386744-1-davemarq@linux.ibm.com>
In-Reply-To: <20250402154403.386744-1-davemarq@linux.ibm.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nnac123@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 10:44:03 -0500 you wrote:
> v2:
> - Created a single error handling unlock and exit in veth_pool_store
> - Greatly expanded commit message with previous explanatory-only text
> 
> Summary: Use rtnl_mutex to synchronize veth_pool_store with itself,
> ibmveth_close and ibmveth_open, preventing multiple calls in a row to
> napi_disable.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ibmveth: make veth_pool_store stop hanging
    https://git.kernel.org/netdev/net/c/053f3ff67d7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



