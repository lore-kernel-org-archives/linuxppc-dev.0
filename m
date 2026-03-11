Return-Path: <linuxppc-dev+bounces-18070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703411125851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:35:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWGZp4hFRz3bf8;
	Thu, 12 Mar 2026 03:35:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773246946;
	cv=none; b=inNVp/FsXyCbQts4v7dflDnrfxBeMZDauey38dbVnDB6Ru0sIzI5lAMh6hd4zECi5rInqA+1R6r3sxbdUi06DjcZM6jFDi0EJkkod9f8Q8No8Me7ANs0CidDdamIDkHgaSOaq1e1GrB6IZt3ZoC6dQYTwRUl3Hsb1M1ZMTMwzevaJHse1eFFrcmStIc71F2KZcaxHKPsJSYRKHhEhzp+AxVpstUKwOQZjaZYvqdIRY8asp2hO/rHk+cXGBqfXMByZi27rEZEeoYJSEst94Bg4KyAjHX1CePEKu7ui7INOPE3kw8whtPLoLsgwzGQPU6KdGP5TFQhiRdkICO/iKZ0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773246946; c=relaxed/relaxed;
	bh=mCzjSh30/nRAFOUPXBs1Zo2xEqAlMHHiD2BfB0QSTrM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I0z1prsVYI9syBCPCUhMrY4pncN25j3FjVsBgUPiJP2K+6wuDja2ibjhxSgj3bkn6iroQR/Ve+5FeUgGHm7dEvdXOo5d4wL5M4wCOHPN0HHWT7YY2rel3pHCW+Rkdv+Qlg/WNvLOGUyN0Ej6mRdz3GwyPTIdA574a5Rufmd5FuGvX3eF2VGxLcIiQqO3Z7RnlKPK4/82iCz1zY0T01VaiTIWs5FLZy/7il4bTCR4tJZvZRHJF32OhvRkIM9VgiBqKnWvc+UlQp36tFxgp4qhmdImmxKv/jHoHUQuVC4zDUqdZqFw+CljBwF/tjvSXGbZNvnbOFzwDrp4to9xcGUYYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GkbQ9lYk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GkbQ9lYk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWGZp0KWSz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 03:35:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF5664433E;
	Wed, 11 Mar 2026 16:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3496C4CEF7;
	Wed, 11 Mar 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773246942;
	bh=RYFGc21Ao3+viFvQ+QZZrhnq/7RrDE8AGZHEENi8BaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GkbQ9lYk3ZEIhoZFyit7f6hrtSSgYTaqheyeXAAomkXLCuhJuG1drMh3me2yzJJvE
	 omJwvw8/rGHRPBSmkTuQ3tHZ5uwK6AbG3pmyj1PzbAGzvBGcoYrgmqa2GAMHT1zj3z
	 gk/gJoRD2kpeK5+ZmRWTC3EZvAkQ8KO5thgUQdctHLAh7tkrzUQQlY9JBfVw5CDl2m
	 ISk8u/63VS/VrhHconJMAXxsiqc20cZCvSWCT4u7pLdKp7SkZa8AP9yzFuTWC5yY8W
	 luzTe781kiJMAi84yTe92UpiF8U4cn1VFMUs2Y/B0PrxabjJy8jBS+v7fmKMtNT0m2
	 P6JuYhLIbN9ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0307A3808200;
	Wed, 11 Mar 2026 16:35:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <c9b0a57d-e628-4cd7-be9b-5057045aec15@linux.ibm.com>
References: <c9b0a57d-e628-4cd7-be9b-5057045aec15@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c9b0a57d-e628-4cd7-be9b-5057045aec15@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-2
X-PR-Tracked-Commit-Id: 35e4f2a17eb40288f9bcdb09549fa04a63a96279
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b8e3fac9bac1f2bb67571a00bb58851826fe705
Message-Id: <177324693857.3742424.10525202679354033756.pr-tracker-bot@kernel.org>
Date: Wed, 11 Mar 2026 16:35:38 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, chleroy@kernel.org, christophe.leroy@csgroup.eu, hbathini@linux.ibm.com, j.ne@posteo.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, namcao@linutronix.de, nathan@kernel.org, naveen@kernel.org, npiggin@gmail.com, robh@kernel.org, sourabhjain@linux.ibm.com
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

The pull request you sent on Wed, 11 Mar 2026 09:46:09 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b8e3fac9bac1f2bb67571a00bb58851826fe705

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

