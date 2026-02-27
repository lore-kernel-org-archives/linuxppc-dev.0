Return-Path: <linuxppc-dev+bounces-17339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3012FFD9E3E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2W4P9Qz2xKh;
	Fri, 27 Feb 2026 17:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174691;
	cv=none; b=ZRjf6HePD94TJCdsmkKCgQMcHWBgUqPxKAGvbHlk12Y7cgYNoqy803bOg2WZsEqn0UNlKOa4LJAZzR6ublPsrUoW+X2LdLdHDYkRkI57NUOrf6nHA5eKyPVUX3GvHe0DowMZJzJkrj9XaM8cUgApU2BZmQu30mUu7gWIfKLFBnYzcGmZuiPpMfq+59K2U3f+CIhgKe7pUSTm1uxx3fS91ro4TDKjaurwC8E+/ZTGZfdpDT0ZWeViJYQATyhBkYiUf/ZY4/ctPQ8cHFgYV0dtnzyy2776nL4sCTJPqr+3BxUPFNm7NTYWnntyPuE0k8cjsoeWr6es5g0OcjNICH7u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174691; c=relaxed/relaxed;
	bh=3e/NNt95zCxtiCGoXkbHwk0qG7BgGrrwg5COo+2IR4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAxtSk008FldC5DcTWChQUlWaTcRSCQw5UOt9wkErf8ex+dqJXbSQ7c8k7zvd8BTi6D6RjF2l7sbc9VV7zHSvHo2AdUbpng7kQ0r3VpOIM5GG5kkmQcvjpP1pRJXkCkSxPu1ZdKBhW0bMa6vRUufIEdHw1Tuorr0nqVrUIDRqIOPqYf/J8ZhaJVhj0sSZmc5UaLntWZEu52qC9jHorOlqD6EFjy2DDMhMYei6q8R1C/4pESbnn5jztuTL2JWwuXezZW4Vx/iCgLxsk4dXXWhwrPKPmg1jYKKLnB+5VoUTkqcSIKtcfTXHDc05ln6EJFyha16ez8iPAXD+OpeU9VPhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rMSSg6Kk; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z+7rDyIY; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rMSSg6Kk;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z+7rDyIY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2W0Vt2z3cCx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:50 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e/NNt95zCxtiCGoXkbHwk0qG7BgGrrwg5COo+2IR4M=;
	b=rMSSg6KkrB+0JkEM1SVz4yxaMDvQUAxB07ZFP9o0HFv6OnuLmfJlM9CHLY8ayOT8Uhnze8
	pLV4mfEgu3dsHx834eCRUmmtN4sob50LIxDOtoV4HLJRpckcONip2LvGVDl/0uetoYfdme
	WYlrXelcW8RoqItBz4pgzGh0g3/tsixL2/scHhnwHl1qFr+6VQK4fNZ+uICoU6db8BK5HX
	mvQ7TDFgU4wiudUQVcteSfUyFjtl7tnEOJkifbpUujp3RFT4F/vZMuuRQtgKgxv4iRvb0q
	NnJyjvFya4aexIexIuGGS4UVVQB8PDNaK4qjW4e55/9HW15nge6lQefC55Rdkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e/NNt95zCxtiCGoXkbHwk0qG7BgGrrwg5COo+2IR4M=;
	b=z+7rDyIYn1phXQcYGsAZsKJBR7n26KW4uUnlAVjzkZZjU2TqDmha5eFw4erHfLHmHrpl4F
	mpFNzwgxd8QHywBg==
Date: Fri, 27 Feb 2026 07:44:38 +0100
Subject: [PATCH v2 12/15] vdso/datapage: Remove inclusion of gettimeofday.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-12-35d60acf7410@linutronix.de>
References: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
In-Reply-To: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=1781;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=I1SCO5giHITu1X8K8iGKyItIGK/4mCTfzb50bCLrYKk=;
 b=cXXrn6n7S+LEJc/Pp/MqAwi+lbezgl7mZP2vqpUPRpYbrjF+hNOZx1xoGZnMYsL/8exZLnqct
 PS2lFy9vGRJA92TiwY/nge/emrraWRcMcE51aTOIQcxtePRxMwT5RuF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso/datapage.h is useful without pulling in the architecture-specific
gettimeofday() helpers.

Move the include to the only users which needs it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h | 11 -----------
 lib/vdso/gettimeofday.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 23c39b96190f..752856b36a3a 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -184,17 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
 
-/*
- * The generic vDSO implementation requires that gettimeofday.h
- * provides:
- * - __arch_get_hw_counter(): to get the hw counter based on the
- *   clock_mode.
- * - gettimeofday_fallback(): fallback for gettimeofday.
- * - clock_gettime_fallback(): fallback for clock_gettime.
- * - clock_getres_fallback(): fallback for clock_getres.
- */
-#include <asm/vdso/gettimeofday.h>
-
 #else /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_VDSO_GETRANDOM
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 73b079eb4511..a4b0f06cf970 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -12,6 +12,17 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 

-- 
2.53.0


