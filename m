Return-Path: <linuxppc-dev+bounces-23003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D6CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmpXr28sTz2yYd;
	Fri, 26 Jun 2026 18:21:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782462076;
	cv=none; b=L9OwEg28UdUBZh6sf4UCtekCO7olOn21wLTJDYOaQrqqF4s8a+sZQYC71qUCiot8/3dxV6WveVvg6emhPHjfWPKdxY6kynPwURNMux0LFx12RjL7KN3H1hwhZyWNf1Q7L3bqnCP8mjQhXbrjCBJ/vyZs0kvYZQ7Cq3+WaHtQffTcwpAiJ4k9nmFkuF95EYawgOaMH+d5Un5ob0xwTC3/afyFsP7KHwBXmHyyy0BrdGkz/sPpK3bE/w4UejLZr5atwAv+ePwwwZfek31yB60sHtLeKkCrpOHw3n5lwkVKV2gaO49MN8PCAfka0m3uxuJhmjU05lzPH3JbFLArehPDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782462076; c=relaxed/relaxed;
	bh=iV8Y1qpbWig8yFM44HizyDZ9SD78GLMuCnUipxKToIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jm+zh8nKES4qefm/h22o+QgQPegunVWC+Pd4NkehkQxNyyth3p1zZEmmMpb98+B458mTV9nisn9ZOCokX7DqsVBMDvguYmbqfNnqrXlH1n8x2sD6/HPFtxnsW4f/6nmrAJcyED4X+YAyYGeeCWuukfuZZUXFC4xbvqiNiYkuwF/Xz5LkCDlmJWErlbEFithQBYCY6thjWEm5catdnEKBwCEpr5g419s3dbbqr/GvGAAkgRC0b07609Lq17Kx6dh6bFVbODERn5dbfgeeG4Qp4xg+PVqGq8362Ef4Khl85PLUby+WZG7X3fGn8MrsD0T3lnw6kMykCFKGz6Jgw1sTbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRNylShy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRNylShy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmpXq1Mlfz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 18:21:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC36B6020F;
	Fri, 26 Jun 2026 08:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F631F000E9;
	Fri, 26 Jun 2026 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462071;
	bh=iV8Y1qpbWig8yFM44HizyDZ9SD78GLMuCnUipxKToIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VRNylShyN+OO0dqReJbUBK5qFI1f6x5ouAiqFCYrkYYUy8b1gMx/LM0S+wdPJVGQF
	 jJ/q0NoPAVrPkfBKALquiLSi66MRTNQPndo+znqjmDQLg1xvBKHoopICntwZGcuu8X
	 ikLcRHzizfC+yRm+bZ7OqmquLsXsx3wcYGymB8+hC4hw6j6FB7rvlCxdjjIDW9i03i
	 E/eIBYBNSh2a2AMpC34HSlEWm0jMor1n5uqlth3PC9c/0gDQf2WRm6QHi6eYZoWMYY
	 DrTngTHNnd66HVz+Vov38qbQvIoPF2E9rhyCjS5TazDwiUUoPzl699cy+/S32kavM1
	 FKdrOosJGm0+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0B39389E8;
	Fri, 26 Jun 2026 08:20:59 +0000 (UTC)
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
Subject: Re: [PATCH 01/18] raid6: turn the userspace test harness into a kunit
 test
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246205852.3816447.1024923704586855592.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:20:58 +0000
References: <20260518051804.462141-2-hch@lst.de>
In-Reply-To: <20260518051804.462141-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 herbert@gondor.apana.org.au, dan.j.williams@intel.com, clm@fb.com,
 dsterba@suse.com, arnd@arndb.de, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 18 May 2026 07:17:44 +0200 you wrote:
> Currently the raid6 code can be compiled as userspace code to run the
> test suite.  Convert that to be a kunit case with minimal changes to
> avoid mutating global state so that we can drop this requirement.
> 
> Note that this is not a good kunit test case yet and will need a lot more
> work, but that is deferred until the raid6 code is moved to it's new
> place, which is easier if the userspace makefile doesn't need adjustments
> for the new location first.
> 
> [...]

Here is the summary with links:
  - [01/18] raid6: turn the userspace test harness into a kunit test
    https://git.kernel.org/riscv/c/c4697486fc23
  - [02/18] raid6: remove __KERNEL__ ifdefs
    https://git.kernel.org/riscv/c/3d6beb659ddf
  - [03/18] raid6: move to lib/raid/
    https://git.kernel.org/riscv/c/3626738bc714
  - [04/18] raid6: remove unused defines in pq.h
    https://git.kernel.org/riscv/c/06d2a66fb7c0
  - [05/18] raid6: remove raid6_get_zero_page
    https://git.kernel.org/riscv/c/885d31423183
  - [06/18] raid6: use named initializers for struct raid6_calls
    https://git.kernel.org/riscv/c/7e91f76a9668
  - [07/18] raid6: improve the public interface
    https://git.kernel.org/riscv/c/35472bc6f31b
  - [08/18] raid6: warn when using less than four devices
    https://git.kernel.org/riscv/c/2790045a62eb
  - [09/18] raid6: hide internals
    (no matching commit)
  - [10/18] raid6: rework registration of optimized algorithms
    (no matching commit)
  - [11/18] raid6: use static_call for gen_syndrom and xor_syndrom
    https://git.kernel.org/riscv/c/10f4b8e2a164
  - [12/18] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
    https://git.kernel.org/riscv/c/dd83de0341da
  - [13/18] raid6: update top of file comments
    https://git.kernel.org/riscv/c/30bf04bd13a5
  - [14/18] raid6_kunit: use KUNIT_CASE_PARAM
    https://git.kernel.org/riscv/c/2175395f76c3
  - [15/18] raid6_kunit: dynamically allocate data buffers using vmalloc
    https://git.kernel.org/riscv/c/d67c25712fe3
  - [16/18] raid6_kunit: cleanup dataptr handling
    https://git.kernel.org/riscv/c/562bcbfcb99b
  - [17/18] raid6_kunit: randomize parameters and increase limits
    https://git.kernel.org/riscv/c/fa0c812c0aa5
  - [18/18] raid6_kunit: randomize buffer alignment
    https://git.kernel.org/riscv/c/8cf0a6c4bb9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



