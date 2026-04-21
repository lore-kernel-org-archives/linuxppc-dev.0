Return-Path: <linuxppc-dev+bounces-19881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA6CF8FA65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:10:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0LlX2rhqz2ytx;
	Tue, 21 Apr 2026 22:10:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773416;
	cv=none; b=hfEHFRmV0E5jxMCIgD+vbMIagaofd3akL3OonZngsFX8Euf5zN+gV50TQXyb2KRrp7N3JkgqNodHcz19z4QwsB2HduBwilNe5KqrKh1az6uF0jQ88//u1TZbAHWC0A9kYcaYgVMQtM1pDsDi6yNYGiHUFpiftjX58pqFQhNu37fB+u6SGyycUw66uJsGpSxWe+42zdv5ijDEhLOk1+gsjoEly+dfhc4YPQNjqAwZ8Q8+bD+ycl/VwMeL58EBFvdDbaS0hc20hQuKDTJUv1eTUBp0sgx2g2lMWijoV3E4R2NGLQU+hudAQXz1aipkU/khBKB9SSGQRXXQvsAQenWLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773416; c=relaxed/relaxed;
	bh=mYvELhLaqGtSokpfPVRkmugugq4w5jY0uoduoY+P08E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wh2mE6maNfaN4wejhk1RpIGdNJDI63gDf+6bV9HN/O4YoTGdnJav0yjq30Ye6eTMjMMC5TLJB2LJd2TznQMFgSSsZmout57xwyxtFjHYSIkLx3AY+RpcgPkdfKtz80H7s67PRkeVA/kNA7zjjVfIygEvwVqu2KVtHE+kl3npPY3Bk98QiSZkjHmzEukwHedjvYMqwgJpBqIeZ4nGzjUhfqG+DP3S42wrOGGmlEinerNeywQSLL+GjR/b0qascdLqlltdiYZUk5Ng1qo4RwszT55T252yx9VMhfsvgaPGMzp7ijc1FMiZacSEJ2tA48JLX2twcV7UKvdniWwFniVSvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRQTGHIu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRQTGHIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0LlW40DFz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:10:14 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2708645a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773412; x=1777378212; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYvELhLaqGtSokpfPVRkmugugq4w5jY0uoduoY+P08E=;
        b=hRQTGHIuORWFAUX5WE3LGL8g8Zh26i8t0HTBGjp+HzgBrIhAjbR9Qe9vf8KE0JGW/T
         9uhs9s6/KLJAfKIkVliQzkw0NCCmsiWfv8RxnBXhib3Nt4BmCofYrS0E1JwRSeGe3qXu
         UeXw3CnPMTUBxqaQ975gF6lkmsFfps45vPsZNXAdejWYO08ARseWxbV3c2oaUHkPLSgI
         gobSLaIFfh+T+A5mNnI8uBwyjtAO+jhmcqxCG6DcFvbISOqUALulaqSETDehbw83Y+z2
         GEDJ7NkTgV7oo0f0jSAPW07U1Pw1ywqraRuLVGrBpAgo6XLj+xR52tw3nUwyvOKPkijq
         OXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773412; x=1777378212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYvELhLaqGtSokpfPVRkmugugq4w5jY0uoduoY+P08E=;
        b=pAAKh0DXfTVHRk+ZPs53cZ+HxaAAlhXutTkq7Kj2AuWWSAdyfcZoij/fN3KAba0qif
         gxnPR35im1sMggILWQcBLBqFdQ8qpb2WUzIeKaZRqe9DbuAZjIEfV9lXZm1GTwlLAnna
         480YIgnhGkyWN68i5iQ+y7FDOdFxWAJSrDxEf0Nb96xo9lNN9MJCcKj3u3AM0JYXh9oZ
         cDN5NbqWuBM8xPME6Hn4XnBHfw/B8khg6KG8MCMq5dTgSwel5apNjpsneZwd6u2NxVTQ
         fRnSO0HhnkImDXk9GOJA3Wsf09FE3caYueBl3QYHWeZH9UgP/h+5RQvpTPvhICTPc/Rs
         r4Qw==
X-Forwarded-Encrypted: i=1; AFNElJ//8kE8/ODxkyOrBV5Ci8HK8GO48qDipR4Pj7/MOsKYTUnhiV3uGnzQH50Y75xbkamVHSmMv+cGFT8h7tY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwivojvlGW+Bc1Ym+zy/PSf33PpILhJ/y+yihToPv6q9uc+bC8q
	4vD3XKEfAE4Y36zVPtyhd766+JgzzNK1GP1jyo88kEicw7WhiwYarga+
X-Gm-Gg: AeBDieuT1vyULeESX3VzDVQr2TyQk5OSfxJ1g8l83Dk29CGca+3NRmzBmVKbGVdG4C9
	7HOEA/j7dgh0JCcbUbeL/GKDFDtxI5B8v5t1Xc2nRqyj31IvjuuLtieWiXbjzwsOTD2zf+sid+B
	tKXD+mD0YMsVcoj21jb/G5Ak3se+MnWYq8g14PS/3DEj4N/dYaRJIxR4PCIMX48Sozz9YKqulmN
	0G01jpEyOKxxCh+Aqi2QBhSsb2aXqF/4DlpeyhziKgVa9dnZY8c/lrVsqkAAEcdE7QCVHgP/y8D
	ZRjt4SWR25vHaHVDp5L7AgmOIdAh0Xb0g+V+Q4kthBa7wOl5nRxFVqRUIdVi/PJ0D9CMbT4b3kh
	hnBRCd81eMyVJLFpUz39T91ja8ZltnIysVhB3/JAttaCDJCR9EHMba3xHSl6c1Q2sXNDYXiew35
	Qe5bkJkhspns5OUhQZ+qTYASkwkdn7x6R2aYBQpUUaM/qfMSH9hc/pKW5Q9U5WabARBbkO6uhYT
	ZXaBaAJj1+GOvM=
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-3614040b2c7mr18545775a91.10.1776773412415;
        Tue, 21 Apr 2026 05:10:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm10045274a12.16.2026.04.21.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:10:11 -0700 (PDT)
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
Subject: [PATCH V12 0/4] Rust support for powerpc
Date: Tue, 21 Apr 2026 17:39:54 +0530
Message-ID: <20260421120958.190430-1-mkchauras@gmail.com>
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

Link Mauve (1):
  rust: Add PowerPC support

Mukesh Kumar Chaurasiya (IBM) (3):
  rust: Fix "multiple candidates for rmeta dependency core" error
  powerpc/jump_label: adjust inline asm to be consistent
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                  |  2 ++
 arch/powerpc/Makefile                 |  7 ++++
 arch/powerpc/include/asm/jump_label.h | 23 +++++++------
 rust/Makefile                         | 48 +++++++++++++++++----------
 4 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.53.0


