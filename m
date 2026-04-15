Return-Path: <linuxppc-dev+bounces-19747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C40F9D0FB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 00:16:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwMBH6zyPz2yrt;
	Wed, 15 Apr 2026 10:16:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776212167;
	cv=none; b=PoJmK7tovN/tZeguEVupzt1/b5Zw9e3tmrpLp8R+clyJXKMfJkndB2rTvMw+Vi83oyJjViFMJk9+rAlU6rXt+DMJdw2KSdHWArL3APhZwckV05csHA7Z5nZtQMnTp/7pcJm7bpmfGwpJYejvQOrL84gWWVw6tgpyKiWPaZM9ZSX5XSrGBd5A5LtSsQ2ZKtSbNsi5x9SmOJWS2AQaQGs7sdjzrBXnIUsTPVet0TRFhSnx+DRGLOouhKCI5FnIdNY+4UgAXJQikzl6VJVssiHAPKeGIwxY7fF8wuQ8JrrvXyNMz7eYOOHu366sMu3UjcjmA9ZutcBq0KPXQdv939ZhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776212167; c=relaxed/relaxed;
	bh=3JfaEoJMI+xMRk7u1BtSPnoN+G8uVXvoFfsYfx94sUA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gAE90acHpDEegsCtXbjUz/z8TPDUdRZEz2gAETx7LM6kj3vBNbKkx8ckodY3Fgmr2Ll8Shtl1W9r3NVd8ysS2nhOjUomY1aM98doR4MFSW0Evw8f1PKOlxgv2CP788oQ4xMf2/9khI+fT/VfQJ0ehNgHAb2zgc2laFVDLbJ+P8xkzisHddWJjp8GZiZCPvoiFVQt8h8rjKlMWRhgJNe5Ft4Tb/lDLCVgPjzTYqAItEyaUy+vjF094zMxZh1N1cgWBBNfqC6HUYcsulqAN8uEOpQcRZKbdLdMmRk5MCy0BnHxOgRVpCDaJpd/ArzNVRQ7Ah80eDEYXBLb8c4O4fTYmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E428kDmH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E428kDmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwMBG6Ykvz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 10:16:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0994560135;
	Wed, 15 Apr 2026 00:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4DAC2BCB3;
	Wed, 15 Apr 2026 00:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776212163;
	bh=ZK/tZ9kCD4cyJL81lgf7UFcNq0EtKCDO3HK2E3Kr9OM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E428kDmHFmx8TwWoHrw02RyerezSSlUfA3rGOwrT3iTrLtzwzchvKWi81B0+6JML/
	 kuIWM1cQdJ9D3cDQWCSjBavrXG0poGHp5VhCBzMLELC58QJy0/5qHTK7FGy5ss1G4e
	 TD+bd3C5iKNxN8f02y32YNsZYvUkiTmvgn6Ia6NC2enCDeqEDqj17HyXVTrEU4xXkt
	 FO+2Jf+7TcMvl+9bY2aX0LtADP0ZGPeyL7CTZUNtAdjeA6rpv8SOqfBkX7R4h/9NNI
	 70HXX4q9/uZVhMot/HfzG5MOnwR3Y45qhCOQUSOMvNZU5GTXPqX+8YvmzXmVZuWDOF
	 3MayeNyAykYRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD443809A29;
	Wed, 15 Apr 2026 00:15:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <f027ade2-63e3-4d9f-8737-eaf295c8535a@linux.ibm.com>
References: <f027ade2-63e3-4d9f-8737-eaf295c8535a@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f027ade2-63e3-4d9f-8737-eaf295c8535a@linux.ibm.com>
X-PR-Tracked-Remote: https://lore.kernel.org/linux-next/ac_R8cR5A-YtcRpi@sirena.org.uk/ and
X-PR-Tracked-Commit-Id: b80777aef570ac561977d7210d04890f9df7e484
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3203a08c1266689c204fb8f10d6bb5186921fce2
Message-Id: <177621213382.1531497.9208431498905554458.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 00:15:33 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, adubey@linux.ibm.com, ajd@linux.ibm.com, amachhiw@linux.ibm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu, hbathini@linux.ibm.com, j.ne@posteo.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org, nichen@iscas.ac.cn, nilay@linux.ibm.com, npiggin@gmail.com, rdunlap@infradead.org, ritesh.list@gmail.com, sourabhjain@linux.ibm.com, sshegde@linux.ibm.com, ynorov@nvidia.com, yury.norov@gmail.com
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

The pull request you sent on Mon, 13 Apr 2026 19:50:25 +0530:

> https://lore.kernel.org/linux-next/ac_R8cR5A-YtcRpi@sirena.org.uk/ and

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3203a08c1266689c204fb8f10d6bb5186921fce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

