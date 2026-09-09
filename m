Return-Path: <linuxppc-dev+bounces-26888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C03C79FB8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:51:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvg52wFpz2yqL;
	Wed, 09 Sep 2026 18:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943889;
	cv=none; b=JDI+dbxBNFkDNrsmysblWUNv6vxRVYrwyB/6nGp/WNwcHRIu9ZOnPf0v8INShw8uIeuCWiGzrqrlsGJnc4X+P+PrhLB+jZtP3UojusluE/7sl3TFF0j238P5viQIUQZ+wH3Jgvv6gpdcY8vqepV8M8Q9LtQnbUXL0TEZIRICZYfziRJ+rQ/7X17wSHvA+6L7+b7hY4BqI/pI76R3lC0YNRO2otzsiNALEcZUV2vPX/QK+Hdn63JJOBVSY2GxPx0xkbuhhZK43RK4EfvJSFsuAsynS+XsoWeFvHwGeIkOBiv/cUnqmfVT1fAwIpqycrnSUyICL3EBmSLnWAc8iUPGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943889; c=relaxed/relaxed;
	bh=p8ISCnsd1kBgxpKDcNux5gAnw7Y6k/Yo3uUbNdp9+qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLnKSYAXk666SGgx09rSDMRpCx+25gpJRM/z835ftuszVwfpTAztWWcPCxoZLmtQbUpNhRKlMAn2o3kZfJwg+GN7/Hboce8EQabbrniaIaoHkwlcV4+HlDaaGSj/BfNvSjEdj1AU7IxWewprB3s6u4Bxqw82xqmD0/e+xU+YCUsDG9TogKxHruvKSzYdW7ld5kFDN/amjb+jFuHpTrWW+XPF5Ll23JFYKUuDjLYZ0wBa+QAukEHUf12rmh7GjswtgsKk+fmUrApK6Xj/uQGbJT82IChe+pbU4ZXFMg84rzBjSM7h4cddX34RhrrKKXaJoFfhGTdxQj+XAifREBzdmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=O5zzVmOy; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9huAc0xk; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=O5zzVmOy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9huAc0xk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg36Ftfz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:27 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8ISCnsd1kBgxpKDcNux5gAnw7Y6k/Yo3uUbNdp9+qI=;
	b=O5zzVmOyrKpaHp2u4bUY98lgwCvVarLkNgeAPPVX89i5JBg3rHp4+Y8F9L4P7sCCu7APVT
	Al93fxOcU0nkxzrDGMp9ojUNo/XMGidIJmj5ushFZTsVzhhH2/4847wUgewnz4odH33RCG
	rYEV6IXxTfCoYWNjLI1njWpXKiTQzh4hlJ2nAfWSRVlSvIRdZ8jZlx0oLL8v+H9qcVdvTu
	VCEGXnt6KMhztEQTNXeBUDeApxeuzzOKfXXfabG23aFg593biDM8h5sQ9dSVqWDjHQtLqp
	9TYPesEC1SSI+QAvRjLvNdyJHhqsK2SHpCmurN0Bhvkm5WRkaGF5W+rYh+i8Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8ISCnsd1kBgxpKDcNux5gAnw7Y6k/Yo3uUbNdp9+qI=;
	b=9huAc0xk9QcC4SgqamXcnykpmbUho6tKXuFLvtEqd+RfqJ7UdPuClzkoIyvHwlR5apQHEl
	EoLJQecYy/nKN7DQ==
Date: Wed, 09 Sep 2026 10:51:17 +0200
Subject: [PATCH 04/15] vdso/vsyscall: Define fallback time synchronization
 functions in vsyscall.c
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-4-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1827;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sUPCnKCUGSNrK6kUHNVPQIEZiXKtWEAStKPxMYG7MFQ=;
 b=lrpRL87RH6Jns+QOQuU8vG+UhFyds9BwYL/rt0fjZCb0s1Oj7j4AIKDMavYVvjgkUDUjPhvEc
 T9kztup5hZYCOHnR9RnzqXUPyVZQLUeJCQxyJrgUgGCsXxKa0apJ8Bi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_update_vdso_clock() and __arch_sync_vdso_time_data() are only
used in vsyscall.c. vsyscall.h has become a dumping ground for different
kinds of fallbacks.

Move the fallback function definitions into vsyscall.c.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 11 -----------
 kernel/time/vsyscall.c              | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index cdf7b39cd349..cfb740e82cb5 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,17 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_update_vdso_clock
-static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
-{
-}
-#endif /* __arch_update_vdso_clock */
-
-#ifndef __arch_sync_vdso_time_data
-static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
-{
-}
-#endif /* __arch_sync_vdso_time_data */
 
 #endif /* !__ASSEMBLER__ */
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 12e205d86e7f..193a02d78b11 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -16,6 +16,18 @@
 
 #include "timekeeping_internal.h"
 
+#ifndef __arch_update_vdso_clock
+static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
+{
+}
+#endif /* __arch_update_vdso_clock */
+
+#ifndef __arch_sync_vdso_time_data
+static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
+{
+}
+#endif /* __arch_sync_vdso_time_data */
+
 static inline void fill_clock_configuration(struct vdso_clock *vc, const struct tk_read_base *base)
 {
 	vc->cycle_last	= base->cycle_last;

-- 
2.55.0


