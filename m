Return-Path: <linuxppc-dev+bounces-19585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C483F4484F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:20:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbTc4sjvz2ypY;
	Fri, 10 Apr 2026 22:19:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823588;
	cv=none; b=GvNhwreeSBG+Z8CKWMvgZ2ZLijFPkla0ecRetv4CJJIFJbYcv5AXC7HZZ3hmaCklUvibxRIWAxowK3It26rZj9JyzlhbQ8c5+Npu7bVADmIZkJia8mzjtGGXUmgqQ4ElD+5/IZLc9oNHj5OqsCliLfmyBGqLDkJNa2+lV3MepzTNOSDl9aWEMc8QHJfJMiol2L41TpOqgDk6SROmNtFGKsMuDOeC5iQCZEbGlary92o/G/Usrd/5sc7psVymRNfrg/GsGXE/Y62aembc5zut6X9YTkscoYygO39kBgcWrRXoDPKL49jVc2BRumt3RGdkOPpr6P0Hd7NYoEXojhRjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823588; c=relaxed/relaxed;
	bh=xygFk++4Dzn0dankGqOQGxF6Nzu0dNNvlma/WvdOwrA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j3XXgCzlNg9xd07pygEqPp8/LzQsZYV9GZyOauSywdSXl5KfgCLthqt5JqJa3T0/kPsrFAPK/jjDjCxJ3GIE80hjvPsyjPndj+mDKOkIVqdc6R6/oz4MVTFHsPmCrG/b4A4CZz6ANWVLXF6euTelkpG7CsTMV0wNIa2VA7jydWUfje2b686dC9GtsjBP6FbCTknY4FeT+MPSZNSuQLr6wnKci96SKdfQGG73qJ/aDkM9+cIFptfgxDS+PqjmgDwuwHq6voTr7VSa0emZj09aewXDwES6BogeN6tuiIxMLCmwL4EL6IgpjWLyQXdat6DUoUJxlho65jYHSIWBFfcERw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lx7PSe/P; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lx7PSe/P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbTb6KWsz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:19:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE51161119;
	Fri, 10 Apr 2026 12:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F75AC2BC9E;
	Fri, 10 Apr 2026 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823585;
	bh=QeSclCuMiRAS5wk6lWoviUdmtawCgYPJK7955XSCrpk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lx7PSe/PjadVTpIMwJdhAJBLt/wkFkRfbRhizAqdCmT18BPcbSlnMFeRTECetW5Mz
	 e18kIbNIOdNmzSRNcljN5MiUEDzdauvDtZpRrKPYAQq6HuU0ixY90WW/AT9/9BP1TE
	 G0pmyVH8DHnvheD/Jtznb1TEyB0LG5ezsRLYR23JSrj8T1XCNh6BmAZvkaj4VTBCOk
	 FjtLvndHPm1jEFcE8PqfK7D9YifyYmXQkYky/wPITICuSdRrICGnLkZ3jZxe25sBaP
	 q8ggvP1HMAsaRRMlhxP+iwStOOzZHUsvv+/U0DMMTE0lc38vp99aMg2cqhdxuGrXAu
	 mqm2UYpSfgZaw==
Date: Fri, 10 Apr 2026 14:19:42 +0200
Message-ID: <20260410120318.592237447@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
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
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Subject: [patch 15/38] ptp: ptp_vmclock: Replace get_cycles() usage
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

get_cycles() is not really well defined and similar to other usaage of the
underlying hardware CPU counters the PTP vmclock should use an explicit
interface as well.

Implement ptp_vmclock_read_cpu_counter() in arm64 and x86 and simplify the
Kconfig selection while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm64/Kconfig                   |    1 +
 arch/arm64/include/asm/ptp_vmclock.h |   12 ++++++++++++
 arch/x86/Kconfig                     |    1 +
 arch/x86/include/asm/ptp_vmclock.h   |   12 ++++++++++++
 drivers/ptp/Kconfig                  |    6 ++++--
 drivers/ptp/ptp_vmclock.c            |    6 ++++--
 6 files changed, 34 insertions(+), 4 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -112,6 +112,7 @@ config ARM64
 	select ARCH_SUPPORTS_SCHED_SMT
 	select ARCH_SUPPORTS_SCHED_CLUSTER
 	select ARCH_SUPPORTS_SCHED_MC
+	select ARCH_SUPPORTS_PTP_VMCLOCK if ARCH_SUPPORTS_INT128
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
--- /dev/null
+++ b/arch/arm64/include/asm/ptp_vmclock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_PTP_VMCLOCK_H
+#define __ASM_PTP_VMCLOCK_H
+
+#include <asm/arch_timer.h>
+
+static inline u64 ptp_vmclock_read_cpu_counter(void)
+{
+	return arch_timer_read_counter();
+}
+
+#endif
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -135,6 +135,7 @@ config X86
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
+	select ARCH_SUPPORTS_PTP_VMCLOCK	if X86_TSC
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CX8
 	select ARCH_USE_MEMTEST
--- /dev/null
+++ b/arch/x86/include/asm/ptp_vmclock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_PTP_VMCLOCK_H
+#define __ASM_PTP_VMCLOCK_H
+
+#include <asm/tsc.h>
+
+static inline u64 ptp_vmclock_read_cpu_counter(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_TSC) ? rdtsc() : 0;
+}
+
+#endif
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -131,10 +131,12 @@ config PTP_1588_CLOCK_KVM
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_kvm.
 
+config ARCH_SUPPORTS_PTP_VMCLOCK
+	bool
+
 config PTP_1588_CLOCK_VMCLOCK
 	tristate "Virtual machine PTP clock"
-	depends on X86_TSC || ARM_ARCH_TIMER
-	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
+	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_PTP_VMCLOCK
 	default PTP_1588_CLOCK_KVM
 	help
 	  This driver adds support for using a virtual precision clock
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -28,6 +28,8 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+#include <asm/ptp_vmclock.h>
+
 #ifdef CONFIG_X86
 #include <asm/pvclock.h>
 #include <asm/kvmclock.h>
@@ -144,11 +146,11 @@ static int vmclock_get_crosststamp(struc
 			if (systime_snapshot.cs_id == st->cs_id) {
 				cycle = systime_snapshot.cycles;
 			} else {
-				cycle = get_cycles();
+				cycle = ptp_vmclock_read_cpu_counter();
 				ptp_read_system_postts(sts);
 			}
 		} else {
-			cycle = get_cycles();
+			cycle = ptp_vmclock_read_cpu_counter();
 		}
 
 		delta = cycle - le64_to_cpu(st->clk->counter_value);


