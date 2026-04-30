Return-Path: <linuxppc-dev+bounces-20324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA434FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 03:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5fhm0vbvz2xlV;
	Thu, 30 Apr 2026 13:26:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777519576;
	cv=none; b=lbQFI3AE/dTQlUXR6taAqmanwR2wkhR1t7oJjfiLPX1nHBamz343Szpvso+j8MnRSppZo/p2Ez+iwftEqWYEBjBFwmNtV2hCA3H6aWZeHJ/e8Fpq0eRR2KvGAbwzcYdKp2UZAQ6l2G88Q7yFCwELIU4HXIPGHW9cLhlNCLFKXKp7VTXM86uJxP0HzKmyK4ixbW6P/5QDPETft2myjC6WbSSoQ0Dzy2ORFbWsBoPTa4Fs/8wmlC8GrQIcCdMyZ+2Iv69VC0+/evk2dtZEmncD3ms9kfXLwC6psz4NmtezjM1yxl5jE7zR0jduQqyIWe+47NBPpfGN3ZkynfIWO1EVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777519576; c=relaxed/relaxed;
	bh=nRKDvhma8zGHa0oYTz5d0LzjmXPDEY1Tj9qizpdFp7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=abptrxUUsWvKFL6bbkqaXLjeQTGLARDq6jtHBEipJlfY21/Yc2RITTmDxr2Rds/nyimjsARi6pjoElRI9kJ8QoqeZ6IcR0/XLzvrFaekLHBFB03e3vza1kh1vSTrsJsKWxzSY3gq6RUnp2RexiW0sdyd158bNoWs+bYmyQqt3L7XkcE331/Bb7R0PC0FBd4ogD5WCZ0PxtekFCc71BosRGU93Tw5Ch7WTgLbKNPYJQ5yKNu/QENr8yHJVfUHCaTWJCb9w+6bCZGTVUUGapoN83eVqhJt3QWKamroQnnQ2jyOWfAVd4AHjdkZEyt8PpoCMtgtN7zBjEQMTgsOToZKyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzTbqLo/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzTbqLo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5fhl43x2z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 13:26:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09BB443B2D;
	Thu, 30 Apr 2026 03:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB14C2BCB9;
	Thu, 30 Apr 2026 03:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519573;
	bh=THrrdSGjgRzaSbCrGespfxo5C/AWLl4KlIEGbaUs1N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzTbqLo/5B2o+wNCv7hc433OYzKq4siikxTyngUKDMF3HAeUjhBhAk77XupcxRUvU
	 8AQeEfOAPdqCa9Uxdu60usplkxVCGl2lAhF6QZOdLWIjERQA7vDLeINPZy/5ERe7Wc
	 ghiINRi89Td2t+djUJI7HVkMnXuK1rdp0d0YYVr2nHuJNC05bQejhStGEvFx6LEv4v
	 Q0foheq2svz+12OFi+UHX6I/M6rycHRVU+nwE7Bew/REJdDDUJFX4jYb42DVn24wgZ
	 Adw0Roiy4+syrE/ThlZQ2sCXbjShOe4cVpKtA73HBp9XxbgCtMQ6+9J8F7NCLPpp9Q
	 EzM7rlb9XVxGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE533809A07;
	Thu, 30 Apr 2026 03:25:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Fix bugs and performance of kstack offset
 randomisation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751952875.2274119.16398594062786998071.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:28 +0000
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, kees@kernel.org,
 gustavoars@kernel.org, arnd@arndb.de, mark.rutland@arm.com, Jason@zx2c4.com,
 ardb@kernel.org, jeremy.linton@arm.com, david.laight.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Tue,  3 Mar 2026 15:08:37 +0000 you wrote:
> [Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
> good to get some linux-next testing.]
> 
> Hi All,
> 
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] randomize_kstack: Maintain kstack_offset per task
    https://git.kernel.org/riscv/c/37beb4256016
  - [v5,2/2] randomize_kstack: Unify random source across arches
    https://git.kernel.org/riscv/c/a96ef5848cb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



