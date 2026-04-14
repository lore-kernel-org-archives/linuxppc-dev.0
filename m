Return-Path: <linuxppc-dev+bounces-19746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35880F9D0E8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:47:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw9D52bDYz2xSG;
	Wed, 15 Apr 2026 02:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776185221;
	cv=none; b=gAwcd8OSLnKqx4CDhrWuvrZgLJj9IhIC4iarv8UFjGzKNgbh05SZKLQMkq5BV9P6vdWWXuGBPDJA5FcvZl3xxPR21qncdloIrCj0HmkKId9RmpSbT5bgVPPpQNoZ3T7fW4ow7k4EdHcWnGlIzYH80FCmi7RARbJ/CkD0eg6P54jpCDenIuvGVx9LTMUdPy5GLdfRQPvHKxuLqPXgpwPsRNJ00IKDq3HpCP+FMQw31xpRmJcgoCPksN1OotxwPZG1MIaxNWm7vWJRywAPzcQC9ww2xzUWHbMQBItKo6wKIvvRWSpLpNb5NYWVINIz9Rj9uOCubmwOwlqcqHj970gLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776185221; c=relaxed/relaxed;
	bh=0XpvUWJdPK3It3NjFxZMUgAiv9eSPEerzQWrcf7EaiA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CiX1LlWUj15qUNmLIfGsdCFWN45ipwoFs+BE/d3fmpRtKJxY4BV2md6z5F2Pz/2CDZco+UTnGuyFGQfpmuUHi/he9NKA0ZSq0vGfe+ffTzoWm26WTqq86dOSm/2A/DuJ0yKGa/pssSUF5n3a1iQB8FxErMNsu9mcR6i5mBYm/DzEx8UmukY47goSPsVK1ckEoHqg6JozPM1AI3sfs2sLuFlGGlUWsG/+hOkceq0oNq/wziz8E01jx4fU1NQI8SC4pGZ55Pj10ppZjSMT7MD+1Qu6INKi97nhwlb8CqVR3NSXm6lqawrcKfWml3pZZbkHYT89si70GB7yYvvbK0W25w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M3XzHspl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M3XzHspl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw9D34KxRz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 02:46:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 35F0743C4D;
	Tue, 14 Apr 2026 16:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62CC19425;
	Tue, 14 Apr 2026 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776185217;
	bh=h5CUHLLZGJj1sqfzAOFN24P+lZAUpLgJCzAIP3pIVak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M3XzHspleh86r3vzAE6YUI8iX7fuNondhwJgpVrbrS0Op2mj2wIUHrH6fREXFKsIG
	 pem7Y2vx+7Y7xwcrJ53ciAxItrD22RLU7qrf8Hp2j1xmoJc8hIvngurUvXyS+qkBub
	 09nlGhcwM6sBuxJtfeY0yNha/v0y2nM1OpuMFM/Zr94Pf2tTnISy5Y3xt0Ci2EKXuG
	 vKqkWXd08DrAsFfVL/8q1rNyTPsVxR/M6KO84zqoDqRYb4tOiaVJZBICeda8HWuSed
	 ECCuMdETCSR6E3e0oPEVWgRNlqQU9u7DIt6JDR+Yv+2AaB+z66VFmF1bo5P7C02lT1
	 Sx30d41kHGYgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1313809A07;
	Tue, 14 Apr 2026 16:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild and Kconfig changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <adu-ZyIv47FnsVLI@levanger>
References: <adu-ZyIv47FnsVLI@levanger>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <adu-ZyIv47FnsVLI@levanger>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-7.1-1
X-PR-Tracked-Commit-Id: 404927758daac5ec4594071e033c1fa6ee9ca9b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d0d3623303775d750e122a2542d1a26c8573d38
Message-Id: <177618518744.1376142.6209842916194520385.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 16:46:27 +0000
To: Nicolas Schier <nsc@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Coffin <alex@cyberialabs.net>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, David Howells <dhowells@redhat.com>, Dodji Seketeli <dodji@seketeli.org>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, John Moon <john@jmoon.dev>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>, Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Yonghong Song <yonghong.song@linux.dev>, kernel-team@fb.com, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel
 .org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, loongarch@lists.linux.dev
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

The pull request you sent on Sun, 12 Apr 2026 17:46:47 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-7.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d0d3623303775d750e122a2542d1a26c8573d38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

