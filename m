Return-Path: <linuxppc-dev+bounces-19306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FDCE88D7E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 04:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnjv269kbz2yYJ;
	Sat, 04 Apr 2026 15:54:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775278494;
	cv=none; b=cmpiIRvIipgtWZh18fSxxPMWkO3+jFHLbvO9unE437BFNgpIaTpAmXEVljRxwNvmQwcr/1T3PIFZBlTm8ZDhANf3V+cnNvZ8Em3jnVQUpw1GWm6p4itf57aOXDJy3vJcOyHpAHxmvB4eckmlmGWmKvCB1r3tPH52yRRbFOqz6Nd+36zV4O31quS0W9a9tMwQZ5/U0g0sbMkFWRZW3wxVpToAmpBobL/IAp8JL4GhUNKb4hhUzpO5f7nqemHfR/7mAU06ZoYKdcRkgmZ60LfI42TWm1OywQm7rvaE3ROi9a75NmbLy9M3cj/xJ1WI4Z6B0G0VIKzEAyoIsPgA2ZyjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775278494; c=relaxed/relaxed;
	bh=Gw/SJex/mTjqzCjUu/g5F7jQmfJOuJt413vNMY9Uooc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NzX+oRldzPzhFOZ1kKxafJ0E4qQdwsupaSUDPKkWGBiiXLR7dTFWg4W1jmkgbe24kn7xghujYKaincB/RLXLMda5I98pZKC+ddh692t8EjoP9xUhVPNueFI4meqTrLRrK0PVgTxDcxyd+YOb2ngpLQqBlpNdqARyoc+De/MzEZMsw2I21fs9Oot9AhwjSGr6URzjixO9rtpLIvVlmtzjPrBreZHz3l1DBm05x5jHNeXMTyDwxar8kUIYjY4QB+wH/zzKNUwJMLHvx6ybx2z4K8GXVhheri3bvXZyO3orcAzE3c59VeqHRz0U3z+rCR8Lch5bPCT5Z76aQyfk1uG+QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ffh9nzkf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ffh9nzkf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnjv15yhyz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 15:54:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9712F4457B;
	Sat,  4 Apr 2026 04:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7286EC19425;
	Sat,  4 Apr 2026 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775278491;
	bh=GERvJkLRlaJ1YPeipP658fx1aask9vnie5EM8IbpwwM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ffh9nzkffx68Ck72E5oN5HyHbcvV729hyAjrnnjWv7kQlNBRh7Sfy+kFUZOvSFFyl
	 xGkDtfHkUg8X1H+e7frZMH3Akj9KCfcEwjtbHx79hjH2hZrkXYsA8hoQXlmPRfT2/N
	 8k2P7gp39KjzJQyWDYlZ573Qcj+xaPdPTpFOudwU/SkUQyO+PgSCNTUjiMuWFvnr40
	 hdDrnX1MmpQ4ccqRcrJs5wGrEqbXR2V+qCzmzrZWFQzNQHzVNUQu6a77XSpoF79dRL
	 3DwKRc+eCPflrca690z2I9rjlUth/amftcezSK2GHGxx833wIjdGqrJdYtuYdb9wJ5
	 ljWFT05YhVoYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DCA3809A18;
	Sat,  4 Apr 2026 04:54:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <3ae2afe3-ac3c-4f92-9073-1b8630496f82@linux.ibm.com>
References: <3ae2afe3-ac3c-4f92-9073-1b8630496f82@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ae2afe3-ac3c-4f92-9073-1b8630496f82@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-4
X-PR-Tracked-Commit-Id: 328335a79487ec38d6b0e1aa807785b0f75e594d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ca6d1cfec80ebe46cc063f3284c5896c344d9a1
Message-Id: <177527847265.1572522.7828308914450583026.pr-tracker-bot@kernel.org>
Date: Sat, 04 Apr 2026 04:54:32 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com
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

The pull request you sent on Sat, 4 Apr 2026 07:53:43 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ca6d1cfec80ebe46cc063f3284c5896c344d9a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

