Return-Path: <linuxppc-dev+bounces-23371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E30C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:22:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVGd2Qmkz2yrW;
	Thu, 02 Jul 2026 18:21:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782980505;
	cv=none; b=EFsPIYNgfeKWmuJIzepWVmLmoPnXjFKpRLjwuJ5OnPgGvHjQJcgsqEHhFFmx5VISCsLHbaiRl0s7DsBM2w5jqx+NJ4ARuUkG2Od73BN1xVe8QQdPE8btjg2h8lf5ySjoLHKlmjd7zjoCNvfZu1bzm5K6JB1h+5TMJ8mtnkZrgWrv7rvro0duDfb/n9r0jvq95TRYIMVLWXpqxRwI8FeFGLR+EZJnpq98VAokXKvfXHkwCgvRfvLoNqAh4q816+j8VZPLahCQs8G3CgyMmMa6DXIpGQcbxUH3vG+2EaChEAfCGZ0TO0n3mfKNHH8y184dcODtoeYkcFUZVWJ2RkdCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782980505; c=relaxed/relaxed;
	bh=DYXRa5l/CdD2C2xpitWtlaAFbTnk8w36CIwHuGabkYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcZXGeCcNt6GhFFrjehAG76/TZqqAzFFJ7rqyZ+p+APwrJRw1vOGhBZhjjuEio0/Hdmgmd5hqtBTRmhvnI6eWyeywJWhXRW1v6f5FWNwU2tADH7OVqTcP8NZQc9MJgu/uPSXtpjWWEuwgw91AQIxH8e++tvcQZVXIbY9eV4TukM885EgqN8Hg15n37Bxa7sSY9ILQfZzQ7M6DXNfxO8kisj49u0w7HN6z0+rWeZmp2lW+6nPFNgZT/rhv9oT4cAA9LY13dASCUjxXozDtFkGbgpG12QB5pC7x7IbbKQbn2bx+mYMQ9lGkFq6D7nbEONrOuQIYIpw5EH7MVaD29O3ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=XVc1AG4v; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=C2lbJx/l; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=XVc1AG4v;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=C2lbJx/l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVGb4rSjz2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:21:43 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYXRa5l/CdD2C2xpitWtlaAFbTnk8w36CIwHuGabkYg=;
	b=XVc1AG4vsrK0a7pnM0dkUyJxPGcDwnMXfIP4DbrVYlHn6kiVr1r162htY+reuvexes8urw
	N/2VHDtf7YxNvAUy1ScxDHZunjondJaxA22XZiph+OZxWheOwn/4cKcWYffJHnqSYbwrCX
	pz4RDXLDP8Y0+tVodVMunXHaUWA+9LuM8zF8qieah1vt3egwRfjEtVS9inb5Cnjnud0pg4
	4uVrDGPhMk+uesnzQaCOnoni3VwcbTUuIHhc4iyUicNJFjzy7DQAsoYdhqLgo+2MLSmit2
	kpLeQMduwCTRA0kgYlsa21CwEHLZ+RhInVFxinq8gykNGhOIRh9x4Zk/HSj86g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYXRa5l/CdD2C2xpitWtlaAFbTnk8w36CIwHuGabkYg=;
	b=C2lbJx/lDZIbv8xS2JUlHrr/Y0I7SrYde892VNhJtwBeXer8ftSR9ALwWmLL/uMpl2XBXc
	iPRj4S0f234rCuDw==
Date: Thu, 02 Jul 2026 10:21:31 +0200
Subject: [PATCH v3 7/9] MIPS: VDSO: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260702-vdso-compat_32bit_time-v3-7-db9f36d8d432@linutronix.de>
References: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
In-Reply-To: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=1652;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=db+HUQOgoPhMZomGV9E3SOxOlzH0qf2UqfHYn/OzdpY=;
 b=LaLkTIW5BQe8nXjVz9t/ub5bfz3xAP/47ZQj5zxKD6mwfTVfpm4LyKgHZg4jRmIjques1fK+g
 MWN6JfPtX18DwYmzCmzpAkao6Iyb1LT3juNvIOoagAPUvhrF3B2B9Ba
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/vdso/vdso.lds.S      | 2 ++
 arch/mips/vdso/vgettimeofday.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 278ab6444e98..b11ee493c67f 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -97,9 +97,11 @@ VERSION
 	LINUX_2.6 {
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	global:
+#if _MIPS_SIM == _MIPS_SIM_ABI64 || defined(CONFIG_COMPAT_32BIT_TIME)
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+#endif
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 00f9fcfc327e..a1fb06b8973e 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -12,6 +12,8 @@
 #include <vdso/gettime.h>
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
@@ -29,6 +31,7 @@ int __vdso_clock_getres(clockid_t clock_id,
 {
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)

-- 
2.55.0


