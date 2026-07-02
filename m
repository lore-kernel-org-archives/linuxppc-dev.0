Return-Path: <linuxppc-dev+bounces-23366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE422C43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:21:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVGS42VKz2xPb;
	Thu, 02 Jul 2026 18:21:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782980496;
	cv=none; b=VHzi5ztjIzyaQk3Fk/+/hqNbOHcGwolN6fC41LgHw9uHmDK5unkAeIKiuh2wZWSO2tafgCXyb5oyTBe2SXND78mJoJoKvixQOXXjv/dzEuAFoQto9EiFvIxyhSamLkQ7HDVhcCA2PGAlb//Ey2QApW+aFhj+HLLIX5nZgqo21TP1qFKmdrhvFgG9PBTQSKTe6MDoZXE7+dUwuMns+/th9OpD4cRRGyZO/uFdRtSxQF+iLI5748XnNdxSwWs0csSv5eK6EQeeyCixWWHh1/i+wTl5CsX7w7caMbJRkITeqYGVHsx4Ky90rAf0Wgd46U3DdVebRr/qbI/rgLtaBA5cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782980496; c=relaxed/relaxed;
	bh=mJSzPYcuu70d1v2EawqMn7TqthwcQ1ssQg57IVhDWI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eytkR33srHIR0TipxVQ1j/rqyuScLAKXKcEW7FOKREC8nX/8SHGso4QRGU7E3EuAeW805cDC5xwx5beyEkcW3c26TwarKZ8qn29eCmp74bLQNnNgr6+s6PSry8hNfgmVStIvFu5lrrxJQCNqH7EoOBHcb74SGFZSwxDlD12Tx3UZ8x1xHR2JHKJY4qfYjRl+5AU9EWtcsLiFXSrivLjXxnEVuBSOXU6gtGIG9RZGLvXaqCX5i4RTq1TB+3iWNE0em5ctsslwN2iRBuUW2z5JOFkVE9uiDxIrhTK6Bi7B2wDu3HgkA2C4cpuVpRMvZs1Vw5NI2r+1Trvyp+B6qQa7ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=of+N59Ha; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uN9Hdc83; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=of+N59Ha;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uN9Hdc83;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVGR34Prz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:21:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJSzPYcuu70d1v2EawqMn7TqthwcQ1ssQg57IVhDWI4=;
	b=of+N59HaFTcbezAeOk+/17hY+A9dAUMSL0R9JbFEMZlA+nby5ylWi5WlxMj2cbxVgqtoX6
	3ROYEFfYafIQYkmKGJb3YKKBa8oT7It8ES1jGDuDnHZJg6BLs8TOAxVlYtOUje+4JN5zUh
	6rlS5LGUaV411jwX0tZLB2y1sqG3lcNLRh+9913Yt+jc2oHHKtciVLG5TH2EiEqdQyI9iT
	uGULIJoJUlBFYcyCwNWA0mQgbR8IdI8+L8xAOlesgBKm/lm+v/HWEO9qNkt66NrD7OTPU7
	VsVL0vpxTO7Xh55obb8zzMh8t1KQ+g4ycfp6un1P5BGtR3J5X8ButatRWQK55w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJSzPYcuu70d1v2EawqMn7TqthwcQ1ssQg57IVhDWI4=;
	b=uN9Hdc83IPYWMSKfkIs/YtSKjNdtWXYIe8rXO0da85TsqVeJfAaNeJbY+tm0TW1LYRA9+j
	B/4b13cGjW5KHSCQ==
Subject: [PATCH v3 0/9] vDSO: Respect COMPAT_32BIT_TIME
Date: Thu, 02 Jul 2026 10:21:24 +0200
Message-Id: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNwQoCIRDG8VcJzxk6lm6deo+IcNepBkoXNdmIf
 ffc7RAEHf8fzG9eLGEkTGy3eLGIhRIFX0MtF6y7Wn9BTq42AwFaSKl4cSnwLtx7m08KWsqnTHf
 k2IjGaIVboy2rx33EMw0zfDjWvlLKIT7nP0VO64cEMP/IIrng6iyg0da0tlP7G/lHjsHTsHLIJ
 rbAl9JK/KWgUhsQTm7Xei2c+6XGcXwD1i+6ywsBAAA=
X-Change-ID: 20260113-vdso-compat_32bit_time-e808763e976a
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4251;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MR/1oQsubIswpQ1T7czms/mRrVaRqITHlz2n6JTUpl4=;
 b=IAPP7P7TT/qjpqsC8+BNXtHg/cnx42xojUXsQ9R2Hz9jbgOm2ACYHF+sMsfHVfS0U/4lV37Yl
 zsUyVwUeFmFBYzA4OF5fifGvug2xcpYakRt7qN14FxkhZlDROdgH2hq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

I also tried to introduce some helpers to avoid much of the ifdeffery,
but due to the high variance in the architecture-specific glue code
these would need to handle, they ended up being worse than the current
proposal.

As a side-effect this will make the self-tests more reliable,
as there is now always a matching syscall available for each vDSO function.

clock_getres_time64() was only introduced in v6.19, so libc implementations
are likely not using it yet.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Pick up tags.
- Fix incorrect references gettimeofday() in per-arch commit messages.
- Test for CONFIG_COMPAT_32BIT_TIME over __WANT_OLD_TIME_TYPE_SYSCALL in compat_settimeofday()
- Link to v2: https://patch.msgid.link/20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de

Changes in v2:
- Also handle SPARC.
- Drop MIPS cleanup patches.
- Also handle gettimeofday().
- Add more static validations.
- Rebase on v7.2-rc1.
- Link to v1: https://lore.kernel.org/r/20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de

To: Andy Lutomirski <luto@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Russell King <linux@armlinux.org.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: John Stultz <jstultz@google.com>
To: Stephen Boyd <sboyd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---
Thomas Weißschuh (9):
      time: Respect COMPAT_32BIT_TIME for old time type functions
      vdso/gettimeofday: Validate system call existence for time() and gettimeofday()
      x86/vdso: Respect COMPAT_32BIT_TIME
      arm64: vdso32: Respect COMPAT_32BIT_TIME
      ARM: VDSO: Respect COMPAT_32BIT_TIME
      powerpc/vdso: Respect COMPAT_32BIT_TIME
      MIPS: VDSO: Respect COMPAT_32BIT_TIME
      sparc: vdso: Respect COMPAT_32BIT_TIME
      vdso/gettimeofday: Verify COMPAT_32BIT_TIME interactions

 arch/arm/vdso/vdso.lds.S                    |  2 ++
 arch/arm/vdso/vgettimeofday.c               | 14 ++++++++------
 arch/arm64/kernel/vdso32/vdso.lds.S         |  2 ++
 arch/arm64/kernel/vdso32/vgettimeofday.c    | 14 ++++++++------
 arch/mips/vdso/vdso.lds.S                   |  2 ++
 arch/mips/vdso/vgettimeofday.c              |  3 +++
 arch/powerpc/kernel/vdso/gettimeofday.S     |  8 ++++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S       |  8 +++++---
 arch/powerpc/kernel/vdso/vgettimeofday.c    | 16 ++++++++++------
 arch/sparc/vdso/vclock_gettime.c            |  4 ++++
 arch/sparc/vdso/vdso32/vdso32.lds.S         |  6 ++++--
 arch/x86/entry/vdso/common/vclock_gettime.c | 20 ++++++++++++--------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S     |  2 ++
 kernel/sys_ni.c                             |  4 ++++
 kernel/time/time.c                          | 24 ++++++++++++++++++++----
 lib/vdso/gettimeofday.c                     | 20 ++++++++++++++++++++
 16 files changed, 114 insertions(+), 35 deletions(-)
---
base-commit: e6da2429169af9b33f3629b69905d89bb5ee9e64
change-id: 20260113-vdso-compat_32bit_time-e808763e976a

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>


