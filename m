Return-Path: <linuxppc-dev+bounces-23372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AC8C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:22:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVGd2rRyz2yrX;
	Thu, 02 Jul 2026 18:21:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782980505;
	cv=none; b=mbWvNADhVnqoLSqueitZKOYOQ2Goc55R8wU0pSjWArkna59dwyfksNkbd8XnIjifmI7dVnOdz2m8vr2jXwJfchcCzQIaWoUmHlxsTm4DR/5NTl3iR6iAR0THcfWKv90n79PuYRP6APTr6TowAqj0XmXqPk81rMLcLZ8uzsCZIMyhyzbGB0W4MUHdGdcgK/xnUVIQtwh1KHN+JhoImDZKbeMECey0gOJDhQsPv6yvj2BGASTjdj/mFFjXz23YyT/8OqivoN7lJlpts3FDTIGO+cRpXWDUBBS7DLNhBAe1WeYI6ahvPtvtSbniNh3xBRT4S72INRvdw8IRtnNEPJJH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782980505; c=relaxed/relaxed;
	bh=JyL5PdaPFHYX3i7vQWHjIhQnNMA6B18Dy1lEHBssn4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nh4zI7COyFef5gWKwaC0dVMMiVohejgykW/huhmySxqP0ppa32GU5chGrz8D6XnSM7dAXtz6UYV5Po+XHDXIg86ei9sdn8hGzhYh8bq2iTqfH98NtFnRjXBAa5ZCRawBCOl+gtsMIELfcMiw8DU4nU0VaaVA4h5SDn6X7ifGPjwGlYEng8rUuLtGZyQvRq41dCnT+lkY2pSrdEyNRJ84ixc8nXkkB/eFcoUiJtWW6QUFASReS8r71I6+uKExuoiVgVM7W+wV1VGn8hUU+PoqkVbjw939KcHTspQJMDGjWVM+3UIvlOusyz67fmDGnoBpBOLplRv7pmLBs39GJ7C6mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NlVdL41w; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0bw0jIRW; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NlVdL41w;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0bw0jIRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVGb2pX3z2ypm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:21:42 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyL5PdaPFHYX3i7vQWHjIhQnNMA6B18Dy1lEHBssn4w=;
	b=NlVdL41wJjParPIUJnXa2XIDarzeHenpV2+nyfxGjlPYEnb8ZP1btKocZoSgONOK1W8bfi
	fPwBosRPvwAlyHOHg0UcLPrgKwlwb3/zkJyN8ylnaVMzev4FomBfmmNv8wDYWTJZziEJ0/
	VbVYZgGRWcgGj+BZAMwYD4lWMbopLxBShBL7MBpE6P6nG/LdCXSDQUoqzyis3FYcATFH07
	LniJ8SdQweQkFry0Mcy7hxBD3oZp8jFmspkUp1u+BUXK29OEi7oYICV2yysRfAZTO9WeSD
	PITz+ahnVJ5VHS9iSYJLzQiF2bh7rkTMb9TZbj04HgghiBYnBEbB6WNufJNpug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyL5PdaPFHYX3i7vQWHjIhQnNMA6B18Dy1lEHBssn4w=;
	b=0bw0jIRWs3vrFQs1H1oSIYdaDp8Y9fC9SKBoyWMkIGWWhAh3yXn8EbVJVaAb5Ls2pJnsXE
	pPCnjDimInHr+4Ag==
Date: Thu, 02 Jul 2026 10:21:30 +0200
Subject: [PATCH v3 6/9] powerpc/vdso: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260702-vdso-compat_32bit_time-v3-6-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4815;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A9MgaUprgJVGbFgeodL0zyKOakZj3wMsENaid0m8QO4=;
 b=ioxD5xT1F09ElJiA4jXNW6UAuz4w1BiJNze+L6ddQbxyZtMz+uqOHcTzXmB8Uyf1O0qqN3tou
 ivKRRIORIVcA8EaxM6HbdrpJ81mHQ8ymLbLTgF2kZajR3jS2EhXtxAk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/vdso/gettimeofday.S  |  8 ++++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S    |  8 +++++---
 arch/powerpc/kernel/vdso/vgettimeofday.c | 16 ++++++++++------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 1c8e51691bf8..c635cd1e77be 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -67,9 +67,11 @@
  * int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	cvdso_call __c_kernel_gettimeofday
 V_FUNCTION_END(__kernel_gettimeofday)
+#endif
 
 /*
  * Exact prototype of clock_gettime()
@@ -77,9 +79,11 @@ V_FUNCTION_END(__kernel_gettimeofday)
  * int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
+#endif
 
 /*
  * Exact prototype of clock_gettime64()
@@ -99,9 +103,11 @@ V_FUNCTION_END(__kernel_clock_gettime64)
  * int __kernel_clock_getres(clockid_t clock_id, struct timespec *res);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cvdso_call __c_kernel_clock_getres
 V_FUNCTION_END(__kernel_clock_getres)
+#endif
 
 /*
  * Exact prototype of clock_getres_time64()
@@ -122,6 +128,8 @@ V_FUNCTION_END(__kernel_clock_getres_time64)
  * time_t time(time *t);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_time)
 	cvdso_call __c_kernel_time call_time=1
 V_FUNCTION_END(__kernel_time)
+#endif
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 3f384a2526ae..5e87c18fd282 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -119,13 +119,15 @@ VERSION
 {
 	VDSO_VERSION_STRING {
 	global:
-		__kernel_get_syscall_map;
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
-		__kernel_clock_gettime64;
 		__kernel_clock_getres;
-		__kernel_clock_getres_time64;
 		__kernel_time;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+		__kernel_get_syscall_map;
+		__kernel_clock_gettime64;
+		__kernel_clock_getres_time64;
 		__kernel_get_tbfreq;
 		__kernel_sync_dicache;
 		__kernel_sigtramp32;
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/vdso/vgettimeofday.c
index 3c194e1ab562..4b712fb01a3f 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -18,23 +18,25 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
 	return __cvdso_clock_getres_data(vd, clock_id, res);
 }
 #else
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
 			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
 
-int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_time_data *vd)
-{
-	return __cvdso_clock_gettime_data(vd, clock, ts);
-}
-
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
 			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
+			       const struct vdso_time_data *vd)
+{
+	return __cvdso_clock_gettime_data(vd, clock, ts);
+}
 
 int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec *res,
 				   const struct vdso_time_data *vd)
@@ -43,6 +45,7 @@ int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec
 }
 #endif
 
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
 			    const struct vdso_time_data *vd)
 {
@@ -53,3 +56,4 @@ __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso
 {
 	return __cvdso_time_data(vd, time);
 }
+#endif

-- 
2.55.0


