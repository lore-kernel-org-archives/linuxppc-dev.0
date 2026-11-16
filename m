Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE509606A323
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i/0E5FgU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfHT1kHnz2y8m;
	Mon, 16 Nov 2026 18:14:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::17"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813253;
	cv=none; b=fnI70RltFS4PkeIzi+X7rsjFIvNsU7whgfhhebiEFb7doWcsmq+MAUVHuXFhTEzTJW+i2WJMkheSB0LtugtWyt5nU/SeLsGg+G9zz90S7550VBsI3G05KGsZA0Ia2qUIyp6LXREQ4s1T58c4NiE/JusdBoyPzPbK6HSGquLqzV7jMpqmZGBWDkO2CI92AwQOnm5vbeWOl2M2uSOZUf6di0flfLpZ/DoVBl7HKQaqB4y2SArssCJwCqcadS1B9KwDi7/gZRPzd6CfubMG8plW9b+AgItwf4VquFVQPcr7qZOPMViPa8D+XYMQYamu06UQiGtiWmVkMEk+LGP5ItW8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813253; c=relaxed/relaxed;
	bh=a1hTeOe7yP6jJ4PJLUPdhDcND7K7E4e0M1zKxRQII6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mltg814E1Mgi1EG44HrbbsBjXV1hHp2ctpLEHOdZqI8/Ubhqcp0CMZM5uOCusPlb7k5OgvAo7TL/D/yDZ1pH8QEL0fmzAmOyJM7W3fC+b0GmYreSA9Ludfy29j6o44xcilwg7PWl9tvEOe3iYifmao7q/ljnLtKRiFiI6WeCNjwUvWOAly5Br0ZMCR9XfM2bYNYlf8gIBiFC9PHkoVOfITJuaVvXLBLiGAAL7E4qZ3l/2xfYzJTugOHX4OyWKBV7KI+25lhvK+d2g8iTgMXNSpq2IOHXeREELek63KGun7pq8cbKjuGQarssz4spskIJKuuynpg8wbShKbVLh2zWcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i/0E5FgU; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::17; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i/0E5FgU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::17; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-23.mta1.migadu.com [IPv6:2001:41d0:203:375::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfHS27zmz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:11 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=spy9jeLw8YXOaQ6MOBiv5dZBFpPS/G4lwKbebeo0RPU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813233; v=1; x=1795418033;
 b=i/0E5FgUNV+jOZ5pAFPftQqcUwHhD3A40dD55ehtlhiYJn2OW+ZbERWOnxZKt96wnVPKHhb7
 bvhdN8tsL/POP+SPdS+WdUQs7X5YcsUo+qyyLOH4aAHuMpHhZB7xaGFqhJhKX7NCQApD+YMpl4e
 nCEOYI1nqx0i2hHBH7YdTUdE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d04e7e5a4f33519f;
	Mon, 16 Nov 2026 07:13:53 +0000
X-Mizu-Trace-ID: d04e7e5a4f33519f
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v5 03/11] mm/vmalloc: reject an unaligned range in vmap_page_range()
Date: Mon, 16 Nov 2026 15:13:17 +0800
Message-Id: <20261116071325.263682-4-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
late, because the upper levels may already have installed page tables
for a range that is rejected anyway.

The pte loop maps whole pages and stops only when addr lands exactly
on end. An unaligned end lets addr jump over it and the loop keeps
mapping past the range. An unaligned start maps the page below the
range and usually misses end too. Such a range is never a legitimate
request.

vmap_range_noflush() has a single caller, vmap_page_range(). Warn on
addr and end there and bail out with -EINVAL before any page table is
installed, and drop the check from vmap_pte_range().

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3c0d9e69b886..a168f6f20f4f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	unsigned long size;
 	unsigned int nr_pages;
 
-	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
-		return -EINVAL;
-
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
@@ -369,6 +366,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
 {
 	int err;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
+		return -EINVAL;
+
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
-- 
2.25.1


