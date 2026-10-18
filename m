Return-Path: <linuxppc-dev+bounces-29648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB807CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:49:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70R56SYCz2yps;
	Mon, 19 Oct 2026 00:49:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331377;
	cv=none; b=NPMUhafi/K0tuFAri9pUYd53uhonNGKJfDs/s6nL9MLggXlfip4ywKcq1XvQWszqpBUl+zIZi5BRjcJKNyhE9nlu+TtQ8vziglpjOJJHC4KnFgofx1fb2762QwWD8lorpiXTPka3zsT+2tpKCvc9I4L1Y/rqaP/tpP9sffGZqKSOP6nBp2uQTkYiUGYgfIU+7ZOEqiISSf2YVH5SuDrAENoyL4pB/lCJaGVpn51WcPvuxYo8RVtuJN6eD/zo4MP2S3JZ9J9EtNUc2+8DqyxDbB6PVVVqHvvkXYWz2OsleBjT9KMB/ya7VVQG2w5huA2Gfmxh++fGEUs5CwUmWns+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331377; c=relaxed/relaxed;
	bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKgQjv7ofofW21UxSlN7qXD1UyUS/z0FKgpfCsR8so5sBiGJLVoQMaxFV5la3/FgzYnUAp67qe0MR4tYC/3wpwutX+yRBo4WMN1PDrLWvQJSSXz0RYt7D+aBiXoscjEsbJBKIlNaVyKhzWuqQoeYe8q8RcT0SJ+JTqvV4ZDw3nSYF+E6nA8a4RDirOMiu6ysM3bmga4JoTnyN8ZLOH21HDdbuE/RU2RV/fPdGwjGkLPqrHlmJ6uyqos5x+jXohPA2rZT0d6kATzZGlOgvDNX/31/EPcPhcBpwJx4tM1KozPezWr0r6WkfUaHfqesfPWJnPqLdXCnmsT3mIEQU+nlVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lrtYcd/2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lrtYcd/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70R44cfqz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:36 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso204985566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331373; x=1792936173; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=lrtYcd/2pn5pg1QLRrcIgZEr9BqXBbX8CKrwbUaC8aa8HNchZ26kQIvDi+Vz67q0AY
         Vz7yuWlL1vP+fC/rvEY6Q3nq8i5VOPOpk+FIPEFn+VlvcA9kU2zX69b72EeImBblhzji
         SnfJ37aL549FJDJz2QeqigqYj6S3Ip3PVvp9E1U7X7AuGa8Fa7QW5u8rxhZql3JlvH7U
         sR1Cogs8/Rt/G7hGr2JtwwKBngG04pDoXzxmTDvNRspJVf/H6hmY7nkS7/DSIUQwOzUz
         YU0ewfWwdxHZn0iiaKi2B9PzRr4mwiRX3EiaT23OtMCgd8eyeNETR+Mu/SD0+kN7Bnq/
         81Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331373; x=1792936173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=L6i9c9VL+WwY4NyTq7q0vhYrH8dLKZCjHG/N/PKpiunc4KYve4IyWD5xjp+e1sUBkU
         S/k78mjzz9U7hUDuTTb2I//WWPqmB/WqCnL523tRr0oChoXashYsog+koaz8dwT7GjZT
         QwlQIt13ZK2QTdlVziw8ZOI65arsgEAYode3+rFnFHMclqZ0G8I0nc+zKgMif2S3K4Lo
         5x5hWNsihZxoNE+W6LZ55F7LaRnB7AYwQzB90PEp9VmnrEh0rXajdj3lPDO1aBR6K7WS
         mJpTUmztLHuexyBcmwzjekBovEZu8WpN/tUDTyxo+xwRvvQyvdZDREavaTcsP4ZcYVh6
         CsLg==
X-Forwarded-Encrypted: i=1; AKwUvBzN4OgHHWG9B+vskMjJXDgO6f2e9ouJNeSWEBG11il7yBf5D16JXS8XAZACNkCvArXV/S+AyWUjSAOKY+Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJLIOuL0nz/oa2DuVs2T1048645DYpbvgof6gxDcDI4fbckgS9D
	0k6fPOpnYt5+MbDT9uX7pD6NqWIAyq+OkQRTbX5dyjO04fvCwPPQst7N
X-Gm-Gg: AYBFou2GpOf7irwPcH4Xcvqj67Ge4xtqIHuTuHoNuV368Q65WN36UDwxKuD5gR0t2Ob
	gs81tnH/TVKXTpD1GUM2jowJF5gJYB+iIq1F4kSLnJRXIYldjhnbP7Lcr3xa6/erwp1FxldMVz3
	cM0vOBjiUcQWEmYESPmC+G0QOs1QQeuLmmF1J/f8ABkQ+jhkMgv469TVnm2yijQLSopfq8ZVIKA
	CsiSl3DNjt5BSduUQedNaSOm1ec9WdeHMp7PvE/P5Tbf96NQZAONVwe3NkCPQkHhah/B6hmpXWe
	cwP3geGn5++nVqHxtsRhl5kTzPiKEDa8zo8XLhDue1iJ/ZcchBa0g1dDBMuHMuU39VEfxA/dUdE
	WEnGPbNZC35Fv1IE8JV/BzElO48DZoww7IbrEgvaICbxiTl6iMHctskP+IVbIQebM8Pjd6w62ZY
	eV1/8nW2EO4nArn4qRHEcUM4iqJktfByFr7uPfVXIu+kC+VRTSZKblLGNJcGQXvQhghdsqoC1XJ
	1rB7yLXDa3f/hoUgsR5kiOPJAMg0Vkt45LFDthl
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr97331566b.47.1792331372603;
        Sun, 18 Oct 2026 06:49:32 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
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
Subject: [PATCH v4 02/10] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 18 Oct 2026 15:45:04 +0200
Message-ID: <20261018134738.1016106-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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

The trampoline uses ldstub on byte zero of prom_entry_lock, which is a
queue-tail byte in the big-endian queued-spinlock layout. This writes
0xff000000; with NR_CPUS < 16384, a C locker can decode that tail as
CPU 16319 and access beyond the per-CPU table. Testing this byte also
fails to exclude a C holder of the locked byte at offset three.

Acquire the word with CASA, release byte three and poll while contended.
Retain explicit assembly ordering and the predicted branch for Spitfire
erratum 51; C unlock relies on TSO and compiler ordering.

See qspinlock_types.h and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 40 +++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..447334730122 100644
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
@@ -212,7 +222,13 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +342,19 @@ after_lock_tlb:
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
@@ -389,7 +415,13 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0


