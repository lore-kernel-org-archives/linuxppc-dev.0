Return-Path: <linuxppc-dev+bounces-25134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624DC5516E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 19:15:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9zSB1qdcz2yH4;
	Fri, 31 Jul 2026 05:15:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785438938;
	cv=none; b=gXHaU3aFMS8p8KcMfsZnYV3HGW77nfoBCSRZa8bUwtuFuwXe0ICccGsb6/jadh5iNj+VvmVM5N5V0cSNipyzXLN/QZ/zOlzXoDoqL+6DpCSkS4fxmHYT0YIPj4LH4QUUzlBscRuZ4BoIIuNDs1Y3STyljZuZEqNk/AEWVoNeadDihrdvrbn00BeW/8vZUztnSoUAYM/1QVi4Xaj1NvmnBoUznJMe9KY4aqiofM6crM/RuBDqw4g5nQkX+X2n4Fyw+g5wRqgXTyn1SrF000e4Mj2eCRJEXhUvxb3A9lnbm8ULJvhCYTX1coZP4uNLwPSyoCfL9jDuxSqyrUVGsjdHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785438938; c=relaxed/relaxed;
	bh=JiSflQYpWZ4zq3HedHH+lInDG3oQCa6GsnTnS78xN+I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T/Dfg0iUDUR42HttW4xS/3nyxDypzrGPEUYf5PImMimOCzyT0rDdZtTJKvhlXvO3f2M34SWwLOIy7VAknT5sW1j7QIB60q4yGMps1PYfPbPOeML151AoUEgzYTu7+OKYtPkT11z6tJme+PbmkTcWMreMumxW6uhC2tO6r3qgLa4S3YJEqDYRVDibc3zYR+wTl5Sv0yxNsdIBuXchu8Q9eoYI571CJUCrggXs+aTr6wdL5e/vPHarHWWmQX/J6UkBuPoIdw2EGTrjjgJXlk1tTgunTNXKUTZqzgFZW0qg9NC1NL07CVV7rptddjSRYf/LxJt2lC2xYhufjd77t+VfKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSIVp+2c; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSIVp+2c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9zS874Rcz2xg8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 05:15:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 65CEE43F6D;
	Thu, 30 Jul 2026 19:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C91F000E9;
	Thu, 30 Jul 2026 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438934;
	bh=JiSflQYpWZ4zq3HedHH+lInDG3oQCa6GsnTnS78xN+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dSIVp+2cs5WJLJYWnyyXag+cjnN7VnORIp8uHn1kLRjcCl5AEGF0OlE/MG97TZGrs
	 61yCAcp8TvCzKGwGbc0LG97NuBTtG5sOMP0VVqJK00pit7D2JW3fMrDVKtmJ1SFtT7
	 IQi9Cj3q2vnAqRU9gPU8KuLcmpKXlYIN/Azpb71Tv2d2y1jHXk1SgtjRKuFDWC2sE9
	 lG+g1j7EKpYx1ONBialPhTlDu9xRCGEYFbRADTdHvZWEEMdIzo1+c6oWbZKr4ReCrq
	 6tSomO96DKUuEQRQqEE+yZFFJ9jtJRysvu9bnC9c70jBZe9Z7/KLnC1TL7g55zO+rZ
	 a/mBrk8DbTbmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28863811A6C;
	Thu, 30 Jul 2026 19:14:58 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <1db2ecc0-b7c2-4647-87c7-592fa50bbfa3@linux.ibm.com>
References: <1db2ecc0-b7c2-4647-87c7-592fa50bbfa3@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1db2ecc0-b7c2-4647-87c7-592fa50bbfa3@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-3
X-PR-Tracked-Commit-Id: 5732bd17feb9ddf843591c4d038eb6de1f8daf4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b96890b3e5e0995a4bcf731bb9d6af2bbdf8ec42
Message-Id: <178543889760.4145507.16222640242978707295.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jul 2026 19:14:57 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, thorsten.blum@linux.dev, vaibhav@linux.ibm.com
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

The pull request you sent on Thu, 30 Jul 2026 11:45:25 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b96890b3e5e0995a4bcf731bb9d6af2bbdf8ec42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

