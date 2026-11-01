Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A096606A327
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLtzwK85
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHq0n3brJz2yMP;
	Mon, 02 Nov 2026 09:15:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793571353;
	cv=none; b=ZHEO9j21Q3qe3L71zkUxY/EmdWTCX0/o/Db3Y3QfEUJH9Qp9K+ripY0/Aga2BnlxgxzX8kFR83O1fiqq3DNWJb9Jad46ACI0lO16N/XtpjIW4XQbgMUXKthBPuiG8Ilc7osSkh2jjywjAjwrkfjH3CsrI8nrK4jHnI+rCzCGHafPhNULP81ff6OZdIAzW3NoQaeIkHWUf/YRaTA8B1SxKuAt+a14rDNE3iiWupXf3Fnno+xKyrZmhP6/OvFdyaGOg3PjL0GvplE55xI7eENu/f4FD+iggmfjg/FGEsJvSaNHWXvGepFWMANTkDZym1wJh0j7zSxej4JPB/qhMTgV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793571353; c=relaxed/relaxed;
	bh=zWjchA1R3k2PWinfdPa1bmSSkYcmsFonhHSsoHtMyf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWnbe9Gbdk8+5gvAWbyXtcvsKZDy5RKji6WeIt7G75VtoNe7xP2vxyfyjtRoXGprMSLwbn8pZjX7O9MZ38X7pqTIMfsUXlVhoRapdFz8hrtsmkl2Hav5IJ4AVJBRRSiUxyS+tn2GxSknXk/70OD1lY2xOrs+OAsGK6VB+hE2zWSS6T9dLIRU4cDSv3749ONrLoRwR1PRkAZMxUvr8YwcEuhGK+HD/lk7wg1T46xK4Dn4NWlT5eVmh3Rqmm5hfoBJ3L4ueJzyAHL9SmQ7YjAMmx3IrgyLdnOtSBPgTz7tiyPImaBTnD4ZO6BZelargZ6yrwUMZ2SGqw/6wPDKv5BfPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLtzwK85; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLtzwK85;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHq0m3j9Hz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 09:15:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C2CE043EBB;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672C1F000C1;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571348;
	bh=zWjchA1R3k2PWinfdPa1bmSSkYcmsFonhHSsoHtMyf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YLtzwK85l4hGxLyA70UvP4j1W3M7aK0AnO65y/AzsiFBwFu+o+am4lM03VbtHtJ5K
	 SS29sY8vrSYrA6jdvWzfwe5K90LxJtzoHxZZu0mTSUAvpZkN1PYLCGRsEs6UgYx0aB
	 97oKuIhcSNLzzTU7IsY2JDbPwHgALU8UUMTUIacoZU37AQpC6KtulGbzQ30fh/1Pj7
	 439Gr0UJypJlNRfMtvA0ZTTdkqVe4hPq7HarsqK8Usmvu9Wk0QYv2Bnam4S5juFWnH
	 d/jArMh+zoyROvtkvZe5ytr6PBXG3TqNVsxhJFaqiJVBj+Botefdp40TKRHbDajTSy
	 ztyxsj6TJTA0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D5C738003B8;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/15] vdso: Clean up the vsyscall.h headers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357134704.2624073.7289302544673229273.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:15:47 +0000
References: 
 <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: 
 <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, luto@kernel.org, tglx@kernel.org,
 vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@kernel.org>:

On Wed, 09 Sep 2026 10:51:13 +0200 you wrote:
> The vsyscall.h headers are a mess. Some of that was necessary back when
> some architectures where not using the generic vDSO infrastructure.
> Now that this is not necessary anymore, the headers can be cleaned up
> and many of the can be deleted altogether.
> 
> The recipient list is trimmed to only the vDSO maintainers and the
> architecture lists.
> 
> [...]

Here is the summary with links:
  - [01/15] vdso: Move the kernel-side time update helpers to a new header
    https://git.kernel.org/riscv/c/35f0a96848a7
  - [02/15] vdso/gettimeofday: Define fallback __arch_get_vdso_u_time_data() in gettimeofday.c
    https://git.kernel.org/riscv/c/4fba7bb3e73a
  - [03/15] vdso/getrandom: Define fallback __arch_get_vdso_u_rng_data() in getrandom.c
    https://git.kernel.org/riscv/c/ca0da001d3cf
  - [04/15] vdso/vsyscall: Define fallback time synchronization functions in vsyscall.c
    https://git.kernel.org/riscv/c/e4eeeaa14d8d
  - [05/15] vdso: Delete asm-generic/vdso/vsyscall.h
    https://git.kernel.org/riscv/c/8579b901d150
  - [06/15] x86/vdso: Move vDSO page definitions to asm/vdso.h
    https://git.kernel.org/riscv/c/8051a0f482e6
  - [07/15] sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
    https://git.kernel.org/riscv/c/782478555fc6
  - [08/15] s390/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/d5b1dadd2ef0
  - [09/15] sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
    https://git.kernel.org/riscv/c/cc729f844815
  - [10/15] x86/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/3086b69ee00f
  - [11/15] arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/128b1c7d3ac8
  - [12/15] riscv/hwprobe: Include vdso/datapage.h
    https://git.kernel.org/riscv/c/0d10af5db481
  - [13/15] vdso: Remove unnecessary vdso/vsyscall.h includes
    https://git.kernel.org/riscv/c/d6df494a0135
  - [14/15] vdso: Add asm-generic/vdso/vsyscall.h
    https://git.kernel.org/riscv/c/996b01393e93
  - [15/15] vdso: Remove __ASSEMBLER__ guards from vsyscall.h
    https://git.kernel.org/riscv/c/9e61cabcce2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



