Return-Path: <linuxppc-dev+bounces-24350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD10C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 15:58:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1vhk07CMz3c1D;
	Sat, 18 Jul 2026 01:58:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784303909;
	cv=none; b=baFTCX7jAheuKgAv3v7cpdp9A9LvAILEDGYvJMpwdknL8JpI2V3BriWJniING/4u09wA2lBCKwJXuOvV3HkHp1VyhR7emMOI+2Q3aZbZRgOXnjnKOsDErvFKq8/MsrKhChUO94+d3FD4qI4gTKaVZeY9Pft3ZAJM7w8TiRHhgu0WcVb1LVCnvWH4dOIInRkWRgQ5Juiiq0MKVSE2wdLkNbZeeXvbWL3Usm1giFOu3y4p94eyZQiBNX9PZdvGiQcbNVQkvUM3kl3ox7CUSNl9f83cyrjqS9zTXJM/oEpxGZxzoRFjqK/O8G14y8OEa/HFqwR42RTL29KBg59RXiv+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784303909; c=relaxed/relaxed;
	bh=cDNky78Ax+2bxijT+XdR4K1/f42IbTC+Qw15KNlIByM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P+6s0Ay9YTJaECBQkX+2zT0ifJb0ac0jGrnkjGZgPr5DDGkZM0DC77fZ4i7JDlnAwWI/TUPUs7n8k3XCZimpJ4Vuggg10yFiZFJfmxn8csRZGGFvUzDjip3tDFU8decGRfjrRNJFgp9vCUb48oelBmVfeRcDxeoBxbmZq5ppHuPTGUcZT+3Y56BcA10WsVNM+tkMGippSjyqzQ4nTepC/4LPBdspx9urBwDdoDp/baN1VX9DKT1Ip/AGh85P79SXjGpsnbMS1zns7VNotBJzFj9uGuftynACfY4YHGH8i9bm5DnTMVG0FEoDJBilq8p+g+HlfAYav+UWpJ7RWU/aJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9eQVkh9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9eQVkh9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1vhj2swmz3c0H
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 01:58:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DB7260A59;
	Fri, 17 Jul 2026 15:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B641F00A3F;
	Fri, 17 Jul 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784303906;
	bh=cDNky78Ax+2bxijT+XdR4K1/f42IbTC+Qw15KNlIByM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Y9eQVkh92uF8Q0EhmGOa10lckjMAQavzMwf/QlLHtschax9pKaydSZREKAgw8xDzG
	 3PX0v0OtzasdYRKcS6uuh9wamiaTUyFWPZpM4kSEzQksHQkE14d+9F1ydTE543PWGw
	 6blg/D5qVbsoI4ybsKfC0xD3nxGE6QItLj2FXEgtUHs2B7uA+2AIHiiiDhp+T0cdjE
	 5kbvD298s1y32znj+UBQWuVv86KAhiXIWHDEIn3t/+ozR9AIsYML1oFtbdz5gz02c6
	 Cc6yr9uCkGtGGJBIZxNHixxChvYEsI/rYA9MYbDRnzDD/GBK7epSJqfUrnReToWuzu
	 C3+trVCUH/ypA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E34380CEF7;
	Fri, 17 Jul 2026 15:58:00 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <65137690-360f-424a-b2f2-b62d5f40ee31@linux.ibm.com>
References: <65137690-360f-424a-b2f2-b62d5f40ee31@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <65137690-360f-424a-b2f2-b62d5f40ee31@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-2
X-PR-Tracked-Commit-Id: a2c02aa0c6ca3ec9fab6f1c99912a440c7b8bfdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6917aa77675f48e7bd33392ed6590c8837001697
Message-Id: <178430387899.1777518.13543830087342458219.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jul 2026 15:57:58 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amachhiw@linux.ibm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu, enelsonmoore@gmail.com, gautam@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, moonafterrain@outlook.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, rosenp@gmail.com, sshegde@linux.ibm.com, thorsten.blum@linux.dev
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

The pull request you sent on Fri, 17 Jul 2026 10:31:13 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6917aa77675f48e7bd33392ed6590c8837001697

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

