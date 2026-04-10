Return-Path: <linuxppc-dev+bounces-19602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE1F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:22:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWB5XDrz3dhk;
	Fri, 10 Apr 2026 22:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823670;
	cv=none; b=WOaKnS9rlnWu6HaivbTx65r9kpuk5izCkHRFfsXEAK1EcT+Je0nYLGz8besB5S5XN3ipt5GlOw46G4VnLj/sV6BVeucGDtaS2pgNMoPvR0dpjA0EoBX+NTwIY+Kbhd3ebmUBbAFj8DRHXCerg1Y8/UTqQv/m1vjZc0MqDFDrQcNaIVfxma9y5HpqIZTjMfGxNNtmpkPxxWMtHu99GjbQMupvSn4JTLIm7qlA1kF9wdxjlhe/+AYzvUD4nIal3Ppw4MBv60geqNIBvk9DR/a0a5l/c6xrfd8CzcBHT1Zej8cS+fQin+3C/h+FL4DCHXVPCo5D7iyrqBld0fHoWegLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823670; c=relaxed/relaxed;
	bh=ae8cfkGUIMIeVdEIq5b46ZHpiRc5HR7kNfrW28/CmkI=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bhSI0bnFZUL+ytLTtYknyAS9Q66ezBH6HNOCxA4UtQG+XzSDUkLQoBzGlP6uvOsRv7eorvrik5DiFvQvBZV/s3H5jp0eqtuCnVRaUMTJya+ZNFkWj7vMsP56QFfsmvTDZCb8ZU7TXEhh2MK7tA9sht7sCkTzDG/eJxVXC9Nte1kLJBfZMZzqlW4B6YTzy0rnqfoIpWAQXnoM0mo4sjQ+DC4GCnf7aB1qXyk8mk4plL81a1TrPSrjtJCEq9m/yaNFo4+fLncFDb+OG+WRw6cgBQeq0dKHKvto6FvxkVNCRE17ZfUbYsuqKkPb6pZzYgXuXJihUp7QVhk3GX/QYAxDag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uoiHjWjo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uoiHjWjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWB02dcz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E98D6091C;
	Fri, 10 Apr 2026 12:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FAAC19421;
	Fri, 10 Apr 2026 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823667;
	bh=ql5fkS0UEXw/nBMHEudu1ngsgqvxlZvUknLeTtAAGUU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uoiHjWjoWcWN7Tw6xiUbL/Io/RlHzIChPqiGJJ7RtYjsrncirPNTd0U6jsMefBLBl
	 PuEP8rIYZGWPrDUGiB7D/1OZBxXBypGlDQEoNlUgfhKncfE0Vht3vVd8dR09fIJYz6
	 LaRap+OM72T7ij93UcDxrSAuxRJvyqDUwai7p79fd01gYNQNCFb6LttF4gur8fMl1Z
	 TmanYlU2xNYAREOAaMNh8AIeZ2WEpNPx/37VkP03IexczKkHFgtDwEiwY8TvmgoUyG
	 zdqSX2TqLhRdpCyZVVz2iZYLDeqcR5cB1pNHnjTlrpzblDMQ8i7KXktiKriMpSMGuM
	 +dQ/qJxaC9obA==
Date: Fri, 10 Apr 2026 14:21:04 +0200
Message-ID: <20260410120319.723429844@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 32/38] powerpc/spufs: Use mftb() directly
References: <20260410120044.031381086@kernel.org>
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
Content-Type: text/plain; charset=UTF-8

There is no reason to indirect via get_cycles(), which is about to be
removed.

Use mftb() directly.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/cell/spufs/switch.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -34,6 +34,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/spu_csa.h>
 #include <asm/mmu_context.h>
+#include <asm/time.h>
 
 #include "spufs.h"
 
@@ -279,7 +280,7 @@ static inline void save_timebase(struct
 	 *    Read PPE Timebase High and Timebase low registers
 	 *    and save in CSA.  TBD.
 	 */
-	csa->suspend_time = get_cycles();
+	csa->suspend_time = mftb();
 }
 
 static inline void remove_other_spu_access(struct spu_state *csa,
@@ -1261,7 +1262,7 @@ static inline void setup_decr(struct spu
 	 *     in LSCSA.
 	 */
 	if (csa->priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING) {
-		cycles_t resume_time = get_cycles();
+		cycles_t resume_time = mftb();
 		cycles_t delta_time = resume_time - csa->suspend_time;
 
 		csa->lscsa->decr_status.slot[0] = SPU_DECR_STATUS_RUNNING;


