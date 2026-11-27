Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781D606A689
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3TTtCYE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbWDF64q4z2yMK;
	Fri, 27 Nov 2026 22:20:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795778413;
	cv=none; b=Br+NEJPkstza6h4LxlkGb4cHP1xAGH2dRrVOjeyt666624OTl9m3LHTbfEB1a2RQdht15/09Fegj0K6ffVhpKFiLghTTjXkPMpBLkrK6NbmXf/vxvAihKG2vJ+392AeMj8UaEh5WhbL86OVY+KAAZojWuk7w7QghF2FQHMcJP6eoBEmDMVeCItiBrJzUk9sPAsvOtmJn1ml4f1P0O4rlmL0p8O1uJaEGhLPc279KpZ2N6PyxpqX2nPdMcBhicDEmLK/VKpKnH2eEuSFIxVCvOxOXcv935y7LIHjnX9NWdgzf9WxZ7x0nHzusVfBM9yk7L6B1zxY13FnvgN2wLeDLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795778413; c=relaxed/relaxed;
	bh=2ETb1QafyRI6/oHfjDrfqCfUkUUni7k0hQ6WfP0vU/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kElJ74dMxmj6yJiOUdBJvvBUWsVkglOw3VJTmIml4lhY6eyFtiGwALAw/IKvbVQ6DUxAjjRiI/e/tWkrNAmP7xP7/qyrgH420RS1piF/vuhO9srQ/6grlC99oN0ajN6ViL8akuCuVPjKlBkXBHO6YKySkr8QQBnwzXr1weEJam2587xYtUlZFyd6pOHvxHYpaJB5ioc4TlNw9BK7PTBrSPb6yCjz/G84K1jFB/RHUy/b6y8r6TB15feIDDzwI3+G+WLOgdCbIkUsKzt8IJ6VxZhao9kJuLJMMCZ1Wb1IaxtoSRyUg8K9B7gepd8xtGLEP+m3MWVcLqDV1uabztBP8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3TTtCYE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3TTtCYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbWDD3P35z2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 22:20:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 345DD61B56;
	Fri, 27 Nov 2026 11:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7A91F000C1;
	Fri, 27 Nov 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795778408;
	bh=2ETb1QafyRI6/oHfjDrfqCfUkUUni7k0hQ6WfP0vU/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X3TTtCYEl/CNkWbszOL2/NTMFsJu73ACHXYum+HEh6WIPYXMg2ynyTzq+I8Cd4qOY
	 EOzIRa8w69HfAYLkkI22528BwZDYPEZvCdnWgzsrYySdtZSMd9BFPNHFdllshGY7Xl
	 0v+M0Ox7zmAQ8C610RyONIuZrWe4GrJgdJowCy+mF0zjfRZekmSS44aEeJ2OARFZ+V
	 fHoygLNWwMA5lI9B0pCf8Q5ocEYgCESOKLWFzT8kIZmq1CeI2Mu18Lp+5kngfoC5XL
	 pWGMUb9NdIhocvWFxtw0sBuV8KG7ogq2vvaAwBafk4pO7FE/HIyKMfWSfOEalQ1MDA
	 yBLOwW8BM+bkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717AB38003E0;
	Fri, 27 Nov 2026 11:20:08 +0000 (UTC)
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
Subject: Re: [PATCH v8 net-next 0/9] net: dsa: netc: add PTP support for NETC
 switch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179577840725.924205.8910316217595010398.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 11:20:07 +0000
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Nov 2026 11:05:25 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This patch set adds PTP timestamping support to the NETC switch, so that
> the switch ports can be used for IEEE 1588 PTP synchronization.
> 
> The NETC switch has no time registers of its own and instead shares the
> PTP time of the NETC Timer, which is a separate PCIe function driven by
> its own driver. The first 3 patches prepare the Timer driver for this
> role: tidy up its 64-bit register access, drop an ineffective reset, and
> export netc_timer_get_current_time() so the switch driver can read the
> current PTP time across the driver boundary in a race-free way.
> 
> [...]

Here is the summary with links:
  - [v8,net-next,1/9] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
    https://git.kernel.org/netdev/net-next/c/1f1bfb52b44b
  - [v8,net-next,2/9] ptp: netc: remove unnecessary pcie_flr() call in probe
    https://git.kernel.org/netdev/net-next/c/0dd839917efe
  - [v8,net-next,3/9] ptp: netc: export netc_timer_get_current_time() for cross-driver use
    https://git.kernel.org/netdev/net-next/c/9b844ef56d60
  - [v8,net-next,4/9] net: dsa: netc: tie setup resources and reset to DSA setup/teardown
    https://git.kernel.org/netdev/net-next/c/f320f1e55e65
  - [v8,net-next,5/9] net: dsa: netc: use entry ID instead of pointer to track host flood rule
    https://git.kernel.org/netdev/net-next/c/bc6680acf83a
  - [v8,net-next,6/9] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
    https://git.kernel.org/netdev/net-next/c/585b422eaa71
  - [v8,net-next,7/9] net: dsa: netc: enable ingress port filtering lookup by default
    https://git.kernel.org/netdev/net-next/c/26b51309ef3d
  - [v8,net-next,8/9] net: dsa: netc: add PTP two-step timestamping support
    https://git.kernel.org/netdev/net-next/c/d2c3f304034e
  - [v8,net-next,9/9] net: dsa: netc: add PTP one-step timestamping support
    https://git.kernel.org/netdev/net-next/c/8b5aba6d328e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



