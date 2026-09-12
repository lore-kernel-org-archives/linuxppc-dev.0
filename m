Return-Path: <linuxppc-dev+bounces-27175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B000C88E59
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 15:17:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhw584gXKz2ygp;
	Sun, 13 Sep 2026 01:17:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789226252;
	cv=none; b=oroCtolehXLdbAH0V3hWiQ+knvL0mT/rfoq5PpJdZZVzqJwcQ5RD25tyr9eFfMfjhlkXWT3RamFfdbMs3lPpjzwhpholJA5pZS6FRGiLnfdL51RDnyNQ4hUoWztuIuhJ/ltOIfnRubur8MHdfCBOZ4evH1YXnip0aMROT16utqujLyr0acegylpphZ5p3+IquJc2Yxvvj+soH2Yi8Lt3A/2XUdOfyZA2mqKqRBwBSo4wgtZ3RWJQuFZDg8IpimaVGgdMDJPEBFM2giFPsNM5IQYiJU4jqrSdSiPYPGAFaBOCU/JIY57Ary9AsBhRRXaOaQ/rnqsh6prbV4xcsIn6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789226252; c=relaxed/relaxed;
	bh=lto7jgAgpRNpr8dUDCGeD6PixlreSfcwTjjLcpd+ft0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Yov3Nlf38l/1Ft6VH3DQxkDCpVAxprdrdPahK5T61BCbRgvQ2IPh2i0q781xXt3FhLbQmnyNNlNy1GgBo6td/T/D/VmQeDVH0qodLPU1RGpBhiDgFuG/XIlwiFwcFCKcXUI4xYRwl/nv/dljJVEW5bg4gP55jALSFBPCTRlrg9lHCckabtdSDJTgQCciBUcf7pQ/jDIFkawj6/ZdJo5qpnqQo774wrjxLHSoR8UI4EmwuAQyak5jaYWManQ3awBCYMezx5zYg2DMwtSCCZK8nVXBw1tKXoXy8LH4jlc8ApDGX0Ujq14g8fy1Ay4NS5GIvIgQy04WoHDfAp+l1BOejA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyUl9g7U; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyUl9g7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhw576Vz9z2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:17:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 981DC60237;
	Sat, 12 Sep 2026 15:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB6E1F00898;
	Sat, 12 Sep 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226248;
	bh=lto7jgAgpRNpr8dUDCGeD6PixlreSfcwTjjLcpd+ft0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nyUl9g7U5EzWaPuVCjUCCso79OPZY31KJmFqiOLAE7E1QCOgF1ZIPGJB6FVT+1lFX
	 01VoitH6aJMTmpeASIRMYJjtcuRQgy38qkwWf3+/1fhaT/jrqfAvhZzEyyU19alz0P
	 zGzX8NN12ZkubLfj+NS4qmjfNMKCwXNxMQnCM4i9tA4ID7BnXYSuQ9dxQaZ4foTiMx
	 ro/q53LZ689UBo8VPbRQJ5iKpMHMzSkqR5Hrrw3t0iUhALElbuxmvDaYWqS5guE1gL
	 3bXVkj0Xs9m1oagiGPAsS7IYXePbx4C6ToF+Ou1opFl9/Ya/EM/22Ylk3Nr/mkHsM9
	 BRTjVU1HloFcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8B380820D;
	Sat, 12 Sep 2026 15:16:25 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <96c01d5a-3000-4921-9775-025f9c4c2908@linux.ibm.com>
References: <96c01d5a-3000-4921-9775-025f9c4c2908@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <96c01d5a-3000-4921-9775-025f9c4c2908@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-3
X-PR-Tracked-Commit-Id: 9e5c53d75c560a058abef0e4338c5e3e52cb432a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52311be52f66f1a3c71bc808d156482feb1eb79f
Message-Id: <178922618447.3511661.5005092280380751370.pr-tracker-bot@kernel.org>
Date: Sat, 12 Sep 2026 15:16:24 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aboorvad@linux.ibm.com, atrajeev@linux.ibm.com, chentao@kylinos.cn, christophe.leroy@csgroup.eu, leixiang@kylinos.cn, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, michail.tatas@gmail.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, sourabhjain@linux.ibm.com, thibault.ferrante@canonical.com, yanlonglong@kylinos.cn
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

The pull request you sent on Sat, 12 Sep 2026 11:40:34 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52311be52f66f1a3c71bc808d156482feb1eb79f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

