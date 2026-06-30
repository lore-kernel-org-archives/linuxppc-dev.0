Return-Path: <linuxppc-dev+bounces-23160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD0C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFXV71yYz2yv0;
	Tue, 30 Jun 2026 17:44:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805466;
	cv=none; b=dDSups2jYMuFYdw2oIix26iRyxbFXFwU/mFhQMDx+bKCmQu57oJNDTnL0hyFUgM85Tvqruf53mgD+UIiED2QRHw3N/EHUh8T+5PjsQXj5ZJUy8yRlD3IFWne/tjngbgr6aFEBZuFUo7/IjxmbXzEoshbl4M5OGVAcsgvgKlJ81QS3cde3hkVXqSyylXFRUWmQ+1P1rC3AqKCqPl+LnDQHs+98cBWR34SSdjintKjfC+tgS11WYFGTyHBVAIijVZPkwTKNbts4yipK1r6EPEylBwfSB2iX3wu1nisaj5kM0Namj6+kvJq7iObTGX2VR02bJEPe9e9l4sPtUjdhgfLew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805466; c=relaxed/relaxed;
	bh=NdrwOPwwg5sl/G/VlKLy2BfD96hcOiYwx38KP81p2To=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZNROJTbOhKCjEypfXbCG9i4WBW55/ovfnYKqB6RUZV+7cGw8KiWVBqMYHGl6mUcEoZewBQMyAzpUUBiBH3y1F0TGaFsUd1j1RLv9UFedb+D+zTfMTxaTn9/qw5u/8uVZ/TH+/WwPxHULUvJNr7eiRodQlMktAsNK57eVC4UR9a/iP+t1ukZ9m3sr6QGq40NCp31LQUpC5N8ZbNXGugWrXHg+VYGQ5o67fObfCDcE+iT4oMHt/auopiGn+crYb+25dwC9RAsAt28Ipu+BKWoRKiXc/LhRot6Hfpuksj4Jgz8sNlqRgDIye9YpeBHYEv95Ks0F8yTkAZ5Lf76T6cyqmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eOCI/CT9; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Btvx2I53; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eOCI/CT9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Btvx2I53;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFXR6x5fz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:44:23 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NdrwOPwwg5sl/G/VlKLy2BfD96hcOiYwx38KP81p2To=;
	b=eOCI/CT9Al8F9+zzbCaSRdLDNuKZdO0uWTKoB2tZnMKpW1yRESHHgZD76EC03YhgbvMlmi
	C/n2LhQNqFCMC/bxvchp20eA9IqpSqZDnBvD0VhQ3jrlrliiSBJK8TN9LGDK3c7+oUCUyH
	JQHBtevBRk+3re8OHUO/TRxNx/+CQrdChPFl1jCUdTrl7YimwZ87ITGoC7febatJzajsny
	jxXixUhadxsuYrlw+AoXiXfzMWLHxR+n4MXrkfjQy6UmrrFpIkIR6VulXnsXF5xEKJTkZV
	JkefOTZCE6s85sFs5lbc8HYEZ/jFZqxqDfzv1zm2+ctf23qBxLCLRwxs8w4bbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NdrwOPwwg5sl/G/VlKLy2BfD96hcOiYwx38KP81p2To=;
	b=Btvx2I53nZX8nXAICG9CUa/B6i7cJ363iMeh2cME3M8TJhPuIOpoqqppMxRTzXXToY8W+x
	ya7jeQWHyt9zVQBQ==
Subject: [PATCH v2 0/9] vDSO: Respect COMPAT_32BIT_TIME
Date: Tue, 30 Jun 2026 09:38:29 +0200
Message-Id: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBAFf0VybkqygcT21P8oIlHXulATSdJgE
 f+9qT33OANv3sYiBsLIrtXGAmaK5F0BOFWsn6x7IKehMAMBWkipeB6i572fF5taBR2lNtGMHGt
 RG63wYrRlZbwEHGk9wvem8EQx+fA+frL82l8SwPxLZskFV6OAWlvT2V7dnuReKXhH63lA1uz7/
 gHqMwZqwAAAAA==
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
 sparclinux@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=3999;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=m2BcXDvYAEp5y0PpYqR0UFKrjTCsaqAcLwRl/QjXAqE=;
 b=MmLqPk6DUhP7wmz102JYzJAuqPgG4TQxTMFC0bnmH6DgjsgVPzlCAJG/20f/m5qxrZq2ldo9i
 GdipLSy/PXsD0YkIipY0BiFwCqtAP78WuzVzlQnXVwNuMroRwsWymi+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Currently the kconfig option does not affect the gettimeofday() syscall,
so also keep that in the vDSO.

I also tried to introduce some helpers to avoid much of the ifdeffery,
but due to the high variance in the architecture-specific glue code
these would need to handle they ended up being worse than the current
proposal.

As a side-effect this will make the self-tests more reliable,
as there is now always a matching syscall available for each vDSO function.

clock_gettime_time64() was only introduced in v6.19, so libc implementations
are likely not using it yet.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
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
 arch/powerpc/kernel/vdso/vdso32.lds.S       | 10 ++++++----
 arch/powerpc/kernel/vdso/vgettimeofday.c    | 16 ++++++++++------
 arch/sparc/vdso/vclock_gettime.c            |  4 ++++
 arch/sparc/vdso/vdso32/vdso32.lds.S         |  6 ++++--
 arch/x86/entry/vdso/common/vclock_gettime.c | 20 ++++++++++++--------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S     |  2 ++
 kernel/sys_ni.c                             |  4 ++++
 kernel/time/time.c                          | 24 ++++++++++++++++++++----
 lib/vdso/gettimeofday.c                     | 20 ++++++++++++++++++++
 16 files changed, 115 insertions(+), 36 deletions(-)
---
base-commit: e6da2429169af9b33f3629b69905d89bb5ee9e64
change-id: 20260113-vdso-compat_32bit_time-e808763e976a

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>


