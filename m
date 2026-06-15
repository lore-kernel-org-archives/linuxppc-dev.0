Return-Path: <linuxppc-dev+bounces-22663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A7ACD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 21:50:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfP1b3y3tz3bsy;
	Tue, 16 Jun 2026 07:50:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781560227;
	cv=none; b=eGymbvAeR/5EaNQByx5ht/e2n334tF/Yq2ziUx2WZy/PApso4ar1xigOFrDOv7xm/WsLj2lHjEZv7cExd4V+BWyUAtYhVHRpF+jFPgPmCHLCF0UBTa5Qx9vJqsRwuHP027UGMOqlvVlXQ8hztfVjpn0dgVelahn+AcTtRDJylM0AY205DpwkVRQaA8OB7UiIOTrGzNyi8ci1Nw5mtxZ9yH+ceXsks8G+kKqcDzreZrnWFU9PqTPpmGMWuAZ3Boi4ed6JahgicMoJkPKs+Z6IjRDcgxMc+WtXWUODKR7QooTvjVB6yS5UGqzHp1rxV+nsS0VkIIczg0HjMS1rO27t3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781560227; c=relaxed/relaxed;
	bh=B/XcSAGeoGp/BP+1XhwRml/MI2qj10vi9ZYd7jCnORI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ouhZ9oH/BAggCDiGtM6t3IdappQDzDyWUsBj/kBoje1XCfh81fA64fdQr2fFYZ8g0BRPczuvfI1jUYR7tr7UJwSKRbQkH6trutQ0VJlMz36Q8YQ9rb47FPlQo+v4g0jDAWwoZSrq4KtPUl73lhYtSOtZZacYzUAKUdGs+U1McTFqrwhfp1h3PVXsPcnOLkXQMEG0J2zGmTk0DW4SA91T/Fn51omMMDf7Z5vzGxGMeW/3RAfLwf3p1lVfk4jvClxeIO6miWyDU0uJmVhDuHV6njgwf6YdqlApGiy/d3l+IJ5E3AzUAcWNk7m0hUyztWYo2D7zeLo2obPZEHf8bIFmGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPlgPyPn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPlgPyPn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfP1Z1NJqz3bsq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 07:50:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 363E5401BF;
	Mon, 15 Jun 2026 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170051F000E9;
	Mon, 15 Jun 2026 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560223;
	bh=B/XcSAGeoGp/BP+1XhwRml/MI2qj10vi9ZYd7jCnORI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FPlgPyPnuMeIfmdNU0MP3k6aXAwqDVGYRcBE+vdzcnANEahuHxJHj2EkNlS3P1irG
	 bA8kdm03jzL0CAYujQzr05f7I7SgYDmlEH7AdJf7+j1+P17KJGHbFrrKRJX2ci7urj
	 YvTxUdTk3Mz5yKlyDsq1tygwgKni+g9/IcHtySqn/EY1SQq7ephrBf5+WEu+BsbXC2
	 /61fn0E1dvpYIf1ilHh1HAK/H1u/RBp7e5FfRPATCcPXShx/cKIPK8b6Eu4qZg5sO3
	 uTraskHJ8ayVvuPud8Rfc890OZKeOsgL+Ky+qeM7fuLqQBpT7XTRGm/JxsmD1QPJNq
	 kM5RnuPl7b74g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568803839A06;
	Mon, 15 Jun 2026 21:50:19 +0000 (UTC)
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
Subject: Re: [PATCH v5 net-next 0/9] net: dsa: netc: add bridge mode support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156021814.308382.3109768586287971042.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:50:18 +0000
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, linux@armlinux.org.uk, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 10:14:49 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This series adds bridge mode support to the NETC DSA switch driver,
> covering both VLAN-aware and VLAN-unaware operation.
> 
> The NETC switch manages forwarding through a set of hardware tables
> accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
> treatment table (ETT), and egress count table (ECT). The series extends
> the NTMP layer with the operations required for bridging, then builds the
> DSA bridge callbacks on top.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/9] net: enetc: add interfaces to manage dynamic FDB entries
    https://git.kernel.org/netdev/net-next/c/ca394837dfdd
  - [v5,net-next,2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
    https://git.kernel.org/netdev/net-next/c/c52b6702a948
  - [v5,net-next,3/9] net: enetc: add interfaces to manage egress treatment table
    https://git.kernel.org/netdev/net-next/c/3cc291a35939
  - [v5,net-next,4/9] net: enetc: add "Update" operation to the egress count table
    https://git.kernel.org/netdev/net-next/c/d51f238a154a
  - [v5,net-next,5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
    https://git.kernel.org/netdev/net-next/c/1a58ae73dd74
  - [v5,net-next,6/9] net: enetc: add helpers to set/clear table bitmap
    https://git.kernel.org/netdev/net-next/c/8469b17310d1
  - [v5,net-next,7/9] net: dsa: netc: add VLAN filter table and egress treatment management
    https://git.kernel.org/netdev/net-next/c/84b4a3b30abd
  - [v5,net-next,8/9] net: dsa: netc: add bridge mode support
    https://git.kernel.org/netdev/net-next/c/751aa5a5d593
  - [v5,net-next,9/9] net: dsa: netc: implement dynamic FDB entry ageing
    https://git.kernel.org/netdev/net-next/c/05b5ee610fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



