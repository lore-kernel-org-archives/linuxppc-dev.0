Return-Path: <linuxppc-dev+bounces-19309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF69DE88D80
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 12:16:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnvhb6sLhz2yVL;
	Sat, 04 Apr 2026 23:16:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775304991;
	cv=none; b=LqIch5deBCH9tT489Q1XQatKOnbxj83cxiIPGRsIv/s5eNfFn0TTML468eLwcVaGLCczYNzdXnbQ9yuTCwHPF7zmo+f94q3plzn50yTpCzpkBgty6CPCfqYoyccSWoBfQeb52dS+gCo4dbeuSwL+9EplslkngdhSdbe7xw7IAuzBO7pzw9/oWlBoTkib8kXouu0y0Bs6dZzet0AnS3zyxxDSV/joWgttzspZRLi+NKgs+vZyz6Shhsciu+weZJ5IVhS3UAFnVfZ/6LgN1l3/BbB3mnzTQckNkYaU6Yllqf82r4PKcXKaGkXU+g20gmr42OILWhPmJLx99T8LiZ+0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775304991; c=relaxed/relaxed;
	bh=I/7o9EiCJhOtnTzDs3PNadMZp0XXQfFToSEBVOVAQ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NoUY0Ekw69f0RwSWMOCKwi61vAm98Avk39zv0QAAWkrJQN9IQ3ud3WXX01RzZTQ2PQNIhnlc4Zo7rRw/GU1IhplKnJAKPapmh9wMpiGkcamikDxp/bGufYO1X8/gPSDXflCWx7dqLYmVmsjcY8WEB3Xj2uZDSqWn1Oa4S6T7rAlSkYCc5nZqsfcKaKGK+CVyo5pyPbai/ztkbFhSZe72jtjdm90iwA5NWcljtMHBJk8kQX4H02FM01QoKTw8oesNokHEu0ORtH7k1aLVKdMqpVmNeYbChv844ptge19hS9whj0+ajtsxkM72p+3pfXBrkUjqb7QtFoU4PMlxq+x4Dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+418IGu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+418IGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnvhZ1cqFz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 23:16:28 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2308413a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775304985; x=1775909785; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/7o9EiCJhOtnTzDs3PNadMZp0XXQfFToSEBVOVAQ6A=;
        b=f+418IGuedEy+2b4OqX60tvpvcFdpfW2uv8oOApPnWpD1JyXkLkZzdunihcjGg+ABX
         RFZ8eeppi51f6CR4q57uuieAeUwCDdExS0zA6v+8QnRGI6EZ5jD09ppqi+6BuPBAzakP
         FZS2nc8MXFXbU7WrV6uyNDfb5phyVxxVGcABcxdNCyTs1I2QiLLWov47JAB4+iSeI3Q4
         V+kWn9bdf66x6KMBpTiegOHAqnBlWEu8cPy3eykomQW4VERbmx5hLh5BBhkAzuoqc1qk
         i5O/GV9qp3SEFhef7gnk4aDNCHZtY2MqwnOG6HYuaiH+/1xkLHRtTv5eFCy17c8XMfAo
         hULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775304985; x=1775909785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/7o9EiCJhOtnTzDs3PNadMZp0XXQfFToSEBVOVAQ6A=;
        b=VzKGNINy/3J33REmyTpTp2DhcoS3qgFfH9FQc0cMc9lyrisxbv5FtlAvSSHj52kJIC
         +e3pLiGJl1nweIg3BQ6aEp7iHXFsP1cKzE2rKvtQh7gVU3YE1SA7LRaSilfsaEW5Xbbl
         tHBYiwBZzvdcMAXZgfLWFSTCDUmP0En6Owh3fgG/qnph4l38xd8lwMLv5aijjLv0UD+D
         D+lAgcarosVXEJuXuybloMFVxnQxViDnYnDgcId/ZCVmOlaojubHnNid4MoDOSwVFtv1
         JL+kdOBKPWAITRnO/wwOVcUeFsoT9J7TdYCFAkSxxno8qYfzPRXadjxBqR9iZaHQZAEf
         F+4A==
X-Forwarded-Encrypted: i=1; AJvYcCUs6CwD/Y0zk1h26kmsTVNlvDGjtd3PplNb+8dq9lyIML31Hvt08hny8ofzbk+PxMjeV3QvUqvuTgt4GxU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywsxl2TmxsioTN/DUncpRxF8cwm0cbh82LmBn/wjpWDr7xHMtfR
	jw2qre6s8n2AEzIk8HFQuJcTQ0pAzAPRERnCqMO0Tl/0Fq5/dsWtTCrM
X-Gm-Gg: AeBDieueNFmXvk3+tCnWwLMxBb3E2t+jNC70ZMNYQ0+hBqS0+BeLwp2FqGd3gC5/5eO
	hGcJcXlSGpeTvL3jxbXv2ZYIujANw2LIAaPC5ipZ8hqZDVTtU9qlNuLctQq9TLCVGM1uZ8kUOtG
	0xo0wss8/e4qPXWIZUIPQ6oYMzSpRShYJx38F5I8H5Rv84vLmPhTQhYJk0OqSzp5tMb6nXqStNd
	HpvkRESw0LXX91Bbm4kN02v/O1tJxaWa6AUtXd8glFHlMuXohDpccQ8LpBp9o3Qqfy4Cjyn2SjW
	TQlYto8dR4h5nNA/O8fW8vkQWVg6pBLw8dHkOHwDApS8plUASDGMjMAmMm9PXVC5LXZPokHSJjG
	Xqtz1zcay96pHEpRL8sN/2zHYuEdyXg/D2DAVmPCPP4Je8zpQCTslkB7TPRRpFDpOVD1TUf9nZ4
	lsaVf9o0VIm7lgLgqygddjFrz4/R+0Z5j79Uv7vWlOcpetEbR9yKoEYhta+OsvWO+poTAe8ibtr
	d0=
X-Received: by 2002:a17:90b:3d8a:b0:35b:e4f8:7b2b with SMTP id 98e67ed59e1d1-35de68ebaf3mr6615006a91.18.1775304985367;
        Sat, 04 Apr 2026 05:16:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de500c42fsm2702745a91.0.2026.04.04.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:16:25 -0700 (PDT)
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
Subject: [PATCH V9 0/4] Rust support for powerpc
Date: Sat,  4 Apr 2026 17:46:06 +0530
Message-ID: <20260404121610.1956528-1-mkchauras@gmail.com>
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
 rust/Makefile                         | 66 +++++++++++++++++----------
 4 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.53.0


