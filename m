Return-Path: <linuxppc-dev+bounces-23154-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8741BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:44:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFXQ6cQWz2yjn;
	Tue, 30 Jun 2026 17:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805462;
	cv=none; b=nJhCz16QYPEmVRPnQIPKo20vokPNC/ruIvBR9sTl5xBsKyXiCThwRglzLhobXKfKp8JGYIYpGK9Tx4qn0Uuodr1PdT17/WW9/wqhqiqr+1aOyNtd9iKs50i2t/NbxmS/mTyA5U1EtNxCLk7qvUX7l3L9DeCtNzNfQqJhznpwJirWn5Slk+3AvFY7ZB4KkyCdWuQ07tG6uAV6AdmvTWT2XbW3XJIYWDFGbJu/K+TtTHtI932MxSlpVHmhq0u9DBqxMheATEErZHmF01CJb4vN3cGzG18n1TNSSi1F2VzKDroWY6sr2aDIPWrEyYDYgsD7NNh7uFGierMJQnCp1Qt+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805462; c=relaxed/relaxed;
	bh=S6M91utBDyER/aDTBiMUHXasRniYlvJ/pyD2pTrwayk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsyjyqAREjDoKZCeGtqj2Dz7I9+UOa+NEpWvoHt6Ranw31NOZ29meWxKjhRXIHCgFw67SSjrnLsmJLSn7j53OPScpLJqTcr4x8qkv2JQEkwfhT4nddZaFBzjtNn2zWUEjp9DJQZv0/wkwRZvK5mAGjFR0SJOQV1ISubNWH4b7xFkTq+C4wXYN58LZ9Ko/ngetmqd95QthwNXgnp/I0+31zuDbqgpFCCE8UDOXKMBR2qXiYjZfONwYnc25+JSD3RsV2cF5Ew/vgit3ZcePFGHoKVEhxT/abjo4V9/wnnfUnWP3KtcI2PhKyaZ/7BaEbszFNL7KYs95NFSJ4OYHGayYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=duF4/mQY; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=u4mle6I4; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=duF4/mQY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=u4mle6I4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFXL4WFJz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:44:18 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6M91utBDyER/aDTBiMUHXasRniYlvJ/pyD2pTrwayk=;
	b=duF4/mQYT5hX6gEHw8dMuRJJo2OIBeQFDn5XWX2fk7Z3ISsbZOA8FSLj9v2JCtnNso3IrQ
	2ZANMF7hOH/up3rX7dqHPd1sG9vJvHOUgU1Gc2guMVNYJ9Kkrh8Y5USQCgV16/iMHmUR2e
	zuV6hUjsUKOCMO3woVkdVsqjn4biPEM7zL8Oee2eB9vNe/HpOUEi8dEY4g5z9QE5+VCQ3O
	NS8dEp1YJxkTo8mERydkkRUNFXNYVU6DL3BTh100oS4LlRrEaMKwvqKI4QoI96SrQyy3tf
	3a/7TCIPYqTEuiIWerP5P5hrnk2yK/k0DD0jcCHD4b5ZJf4FZdTzDe+B+oMfIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6M91utBDyER/aDTBiMUHXasRniYlvJ/pyD2pTrwayk=;
	b=u4mle6I4bI3ZXtqPrEkvjfUQYZBLbkncMssz1fQpgdGYNQXy3ywpK7odOmEw5AVrKcK3ec
	rb6OaJiMs2XtzBAg==
Date: Tue, 30 Jun 2026 09:38:30 +0200
Subject: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type
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
Message-Id: <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=4359;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=I0ELZhoYhq+LtWILvEK7psoB2pGAmCGtbLQ0fZb65NY=;
 b=lKA+JCeWX+SJ7DzYMd60wozWzPqzhbOUH6o+Db6m7VKmveoGRrNH+JYFCw8hjKwqFs3A4FGuz
 C9lPF1/nufrA5wH6XkTdI0/vczjSKBfYsJNkCCfz6HTQGadj6Ihxem5
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The "old" time types use 32-bit seconds which are not y2038-safe.
Respect COMPAT_32BIT_TIME for functions using those types.
time(), stime() and gettimeofday() are disabled completely.

settimeofday() is kept as it is required to do the initial timewarping
after boot. However the 'tv' argument will be rejected.

Link: https://lore.kernel.org/lkml/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
index 0dd63a91e7c5..0b7aa432bc76 100644
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
+		if (!IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL))
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


