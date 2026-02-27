Return-Path: <linuxppc-dev+bounces-17336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12CEFD9E34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2R6h4nz3bn7;
	Fri, 27 Feb 2026 17:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174687;
	cv=none; b=WecELCVyLRgetMGpuPtgAkWmj1ZjE6Xkblf/Zdw57YidXopZLBCc1q0MjjuGPVBnQOazL7A2ssyvZhWpVuA44nYoS1RiMfQGOQm7ohz/ouZuSKfYn003fW9sQC2wqWv/iCLx/On0ZBpuwE/xdB0xq3gm8C8toXnIKzhsI5z5vQRZLXr/yzYCRijYI664yVG8X9udupY6Pp+5iYynuRY56/qJB7dRNGUQ/pfO/7cDNdikHgiiWIGN5pfIIBzvmC395V+69hfUxPoAgspc5zg5JC0e9p7NwNWHzhvE1Qr/NEOnrdk28ad/Q9ZMuB1weilYyVU7LBHuNeMqhPMAIzWFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174687; c=relaxed/relaxed;
	bh=j41rfTYZDcPnORX6+H3qvB6/XTLHclkdQxhoSfZSj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YssQ4Xdc/Wev/TbWo4Ddkn2JBKXq7+nxvnf1NuSAT5v0WLz28JP8DXHUs5VlqHeDLk8LzsADXc0shvAqO4kkLt7/VKKPHOg9v+IS2Z+F8fS7TpMjnUeV8yzQVu8kJr3bySWYSibJUbBwE+LkDAbfd1IVQ+q2rtrOg4Dx/Q3haHWJdT6G5TETbL8s8CZAmwkvW6+OVPhfKoNM/s3RUP3tavVNHW4s6/ESJcOaG48KmMO8YYymxbt4eWMWJ/c1dsHXkNevBml4Vtauh/gL/wrnb+rPafF4z3TvME/9u6QvTqWJVYlnZG2rrhSVJe81wktq68dCNUiF7+D7PS6ywK20rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=teLIpbJD; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=sqnSEXW8; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=teLIpbJD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=sqnSEXW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Q2s1Wz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:46 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j41rfTYZDcPnORX6+H3qvB6/XTLHclkdQxhoSfZSj0Y=;
	b=teLIpbJDZ6ty4EgjyBCW0HNDQ34y6Z/GXXufwmzJ9LwvX3UJC767NVYgEO0dWOABJOe6Kh
	z+HJWNIcxCYB0GXNxmXgCAS8H/0wt4W6xzz6kpchpLwI0OiCnBQIJkfXTxsv0K3keVRjcA
	Zn/5jiYqYhQv+XPXUxPXU+XsHmZO0LaxiVSj2bdLrkpla+oImCr6cMtfd8bTEMrrc2zk2l
	/g1Fp7rXxGDHSUJFNFwcXAJmE09ZDDT7FRKrjb+BlA5OCRBIdfuEvwQ4v9UYZ12/GLk1s4
	655Aw+ZR5m/M+16gGq5fDWa1F9Pi1avC3N1OHab/nthSXnO9zRGI6fvAxp2yEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j41rfTYZDcPnORX6+H3qvB6/XTLHclkdQxhoSfZSj0Y=;
	b=sqnSEXW8Jtxu4AdEvoDJotRY5wYBKsIIkaMGtV3TVl8OfAUEgUeaTEYq7RJJG6dW062WZx
	wLWGxNssGv3lS0DA==
Date: Fri, 27 Feb 2026 07:44:27 +0100
Subject: [PATCH v2 01/15] arm64: vDSO: gettimeofday: Explicitly include
 vdso/clocksource.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-1-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=B56aYMYQAdEmPujlFuVOYBxgPBhNNOzHKiu9popOBq0=;
 b=Icd6rTz9LQS9xz5L4WU3B7Au6NWvTQBRcgEdv4gqrl76kLvgpQ8QZfGaYsOPM26zB1bhzUCF0
 HQhi0n2m0/LB3MiaPP5WgRq43qkpYPVWp3cMShvvv8zUN57f7Tc5KGq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 3658a757e255..96d2eccd4995 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -9,6 +9,8 @@
 
 #ifndef __ASSEMBLER__
 
+#include <vdso/clocksource.h>
+
 #include <asm/alternative.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>

-- 
2.53.0


