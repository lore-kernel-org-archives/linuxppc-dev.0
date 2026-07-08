Return-Path: <linuxppc-dev+bounces-23782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26262C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB3v5tJ0z2yft;
	Wed, 08 Jul 2026 18:25:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499115;
	cv=none; b=OdL751ncz63/7lT1EwdhQWOBreRxeJwjIXkFD+yIpTE1TgyxRvIxaqpwcripk3RBRm3IIrVNF95GJSWpkQx89KJ8NWJLWN/xCBLK2S3t+cvlx5fYjlBsqtlwC4XS+a+T7FconGQPunH7xMsMu0owW/JM8CZoArRT47KhaWqXyOpQ3331xTZsFjrFONLFStHDWNObEfEi0TnpmJjrKkFrG6voshZO15uJOrw4klEy6aqaKsSXu1G0cqjDjlX1N0bcXpw9msbB7Ed0fVb9sonwrSv2QQAYVm9ldqvluxqt1f/YP3V1MnyP4qYjWrW9XGgyaNF64PYURPi8w/HhdhPQew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499115; c=relaxed/relaxed;
	bh=unhRE1bbaSsT1YMYJtqH3njUIuLKUE290GOc7N1/y2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJt2hQWWywZO5IIWcYaLfl27q+Ae4kvUdYs3+aAogB7dCokIwkOCLJPFJuiRVTEf3G5VdZN8FFEuN77zr4w4B3VSPyStv9BkweGklqy5lp/mvZkLt8GqxDlND6bWzpYfL7WdWt/fQmXsSZrvbhlIE498QyNi/WBk+E7oJDmB95y5qR6kpO0WxXfBxz7Mt6gIKxpPSdJAGIK02OL53UdLnAM/SMv7cmTBcW2UEQ6NfE97uzObI5XplP2dcEiSJJbg/01olJL1SSIfi03i/4RM+3nOnEsY+Pmu04XO1OJR1pSL9bvB9tO/G6yGToNLsKWcbsCG9VqkNS9RnmkxKIRREA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gy66J0u3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gy66J0u3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB3v0JDRz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:25:14 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so363437a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499112; x=1784103912; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unhRE1bbaSsT1YMYJtqH3njUIuLKUE290GOc7N1/y2Y=;
        b=Gy66J0u3W7SQIt23iuCKGnAxNsBs3rAAaYHqJ42FPcjzPy5Yzqhv4WyVY0oGrctUY3
         3e0TDgT6dEIgZ/sFO4IQ5/sYAYssR8NT+4EuFEifnDCMi8997Yo7/UYJ9CXf3XYdbE6o
         6axDVrcR3N/mkjgHkLLDB64rQEPdqDsUui/hmjNmZUvBgX190CwDjsP4LJQ2O/4Vi0hf
         QXSmxLCRdB3gXZpX8WwzN0KbH2rfb59ZwlU6UX9K8WmzyxrW+j1XETF66o0ffwEs2n4F
         7p8Ob5SlHSHAbUuzigO+k7xAx/w7aKNps5/FixSVaAlJF+CdEjODvU1oyc3s4+SeLptl
         s5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499112; x=1784103912;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unhRE1bbaSsT1YMYJtqH3njUIuLKUE290GOc7N1/y2Y=;
        b=MEVjKhYB51gqb9LInSd4Egpm0XYmyFD+gId5X7F1TtYt4j3huLWBUgv2qEaFKHxq2C
         INU7ys1+tcUBa5UxiyxS8c5FY6jmJ0jWT0XHYaot+VR6Px1NrQKoGBeOSXdgM3/Nt3pH
         wHY/4R0kbCmZmsnLLrFEXBTpBIUGGKj2IKkQsJjNNHfBrlAHzPUsXP7jouC3wdXDguiP
         4GK4ndmjjglsM2mjDNMXr4LGYsimiKMmlfZpmBsArJYPyWfdRbXD2XSsu3sMaly0k6/I
         lsxJpg2ft3EQnz7XWnsY2EaAL1h0GqeyUPySpx44tbM+mmEYfn/CHPNVk3pSk8o+i0Qz
         m2uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9+fRl0trbtU/VJDGRkS2xXJUEiNwVVJOKHIJH5P2AoWuWjpFSVImqO8Km8HTRIWk4nsZv0w6vnA3+5BM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMA5v+ENRT36LgULvpl6GIss6qO9U8LqCdYp3i09XIuB7Yr2mb
	u/5jKlF5g/AvFibBJxgZpcFHPp4s8WcsvYEJfoIPgCbO/tJ8+JBK2IP5
X-Gm-Gg: AfdE7cmsf03/2qg3YwIH1kaucYj0IGNGNOksV52U8uhyfWMETrQrcIpbn0CNxO1PGGC
	CJ2lB/joBEHGgjPKNLIo8nwLtzq/J5kJeQuQljuBlf346rk9TMcP805hHAMmpfDzYBQprMY1YWl
	YkWmL78swVby+N/ZvwwZEHGXJfunYMeAklbRdYOaAcDOGJbffKprgS5qkIp5FRkLKkOW6qj26jW
	8NhtPl7Eh5H0gdu4tvy/8yH2qGU3PCy1I1HLVc2OOr4XmjQwBvy1p5UnGsH4ejBTenjkUro7PfP
	2PWOrMhx1LwRLu8EzneoQMlbKMYBMySBSOoDZpTBMY+WJK3q8/EEngPG3D0rJQDH4dbqisxWv6i
	rPCPS49rrdtx34r4wKlAdMPb+cgmjQkpPoFd8fJNi7LgLQ3u81k7SgBJ/31CIGInPQFxYfrDE5+
	5CFScgzwp6915dE4AbJg9LcbFm7QltQLtMsYoHoYpW6QVKO8mKeCBZ+TVRnnbTSCudQg==
X-Received: by 2002:a05:6a21:6e93:b0:3bf:7081:934b with SMTP id adf61e73a8af0-3c0bcff3977mr1796917637.26.1783499112244;
        Wed, 08 Jul 2026 01:25:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:25:11 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V17 0/7] Rust Support for powerpc
Date: Wed,  8 Jul 2026 13:54:47 +0530
Message-ID: <20260708082454.1254320-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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
V16 -> V17:
- Rebased to latest v7.2-rc2 

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

 arch/powerpc/Kconfig                  |  2 +
 arch/powerpc/Makefile                 |  7 ++++
 arch/powerpc/include/asm/jump_label.h | 23 ++++++-----
 rust/Makefile                         | 56 +++++++++++++++++----------
 rust/compiler_builtins.rs             |  6 +++
 rust/helpers/helpers.c                |  2 +
 scripts/min-tool-version.sh           |  2 +
 7 files changed, 68 insertions(+), 30 deletions(-)

-- 
2.55.0


