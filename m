Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EB606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSTsVZbL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8nbM0YpNz2xg3;
	Wed, 21 Oct 2026 22:47:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792583279;
	cv=none; b=B+V9LypyFpw0QwsIAVDU7151xi67dj2FgY8r8AcTta7yaMMF6DtJQMbpEQtEaX0oW9Y1vocCl7uZMAVCSmRrnsOLo2tMrVP03sfKiZ/hJEgsvJ3peq/xshRh+q/yZpeF9FZJ9LJwbpwt1pfeG8bFBvB1ewlv7bmwdSQv6+Ihpg8xbB+9TAPQ/JGPJRZswgQapatOOyoTFKIMXv3bdsG2oPGuBieAqGn1CE3aYp8zDNWpZ4l4jJdWl1wh/DmK7HlekOag7CytIsXy3bkIMF+I6VKP9Kex7/d6xwyi2y2GMlBiYgGGBJYrNOcyYCL/Yrcqy4IM2rsW/lwU9I7Z/28mow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792583279; c=relaxed/relaxed;
	bh=FdNzDMyikUDkRQM2Yx/R+UlgduqMmo5RYSj82aLvC8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+5oU6s5EAFEziaovAfuVth1M5j7HSeQH/jcLlkhZIDTx1fG7TRq6+eI+xOLzENAJByaZW2+QQtlgHD9pfwZ3SYs6aLJk9UF2s4IT0dPqHCNdCOIyidvPjqhDzht7vUojV7ANhVgCV94cS41guoN8L1XOjL1GGkdDJfXMC0weMxxMbPNfS40Op1YTiwpGUkzMYzwI0qgnUjFipCb+T0JcKwBr4cVVRSXCtkyrJD/669OKg3pJqgCoQ5F0+pofs2qhviM4ZYLiZbd+CDZUn9sFWezxeVNPbNOEyyLsJopPOhrbLtvvNGuo9D91JrSyeuWMfzNIspgcbmyonTKbYA4tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSTsVZbL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=harry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSTsVZbL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=harry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8nbL25NBz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 22:47:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A991447C1;
	Wed, 21 Oct 2026 11:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EFB1F000CA;
	Wed, 21 Oct 2026 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583274;
	bh=FdNzDMyikUDkRQM2Yx/R+UlgduqMmo5RYSj82aLvC8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fSTsVZbLq+oG9k7aYHjUwtPMV2IMdRjBz/QrEGiTP+glW02RmmZw163JDRDdGuzXG
	 ywJ1FSKJMY2U+wwwHaYftuUZPJFEuS+rwSxA3qjefkUKmt85gQX5cG+G6pO9lNJ98H
	 ZD611ggfnEzxeVeI/KZr/eowxy1lXMgJEP6Ktem733QZ7eKIwIQcESDMaVeROgqNxu
	 axrwIZcRoZLJpLln5ZhrCy5MDuufEYKyqgX7r/bcohNhL8/zAnDke1oQkn9JeFAir0
	 jZ5NkJECpu/2s80E+IxbA1NYUZ+Tu8/sRif3MMhZ26ifDHLj4eFQHoiAH/GG6CSL8x
	 MMe8xKQYEaOhA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:49 +0100
Subject: [PATCH slab/for-next 08/14] powerpc/mm: specify SLAB_MAY_ACCOUNT
 for pgtable caches
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
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-8-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
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
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Assisted-by: LLM
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


