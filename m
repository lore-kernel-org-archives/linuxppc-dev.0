Return-Path: <linuxppc-dev+bounces-23365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B2FC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:21:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVGS3Zjvz2xLk;
	Thu, 02 Jul 2026 18:21:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782980496;
	cv=none; b=FCf/a6Z028q+EZ76/aQPrjrrbUcKVbbSEpagEsDnmhnxypLXt5XvhRwwX+y1l3zwTFHvx6KfqhzrnVs+NrSaT2ekmWoxHikimAARGhdxB3+coCs2SqiEoAT57L66sEsbABUHYrCn/YNhcf0zPI2bj9LBrLigEYdAWizQD1dXXMIGY9GKNdhTYlXCZ8lomibWh+1twB1vmiPFtRJJMU6ukWM+q/IiP0lg7gnmjtSprzJxkoIEPE3+ThRbKiPRM2nWahwjAxBhMqvXCmGf2iZ4Uamj0MFq6NfsIO99Zigbb/g3wpRkih1wfOKjuSMyU9bAeaFZj7mkmjFnbaGaZZGFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782980496; c=relaxed/relaxed;
	bh=Hw7CMtSzZ3T03/nHIxRfsVoUiZsPLzFgwT0l0XLT+Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSB2ewneDT5/JeqZUeUBDekneoi2K5edHPu+VRNRZukBfNU9frpV62p/1N7zn4/6iKGGFpnDE37PeG2rbRP7NKweJhZytR9TaPboXiBp7RMKBJT4ofvj8jvIJjLgSrVdp1YHfS/S99rN8pZq2xxvH7RAv7OBdm0qzrHifKOkTAloc5DTjMiS/p/6DLcq5wuTsnkUf1CmvcVaLm6txwJTIOhCMYAGr+ml1M2h0iTmM46c2LRlk/V1QdiA7UbGRMKyXCgewsHja2pBdTBhcHkk44Ym1amoeOER9BjKQ3c3eDb+SENUUsMCCCN4/eraxRXUdS8HDoJqLoMhQuW453KSlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ODI4rx+o; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4u6eZy6u; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ODI4rx+o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4u6eZy6u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVGR3248z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:21:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw7CMtSzZ3T03/nHIxRfsVoUiZsPLzFgwT0l0XLT+Jg=;
	b=ODI4rx+oZm7smBBBPpFBoEzJffCzbGEdLsD5wPz/Z8SWP2KWUliPgSciBLpp/HnVa9HmGg
	u6bIFv7MkwrEaqND87SmtGQ7ULAhisPC9KtkyHrqLK9b8tiO5Esp1+GUp7LIU2TJZJdZ8l
	RiwnTbK25PJ7owO7x/NA2E/DDb4qx25xKPlJQkpLKiuAG6Zk9U6nDjbFa7yMjhYuMyVgIU
	pJs4sbQf1tsOYCRwAkkBh+7op5j3IGOFTrlewqWvZ6996ySNqZn/PfX1++o+FUIpjcfM2c
	WETCgoBy0PHMFdSjgI8xR5410KhZDwYqng4RRYVUzaE9wF6e3tOwaB4kjXZpIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw7CMtSzZ3T03/nHIxRfsVoUiZsPLzFgwT0l0XLT+Jg=;
	b=4u6eZy6uRINUX51mFPcy79lFscIhOYvFi8pzq8BrNmI3lHtBbhToMDZMYez4+Vw+p3h4vU
	qxvfvL8PolrSSdCA==
Date: Thu, 02 Jul 2026 10:21:25 +0200
Subject: [PATCH v3 1/9] time: Respect COMPAT_32BIT_TIME for old time type
 functions
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
Message-Id: <20260702-vdso-compat_32bit_time-v3-1-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4399;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gj4V+syfmAXpdEr+HAh+eG00nr/CFRTmxa9XCdZH050=;
 b=kHodoXYGMDqQpGUjixS5+cbPKN/0Jqd7NpPoi4peiRMHPp8ULeu4jga/P4nLlW1n9oTDU5nYk
 vG017ekPc5IBx5pLMAdQGd0O4fsI3rokIoP9aC8/mbb7ofJAdOTZSq4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The "old" time types use 32-bit seconds which are not y2038-safe.
Respect COMPAT_32BIT_TIME for functions using those types.
time(), stime() and gettimeofday() are disabled completely.

settimeofday() is kept as it is required to do the initial timewarping
after boot. However the 'tv' argument will be rejected.

Link: https://lore.kernel.org/lkml/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sys_ni.c    |  4 ++++
 kernel/time/time.c | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index add3032da16f..c8be0abaa407 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -351,6 +351,10 @@ COND_SYSCALL(ppoll_time32);
 COND_SYSCALL_COMPAT(ppoll_time32);
 COND_SYSCALL(utimensat_time32);
 COND_SYSCALL(clock_adjtime32);
+COND_SYSCALL(gettimeofday);
+COND_SYSCALL_COMPAT(gettimeofday);
+COND_SYSCALL(time);
+COND_SYSCALL(stime);
 
 /*
  * The syscalls below are not found in include/uapi/asm-generic/unistd.h
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 0dd63a91e7c5..f836a31751f4 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -43,6 +43,12 @@
 #include <generated/timeconst.h>
 #include "timekeeping.h"
 
+#if defined(CONFIG_64BIT) || defined(CONFIG_COMPAT_32BIT_TIME)
+#define __WANT_OLD_TIME_TYPE_SYSCALL 1
+#endif
+
+static_assert(sizeof(__kernel_old_time_t) == 8 ? IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL) : true);
+
 /*
  * The timezone where the local system is located.  Used as a default by some
  * programs who obtain this value by using gettimeofday.
@@ -51,7 +57,7 @@ struct timezone sys_tz;
 
 EXPORT_SYMBOL(sys_tz);
 
-#ifdef __ARCH_WANT_SYS_TIME
+#if defined(__ARCH_WANT_SYS_TIME) && defined(__WANT_OLD_TIME_TYPE_SYSCALL)
 
 /*
  * sys_time() can be implemented in user-level using
@@ -96,7 +102,7 @@ SYSCALL_DEFINE1(stime, __kernel_old_time_t __user *, tptr)
 	return 0;
 }
 
-#endif /* __ARCH_WANT_SYS_TIME */
+#endif /* __ARCH_WANT_SYS_TIME && __WANT_OLD_TIME_TYPE_SYSCALL */
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 #ifdef __ARCH_WANT_SYS_TIME32
@@ -137,6 +143,7 @@ SYSCALL_DEFINE1(stime32, old_time32_t __user *, tptr)
 #endif /* __ARCH_WANT_SYS_TIME32 */
 #endif
 
+#ifdef __WANT_OLD_TIME_TYPE_SYSCALL
 SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
 		struct timezone __user *, tz)
 {
@@ -154,6 +161,7 @@ SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
 	}
 	return 0;
 }
+#endif /* __WANT_OLD_TIME_TYPE_SYSCALL */
 
 /*
  * In case for some reason the CMOS clock has not already been running
@@ -203,6 +211,9 @@ SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 	struct timezone new_tz;
 
 	if (tv) {
+		if (!IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL))
+			return -EINVAL;
+
 		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
@@ -220,7 +231,7 @@ SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 	return do_sys_settimeofday64(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(gettimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
@@ -239,7 +250,9 @@ COMPAT_SYSCALL_DEFINE2(gettimeofday, struct old_timeval32 __user *, tv,
 
 	return 0;
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
+#ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
@@ -247,6 +260,9 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	struct timezone new_tz;
 
 	if (tv) {
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -EINVAL;
+
 		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
@@ -263,7 +279,7 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 
 	return do_sys_settimeofday64(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
-#endif
+#endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_64BIT
 SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)

-- 
2.55.0


