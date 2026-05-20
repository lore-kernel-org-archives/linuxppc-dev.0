Return-Path: <linuxppc-dev+bounces-21207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6358CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:46:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2C11fg6z2xnK;
	Wed, 20 May 2026 16:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259613;
	cv=none; b=HMtd03/WOO9wm3YfqkZJ+R40+XKMcAIt5QcdrHhuRO5pJU1QeSIz0rrX7K8/R2PFSW7Ywcm+smB4EP5nJqAWbzkKHSJP9k5j5kHJoA2cwRUN7HNFgjBxoikJeJlyOfR2gfR8Coai/qCyV1iKRLYEdnEIl5vdn/aXxeoZRBakHD6bVUUBG7cghvWYeGdi7rY5j99VO8pBUCTOPcAjFDp8vfcGvBtUVkxJNC4NrcPW7EDwB3JIicv7SsJFuUdxg2c8Zc9vNi9aLYLP985HZWbcPXVE1bZxxitz/b80poN2sdRRoinq429E3D5Y7WHIcN4dfrNn+JpaK6Ox8Mwz49rbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259613; c=relaxed/relaxed;
	bh=NDx5HOJPuqRAyZ1SBpaIcm1vCWOl9Riz0JdHBJ7QyUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCj4Wk2UsqAXS8Jh6iHfLfFtM0MkSfycJAPSbHDndfmiqmuvhNVf2HC0w3i9SdjysasNdhENK9VC6GujSx0hIP2lds/uA25PrhlM5WuKSSbOLzSNMRV1Qvbg4Rk0se2KUqnCSj6GKQuPgSvfahZbSA+ulHd/5yV9s7ALjKgaGxCg2n9RYL/ib75dgY+xxyDzpXJntvyMVoJwa7cQEIIuNoQ0MgYnC0bqhOOCVwtcZ3Tva0/pNM7iNhwyLH/zGb45slWMHQefkrcGV4NzsXIZ6qW0whYQndmVS0SvRiDM0zx/36WMxO59oJg1sNmE4ZYaDZm/rOXKmJDrntSZgbiZAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GpfZkDMH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GpfZkDMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2C02GXhz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:46:51 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so2809956a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259609; x=1779864409; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDx5HOJPuqRAyZ1SBpaIcm1vCWOl9Riz0JdHBJ7QyUM=;
        b=GpfZkDMHb5GMzyUTswQT8eoaPRZmk+isnB9Nya+rLkfS9r5GUGB8BJ0oW0tgDCg3Kv
         P+3ca2tU417kXNLv5Q9CpvmwyyFVVl+G1/nenW1vr/T3n62/LsaDManZOba6lFSOESnC
         Kka9j5WJKt9nBuX2GC5dD/O+VaFS1VUhETIJWSFORzuTBC3v+d/TppI8XVGDCSpFTmQU
         g4n1H+B8pla1Hcyzbd3vWWwWQTz5TmgUHcxRxBiOnWn5F+89EYV963D572VJXGXY107P
         TzzoU+XLbvWMfi+FObJIWq2toZG6ecq1d0Q2L451QLctS+Fx0eh8pnYIXPo51+yUzBSh
         wtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259609; x=1779864409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDx5HOJPuqRAyZ1SBpaIcm1vCWOl9Riz0JdHBJ7QyUM=;
        b=L86YCxC5+cDv43BGPgoQSXKd3/aXEWbSfHvHf9MGCpnRrbWMjCA1TB4fcqn7HtDWbF
         xkEqbQggPRfjH0SWR/RBotb4VWHf2i9hzenFe0bVCEoD4/GqqCBkaau1y0LmcQ+Cv7yp
         sx8X3r3LgrtSJXM5PML+MSH/YTGxQVm1hOIPhfESc4tihRCE0hzfWdxdArOFfihL0/GW
         GJW6Mo31yZx0a7YrAf4swATYdG6kFLrVRjdGfF5V56Pqmzk5aLl7HezmvMsTscd9dCp4
         TyKAa6tJGXSW/Z9q5HRY+m+QHzZc3sGZHePcptSHbRVLPAGcyba/Ix1jm5kcszqPDol0
         4Udg==
X-Forwarded-Encrypted: i=1; AFNElJ9PFk27IhWT5TIh4bMJablKvFoxipaml0myGMpKkZE2dmOt7pWLjGzR7FCZ0OKg5mi2VP38tN/WY7TuGmU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4VelBtxSqMq406BaYanwWIBnuuKRLOkfBFrCSDIPzdATKV+6C
	ZXuJjq/90uqSnspsb0eZvrSljx2ybHMjCLdiPHFUf37eafZvRseYWI4J
X-Gm-Gg: Acq92OHb9kvvuaIbuq4H4n01KFupOMDD8xP6a2Sh4cgROv287FlxeZI6T+q4JDGAW/v
	XaTcQp9bAoF6xog2VI+CbLO+G2vuhhTTFH1JkjRvzkgZp2ZuZ8uy9hugZVSszmTmnK6hM5I8tPl
	ahJ09cnDujpAE4Iwf2tL5nGi59F7T+MxJPhJBqyheYMidnB3MOvaoo+rvBIiCVh9Gi6qPMuH76c
	WNwsAHOfjeSBJ3sE1wV2qLBUdax48snltK5W8uBpcEG30RAlmW8s1iaF6IlDcURifXTZzJS5kLL
	77IuipPxP2trAD9c4wMn1ZXygiaaQbi1zR0IzXXuVbBhBL1AWr1ouTGDDxB8tJofNZVR945qAiP
	a2KNhScmGldhFqSZU7SIgrnDJ8iz+1KNhdi/rXlOw1/04oGTa3/GPndmymRCS2s4oToijLtQkR/
	7TpweHVlVLe425u0MXCGn7zv+yVfv919OSLCjCmVtBq4nDNvHTRDbWv4xuHU2KLhbo5oVBDy98A
	WB/CO0cDJrVbSI=
X-Received: by 2002:a17:90b:1810:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-36951ca602amr23738159a91.22.1779259609374;
        Tue, 19 May 2026 23:46:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:46:49 -0700 (PDT)
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
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V16 0/7] Rust Support for powerpc
Date: Wed, 20 May 2026 12:16:22 +0530
Message-ID: <20260520064630.1785283-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
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
V15 -> V16:
- Rebased to latest v7.1-rc4
V15: https://lore.kernel.org/all/20260426105932.2270364-1-mkchauras@gmail.com/

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
2.54.0


