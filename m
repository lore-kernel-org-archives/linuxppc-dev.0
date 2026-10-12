Return-Path: <linuxppc-dev+bounces-29305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB6CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:49:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RM76q16z3bxM;
	Tue, 13 Oct 2026 05:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830931;
	cv=none; b=Tk9jK61Y5sZAOHd2HOpZZapKZnPh1EfGQJbRzPZEautxvrlYTXs3ufaBj02Umw6RhbwYaA2el72G5JszrkrSZZqfbpAun2fCPzmVxIfeVilBQv7VuGA9Ypk4XEGXnpYcri2piZubrMtVMP1NByUuzHB8QlZm1xy9Sbpw1LKpTX77aRCH2q6JlbIzn7NvSC2l2h9sne7y4wXo/YsWuB0ET8ADCB1SHDO8rCCdpumb4Y1X9Micz+TTKsuQDN3rb6Dh/2xqq/78Q8Wa3iAOdp8haxAKOsXB0vHBOmgA2GOCtN7XWrweo7d2ZLGFcv+7Hpsj1ahj9mZYX+GhG4TSIKwmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830931; c=relaxed/relaxed;
	bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esGhNtEDOwnCzkB+18GDI/RxplEPf9rl0AHJl8sXYo1IAKnqTa/J8etQCWOoNItLxUDBo2/WHiii5mVzea+hBoq+82Lb1PWdnWfaPAfkgoqNL4fBcF0DjxTTfwi+QzZ8jKEBI0zRaDxinjDvQuuMIcBVNPCl0ytG9T4K/o+lSj1Hq0qyGH13Orp0TAKo6xVZr9nYxPRTgBZiobgVcTWMFW3ktT6TW55B1LMs4AhOX+1zDFZ5Js04ZJj6fjcyj03JiTvuCj8ol643So5t4+wgQx1e19vEjjEZFsdtGGs1GXbAd0VHhmVtqFDO7nUs48L3tnssPiy3lM74Rpyim1GiXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ez/r9bVP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ez/r9bVP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RM66MKLz3btn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:50 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso365416266b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830928; x=1792435728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=ez/r9bVPHJXwFB4sE0dX/NBJ3+VqVAq9rJEFZyZo/HU0d+IMqVP4DdqU6eoxCI1OMD
         TR8R2yjxbR//vIdHOEXdxxGJ0SLMuraOB9afRZoDX4kU06+cWbesFv/tOdcMI2efc1ja
         3siPKTviFxBvEqpbgebeLGuRqd00bc36x2fTGeWLhLXMGidSj3yJaubOkG7r2rfIEy09
         mUQ560+ImBtO6x8o4PxktpLYohVyQRPOiRbsLEURjOXeurzsAWyU6MYukj0L+aKDW0ke
         NlowoTV6jW9HzEunmDrVP+SNb+HNCPpCwkx99yxj8WE/9lqsUzfgljrVgmghcNh48Kng
         eGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830928; x=1792435728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=zT/xbVAGr3AotUNuGCHSnIM7o/8IP+3f0nGfGmOOMHhv8Y/1Ir3aPx5N5W5/HbU4c6
         lpkxqhXWs7MFJj+RLgF8aBxbLnI6b4NtgW+FfzX/APv2NXQPZP6axOSCvmKjL9JToBoq
         Krv05VPjn0J/rxfQFlN2WF1m66AAERNtJ0ibbHoy5/YT6pubqAgOTR37D56CnKbTqCrU
         voHh5e4N6mOZLUxwTGULVhJdGxduy+BApBmGIMHzvL7C6ieZ4dng+1qBDrp8ho/hNY8h
         r8NwXc98AlBNMsLOiHyTyln1h0aLtXM4/50XEvUV61UmZ1avA2i+pHpYzWppGlGfevyc
         ipFw==
X-Forwarded-Encrypted: i=1; AKwUvBx3Cs1adGT98oweoL8Ybv4+fcZnMq4X2k/CJ53vdtzgL9zP23ecqyUUhQZYj75ThhViXu37b7icBzy6Zo8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJJbVmS27yB5xn/vF6AwcfRRId5BD9Vd+LD/o1RbzuxnoAY4Cg8
	k3z5DIUJQGRpSzW3VpCzyQYRNZWszYhxE/DigJlekI6S4eGVfFJ0JH6J
X-Gm-Gg: AYBFou0/nSf68HEOG6E1y0wuLs0EY7cikK32uZWFF81/80t//qHX6aycl9xxIdslCWt
	9+yYmfMPUK1iTO1X+JYi9KFckoD3fVxbgXdR+ezKE4AQ9+dcFoFqNWI0jq1pMLhw5nbR/A+XQ2W
	yJz1frBf1+wRJAiAMgnBAWx6rRyWu+FQqIKOP6Eyz3DsMdItLbbCzpJ2FLOPXXbeqbAFOcgPI1S
	iNxQf9FsKODj2SyC8Ar47OFw/rg3D03e+SVxtfVvlnxURgfIghdhnn5FfOY8sblRHOyHHQHWaSz
	RMvOYKMHH6taPpAGtJrw9a4pG9kubXPOaNW3pfm146xgIL5AHf3jKPg+pTta7A8EXXxR7yxm5/N
	qHNGuUsNC79DOLsOaquCtQND9odXS5fvdd0H9IDbLHKremRB/phjhJGIgFzSxq9Bte3bf63hKoS
	plly6t67DY23GpihJynLg6O2slaqdQSgdfBhrmblJLaVjrLzs2D31+Bnauq48SeAs0rJZyObvVJ
	BKEbje1Ykt+KZ7Ef8YiUh2LZtK7ed44xv5l3wNe
X-Received: by 2002:a17:907:3e1d:b0:c31:70a5:4c3b with SMTP id a640c23a62f3a-c31a9a2fcccmr1093246466b.3.1791830927588;
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/8] sparc64: honor queued spinlock layout in secondary startup
Date: Mon, 12 Oct 2026 20:48:03 +0200
Message-ID: <20261012184826.986050-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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
Content-Transfer-Encoding: 8bit

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4

