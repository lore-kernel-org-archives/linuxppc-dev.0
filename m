Return-Path: <linuxppc-dev+bounces-26894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A46C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgC6NCjz2yvB;
	Wed, 09 Sep 2026 18:51:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943895;
	cv=none; b=Yp1VW61croQIjPleJ5l53SoPcXc4V/dxrXMYfZvQPH95XcMdXloy9bN4LVtEa8y7BcCzSxn6E5j2qYhNBK2hky8V/LhGo+i8r5RUzjihn0MHMrA/r3W7qy4FN0eGeyJjK42c0wbyVWEW/XIwg8huE+7xyjjUwuBjRECuKDaOYRWNYl6CTh5F5elA+HtXLtKquutlFaVMal6Z3FjTOFF39RDGCJlyDYraMIxa4BuML5S9iya0pCv0NzcVhvBjHllfWwOzk3DH/vBgeo9cRtyn3QNAJasTByg5kjzFTo15ZFttvdXCRIRvJkjRYt/L2+NLIMzNS4/UDPES9Sof5NaNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943895; c=relaxed/relaxed;
	bh=ZBW+NNY2SjZx2bEP4psBPmVHnHPr59CeSsptOJzPpxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHoauxr46XtbGLJJZqtCMLuuT2Hc8R7J2nRvN+MUfOuFRHu7uCdJoGR2152wiMtaJqLi+gc28GdIwql9MkfZaC/Z6bnYQhOecAo8L2YzAuJwSQwOXp6ZBkljV5Q+l0/7L3psMDzov+NoYFT3cP5QWPyjpHmjkkr3Wz1jSevy7vuBUKqF7M2bFjXkoj7eKUJ5YIh5LWHlUSoNE6OovR5nubBqNF9aF7bVuBuasM76kmwdvb0BAh8yZ2hrXV4335iNq95kIovS5+Ps/lVI1KnYVe4CBE/pj1kpZ6Pp2fL67edFF2YoV2MxxVDt7ZTToB3zvmiSwtPMHWkPTRF5e+L4OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HRqxeHQr; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jHrgCIP/; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HRqxeHQr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jHrgCIP/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg84pGHz2yvL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBW+NNY2SjZx2bEP4psBPmVHnHPr59CeSsptOJzPpxM=;
	b=HRqxeHQrnXZFu+IW6nd8K+TY+LCZR9HvX+RpxOvhst2wYQkKsTY3WEghL3CDlSZ/UMJ9U+
	qClsqE3u5gtUnsC+c/J5mpb5IIBe4D5+R8+ZJApFLO4luQIonxDru0UGAZnWLOoDos0UY1
	vPT7y7D7QRsVuT9MzxZuIdVqpLUhNiLz72FSqYdSxj2RShBxyjgY5PXTSdirYSX0zl29Ep
	EGgrqvBqFnaiWkZo8bzs+n3/0umIANXltxdYplWWoqUmTpi5wgqV0Bfh9XTtj3hddbI1/r
	uYB7p+q3cj1Ew5ADSyyWHuTBSTecRPxvOHhuDBoHmxit+YMutvt6FfKiABLETA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBW+NNY2SjZx2bEP4psBPmVHnHPr59CeSsptOJzPpxM=;
	b=jHrgCIP/rO/bPwnh+S3RCGy4iJMaIq/Mlhlf+7l8900BurZmy7j2ykoB99Wxkh8OyfH0Dc
	9C9dta5dCibWzWDA==
Date: Wed, 09 Sep 2026 10:51:18 +0200
Subject: [PATCH 05/15] vdso: Delete asm-generic/vdso/vsyscall.h
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-5-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=6201;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qhKDToRtVgE1seQYerDld7q7s7MqJPXIzQ2BawbRJ8w=;
 b=OFttGqDPceoM6rX7XNSrPCjOJ1o8w2sSyCuFYpcv3XLXp44msE1jDwBI83tyjyEjgR8ippMic
 gm8o53XdU8YBqTvJMqR0P/K8MUsjnsBFmjsyYIwE5HEwFngYTWSn65B
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Recent refactoring have made the header empty.

Remove it and its mentions.

Also that header was never a real asm-generic header anyways.
It had no reason to be in the asm-generic directory.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS                                |  1 -
 arch/arm/include/asm/vdso/vsyscall.h       |  3 ---
 arch/arm64/include/asm/vdso/vsyscall.h     |  3 ---
 arch/loongarch/include/asm/vdso/vsyscall.h |  3 ---
 arch/mips/include/asm/vdso/vsyscall.h      |  3 ---
 arch/powerpc/include/asm/vdso/vsyscall.h   |  3 ---
 arch/riscv/include/asm/vdso/vsyscall.h     |  3 ---
 arch/s390/include/asm/vdso/vsyscall.h      |  3 ---
 arch/sparc/include/asm/vdso/vsyscall.h     |  2 --
 arch/x86/include/asm/vdso/vsyscall.h       |  3 ---
 include/asm-generic/vdso/vsyscall.h        | 10 ----------
 11 files changed, 37 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562ace172594..21c590dd28b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11064,7 +11064,6 @@ M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
-F:	include/asm-generic/vdso/vsyscall.h
 F:	include/linux/vdso_datastore.h
 F:	include/linux/vdso_time.h
 F:	include/vdso/
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index ff1c729af05f..14f2ea9d8640 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -14,9 +14,6 @@ void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 }
 #define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 3f3c8eb74e2e..7d9d6bdd58b2 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -19,9 +19,6 @@ void __arch_update_vdso_clock(struct vdso_clock *vc)
 }
 #define __arch_update_vdso_clock __arch_update_vdso_clock
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
index 558eb9dfda52..db653780519d 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -6,9 +6,6 @@
 
 #include <vdso/datapage.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
index 0f061a9babd1..f01ab2e15c08 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -8,9 +8,6 @@
 
 #include <vdso/datapage.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index bee18e8660a0..6a6510fa8217 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -6,9 +6,6 @@
 
 #include <asm/vdso_datapage.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_VSYSCALL_H */
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/vdso/vsyscall.h
index 558eb9dfda52..db653780519d 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -6,9 +6,6 @@
 
 #include <vdso/datapage.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
index b00acec8ddbc..c74c307c320c 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -8,9 +8,6 @@
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/vdso/vsyscall.h
index 8bfe703fedc5..b08e0bd5e309 100644
--- a/arch/sparc/include/asm/vdso/vsyscall.h
+++ b/arch/sparc/include/asm/vdso/vsyscall.h
@@ -5,6 +5,4 @@
 
 #define __VDSO_PAGES 4
 
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 4aa311a923f2..57598db8763b 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -14,9 +14,6 @@
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
 
-/* The asm-generic header needs to be included after the definitions above */
-#include <asm-generic/vdso/vsyscall.h>
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
deleted file mode 100644
index cfb740e82cb5..000000000000
--- a/include/asm-generic/vdso/vsyscall.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_VSYSCALL_H
-#define __ASM_GENERIC_VSYSCALL_H
-
-#ifndef __ASSEMBLER__
-
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* __ASM_GENERIC_VSYSCALL_H */

-- 
2.55.0


