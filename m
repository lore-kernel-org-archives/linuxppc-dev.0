Return-Path: <linuxppc-dev+bounces-26900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2DCC79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:53:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgJ2yjhz3bj8;
	Wed, 09 Sep 2026 18:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943900;
	cv=none; b=VUnhHkv0uEbH9HzN3g4CAuEteYmr6dvTBAZ0x8/UKu+des94efouZc8ShQLLZ/ws0FUkLGZ8EXZQnDgkdMHwYdWepvy3ZjiN9W56ANZecQPE997fPkp+QMsS9LY6G/ZpNvESDbIXm493Fwz1n3T2a0YX3zex3yaNiQhCWkFHT4esniJuvbT5TpQLXS5SMSATHoE5x6IzDsp0zGZz58xRUdLCjAy6yKOJuWLZVFZ7PRZ38QcZOFW+7PBNoIt+SV41egxmAcsJKaDKUPrXwUi3yJ8z6B9L7ck2KIDd+Rau99uYEGJF+Z3qL1crPn34H8DD0B7N4coSkAlrGgC5Tiilgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943900; c=relaxed/relaxed;
	bh=bRBWj4mHSE+gknjapqdIxCDI+b+DaeaenxvpulsS1K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH089fP5Lkp52CDogiOn/6ApJKO3uz7OWSpvopgTltKvumQeAcqVQbOGCdafzTC7uGleA1WPOouQ2dRP9aPNFU6FbAcOSeBDF3Qfwyqq5/OHItiSGU8psWX7a3K7Emk+ibrMGSD+785XCysmzb68srU9x/ObjZ+U0JxFAsWqmMg2E3Xmch3ejrPQBzPLWTYSHi8Mqk7ReAlvYVhBxe1VfH+dSelFhsmI8fQyK8nzgHcLein3LMfxPuRdKRJZQ7SJhaZ1vSI0mfy3TAcj1vJ4nURjv1+Me7Fai3aoXwZDu0+G8r1igjxrqdtCfKQlM5iHQiS2lkH97eiVx9qBDyIwvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OuwvPY70; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wRCjo4pp; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OuwvPY70;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wRCjo4pp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvgC6zCdz303X
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRBWj4mHSE+gknjapqdIxCDI+b+DaeaenxvpulsS1K8=;
	b=OuwvPY70bFMkqtB5jpFaHm754bhGKnxYjRFqeq/NxUHsAi1S/l6DON/VFVG35d42rblTYT
	q6nPgppRoUf2NTOIeO19SzWG1Dgirc42Owbs6GVYpb3JRlXE0lZTUWmbSpdYa/IMY0+PSQ
	BpBSXtapXIZ3mUdmnI6qABHQMVSFVsywYuuxu2WTq380Uq/f2FD3rHQ+6dci7c5FY4beKt
	spLLl3asON8tW8f3/yj9ohsCwkhsjD3en/x7SdI5zE8pzWRPc5klauC/Draw/Ok6Tk5WgX
	qeDqlDtCTn4HBCSILi54ACQICpWadAvqQ4UBqYOAtZWu1+JDURIbjPxybYHzSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRBWj4mHSE+gknjapqdIxCDI+b+DaeaenxvpulsS1K8=;
	b=wRCjo4ppx3NZEr7blbkSnFDjUNREZe3LWFNZiakgUojTuDBVUpaNXO4d+N8RwyHc3AJBN/
	Awf+ktdqmalyM9Cg==
Date: Wed, 09 Sep 2026 10:51:24 +0200
Subject: [PATCH 11/15] arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-11-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1045;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gLJEWgigGyJ7XawvovjYyQOfwIjsfDH42RIEWGgskXM=;
 b=dXObFU3KxzH9K1ul1RZRBGrqGW/wDZaQe1dxCAARQqeFJPUhpOY3RLhbeefuEg4MBu550yA8g
 Kiuma1H8fEGDwbk+wuxsy/poBd6Gxu2/vVk7ernHzK4zAYbhLyYb6VM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusions are unnecessary, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/getrandom.h | 1 -
 arch/arm64/kernel/vdso/vdso.lds.S       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
index da1d58bbfabe..d9b9104d4ea1 100644
--- a/arch/arm64/include/asm/vdso/getrandom.h
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -6,7 +6,6 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/unistd.h>
-#include <asm/vdso/vsyscall.h>
 #include <vdso/datapage.h>
 
 /**
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be29191..6334ca0a7673 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -11,7 +11,6 @@
 #include <linux/const.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <vdso/datapage.h>
 

-- 
2.55.0


