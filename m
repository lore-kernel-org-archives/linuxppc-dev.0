Return-Path: <linuxppc-dev+bounces-26898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19FAC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgF5TXFz30WD;
	Wed, 09 Sep 2026 18:51:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943897;
	cv=none; b=gDA+T9x01F/Q0FG/HPfwjMy7gEK+CPGdnsV5XCzA026pKCYusbygFPGoIZRruwUYs2XghTCl1PmE4Q6WbKGPWeq2exiJZJ6m2EN2r2rTs4bE0egBP8WA2F/0LnuUXXK2MGe4+P5BFVJBiOTVyKZH5LwvlIuUxC69P28mK9hzaVFMz6qgPvP9EA/tvNtqIGBn2E9Xgy+5EXYOENkTAEnxYYNnHkaoqBGSzzyqGxznJzYNqki5x0Q1D4JWNOIGE1jLZvbX2GLPoJFhA5dmZOJe5WyWM2W73doojS0ZqP0++dm3B+S2B6IZeGBOD9sySj2eOhd5sGXr39euq83bB2idHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943897; c=relaxed/relaxed;
	bh=oh1PJG/vwynt7EkxazpWcIlavpMds/jXQGtW/4wg0d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFwkYXh4JYdldd4tIywU2R2LJDcEeYAZYiyrI6cSuo9I4W62gKeHl2+U0N/t4myE7+TCqykoXV4doP95YP+OUFiOXYdgG5eRvsoqrcWocl9Ir8fVl8EBbrc4tjTc1orbusVCAC/Lj85JS8akZxNw6Vgxz9Gcav8E5oNt8nXlWO5WYW+K+JJGgV/oaXBdiNCSqOXh+1Fv3TaGtafXZzp02RQdsI2YuHeWxWYI0TmFiDxQWw/9a2PlyHOngWSQVSaJvnYnxMPsa6mU1kZYMlVv0utf5hDHgXmnYwQ4K6ck4MtPby8KzIFR0K1zQGbmIM8nb9uBaRcJDvU3K/JP3lptsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jG8f6cKe; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+0brCh2l; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jG8f6cKe;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+0brCh2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg96ytKz2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:33 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh1PJG/vwynt7EkxazpWcIlavpMds/jXQGtW/4wg0d8=;
	b=jG8f6cKe83NgFyvB7usZY5ErQO/V+DEWyK1IB8tUERMGKxGkzLNkIRGesrebnzL/Gxsnyi
	ajCdAtna/v6CMkAKXjthX4qDcEE9WrSAtMgIfoQFesbhR0R4vNqSYIZ1OGchhK7tOM/GSY
	SGyj2dZCe0nw25WQUym+CIEiEZ6x/wUaSFxGrW1UHbhREFH9op4ca2NuLp1Mo/RiW4B8P0
	WztwZfxOkGPxnJhqkzrD+mcn0yD453QUx2P4tDWkiLiMbYyG78yBvjcK8R/Ym+DjhTxPlv
	Qu07I+AE0JkTdPbZxhPMQ3BqhKIYkYs6yAnLeDVndUB+dkr600i6Jh5cklHbPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh1PJG/vwynt7EkxazpWcIlavpMds/jXQGtW/4wg0d8=;
	b=+0brCh2l6wZIkosY+LRmMvfxx2IhX7GE3jNB+mNx83iF8+o62DG8Ex4rQiFeyrEcrPuQlG
	/Ke2Gl8rQAlYcQBg==
Date: Wed, 09 Sep 2026 10:51:23 +0200
Subject: [PATCH 10/15] x86/vdso: Delete asm/vdso/vsyscall.h inclusions
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-10-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5kEtWlx4srqMSxMbrqSmgOqVkUKIg3dsZZJXpVNG60I=;
 b=n4PspGkIOT4Ebc+CmHeX9ALb1UVKIlo/hmp+mpBEFSF3QM6gtk5pa1nGQAPgV+tbbPhWB3ikF
 CsF4rPheNMACU2R8R3gkRXtsPOgU2bhh0jtZnJ0G/TUZh5S+gNmgRl9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusions are unnecessary, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/common/vdso-layout.lds.S | 1 -
 arch/x86/entry/vdso/vma.c                    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
index a1e30be3e83d..f190efbc640e 100644
--- a/arch/x86/entry/vdso/common/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
-#include <asm/vdso/vsyscall.h>
 #include <vdso/datapage.h>
 
 /*
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 18dfd80a81ef..4bd3b22beea9 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,7 +25,6 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
-#include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
 
 static_assert(VDSO_NR_PAGES + VDSO_NR_VCLOCK_PAGES == __VDSO_PAGES);

-- 
2.55.0


