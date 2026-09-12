Return-Path: <linuxppc-dev+bounces-27167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A682BC88E45
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:59:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhj2P16Dfz2ynZ;
	Sat, 12 Sep 2026 16:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789196365;
	cv=none; b=KTvxhCYaK+XxGHwZSp2GLzOjJh8G/MiqcyPaLADOFYYm6gslRIjxaDtp5JsUftiJU9FSvUyF6xW3/hWCtb4R+aWQKbC46xoiH1noYbgmws7HNm5+fRQR7Ufd4w54N8v8AkG58+a67vCkD+fGoAYjt6YmZpcv2jiMyzoEBXTNFh5ULEOBrwFNBNiD5NvzhAIvh+gQWItWyGZypK2vmqv5V4F2wydQCDfsrkOhpBHqIZfNEnzvjrIOm/4RSJ0ugxQ4S+wOZqff/IDC279rj2SCkaI1BIpsEgc7MY0/eDgLX6Y/yOc0p23nfib+ZnRz34C5E6g3Uf1cb7dsZBgUr7BGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789196365; c=relaxed/relaxed;
	bh=DPtC1KNwT+749TftCz7aP1Y3qEPtVYfk7lU7EbxfQRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkiGv85kfICyaH41VQ/HoXdlLMkQxRcypI0kzidnlGesGh+tLHZ9nZnlViIpzZbRjSRY/pdS3q/+otUswkYtXn6OMzOSr19hpZ4mIg4CZ/rYKHBmyRLzOC+Gobhk76DZfKGZZJflXgNfp05UVs6/g907/1tRYsf1nXda5U/q+bx8IKatfd1lLeV20WTWIhK+BXwjCtQe+8GxEybyaBvp2aIZ4JLwvZ87zbjW+EWtrGsh+JhV411aRZ920cMX9z0aT05UYRNgSMb11WZG1eg6chCyBtS/piaMWQx28Xs57RnQv9vSNDcTGdwgHf/nv01oCqrEh03kIswCK73/kYloaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QGhYCmGr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QGhYCmGr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhj2M1S5bz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 16:59:21 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2419122a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789196359; x=1789801159; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPtC1KNwT+749TftCz7aP1Y3qEPtVYfk7lU7EbxfQRo=;
        b=QGhYCmGrn5XcnfP7+paFzT2zt3S6Slm3QZIaIOrYGCUZlrFygTg+Bu5aldBj2FhENT
         YfUm57O+zw1LN6r311Z7k7Eyz1tAHvzLidhprcSp/sGC1MNWoAXgp9YdXebJvlAzyvC2
         sUWn8gtGUadLP0WZNHjE0KFEFsejwNpsLsnx0+3uL2VNXn61zShnNRjoUy5McX2b4TpN
         D6sN5K+6Nb63Vsc1bGL6hqBZ5Hys0qSD+AaSam/ENzBg5nsVSWRsNiCA7ZpzmRzwwU+r
         89rzHWiYxKPioh50YBwCAbjveAuGKsZUDCt2JII9SMezRsILcGq+AS/vmb24XfZ8F2Hg
         kr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789196359; x=1789801159;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPtC1KNwT+749TftCz7aP1Y3qEPtVYfk7lU7EbxfQRo=;
        b=ZE27FJpqLna5Nf/CYaxt37xiqjbxb3NM9S0WdIk48Bkwu761P5lnCJiBvO4qiAz6c2
         fwilq1ZKOIfwSoJTePaYCOJsF6a5SOOSKxbTor0loKQwfgPIhCsAwsr+d3cfUF50Naku
         XtwZ29UglP5MfoqfpnCfsDAHWezP8QJ+RAe4elfNETzztwaY2yHFVd4guu/VM078HpxY
         IGrgooVrce2YXQg/mlpKdfRTD8HL7gH5uObtUAR8+vxCvR5rD6qDJWR+ymsHaGbXAn4X
         hEhcfhtWbL1EAri3OsHpEEBzGCfM6+Qt1hYUgKJ8E9lv0IxdTIvw6XcJzcPopCQWMd52
         8jig==
X-Forwarded-Encrypted: i=1; AKwUvBxS2cdrGm92BZDUUjzJAiBAbRHrJS90Li8tZJ/UC99ggWWcYFuTewhHvMj/UQiISYsDljj1X4rkuQwkGG8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k+pLl4YEpIkNQsKya5bDlJh0PmKL0p+XWM8aoN/G/OwUvuEsX8
	H52ZOnJu0epicu+O9xW/TPzVJptQanrAkCzX43Z5BXRrLD9UxUIqWu4/
X-Gm-Gg: AYBFou2MR+h6l0Aq/vbYGQwn7hDxVoyhxKWmspLg5tj83JeBRT3wVGzhj93sR8pD6YM
	m6hWAd3h4oq5ORmo8Jk69yBy+36i9BAIIyVgiKUORxCwLpLRy5tYqQLk/xBBbrJCjlCbvMa6C/F
	jkx2GTE2hle3DK8PtutEbAE9oIW38xYNurK2C4dMB38ytL7MDSJsCUA0hYqFlWZDIXP/5MfpweU
	JT5wCxyn5JDUTErXOUEv+xekwOqFMw0c4NmQybGuXzscWuLV1RVqoSL3qYPz/7y30NYr4+dzonS
	ynptN4xSfxm7nSbKpvpiABrUnevZSprOrSe/xX4Tu6jFwySR+6fHRPljraAbMKuH9Glp0e18Rbx
	IoyuBHD0Zwa7B+1m1nxcCEIjTGmsa/HaZqnzc0OkC4413+hVrJsYYTJc/TK1wdtWDg4DQL1SM9N
	hqSJpPwECFklwKu8hOAm2C2OE9SHA7h3BfZ3k1xMRnOkFOXHzlVWGoZkCuTZ9XTA5FOr2Dx+Fqi
	582VQ3g4eunmKJ0EGN7AOMgjn6AzaaC1yfnzC3MZQOLeQ==
X-Received: by 2002:a17:90b:2d82:b0:39d:6c95:7e4 with SMTP id 98e67ed59e1d1-39d77d205f7mr15936166a91.31.1789196359477;
        Fri, 11 Sep 2026 23:59:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm10777777c88.8.2026.09.11.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 23:59:19 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	mkchauras@gmail.com,
	ynorov@nvidia.com,
	ecourtney@nvidia.com,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 0/2] powerpc: Add ARCH_WARN_ASM and KUnit tests for Rust WARN() support
Date: Sat, 12 Sep 2026 12:29:00 +0530
Message-ID: <20260912065902.24017-1-mkchauras@gmail.com>
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

powerpc currently has no ARCH_WARN_ASM or ARCH_WARN_REACHABLE definitions,
which causes Rust kernel builds on powerpc to fail with a macro expansion
error when the generic Rust WARN() infrastructure tries to call
ARCH_WARN_ASM() through generated_arch_warn_asm.rs.S. Every other
architecture that supports Rust (x86, arm64, s390, riscv) already provides
these definitions. This series brings powerpc into line.

Patch 1 refactors _EMIT_BUG_ENTRY in arch/powerpc/include/asm/bug.h.
The old macro was a positional-operand template that hardcoded the 1b
label reference and embedded .org/.previous directives, making it
impossible to compose as a free string outside an asm operand context.
The refactored version takes explicit (label, file, line, flags) arguments
via string concatenation; .org/.previous are moved to each call site so
BUG_ENTRY() can continue to pass sizeof(struct bug_entry) as an asm
operand while ARCH_WARN_ASM supplies its own size string. With
_EMIT_BUG_ENTRY composable as a plain string, adding ARCH_WARN_ASM and
ARCH_WARN_REACHABLE is then straightforward.

Patch 2 adds five KUnit tests under CONFIG_RUST_BUG_POWERPC_KUNIT_TEST
(depends on PPC && GENERIC_BUG, covering both ppc32 and ppc64) that
verify the __bug_table entry emitted by ARCH_WARN_ASM is correctly
formed. find_bug() is called with the exact virtual address of the twi
instruction, captured at link time via a .dc.a relocation in a
global_asm! block. .dc.a emits a pointer-width word (4 bytes on ppc32,
8 bytes on ppc64); BUG_KUNIT_TRAP_ADDR is declared as usize on the Rust
side so the same test code is correct on both. The five tests check that
the entry is found, carries BUGFLAG_WARNING, records the right source
file and a non-zero line number, and that the trap address lies in
kernel text.

Changelog:
V3 -> V4:
 - Fix Label with appending b at end 
 - Add KUnit test patch.
 - Tested on ppc64le pseries:
   pass:5 fail:0 skip:0.
 - Tested on ppc32 QEMU mac99 G4:
   pass:5 fail:0 skip:0.
 - Tested on ppc64le QEMU pseries:
   pass:5 fail:0 skip:0.
V3: https://lore.kernel.org/all/20260910100801.2159785-2-mkchauras@gmail.com

V2 -> V3:
 - Add label argument in _EMIT_BUG_ENTRY
V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com

V1 -> V2:
- commit message now has error, fixes tag and closes tag
V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com



Mukesh Kumar Chaurasiya (IBM) (2):
  powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust
    support
  rust: kernel: Add KUnit tests for powerpc ARCH_WARN_ASM bug table
    emission

 arch/powerpc/include/asm/bug.h |  36 ++++---
 rust/kernel/Kconfig.test       |  13 +++
 rust/kernel/bug.rs             | 171 +++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 16 deletions(-)

-- 
2.55.0

