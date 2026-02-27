Return-Path: <linuxppc-dev+bounces-17357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DFDFD5302
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMfKb14qlz3c7n;
	Fri, 27 Feb 2026 17:57:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772175475;
	cv=none; b=DFleV95evBnGkuHrbCE+879lUs0yr4f6/Q37jkdW1bnFCnubr5+0CQFqdsXI0JhGIa4P1YHmjciMqWatOA00sOH9cPVm6uMn2WRzklzsbFOlKZEhGHV1rKHEOZPl8vgW/A++zBQMLxXSG8/0otH6kGg7C07ja1AtTGard1okvYLBlwdsRl/31uNr0qc2yzcmNTeByPFP2leG7YyZVnCoenMGfihgquz8Zodh4a4pJspHId5ms1O1mR2HmtIFgzAA0dieCdwqUvaJFzn8APjrz4xyM2uZYOBfQfEnoH5VvQLjnrNS9fU1MbdB2Zo0G+h5Ge+7ZWYM5bTYcaaxs1DpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772175475; c=relaxed/relaxed;
	bh=t1GJvcgWkbz8wTHp/DjmlS8V2g07Rf5DUkQm/V/ZPYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9mv7w4g2/b2eiT/mKXhcKclE8VCczXnyJERCK38jvrtt5duPD4TKQH0Fdc6LSaMDMk4+Ta3zIRHjGV7t4R9fh8mVCd0V/avLVZPR/m4lh0lpaR8jDMBsVlFF4x9j3km/WwadghB+XR6dzftRmXqdhP22erlppWda6LkjE6qyexolcQlwTyne1UojaVB3UP5bMTXjPg6xYsOelugisppmv1WXJrEjTUTcr5gThUjFF8bn8F7bzuhrgPgvF+HXRtw20wRgJ8qf93EmlEZUpqatQNry/4IuyJ6wV56BQDNSL8SnGmpkqnJsSGMnuet7JNoLqmFYFb2FuoztI2pfzF5ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hmx4hWjt; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3LXrXDPJ; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hmx4hWjt;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3LXrXDPJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMfKZ3h65z3cCC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:57:54 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772175470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1GJvcgWkbz8wTHp/DjmlS8V2g07Rf5DUkQm/V/ZPYs=;
	b=hmx4hWjthmw4yD0X7aYS6rU4XqnqGZtbL9w/8yXzstmtCHvt007ttxhUaUDDzR0D2xLZNg
	4ojeOmkO9HdfkPr/qwXEzOkpfKDD5T9DLaL6IAtSmI3TR18axTzy0SAtUE2ID2Eo+FhgAM
	NSsUQdkp1wZxsj10MxkYvm1XLJo4snCU4teJRCmASq73V0Ir8gZZOpCxnwUgeSH/lVKbW7
	+he9Da1Sd9D4hM/fEX37Aan4WzwNIKltwHJsKEKuHljR9+NMBbCPW06EXSD1MKVOti2ouI
	F5CBZHRRi63SHmlXWbLmg8xQzQ0kQRJ5sthkwy0jp6kuu21BD3Sgv9JscMhwDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772175470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1GJvcgWkbz8wTHp/DjmlS8V2g07Rf5DUkQm/V/ZPYs=;
	b=3LXrXDPJ0FuljL985vAPBauSlRHKHVsGJGs/AOnf5ySt4fkv9uSLkMuFFWko+ymIdBic8f
	0T1WfZ54uPl5DZAA==
Date: Fri, 27 Feb 2026 07:57:45 +0100
Subject: [PATCH 6/7] MIPS: VDSO: Respect COMPAT_32BIT_TIME
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
Message-Id: <20260227-vdso-compat_32bit_time-v1-6-3f0286a7bac3@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772175466; l=2116;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Km0PgJMXkFkzEVtC7VNNPJ/W6hZE0rb4fibkO3N6l5U=;
 b=iQZaEpF1Kp9cd9x/h4MaRGMO4/Ol0pvyrtHjVbAwfLjrsOI2BlP6jSY/FK8nHGf5AseFnQ7ik
 sV1FFBfU0WPDhwSf6+JchfdnU7Ez9AgnqLjUu0Db71Kwz8A+bdyy8EY
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
 arch/mips/vdso/vdso.lds.S      |  4 +++-
 arch/mips/vdso/vgettimeofday.c | 15 +++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 76b6ad898288..f60d66bb677d 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -96,9 +96,11 @@ VERSION
 	LINUX_2.6 {
 #ifndef CONFIG_MIPS_DISABLE_VDSO
 	global:
-		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+#if _MIPS_SIM == _MIPS_SIM_ABI64 || defined(CONFIG_COMPAT_32BIT_TIME)
+		__vdso_clock_gettime;
 		__vdso_clock_getres;
+#endif
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 00f9fcfc327e..39bc7e55fec4 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -12,23 +12,26 @@
 #include <vdso/gettime.h>
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
-			struct timezone *tz)
-{
-	return __cvdso_gettimeofday(tv, tz);
-}
-
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
 
 int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)

-- 
2.53.0


