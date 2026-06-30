Return-Path: <linuxppc-dev+bounces-23152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAF3C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFXP0TChz2yfH;
	Tue, 30 Jun 2026 17:44:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805460;
	cv=none; b=kdto9Lt9nNlWio1QsFrbC5uSs2K50A8sXOqd2tmTJe5Lz1hrCpXqcS3SxO3TCamtl0/6xU55Vr9fF7iTbp9nr6g3UZTA0hGcJLveahUrH8VgoRTfJNJMjoCqoct+5bXjQmWCZKaSrH3GNsB6oDIl280XFMgmoexgZ+B6rvdt+KoUP9n8zKcOro0HM7EHrnWnonEIf2MrEwRNa8pwoU8p3zgPV+8LFwrssWsmhLbmXdonW0XLdc4znoCDsFpN6HubN1i6sPLL/IlZFVqAQo1FuY4JWUXcwg3MrBX+BQ+Evm53ZM5IXeEM17+2C3aaatQoJ2LxjkGOQZHYJ3nzqKGvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805460; c=relaxed/relaxed;
	bh=J4jNR7IvW42yw2Udss8oMjXgT07Ci6ORkUJxbmsVFdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAxzFmdIL5KXaOL6za9a5JNKLOmQwmB5jp39ODL3BldZWClBZe6Nu2WlqC3Nbd3wKIzOZs5yRT8tQimcN6i71ylmv+IF5nKUaoLE8fcc5+XCcA45aBCTjF88j7rZ8n0FhdxyMubUjUyM3G0YixSO2gm8PnimXZFDuVT5XlVuiqRpOMGa8fTlKus9ok100g8vL80kOI2yRwsQSSAaiabOpjth3pQxwsjtPATk+jajXOtYXG9Yd5qxbhmS8DYW4jRIbpIAWo6889ZSsEsURPJ1BeuYVKJgKYWVDbj7QOJfg4qwiTfgTmZyXhXKSf6L4dd0tIiCsADALRBL9yooxTnX2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2UBKjP6Z; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=f83Sn6qI; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2UBKjP6Z;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=f83Sn6qI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 333 seconds by postgrey-1.37 at boromir; Tue, 30 Jun 2026 17:44:18 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFXL4Rmnz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:44:18 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jNR7IvW42yw2Udss8oMjXgT07Ci6ORkUJxbmsVFdo=;
	b=2UBKjP6ZHy3CRwMmUBUaL4kxEI/lQaVcZ5OwMsP2rjGQK+Loprr1BGaBZhBw4YAEi9z7dU
	M6igmNLI6dzAbCY20DEcphw4Q23zX7ya0jVLPy1lAkYUxtq9SepZP+OwypzPhHcj32BEhW
	Ezr2rAUK9JSOMiHtPCv7BzToplrlEQpPvrHeE2TEtb61dJiWT68d19hF+dfZil7Tmxs6Lo
	ddgnosAdzz+yq40r9sqRL3jnyJsPKSGU9rlv4WRbs43teWKh7R6DXeWYtUWhV2ir4tXK7v
	SNGZToUOxEBZII5zQxuMYa2cAOzWQOtElc3AGWQuRNgVxxh4O9E7EEVOj7u1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jNR7IvW42yw2Udss8oMjXgT07Ci6ORkUJxbmsVFdo=;
	b=f83Sn6qIhsaRZ/jxhSBKO89iQ/va46I2A9tQdntRDGvOCFXzAvYqPM/0vGIBMq5yP/ZOjK
	szz6xhbpCi37U5BA==
Date: Tue, 30 Jun 2026 09:38:38 +0200
Subject: [PATCH v2 9/9] vdso/gettimeofday: Verify COMPAT_32BIT_TIME
 interactions
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
Message-Id: <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=1853;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=12QPBY1A1qwsYzo0GG6Ngj7WiSTW+DNwVbPq5hDEyT0=;
 b=iLniktrStdEyXZsTH8ubljifMoWZxQv7NLjjYBM7Yr1YVx3xlPUy0sysk+14qkrzN0NXTK1Vh
 udMagMcO4uOBheZv2oJSUM8e5CtprPBwpBd6EQbpcV+gSy6NQKJfUGS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality.

Add some build-time validations to make sure the architecture-specific
glue satisfies this requirement.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b8c1fc85eb74..f7a591aba59f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -25,6 +25,8 @@
  */
 #include <asm/vdso/gettimeofday.h>
 
+#include <linux/build_bug.h>
+
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 
@@ -325,6 +327,8 @@ __cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t clock,
 	struct __kernel_timespec ts;
 	bool ok;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	ok = __cvdso_clock_gettime_common(vd, clock, &ts);
 
 	if (unlikely(!ok))
@@ -354,6 +358,8 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	BUILD_BUG();
 #endif
 
+	BUILD_BUG_ON(sizeof(tv->tv_sec) != 8 && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
 
@@ -392,6 +398,8 @@ __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 	BUILD_BUG();
 #endif
 
+	BUILD_BUG_ON(sizeof(*time) != 8 && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	if (vdso_is_timens_clock(vc)) {
 		vd = vdso_timens_data(vd);
 		vc = vd->clock_data;
@@ -481,6 +489,8 @@ __cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t cloc
 	struct __kernel_timespec ts;
 	bool ok;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	ok = __cvdso_clock_getres_common(vd, clock, &ts);
 
 	if (unlikely(!ok))

-- 
2.55.0


