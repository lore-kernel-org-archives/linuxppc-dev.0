Return-Path: <linuxppc-dev+bounces-24913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61032C53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 23:41:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8FTr4B90z2yH4;
	Tue, 28 Jul 2026 09:41:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785195664;
	cv=none; b=dj+HkejXL60fZPyLHSndJAk0b3dYeF+emNcodyChPw+oftkcGk+/P1m4OH+b3cTaGXJzYwBJXBelNk8D61auUKnOVs1iFtNtO3+/r3BSQqO8liNArk845bFjupdLlHEHPuT4qqFdzcIzmIxEVivLYObeOA3kTSdo0YdOPpxFjds58YuZ1mkBGt9mZmitp1FrWQmgv1y6dPM9ozUT/WGde3P6MZDKa8yTD8Ees7VrVWgvWnAb5FN0y6ZIvBagII1fL0OkmTUBDXQICUENXAXfrHozri+jVuqJuw28hWKHAKnaBPjGSJepsnRfjUOG9UavB0+OYYLYeqKgBILnf98x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785195664; c=relaxed/relaxed;
	bh=+AkDulFJvGbU+T4ibTyIoVY+rmeIInL85BGIirfLA5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ViIU7kIb55u0sc+DZ1y4BWA7qloiJkgFs//I14m2Io5ax+HB5GrvqNBDZvYZDicBWgPVlGT7E6aglq9rTyI+nqpKt2vt2ta2wD+PZ5Rag6zXtS9GBiWgoo4n11d9ELjgKJ+iBueIPCgZe4ZjQKrO0AI4ZpTlcGDv7xs8ydft89OTAOD8WhNDw8kGCamI3OcNydCYDSpZMuqzSb3lpzxwaH0rsnNzh95qlmbFWeJ6sCcjORCyF5A8oQTQ8HAG46z2Ru9J1WTeb6RWYCVt8VEsM5c72XZrYaglB/0IeEdB1Os2kjEndm89DWDslIeuPW+1ILJoxiTooUzS4Ncp2SrWpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqNRNaMr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqNRNaMr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8FTq2SvRz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 09:41:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C0E08408D0;
	Mon, 27 Jul 2026 23:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFEF1F000E9;
	Mon, 27 Jul 2026 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195660;
	bh=+AkDulFJvGbU+T4ibTyIoVY+rmeIInL85BGIirfLA5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kqNRNaMrE1Z23E7OwSTuE8VhlwGmYwdoexj10/ehEOPMpB6r9rIS5aigWPz0UrFGP
	 ZRevf6/7PzYKgG8YmSryF5fLbnPt23wvSxtkYPI2IEPAOwDYxOqjk9UKSXqRTwtYkJ
	 niKE5vcMKJ2sOrvAwlftF7fAmTiiPoqj0u4U4e7kr0f4Q1X5NWMIyEtPWNi3rKa2pH
	 bvLPZ7Ge1DzRee5WHPBqKIIqmj8LRU+2YISrm/OQDs814IdAndNM27o1VW5bkvcNwR
	 XXNF1oE2pejeg6pIkWzrwHDX/KbtLGSoIxRaSb0S37Cv3wsL6Te60OIJ+ipH6JAguM
	 26eI5t0Hjmiag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EC380CED4;
	Mon, 27 Jul 2026 23:40:27 +0000 (UTC)
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
Subject: Re: [PATCH RESEND v4 net-next 00/14] net: enetc: cleanups and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519562589.1461983.12874776848447820701.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 23:40:25 +0000
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, wei.fang@nxp.com,
 chleroy@kernel.org, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 09:43:02 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The first group of patches (1, 2, 5-7) eliminates code duplication
> between the ENETC v1 and v4 drivers. Since both hardware generations
> share identical register layouts for MAC promiscuous mode, MAC hash
> filters, and VLAN promiscuous mode - differing only in register address
> offsets - common helper functions are extracted into enetc_pf_common.c
> and shared by both drivers.
> 
> [...]

Here is the summary with links:
  - [RESEND,v4,net-next,01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
    https://git.kernel.org/netdev/net-next/c/2557834ad0ff
  - [RESEND,v4,net-next,02/14] net: enetc: extract common helpers for MAC hash filter configuration
    https://git.kernel.org/netdev/net-next/c/0ce10770963e
  - [RESEND,v4,net-next,03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
    https://git.kernel.org/netdev/net-next/c/debf0c7a34fa
  - [RESEND,v4,net-next,04/14] net: enetc: improve MAFT entry management with bitmap tracking
    https://git.kernel.org/netdev/net-next/c/6228fc9c2bbe
  - [RESEND,v4,net-next,05/14] net: enetc: use PCI device name for debugfs directory
    https://git.kernel.org/netdev/net-next/c/9db43e6f35db
  - [RESEND,v4,net-next,06/14] net: enetc: simplify enetc4_set_port_speed()
    https://git.kernel.org/netdev/net-next/c/c969fbc01d9e
  - [RESEND,v4,net-next,07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
    https://git.kernel.org/netdev/net-next/c/7c9a6ae0edb2
  - [RESEND,v4,net-next,08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
    https://git.kernel.org/netdev/net-next/c/59bb3d62489c
  - [RESEND,v4,net-next,09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
    https://git.kernel.org/netdev/net-next/c/75e134261f61
  - [RESEND,v4,net-next,10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
    https://git.kernel.org/netdev/net-next/c/f7c6dcd6444b
  - [RESEND,v4,net-next,11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
    https://git.kernel.org/netdev/net-next/c/ba07e3bef1b5
  - [RESEND,v4,net-next,12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
    https://git.kernel.org/netdev/net-next/c/75b136cf0f6f
  - [RESEND,v4,net-next,13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
    https://git.kernel.org/netdev/net-next/c/f0c1f31afd97
  - [RESEND,v4,net-next,14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
    https://git.kernel.org/netdev/net-next/c/18bf0ac84334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



