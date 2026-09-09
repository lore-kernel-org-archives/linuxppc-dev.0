Return-Path: <linuxppc-dev+bounces-26903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A57BC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:53:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgK3xF0z3bpN;
	Wed, 09 Sep 2026 18:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943901;
	cv=none; b=MbOcVGCTJS9loWCGlySKp6N14PEl4lU0AQPhbj1b1s3RV0yOMhJ2F4qrQxLSN80OxF/63/KyLNdgGzUFr50k+FIiVs09bAQ493urCfFArVr884mf2KpXrzPBf6iAE6i1Rk1lGFkraarKspa6NgXgwJp4+xEIH5XygM1zGJF08Lp/26FMqAhho04yJ8MOHi4TLJaZVxNEX6VvkPo6lMyz3vJoE8Pf1rnBZI/jyrd7zTa+3MwI/1vhkfVCKvH7/gnaWWdIiF+S24LIgkrHg490c+JcqvPmK3khcmvLoBTVJLHuQrJ0Wer4UsiTsYbKM6dxlMsm9PwA7tAZDGP992l6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943901; c=relaxed/relaxed;
	bh=JMVMS5fB9cOPA4POT3k9FrIUmWVPCjnIMj07aQx41TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4NwnbIPz8ckXpr860INBKG+1vEAeKLpUQCGXYKIns6NHreyeXot+o6PPGEeD7sLsmWXG7MEVr9ARs4DfmhOiLlNwAz5HG8airaElj4/IHBnBNwdOB78+3chTy+Slr1AB6wmGklis4G9wEZYxzKDU2MD+jlJgvZTOdWRu8WmiPnu/rEEs+KttArI2Dv0bm1Ybq+ZshhjIHzBw8PvxF+2B+7f8H8PRy2y2Op2ib9a41ZZr/nkIHi14SO49v/AiGg+jrvxz6pxk2md/LsmaRMou8arjih1kMXQhx9y6OE0Ma4UGe38mpBeQ4pe1c63dIFaI1RwZ3y/8ULfFrUlIjUEuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PBnltHou; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=OsR9+ePJ; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PBnltHou;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=OsR9+ePJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvgF3F9Hz30Hf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:37 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMVMS5fB9cOPA4POT3k9FrIUmWVPCjnIMj07aQx41TA=;
	b=PBnltHouqiLd0vZKnEktzgXmmVWj9E/rgINg+MiWTjeKITcztp+Zs/R13kZurmAKB598p4
	kddIj8zs+mThxi0y1LOe5Ah2DoBWqyt7r6P+8YyxJlafdIhLoo6yaKWvWFbuwAnV8UJa9+
	2t63vt1DbGY4E1IaJujjBIhN1MeJAXY+mMvFRhspG6cpN1YGpcKx5eb8u+adsTk7vQ5JjG
	JFW2Uy4Vy3WyoTXTFZRKk1+zsRveZDTBJT4cK1mWfo7GCoDzh2Y0SX7/53JxGrJvO5p2Tq
	3VdybOHbhTLd1PX2P6BepZhrOPUVFmlZshdcWktTvhB6XBpzkyhmyJ1t6NAwGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMVMS5fB9cOPA4POT3k9FrIUmWVPCjnIMj07aQx41TA=;
	b=OsR9+ePJ4YG9lbDvs0TVFng2Lc1FxhDap7d8efI2GntHBjwnUbhw+GFc+EwXBu2WJtvwC4
	bCPFZo80XHJHmfAA==
Date: Wed, 09 Sep 2026 10:51:27 +0200
Subject: [PATCH 14/15] vdso: Add asm-generic/vdso/vsyscall.h
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-14-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=4765;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=RN6cYJUEQdRxuBEqqYhIPB2SE0TZGxcBuEAXLBMYDtE=;
 b=d6YgCC9mOtzM/HCu/dlX+VOf6yWQ71CH6LOM9NRJDlKLcjm2on0tmi0kD6UBUtMzkFELguk6T
 12bpP+ouE5+ALngtyStONC+dPoOfbs2V+mh5GeDN2fzMK207HnGAZQL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most architectures' asm/vdso/vsyscall.h do not define any symbols.

Add an empty asm-generic variant and replace the pointless
architecture-specific copies.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/include/asm/vdso/vsyscall.h | 11 -----------
 arch/mips/include/asm/vdso/vsyscall.h      | 13 -------------
 arch/powerpc/include/asm/vdso/vsyscall.h   | 11 -----------
 arch/riscv/include/asm/vdso/vsyscall.h     | 11 -----------
 arch/s390/include/asm/vdso/vsyscall.h      | 13 -------------
 arch/sparc/include/asm/vdso/vsyscall.h     |  6 ------
 arch/x86/include/asm/vdso/vsyscall.h       | 12 ------------
 include/asm-generic/Kbuild                 |  1 +
 include/asm-generic/vdso/vsyscall.h        |  0
 9 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
deleted file mode 100644
index db653780519d..000000000000
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_VDSO_VSYSCALL_H
-#define __ASM_VDSO_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-#include <vdso/datapage.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
deleted file mode 100644
index f01ab2e15c08..000000000000
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_VDSO_VSYSCALL_H
-#define __ASM_VDSO_VSYSCALL_H
-
-#include <asm/page.h>
-
-#ifndef __ASSEMBLER__
-
-#include <vdso/datapage.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
deleted file mode 100644
index 6a6510fa8217..000000000000
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_VDSO_VSYSCALL_H
-#define _ASM_POWERPC_VDSO_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-#include <asm/vdso_datapage.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* _ASM_POWERPC_VDSO_VSYSCALL_H */
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/vdso/vsyscall.h
deleted file mode 100644
index db653780519d..000000000000
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_VDSO_VSYSCALL_H
-#define __ASM_VDSO_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-#include <vdso/datapage.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
deleted file mode 100644
index c74c307c320c..000000000000
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_VDSO_VSYSCALL_H
-#define __ASM_VDSO_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-#include <linux/hrtimer.h>
-#include <vdso/datapage.h>
-#include <asm/vdso.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/vdso/vsyscall.h
deleted file mode 100644
index ff62b291e4eb..000000000000
--- a/arch/sparc/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_SPARC_VDSO_VSYSCALL_H
-#define _ASM_SPARC_VDSO_VSYSCALL_H
-
-#endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
deleted file mode 100644
index 65d10f4cc718..000000000000
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_VDSO_VSYSCALL_H
-#define __ASM_VDSO_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-#include <vdso/datapage.h>
-#include <asm/vgtod.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 2bc00c67dc54..b7a388bef6ea 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -63,6 +63,7 @@ mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
 mandatory-y += vdso/clocksource.h
+mandatory-y += vdso/vsyscall.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
new file mode 100644
index 000000000000..e69de29bb2d1

-- 
2.55.0


