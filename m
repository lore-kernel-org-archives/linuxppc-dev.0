Return-Path: <linuxppc-dev+bounces-23368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F961C44502
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVGY683sz2yjp;
	Thu, 02 Jul 2026 18:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782980501;
	cv=none; b=mby/drNmLq+jb+aSCLAMBBCAvl5utR8jFHXDAR9u7merBAc6EPECrWUeHam1TGFmPhRzWwPtX1GcIDI1y3TJCo2GozcI+q/mbCSAvpHr9gcBudxABlRUhEvJy39M3VC/9E8OofPAxaFehQymhp5c5yC6bZzAchhd4Cii9i0z/BeK0FqihfxyNLvLL/0g49gF5FNbR/Ji/viUm3kdo1jPy2pSGbo/jqcxGAenh5bbN8hv1aceTTdPAOI0f/Zb0sQwhhJ7KXCu22xm4R08BUWNohGlrB+RGs6D0F+eYzdHXm4gPjHPD24wniW/H/8aPh6av/w/zwXukH2LtkOq8Fynsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782980501; c=relaxed/relaxed;
	bh=SSwZ2fRFDA2B6U/uyvpiDsqnsXPvOjViDV0jUJxsvyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQPMwqmHLoUgG+RWAuoQQ1ejz4H2DRaucGMnM7Nqe2qvRosWjJO4ICwTPARpYS3UBSyvLlCa+5HGzOEGzHIynPSMMKy4TOCbO2hj3FwqQ0wJpgd/0gdkDIxcJRu1alUC0q1bOqFii7qW6llBHUC4OcS4EKZhypqUcczDI72wF3emT2vQoWjEB0wrwsjKRQHDI8qKQYVoqlPT1sLhqVnik9/d8pVpv3dqGpFJNXlDcEryazt9ltNKua5CtshPwNFWqneQhXfDHFhMKrBLgXpin7DOuEd7Wneoz7QIBVZ9JvM8HCY7XkQq2tVoek5N5/2H1Xvui854wxVqYbn7QHWP8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2iwXWmQI; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SBVDxiAy; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2iwXWmQI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SBVDxiAy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVGX4bmvz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:21:40 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSwZ2fRFDA2B6U/uyvpiDsqnsXPvOjViDV0jUJxsvyw=;
	b=2iwXWmQIYgFDTQyeAME9Zso9Qtf0EiOr4yoVSfEh2dZJSGiHIxlnnInb8cz70jhKBEtjKj
	iw6SuTH4hFTrWYzh5lcHkpcK530yqwQhv2iiWTBiXUHX4mfKJiinYiEBOcaxJiD8HPtCrf
	66pg9vHZM7qyMOowR0w4TX86gqJrX0JicckvsBlu5aCaox4iiFcW7baRWadXNVnJtpDZEd
	NkRkJP/SJwvx7Fk7EqDUDHv/Li9OQmkXREeegpDYl3wXX6UC6ICpTyQym1tL7+ddv0ryAB
	aOelgILRJr5dNjFXugOurzNNLOXjzuCzzxKJvUiu2jeqVAnYnN+YKsC6WP9Iwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSwZ2fRFDA2B6U/uyvpiDsqnsXPvOjViDV0jUJxsvyw=;
	b=SBVDxiAyRNJI6ZrNDor6bfSlx959wrkz9D9TmxhtQOouqzzqbJx/vUi1Ih5JA6VM8yyGNw
	P2IMNk0zxy6Wf0Bg==
Date: Thu, 02 Jul 2026 10:21:27 +0200
Subject: [PATCH v3 3/9] x86/vdso: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260702-vdso-compat_32bit_time-v3-3-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=3288;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aE7B3vly9DVH5JNvTLoDjijb1pgHA5flYmw5pog0TZM=;
 b=JoI1ppcgZTmMlDXlGvea1wDNGWX7R7KezhNa1+xNMdembkpPHF5FHdzzxrsZ1mBomtqL0kLKE
 IIyAN6HiRn/A9JWkmOftgK0gbP8fMl1IiSeYzE/7zXf7Su6WXph5Igk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/common/vclock_gettime.c | 20 ++++++++++++--------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S     |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/common/vclock_gettime.c b/arch/x86/entry/vdso/common/vclock_gettime.c
index 57066f346b3f..304dbd1f9db4 100644
--- a/arch/x86/entry/vdso/common/vclock_gettime.c
+++ b/arch/x86/entry/vdso/common/vclock_gettime.c
@@ -15,6 +15,7 @@
 
 #include "lib/vdso/gettimeofday.c"
 
+#if defined(__x86_64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
@@ -29,6 +30,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 }
 
 __kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias("__vdso_time")));
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
@@ -51,6 +53,7 @@ int clock_getres(clockid_t, struct __kernel_timespec *)
 
 #else
 /* i386 only */
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
@@ -59,14 +62,6 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int clock_gettime64(clockid_t, struct __kernel_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime64")));
-
 int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 {
 	return __cvdso_clock_getres_time32(clock, res);
@@ -74,6 +69,15 @@ int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 
 int clock_getres(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
 
 int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts)
 {
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index cee8f7f9fe80..00629192db56 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -23,10 +23,12 @@ VERSION
 {
 	LINUX_2.6 {
 	global:
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
 		__vdso_clock_getres;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
 		__vdso_getcpu;

-- 
2.55.0


