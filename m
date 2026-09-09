Return-Path: <linuxppc-dev+bounces-26901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CAC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:53:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgJ6qsYz3blN;
	Wed, 09 Sep 2026 18:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943900;
	cv=none; b=LwefnnWXrltzOyupB8S1+dDn5u2T/RYbNa7qGQ1FMPMLLZdaVHYgOzzGH8iM9FBxwCqdsrIdlKhoV46MOf9/NSkjc0IvsfFihZON92Xr89IidRGHQxyR4gtgPSXQ1FiqU8Hedep80hTzLyNbtEFoKaNJH5TMKqQ7j7hBSOY1+ry4XNoe9i4P0ywiCEXv/85hA4+nkgZTnpCrDPNVmaz3BksLngdA2mj2uWOoy6s02Jq3Lybpwfc6juWTjcnx5ag416b18S5DrCn0pxFArjuKj/ytjByZrkr69OEg5SZ9rJ8Fs/ekJrxUcDOfr3GR7Z2q4SuwGqV6rO4a52W5qh+pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943900; c=relaxed/relaxed;
	bh=C8jERIZlzOiJ0igHK630ldoZDDzGvj3UyoNSXBhnm0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHmiZAj+9bQdJo/1FKQuySmCr0gFN4VmKSljGFlZ37k7Ld9SP/yib3HVTDsj9VOsTDeO5lJw0ZmYvDm9Fy7JOCuQmM6Kt5dDcvoc5MGJcWIayB3ntMktWD9HPGu7Pr4xxlpOf3kw4xCat4ptPfmJNQfpOaE27XJNHboinPkVHz+WPSeTfi13bk5//d83IckQaCob80LoQm9htMhfzEZn6l3U9VTcLo4uRLIFo+qAPrduUVLBpmHIPMvyhhUd/hM1Xg3H8fyH4GWcXSfPywmTrplC6ti6K87KDrb6zRuY7LNll7V5BNeti9vKFcT5GOd5JbDo/xbD3Ra9Wda8FCuRng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YV80N30g; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WnZhgM4C; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YV80N30g;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WnZhgM4C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvgD2JSgz3054
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:36 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8jERIZlzOiJ0igHK630ldoZDDzGvj3UyoNSXBhnm0Q=;
	b=YV80N30gtg3Qo0+Nn5ZL14Uc4rxWQ913cXwBr24SAORpArv0rT4pLXYRBZmiU1XhVedhtm
	3gyANW09zc0AnJxdyhKpTxL570GrkaDpIprXpjRMCB0Q+lNtZiaZm58ZlxVzDicKRvrGpi
	w4/0MiHGowiYFT4LIjDgcSG2s9Rx8D2xwYHKUyVfl6NjAepsAWVAkrsjsiJ42saGd6Xbh9
	yfPekIScgoESbt7to4o0Y8ZggYTV62CbRHIJ2AJl/mS+ulCdUu7WTvsp4tsyim+fNDyfJy
	xlknZiyieERW87XvXKMAzRCm5R0mZ3L/DYRFqdklDPcVzg0WpkAa41ZQaCp3MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8jERIZlzOiJ0igHK630ldoZDDzGvj3UyoNSXBhnm0Q=;
	b=WnZhgM4C9TDIR2uFp2TfzuCBG6oPaXdRjbuiKfGJaM4UpnOVhuqvMp9qkQ5jtb3aWa2zG+
	xJdxOHztclSdoICA==
Date: Wed, 09 Sep 2026 10:51:26 +0200
Subject: [PATCH 13/15] vdso: Remove unnecessary vdso/vsyscall.h includes
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-13-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=3977;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gna+NxAbuHUiPh7UeY3iJvOkIMhHRrEMbf8sWoWLNzc=;
 b=ytf6AJeQ2RRzfTAaVL5jTvw60PTKQTaUNnPB+n+rtyAnSCDKsJxnzPm4sW6CzyPlgy4A/4sb6
 frGknUkvvrgA53jsfF8DIulc1yisK5Evm8qLbONPtD1QywylGQrPYC4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

None of these files uses anything from the header.

Remove the inclusion.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/kernel/vdso.c          | 1 -
 arch/arm64/kernel/vdso.c        | 1 -
 arch/loongarch/kernel/vdso.c    | 1 -
 arch/mips/kernel/vdso.c         | 1 -
 arch/riscv/kernel/sys_hwprobe.c | 1 -
 arch/riscv/kernel/vdso.c        | 1 -
 arch/s390/kernel/time.c         | 1 -
 lib/vdso/getrandom.c            | 3 ---
 lib/vdso/gettimeofday.c         | 3 ---
 9 files changed, 13 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index e306d0c5a21c..7be871f5eb9e 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -23,7 +23,6 @@
 #include <asm/vdso.h>
 #include <clocksource/arm_arch_timer.h>
 #include <vdso/helpers.h>
-#include <vdso/vsyscall.h>
 
 #define MAX_SYMNAME	64
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 592dd8668de4..50596dab23f9 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -22,7 +22,6 @@
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
-#include <vdso/vsyscall.h>
 
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 8ce8159c10b9..1edc8fb720de 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -20,7 +20,6 @@
 #include <asm/vdso.h>
 #include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
-#include <vdso/vsyscall.h>
 #include <vdso/datapage.h>
 #include <generated/vdso-offsets.h>
 
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 8165dd3fc1f8..8eb1760a8a9b 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -23,7 +23,6 @@
 #include <asm/vdso.h>
 #include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
-#include <vdso/vsyscall.h>
 
 static_assert(VDSO_NR_PAGES == __VDSO_PAGES);
 
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0f42101ad935..e1ad8671137d 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -19,7 +19,6 @@
 #include <asm/vendor_extensions/sifive_hwprobe.h>
 #include <asm/vendor_extensions/thead_hwprobe.h>
 #include <vdso/datapage.h>
-#include <vdso/vsyscall.h>
 
 
 #define EXT_KEY(isa_arg, ext, pv, missing)					\
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 9c2f5e442338..5666cec180ac 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -15,7 +15,6 @@
 #include <asm/vdso.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
-#include <vdso/vsyscall.h>
 
 #define VVAR_SIZE  (VDSO_NR_PAGES << PAGE_SHIFT)
 
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 161628f6906f..bca65bf1c8cb 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -40,7 +40,6 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/vdso_time.h>
-#include <vdso/vsyscall.h>
 #include <vdso/clocksource.h>
 #include <vdso/helpers.h>
 #include <asm/facility.h>
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 6ff46549281c..e0fa10bbefc9 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -16,9 +16,6 @@
 #include <uapi/linux/mman.h>
 #include <uapi/linux/random.h>
 
-/* Bring in default accessors */
-#include <vdso/vsyscall.h>
-
 #ifndef __arch_get_vdso_u_rng_data
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b867c2301d5c..728fed1ae52f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -27,9 +27,6 @@
 
 #include <linux/build_bug.h>
 
-/* Bring in default accessors */
-#include <vdso/vsyscall.h>
-
 #ifndef vdso_calc_ns
 
 #ifdef VDSO_DELTA_NOMASK

-- 
2.55.0


