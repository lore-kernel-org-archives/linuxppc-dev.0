Return-Path: <linuxppc-dev+bounces-17344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B709FD460C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2b1PCRz3cKV;
	Fri, 27 Feb 2026 17:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174695;
	cv=none; b=ElKmph29wEYu/GatUg0u1taPuGBNRO8HrnfiFspEZhzwJM7dDAMXa/Pyy0NmTNs2jFwmjqr/0CTHxqq52NDwI21KxqLHB1wxXRvcZr9izt+n+Ip76LUWqxboTns1cNTnKjBXt4a0TotoqWbA3Q5ZEknNfobH374vgihcYwyXbYajkek1foPEw4lxt4f8IeF1asuKj48dNi18VZJBZFJGs3Wkaglkn8OHErue+GxqdX5gyRU4+vqjEfJgJR2gVGVomCwFymDlXMLePICXbec3ITBqF2ImVjG85BAUWM5bB910pFCKL80h1vY32dYBxdc3KFzhjiWKfVp7O/SGsDqRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174695; c=relaxed/relaxed;
	bh=73eqjBr6NZdEDnZXr1CPa++8UKXkeQebz204fUBPgxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOtZCqCHDeLKyp/1fN+3bMuiQGW7r5yhTFhWOyNzMigRbWKyaysnJeJu8VrpPmnIX/bT4e899/e1wOA+V9dRZKo0rMyfsDFNNjY1W3qpEt15o3cqEOuJ/AO25yGiB3yxT4wyBrTlkjTQupWrBFQzbWsLlKORbNPpd/bSEgP8J/f/T9nhXI+UqFyD0VeKov4XooFOTPUncAG6n3HBbjevAFj5HBZvt9UGiUxgtcQrMBfLuL90KtlP5ALTbMB97juiMHBBpkpuquST78Yi58dGXysFRoGS8mxqHP1p7mobC9m9Pz/GqDKmBSVTmSOJkwmzJkl1nq7HfWifFRu8BGjTiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHWp83mU; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MtHTIOHE; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHWp83mU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MtHTIOHE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Y6GjXz3cGS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:53 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73eqjBr6NZdEDnZXr1CPa++8UKXkeQebz204fUBPgxU=;
	b=EHWp83mUC9sqmCRL4lC99TpnbEb3A1GXb9+8KiMgnvutKxhoh6utIAiDJXzxKuL7tAADAx
	iHAb6kk9DIQaXTIB6jAYTCkJyhL/rjxv5hqpKmLPgE1b8lU9UQTu1mc/IxpaHelkXHCtQL
	FLe17kLwGuRpzLrDw329bgv2GfKC9zt5KuIo5EdESzn6T9UIcT2Efv+VA/4BpjpqawtkKd
	qYWKxnAXyfV7qTW7J6bc15aseZDwryfZ4cTzpGQbqMyKuOgw210GVKaOmYfkzslrfNlbSS
	v8Yyz29fLRhdRzJjxPOAt10CE191nkq/ZjaxhwRWaTUpenLnYffBSoMaCgoqmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73eqjBr6NZdEDnZXr1CPa++8UKXkeQebz204fUBPgxU=;
	b=MtHTIOHEnRpdXAih0ezpTAU9FGMaQ+i+ctr8UJ10a4fIOdQ5bXYUN/9BltCsSFq81bdVZS
	aFb1AxBAaXAzQTDw==
Date: Fri, 27 Feb 2026 07:44:41 +0100
Subject: [PATCH v2 15/15] random: vDSO: remove ifdeffery
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
Message-Id: <20260227-vdso-header-cleanups-v2-15-35d60acf7410@linutronix.de>
References: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
In-Reply-To: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=2411;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Tai+RXoFwVJhTM1dVEO+ykZdBlXqme/L2pcT98/4EtE=;
 b=ylxvWJ/shVYJ8y0GfPnPSP2H8OGGFINUoMx2uEfocZT8keFFPHG+Sq9+BcBiIFrHUqvkQu0kT
 Bawf8udB+4qA110MV9KRLcG7mRXhNKdUvusDTpEXgKSWR2rtnAUXJyT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Recent cleanups of the vDSO headers allow the unconditional inclusion of
vdso/datapage.h and the declarations it provides. This also means that
the declaration of vdso_k_rng_data is always visible and its usage does
not need to be guarded by ifdefs anymore. Instead use IS_ENABLED().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9738673018f3..9392a45852ec 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -56,9 +56,7 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
-#ifdef CONFIG_VDSO_GETRANDOM
 #include <vdso/datapage.h>
-#endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
@@ -274,7 +272,7 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
-#ifdef CONFIG_VDSO_GETRANDOM
+
 	/* base_crng.generation's invalid value is ULONG_MAX, while
 	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
@@ -288,8 +286,9 @@ static void crng_reseed(struct work_struct *work)
 	 * because the vDSO side only checks whether the value changed, without
 	 * actually using or interpreting the value.
 	 */
-	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
-#endif
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
+
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -742,9 +741,8 @@ static void __cold _credit_init_bits(size_t bits)
 		if (system_dfl_wq)
 			queue_work(system_dfl_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
-#ifdef CONFIG_VDSO_GETRANDOM
-		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
-#endif
+		if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+			WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");

-- 
2.53.0


