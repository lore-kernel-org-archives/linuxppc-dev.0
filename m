Return-Path: <linuxppc-dev+bounces-23156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04092C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFXS4pyfz2yps;
	Tue, 30 Jun 2026 17:44:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805464;
	cv=none; b=MMDWZ9gs34+5ln2JvqFdGyeiL2JRKwFIHCqU212sdQi/EoVbyEo1fK0dURvuLPSwwQzD28XMizQFbwb0/vPSTWkiTuaUqs/kgkftn+PKkXbvAABE+E+PyIbf34Zv/v8wnKlG06QYkYvwyZUasiLhLq82CAqagey3kgkCmU4XrSHAGcZdwN+RDrvaMIMXzejrN+69xHPQFZ1oNfS3gk5xftVJaFFS5fjXWl+CLiYcDCcDdB73yC82O7fz9Hqzk3plfKIDxMR06h2hlRpjE3Kjz8/3OBjlDsJwtLoIXLn2Z7vKF/OEKvw7q3JH/5Mrq26GoJfkR6dCyZUb50hRxzlxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805464; c=relaxed/relaxed;
	bh=iUQ6jFSMVNPMzb38d677yAeg1LprsENzvRHiBxMRE/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxYge2TkVpH7F7hIYU/j1UoO8CjtfoaBDlerB2VdWriIKd7Dh6DK0mnionIb3cnSdf7p3hOrQPzkDI2id5p66qoWHC7VNcrGXcrOca7j+Ut7ZVciUNpmabDkU39UY/pn/Yu6SdJ+tNwqG9zemwqaexBg9IJKzPqVgHMfxX84HawT/pLYb9OPB6LRMZt53uFXcq7i6Ce4n7hOr24VsuM85tLcM6KDKfbyafJVxPPerGtiAG0Yft+p7c8WIvrcd30TfP2qtBvY13iEdtDD20apymbnYrosGuHa5sF1drspU6kSIzDjBRCmkXDkp9UOhAb5OtVEnOde5zsD97f53RnJ1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=azx0VF9B; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9987Z3GT; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=azx0VF9B;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9987Z3GT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFXR1nYjz2yjx
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:44:23 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUQ6jFSMVNPMzb38d677yAeg1LprsENzvRHiBxMRE/A=;
	b=azx0VF9BBEtAr6ThA3DX8ZuDyV7033nYYJNIAmDBN8Lp3/iyYMAoRv79U/JPQ46Dk1olVO
	WciQTdIzt0q+ph5qD4attfn0fiqCz5uLvmivbJVUKu0pE95/F4YtFHhpamzIg/msfr+Llp
	qFEwW7fEPEfv1C4xZDTTPLEivZi7dGUrZXnmiqW2tBLGGWm3sBhWKFsk7mB3XvsB1OpKOx
	aVTuT14dju5xMOQqEA1gJiM1BO2QhEb7DEsHT30dsHNr0xOt+9WsHkyi3jDg27QQVVtHis
	C8EwyuswDoQxqLYV62IgEHIObYywWlv4n6BXxgtI4USncweQo6NAcLostoKIqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUQ6jFSMVNPMzb38d677yAeg1LprsENzvRHiBxMRE/A=;
	b=9987Z3GTA/PZJ9Vl1M6iHdMwE8mQRNdoTRRjeakAY3fSlZgniuuu21uWmsb6Tp/5SN60S/
	Ik1kFTcFqNdv5GCw==
Date: Tue, 30 Jun 2026 09:38:34 +0200
Subject: [PATCH v2 5/9] ARM: VDSO: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260630-vdso-compat_32bit_time-v2-5-520d194640dd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=2321;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T7+Paogn085sgV9ELgz2TiMuWvOL8lCxlSvp1JXazDE=;
 b=PTy781XLM2JNi0R38FXtorGsAFXddDqIMmPeoQy7XdGWCfhypPS/ubgzDzcAGa/pbyA/i7DT7
 YjBmN0yfLKvBx0D/ixlkCFqITJ+WN73NzmdTvcbFjUarFsLbYGcUeOl
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
 arch/arm/vdso/vdso.lds.S      |  2 ++
 arch/arm/vdso/vgettimeofday.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 74d8d8bc8a40..e61038c0195a 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -70,9 +70,11 @@ VERSION
 {
 	LINUX_2.6 {
 	global:
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
 	local: *;
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index f7a2f5dc2fdc..3eebeddbfd18 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -10,16 +10,17 @@
 #include <asm/unwind.h>
 #include <vdso/gettime.h>
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
-int __vdso_clock_gettime64(clockid_t clock,
-			   struct __kernel_timespec *ts)
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
 {
-	return __cvdso_clock_gettime(clock, ts);
+	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
@@ -27,11 +28,12 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
-int __vdso_clock_getres(clockid_t clock_id,
-			struct old_timespec32 *res)
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
 {
-	return __cvdso_clock_getres_time32(clock_id, res);
+	return __cvdso_clock_gettime(clock, ts);
 }
 
 int __vdso_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec *res)

-- 
2.55.0


