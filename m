Return-Path: <linuxppc-dev+bounces-22826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035B5CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 14:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghgg63vM0z3bqD;
	Sat, 20 Jun 2026 00:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781881042;
	cv=none; b=JepQ7ol66A8su2x4slSXvjVvTVVMU15B/j/p2qGYpL3aZEkOJm4f/jbL6rAMPmB0UO8tEQJhuDEoGQiuqkZkVMdfYDMidSeVMjOhdAmSrK8IQtcIlGMqT/q7D4CjtARm+2ssL/BPWOgO+AFF3jUyH0c45LGWg4CSgnus9zoicBRxJ6LSiSs+BKVza3fASl0Fv3NeqxnJbQu0Wn7XU0mpCud1sYQYoQA7arXIROEXGtK3uynjU5XYPi4INUwrrTgckNpNha/SpnRKaC5DaZLYWNqgQeBgAFvPQIiMo8yUZ8Pugd8uifkz9bXwhGLeCdZ2f5kww4OA21OmnAfR8MT6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781881042; c=relaxed/relaxed;
	bh=hSc/US9wBdexw3kS1fvVse21J6pp6YGVgDgk6gv5awo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gdRmelDXiFyB4CDfy4XldyN1c3okvAGYmkJOZre9Hx5LgZzYxWdlRPaauzIhPvOpqwTrSc1qnl5fZ+9cSIvacnSEyv5onGgn6+oqj6fUkoZW3hJpQx+XG891wIJs+5i4dC5MSOHyVGiq+ERyen9WKXmkes8t63B/qQRvlpEXfuB1169+NrPd9Vo6juBJ4AxGugY2+m63IXXvA0IaoL4nKKuRKhfVkpD+SoSqXDoFodYES42YTUX5erf4iHdHC6py6P18gkcp7G0j4hW/d+9m0PU1BLuMMMgS9bGxaP2r8FlPGJJ8Dd6EVETi8Uurd66tMZKB+9rb4L3Tq2G02dBHBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll7CA3Cd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll7CA3Cd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghgg51dD0z3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 00:57:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33054601E2;
	Fri, 19 Jun 2026 14:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D511F000E9;
	Fri, 19 Jun 2026 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881037;
	bh=hSc/US9wBdexw3kS1fvVse21J6pp6YGVgDgk6gv5awo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ll7CA3CdMNpd2rPEVsHqa0OeidRWIrlKG1Nh73gX7c/qbjKTbh+EE5zMHc9ce5ze5
	 BOdNdNaB0OoNgXoULMJTdaRVRpXdbPQ26piNP63bOOhr21h+o7FQNzsE++uwuAeldi
	 PUUMPjBvo/0K69ON+W2LqyJXz9zv56m2daDblP21/mS+kVrA3JEuMtEonVD7p//NVi
	 FkJXHwJIJOjVQfNSQH3OObvY9o7LhPdTQRr1LsFw/4SUFAtGdMMU54XL93G1xw9izF
	 UsUze52jfrkzdINr6IOtLgg1N54jMZS0d1SjYoDSm2IvmpJTxRmRmndYrtlpR818Dh
	 2QHGFn3E+zTUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199473AA6A6C;
	Fri, 19 Jun 2026 14:57:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <aafc00a7-e59e-440a-b33d-566ff4275700@linux.ibm.com>
References: <aafc00a7-e59e-440a-b33d-566ff4275700@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aafc00a7-e59e-440a-b33d-566ff4275700@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-1
X-PR-Tracked-Commit-Id: 42f252f5a646866a95f025863c8b201042494ba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91981f96d2831a73cd4dbe4383b4d7e1dcdfcc06
Message-Id: <178188103070.3941480.318041878574794849.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 14:57:10 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aboorvad@linux.ibm.com, adri.vero.dev@gmail.com, amachhiw@linux.ibm.com, bartosz.golaszewski@oss.qualcomm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu, ebiggers@kernel.org, hbathini@linux.ibm.com, j.ne@posteo.net, leitao@debian.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mchauras@linux.ibm.com, mkchauras@gmail.com, mkchauras@linux.ibm.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, sayalip@linux.ibm.com, shivangu@linux.ibm.com, skb99@linux.ibm.com, sshegde@linux.ibm.com, thorsten.blum@linux.dev
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

The pull request you sent on Fri, 19 Jun 2026 12:47:31 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91981f96d2831a73cd4dbe4383b4d7e1dcdfcc06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

