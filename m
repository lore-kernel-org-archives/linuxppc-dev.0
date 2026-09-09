Return-Path: <linuxppc-dev+bounces-26899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA80C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgH27B7z30gJ;
	Wed, 09 Sep 2026 18:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943899;
	cv=none; b=JPmswK5otBt+GiwYmDpxFCGMj6oe3tdmHmPiFRBboV0VDj77GX1dVNaLlUS9PcW5OTTFB4+Q1iLsV5kfcW7eePsC6hKpNSjMMU1AemA6kwo8UlXNexDdzRcLXoSL8w7TNmPbT0ITYXIs8T/hQ/KWytMC5H27fSxWvmRmuvmK99wUn4UHruf3qUWCB1qgIWiIlJsp+pEVADqNsmGIF77liapbrqmN/v8AJ1sha+6OWR+o1tk+EWnq3AV25+YFLy1TNrc69jneJ+y1yXNeLtIGY5b6UpOAmuwPrPRtaKEmwyuLe1Ke1sKdjoFeIxDsi5TvK0NLdHlDS7g8L468mn219A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943899; c=relaxed/relaxed;
	bh=+BSSPIkVsfUiGZ/2/7JQoGktT3Bg/qW3vWeVl3H8t4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e64+KKtX/j2z1KMJmaj5fX+mNxWmv7KanFs6KzLcB8EukwJ4gyEODshY7ngtUmFABjnZa+ugODzcgDi8fWGBaJ5/0LRG8BirOrK/BntsEylmFBWUBoUWl2j7LTx7fkeyYAplVdVPogsdIb2FHpCUXYRo5OaWM0u1IBVS6CNI7zU4gichIHvKcoArjxqOLt38BuA9PO+VIf23gfffa27dEh14adm8I0XGduc6YWXXpag3SG4SuOVTld1wR9QkP+wZKQ5Izm+k9o7x1e3FVx/Q7hexB73JqvBLVoP41Fm09DL7o56NWJmw0J8esOEEPp/uccMMgf52g4kMLn7q8o51vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JaOyz+Gf; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=y5gKHnSv; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JaOyz+Gf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=y5gKHnSv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvgC7103z3046
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BSSPIkVsfUiGZ/2/7JQoGktT3Bg/qW3vWeVl3H8t4I=;
	b=JaOyz+GffrY14/vqZR3mc3aRHefVc9sKFST/Y+iv6y2dWE5XkrXmA9ZJsAgqJ018f/vug2
	cBMChuc7FaXyUAF9yQKOHxlkPemVJ32YoyN5tLBaH5C5wxOmAtxy0Ukobemx+5ORO7uFfy
	Wiu0MtImMa+hOKQRUZBdB84qZjgFlKRYR7h4fdWiycJ85XrjCvCyV1y6fITwXy11WldYgg
	+vgzkpMELO8vXyECyskLAnuY5vVpDRCTsaR+01bT+hpNKuUJVRHkC5wWfCgNEJWMjBkGqg
	t+9mVcjwwU/JEljjnrLJ3bJK/1yy+XyvUm48H3zRCFfkamQLKNoJ6UlylCYASQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BSSPIkVsfUiGZ/2/7JQoGktT3Bg/qW3vWeVl3H8t4I=;
	b=y5gKHnSvh3NyUEy73IKx6RfvsCL+Ha6mwmh698IzxBvPV1anfbtnSec1fGWt7Tg3vCMaSo
	l6Cb8RNPcUh7xvDA==
Date: Wed, 09 Sep 2026 10:51:25 +0200
Subject: [PATCH 12/15] riscv/hwprobe: Include vdso/datapage.h
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-12-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=814;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WJuW0vHAzgVK65zYpMsMpkIoWVAhRqBIQ43ugL+Vfgo=;
 b=3v9PIQWIfY59Utoqf3u0a+2xyzC3K3qFiLXNZMe7AgOtEielmjn6RIPlrTTQkKqzrYA4P+N4f
 jrwA4Hzlo03Cus2D1tSaBop8ClV4dFKjXJ96j2IsAFgQehGy3G3Rb0w
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The symbol vdso_k_arch_data is provided by vdso/datapage.h,
which is currently not included explicitly. An upcoming refactoring will
remove the currently used transitive inclusion.

Add an explicit inclusion.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/kernel/sys_hwprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bd6ca7d769da..0f42101ad935 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -18,6 +18,7 @@
 #include <asm/vendor_extensions/mips_hwprobe.h>
 #include <asm/vendor_extensions/sifive_hwprobe.h>
 #include <asm/vendor_extensions/thead_hwprobe.h>
+#include <vdso/datapage.h>
 #include <vdso/vsyscall.h>
 
 

-- 
2.55.0


