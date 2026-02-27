Return-Path: <linuxppc-dev+bounces-17334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8EDFD4600
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2R2PP1z3bjN;
	Fri, 27 Feb 2026 17:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174687;
	cv=none; b=dhDg46g424BdL1hpX0kb8nJ5OpWL6I5fIXvJP6bzIprNE4YLxgC72TC0k1QX0pLRv6zWhUBHH7hbOjVe9VKqf1x6sjDY0iSwMVZexxbUxIvvTwe2CC3DfKp4KqSUVBwTt7FQ2uxYYnzxc63H6cYnBeHQtwrwIEtiCHwTWCGDOli2d4Vg1Q3HBzUyFsieZUoTidb8a9Do3dwfusOoHfi/oZwvtC7ktk7v3cr2fsoNVyhzCB67ya6RFj1+I6bV16dJ2MP0mInQJtJo5IIGsBDqW5w4n6DzEJim3KcjU+JoCZ1lNRqCfM//fZjAEwAiJ3nPNi3Td8Ejn/VrNTBKJWd36g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174687; c=relaxed/relaxed;
	bh=tIzyOBO0MUC1gjnQlOZaz5WdpoHJoIjGFPUUXU0dq7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHKtOlD9U7yybRceA/emVLtmhjuvzLeO0qiWalZIveSgtThJM/nS04SRDzh5jAvgZemSIufvE9VM+HZJysZRDUGnjIuqatjtSKKJ4fad2z9NpcPofmxxdWo/vjzfvvZCHpA4pIhrbHWhM2rUkGy2f8ZSAm3icEX6ldZHCmhiWP3VVlzYgfwvIa7HtXhk20g6T3gwBY6VGtqjp4dOfCrs2BcH2vTnCPzMPh6HyQ5hjVGp3ryNJsAF2eMLLEgpLtI5pe3REtKUYiygoW0bS5j7+EtPl8wWs4gn4l56JqdEy2JRH+uPXACuM5efw3PXU74OKLEZBz/6BM11hzPOTbq7sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E81MX9z2; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U94drMM5; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E81MX9z2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U94drMM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Q2pnBz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:46 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIzyOBO0MUC1gjnQlOZaz5WdpoHJoIjGFPUUXU0dq7E=;
	b=E81MX9z27fb6iOgDPvOjHyZq9lLoj5k7Xn4lhkXaNGe+gQTytI7YYl/p5GxyCR0bpojyEl
	I+ytafun06DCmWYljV840vgi/0RqQ0PrTsgD1b6mau/3ev4WlS35Flv65khQJPJm69OB19
	5/Ui4qC67Lli03t78tLB3XaKiMWrgsXYg3sSUT5skJ7m85q/xhqehxm2ciaKp9LgGaqrtp
	cwgKZPwiOPxbxB2axoaVmFdKlSr87wTTQU7R3UTjM7UJQ2RyquhN7VyIdVNYjuAwr99jkn
	k7CNW3By19H79/yNTztN1GKacKgRTLbJVqum68Ca0M4YVfCpEteDCjyhoVNLMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIzyOBO0MUC1gjnQlOZaz5WdpoHJoIjGFPUUXU0dq7E=;
	b=U94drMM56wMv6zpBylLQPwmLFuDXo72akf5+eb1y2OjPiFv44gi9g/toB2rqCZHPxOpY1/
	5xKusqE5XrZEMwBQ==
Date: Fri, 27 Feb 2026 07:44:29 +0100
Subject: [PATCH v2 03/15] ARM: vdso: gettimeofday: Add explicit includes
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
Message-Id: <20260227-vdso-header-cleanups-v2-3-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=899;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aYrHWJd0bhmjChMmo+JGha4OUSHIgaD7jcuPC+kTlSg=;
 b=L+nxYTe4Xu7tbOaysmodJ3f65uyex5hwuv4KS3TnbH0HYi4mZ5/LtcKTrbLS5iK5/ygPPMWVi
 i+XTjg51+63DE4ZupdB1nrJ3vyHCCtJqQWsPOwIN0nJQy9oIttoD0qK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h and
'struct old_timespec32' requires vdso/time32.h. Currently these headers
are included transitively, but those transitive inclusions are about to go
away.

Explicitly include the headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 1e9f81639c88..26da5d8621cc 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -11,6 +11,8 @@
 #include <asm/errno.h>
 #include <asm/unistd.h>
 #include <asm/vdso/cp15.h>
+#include <vdso/clocksource.h>
+#include <vdso/time32.h>
 #include <uapi/linux/time.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1

-- 
2.53.0


