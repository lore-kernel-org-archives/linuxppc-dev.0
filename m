Return-Path: <linuxppc-dev+bounces-17778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AED0F33A8C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2026 15:17:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRY7n3t8yz3c5f;
	Fri, 06 Mar 2026 02:17:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:19f0:5800:8dea:5400:ff:fe25:676e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772723877;
	cv=none; b=kPmGB1ii8/jKdbptPPLup3MpvwJxnBzLZxlZ5rkvIu5OVVIBKt3MRLGxoaNs0EZ9BlAmqrWrAA0vA93nGXkbSmVCzmV9cV+FcJWNRLJzrIwdDHXF7ArKNu+TdAjDk5gdziwB6pwIo2o217q/n+TaMt9PZngd1n8GJqxs+j3WBLw2WKan/D22RE7eIe/3tMVTmLILq7H6JBJjp8C4Xe2I1bcBMUdaVlGKwjCQMEWSMaTPGITcrSXjHoqq4+xp10n457jjJ7y7oNelN5pP77pwxueNYAKWpaQkrX+VERy2ZStP7GSS9Juj8e8U03bkVA0ksBcdcpRhsNlKKId+SUYmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772723877; c=relaxed/relaxed;
	bh=3lgPzYY+h2rxgMib06rpA2OEDOgbBdmE+X7ijJayJaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOdTy6IwLmPjFQjR/QwQKBXyejeFOl3LdngwL7Dhxwep6Vc0itjFzOCCAFGfij+ekD8waQW2/FKRV/Bcq9+Ufc9Ax2zJ4w6Ukxx+3KYWPQxzS+R+bfTxOjjVXOiUWwYii0rfIL7P9ohoOxsZAoyQl9BXvRFe0IkuBSdVoY+u8NmuA7QLr/7IO1Qz6MA98aZ89P/YhICwRecmoSj+Mi+JdPJmP+fCqB2h/4bfTtc6i8u1KRmO5o5M3VhplbfTK+4PNyCnPM+/nI0Jb2W26uHfiL1LGVsXdioDATdTCDJ6XhhyzolfvHVMWqWU97UxpYM0hyYJWJq3PNrv/DGEe+HA3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au; dkim=pass (2048-bit key; unprotected) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=eNIoCpsC; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=eNIoCpsC; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=j6HEjp58; dkim-atps=neutral; spf=pass (client-ip=2001:19f0:5800:8dea:5400:ff:fe25:676e; helo=arcturus.nroach44.id.au; envelope-from=nroach44@nroach44.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=nroach44.id.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=eNIoCpsC;
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=eNIoCpsC;
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.a=rsa-sha256 header.s=dYX2HNEqNNRL header.b=j6HEjp58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nroach44.id.au (client-ip=2001:19f0:5800:8dea:5400:ff:fe25:676e; helo=arcturus.nroach44.id.au; envelope-from=nroach44@nroach44.id.au; receiver=lists.ozlabs.org)
Received: from arcturus.nroach44.id.au (arcturus.nroach44.id.au [IPv6:2001:19f0:5800:8dea:5400:ff:fe25:676e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRY7m2ZN9z3c2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 02:17:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1772723870;
	bh=YYARtrHKCTb0FOK3T5y+Ihj4HwkDUufhHFrwTteinjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eNIoCpsCmsx825Za9IFJ7s0I472lULyOz5PMvqBsBM4bUyw8UbVikO/eR4eBjHaYz
	 aBNoHiEGCzhVSgbDLSHcSmG9Buj8J+JEI+8umr/UIJyKBNr86XVzsTYgiigXcMbD73
	 H7Yr8+9Ps5aeArV6P7KxzKhGzg3vVqoXM6lCwYIp8zgVl/q6mSJk8eA8LVxCHgMVIc
	 D+ureejQ9r1yGCGeoHoyX0GMQnFW3YvYP3iGtwhvNzk/gkVlCJ9lfrh4rRtb61Llwk
	 7TRbYaKbfpOXzpuExp2A5UtixSL5/0I6yIuCAV2hphFmzBs5ofIsPIV2So1iNWioDf
	 YyyUIk+WVGYrw==
Received: from arcturus.nroach44.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPS id 7849931157
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2026 23:17:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1772723870;
	bh=YYARtrHKCTb0FOK3T5y+Ihj4HwkDUufhHFrwTteinjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eNIoCpsCmsx825Za9IFJ7s0I472lULyOz5PMvqBsBM4bUyw8UbVikO/eR4eBjHaYz
	 aBNoHiEGCzhVSgbDLSHcSmG9Buj8J+JEI+8umr/UIJyKBNr86XVzsTYgiigXcMbD73
	 H7Yr8+9Ps5aeArV6P7KxzKhGzg3vVqoXM6lCwYIp8zgVl/q6mSJk8eA8LVxCHgMVIc
	 D+ureejQ9r1yGCGeoHoyX0GMQnFW3YvYP3iGtwhvNzk/gkVlCJ9lfrh4rRtb61Llwk
	 7TRbYaKbfpOXzpuExp2A5UtixSL5/0I6yIuCAV2hphFmzBs5ofIsPIV2So1iNWioDf
	 YyyUIk+WVGYrw==
Received: by arcturus.nroach44.id.au (Postfix, from userid 5555)
	id 5C41C31153; Thu,  5 Mar 2026 23:17:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1772723852;
	bh=YYARtrHKCTb0FOK3T5y+Ihj4HwkDUufhHFrwTteinjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6HEjp58CAncqr+uwXPGkZ8lbR369/LG+98D/0XTHkVG3l29sNkU52WgCB9M9dhew
	 gfYeHT+jf9fW3OfG/GF2ck8167gHXSBgmfi6zT9ikR3LMg0qsPoY8nZSWjrMI8OJMj
	 kMd1y8ytlCPRepikIB3G0QISj/p2xbEqBa0pK59UYEzty8JgqZBIuj16Yj6eh2Rwin
	 RqmxUyGdqP+iWTSqkWn4TEleHa5tBEEY1MFUvIEGuDv8GfTrCrGQcMjfyPuSXM+3gd
	 YedViadoD7BXyM4xh27Cob7Y7tDuZ5rBOkg4Zdw1yQSY4SCVwDPQ2Y427CbPT0C5YX
	 UV5C2DMMj3FPw==
Received: from [IPV6:2403:5814:4228:10:6097:a659:11f5:50c] (unknown [IPv6:2403:5814:4228:10:6097:a659:11f5:50c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPSA id 3DB73308D6;
	Thu,  5 Mar 2026 23:17:30 +0800 (AWST)
Message-ID: <9dfc93b5-8269-4c72-aedc-2a1d5311b4a5@nroach44.id.au>
Date: Thu, 5 Mar 2026 23:17:28 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] sparc64: vdso: Switch to the generic vDSO
 library
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>,
 Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>
References: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
Content-Language: en-US
From: Nathaniel Roach <nroach44@nroach44.id.au>
In-Reply-To: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

No (new) issues seen on SPARC T5-2.

On 4/3/26 15:48, Thomas Weißschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
>
> Make use of the generic infrastructure.
>
> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
>
> SPARC64 can not map .bss into userspace, so the vDSO datapages are
> switched over to be allocated dynamically.
>
> Tested on a Niagara T4 and QEMU.
>
> This has emantic conflicts with
> * "vdso: Reject absolute relocations during build" [0]
> * "vDSO: Respect COMPAT_32BIT_TIME" [1]
>
> But I expect both other serieses to need more discussions.
>
> [0] https://lore.kernel.org/lkml/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de/
> [1] https://lore.kernel.org/lkml/20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de/
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nathaniel Roach <nroach44@nroach44.id.au> # SPARC T5-2
> ---
> Changes in v6:
> - Provide statically allocated during early boot to avoid canges to the rng core
> - Use non-compound data pages
> - Reword commit messages
> - Rebase on v7.0-rc1
> - Link to v5: https://lore.kernel.org/r/20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de
>
> Changes in v5:
> - Merge the patches for 'struct page' mapping and dynamic allocation
> - Zero out newly-allocated data pages
> - Pick up review tags
> - Link to v4: https://lore.kernel.org/r/20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de
>
> Changes in v4:
> - Rebase on v6.18-rc1.
> - Keep inclusion of asm/clocksource.h from linux/clocksource.h
> - Reword description of "s390/time: Set up vDSO datapage later"
> - Link to v3: https://lore.kernel.org/r/20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de
>
> Changes in v3:
> - Allocate vDSO data pages dynamically (and lots of preparations for that)
> - Drop clock_getres()
> - Fix 32bit clock_gettime() syscall fallback
> - Link to v2: https://lore.kernel.org/r/20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de
>
> Changes in v2:
> - Rebase on v6.17-rc1
> - Drop RFC state
> - Fix typo in commit message
> - Drop duplicate 'select GENERIC_TIME_VSYSCALL'
> - Merge "sparc64: time: Remove architecture-specific clocksource data" into the
>    main conversion patch. It violated the check in __clocksource_register_scale()
> - Link to v1: https://lore.kernel.org/r/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de
>
> ---
> Arnd Bergmann (1):
>        clocksource: remove ARCH_CLOCKSOURCE_DATA
>
> Thomas Weißschuh (13):
>        vdso/datastore: Reduce scope of some variables in vvar_fault()
>        vdso/datastore: Drop inclusion of linux/mmap_lock.h
>        vdso/datastore: Allocate data pages dynamically
>        sparc64: vdso: Link with -z noexecstack
>        sparc64: vdso: Remove obsolete "fake section table" reservation
>        sparc64: vdso: Replace code patching with runtime conditional
>        sparc64: vdso: Move hardware counter read into header
>        sparc64: vdso: Move syscall fallbacks into header
>        sparc64: vdso: Introduce vdso/processor.h
>        sparc64: vdso: Switch to the generic vDSO library
>        sparc64: vdso2c: Drop sym_vvar_start handling
>        sparc64: vdso2c: Remove symbol handling
>        sparc64: vdso: Implement clock_gettime64()
>
>   arch/sparc/Kconfig                         |   3 +-
>   arch/sparc/include/asm/clocksource.h       |   9 -
>   arch/sparc/include/asm/processor.h         |   3 +
>   arch/sparc/include/asm/processor_32.h      |   2 -
>   arch/sparc/include/asm/processor_64.h      |  25 --
>   arch/sparc/include/asm/vdso.h              |   2 -
>   arch/sparc/include/asm/vdso/clocksource.h  |  10 +
>   arch/sparc/include/asm/vdso/gettimeofday.h | 184 ++++++++++++++
>   arch/sparc/include/asm/vdso/processor.h    |  41 ++++
>   arch/sparc/include/asm/vdso/vsyscall.h     |  10 +
>   arch/sparc/include/asm/vvar.h              |  75 ------
>   arch/sparc/kernel/Makefile                 |   1 -
>   arch/sparc/kernel/time_64.c                |   6 +-
>   arch/sparc/kernel/vdso.c                   |  69 ------
>   arch/sparc/vdso/Makefile                   |   8 +-
>   arch/sparc/vdso/vclock_gettime.c           | 380 ++---------------------------
>   arch/sparc/vdso/vdso-layout.lds.S          |  26 +-
>   arch/sparc/vdso/vdso.lds.S                 |   2 -
>   arch/sparc/vdso/vdso2c.c                   |  24 --
>   arch/sparc/vdso/vdso2c.h                   |  45 +---
>   arch/sparc/vdso/vdso32/vdso32.lds.S        |   4 +-
>   arch/sparc/vdso/vma.c                      | 274 ++-------------------
>   include/linux/clocksource.h                |   6 +-
>   include/linux/vdso_datastore.h             |   6 +
>   init/main.c                                |   2 +
>   kernel/time/Kconfig                        |   4 -
>   lib/vdso/datastore.c                       |  97 +++++---
>   27 files changed, 375 insertions(+), 943 deletions(-)
> ---
> base-commit: f02e02079ac56b44ff89d4c2189cf7185ab794f3
> change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c
>
> Best regards,

