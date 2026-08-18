Return-Path: <linuxppc-dev+bounces-25965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D0FC5DF85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 19:15:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPfYY6z1wz2xrL;
	Wed, 19 Aug 2026 05:15:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787080545;
	cv=none; b=TgLEdJw8eZX7vRFUlCK0wrFfNwsn6OAWIk68HWqeqbXQ9dB3Sw3Qdty1Ro29XJ7Yvqn7Lax8dCKV+TXm6iI4HkEaV9lfs6h1DrOK863eyghIHA3NqadIChmuXAl24ahLVbtDOumdwCRP5VFh1LkqXcaNlEORfgsqSwJAZtxCjVd1WLDHIZMWUznAyNTimCD6qd1YS70Cm7M6bKNk1p8JmjytrAaTOBpSQviykoyJD0q+D0eoPTRxWARh5wOr71I5o1JbNE7pyqYKYJ3o8mQ586bJ+nC6JyCMTkns0aCPnE6a+Prl4Lgy1s0VP8sS+2+lVWkJaFOaV9YZlxqGjJ9pYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787080545; c=relaxed/relaxed;
	bh=eeTt1ekCuzJ0dbvI3QlwDLHcjKpOhdLKb2WDc+PP3zA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WfTwpBKEfKhYmsFBqBX+c5nRsfyQFU81c5+Sqww2TscTX2gqxeVKCGeaO+oynwptnOCmJjxzKiFjpVu3eS89qE3T+9uJbzbIePFR+ldLgxUYLtmQkSx2OQz96+51HdBlZ7Wi16uY9HcDrKLNOZjbJ13U1uAAs6tRbxdylrIsUPdXCs0kSkZIYQ5HxbUTLjIBpug+G8Eb2mFT9lABS8oXAgpbhAr3av4vSnCqlTR2WOFlWXD7l1OKwKOtgHdtjKac4IlYDmftpC4dFb2s9X05qfs4aQdHAI1M2+nOniU1d3Fsram1Tc9YKZAHbB0IAbktJAxTcxiRF37LIDlkGLvEdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKI/HRKW; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKI/HRKW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPfYX5g19z2xnS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 05:15:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A5F7960A63;
	Tue, 18 Aug 2026 19:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5654D1F01561;
	Tue, 18 Aug 2026 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080541;
	bh=eeTt1ekCuzJ0dbvI3QlwDLHcjKpOhdLKb2WDc+PP3zA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aKI/HRKWtbeli3BVqlWF0xiuap7VBoKErKeD0YJ7FTwcDe0KoFFPLbMoPEjwU3fs8
	 TNlEV0yU7ot78n0YiZWAYuxfWz80NoPd9oeLEV9g0Al3aWeyhxCeooV4Xp1EJfu58i
	 Be6RvagxcHdM6aok35LCIf/2OigAX6hDRtlmTxdWD/6OcX2bjgBV03RBiMd+k25ELk
	 7fsYPHBqdtTFMLVImcWsQ8Am3Qa13pm3F4gvmKhjtz4bhS1icOah8HNP8NhVwWuxWD
	 G/pm9PUmIwEXqu5EYw4FHPcvJgUw8fvriO6x16BLiwaUrVD49C1POnqBg3cGOAvLSc
	 hcyULkaFg8Rdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199073927051;
	Tue, 18 Aug 2026 19:14:54 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <a0c34d36-fa5c-494f-8525-13e0af8a40f0@linux.ibm.com>
References: <a0c34d36-fa5c-494f-8525-13e0af8a40f0@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a0c34d36-fa5c-494f-8525-13e0af8a40f0@linux.ibm.com>
X-PR-Tracked-Remote: https://lore.kernel.org/linux-next/ans20_e3b_8XJsvA@sirena.org.uk/ Thanks
X-PR-Tracked-Commit-Id: 1304643a1c20badbb91b86a5084dd76cb7620c05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1200d84f4c0a929a0780180d25063d93773be79c
Message-Id: <178708049269.2235733.17283840532040668161.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:52 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amachhiw@linux.ibm.com, atrajeev@linux.ibm.com, bp@alien8.de, chleroy@kernel.org, christophe.leroy@csgroup.eu, gary@garyguo.net, gautam@linux.ibm.com, gbatra@linux.ibm.com, gouhao@uniontech.com, linkmauve@linkmauve.fr, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, mkchauras@gmail.com, mpe@ellerman.id.au, mwalle@kernel.org, naveen@kernel.org, nikhilks@linux.ibm.com, npiggin@gmail.com, ritesh.list@gmail.com, rosenp@gmail.com, ruanjinjie@huawei.com, skb99@linux.ibm.com, sourabhjain@linux.ibm.com, sshegde@linux.ibm.com, thorsten.blum@linux.dev, vishalc@linux.ibm.com, yanfei.xu@bytedance.com
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

The pull request you sent on Mon, 17 Aug 2026 10:15:32 +0530:

> https://lore.kernel.org/linux-next/ans20_e3b_8XJsvA@sirena.org.uk/ Thanks

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1200d84f4c0a929a0780180d25063d93773be79c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

