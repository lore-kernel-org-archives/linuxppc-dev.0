Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741560A260E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HRA702GZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP47g3sBcz3bZs;
	Tue, 10 Nov 2026 22:25:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.126
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309903;
	cv=none; b=Sp9cLiXiimazUZg99h930ev9i1L0bhrG4O1rzOI8kZ8YGCTSrgGIaHd791Vp7l/RDIgdPmyNoecqeGmoKvTF8Fx919Eh3yvXJSwsyd6cfaa0NvHQihivT5cL96V8VgzUdrhXVhHox0cW4dUS/4/ZVi8nLQjqhLspIapvvTfANYqSEbA2B+oO1UXHQKl4y4LFdPsNrcz/z83+C7y1V1ceYW9Z8ItNgOJhtmhNLfeStOaPpG1hMoFr/a241uQq7Q3M4BlGwTz5DyEtTiadjHmblsgm5eejNp17unpup7x55fPUKhXq4PUuE2OK+PIjlodNWskD1WCejA7htp3PmBWgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309903; c=relaxed/relaxed;
	bh=xc/2Ec+isrnw7gxi44tzolJqOLCV74Dq//tFYw2pc30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWf8dKI/ZDWF4Jo80Efv0fJsDUOzq8k8v2adO5pGT5x24g4VIVdOSm92BXRInIAwehrt/y4XaEpDD788HvaNc0b3Xmf2pnrZzNJXEn8uue/dUkXvxhqFWUUxCygxwFyEIVGd4zCAzp8rU5A8qyrWHL6i99Sd1qVADgUu6C5a123uN+g1ic9LQHZFIV8CmSmuSRi60/SmBv4YQUfQt+cZzCIipmb9HdDsSTCyNDXXedh6RwP4h8egOFSehpl64WWkibolppMqZvb1S8RsMsKYGRX6lj4mBO3R3j/ltZ4Ohm4L8PQychRgvCI533Nf7FCbU6TChwXiRuS+KNIGevFzVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HRA702GZ; dkim-atps=neutral; spf=pass (client-ip=95.215.58.126; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HRA702GZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.126; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP47f4Lmcz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:25:01 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kYvyfDK0ROE4CNDauI9kgGxJwtog7X2zxAx8KX+EfBM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309883; v=1; x=1794914683;
 b=HRA702GZnLe6rctJhDQuM+ozDS99Y6I83jb7m2Te53GS/hs2+bFIZ2s+2cVGJMwAK/Owan6N
 20o+OdmwXDveZmtlleLBldslCBbxqEGAILLWaDa9vd4MwMVxUAOiLKuGQOVdjKeCgfTjK8eDDjO
 cJ9wglN3lckVV9nThG0g6dh8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 6c351c2373b5f8e3;
	Tue, 10 Nov 2026 11:24:42 +0000
X-Mizu-Trace-ID: 6c351c2373b5f8e3
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v4 3/9] mm/vmalloc: BUG_ON() on an unaligned range in vmap_range_noflush()
Date: Tue, 10 Nov 2026 19:25:40 +0800
Message-Id: <20261110112546.261415-4-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261110112546.261415-1-hao.ge@linux.dev>
References: <20261110112546.261415-1-hao.ge@linux.dev>
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
late, because the upper levels may already have installed page
tables for a range that is rejected anyway.

The pte loop maps whole pages and stops only when addr lands
exactly on end.  An unaligned end lets addr jump over it and the
loop keeps mapping past the range.  An unaligned start maps the
page below the range and usually misses end too.  Such a range is
never a legitimate request, and the corruption it leaves behind is
hard to attribute to the caller afterwards, so bug out on addr and
end at the entry of vmap_range_noflush() and drop the check from
vmap_pte_range().

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 093b8d5f7b0e..27f2674a5556 100644
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
@@ -347,6 +344,7 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 	 */
 	might_sleep();
 	BUG_ON(addr >= end);
+	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
 
 	start = addr;
 	pgd = pgd_offset_k(addr);
-- 
2.25.1


