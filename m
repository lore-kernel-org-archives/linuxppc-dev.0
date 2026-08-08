Return-Path: <linuxppc-dev+bounces-25641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F3C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 14:52:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHPBC0TMFz2y2B;
	Sun, 09 Aug 2026 00:52:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786200739;
	cv=none; b=kLoqlAqOrNliOTKjIg+yFgaKwLQG1m1Y6bpwBH9z30104XviGiuTHmMQNM/Cnjm9TJLoDUE9UMulSOs0GTdW+V4CKNRqrpp8r2fMkLIIwUgxrp/YDDqZRS6nj9QqNwu5Lwmns8TxaUmQ4gSQZzXfNiNWvBV/9Hc/YmQTwskH4OusdP5+rPFBgU2tbvGTdTch3tqkaB9DaQPKnEE79ZENgJvXPmKf1tu9Ztxi/6nFuA83zUpsTJ/mv7e8KIprPy3k4gNhNGWhWVR+8tchB0yC3jGJXj9o+GMspl6AjKHRp4FbO/dSyLob6NNnZAgifV/tO1JT4OgYReeIbBNxAv0fEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786200739; c=relaxed/relaxed;
	bh=jUbIPdaG5F1aS83dmmsQQ11ZafyFjk7J1CFFqxbEXvc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cxxH2Mu6pWu8qfbmAXA+4tmT7vaMw5k2sfvGsvzM6kJXHHcgsqc2NYUc42B8/NbmjnfCPPXnqAXhL7s9CWqPsYj4oVZ4Tq3VllALqLzt7qN2YoRBgy5AljzyJxdCGiUARgQIpWZYTi0whJ73q1LP0BngvaffmEk7gPCwx3YFUEEQCSS3k5pkFSEkVgKvKTdqsRIpMPgCqpTULPLK/Oeb7zfIGCVFEmKk7Og0MkckICrO7jdES15wy9tqYxnXMQYlGavPrQTQ+ZZ1F2vgTdKZobCnO44GWMzN+a0+NfvZ5IyDhi6pl/fK97/AYkIW7pTOzZCZIjc/6CLDwDEkn/gOhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNDC/lZ9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNDC/lZ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHPBB3BKLz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 00:52:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3CAE4129B;
	Sat,  8 Aug 2026 14:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78931F00A3D;
	Sat,  8 Aug 2026 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786200734;
	bh=jUbIPdaG5F1aS83dmmsQQ11ZafyFjk7J1CFFqxbEXvc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RNDC/lZ9a152UfEaD1eUWHg3jMYZLEgyG8hcGndQyXEuB0UtQuSKremsSfMgUmiSe
	 ncY3fDroZgyy29/8wtzQ+tvq25KYOac2ybaQoWPMZ0DAqSF9Rdq+10eh2NUrlt4XKt
	 xyQawoaKaUbDYS4OZV7rI6Gy/ts8ClXvCgHZVkLWZUricyMTmm+4nbUStsScHJt1oQ
	 aQJ25o0lMyaW2o/V5A8ggJgR/fUTMloC/qUFIUnjJeWCcGluE/+0Lvc39XKBDmC2Xy
	 WR6z+vKcT/cowcvVbfmWkfz58WlvaOFOmF+p5ok//1xLYyVqDsuT2bIeqBuXKXTV3H
	 3CfM9r0NKzlzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19854380CFEA;
	Sat,  8 Aug 2026 14:51:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <be9b4950-898f-4f17-825e-415b30e0d892@linux.ibm.com>
References: <be9b4950-898f-4f17-825e-415b30e0d892@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <be9b4950-898f-4f17-825e-415b30e0d892@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-4
X-PR-Tracked-Commit-Id: fb442a6673ff1046bf67754957d95880fdb394b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afe80aebd320848964682ad5a1ffee678ce9af99
Message-Id: <178620069253.2671154.17759463029349724105.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 14:51:32 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, gcwilson@linux.ibm.com, haren@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, nayna@linux.ibm.com
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

The pull request you sent on Sat, 8 Aug 2026 10:58:20 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afe80aebd320848964682ad5a1ffee678ce9af99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

