Return-Path: <linuxppc-dev+bounces-19407-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4132CF46C7C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:02:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKwv6HXsz2ySS;
	Tue, 07 Apr 2026 06:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505727;
	cv=none; b=Rb7W0VqFjL9Scio++0EWQjQXYDWXa7XJHPxb1MErV86of2AU2CBWReFVeohR/357O1OzcA7+x4k0xrQjLBxzLcXRpMQtqYepFYTHQNc0YXqgemyRKRsPrbef11hpFQtfBuvUsNxqs/UJalA9QiT6S4RP3tg/elFs5RUqfCpSYw7U7vNHDdYJmdOqSvHWAg4CxBY3l3YIH1lIyQg4EUQ5JWNgejO9H++u85SBRmXotJCTO2UBCor81ZBYxZ2+1xMX5LPTu0K90CvRHSozSZZrvDFfAK1cfJopr6zZwiabnj69buPPcZ/2hslvNaTQdRZyQwHZOIwOz/qpk5L/NLw96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505727; c=relaxed/relaxed;
	bh=8aqgt9jJm3l4gnx6c9t2i53dMaxCBMnYxyV14FUwpPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJvG4vS4+x/LWpMVpBro5qQV8IzNDd/E+c+HdP9wbNYbuOdd4B5plhQLfoVOkTJS2lnB23nha02DD5IX9qUsdMvVFSEN52yXyBfJLgwDHT/ST98JGpFZKOrRVJ7ed1XfxLVEqUodwbDzGOm0rMlxEKJUrdjyd98yF5Ao1rrsoWw/YyZ/H8PN+5dgnsMH2cD+UeEc+UbpcoY7mWzE1NQH9YS55HB8QRucgHIDDPQ+3aQBZ4HJ1iutMzwJKW1eRX8i1DAMDWvqDk5JEPtVYlV3e9MihaqO28RSeoz0M1p3legJzJv/9bLnJA6mB6p2AH1XA70bEPMAeE1SdtJiwZAS7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=REKXbhhe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=REKXbhhe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKwt4HhWz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:02:06 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1425618a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505723; x=1776110523; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aqgt9jJm3l4gnx6c9t2i53dMaxCBMnYxyV14FUwpPQ=;
        b=REKXbhheaPVULs+mQjxidj47g1JnqH7CDAAyd5bCvTpbLQtZtE/mfg59OYgaFQab5V
         kU8DKjogEv8RZyN4lzIQbimZyrB1XwbqxMjSg9ow5lqP/hSyE4PZQNKFOcZ78jJbfbuH
         c7gTi7C/CItRdkaSdxXdOgN5uRFvV01QOdrpEnd5c0tievz2N1V9Zj+CKZ4m3S9KH4hN
         ihk6GN3Wnc4s/Le5H5UOE0QUzJouGEGuuHldoFMzs4G6YqUVqxjJYyKLrxl/AJhSbJYa
         h/S7lcz3hZmQExJJ9FvjQVTN0usfMgpDQMgSIxtRBhEdzEK+2MAcNO5j/9xfZFui7ES1
         p6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505723; x=1776110523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aqgt9jJm3l4gnx6c9t2i53dMaxCBMnYxyV14FUwpPQ=;
        b=rMSaDwXoVdCu5uGgD/Bgf8KnVP5tRS/xMW+3vaRa6Jnw9LB5QYqIeff84BplVBOTA4
         6NrF2tuiwwHNCFjYRgLgSHZbCP8LhrFYjwPVaG2d4iLbw9RsgDy3ZuAdKxlK4RxaNuxF
         +O9FwSKvgWfV6F1ByNcc4JzAukgvKRy0X7DKM/0+akF48u1Z1+fOcFx4wZH2bE0I6kvo
         3PO/pbisLkmgcXSHy36B1gZwFXrqOqD8sAX4Z9Gh+/CC5Jf+KfmhvHU6LU67JO519Xiq
         9fXebgUDUEjnHMN12nobJ/Sw3yz4iOblSu6gbUSlg91ApgzqnKrsUL5Vrh+DNHG64De5
         ntXA==
X-Forwarded-Encrypted: i=1; AJvYcCVpipk3e4l1tNBKnnjDTWu4wJxxhxF/V859kzonE+Q1Pb2v/hydmbAIUWZkHXjaiN7wJiXD5Jkoh1Jq0qY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGlvLvLctipjJTzNGUC4H954X8xI7L7+MnVcaExbyqMhWwUSkW
	Oip8TYu0inPbGMcWZb3eHLGkPeqRlOhFo5LwRswn6NHcH3h914gsYvQ8
X-Gm-Gg: AeBDievtqZJ+0OcljVCpzuPbQXJarUqpKuoOHwSgXk0pPYNAsti7O/au4ItV65h0YiL
	itjZm7Z+oRuv1i3DheNhuN4nFNYx2T4mRxc8xG9FfE7hIiRNs4xgG9g73H/N4Q8fdYXwD5jEj4k
	P0DZwOaYyG//RfnOt9BihzkxVXbw2TI6vI6WhV0rD4KE6dl57yUY+VDaDZ1UeWeHxvDUUN0Dhx2
	RxSEysyZIPqSkZqOaNqgnFEnaVdJbbo3HbIb5RsLPgCXdpaDVAOIM9NDNLmtzt4gurx9rYtcFVb
	xfG+2lrAVYWQsRbiWnHM3WDuATh4KOetIHp/QdNgQdEjcutV5IzKuc5T6bk0iL/OQGnZ9vYrRgt
	SX1MrN1xAahZEpOUqLMU6fh4WTB/snbhTLJwLTSpK4BqjDKsN3cS5wLUcphYt1Y+bSBeNzt3xPK
	Lmy1DmL34+KT2OXjKQVcLcHLSGJWO9QEo6sint1mAE8J+0Ls+2MVcikZnuDXNViHMp0gJEU1E0N
	Mo=
X-Received: by 2002:a17:902:da92:b0:2b2:5256:9ce7 with SMTP id d9443c01a7336-2b2818e65c4mr147102775ad.36.1775505723315;
        Mon, 06 Apr 2026 13:02:03 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm151098205ad.49.2026.04.06.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:02:02 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V10 0/4] Rust support for powerpc
Date: Tue,  7 Apr 2026 01:31:45 +0530
Message-ID: <20260406200149.3727922-1-mkchauras@gmail.com>
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

Link Mauve (1):
  rust: Add PowerPC support

Mukesh Kumar Chaurasiya (IBM) (3):
  rust: Fix "multiple candidates for rmeta dependency core" error
  powerpc/jump_label: adjust inline asm to be consistent
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                  |  2 +
 arch/powerpc/Makefile                 |  7 +++
 arch/powerpc/include/asm/jump_label.h | 23 ++++++----
 rust/Makefile                         | 66 ++++++++++++++++-----------
 4 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.53.0


