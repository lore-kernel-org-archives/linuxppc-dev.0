Return-Path: <linuxppc-dev+bounces-27300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64654C88E73
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:05:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkbhG4mLjz2yFW;
	Tue, 15 Sep 2026 19:05:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789463118;
	cv=none; b=K4RbHBgylKc8Nt149i871Nrc+ZjXeJYWc9wiuMr8EHHjbFD41YJnV5qIBAWpM3E23KmJ2vgRXKNBCHeXywtBzT1FR3uvCklpXPWTwQ03CW9Pr6CdpLiXmI7VNQ7MuZ7T9zBzJ2Q2FzLDXgyI7P32i+xWpiP9yoiCPSfOMI8sc59HZbuSs/iuYLpGBVRfoKh3HTWuKYibDlrbdV9hyqjJqbWI2xXVYHWRyHJWWOBLeh9h4ko6GJJjLcro3TxtcAJZhSAy2L++KFk7w8vwffVDC0BKSgOKT4qrdmD0HNa7vBW7+sqTiXD7uVArO2e6DZgnLweXq7KQYvY87FETc0nqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789463118; c=relaxed/relaxed;
	bh=5OftSuNw6O3AgitXo4CDVX+TOcz6GDkEK6rb5ipL/z0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of0tKvcEp0yOSQIe6F/+TRPdrGdd3K4qy8nRSvIE7YePqet8qmGdvVS3p/8DCGMnXleCHIipVgyVX/GgXkImPSkcF7IsvXuYQ6Pp9s0e9OV0h0mTEr/MmyVnwZducoQpNrS97aOY2ehFknOydcmd4b1Njt++MWpb26h8p4vTJEk4v9pcPZqtIg2i2VFwGcV+e5hAzj1WbHPyhY6VDxaVPmARblKdhgCkmzj1pZ5Y+/tjM+Hb98bv//ZVZkiVHgWM9OGG9epTTmC5s+RuEdSqIgvfFIvKKbxU4Hd+LiAp0GXtmYBtwyV4zKEwvT69JiOylh5Uanw7pVpHFJhzC6/UEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I/oTrmZr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I/oTrmZr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbhD0cP8z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:05:14 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so29163a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463111; x=1790067911; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OftSuNw6O3AgitXo4CDVX+TOcz6GDkEK6rb5ipL/z0=;
        b=I/oTrmZrwOXNIZ1EAfZPVZrskyUgJADiGxVi1hWxkxsrfZkjxaa+4Td7kGgP2BdssH
         cpfE+0UQ9Xq2PydtwscMIqxFXy/ahb2lsQOVyk4VwmYRhXwAZlClOxokJxd4M06Rmkba
         iHXdrfBzduupGoG7EQ4P8p1J7FBIS0dSnHpk8EWUaR3rrY0sZiEpvsL4Jm3OVZye9Zlw
         bDpmYd+GKJiy/8+bDRz4wIbSCD3J4JSX0GVUrMoM3i0FCbgyPQoyl/amFDMazSZmCu5G
         S9CABPJIqLtNQD4YX5pAb9tEXsad0VTKjW+/ZvDBaaQFF/EPid7EPVPQuVw+uJd8LinN
         NZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463111; x=1790067911;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OftSuNw6O3AgitXo4CDVX+TOcz6GDkEK6rb5ipL/z0=;
        b=VwMWQPg9y8pPaBNZYMv2MMglqOc0tssM+oLAufWYE8wWmjA9Oejwdx5eMlVbjI5WS5
         C7fqfXeM91DJ4oNqctRA6d+HddhVOEMC4Yvi2RdNVsgs8TjyobYRWNZGoceGCjAxGyyt
         McLGOxSH1hqBqbHHWToqVyPUcAzODE0Umn8V5aQP5eQxSiiZ8E8Kk0dIXqRgQPTGJRu4
         QR1HO6t36l++55a2X9FJf6buch+p7w0AyDdKX09Qxt6Y92gI0MyjJvJFekO7ZTVKKVjt
         4RzPmf0H6WI6T5IoY6L7vbjWb09kK+oeYSf6GJtZKF8gIhVXemnw3OMmit5SXAbS5tyG
         QVvA==
X-Forwarded-Encrypted: i=1; AKwUvBw/+tbcm/lfrA/KgLOeWFA4/Ye5GvBEDZrNrqYLCQg5B4+LRX1SgQ0H9BivZQn0fqXTqHiAyfYMP1O/o+Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lkqtjqRtlGTBKaIHdnL4Ediy8RAzd0Ay0l7h8GHmzVKksmKfGw
	8+4KwD1yEtOQSKMY6HDuV9xbuB+phErAfyfB4Y9KvjKq5BywH9V3nj92
X-Gm-Gg: AYBFou2AYSfR0lB5oJ+OdjUt8Zd1oWewlO1MFYv/e1OjMMevrlOtPGHgJspTBmzTCfw
	JSgHd2yLW+WTpetOnrv1x03TVlbh34kM21/FrnGBZ+IeobTS0B15XFrjB+KIWH54h4cR426+n1i
	Rq572hfqsS4On6V/zk7ntQSSja4EB2EcYFUyCIEHj0vM20UEFzzBa2z/OoHqNVphCOMkgTzhsAA
	A30fHgqvZnDDg66r0WZXJk2zwszhATPWsk5DZRxksqj+lh6xQCBHSQ84Lc9Gj+pdCdqxt96XFL8
	OmjR15Ilpa5LAjlsLgcM1CnFOfg91+ei2983+AQlknTW77IqkYAXg+2tpz7YV8ohIS2rQdN30WD
	MSnzD5nXxZArZJ79D+6aEr9DnLnGzpxPHmAhvh0CP7ugxXs2o9cyeSwqtA+LTTlmq8dI4Io3TbW
	lLqIpw6YpjPDltkn9+DSVnEqKH4JLkhqVvVwW0ku9kJRiHNCaeXcD+HkexCSWcsOXtrTgXoDGLl
	XTBWTMPjpmZZ29GRcyZ3YSN426KZb0or5JEfOhLqZv0eX7+QmMd
X-Received: by 2002:a05:6a21:920e:b0:3da:f21a:23ca with SMTP id adf61e73a8af0-3dd52a2a52bmr559662637.22.1789463111413;
        Tue, 15 Sep 2026 02:05:11 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65a8120sm6495512a12.30.2026.09.15.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:05:10 -0700 (PDT)
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
	david@davidgow.net,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 0/2] powerpc: Add ARCH_WARN_ASM and KUnit tests for Rust WARN() support
Date: Tue, 15 Sep 2026 14:34:51 +0530
Message-ID: <20260915090453.1227034-1-mkchauras@gmail.com>
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

The global_asm! block is split into four cfg-gated variants covering all
combinations of CONFIG_PPC64 x CONFIG_DEBUG_BUGVERBOSE. The split on
CONFIG_DEBUG_BUGVERBOSE is necessary because when it is disabled,
_EMIT_BUG_ENTRY drops the file and line fields from the bug table entry,
leaving the {file} and {line} global_asm! operands unused — which is a
hard compile error in Rust. The split on CONFIG_PPC64 is necessary
because concat!() only accepts literals (not expressions), so .balign
4 vs .balign 8 must be selected statically.

Changelog:
V4 -> V5:
 - Fixed a build error with DEBUG_BUGVERBOSE=n
 - Added a label for bug entry
V4: https://lore.kernel.org/all/20260912065902.24017-1-mkchauras@gmail.com/

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
 rust/kernel/bug.rs             | 222 +++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 16 deletions(-)

-- 
2.55.0

