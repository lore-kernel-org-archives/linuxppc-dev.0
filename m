Return-Path: <linuxppc-dev+bounces-21317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8857DCD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 11:10:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLm0X5dwMz2xSN;
	Thu, 21 May 2026 21:10:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779361820;
	cv=none; b=AgbMY0VpFftXbpJf+VWFxkqSILUc5lxoGJHplW0MNilcoAezuFekLdKvqBInKrBc+cbLUvmgvSMe0rT3U4+fJ7iB7IHEv478752zL8F/3Cko6Nf/eCpwLvor03n2sQUF4RMKuaq0TuCK007Uw+RB8D3pDx0EBHVazyMvN4442YeQRis+5/SeVaydmPcHXfO9nIE6B1Cc8kOdxwbRMJ4CtyK/WvBR4qwQjW/Sopcp6TNlkUmisGgKI7O8zEQkYKFhwkj1NiuNIOeRVRGqsMAUoaqkwjqjSCUvvBlccEwOf8bQvHlMvleKCRGpkjwFJNtkrVP8jbQEYpu4gW0oE4GhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779361820; c=relaxed/relaxed;
	bh=xU8Xda3hTS+TH6/kqkYtkfd/gVphmpM5ys0iuESx0eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eBCEaoZ9KR3isTOOv9R7EI+cYqt2oEP6+Ki1Kgke2uq858uOWvAis6bHSSFcShxEM8VJWMnAl6k/jpEMP7sRodTPmYTq5s7fvVHhe6IwUQDX6nadjwfwrw50tQzZXFDx6OI8tK+ADJPKWLBnENEBrAKYjixqkrhPSEuQmnSnpnPdMPN5TzJWI0s42Ngo170U+iDmfesU/OF+kz76UoiVGKanl3bvuPzPBRpSOZvvOYtm5lVAD1GlkUz3IrtKY4VMgsNgkgGbd3qqMzxbOKHibyV8ea7LAU88uLeCOzmYMiK/aZN1P5qWHQdmjrcDR1BVN7tqnEUDy+xC/yI9wNuXHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeUc+TU8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeUc+TU8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLm0W686Pz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 21:10:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3817160212;
	Thu, 21 May 2026 11:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDA1F000E9;
	Thu, 21 May 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779361816;
	bh=xU8Xda3hTS+TH6/kqkYtkfd/gVphmpM5ys0iuESx0eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IeUc+TU8KfmOdLpDtUOEaJcHiCUK87i4XfCq0IgsjEVMuvTatrPzUduaPqXtzGTYF
	 +yb2Nag0bIqi7PsRqx4bPgfzLke4z29ohFAEWnQi2AlyhcGncxJiaA/IZe1EF94T+T
	 oZ4md4kwYc30zpyZJ5jGP4dnqcp/6BHFKBMb9RcBvqDZEJmDllHDy/gxpYJXz7chU2
	 H6Js8SX//oWDtT2rKN8o6VL3jM9QSCDhaIsmZPtYkVxlTh1LHC9gr8lUyeE/uxe2q7
	 OtuOhiDBT00ei8HkIJiz+38j+qvwE/foOTPD0SKFwPfzUiODrmT+LN85NCZsf/j8cK
	 Ylfd5f8lf9sEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994C3930D65;
	Thu, 21 May 2026 11:10:28 +0000 (UTC)
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
Subject: Re: [PATCH v8 net-next 00/15] Add preliminary NETC switch support for
 i.MX94
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177936182689.4032976.7498848495414588133.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 11:10:26 +0000
References: <20260518082506.1318236-1-wei.fang@nxp.com>
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, f.fainelli@gmail.com, frank.li@nxp.com,
 chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 May 2026 16:24:51 +0800 you wrote:
> i.MX94 NETC (v4.3) integrates 802.1Q Ethernet switch functionality, the
> switch provides advanced QoS with 8 traffic classes and a full range of
> TSN standards capabilities. It has 3 user ports and 1 CPU port, and the
> CPU port is connected to an internal ENETC through the pseduo link, so
> instead of a back-to-back MAC, the lightweight "pseudo MAC" is used at
> both ends of the pseudo link to transfer Ethernet frames. The pseudo
> link provides a zero-copy interface (no serialization delay) and lower
> power (less logic and memory).
> 
> [...]

Here is the summary with links:
  - [v8,net-next,01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
    https://git.kernel.org/netdev/net-next/c/0c89a779c373
  - [v8,net-next,02/15] dt-bindings: net: dsa: add NETC switch
    https://git.kernel.org/netdev/net-next/c/6d019124be60
  - [v8,net-next,03/15] net: enetc: add pre-boot initialization for i.MX94 switch
    https://git.kernel.org/netdev/net-next/c/f059d55fd8a0
  - [v8,net-next,04/15] net: enetc: add basic operations to the FDB table
    https://git.kernel.org/netdev/net-next/c/4566269803ff
  - [v8,net-next,05/15] net: enetc: add support for the "Add" operation to VLAN filter table
    https://git.kernel.org/netdev/net-next/c/d0ac4d4bd299
  - [v8,net-next,06/15] net: enetc: add support for the "Update" operation to buffer pool table
    https://git.kernel.org/netdev/net-next/c/cb4d95d79d85
  - [v8,net-next,07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
    https://git.kernel.org/netdev/net-next/c/123db6a27511
  - [v8,net-next,08/15] net: enetc: add multiple command BD rings support
    https://git.kernel.org/netdev/net-next/c/c5aed83ddc53
  - [v8,net-next,09/15] net: dsa: add NETC switch tag support
    https://git.kernel.org/netdev/net-next/c/0850005c26d2
  - [v8,net-next,10/15] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
    https://git.kernel.org/netdev/net-next/c/187fbae024c8
  - [v8,net-next,11/15] net: dsa: netc: add phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/bbe97e347219
  - [v8,net-next,12/15] net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
    https://git.kernel.org/netdev/net-next/c/46d6407692c8
  - [v8,net-next,13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
    https://git.kernel.org/netdev/net-next/c/a5ccb7f5e067
  - [v8,net-next,14/15] net: dsa: netc: add support for the standardized counters
    https://git.kernel.org/netdev/net-next/c/25049d8b6e6b
  - [v8,net-next,15/15] net: dsa: netc: add support for ethtool private statistics
    https://git.kernel.org/netdev/net-next/c/beb0e54f3806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



