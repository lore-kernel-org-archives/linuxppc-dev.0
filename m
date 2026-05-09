Return-Path: <linuxppc-dev+bounces-20630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56201CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 01:51:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gC88j5Wyjz2xFl;
	Sat, 09 May 2026 11:51:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778291461;
	cv=none; b=OTJu43MU4c1eGouXil6sj8RS2eG3rAB0RzUJQxBMHbiSLaS+ZfxEJfKK3uYfWrwvijCpoOte+1pSt+mbYdkekifryrck3S2Hb7gwdhUTjb8fOH5djk4ieFthEYKXYRFLccfrWWybPk81TVLF05dRu6oC1u49LBB8YenGoT7IvilzjIb7j/IyjDQjQcBnDquCkXs2FRLpe+rNngsV/O5XUGJDFT2jbV5w2Xd/pHVMpO3wtsBHAxpx1XTnOoscMjQ4IolE5j/1BUsjkZTZxWkK/V4W3965DKwl8Oa09PNaYjtnyFqNAg0wmlYima2X8h8xPlhl/3F/s7b7+NwBAB5d6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778291461; c=relaxed/relaxed;
	bh=+rIc3WjjipwnXV6RuItbamlGgSei33Wan2vcrRH68kw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=joYLyYxbj13eERv2z5Jj6pEqjmOFTTNJHwQT0/xL3Uwh0K98uOMEszdNRl2iSOv05OYZm+DBuWhx6Alql77Wgp1yHib/mXH81HQUoMahq7FFe+2Ab2DQz5umtYyPN4AFgIh3L0KkoDJCehxc/42R+szIvMhpEXaYZBJ33H4b1KaxtqfNJ4ONAQjoiOWKaUHt1l00MtcB+S3I+jjlc96o3iBRa1c6TsbAMiVcdQ3HK0mEDsjObxu+plsTQ4ogoyt6wCTWAtP7z6E8tgjBGYXWPjEujlYPhXTNhmGUcu/cL9n9ZsyN167qiK2HVw62+CNWlfO1thL8Jd8irjq7929ORQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NvUItxhR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NvUItxhR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gC88h4YGWz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 11:51:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C6E2E60583;
	Sat,  9 May 2026 01:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747EBC2BCB0;
	Sat,  9 May 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291457;
	bh=KntIHwJ+PkR/VBc31DDFO7W9+1zpNvg/anmOOYQvFP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NvUItxhR/gJUc4U63GaheSTJXB5SoL6CL2teKaM0AirGRoao1N7+Y6xIWgyXmVRNg
	 qX4s9Wc4DnXh3MHMoV5gdYeZb4NMHc3s4s1ZQbYcPmgiz5eCWh3pJHwrcf8TL2KUe6
	 Xv0w9qYQ5Z7U6zmDE2YDj5v01wate8Kr4Fo7r9WjyW1m47a+2Dje7ks4ez29Ets1Qn
	 SoIJaHGjMUxCHx6M28wNwfKuduZ8OvoMy+61+aW0E8bKbJmCEyAVXWcEnMoKGuuEAh
	 RjTLrtwR64dZIiLc6rFW52RhUNyu0KnLtXuwG2k7e50AfMobWu9AbAU1FJuSZTFIBv
	 X/mE5K3EhEuiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6938119E7;
	Sat,  9 May 2026 01:50:07 +0000 (UTC)
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
Subject: Re: [PATCH v3 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829140555.931855.3651116265067551153.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 01:50:05 +0000
References: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
In-Reply-To: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 17:53:32 +0200 you wrote:
> When the device is removed all allocated resources should be freed.
> In uhdlc_memclean the netdev transmit queue was already stopped. But at
> this point we may have pending skb in the transmit queue which must be
> freed. Therefore iterate over the tx_skbuff pointers and free all
> pending skb. The issue was discovered by sashiko.
> Tested on a ls1043a board running HDLC in bus mode on kernel 6.12.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
    https://git.kernel.org/netdev/net/c/496c0c4c53bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



