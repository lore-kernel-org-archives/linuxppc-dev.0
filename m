Return-Path: <linuxppc-dev+bounces-20322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8292FCD1297
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5fhN584Fz2xll;
	Thu, 30 Apr 2026 13:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777519556;
	cv=none; b=azFavau3iqMqnjd8H0Ff5jEYhWuh6uDYgpqusKKWA4HrmcpMvC37G3TXoZ0clqUEysXLhXD85a8UZioWioYD0sNMPv5YrBn43UMRCyVKVAovtalBIhsDXo6LZyTaIm28UkxugAIH7kGz7UpbVV2aZlLPFUW9z3NQ898M2/NVFPO1Os5Yd1BiRLiUvgmnCgLfG+y49N49yc81s7HO/j+/ITPVZ40cq0hepWhQcJpU6AVMLjYX3iBUKPkSrb11mul7j2iTqxs+luV/pUW1hAaH6aUc3Sq/l7nrd3JPzwN9xmNjmAYe7CypGAFFWLE3atU8jPA4y1HnYIF0aQy20pyStw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777519556; c=relaxed/relaxed;
	bh=9h+2+l6YOgSv4xQuuSp6Pxc+vCf1Cm2WPNMAxO5dvrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwxaLmGuJYnXvAWxIXrPHQFmZEFe9/zlx5QRQAv+8sEcYBY9yJY1gXZz5xV4eSSvFv/mWY315Xb65PvCHhymh0LV25IHPpN16Ko+TRJBN2mGTBA0DvTHvUmjJdteO6KVJqhUojhQCLmf8EDsquUQMhocT+X6xJSstsToOSEWq9cgwUyrxTE6W0evVaFTkGLO+TrUKJdvv4mvF11IjXsS993vsTLBEvHn6DMxG1csn8QHfnDhuCkTw7PDoltX2nglU7k4iAe58VpYQvM3Gh3m9yvKpzKQlBRiXmMjxfIZoueLSbkgZJgHTG2nJjqgPm5rO1PXCzZclhjOOziomRFcfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S3K5G1Xo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S3K5G1Xo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5fhN177Dz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 13:25:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D8204457C;
	Thu, 30 Apr 2026 03:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F0EC2BCB8;
	Thu, 30 Apr 2026 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519554;
	bh=7DUN2QuqQEe+BONI1ESG4SkIz1fzsjbqa3ckTuuKON0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S3K5G1XovhD07R5O5Cfcy7lVvTxvdUAegkMVL4L8Mtzf9fKcNC7CadGfDm94ncYW3
	 /b3gcg0/YcLg9Als2F8ssWaUxHQUhQMOrsInNGp23YyNVEoZesnW9na1KfzAJGwADp
	 KTU1UQLuwoaLC0FxYgCBT9ErRd1+nqtKD6J1vJmiEmkbMPNMtG+lgotURJHsePS61S
	 RLCqfSNYiEnZojyCuQbicPLDo3ywac2PmflqikQdR6Ir9LNvsPRYjNWI6Ol8jDiw5K
	 s6K1opc7+K/SSJ8ToRvLUcMAZC9t1wDEJ2EBfwZ5oF2rytHLJHY/YtizCxlNq2AgJI
	 UMoMxqu7YBolw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0123809A07;
	Thu, 30 Apr 2026 03:25:10 +0000 (UTC)
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
Subject: Re: [PATCH v3 0/4] arch, mm: consolidate empty_zero_page
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751950929.2274119.3965174046465654804.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:09 +0000
References: <20260211103141.3215197-1-rppt@kernel.org>
In-Reply-To: <20260211103141.3215197-1-rppt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 andreas@gaisler.com, bp@alien8.de, bcain@kernel.org, catalin.marinas@arm.com,
 chleroy@kernel.org, davem@davemloft.net, dave.hansen@linux.intel.com,
 david@kernel.org, dinguyen@kernel.org, geert@linux-m68k.org,
 guoren@kernel.org, deller@gmx.de, chenhuacai@kernel.org, mingo@redhat.com,
 johannes@sipsolutions.net, glaubitz@physik.fu-berlin.de,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, maddy@linux.ibm.com,
 linmag7@gmail.com, mattst88@gmail.com, jcmvbkbc@gmail.com,
 mpe@ellerman.id.au, mhocko@suse.com, monstr@monstr.eu, palmer@dabbelt.com,
 richard@nod.at, linux@armlinux.org.uk, shorne@gmail.com, surenb@google.com,
 tglx@kernel.org, vgupta@kernel.org, vbabka@suse.cz, will@kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org,
 x86@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 11 Feb 2026 12:31:37 +0200 you wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches cleanup handling of ZERO_PAGE() and zero_pfn.
> 
> v3 changes:
> * move zero_page_pfn extern declaration back inside the helpers
> * add tags, thanks all!
> 
> [...]

Here is the summary with links:
  - [v3,1/4] mm: don't special case !MMU for is_zero_pfn() and my_zero_pfn()
    https://git.kernel.org/riscv/c/652d12bc74a0
  - [v3,2/4] mm: rename my_zero_pfn() to zero_pfn()
    https://git.kernel.org/riscv/c/9a1d0c738b45
  - [v3,3/4] arch, mm: consolidate empty_zero_page
    https://git.kernel.org/riscv/c/6215d9f4470f
  - [v3,4/4] mm: cache struct page for empty_zero_page and return it from ZERO_PAGE()
    https://git.kernel.org/riscv/c/26513781d1b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



