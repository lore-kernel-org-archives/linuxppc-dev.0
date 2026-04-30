Return-Path: <linuxppc-dev+bounces-20321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B51FF8864
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 03:25:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5fhG1mChz2xnK;
	Thu, 30 Apr 2026 13:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777519550;
	cv=none; b=Zf9hoBn2g8c+xRHdtzsyzzkuokTUsjN3j2T0mZZi7C33SI5rqEyrxTWH7aauW3Yqoc3Uwa6HC5l0Ufd5my0otb1jaVWsWhr9W7bdWQTRq6WWh9vw6feYq2m1cVCUicM8vawbjm32j8SbKo03uIhWehZX1f37P+PVJgYTtoAMVMOCg8kFHKJkJ0B7j3A9LaAsPgn1wDfrsroovATm07/mHrYiIASRqmPoGVTyQjPPz/5PULd1mQXEQ0pb0AzFYgdbu4DHf5N6VPRJXFcBtpPZIV2Woiy+hBK9rZti7U4MA6ptX1jEuSJebRCJAdac11GCzwT8UdaolPzbMaWcbjYQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777519550; c=relaxed/relaxed;
	bh=e5TaI9M8cOEzzxA3yKmeoFjtnYXZChCt4lKYDYwQv14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ioYak0CTVz6TmKQ377HT3yk3sjP4iEb1f+nhwmo+4LlmCZ1LP9QO2WKqQ3rUB9KVXU9h5ZnvLzEfG6ZdR09JryV1ci2Ga93T/ZNgiBfwGjtFiMcF65BBvlvq6VkhCMBZ4AzdWP0+PJm0pcndRkc3JWP9ubkG7nMYRpHZSFq+U9BowhifGFy6KanZGwRMtGRzwgCc52tGkBBZKw+ntpuK1Aok5rYGZVJRKaHQtLSrYUppbQSNb9YKpBEHMXXQi9EG1ekmRWsf8WsQHP+ycu3fSltWpkDWerihVVhl8d7gNriHs1sqndhY8aQbeIcMbepQop2ujeMCH9mWYtO3DlDb8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oK4W1kKQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oK4W1kKQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5fhF48CSz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 13:25:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 146F844455;
	Thu, 30 Apr 2026 03:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE62C2BCB9;
	Thu, 30 Apr 2026 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519547;
	bh=dFN6b0A1gSAjmpxBdfCzLd7sjLkkLRUt90cBNTEzJS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oK4W1kKQ5frD7xBp2Peo4k+zymjuUiJnLNz1vcnh5EFW4Atm0o1eacKZFX3kxsdMB
	 Z/9Bybkbt3e4DSKls2D0XjOElY/uAFwJmkXI/D33yiz2mgpn1fh1pHq8wwtdcupk2H
	 lxsRxcmcLT6uUAPcxQs3YzTqZheDJf8qP4uhFGhGgLv/DTlHLkFL3nUxAt6MFMm3Wn
	 udAWzPlFVeqX0qf5lNmUGifS42MtZaKyGgO3cIqnJJYyJsJWf51lM0MqpG8QFB2ry2
	 1jlaoCGMchkNV4IFNSmAKO5kJWwGEnpPKMc5ZEWOTjjRj0oKTos1CMGgTRvfcPXQMF
	 j0NI9CkIJOSPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA63809A07;
	Thu, 30 Apr 2026 03:25:03 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751950193.2274119.6306882784421764696.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:01 +0000
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
To: David Hildenbrand (Arm) <david@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 19 Mar 2026 09:19:39 +0100 you wrote:
> While working on memory hotplug code cleanups, I realized that
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.
> 
> Changing that revealed some rather nasty looking CONFIG_MIGRATION
> handling.
> 
> Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
> option and reducing the dependencies that CONFIG_MIGRATION has.
> 
> [...]

Here is the summary with links:
  - [1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
    https://git.kernel.org/riscv/c/078f80f909ba
  - [2/2] mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION
    https://git.kernel.org/riscv/c/6ebf98d71f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



