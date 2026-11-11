Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0B606C141
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=67f/wVrW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPsHq6Xc3z308H;
	Thu, 12 Nov 2026 05:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794421191;
	cv=none; b=UcvXTWchIzl5N/XaXEFKmg5sr/837zOlNpU7sEU1UZMEuI6RPal5XvTo6cxXDvd8UdjsH7ZyT4ePdsB64dWuflxo3jZtHI6hdSLKAqXUIot28rs2e1RokGZCuE7ojWtR86G0ojpP1FK3H+nQ35D+7Z2BEjVyom3yawdCqUcyufqs0crc2jjzfmmEcHXjgSIDuC1uFTnbuW9/3m1qfBD17QW8Id/8YDAtpu49zuNcMPditIzvY1x4Z/rfpF9WcU111mPXBedjVzZB2MCZUTI38ygMuShQV8Pc9PdknGzrMPhAhzGrT2dNDyw/nqZojSjZvgpcIyTsEQlDd7Fjxjf40g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794421191; c=relaxed/relaxed;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNC6T8432PpV57AnG8Q+1NidcozOH8aS9jSKSSRckXhVVG4jSFvdV+u9WpZsfTDEiwSR3D4qtukqH7X+Ngpqruh98oV1LtXD/X7+qf45NXqLivWOgnDc9p31pZOuWR3XX0xmb4VxiqfaHMrAAG/1mXCrVNW1UIVRU+mdWjse+VOY4xp53fFls3C5+VWI86/WoPPvuHPy3mETB/07YSPar5UzIBdhpHgjizA9xseQ8Up0sDprHQ25llya9XL0FTQkTmMo3KYJY+myieER8dy3r6yFkYHeWQMVckRfncpgh3sGvf/IlAFoSnRfCnzAmrfJcIwcNMS/kcH25S5o1HDvxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=67f/wVrW; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=67f/wVrW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPsHn5PgXz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 05:19:49 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=rXyV+V8mB3WGQYt0D1cbKm+3TdQH5P7EkBB0BuarwzijqP3FTDgXeDtU+702Qha3Vjesjd
	ZOM+Cs2Cjqf95W9HPfwGmTijj2qXHfWvu2anJBtqLqoaWKO9FjvL7fGv6zbAmkaqKvsvsQ
	RLNM7MfGFGooJ30UY9ORSGfoi0Y4Pd/bLfBvxxCuZ0XnCWN6lhknFqGFfTdjfbjgodCXyL
	9khOfeXGPBb8Che0NlD4shfupUeTEen9ahuAZgPlfkyLNV7YY0wetUpUm0wM8itMWW7+PD
	8f+X28nEXLQlCNh1FQ2LsARwu+5HxRkTrDJVnz2voRACc/e1f7hBk3Crxa9Caw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=67f/wVrWqykxVxVPvO3YPpqenX7yBp2KyE+jBcUbzvEX+HrwwBjv1vgxB6QxoqLtZqXPOF
	cVUFfC/MqkcyEyAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kgdb-bugreport@lists.sourceforge.net,
	Randy Dunlap <rdunlap@infradead.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk v2 0/6] Introduce policies for unsafe flushing
Date: Wed, 11 Nov 2026 19:25:16 +0106
Message-ID: <20261111181942.593695-1-john.ogness@linutronix.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1 is here [0].

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [1] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

Changes since v1:

- Make console.unsafe_flush_flags unsigned.

- Add missing kerneldoc description for printk_trigger_flush().

- Remove the WARN_ON_ONCE() in
  nbcon_context_try_acquire_hostile() since hostile takeovers
  are now possible from non-panic contexts.

- Also provide a flush reason for console_flush_on_panic().

- Add a global variable @legacy_flush_reason to track reason
  for legacy flushing.

- Explicitly set PR_FLUSH_RUNTIME to 0 since it is now used to
  initialize @legacy_flush_reason.

- Temporarily set @legacy_flush_reason during legacy flushing
  of console_flush_on_panic() and printk_trigger_flush().

- Also set/check ctxt->allow_unsafe_takeover in
  nbcon_legacy_emit_next_record() to enforce flush policies
  for legacy flushing.

John Ogness

[0] https://lore.kernel.org/lkml/20261109123127.489676-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/loongarch/kernel/reset.c  |   2 +-
 arch/powerpc/kernel/traps.c    |   2 +-
 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 +
 include/linux/console.h        |  39 +++++++---
 include/linux/printk.h         |  27 +++++--
 kernel/crash_core.c            |   1 +
 kernel/debug/debug_core.c      |   2 +-
 kernel/panic.c                 |   8 +-
 kernel/printk/internal.h       |   5 +-
 kernel/printk/nbcon.c          | 129 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  38 +++++++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 14 files changed, 181 insertions(+), 82 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3


