Return-Path: <linuxppc-dev+bounces-23159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349D2C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:45:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFXV67lkz2ytx;
	Tue, 30 Jun 2026 17:44:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805466;
	cv=none; b=cydWDespxUIG743OVfLNeDLoi4xvv0JvuJXMnDDgOJckQ8x41TavdD1R2tJt6zr+wsM67DXzZB9q9nnC8HjiUQt/GAw9IFJMx86/1j7Hc6SxSXPW8LF4v4Sg+66mtRG3N/v3jh9Ri35YwVMVZAwCFnZWdDrZbM6Xyd0u/Hm7waDfa1PnGRCEo5nVcNwIRxNBHjzGEXW/bntLctOn3iny/CI52uubqNfD+7IvZFVakRf3FghbWQ5wbUqvcW44g5MAcdvJhaIr5D9sJYYe/NgKO3GXtCEJkN6hgmy3jo2gLIhxLnl9vGw6p2ZXZy/YJg3z/LeIKtnor+siPqP0I54eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805466; c=relaxed/relaxed;
	bh=FNfx4ZwRa3SfdLfS/MgnIIl+XkUPa5LfnmNevbx+zaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+0J97u4ACgPBj3MOhOB1S7PIheSgWKaygN2mVNVEX1uISnnvErL9txIbe8jLSJDkxysX3URNwBsfDUBoJsL8Y/vLUdAUZTeXeWAhqADm/Esr4YY0ep69lO/Uwqyj0nfskgOJwr7aMHeP2w/inJYXt/wweMv3S2Tvwfcgo6d7UDnq3IIaCXKvi3YIS8sySg+mVKU/QS4Dv5vUpD6rb2LSotGaJDVFgmtfBYcWZVtTjDlW36JJnqRlmokcqjjo7tXosHQkRqcLwCZ8+RMsGH//Afard+aYmA8G5LzXM/GFjr5Gbcz6RQrpBBlDLSsIWbw8zEx2rZpUqkuUd1/bQ4GtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q+a0wBwR; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=B7L0hNtt; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q+a0wBwR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=B7L0hNtt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFXS4JMlz2ypm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:44:24 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNfx4ZwRa3SfdLfS/MgnIIl+XkUPa5LfnmNevbx+zaQ=;
	b=Q+a0wBwRKuOXhUGw5UrtYYaGZf0lWYo1kyUS6je1NXU6QPdrucV+G7CqacXiD37gfdJbV6
	J7rq34H01hP6vSj58utRPJ+zs8TM/4EaNqQGJqzkLJ6jSoYiLMQvUoc/zL3JQ5AyhxNCcd
	7bCxJpJE1ru7xIYs8U2fRra2d99Yz5bIX/XmCMX1Dzl9iXqMAiPiXpzjWJ0n0MWL8XwMHd
	D/barvU7cUoJHgfEBJdKPnJRp4u5TzRcT+L5EUAKqObvp3ef4XBwWFDlTUmNlPuTwU/Ana
	xm80OOIsVkttr/DEZ2bHD7VI1ei3xLq+OMNkQmbdv+lgXH2SFNP1irWZBns+5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNfx4ZwRa3SfdLfS/MgnIIl+XkUPa5LfnmNevbx+zaQ=;
	b=B7L0hNttdC5FRLrdbzZu0qi4JaPLGn1VpBGk4BsLHuFp3OgZ2CiM5MI+rXCNylw0dQudrD
	ZRHFE3G117t9zgCg==
Date: Tue, 30 Jun 2026 09:38:37 +0200
Subject: [PATCH v2 8/9] sparc: vdso: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260630-vdso-compat_32bit_time-v2-8-520d194640dd@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=2429;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L9VXOtgaNulXrVyi11tUXSjGEbMI8U34DK/dFNNZ248=;
 b=s77lbGbpfMNEIGCpqAKR/35lvPeZ/FQmSsNV/eo4RyMakK77HRLSbafblw3w/8rJKmqYxbjba
 tE7pfN7XQuqD/T3mGQMdhM8cwIRimaQ4mP+o7FmhL/T+BqvV3ujTClh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Currently the kconfig option does not affect the gettimeofday() syscall,
so also keep that in the vDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vclock_gettime.c    | 4 ++++
 arch/sparc/vdso/vdso32/vdso32.lds.S | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 1d9859392e4c..221bd4ed19f5 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 
 #include "../../../../lib/vdso/gettimeofday.c"
 
+#if defined(CONFIG_SPARC64) || defined(CONFIG_COMPAT_32BIT_TIME)
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
@@ -28,6 +29,7 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__weak __alias(__vdso_gettimeofday);
+#endif
 
 #if defined(CONFIG_SPARC64)
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
@@ -40,6 +42,7 @@ int clock_gettime(clockid_t, struct __kernel_timespec *)
 
 #else
 
+#if defined(CONFIG_COMPAT_32BIT_TIME)
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
@@ -47,6 +50,7 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__weak __alias(__vdso_clock_gettime);
+#endif
 
 int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 {
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index a14e4f77e6f2..28052168b875 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -15,12 +15,14 @@
 VERSION {
 	LINUX_2.6 {
 	global:
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		clock_gettime;
 		__vdso_clock_gettime;
-		clock_gettime64;
-		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
+#endif
+		clock_gettime64;
+		__vdso_clock_gettime64;
 	local: *;
 	};
 }

-- 
2.55.0


