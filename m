Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52D606A319
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMHv9988
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8PgV75d6z2xly;
	Wed, 21 Oct 2026 07:50:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792529414;
	cv=none; b=L7r2rQ4I0Nhsb0gqQnaceM15zraouupv19nfnXE5elwIX4S8mtfr0+sKMo4B4OuX8Zlov9pcUOFBCiUk0x4d/19UzYR/VLx1bZ5P1utVcyQ8GKbo74bX4PHEEi+eTRG5nSYZHlFS5wPkFH0BLv0VUlcI57T6AbpVJGuDVFMrsAI51eznYjKSYOA36iwCofwE/Cx2ZUgprgkYFXg7/G8FKr+cwXk+YebsG0J5KYbs1B3LwiP3JkyfjmukbGDiQqnoexS1nkPlVMhW/xYCqW+TFLCQj0p1vetfJ810gBd+HHMZlvtARBYSLOuSaCz9Z8Yu5C9h7GTB4wJP6KPlkK24XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792529414; c=relaxed/relaxed;
	bh=UQAaHgmlQKDGLtXEfAY2vP+sucWYdmNtFS1d5EJPeGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UW1wK6M++6IcJE2FR96IGZHGswyezONtLF/Hl528o7z4GdUnknGwl4GPak1j1Rq5yUcYEe3CGy6U0ZdByCJDqxdC/ud6nHS80HpD0aAtYimDCmTIHi6v3HY+foz5+Qojn8PwiGZ4YR2PZKgjtbuNlEYdaQl717vfAgNaNYMJDQT2OZCzOzGHk2D43UjoaJD1gCquXfFiRUCpGpXUJymvLd2NY9d8htB2QTO1C4hAtngMWlsL71cbQlJYgcvd2MJoxjYORGe0l58GeZju+5JLV7oFs4X/hcCuBAK8LNJO1dEHAWnxMvrOPh1STznYPLuO8TWuqkx9314h25ZWjeuEng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMHv9988; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMHv9988;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8PgT5151z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 07:50:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A3AA343B55;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D121F000C9;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529408;
	bh=UQAaHgmlQKDGLtXEfAY2vP+sucWYdmNtFS1d5EJPeGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lMHv9988OSw2Qf+jK72hfM+vT4RWfedhlGVr3DF3Qf+AgaVYB8GqYUmk2VmWZSGAt
	 fVLMIxSADHPxcIxNqHJCYDs6mG9jfnMOsCPQQfAqVbHCGkX5i8lPFh5h8naCuHh+Cb
	 mO1FC6lE2R0nlZzI5YWZ2+HCqxdUiKWTl5APQiJTZuoFsYqdmqAiAQ7/cgnYnzBAOL
	 mO8clKUA62qvqMATwLOjyFeezb4Qf0Ahf9vNnh7EcxMUZKutXlgVj6VPod3lotxsCT
	 Ohcbn63c8567IwCpq6rIvpbujWvIyASF6PXBgMemmmNKRtVdPJcAEbJt1FHeQQ6052
	 K262PCg9WIR3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774423809A09;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net v5] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252940703.202014.9168036604597546075.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:50:07 +0000
References: <20261014194818.11640-2-rosenp@gmail.com>
In-Reply-To: <20261014194818.11640-2-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 12:48:18 -0700 you wrote:
> marvell_config_intr() rewrites the whole interrupt enable register, so
> the config_intr call from phy_init_hw() on resume silently cleared
> WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
> WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
> the board did not wake.
> 
> Bit 7 of that register is WOL_EIE only on these two PHYs; on others,
> such as the 88E1111, it enables a FIFO error interrupt. So give the
> 88E1318S and 88E1510 their own config_intr and handle_interrupt, and
> leave the shared callbacks unchanged.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
    https://git.kernel.org/netdev/net/c/f434191f9388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



