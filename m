Return-Path: <linuxppc-dev+bounces-19273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC17E85367
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:53:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMD83lnRz2yjV;
	Sat, 04 Apr 2026 01:53:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228008;
	cv=none; b=N4zzjb3w3eH2gp/ZW6IEWdgbjxI0wZArKzbPVQz+tbQTaJaTIkj0Lh+7NiZNm2hiBs1s84kqkJ/n2JvSqjs+tk7hpuNGsGmIczYcvBOOn25XQ2psB/ndmMat+S7+M7YxobwuPJu8YY/V8RIZ50IOe88pmcetB5OscpmfSWpnZZgqJWV6NBbgqfZP3PezDCv9PCSZYhDR07U7Gy2TF0xThrtFW6bupXlFD0HcdQSADAX1K0mc6K46459aRUgbp2I5ncJEF+yR8Q0HGA/4UEebas3kRBPzEgjVNAr6IS5NYoPFWmvNhlZa2fXoxGA8obcbGAJWWFMNJszMLEe6LpDM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228008; c=relaxed/relaxed;
	bh=Y741cUw5/skL529bebHe+2MR3Atn8T2EhTb8n3/Lxrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXH6wHOO30ObHEYaTfLK3qFOp9hZxMJn0SWZmrE8m4QaRB2qOBfKZRiycSFgfa8x/M2/Y8xZih64f8iUmU3u1GTCDsgtnnxibm4xhiC9K1iTVqaNH/G6bCXc1uzvY0oC2+E7+V/hjGVY63jXvb1mN4StkiyVgNsP0UTUZnZYRO8JkS2tQ0iA3uBTdAOsvJe7diupFTBBVL81LHYxfWLrEuC6bVwaFXAOYmYhpk3Mgbcmak3RfaEfdNd5jpwwX9G/3zBkqQXbe5sH8wHWACQTiOv1J4LlBdWJRDfX9xLO3jYb6o9QsLEngX091ooPG0otCO43rqy0Qp3Vkcv0RbncgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4O2mVvX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4O2mVvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMD71J5rz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:53:25 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82cd98be655so1356232b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228003; x=1775832803; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y741cUw5/skL529bebHe+2MR3Atn8T2EhTb8n3/Lxrg=;
        b=N4O2mVvXS21ET12ze7diMYy7o9aPfjJE33ZfSKmu+3wR0utxoJPR2lx/cVxf5UL1Rh
         sAGjjP0dxllt4YrKRw5Sb4tSTpyDl67EW8W4Nyw2khILJI/mk6j4021YnHtmsaTm8l8C
         NcTWDJ4yxj/FCjjlT12OYTXFjmukQokOD80NO7kz/+AXNtF4/kLlm+pf4l8St61tDp/f
         vAgqEnRPlXPNlDmNtgff+SAV9LgGtumAqO4Riez/Uldqbb7mf+VVle5XM/JtUbwrQoCv
         AJD4mFkYkMUy7CsJwRbcnFPC9YqFBUll1S0SFh2hSO/y4V0GTCFda34mclRY27HCSMrB
         sMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228003; x=1775832803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y741cUw5/skL529bebHe+2MR3Atn8T2EhTb8n3/Lxrg=;
        b=aL9JuIuXZM+vTtvdnYOKiyIFjK58daTDQjgkZDDg1A2P7dO7Zd3o51skcRF3MqXe/4
         JmrDN4a4xaedR6KloxrL03vvv+oOx3l7DHplSZjLpm31H36faMAypIRETMEkN+t2emD0
         EFYyQLC3iViri0b8RSc3MlCg+T7l61PtmhSN9Cg42FicxlxpzPs3MLN07cYbzAQpXADV
         6fT3qBOBFW1DSexDsi1rRbHmqIjJiM4yHYYzFJ7OxeFPGG7snAsw8Vl49ZNDYV3a7PxC
         DdBNpPYkOz7iZLauL//w+AMpAsQ0TlM8EduCzC6yiNwDsAOSJLEuxN4x7VSFPWUFHUw+
         lM+g==
X-Forwarded-Encrypted: i=1; AJvYcCWyI7CUWJyEBCXblhrKaPX2i+LNT1KaAKz5AbcN2zeOhF0mayf2TvqKDxLACOsOU1w5oFE+WHt9kdNhG1A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2vJQ2QVmJMYLq2GGzpdaqJCMQyqELWf/w6pvGSsy9dbgZ9RzK
	982WKyPeIoURhZKTufBYCQDbM/eV6hI+xKIihdMsoX+ktCKgkF++rsw4
X-Gm-Gg: AeBDiesTZ8KNSlLsTqdq52SI3azhk0VSauDHLWz4nIjbMSt2Z6IGFNMBCuTU3AhzFHe
	DdQQG+qPQ1dFj7wxlGww/KdJ28VmrH58G72TYGIw33rj+sNimorObl3tSUb7fcHHrXNBMFyvrfv
	sbtfR1iSsC1TH7WdFCBVJ1TbL+10Q+GnR0RaQXhFM6dt78sax4hQ6XXKZAc8oMrImGVjLIXIpLR
	b95U3JX24RAmZKMq8FvcndPyojISWCDezfYMz0o0NlTU7ghp0fGX39louGLH5SyCXvcLCpY2jL0
	nNmm/111kkuiBNeFMrNIpJD0i+DtnTICeK5Ef8PB/3catU2XjkX0+W76Wm+Pdleiq32x4ITbdqA
	p2y8Euba2dgk755M7V9ZCCCakXeFyVpE81QwgA1fdZ2swBtipMudOr1LgIVeds5wrKD7ZfAG9fo
	2qVloaPpwbocALC/xk7iJVBdFD86LIJIFwJOBFVxyc0sDxF7H3Lbb7tojFPQ06w5eAAyGkcekql
	U8=
X-Received: by 2002:a05:6a00:2e12:b0:82c:9223:cc95 with SMTP id d2e1a72fcca58-82d0da4e79fmr3167167b3a.1.1775228003145;
        Fri, 03 Apr 2026 07:53:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm6301682b3a.61.2026.04.03.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:53:22 -0700 (PDT)
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
Subject: [PATCH V8 0/4] Rust support for powerpc
Date: Fri,  3 Apr 2026 20:23:04 +0530
Message-ID: <20260403145308.1042622-1-mkchauras@gmail.com>
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
 arch/powerpc/include/asm/jump_label.h | 23 +++++----
 rust/Makefile                         | 73 ++++++++++++++++++---------
 4 files changed, 71 insertions(+), 34 deletions(-)

-- 
2.53.0


