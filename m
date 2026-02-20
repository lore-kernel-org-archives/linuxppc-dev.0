Return-Path: <linuxppc-dev+bounces-16978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D3C531F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGy94nZwz3cFm;
	Fri, 20 Feb 2026 15:10:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560657;
	cv=none; b=h5ByTfsvgWJ/nlz7VWmRrARN6Cip9YrQ0MBoShhHq2RMLp1OTlBtBYETJUggJFKwERE0VuX8c9316QhDgWQI2HMzcweZNkgU5VPEq8GoHUxgOBvSWG17dI9Xxv6k2NUF9Qn0QfsmJjxvC+OqHl0QU5cD5N7bIOtwunYFQIvXBNLHH9AxUagLgTZNrSyDuriPtPskkmxkiHcFEpR0iU4dRXmSVLszBXtAUuIJ/20W6s578JzgNlRU27kcwY7gbzn+JthatUXZqQ0mCeWG5pRQ9P0UeG737FCnJYtah2YTxhfn3K5wmfTGUUej8QNZXMHhXzVrDLtzH0H+IxDS5JDeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560657; c=relaxed/relaxed;
	bh=/A0Yxvye63cj+hpAab8QOVcalyFGH3t35eHSGcH62hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JiVNP+7alo7xUNQY8L1strFHXQ1noaLYZhH/2gnQGqsAFRALGQG89L27JzQjsyqH9nN4ISloehUCOHNbMBE/Oi9et7yZawqdNKSqVwRAY+eMJs3PzmjWUHii7ZHcmwUhKLsasNlNpHKDmHmcVPWkVKTbGpPDxCYO1nxZjkcaKU2xxTuQfw9Y30u4CMC4hJKPkVFFegU0AQMFGeuASrjRgUMWlVkQ1pnx1MvHDZOoJppkNMpQwc/Ts5qyMoAsXdxEX7yBqw4Z5VYa6UwntHSmaYjEiWZy9JnYtbKBD/oo5ewPRQMMrqH8jvJ/SYUdyYsblxUs/ZZkU6ndo8vpoXK5OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N1VrZuK9; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N1VrZuK9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGy85pC4z30N8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DA55A6185D;
	Fri, 20 Feb 2026 04:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD7FC116D0;
	Fri, 20 Feb 2026 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560654;
	bh=Wl/q2I9MW4EAYAIqkkPs9cMuPySyeP7Ys0yLcRoxiik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N1VrZuK9lrvi+0jv5UrnpCwpMzW70T8EtjcsHnyvYb/C3ysXhXnwcXh0J1BUrz/fQ
	 FXvJgc0MX5grtuvCDCjFOveYmh43k7YKrhJKjA6KNPY5GbthY3tSAB5Rd8DWyI60O4
	 60LGpZhdpz2TPplFhz9GOt22IkO9j9SafKfb23NhzY6Pqtbyy2AyC4nRduEnajg21H
	 pPrMunHoqFuSELpIJz/FNzbQUBVTQ/4/r5X9keCr5k8mekJQPLFSEN/1VTk4FKKX96
	 mGvQFqOn+07PQ7stZW8usaIlrYxFaew9yX4CoBIDJ2elY6T+mswJuAAcc8jX+e9rPf
	 2Anz+jmhWYL+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEBA3809A88;
	Fri, 20 Feb 2026 04:11:04 +0000 (UTC)
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
Subject: Re: [PATCH 3.5] arm: make initialization of zero page independent of
 the
 memory map (was Re: [PATCH v2 22/28] arch, mm: consolidate initialization of
 nodes, zones and memory map)
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156066278.189817.13783312336351868850.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:11:02 +0000
References: <aVpWpLV4Dut5Muo2@kernel.org>
In-Reply-To: <aVpWpLV4Dut5Muo2@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-riscv@lists.infradead.org, klarasmodin@gmail.com,
 akpm@linux-foundation.org, alexs@kernel.org, agordeev@linux.ibm.com,
 andreas@gaisler.com, bp@alien8.de, bcain@kernel.org, chleroy@kernel.org,
 catalin.marinas@arm.com, davem@davemloft.net, dave.hansen@linux.intel.com,
 david@kernel.org, dinguyen@kernel.org, geert@linux-m68k.org,
 guoren@kernel.org, hca@linux.ibm.com, deller@gmx.de, chenhuacai@kernel.org,
 mingo@redhat.com, johannes@sipsolutions.net, glaubitz@physik.fu-berlin.de,
 corbet@lwn.net, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 linmag7@gmail.com, mattst88@gmail.com, jcmvbkbc@gmail.com,
 mpe@ellerman.id.au, mhocko@suse.com, monstr@monstr.eu, muchun.song@linux.dev,
 osalvador@suse.de, palmer@dabbelt.com, pratyush@kernel.org, richard@nod.at,
 linux@armlinux.org.uk, shorne@gmail.com, surenb@google.com,
 tsbogend@alpha.franken.de, tglx@linutronix.de, gor@linux.ibm.com,
 vgupta@kernel.org, vbabka@suse.cz, will@kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sun, 4 Jan 2026 14:01:40 +0200 you wrote:
> Andrew,
> 
> Can you please stick this between patch 3 (arm: introduce
> arch_zone_limits_init()) and patch 4 (arm64: introduce
> arch_zone_limits_init())?
> 
> From 35d016bbf5da7c08cc5c5547c85558fc50cb63aa Mon Sep 17 00:00:00 2001
> From: Klara Modin <klarasmodin@gmail.com>
> Date: Sat, 3 Jan 2026 20:40:09 +0200
> Subject: [PATCH] arm: make initialization of zero page independent of the
>  memory map
> 
> [...]

Here is the summary with links:
  - [3.5] arm: make initialization of zero page independent of the memory map (was Re: [PATCH v2 22/28] arch, mm: consolidate initialization of nodes, zones and memory map)
    https://git.kernel.org/riscv/c/18b7cc70dea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



