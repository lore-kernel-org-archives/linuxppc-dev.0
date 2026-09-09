Return-Path: <linuxppc-dev+bounces-26897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A687C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgF3xfnz30Qy;
	Wed, 09 Sep 2026 18:51:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943897;
	cv=none; b=NT8u89nwlAnX02mVM6UGa6myoAhnD0FNB94YFhzVy9ED0RKiz9/KwD+/9FEEdXY9okN64Jar0DKIoG5TtXLoWzMnKNgS0xikXRjmX4IW6qthBkhf+NueuHhccSj13J2eByxHrI8ynGtxw3c6Cw3ObGAL+UkxNyEjf3d0X0F6DPE73WTgEuCOZ1EkmerYXcF6wV0eaOtTuUCPm1X1/Ns40msYrfVZkZ5LBmt2xdjJ+0BvefSYUXU4yYuwQaFHU0gcZ+JLVC16zR3RsJmD1ScozJyP2vCcX8vcc9UdH4cIgZ1bh3jo83/B6Eo7WILGatXyA+hyolRzG1ZI5E2/fealXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943897; c=relaxed/relaxed;
	bh=Pu21AANy6bk1mlm0NmAgLdaZdlkGyn68YRFNRQ9INwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYUWpWcn2q1eKMFRg7KBEevpIxdFu0B++FbQBbBeZBoAt2G6y7fcVPDvTxPs+IpCHxYq9ujwgueIiGyAnG/aFPZ2l0FXquMivxwj7ZqlqMNAB+b2af+mhmeOEWMPeya3ze4SmJXqOZ5ghA8e+qjNsr85JlXCmpl/pSTBIWIHolMnCZTw44TQYUcLRUQt0WxnhXL0oV5QYxINqTA2r78tOMbUVw8hBngtcMnADL/GNjQa1FxEKlkXVAb5viLJb07WMwY3rFJ/GLiYQdvexrYB3qr+akRxTGlTkiPLther6/1X/w7We6YLyhi1c3pkxrzVYWyBpBaigTZm9YlMmjXxoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fY43G6LB; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fS/qMfZf; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fY43G6LB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fS/qMfZf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg91D6Nz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu21AANy6bk1mlm0NmAgLdaZdlkGyn68YRFNRQ9INwY=;
	b=fY43G6LBWdQkHYdyVBIxlLabTz9sY1wdEwbix3guUJj3EMTAlgttvjyicJzcS1byA/EYdy
	G2GOcuMDfq5geeNDnOjPbvRb7EzsEL1Clk/H8WaN0sddjYKMQS4eG0BqCIjRr0OlvTLJSN
	RN90tB/5INV6w2dlX8afOXI3xFKQezguucJCgLOZTNwjr6RY6fTr4CjhnpG2JJQfq8bTxY
	xQ1o1MTBSTdqjdBasvcUb1G+ogTvTjmpXkvfnYDAWwEY82x7oyBpb3faiydAcgcQB9K5Yj
	qx0k7QtEbJReCwJRQceG/UD512/jPmjWdRPduWsrE9i7v+i6KjtZJ5SCxfdJxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu21AANy6bk1mlm0NmAgLdaZdlkGyn68YRFNRQ9INwY=;
	b=fS/qMfZfymFeZyXXZSlfW6pLXpcG8P6cUd3bXFewTMfnuYEoBNdNlxmu56kaFJOQgmnkTU
	azAqtLuPsNDaytDw==
Date: Wed, 09 Sep 2026 10:51:21 +0200
Subject: [PATCH 08/15] s390/vdso: Delete asm/vdso/vsyscall.h inclusions
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-8-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1455;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XEkGmHaO9UQ15JGGo9EFCqoDzN0VZwQacIVpi6I6eho=;
 b=tWx5LzZMM3tFuh6dvop7MXiyaao+GWjDBE8xefvCVu+hYibUJLQsMpisPmgpEGcWAc/Wv8tBg
 BkTPk+qz6khArKF3lgV/FIsobdzvGD8+AIMA3xOqRUfKNBft+tKTA1x
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusions are unnecessary, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/include/asm/vdso/getrandom.h | 1 -
 arch/s390/kernel/vdso.c                | 1 -
 arch/s390/kernel/vdso/vdso.lds.S       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/vdso/getrandom.h
index 6741a27199f8..ff5882f2fc70 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -6,7 +6,6 @@
 #ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm/syscall.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 0fe616c49fcc..a905f989f910 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -18,7 +18,6 @@
 #include <linux/random.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
 #include <asm/vdso.h>
 
diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 841daeec4be2..6bcdb64315f2 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -4,7 +4,6 @@
  * library
  */
 
-#include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>

-- 
2.55.0


