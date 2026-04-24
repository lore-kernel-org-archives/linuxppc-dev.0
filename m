Return-Path: <linuxppc-dev+bounces-20034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6317FB44B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g22772vmRz2xnl;
	Fri, 24 Apr 2026 15:48:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009683;
	cv=none; b=Q4qntf4Pq0PHzPt5wI3t1YD8532+rrNx8XdCJ2a1iATg7MvymJTj1czzl1QkKSZ+yuUEvvj2IDXHZfroV3XiiwNUusIfS4WxG43QPYw+OAtRGY8TF/cSiHlMzufB0hMQ8CefCRBV57iYzpiZgcgG9Mqb90E3jnrrAzOf8S98YUBOvYelgm3iKneAPTP0SOVrwG9dZSaq7JqegRmXFN+H/Ejr8/vWBnGPGK3yUrmCpyleUCFXbKHZgoFZlMNjkfnf6+hvYXjBmzdeaYk3nj51F77K9xmxrllxLDHYp8mXA8aJVx/PPpGMSgs0AZQcsAWY2WjS4N17uuWZhNJy09pT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009683; c=relaxed/relaxed;
	bh=Q7M2fwY604nxmRG1YIO02Z14fgzwwg1Pa67qHupVFxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cup1YoG+Y17u6llAJVF1CfNnebjOX83tj+BnlWuKhr4iXT4HrXd2gZRuzL+Z3xhB8c/qeeJ769RxBKXuu8thx4i3a9x5V2M1wuuocujWwfgjCAoF6nBMzz6EaYtMv1T8XTXQ2Q5Ga7KV04cCEOiVLuxdy3KHbYAQQ5gxRDwqflMgYBWCE7z5vMGQIMn11+Bs5ARM+/mV7BsDbBW3CmTgRSjpxeYJYDxqwA1LYg0sVVi26yEMq3Aqsm7Hcune3bC5jd5emKfFw7No2S/XP36Q/byF7iFz7DoE9DTuIMcuvJzUkignl5HFJR8xRt7vJePc0jNIA9IXO59CIlD+m5+Tog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=saPKta14; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=saPKta14;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g22754SVQz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:01 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a871daa98fso49354215ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009679; x=1777614479; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7M2fwY604nxmRG1YIO02Z14fgzwwg1Pa67qHupVFxk=;
        b=saPKta14ZHnIR27uUqMiMxhlxVC5Od5JzPyEfh3Ip38as08DZQ+/+7M7xN0KBokmT9
         Vy6FmhvwRlhwplUt7KHmNCgG4mmr2SLjJG7V2iCG94gwz4E5o6PZoOjYiXWHI31I8ZT4
         G9FWj+emoXXqckpcqdMymYulJlvnsnIfB5PEIxspE4u02DDW1SoQLLQxkTBUYGF7BbU8
         DJcZq7sLYy7fHM5CDS3FL22Jvrcej9pbhLaMrU88e8xhpJXrHrrZThm3wDuQxF9tTnZq
         0LAyMQjnzooKN7Rdv7Zi6Zi4hQTUDVINPGIM76ANVEINJympaTbP7D6MWTICUNzxHOhZ
         LoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009679; x=1777614479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7M2fwY604nxmRG1YIO02Z14fgzwwg1Pa67qHupVFxk=;
        b=svVDjXtfhaHr9dHEGVHcL09jFWdfBfPjsz6ROpM5OKeRHAg8SNnT1QR383pcUHMZNQ
         fLM45wOy6yrwS0ED4Vf7v6yYRBXlj0tRWtN9nhdJrt4P8kxHYVXziii/kdb+EjC4vfUb
         EBNMelR6fXaBvOjaGv1a2rmnCf5wS2IkXqeK6J6VGLD2rjv+iNoHmwszPliRJaXnDZ4J
         CQXHJQ/lAigHhSk/oul9qMk9bhaIF/H87LCtyYw2Ca1QDd4RCIt5s/bIX03ZOCizFV1O
         D06CsFoaCNshfvyHPoqge7R+9onexJP2kfCKgCpOzRGr59gaw2hq+nxHSUeBy/gODxCJ
         6Jxg==
X-Forwarded-Encrypted: i=1; AFNElJ/3mL/CgBQXynk5yGh9+NAhoARzHhcPJrACwTj3BDkrkJpVh77MLt5rLkPm+H7A8aNHG/bv442lfrjpXlk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytrkgE2p8+oGI8LC8wYMpOubZbTeifmHW/DLR/A2Ynuaxx1MdV
	cP3ZG+9BwdePxjZtPW1UzmCj7i5zIBiTG0spd4KppotTYm0+H0bkMh03
X-Gm-Gg: AeBDieu3HflwrW3RuhBVFmI27xZGJqpLOaZv59KBdqiR1E8bgb7Zx442aXI038+rsSZ
	8qp0Yh28rGnyFC/p2EF5ZLqBdXwYrBdrzEWT59MvxgIofwLzFv0BZKGUF7EvQURt/rgVm0oHgbT
	FuSXKZVVM6V4i2lqukCbzBYw7pSvxYqsiocEurC4BvE7nGv+UVmXHQpkyWK4L1z1iyeRIFDAwhK
	N0VZ9YM6azFfcTAHsLL67wvUVdGSxtf/UU2udasnuqWQQpumDT0D3RG+JuMliJyUGZ3f/QbAJfT
	NdnGOO+drCr0+FkEv69rwROIao0KhHVzieoYDjnVxgV/dglOKsjgCAi0DpgcgPD12LxLy5ON3TR
	+HMBK7blBpvhLZvC58iAouX4tZAZzZicGyGSAcH+J4lIXMfXH3r6PDYL+2yp5koGzf5gbAycizE
	7hzO5BsSnGEbr2CUFXFPLnpeFIRlSgxg7iHfc1tOjl09wB0XjFA3evOmNzDy7Xf4IeJ3xiLploa
	TY/Y+votqL817A=
X-Received: by 2002:a17:903:28e:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b5f9f9f125mr305572665ad.41.1777009679150;
        Thu, 23 Apr 2026 22:47:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:47:58 -0700 (PDT)
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
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
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
	tamird@kernel.org,
	arnd@arndb.de,
	nsc@kernel.org,
	mkchauras@gmail.com,
	simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V13 0/7] Rust support for powerpc
Date: Fri, 24 Apr 2026 11:17:35 +0530
Message-ID: <20260424054742.45832-1-mkchauras@gmail.com>
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


