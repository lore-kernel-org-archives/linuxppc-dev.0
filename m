Return-Path: <linuxppc-dev+bounces-19584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E024F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:20:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbTW0vJwz2ynv;
	Fri, 10 Apr 2026 22:19:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823583;
	cv=none; b=e7qM008jkRGS7xy0dEcB/Qot3l7Cn1kKs5CEZKcJtBL+81ucdJVdNFAvPBBtTqvXFsQz9Evsi/iQpBtAU+YCNkXYYxpORe7QynfvTY5KUyt9E3bxdF2GGo9zCpGBpmoRysnfGIpFRiYKEOC92krqIH2EunAU5EI0Tz3w9m+lwu8TpVu8KYEJZWfu68bln5yLngtNDQRPFF4i6jPo0Uyb4pCn5LZ7wTLC2an4uS6t7cVVJ60MYoFSPpmO0U0ZnuY+BRwVgNwEv+xAPXFtBDEG2Jc9f4vgx5cZt7Z+73JaZcPJNeuF0VN5wg5it17yKVEaWc6VjEYFuFPG86ftfOGs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823583; c=relaxed/relaxed;
	bh=l/i7/xAykrEqhXZEt+AYWUOXkyMBaQ0jVLhvmI8QgSc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fNGOFHUeKfZpXBau8f/GpkPoQTXqxTZznH3a5wm1PU58xMlh38FyylzEMvFulJE3hlUuLtthlmv9dAo3UPqDwG59QKwXKOJysiKcevok+1BMk+vZRG7d2wQCBhX7IJE+5aKkERkNCBwJqjWTAe32gosdviytHpR2Ox2ugyqgujUqsOe9YrYKH/gsSqkRVdaF6QRebnyvsmAwSXQk1aL0BdpWiRHsC+WsIPpCi0mncXgp73Q4d7+0CHRxDUJymoE4HBH7jo4w16wB3nN9ALwNxaps1MqcsPh3gH3Cv/Mr7wcPW5oRZdvo/ktSmVM50vryUiHBzSuiawmq1hlcgEepqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t3jBR9hr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t3jBR9hr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbTV3NP7z2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:19:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B87CF44580;
	Fri, 10 Apr 2026 12:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0FAC19421;
	Fri, 10 Apr 2026 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823580;
	bh=mpxbBHJF6rhzMhSEUiQvC99JYsoAEEbwdTduYzlxEPc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=t3jBR9hrloEPurMHDq+39Qmu/knh8sc4zRVE8/2evrp72m0jjf5ZLkiqhTfHJf3lQ
	 UuLDw1roDamtB5PCEFrCj4Am/iqY2B6Eqxv0IhuFUbghxXFtjb45YYjGv/1iSpakD6
	 TFwz04dexWQxc2lpHNkB6gue2paUp+SphQGzt3h2nfY78uDiPTzZOojY3e61FIsW5V
	 nWhQqjnOO5JiF4o/mhmPEmcNABsipUeHkNa04EcUPJl0rFmYRv/1fqlaU1qeGqFkTx
	 Wm9D7sRbThBkNSUjiYqRay+oEzZSBtooNF5Q5Yp17uiVAaos9NzjDw3gIyxmgs/heb
	 T0VBqEkO+l/iw==
Date: Fri, 10 Apr 2026 14:19:37 +0200
Message-ID: <20260410120318.525653921@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
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
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 14/38] slub: Use prandom instead of get_cycles()
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

The decision whether to scan remote nodes is based on a 'random' number
retrieved via get_cycles(). get_cycles() is about to be removed.

There is already prandom state in the code, so use that instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: linux-mm@kvack.org
---
 mm/slub.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3302,6 +3302,25 @@ static inline struct slab *alloc_slab_pa
 	return slab;
 }
 
+#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
+static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
+
+static unsigned int slab_get_prandom_state(unsigned int limit)
+{
+	struct rnd_state *state;
+	unsigned int res;
+
+	/*
+	 * An interrupt or NMI handler might interrupt and change
+	 * the state in the middle, but that's safe.
+	 */
+	state = &get_cpu_var(slab_rnd_state);
+	res = prandom_u32_state(state) % limit;
+	put_cpu_var(slab_rnd_state);
+	return res;
+}
+#endif
+
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Pre-initialize the random sequence cache */
 static int init_cache_random_seq(struct kmem_cache *s)
@@ -3365,8 +3384,6 @@ static void *next_freelist_entry(struct
 	return (char *)start + idx;
 }
 
-static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
-
 /* Shuffle the single linked freelist based on a random pre-computed sequence */
 static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
 			     bool allow_spin)
@@ -3383,15 +3400,7 @@ static bool shuffle_freelist(struct kmem
 	if (allow_spin) {
 		pos = get_random_u32_below(freelist_count);
 	} else {
-		struct rnd_state *state;
-
-		/*
-		 * An interrupt or NMI handler might interrupt and change
-		 * the state in the middle, but that's safe.
-		 */
-		state = &get_cpu_var(slab_rnd_state);
-		pos = prandom_u32_state(state) % freelist_count;
-		put_cpu_var(slab_rnd_state);
+		pos = slab_get_prandom_state(freelist_count);
 	}
 
 	page_limit = slab->objects * s->size;
@@ -3882,7 +3891,7 @@ static void *get_from_any_partial(struct
 	 * with available objects.
 	 */
 	if (!s->remote_node_defrag_ratio ||
-			get_cycles() % 1024 > s->remote_node_defrag_ratio)
+	    slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
 		return NULL;
 
 	do {
@@ -7102,7 +7111,7 @@ static unsigned int
 
 	/* see get_from_any_partial() for the defrag ratio description */
 	if (!s->remote_node_defrag_ratio ||
-			get_cycles() % 1024 > s->remote_node_defrag_ratio)
+	    slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
 		return 0;
 
 	do {
@@ -8421,7 +8430,7 @@ void __init kmem_cache_init_late(void)
 	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
 				  0);
 	WARN_ON(!flushwq);
-#ifdef CONFIG_SLAB_FREELIST_RANDOM
+#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
 	prandom_init_once(&slab_rnd_state);
 #endif
 }


