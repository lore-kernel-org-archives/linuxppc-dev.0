Return-Path: <linuxppc-dev+bounces-20654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A53CCD3445
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 15:41:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCVZc3ssNz2xqv;
	Sun, 10 May 2026 01:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778341272;
	cv=none; b=NT5nA7Ilw9kpV2+hgF7sDoV1l0nL1GFdNyV6ubOnUMXpBfzP9uWvLrnhFnd1PfQJN467wukT3BsePMN5UlLn9cJRTE40ws5m9H2FtmB5WBuu3G1LtlN6+9NkmIf7mLbucQetXlZU5wr+7u5zn7btdc9htkVoGlNVT9YjAIkYIY/cMb+2uP2ThyA59r4Bk0Y8ycBbnvxWmaNvmt2Fy1zooGPLlgcOv7Qo01ZlikPprcGwqB25u2soohTH2Ret8Fbcyk+3UlBFL+RxBSqxbw4Pe7uItjoq1PcnvPTLn7HpkTHOFUPPORLMS0Cori0PVRpgmDcqW2s+rGI49/lYYH0Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778341272; c=relaxed/relaxed;
	bh=zUga5rsHgz3ff3dyQ2kA0wGcNc+IbK1CFp+a/ZLdQvU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UE72BZhkBcvQyZincXBuxWs0kMBAsMueJr7vt45MRwU/iGtvVE+eu0yepE8UyBNPaj2QVK1NeQdg8NClNVk00Hcxb7ez/yxqqgr6VHgoSt7o2d5of3rKl+TPm3P7Obh+fzY+HcE3WlleW6nuy156v6WD/LDZohIZ2xWJdrXKlh4mC40woa80FwJbf2STPxzcALoOY1cKUcNR4nOvyVeqPvpEuklDUTHIoW97SPbecY86R4IAdKm914EJvLwNhPb191eS08x2nepJhUKHXjfbcBi2iEwPdItwNyZw0ucxmOx+PPp/MgwUsPtPmhDdBU3LIJNNvKT0/Cm3oMQ3fxNtwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fzusdlb8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fzusdlb8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCVZb1Pyhz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 01:41:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EC9D36024D;
	Sat,  9 May 2026 15:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A969C2BCB2;
	Sat,  9 May 2026 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778341267;
	bh=ku4N2I1KSV1Eh71R9wXsVIZfeW+FR60Hz/U+6eJtkOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fzusdlb8ampFAfTJbWn/oKedzQfNS4KzwjUAKuIihdXlFACmOytguGzDRQJZjA8hA
	 YjAZtFITaZr8f6qqvyAawQXcbrX1aPanKRtRoKmxz0IXBM5R0MPc6i7FiZI1NzwqVl
	 FBJzF7VQ4FxrT1hJOg2KKqwHHVq40dbF0bJMSA1n2dL1ggzbTOD+TcOtYKLoWtVy8a
	 TpxAPvqGv21ewXnwSWdveGPzxr7Kj/YZBhg1O5ew5Je+JlL0gOamPooeEXqEUwDypU
	 KeI28a7AuaIYimI2wb3HQYbPctRq4j/1vTFUsu63Ff1uAblJbfmr8X2KGsOx7V7zT+
	 jUEBZwYY781yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC87C3811A53;
	Sat,  9 May 2026 15:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <ee1f6b28-44c5-4567-a5a4-273ab31cf56e@linux.ibm.com>
References: <ee1f6b28-44c5-4567-a5a4-273ab31cf56e@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ee1f6b28-44c5-4567-a5a4-273ab31cf56e@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.1-2
X-PR-Tracked-Commit-Id: f583bd5f64d40e083dde5bb22846c4d93e59d471
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf0e022821fa516cd6eb0292fcb4ccdd4e201c9f
Message-Id: <177834121523.1109995.6964480963723772486.pr-tracker-bot@kernel.org>
Date: Sat, 09 May 2026 15:40:15 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, atrajeev@linux.ibm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu, krzysztof.kozlowski@oss.qualcomm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, mpe@ellerman.id.au, nathan@kernel.org, naveen@kernel.org, npiggin@gmail.com, ritesh.list@gmail.com, shivani@linux.ibm.com, sourabhjain@linux.ibm.com, tzimmermann@suse.de, Nicholas Piggin <npiggin@gmail.com>
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

The pull request you sent on Sat, 9 May 2026 10:47:30 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf0e022821fa516cd6eb0292fcb4ccdd4e201c9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

