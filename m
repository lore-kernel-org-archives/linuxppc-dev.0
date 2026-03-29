Return-Path: <linuxppc-dev+bounces-18971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64331F3D610
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkK0y3VmTz2ySS;
	Mon, 30 Mar 2026 03:03:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774800194;
	cv=none; b=SG8xGj9X9YvBcYxyYCXyfBGW3547Axgxc3dpVFS2VdOnPk1OYppfzS+teeyHM+V91Fyj+C1xNHwUXbUQohdwUqEcTjPjVHPzlAtSOpAALV1t5zz0u+ZVYqXxUW6lA+/Q30GCk6NubEs7yGf/7BUMimoHiLXArqRlZN7MGjdzljq9KNhLMJ8u66xkIlLxYmAW82kuyEmwlRmqhi7IRhW4F54o0CP5jJeWAHUts49ARLADUzUg66HhAoLJPzo0UCUhbYGYJ4EbJmoy2F+V/78AHX6eesmO/SkgnLNvBIcTygCQV+o21G7Y95rxGasNIhYwovtiGkx0jNtAjBZj7gugDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774800194; c=relaxed/relaxed;
	bh=RJWuo+9xSqQU3Qf5pjDrFaLqDSLZxCVWVnyQisupYyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDzrx/9QwqI9pm7696f/9LCIjIT8kzQNElTcBBP1ej7nPZyY2v20DFAiD5zhvfOngl29YmX/Fvwlgbd8Lb0xy8fCcFqJXtNUNcaB8kkNFG8VcSka8l0jnIVJU/PbmaZm7QJcEaDqrCcWy8i2QOZOBVTMoeb5MlPLb3SJygEDmcS03XdzisqxflWLp3ux71b5aod5H4+uyCXtNaiba00PQeLe/BDrqEo1z5AZGDuERLOqBPfPQ5XQsG4G04cfcTp5vu35ajaBYvvVC/WE5Ys7Kqs0gpBwatChF6iQyHzchHyyihAqyDim3qS+rcQlPnBb1snte8j2qW3dsZtzetyDeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rGc2/thV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rGc2/thV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkK0w3nY0z2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:03:11 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2a8fba3f769so14585545ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800189; x=1775404989; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJWuo+9xSqQU3Qf5pjDrFaLqDSLZxCVWVnyQisupYyM=;
        b=rGc2/thVrkq1tqRb+7tLiNsK9PDZVe2AbJFOzRhEp8QWTJwO8Z2E6f28mtXYoCT7N7
         JcZqCJqu9KplD+dQ3S1qtg+XH4Ybi2kq8hGaYw9lrE/Hb/L1T2uNP4bKF2yjg32As5Bt
         ESiuKRXGu8g2fosLuNZPjj+RtCpR6Rmxna49Qj7mDlsWExbdlGf1aJ5nW5Dg5wgc/1/k
         4/wZ6u5/J0YygKDmZ67oZXY/r+GMX0xg4+U2F1oPRJtDAJYcAsWX11Bt5Q06TFsbUtlL
         zR5KiRIW0jDudBbZv6nd7oYOVD4/Chuzngelicr0HmrPNP8AMnojLEv/oEXlRDN3VQ8N
         9w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800189; x=1775404989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWuo+9xSqQU3Qf5pjDrFaLqDSLZxCVWVnyQisupYyM=;
        b=ZMMQUtKZt/WdXD2ClW5z7RRdILTiOkVEGKfqSG5+ABSSwzWLxNZtFkYkuL6gVBA3KG
         eUrF57UQeZKCbiLyePA95xq09TOsPnR9VZ0toCuOqmcnITr+Vq64uNFzDaa38Ry/uR4g
         krQ1FIJ9fjZSCio+zT5hz4ELXOCu+Jt6NHnTm4LaQYNzrtQWhFKLPIIWF/QIE7ylVy9k
         w2wX6NlDA0MYP5jzmt15EEW+/dKrj3VZtwOB+DONXITAXCjAOzfNPtF+Lt1oTEQL39Ca
         4g2+0NjRbHPIpNTz7VyKrB3AdD8XDOt2TZ0pwRrX0Bgod69B1ba6BSB5qrazpe7IES+G
         u3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXezxuMfkC1gCpZ9wiHXulEMbB5ZEUTrnOBuSPWwS4kSKBir+w+1fkg6RG29UuOwCjTE6sJLXdVm1SAiS4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfR4isH3T4Fof5DQDnrMK3cEHf1rudSQLmXeXpnxiA7LTW4yc8
	eumdUyQ7lrsN0e+vwv/Mxv1dd8YPsjy10OMFYFFZZ+Ji4ay+DWhZ/14s
X-Gm-Gg: ATEYQzxpLM/thQ0G51RrGDjI/DfwUFFBckL6nnoTxkyYefsIanXDayrMusnPLzMasZn
	vMMBHVyIuwZBWOyPgDN5Sp5GP0cgmD0DmtA6T8ra51qRIS2WMYJLZSWJiIadDvAGLPGpq+ys7MJ
	1lOdErNjGlnrvXzkeeBBWsBNlFsC2xmxS0vn8pnQnVyzoQf+CxN9ud1OFgd3n9FX/Z2wn3XN39K
	2QWR6dK8KP6+18AaYmqj5qJoGoAMDglr4o+AUEK8qe0t9eceebp1smRP7oAQGWqW07/KiSVF3xX
	O2xlWwZ9W4TOdXKA+Y+blJSh5fTdNXzlVo5qf7Xa0LOO4K7CwVBomUEAtk/B4axl8ZRzvvZm1w2
	jWVnScXZwmYQnOT16rO05+yOxC+TdFgyQjdKvbZP0P+8qrzg0btDxc/F6EzWwDsx46f6RhhuJtR
	ikF7rAHZXkITpPW9+7V1918Ibu0lSMGcPzCwP/nrxGGGtwtTKNpfg3k6WAv8quNDdj/PTLLRYO7
	vo=
X-Received: by 2002:a17:903:19d0:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b0cdc02e54mr102192735ad.10.1774800188509;
        Sun, 29 Mar 2026 09:03:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm52521175ad.77.2026.03.29.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:03:08 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V7 0/4] Rust support for powerpc
Date: Sun, 29 Mar 2026 21:32:50 +0530
Message-ID: <20260329160254.2592207-1-mkchauras@gmail.com>
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

This has been tested on powernv9 hardware and power10 pseries qemu.

We are actively working with our LLVM team to get the target for ppc,
ppc64 and ppc64le in the rust compiler.


[1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
[2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com

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
  rust: Fix a race condition in Makefile
  powerpc/jump_label: adjust inline asm to be consistent
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                  |  2 ++
 arch/powerpc/Makefile                 |  7 +++++++
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 rust/Makefile                         | 13 +++++++++++--
 4 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.53.0


