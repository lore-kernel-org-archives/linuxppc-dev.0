Return-Path: <linuxppc-dev+bounces-20121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4385FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 10:59:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Ny26G9kz2y2B;
	Sun, 26 Apr 2026 20:59:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201194;
	cv=none; b=H9cVIiDq/jbhkiGYR6veaO8gJhcJ1aKyQouVRg0nbRrMvmr3FL2PN6k/wdz9V1w4xFBWNWTT++0bjSVhIOHsjcmgFVzymi+3IeHfBGqniePPpR0K6LtFHCUWseUTfF8hft7j/shb6457FDDuO5YLBiI4UDblbE5B2NZ7ef/C3w87JYXcXCPAnwBHHJc8mid8TOtlMALUiyC49PI2jUYidt9VSj8DNEPQiqPq5Tke+sMZmuzS9N9+MtQLuLhB/d2N1OpwyDNcLNP7iU+P+yDhURIQq75RoXNazjFgJXfU2odqzjgaV+4bqImnLWYyo8MOr0CU0PsBX79hxYDkxWbFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201194; c=relaxed/relaxed;
	bh=U1VDIUYAAbGhNNmqVpBAywUG0DbqRnlLtXCpqzu1q0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIup3FwRcwGnOHmQX5HeoJvvdXzZ18I2zjKKrFUn0S4qQ0mQwDFT+MxxaDQ7SEjg+SWYshYIPFgtN3dXF3szeeNRycRmwbmT9FhZ1PDawGZAQFVlqBKWe7J8XezjmU2HjQllCaqntMcNbj96rcoiKEY0YPBa3nZwSjW22nKAId7PHFhzKXPf8Zinw4vTk54lmy/NMd4fg3smUSCEb1dPzfhwxj1aRfIlxo6Blzmu91bhT9hgU/IgvWZEo5ZLcwDqJ5cC47LaBdqTCYbPtMMYvFi/PpIRDXJAcTW5e6cTVSCTENC4Y8CFAZtr5QPxRmwk8SLG8gwU+gxc2h3N6orA/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1WzA3gm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1WzA3gm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Ny12pQvz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 20:59:52 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2b2589c26e3so87171965ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201189; x=1777805989; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1VDIUYAAbGhNNmqVpBAywUG0DbqRnlLtXCpqzu1q0E=;
        b=q1WzA3gmWNDXe4Qti/JksVMOV0JO1Td+PvQzsKKbWtOSpIMka3Z/k5TxzR+qnip+lL
         NtZVhzi+CjQVg2ImjKwO0Pw0Pwey7Vkri05POnu72e1PATCZ29UUTCEt1IJsc0JPrtmm
         nM0spQBXvTt5YmfkhK9RucB+fEDW25NcjtabOpNcvXfFUjvEaZ40DrYzulp/Trwv0Vh6
         XF3mEtqtl28ZRo/LDX5dBBrhGPl17J+g0moR4DCbZUsGrBK6LhSEIxQNsM7/vHhPHaq/
         jA1HZIJq8Ei/2LqLt2WzJv990z++i/Ng4jtkktbyTmO0GAxTwNhFg/gTbNHeJ2xVEnCA
         IIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201189; x=1777805989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1VDIUYAAbGhNNmqVpBAywUG0DbqRnlLtXCpqzu1q0E=;
        b=e89TkotOYfdnPo/7h/7/PxnmEMrgr8vQ1/EpwfZFUb0yz0ko1CCi4W+GiiVjILCW7K
         jkQdffnnRkno9sosoH1K8D0OQCbn0ZfXmnTtJ87t/9UH1BFxC8TSzbFKuT1njx+I9Sd2
         DkWOSn7xlGVzPGZxdTso1xRghB7yBY4Uvojk6BWYM1PWq4INks2e//FK8dbH7EUAqo/2
         DrBAUo13jSwouWAPyKgfA0T2fdmHabUY5VbUhvD/P6qwO/t//F84u2K2ySVpPqkBEy+B
         VcjNCQcCOnHHEE28cUDOP32cda7FNhm1fUxiQJK+Jwr/CvOaMVPIX+lcvkgt9TmeaEIL
         SsGg==
X-Forwarded-Encrypted: i=1; AFNElJ9b5aFGWqpd9T/WMsrK6a3CdkWT6NH41qiQ7GtjYGCx3Ntz2HLz0jVSLAsbiOVmxxPHXd7UEtU1/POSd+I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfTA5fUdDjWVyrRCzkh99NQxbmuAkfRfg1v43DUazZZEqmOgBy
	qNyE5gqVPbYohVfzvGDVSrMCuHuuw6canE7HvLABQhC99+hme8txt5/5
X-Gm-Gg: AeBDiesMYI2jKuBph27J5dU1Wra+3lhh9wFV1nzBgVAQCEVScqTPDta8Q4bEeYXGxib
	4claz852kRyLN527M+WcgezetopLmY7j/kY1bnaBpOjDIz6Ecrtdp0MfOGKDIqJn/6QMDHK0NZ+
	eibtaHCnO7oDi0mZyjbeDgN2YhimbMvvVHnWlhIOQaUWFc7vvOrXi1/vfr1NXvAf4jYTnEp9fL3
	RHJSK5z1WaXVNF++S6XXw+nCShQakQv77KWqyasFCPi8LR1snqrEzvVOF9nRGocy6C+F8dduTVH
	fR7mPYHdebCxZV26EQjfXnMrvfX0ryaJ0aWZxidF5f7nRyM5j18/rH4NME4pg3TpXjEqZmeELGU
	HXKWceD+b83BFuXzhYyXfYtd0ZEFKZgRUeSx7/CF/OWoM5pPKWMfRUFhwl9Kjm+YwPxvYYqioHP
	i21uOpPxEV2GSnNtVvNorSQePp6hL7BTQIgzCWz/E/cUKoBm8tYuVkV6emUHk6eGdhVTW4EJMRT
	epE6KhChGezHVQ=
X-Received: by 2002:a17:903:3585:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2b5fa013092mr465462375ad.39.1777201189497;
        Sun, 26 Apr 2026 03:59:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.03.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 03:59:49 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V15 0/7] Rust support for powerpc
Date: Sun, 26 Apr 2026 16:29:25 +0530
Message-ID: <20260426105932.2270364-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable experimental rust support for ppc64le and ppc32be. The patch for
ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
merged over it. ppc32 needs some toolchain fixes mentioned in the patch
`rust: Add PowerPC support` and the discussion for that is done here[1].

This has been tested on
- powernv9 hardware
- pseries P11 hardware
- pseries(9, 10) qemu
- powernv(9, 10) qemu
- rustdoc on x86 and powerpc64le
- rusttest on x86 and powerpc64le

We are actively working with our LLVM team to get the target for ppc,
ppc64 and ppc64le in the rust compiler.

[1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
[2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com

Changelog:
V14 -> V15:
- Fix an issue with rustdoc build on ppc64le
V14: https://lore.kernel.org/all/20260426085725.2090827-1-mkchauras@gmail.com/

V13 -> V14:
- 2nd patch is rewritten (Christian)
- Fixed a small typo in rust/Makefile (Sashiko)
- Fixed commit message in Patch 4 (Sashiko)
V13: https://lore.kernel.org/all/20260424054742.45832-1-mkchauras@gmail.com/

V12 -> V13:
- Added a patch for fixing build issue on ppc32 by Link Mauve
- Added another patch to fix a build issue in dma-buf
- Added another patch to enforce minimum `rustc` version for powerpc
V12: https://lore.kernel.org/all/20260421120958.190430-1-mkchauras@gmail.com/

V11 -> V12:
- Rebased to mainline (rust/Makefile conflict resolved)
V11: https://lore.kernel.org/all/20260417152253.2312961-1-mkchauras@gmail.com/

V10 -> V11:
- Updated `rust/Makefile`
- Not all libraries are move to `rust/host` directory now. Only
  proc_macro2, quote and syn are moved
- Special handling for pin init is added. Details in commit
- Removed mkdir for `rust/host`, this is now handled by toolchain.
V10: https://lore.kernel.org/all/20260406200149.3727922-1-mkchauras@gmail.com/

V9 -> V10:
- rust/Makefile updated with review comments from Miguel
- Patch 1/4 updated with commit message and subject
V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gmail.com/

V8 -> V9:
- rust/Makefile updated with a directory instead of abspath
V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gmail.com/

V7 -> V8:
- rust/Makefile updated to separate host libraries from target
V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gmail.com/

Changelog:
V6 -> V7:
- Documentation removed as powerpc is still under development
- Added a fix for race condition in rust/Makefile
V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gmail.com

V5 -> V6:
- Added a missing Tested by from Venkat which got missed since V3
- Support is marked as Maintained instead of experimental
V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com

V4 -> V5:
- Removed a nested ifdef from PPC64 for Little endian toolchain
V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com

V3 -> V4:
- Co-developed-by header added in patch 1
V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com

V2 -> V3:
- Splited HAVE_RUST in 2 lines
- BINDGEN_TARGET_powerpc initialized before assigning the same to
  BINDGEN_TARGET
V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com

V1 -> V2:
- jump label fix for rust has been moved to a separate patch
- PPC32 support has been taken
- rust support has been marked experimental
- target.json dependency has been removed
- HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
V1: https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com 

Link Mauve (2):
  rust: Make __udivdi3() and __umoddi3() panic
  rust: Add PowerPC support

Mukesh Kumar Chaurasiya (IBM) (5):
  rust: Fix "multiple candidates for rmeta dependency core" error
  dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is
    disabled
  powerpc/jump_label: adjust inline asm to be consistent
  rust/powerpc: Set min rustc version for powerpc
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                  |  2 ++
 arch/powerpc/Makefile                 |  7 ++++
 arch/powerpc/include/asm/jump_label.h | 23 ++++++------
 rust/Makefile                         | 52 +++++++++++++++++----------
 rust/compiler_builtins.rs             |  6 ++++
 rust/helpers/helpers.c                |  2 ++
 scripts/min-tool-version.sh           |  6 +++-
 7 files changed, 69 insertions(+), 29 deletions(-)

-- 
2.53.0


