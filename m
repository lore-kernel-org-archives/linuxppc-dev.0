Return-Path: <linuxppc-dev+bounces-17356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E7CFD5301
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:58:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMfKY6rgQz3c9l;
	Fri, 27 Feb 2026 17:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772175473;
	cv=none; b=ZImA/gZLfuEvaMmjLNufH4/wnTit3By/M/ujGrI0EMSFFx8O/mDk39X8GhU8f76jgxQRCE4wUnj5pZbyhtoM+BDwSkvG58krrYCx1R9S1yhNSdaSOc+kv0qqWcohKojNZjI1w/61yo+xFxs0IpcKEH+XEuef2cGgHCxQkai7N4n8hFl6KOVDXKxAhaarcOIanVItJWQgopJXb8ESPdgugywkpPXF2QsClTm4Z6v9Nin3YHBYEcN4WBeot3P+yP7QYZ7Byf4+Id5B4NFY1IXme0ko2WZl+R9JhpAbS81y2hgZkxnMQ+vzIYOnSGua4eyBA3/04icVfLAw/958lTOvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772175473; c=relaxed/relaxed;
	bh=PMoWoELWXhUvJ+5dGoSFr0fxre5mWeKbDwq8tLK0U1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB/BIaZp/3hRph0Hq8tWYey07OQmwHT9KDRdv/cOd0fsH/iGGZ7MJUEWfYN735cxj+VduxzegOHQPF0fF6EhAS0497NFCafNGhbSlB4UsVGA3wPGra8xzSNCoQym6sLPV4+rtW5WEGXxlRxnxkt6RnuhkFHZY3xiSZyuhwsvOjvQyuJZfENyLRCxxP9uv/QI722H/iasQQt0pGEyDXYwH3QLMJNnYYzvO8l8jIWLiUHjzx6GJuWz6UUQ5EZY9hwebgNEfuqIcHGvP+uQ3aeVOrf3lps5puILxXxcTpZPbyDM0YmXnM53OHx+4py8zpy526ZL8WmeAUR7LSE09ptpWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jz3sFWXh; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mNoDAPoh; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jz3sFWXh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mNoDAPoh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMfKY2P37z3c7n
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:57:53 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772175469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMoWoELWXhUvJ+5dGoSFr0fxre5mWeKbDwq8tLK0U1w=;
	b=jz3sFWXhcbKGJDvHLemZ34PNAxwppfUXe+wTPhRtV3gLeHLzKe7G/sOWhp432nGhXwdSHn
	MgPHL/ieh4CRL+Sj/V0VrSdeXNrJJWdNoAnA+kUYdLhaxe5hRqxfwTSIVQqT/n2JRu11Db
	54GUiQ3Ep2UOkUDN0lDHYCt1mgYt3lWckWML/nc21HoopTL0vjWSaXA5qYRwVq0Bz0oILh
	Mywz5yZTC95dNZKv+8lxx7sqRgP0XM9ESwO9geQDyk0s6GnuSbY0G6jK3tLh/1UPre0lm2
	maFHxd31Y+gGwZf3eZw3N0MbkkfM5ZYX34hb3FOHezAsDQlFPn+cURluRusTEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772175469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMoWoELWXhUvJ+5dGoSFr0fxre5mWeKbDwq8tLK0U1w=;
	b=mNoDAPohU52TI7Xd8JWlXSfQ8jNjk3ZTMwand/oL+vE8eWgqiq+6XegH6AjkjIti8lIJxM
	gQC7dMc48YTxE5AQ==
Date: Fri, 27 Feb 2026 07:57:44 +0100
Subject: [PATCH 5/7] MIPS: VDSO: Drop kconfig MIPS_CLOCK_VSYSCALL
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
Message-Id: <20260227-vdso-compat_32bit_time-v1-5-3f0286a7bac3@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
In-Reply-To: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772175466; l=3146;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oahUDDzRXbGFMlkc0RC1a89GUCrIJez2IL5R9Ep+PBo=;
 b=04Iyq9XCQR4S4Ii1jZ1CW+E0jOmqmZS2e+vnTE9U0dCmMRBUvfyhPR94yWmPUG9n2pIN7c9iT
 6C8JYr4OYX/DVncCggJaRcX5U23VD83H+KnRI5WnFMgp2MAlxM6D477
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This configuration option exists so "that we don't provide the symbol
when there's no possibility of there being a usable clocksource".
However it only covers __vdso_gettimeofday() and none of the other vDSO
functions which should be affected by the same circumstances.
As these are more widely used than gettimeofday() and nobody seems to
have had an issue with them so far, drop MIPS_CLOCK_VSYSCALL completely.

The removal of the ifdeffery will also make some upcomming changes
easier to read.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/Kconfig              |  3 ---
 arch/mips/vdso/vdso.lds.S      |  2 --
 arch/mips/vdso/vgettimeofday.c | 20 --------------------
 3 files changed, 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e48b62b4dc48..4c8592fd1556 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1137,9 +1137,6 @@ config CSRC_R4K
 config CSRC_SB1250
 	bool
 
-config MIPS_CLOCK_VSYSCALL
-	def_bool CSRC_R4K || CLKSRC_MIPS_GIC
-
 config GPIO_TXX9
 	select GPIOLIB
 	bool
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 5d08be3a6b85..76b6ad898288 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -97,9 +97,7 @@ VERSION
 #ifndef CONFIG_MIPS_DISABLE_VDSO
 	global:
 		__vdso_clock_gettime;
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
 		__vdso_gettimeofday;
-#endif
 		__vdso_clock_getres;
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 		__vdso_clock_gettime64;
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 1d236215e8f6..00f9fcfc327e 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -18,22 +18,12 @@ int __vdso_clock_gettime(clockid_t clock,
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-/*
- * This is behind the ifdef so that we don't provide the symbol when there's no
- * possibility of there being a usable clocksource, because there's nothing we
- * can do without it. When libc fails the symbol lookup it should fall back on
- * the standard syscall path.
- */
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 			struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
-#endif /* CONFIG_MIPS_CLOCK_VSYSCALL */
-
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
@@ -59,22 +49,12 @@ int __vdso_clock_gettime(clockid_t clock,
 	return __cvdso_clock_gettime(clock, ts);
 }
 
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-/*
- * This is behind the ifdef so that we don't provide the symbol when there's no
- * possibility of there being a usable clocksource, because there's nothing we
- * can do without it. When libc fails the symbol lookup it should fall back on
- * the standard syscall path.
- */
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 			struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
-#endif /* CONFIG_MIPS_CLOCK_VSYSCALL */
-
 int __vdso_clock_getres(clockid_t clock_id,
 			struct __kernel_timespec *res)
 {

-- 
2.53.0


