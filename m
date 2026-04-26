Return-Path: <linuxppc-dev+bounces-20105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C772DFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:57:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LF80ZH9z2ySC;
	Sun, 26 Apr 2026 18:57:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193867;
	cv=none; b=P/hBQEKB2eWDLBdVcO2OfvA721CnSYKJhk9Wr80DAWdcyHMJu8CDK3DFLFrmpOVinLytl7nxQ7beIbVB2sHL8tzE4R4yh3YmOlKYyna2fLwHix9Rm6feHWrGVlxDA2UPDP6RjbDr6uQJr2cQy6Owm1NDBUaeKbulzPDbJCe3YklMSihzz6w0BLmnI3FHdN6g7seEBA0k0XVBhJWUc+HfLXIU5Nl+PsQ9ncBLTlyHCczsthnwr3GBbH1sWfoFFJlNy4ZqnBYRJkxl84zXfgNDh+/tZAPsSepLaRdjj7WSkM4/i31d9QpYcvMpcz6WID8YA20qHORNo7I90Rd6tGr+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193867; c=relaxed/relaxed;
	bh=1TNDhheCgYQwNZEg4xsaQHtI58WnlBldGT70w7nMF+s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOZeAF7F3Xq73O52u+Kn/o0JxVKy1fhpsBA2F8qDT9k5PzRxOKCPHBGpxAMmlNS/K0iAE2znaDCXWESkFyjbJkhzbwOzy1vc0pt6Tco4CUfGT6M/NYYfkLAxbhba/NrTsHbxVznppkWioNlXvBuawZRXJ9NXi0EgYcaP6oRuycIqskTUEMejS9mjUXjAakOPVUgmc0A3aLHKnChILnSZgoz8vacFms1qbx4nXZoVZWTcR6xWU1WduFO6ZybPlaXT0ZTkBYEKiapUoVhQfCRonri0uJY/oNew7efUfMajTi2QSA71Iy31dhnKVlqsJYdTv+Zr26j6K22coZjOywlI5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qcVjImeD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qcVjImeD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LF63wdpz2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:57:45 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso5811937a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193862; x=1777798662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TNDhheCgYQwNZEg4xsaQHtI58WnlBldGT70w7nMF+s=;
        b=qcVjImeD4z6rgdjr+WAQP8T2grwAP66DHHfqV52xwn8fd3GQzUDK8no1S3mlEUpCvy
         yPen3fsvhI5UPRqt9NkbTNq12EgmZ20qGuogthVcrbNrJWmZBA3dNLfZDDjlH4yy/T7m
         xcl3E2LCjudtZ0O6G/XD8Alf4m1CWfnQnlRrqcKRodbwzaoHbbdGFtCjU/mj08/YOZoF
         mnT1sOZFH2ThBAoOfoIW4/xP+Ae2YDK3SLoq+Ueci/1sVMRXEeueCmEij3KXVW1gbPVn
         l6HF2WYpdj3rTnfoRzuexFxgydCDWaTpRcmd9xtvkeHN32DvmTQkCcA3wtkGT/Ex59Xa
         1k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193862; x=1777798662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TNDhheCgYQwNZEg4xsaQHtI58WnlBldGT70w7nMF+s=;
        b=aC5J45lbRPCQG7RhPrI1Dbq+tas/QmdFFjGyYzzLmqrCiWGPyuU+FY8GaegFpulsF/
         FJbV0CCU9MeWjZ5OtKd/GdIVlXmuzKZUhY1FTOCs8YipkTOPvI8N6AXezn/niS5vukas
         gN7ZtTPR9rUjo1a+50znKYBgLQzyKyK8uKR03kK1nyjSnmN5sPLHwZ7kNSb2xEfyGttm
         /UDeXSBwe7zwZJkPew6NzvmpV39A+DVUYuiSCFqP+YFF9PdwhU2aE2OMB+SQM2TCA1eb
         rg0vjHBUvTa8jR7+D7Fuk0ZFr1VXeioRYyvicRpaoW+sZxPvrBx0h5l7WyLE7IS3zOR0
         ZsGw==
X-Forwarded-Encrypted: i=1; AFNElJ/4QXcbPr2uULIDZLZgS4RpbhVm+hIpjBDy7hTe5C0IgRMXhIRAOcUbNuyd/dU5uVoE17QXS7E8HwJTkVY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+J85AYVE0eQyp6jhFXhTaaM2oaw9r2TUGvh6PvoCoZtbPeJlW
	fPjkip7nsAQnPOxwSmVFHYLsg9sHy6Ji28DZDk1CeY4dNnY4BjjkUQxG
X-Gm-Gg: AeBDievYYLyKRtcToeVbWdy7fh1vCRdaX5a+9WjSlO1Brt3EwEkjbt26ogYo4IxIhOi
	+QG1dYdgispVoasc9GKIDEdtxM4Us/1Ieuo7znleItX5ZAPEflaY887Lu81uaqhJ2L3aiGJrzH/
	prFvuwVOM6tPRziEeP4mmVdwyGOloSney+H+zBAMt24bvbUm3W+deofAtp8DfDDMEpMLuC5BCRH
	ouRrk/T8CaRJOkP2+RQtBq9/TSSLxt+CYZi99+vbXu/6m99mpitGGfThZI0Gf7+r12aUh4Nx10q
	VGZfq44EFleHXKlK0uxEV2I9SjE38Yr9tYpfaUoVlNxsO8OJ0ntXTo+G5wcYuQM/tt6YMgHKY9a
	lU0moqs2w2cwJjUAv+huszStkCS+zp3mmGl6Eqm1/PoBY9Aj4lRVy/K92AAvLr4BccGxAEuexQg
	os5lMcWDYyOA6i+4mkkgMQC1g2P/n3I45dXt+b8rAj8amWQFSk4LRVYd3RyLIuFf6XeHeyBytuD
	xBsOVtPkXTyZoQ=
X-Received: by 2002:a17:90b:5490:b0:35e:594a:5b6b with SMTP id 98e67ed59e1d1-361404992a1mr45071909a91.24.1777193862298;
        Sun, 26 Apr 2026 01:57:42 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:57:42 -0700 (PDT)
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
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V14 0/7] Rust support for powerpc
Date: Sun, 26 Apr 2026 14:27:18 +0530
Message-ID: <20260426085725.2090827-1-mkchauras@gmail.com>
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
 include/linux/dma-resv.h              |  2 +-
 rust/Makefile                         | 52 +++++++++++++++++----------
 rust/compiler_builtins.rs             |  6 ++++
 scripts/min-tool-version.sh           |  6 +++-
 7 files changed, 68 insertions(+), 30 deletions(-)

-- 
2.53.0


