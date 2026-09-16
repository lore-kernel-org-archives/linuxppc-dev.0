Return-Path: <linuxppc-dev+bounces-27508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA26C982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 20:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlVFd418dz2y2Q;
	Thu, 17 Sep 2026 06:03:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789589029;
	cv=none; b=GrAfYkdrYRFUXRkrOVwTK1+0ukN7Ioc1S68GV58ifmHMQXARg+tb6DFnzf/Ew8ebCTEFdxFGs4B8Gd3NCpIf0FkkL8jV+O4ppKWqYxOeCLjVetD2463okGQZ/jok6heECi2eF4HksOkgUa++5yorspJX0fPudS1V6zF6Gozg6q/3oQ9YbU2mgT4qyboePd4HTw32WM0qpf50dZhNXJJ1mXphOwNT8wFraIqiRUAy3YvMvE9Rr7+EEdcsIt86O0TJ9HoPCp9j1Nb06mBIc45i/s2wLMn15a1UMx0HjZUqWAmlrk3rlVYzgsSwYy7TKcyDSn5AB1iwAA49j5jvRlomTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789589029; c=relaxed/relaxed;
	bh=VRWG2SoRwjxQIbFVUxojKYFvMyrNaqq8HsCrfsjBoUQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T8SacLHwY9cxrt/seIjIsngf7X9T8+bIxjeGrc7uJ3MXOLCrnmfvgX//QgIoYiq/bDqzNnK1aMCsT3/xvXwa2a38S90XdKlT/cNZ3rJNDks2s3uVPnQBf2UTYSSyrqfgA/wVbh2Y+U3Z1KiryuMHxwnEDPbjcx4LqtivvF3hEVWcLtuL0hgqyBc8+rHUbdVa2gpCrGA8W4vLtupYOnyU15gMGl2QlD4btKyTpE7q6lMc//lVQ2aHi3C2ObdHHsb4jx6v0kQLr6g6li1numBH/2dbkObt7jlMYGkLFguo2UGvUb50OcGd7e6NmZH8gc8Ww+LHVdpBz4xmUQMmxxRVYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aysqbm7m; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aysqbm7m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlVFc6B0Wz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 06:03:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E91FE601EF;
	Wed, 16 Sep 2026 20:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AC11F00899;
	Wed, 16 Sep 2026 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589025;
	bh=VRWG2SoRwjxQIbFVUxojKYFvMyrNaqq8HsCrfsjBoUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Aysqbm7mrAKtve6Fd2eCg40VfJ6uHVnQy6WnADRdaNkvFQ7MZ4g4U0HW2BfrjcAZK
	 leyo7DnB/SgLIztzGfVKDYPFN2OtrS2EOcikNuyy6Wv1kF3vmGVfReRmftVIoy0/El
	 knWXdtTWM2X4n0CDeT83Hk++ovcwEIBrro86ieuhL34tYYUHyaOnlDMWgyEKD2nDzA
	 c5BZvo+vetBncbPsGU7NMQcY4Km3pQXzCtH8sbW/ok1XXQGcs/HJ3rdw7MFU+B/zut
	 buygcDPfgQ2GUpEV5guxyAiSd9YcEoj/WmXM9NwJMtgCaADaXfwyy643NdUdffvSbL
	 dYk/H4MM/ijJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CF239E8A5C;
	Wed, 16 Sep 2026 20:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <376f4338-8bd8-44bf-b132-ee7bcb5bc29e@linux.ibm.com>
References: <376f4338-8bd8-44bf-b132-ee7bcb5bc29e@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <376f4338-8bd8-44bf-b132-ee7bcb5bc29e@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-4
X-PR-Tracked-Commit-Id: 0b271f7d7f5ed45bc498a03ce0aa9cfd8402fc71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 238650ef6c7c7cca08e032527329424c9fbd70e5
Message-Id: <178958895949.3268005.4615565111290806567.pr-tracker-bot@kernel.org>
Date: Wed, 16 Sep 2026 20:02:39 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amachhiw@linux.ibm.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, sbhat@linux.ibm.com, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
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

The pull request you sent on Wed, 16 Sep 2026 14:09:04 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/238650ef6c7c7cca08e032527329424c9fbd70e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

