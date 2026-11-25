Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEE606A323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHVXRqO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY3N6C4Hz2xLg;
	Thu, 26 Nov 2026 08:39:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795642752;
	cv=none; b=ZgAEzOmkOwqyC7/fkoSixfMGfzyatVeF3iKz9cJMrgh8ew0fkIjmh+Br4u6pYkEpINwtYNbJ9AR3Fbg/AYvWtsnyBW/MWAFQZmqLrTlAEIG5lEi8ZAMK3HgyMV0e0UnLUkR/CwB/ehCwQAuKmqz1Zk/kIXKrroPYHnHeRP3mGKNuow0iF40NfOlqODhTQzZC/OqcH1eNpmONdWAIK1GL0CQZDQoS+tEp9jnhBvrXB70h5HVgRsqXOuMsyRi7YAUmUUowcX3O8ZtdQMs96aRWCzijTQ7CFlC143y6KaKuIXyllwYcOq6p1uS3WUQEa5sZHFKwkxMqYQ7LABTUFMwY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795642752; c=relaxed/relaxed;
	bh=rUM6DDgN644lwBMuVOf8hCvlUKG7RqWtFvmySpiCJP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTF9ZPz51wWR6HZU2lMUqj2tLTOnp49cfSMNUvrKrnnlijYFG3G0JcRVx1UxApxXT8g7j/Zb+v2NUzSuebUcwH5RcjTemqaSdHCC9OtWyZqnrK8BppAF3xmFVSXqUSusiqnuw4I5t8gEtxyCa+Vy5u3utzUj/WSe7E/TJNN4by3PUIVfDyOwGk7E7vflROgJyIplbnRHALc3S8wMyiHOozjXvIMv5Q8Wf9hyGkzsl2T5LKpKa8EvyR+dZQ9DQ8/SS+uQnXWpiIkTw8f3X3IzGp55a4/6Vvc/rM9cGB472D8UAY/uEhwXAmcehwkruHQgUWJuzQ2Bk87WJ8DXVVAZKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHVXRqO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=harry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHVXRqO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=harry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZY3M73Y9z2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 08:39:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 06D41612BD;
	Wed, 25 Nov 2026 21:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3346D1F000ED;
	Wed, 25 Nov 2026 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642749;
	bh=rUM6DDgN644lwBMuVOf8hCvlUKG7RqWtFvmySpiCJP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=csHVXRqONzw+Zf2W4mIiRNX44yIJY5CyRbFbcCR0+M/3R+GAiOMw3psRBPN1SgjKG
	 e3zbCETZaMq3pe/kSpHAtZiGstZ7Nel3amY5pdz9XV8gqjeM1AXeDT7jpyIny0bOe9
	 SuomrZaO2RHa2qG2CVi5VaWOYXyVZrW1FAihaRpWfvGCbxdLN/suOU+Wc2dERbKl8o
	 boj2OWLoGU/PW20RgzAeGTnGgWZWL7274PUZOHFuSASuVtqK5eYFytXfIwSwwoOCk0
	 g7EEMg5orzdhHYvJnZxuXFqRuBz9YUo0FhIUT/VJHPoRhMgzSPogevaDBmoXEyezPE
	 LcFWpym+IE1LQ==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:09 +0000
Subject: [PATCH slab/for-next v2 08/14] powerpc/mm: specify
 SLAB_MAY_ACCOUNT for pgtable caches
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-8-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

User page tables are allocated from PGT_CACHE() with
pgtable_gfp_flags(), which adds __GFP_ACCOUNT for non-kernel mms.
Specify SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: copy_process() -> mm_init() -> pgd_alloc()
  -> kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
                      pgtable_gfp_flags(mm, GFP_KERNEL))

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 arch/powerpc/mm/init-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 745097554bea..72dfcc559630 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -140,7 +140,8 @@ void pgtable_cache_add(unsigned int shift)
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	if (name)
-		new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
+		new = kmem_cache_create(name, table_size, align,
+					SLAB_MAY_ACCOUNT, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 

-- 
2.54.0


