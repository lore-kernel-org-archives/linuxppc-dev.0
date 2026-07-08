Return-Path: <linuxppc-dev+bounces-23778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D796C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:16:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9tJ505rz303B;
	Wed, 08 Jul 2026 18:16:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783498616;
	cv=none; b=mKW4AB9SfkNw0qyNgdRuTiC1NNv76azp4k36trannn9cHpE5Wgyi01MpiYiqBx3iCbTkCK0sVz8SwhLANtmtsMFae7Av9wzk904HZB0puq3sbmKvIkvm378FUZfOjOLUMluViZNHx3J1i2h5jYLGhxtAMx5tpncuoxIB8D5oex9RWfdXZiGmqqiLALKt1iO5pwXqrCE0uKH2MJPx8mgMt1LLnNMFCTDT4nXhMpY0v7odTLQLuj8TTHlEiFDxb2Y08pcF73kHLvYf/jeJkznsQseOePkQm2yE6ZZ/CWEirXIy2fl4PZ2lBy+tGC0R4CYvaTrT1X6NbN1EsoxWkbWYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783498616; c=relaxed/relaxed;
	bh=OKHyME7FzZLUkSII5idM6IXVqJSLJz+6sWzTPKllxxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sh7NIcgRMeXT23c6VarmN1F/CXM3gnMcrhd6rWd0Hf09qX8mnErdPRRx0nSKJTTCtsdh7nrCfKDaEHONm9KTmPAiF7+zt8T5u+OVFOeO9Vkbv1bvScDyPA+EtQntgKEhUEaTkJ+falAmS6ou2utcz3lauDKA2tMs7Kxn9PkT8jqiVYZoBP8eppHm2CpE0y+lmH08MQqprs7C8fnjUtMEpZ645PqdTMgzGBHwA94bgn5PsW/89lx1/O0xA1wPOXgYcBEs0tPn+jX3hJAVecwqt4KX5D0LOq3WvbdIa4n+JC7DdO/c/Y1hHvnqxxZwI5FpB89uCVccqERCeAFZvG1efA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HXEECLTd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HXEECLTd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9tH196Zz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:16:54 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso327045a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783498613; x=1784103413; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKHyME7FzZLUkSII5idM6IXVqJSLJz+6sWzTPKllxxk=;
        b=HXEECLTd8bW1x5I+ur89plLxl6FN4FlLjq1qh6snYXArnEvpuUfBl0R4f9shB6/px2
         oO+E/zcw1c8cAEIRi7FWa2WLjHSDE4MnsJPTYIKCaGS8Hw9Vs+GNMFNI7QQHG4+TT2lD
         U3YfFsvWRIQPpr7ypPc1qUonzYrDUuImfLLjbBIO6moIKjwZtb7tdNzUqq811FZRDV94
         +BvU3IHLZeGRsz3AMYUXjjktw4ICNyCWxAJqKX8GbAU40BITnWQoie5Aa2ymD9p++qPs
         ldHjh9eVg4SzVk+tP4NVqJl54pvv3QHLYBK+qr+DVaTSR5o4o2SiwA0ONZLStUNaBLHY
         dH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783498613; x=1784103413;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKHyME7FzZLUkSII5idM6IXVqJSLJz+6sWzTPKllxxk=;
        b=cDqUFw3Zipup0LFTx7GKmYgTS6yAtHyYEJ/JCIneAaBcQEa+KVxS2lWrDtIrUMZgk0
         12ui75hftjQsTksWk06hC5eoYtxpdi4fJsYXss+ZefI4k+uVCaWxCPy6R4SddO9FRbfN
         ACNBWdAx8lb7AgnzxOzEVkTbAoyRTW2w0Ibw4YQ3gnkFACSthpODpUS/kBIBEqYKOxV/
         vVFDU8Z9hAinYV2jEMy1NK40mWSgKaAKY+AVppo/zert6hhA53a0lwb/lYZMXA1HFTws
         YSXqA3pSnLqYBvdXx57fnkn6hPajPmmdCo+T665OGY4Z5XgS5A3yCRyQvgeyUpHod1WV
         6I/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro40lJ5J9ufZ+u3IDHt4+U5WYb7ofqqk9lhRf35RLLOiDPHqPMDqxfR3Uyl4WO7cIEgILnfWovrgfslVuc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxtd8mE47nHqxq1cr99a5PDuy+mWXrpt2dd0JmCO3tgpDvRnQpb
	nEllYcDSTKGR+6a93AfFgmT79CJLi1lMOmh1eOhTrqsW7zL/Nc1wpa9S
X-Gm-Gg: AfdE7cmpdX/S3JwGgMZl/6EuSMT6mFKwaWhYYmfXStivtgvsIziA+pCcdHIX22EqcVI
	1Xls5gwXO7QzWYawvprHBgsgMF+UP+js6uhuqhx1GDyOFzjhdnwrTxazsyMahFYGuFWTZzyRgzc
	Pst2i45rs499532KKxjaLgpD4xhpW7FU4ZJ2Gft2h8bMvNVsF/FI4gv/GWM+FbJtiaGkcrRPry2
	a6XiPK14b7TMfggZvLhoeCG7S/qK6RXfd/pPkTUBOvT03N7oPEVIYHflB0jSBdxGGTGtkwKzrmj
	u5pmiBWh3rXxAsOTuXEtIDCB0SXPEjrm/G37VAK8kjdq+e3tuP1THdZU+4JM8zAa/jv8ELkyBr+
	Z6TNtfLSHF4ki62efxN04KklbOkplwwo/662WoTpJJvzHxa5mrY+tZJZ6JrpW1ZnAS/1k81soUB
	O8hZ+buEcbtILjptrobZPUfEV8sqOuFlBX2qo/Avu4SSUYj/+FpoS9OZQd1w5QFDsCdg==
X-Received: by 2002:a17:90b:4b11:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-38941201e18mr1717208a91.20.1783498612611;
        Wed, 08 Jul 2026 01:16:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm16346132eec.12.2026.07.08.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:16:52 -0700 (PDT)
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
	oleg@redhat.com,
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
	msuchanek@suse.de,
	mkchauras@gmail.com,
	sshegde@linux.ibm.com,
	mchauras@linux.ibm.com,
	thuth@redhat.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	nsc@kernel.org,
	japo@linux.ibm.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V17 0/8] Rust Support for powerpc
Date: Wed,  8 Jul 2026 13:46:25 +0530
Message-ID: <20260708081633.1248382-1-mkchauras@gmail.com>
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

Mukesh Kumar Chaurasiya (IBM) (6):
  powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
  rust: Fix "multiple candidates for rmeta dependency core" error
  dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is
    disabled
  powerpc/jump_label: adjust inline asm to be consistent
  rust/powerpc: Set min rustc version for powerpc
  powerpc: Enable Rust for ppc64le

 arch/powerpc/Kconfig                   |  2 +
 arch/powerpc/Makefile                  |  7 ++++
 arch/powerpc/include/asm/jump_label.h  | 23 ++++++-----
 arch/powerpc/include/asm/ptrace.h      | 22 +++++++++-
 arch/powerpc/include/asm/syscall.h     |  6 +++
 arch/powerpc/include/uapi/asm/ptrace.h |  6 ++-
 arch/powerpc/kernel/ptrace/ptrace.c    |  2 +
 arch/powerpc/kernel/syscall.c          | 18 +++++++++
 rust/Makefile                          | 56 +++++++++++++++++---------
 rust/compiler_builtins.rs              |  6 +++
 rust/helpers/helpers.c                 |  2 +
 scripts/min-tool-version.sh            |  2 +
 12 files changed, 119 insertions(+), 33 deletions(-)

-- 
2.55.0


