Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD9606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMch4Q+4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTltm2kjNz2xNC;
	Wed, 18 Nov 2026 13:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794969008;
	cv=none; b=A982VjlV1NTctnqc8rQwYNqewx5znVn9B44/C3fpht+Msdhl/r8s76E52gx2BXYURp5/balg7K3e79yVSWOk4em6sLHuXf4w7tW+37arHgWgz6J2E+rwkoMWlbGiPwh1uYr8vgsa7N7/5Ba6l1iPHFtjfcs0aUhZ1j/vBtcWfSiwjNaIf3u8L++tE9yhmSO3yMxPC8lXYc+g//lzIXuz0YT1nOzeaaLLIDCXtvlPa6yDnz2ck1vD4eAYhrwa2v98VPmCrn5jkTP5dNjnaY8sPgsagMRJV9TgBLQgRBlHLKZ8E7Bgd2CWCBrwLyDuP9P5m6cfnp2gU5MK1eq2LVG2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794969008; c=relaxed/relaxed;
	bh=12uYNWixrNxChlP2U/vVzYNoiX0h+AZW7KfjzyKi3nk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WNVkX8Kxp0g5gzrFL0HASrlvcAuPt0VYwEnpBK9X+0U9n7ZkAnteJdqq2PyJdM3mkNJV4V78PY7XxWMas1iGe/hWVAtUdHCnRu5B2rLcXf/pNhsAfft9I6vg9Vn+isTQrtkUiRi9Th8qtxvgGqGQYkhMLzRQotqk39k3BmwZEBh42hOQi1Hx54QKXMxJ6hD4xkYV7swY9vGDP5BkKdFqVP43dVp2ltIr9dVSb5b2I09M/X6bQiJQ2EpnAZc2uC2dsdOgzEjp9mMBzUyFoiEJjHzQu1B81/UF3aEYB2Yzk5piI9vaeomJk5jwwCj66fVdj+jXUUkP/Gb3saI/dj5AAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMch4Q+4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMch4Q+4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTltl3jkYz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 13:30:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A173B61F03;
	Wed, 18 Nov 2026 02:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CF11F000C4;
	Wed, 18 Nov 2026 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969004;
	bh=12uYNWixrNxChlP2U/vVzYNoiX0h+AZW7KfjzyKi3nk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZMch4Q+4in3qHAn9+Bjcqf4S35pIlJLPAz0/D2krvkydHNha0cRnPx33POjMmhH50
	 YCmaRwfT/s4BhCABUFt2Dklex4WXK8jnR3k7NXVUuPWuJCB2caFqsgtKcl7Pd0s7VM
	 722aFG65H15JienM/np58mjfpIVJmjBRnfYnk8gJen8Csk1+LaS5O2a1NihmFYI71h
	 jr7WJvfMAb5OHL7bYmlDjjJM3CS48Xm/VJSujVgjdU1L3B7aNZ336rR2q0Ny+LQvvr
	 TKHHOgorG56Tm1smKY/AwgpidOrEkLwtJSn0qcKXRdHHq/Ex3egqPlNcV359ZYo4Ab
	 y+eRaQpT2T9Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A397392B1FF;
	Wed, 18 Nov 2026 02:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <6aec7d43-7c12-413e-a73a-3275a1ac79ad@linux.ibm.com>
References: <6aec7d43-7c12-413e-a73a-3275a1ac79ad@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <6aec7d43-7c12-413e-a73a-3275a1ac79ad@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-2
X-PR-Tracked-Commit-Id: 9500416c8aa7c271b85be6a0d5856da62b60223a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ccb044c27720d48175577080b851f047ddcfd1c
Message-Id: <179496900297.1415040.8395913757600607238.pr-tracker-bot@kernel.org>
Date: Wed, 18 Nov 2026 02:30:02 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amachhiw@linux.ibm.com, brads@mainlining.org, christophe.leroy@csgroup.eu, gautam@linux.ibm.com, info@xenosoft.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, luiz.capitulino@linux.dev, maddy@linux.ibm.com, mdshahid03@gmail.com, mpe@ellerman.id.au, mpe@kernel.org, nathan@kernel.org, naveen@kernel.org, npiggin@gmail.com, sashal@kernel.org, yaojiale02@163.com, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

The pull request you sent on Wed, 18 Nov 2026 07:09:33 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ccb044c27720d48175577080b851f047ddcfd1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

