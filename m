Return-Path: <linuxppc-dev+bounces-26891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C582C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvg858x3z2yvP;
	Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943892;
	cv=none; b=L+ssPrtPRtfxvMcEnzPKYKcoZdonOFOMeOAaizZHi6Hqdhe3WS4eOo4ohaI6nIrQAiK5fAsRTkmBvLHKvpi2HhvzyGQggMmBJOmXN50/HRb1OnU7DVnadBvGW2w4PkPwqRMCNNP6Hposwpd/Us1ohH/fYzk1RSHPkSnPZzP/l1yQ+2lxi75IryQy8TerrrwYL39n/uraS8rp5s37uDXcR6uueQGeNOifu5bZMEo722lG96Bfiky2AR+ThPfXGC74XXUNjauEFi8WPvpnjVZwCjCr/H9aZ4TQCmYO1xgY5iVtKPXm3G57oGvGfLOUp/IaHYGQ8qr4YdOKA11iEcJUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943892; c=relaxed/relaxed;
	bh=xA+RTkJw0c+YR5D/QOgVdwP7zOXPBjoexPBxZtSIN04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKOTzRqXj1XPhuDeSWpfIi8rsixSjicqHJVyibvwAngQtxFgb3dg6beaArBhY2Ye1j4S9z3j8azH3n2+Kmd3urb+qEgZpcT3JKxYyAnx5IuK31dN0ObRkCC/MDDPYNeyvESRpK+TySE5+Wi6LTRHy26eVHJYsAKTf8yT+gi1fQYvAlb8uRA2+Bk7BKnTbrGim8CXkl3AOLBs5GPRU691mf+n8/GxM6lf57sadNbtefkDfSWh00rwFm3gknUAd71t6dJEC+dBhuKPTGS00hhB0TLRZOhDar78i+BjYv1W/Rnoq4szu10YA3bGhLEviukMcSlzQkhqwD6qj38ocSiyPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0kGifJU3; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/tT31v/M; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0kGifJU3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/tT31v/M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg72gP0z2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:31 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA+RTkJw0c+YR5D/QOgVdwP7zOXPBjoexPBxZtSIN04=;
	b=0kGifJU3jsfalQ0vMhT6JP3VlLln+gnd6PviOfid9vcMQ9ZfVjh3S6K46Y6RtuwYgfkQp7
	U4VEARgjQz2y9zWVKUibcuXAcE4/PVf+skeugVCZcIXp33PQ8GX5qYE7ku4QLgIfpJBaji
	sLjL1tWFCu3bZuuADFD0AYDYIBKL+YSk5Sd24lEO1Nytg0HcECLj3N5LEdCgUAxJDjDadI
	shB1V9Vpyv5V5KUelf38XITDATgyYew3seTijVNyKcdWbgfUgXsa+82TRsDxxr0nyLUmvP
	r6AikYXfmAecxzddK5q6ximEIZie8JHXo3dmv5t+53uTJxmbJPD0s9zaa2sZWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA+RTkJw0c+YR5D/QOgVdwP7zOXPBjoexPBxZtSIN04=;
	b=/tT31v/MG34PF8rBM384dyABDZOrzGB9ykwPSqEtaNtwaktWD7oMFoQcgvhlIia89klS87
	FLxDjTW4EyLOtgDQ==
Date: Wed, 09 Sep 2026 10:51:14 +0200
Subject: [PATCH 01/15] vdso: Move the kernel-side time update helpers to a
 new header
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-1-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=4673;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ndsrVtodOF2PT/OV0JmJocFYtm0oQ/AhLbzcTA5NPJU=;
 b=QFJMpel8Oem89wFMEyNNwMRhARMWVEaTGpbIuOv/+f6g6Odsm+x6tVkjIXNr1SYGYi7XBz3Ut
 icWBswwhaH5CKn3oECTYcx8kCso8VGVsVWamVOR7it7ieJAfv7qrCB4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdso/ header namespace is meant for symbols which are usable from
vDSO userspace code. However vdso_update_begin() and vdso_update_end()
are only usable from the kernel.

Move them into a new header in the linux/ namespace. Also rename them to
make clear that they are only for time-related data.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS               |  1 +
 arch/s390/kernel/time.c   |  5 +++--
 include/linux/vdso_time.h |  8 ++++++++
 include/vdso/vsyscall.h   |  3 ---
 kernel/time/vsyscall.c    | 13 +++++++------
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..562ace172594 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11066,6 +11066,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
 F:	include/asm-generic/vdso/vsyscall.h
 F:	include/linux/vdso_datastore.h
+F:	include/linux/vdso_time.h
 F:	include/vdso/
 F:	kernel/time/namespace_vdso.c
 F:	kernel/time/vsyscall.c
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 2b989bebd220..161628f6906f 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -39,6 +39,7 @@
 #include <linux/gfp.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <linux/vdso_time.h>
 #include <vdso/vsyscall.h>
 #include <vdso/clocksource.h>
 #include <vdso/helpers.h>
@@ -527,7 +528,7 @@ static int stp_sync_clock(void *data)
 			cpu_relax();
 		rc = 0;
 		if (stp_info.todoff || stp_info.tmd != 2) {
-			flags = vdso_update_begin();
+			flags = vdso_time_update_begin();
 			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
 					&clock_delta);
 			if (rc == 0) {
@@ -537,7 +538,7 @@ static int stp_sync_clock(void *data)
 				if (rc == 0 && stp_info.tmd != 2)
 					rc = -EAGAIN;
 			}
-			vdso_update_end(flags);
+			vdso_time_update_end(flags);
 		}
 		sync->in_sync = rc ? -EAGAIN : 1;
 		xchg(&first, 0);
diff --git a/include/linux/vdso_time.h b/include/linux/vdso_time.h
new file mode 100644
index 000000000000..6d81ee3a3c9c
--- /dev/null
+++ b/include/linux/vdso_time.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VDSO_TIME_H
+#define _LINUX_VDSO_TIME_H
+
+unsigned long vdso_time_update_begin(void);
+void vdso_time_update_end(unsigned long flags);
+
+#endif /* _LINUX_VDSO_TIME_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index c5c2a2c07857..29dd4e097220 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -6,9 +6,6 @@
 
 #include <asm/vdso/vsyscall.h>
 
-unsigned long vdso_update_begin(void);
-void vdso_update_end(unsigned long flags);
-
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_VSYSCALL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index aa59919b8f2c..12e205d86e7f 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -9,6 +9,7 @@
 
 #include <linux/hrtimer.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/vdso_time.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
@@ -177,7 +178,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
 #endif
 
 /**
- * vdso_update_begin - Start of a VDSO update section
+ * vdso_time_update_begin - Start of a VDSO update section
  *
  * Allows architecture code to safely update the architecture specific VDSO
  * data. Disables interrupts, acquires timekeeper lock to serialize against
@@ -188,7 +189,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
  * Returns: Saved interrupt flags which need to be handed in to
  * vdso_update_end().
  */
-unsigned long vdso_update_begin(void)
+unsigned long vdso_time_update_begin(void)
 {
 	struct vdso_time_data *vdata = vdso_k_time_data;
 	unsigned long flags = timekeeper_lock_irqsave();
@@ -198,14 +199,14 @@ unsigned long vdso_update_begin(void)
 }
 
 /**
- * vdso_update_end - End of a VDSO update section
- * @flags:	Interrupt flags as returned from vdso_update_begin()
+ * vdso_time_update_end - End of a VDSO update section
+ * @flags:	Interrupt flags as returned from vdso_time_update_begin()
  *
- * Pairs with vdso_update_begin(). Marks vdso data consistent, invokes data
+ * Pairs with vdso_time_update_begin(). Marks vdso data consistent, invokes data
  * synchronization if the architecture requires it, drops timekeeper lock
  * and restores interrupt flags.
  */
-void vdso_update_end(unsigned long flags)
+void vdso_time_update_end(unsigned long flags)
 {
 	struct vdso_time_data *vdata = vdso_k_time_data;
 

-- 
2.55.0


