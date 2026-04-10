Return-Path: <linuxppc-dev+bounces-19592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACE0F4484F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:21:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbVF6JhGz2yr0;
	Fri, 10 Apr 2026 22:20:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823621;
	cv=none; b=kNPL+XKxSbAcQ0ONq7l7lamMLp8yfIskwHnDQzphj3tpBDB6PgeLHhHtbB7NoaH8t8xPkbEHEVBHTbBHcWMJTK/GeHXOw5sesCKwVDsdTnlPD2Bjg2YmZQ6RS6P1DzVEB5gKVNiQBIN3m3E4/XKPBRLvH8RmpP4nVPTXWHeZgbCJhlPNUOkjTQHdZ6HOp4PYL0T5D8xrNqQ29EEqKgmgp4HupsalhPbwdi9dsA2vGNp8YKfA1SSynTf6PSiT5BK6S47mwHUAWcF7Ki0t9R71u+XOvTDtxvB8IE56Ct44okbrluVMXL+lZ7O0pW+XMLuW4LI9kNxxzd4hB0Dgm7Cn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823621; c=relaxed/relaxed;
	bh=AqOQD77ovJbDZAalLb7LttNXWfQNwpbHnO0m4lNbaKQ=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dOfLIKodA3bPKVWRjlg+zg/PzukQCjxlt7nOl3Ika8Izb4hjlClhO45aQW/uK+DfwbWonoUDRakm16CucLmjnLBuDYBwqxrKeNBMqTr0y1VYXJyK57j+owsP1HPaWHLyZD2w4adoF+cU3rTc2WhIbUsayAMRJauPIe7XE0SFNiI8Jiyo8M2UO0OUXWwf9fk5QXKRDb39zKhiE/T2MBPWr+yoUaaYTnPY64VVKubPo5vWk11heL0NKbUuwvPWcZESP/DLuUv4gGV4lLxHCGoJChwSP+tfV/93SnwYyPAP9gmQoW7Vs2SaG6WdkgS02LEznfYaZ9gmn/LQmySv8tfgtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C7az2CYX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C7az2CYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbVF10qkz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:20:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 806A043DD1;
	Fri, 10 Apr 2026 12:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21BC19421;
	Fri, 10 Apr 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823619;
	bh=qm3xQcBXEr96lL4hegVcj0UIOMtgXH0StGBPsgVLlKQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=C7az2CYXx68wjErxLRkuWTeHqh2CiNCWSqYoEW7CDASKgYcRJIgZbMFxC0wyGwYuo
	 q2wWS5Il3rSZIvkXMrziJDymJeOKDwzCu+GiLTUQ15ObFw+7EBHLm3ubP5lL1H6hxr
	 ReCtVW/VKZ0Y6HBv+Xxa78vZHjPEyhGg6WzSGQLG1W0Tyuqe7kgGZgc8KKs+JzIX6a
	 qzTQ3qBxeH5MKjO5ANy/+fOcCKNQ7HWyamJ7hE6VNKzzJsl13+xyi236101/gCvlT5
	 hn6GusmLxuTParC929bCg39takaaNPRV5A3bS+11CTndJSbqW1MjcdkxKmUqQfmLua
	 lqUqNEa3EnLWw==
Date: Fri, 10 Apr 2026 14:20:16 +0200
Message-ID: <20260410120319.064561422@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 22/38] random: Provide CONFIG_ARCH_HAS_RANDOM_ENTROPY
References: <20260410120044.031381086@kernel.org>
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

Chasing down to what random_get_entropy() resolves is a 'spot the mouse'
game through a maze of #ifdeffery. Also the placement in timex.h is
non-obvious and has just been chosen because it provides conveniant access
to the underlying get_cycles() #ifdeffery.

Provide a config switch which is selectable by the architecture and a
temporary #ifdef guard in timex.h. Architectures which select the config
switch must provide asm/random.h with the architecture specific
implementation.

Update all usage sites to include linux/random.h so that the gradual
conversion does not cause build regressions.

This is part of a larger effort to remove get_cycles() usage from
non-architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
---
 arch/Kconfig                     |    3 +++
 arch/loongarch/kernel/relocate.c |    1 +
 arch/mips/kernel/relocate.c      |    1 +
 crypto/jitterentropy-kcapi.c     |    1 +
 include/linux/random.h           |   15 +++++++++++++++
 include/linux/timex.h            |    2 ++
 kernel/kcsan/core.c              |    1 +
 7 files changed, 24 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -370,6 +370,9 @@ config ARCH_HAS_CPU_FINALIZE_INIT
 config ARCH_HAS_DELAY_TIMER
 	bool
 
+config ARCH_HAS_RANDOM_ENTROPY
+	bool
+
 # The architecture has a per-task state that includes the mm's PASID
 config ARCH_HAS_CPU_PASID
 	bool
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/panic_notifier.h>
+#include <linux/random.h>
 #include <linux/start_kernel.h>
 #include <asm/bootinfo.h>
 #include <asm/early_ioremap.h>
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -19,6 +19,7 @@
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
 #include <linux/panic_notifier.h>
+#include <linux/random.h>
 #include <linux/sched/task.h>
 #include <linux/start_kernel.h>
 #include <linux/string.h>
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -42,6 +42,7 @@
 #include <linux/fips.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <crypto/internal/rng.h>
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -139,4 +139,19 @@ int random_online_cpu(unsigned int cpu);
 extern const struct file_operations random_fops, urandom_fops;
 #endif
 
+unsigned long random_get_entropy_fallback(void);
+
+/*
+ * random_get_entropy() is used by the /dev/random driver in order to extract
+ * entropy via the relative unpredictability of when an interrupt takes places
+ * versus a high speed, fine-grained timing source or cycle counter.  Since it
+ * will be occurred on every single interrupt, it must have a very low
+ * cost/overhead.
+ *
+ * If an architecture does not provide it, then use random_get_entropy_fallback().
+ */
+#ifdef CONFIG_ARCH_HAS_RANDOM_ENTROPY
+#include <asm/random.h>
+#endif
+
 #endif /* _LINUX_RANDOM_H */
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -66,6 +66,7 @@ unsigned long random_get_entropy_fallbac
 
 #include <asm/timex.h>
 
+#ifndef CONFIG_ARCH_HAS_RANDOM_ENTROPY
 #ifndef random_get_entropy
 /*
  * The random_get_entropy() function is used by the /dev/random driver
@@ -85,6 +86,7 @@ unsigned long random_get_entropy_fallbac
 #define random_get_entropy()	random_get_entropy_fallback()
 #endif
 #endif
+#endif
 
 /*
  * SHIFT_PLL is used as a dampening factor to define how much we
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -18,6 +18,7 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>


