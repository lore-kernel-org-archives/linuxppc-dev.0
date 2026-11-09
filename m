Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F64606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNTtY0F1Dz2xjv;
	Mon, 09 Nov 2026 23:41:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794228100;
	cv=none; b=XRX+Auq20Rsh+O+aqGgP6DJ3j2OLyiXO+1ivO8m/ZPXAdMKUhNjM2mUp2dmbSlc+qDalO/zW1iVseYkX0QObQ9ytW2qAauu9O81r3v9b0IZjxjsPUrThVCxUMGf/vi9xrGU9oDTZDzGK0ofb2wHXTFJtSqo1T3mZBRepyi+tReM0pLVbCOTljYiq+FlMXviEcRRs9pnpNq7P1IhUzOXXf5hVkhCahH5t5EPQwooTE+GWVgoNWHT/6HYUcwSXkU4dXEDDkwgvLryoKxBkbBZ6YbzTCN1CCS7QnqfGki7fzzfIqq36JySs0nbN+4y1piZBB3VeGHGaM0SseFMd398EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794228100; c=relaxed/relaxed;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSvvbU2of6SEFvuIe2fCZ9Kntmp5zdc5n8Ctta9D9csuCG6LjmHbwxey4OSh2IPkcOmhNC0DTELOr/B3XI5wNxz/kafCLPibSF1ROE+ksY2HjBSqO1kJ4GqbMCyitAWRJi4iFCdbmuuAGIPurSKu+r+xFHQphsuJoNdE8/Lx5cS1UEZenUGSscZMyzlnGUZMMJ7AMKndbSBCDK0RLgPj9zTfLUxdcKvz7FiTLq7CfoMoJilXpQSfQFGchDruSYfOJb2QUZWWJ+q4+ZjLt5KzvHSXIQeVCmmTia+1PiHgr8Orp+O35dvKZtSkmAYPqqOW0jIJH/pt+5GwZBhO8iqGVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 601 seconds by postgrey-1.37 at boromir; Mon, 09 Nov 2026 23:41:39 AEDT
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNTtW5Mnxz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 23:41:39 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=BVn6goM5DdOyungF+KCccmht5x5GkRSV4guGwd3HLRCXTbHqP2RNiBFSjb1lRM13W51iy0
	nY5UzEMxxhDgwT2yZpZWahcO/gFqmk3egT5469koNPX/h3rPNizr+IxKAMVVirbhfly6wZ
	GbApcLMlTK56edrSa23nENBu4lALoN/Ok5UUwxPBZYFgFD7oMltFdIPLKmBFoHAyZIGP0j
	cb4g0qnyjR42YZWtEp19Jh/oUNlIxTbjt+nejaridLx/hizJ/F3Xx4LHIMDbfB8aQOFq+s
	DON4vr114yGTh1Dsj3tBOMazfCEaQiC5hHj1AzT8sR88fGghX5fUPWaOAyaCRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=icg2C3zy263T42rXs/vcrNrmpaVc6W/Byd9Lrj/krqLWZRCOZgtpnTqaiIvsOkFPEgixus
	tgqbc4XsQzsLndDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bradley Morgan <include@grrlz.net>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
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
Subject: [PATCH printk 0/6] Introduce policies for unsafe flushing
Date: Mon,  9 Nov 2026 13:37:17 +0106
Message-ID: <20261109123127.489676-1-john.ogness@linutronix.de>
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

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [0] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

John Ogness

[0] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 ++
 include/linux/console.h        |  37 ++++++++---
 include/linux/printk.h         |  27 ++++++--
 kernel/crash_core.c            |   1 +
 kernel/panic.c                 |   2 +-
 kernel/printk/internal.h       |   4 +-
 kernel/printk/nbcon.c          | 117 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  16 ++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 11 files changed, 146 insertions(+), 68 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3


