Return-Path: <linuxppc-dev+bounces-26892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56713C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvg85SpQz2yvQ;
	Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943892;
	cv=none; b=PjabhXLeCpqgGs/dWPlXLXNoXuYTtYXwDpVSbUMnWMWV30lPVfZK+EGVVfGVNKPNFqc0cXmcwxr2e1YGlNnWzEQ5/+AB3Gc+SET9KzgLuTjVcUtE84jDpgDq/uV7AVJoZh1BbWx3zYsBUPIE1s8StX25mOdAf9W5wb4123JTbMNRy8W0toJ4GyiPYOmn6rVLEKMFmvX2xuVVsmsJqvleDkMml2Hlwx9/tHGDcc+/z5pPDxWW9BgL5uBddCCp6U22Dzyw09FseU1L7ljw5HnIyNUHHoWJWVXWGjQSoQWnsxCxUdS9aWaV/OgcpcM/T2s7VqYYefFhNvJXTb/wQXQ4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943892; c=relaxed/relaxed;
	bh=XzQOMxzxshTh4wmqEu29Gu2VPX+xEoLqk1yFbDrb8uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1BGk27/+jwQCo3yuZz/BVyY3N1PMHZC/SLR1ppoOPCsDiJBsHvv6ywtVPjpD39icBGyfJGqxLKpLgrqFtDkDQmd3XAJSjtZWeQACrJXdSEpHWkJ9v8kW3uS34z+BKo9NzJ3lGGy47uWZJlI9AYq47Zypr7hVFzfKxutHGU46ERg2LS68w14jnYoUCVICFR1M2ycjXDMRbicKupVOOhND+JnVrWus3vZ/gul5I5GJ6ClFEtnz29tZduUcClisRPgjmiPmot2vdYrsnoyFvhGkMVjdYn+ZQcfJbbXayX6Q2Ks9X41vBqRdsa0N7kM/7MFMfkObETJzAa6sJjIpkmAow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X09Yejo/; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cYA/s1bW; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X09Yejo/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cYA/s1bW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg73npLz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:31 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzQOMxzxshTh4wmqEu29Gu2VPX+xEoLqk1yFbDrb8uM=;
	b=X09Yejo/JqqKtXCBERrNnRAYA35ImQKVCAF+aSCtG2F6PKrzCaElWrLHCAxGtzr7vC7OOu
	w0HUGAq/x4Pq3gNZtO6+iPsEvOwxvPbU1eDFXpf/ovbFERZB00bGkzZGvYmYJW9ldJ+TqS
	QLNVMEHKXIz5pnTCub3fdLep8HnNx+Lwy8VwNv++2kJBMAasTB9ZIDMciuBfKiHjHkPOx5
	tC3004wXfoTPdEjwfIlJE/qyREnrsnkGz8wj1Jtp35FtBZ281kpRX+N5IgSTM4LnIdUKJV
	xZiars5kzubb+8wkquYE/jKHmF25JTco2ilJeYOEa4VaT6+D19ljJZA18zrpnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzQOMxzxshTh4wmqEu29Gu2VPX+xEoLqk1yFbDrb8uM=;
	b=cYA/s1bWs/UKgyEP7Ti0e2vw1WhICfuqGpLaEZeMxwrx7+M/smOGJv8avR0BVCzMnxs/GQ
	tXZzBptfzYAlvhDA==
Date: Wed, 09 Sep 2026 10:51:15 +0200
Subject: [PATCH 02/15] vdso/gettimeofday: Define fallback
 __arch_get_vdso_u_time_data() in gettimeofday.c
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-2-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1583;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Ojd0VZyBuWlT1Vlm9OCcvjNe/c3y4B8B7OiZI04IfU=;
 b=VGAO2rm1dloGKPPn6fG5mfwo6sz2glPNKl5GoEyuD+WCr61o80au+loFA+6grZFSc94CCx300
 8Gh0V0u0lq7CxoWtxOpnah08gZTdMGr+JgfY05geFzjXERrVbBldpxr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_get_vdso_u_time_data() is only used in gettimeofday.c. vsyscall.h
has become a dumping ground for different kinds of fallbacks.

Move the fallback function definition into gettimeofday.c,
similar to other fallbacks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 7 -------
 lib/vdso/gettimeofday.c             | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index a6b03cfba0e2..fe12fb1fb442 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,13 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_get_vdso_u_time_data
-static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
-{
-	return &vdso_u_time_data;
-}
-#endif
-
 #ifndef __arch_get_vdso_u_rng_data
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index f7a591aba59f..b867c2301d5c 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -93,6 +93,13 @@ static inline bool vdso_cycles_ok(u64 cycles)
 }
 #endif
 
+#ifndef __arch_get_vdso_u_time_data
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
+{
+	return &vdso_u_time_data;
+}
+#endif
+
 static __always_inline bool vdso_clockid_valid(clockid_t clock)
 {
 	/* Check for negative values or invalid clocks */

-- 
2.55.0


