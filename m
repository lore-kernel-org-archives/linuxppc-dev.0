Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52B606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Of4lsz3c
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfH73TBqz2y2f;
	Mon, 16 Nov 2026 18:13:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::4a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813235;
	cv=none; b=d1E9mxbcU6dah30F1WVvqV1cMPCVraIDFQ94TSFPElo/R1pcLZ0X63tO2FX2UfkXIOCD9Tqev+2kluOyeoFNji4/QI2dtD0UxaqKqh4sJB7qIV4ei9HWk9AZ/XRBNoS+TK0X3PmhL51q4qiZJVqSUZ580awt72doEZwEKIkjMO4Side4fWsczQHBnpcctxZrEkJsaeFnKAaY4tlmJr3fV9rqjkXhGwbC957nCLPtWHR9C6fn36fBhQf/5fABKy5jzs2RmaNE23rqWb5AQV3XxYExP8h6kEgsX/ITiJT2vRZiG/blAsHJCO+CfknxASOoiAp/Dmilgy0kLETtLJwl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813235; c=relaxed/relaxed;
	bh=OkgfjJfKGIx3ULtuBKyWwXSAvJnNVfF7lRvSAV7abaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5nCXv+vl46zpJzYv8Orq3brKkjb+kbEtsjQJj53hgJGxeF95wDI440dNKkCjLLzJYWP80zPTzMhc7TRik4i5lamBwe2BPtkrx+R3bb821swvqJ5QLk+tczQs1YHdgRorfjxRfBK5qwpZh/wTYk3bBGKNFc+8L5cDZJVDs0g3bsikYLqA7IwJSHhs17VLp2I1Escf02D/SLs5yWbgTLr99hhrBAdn7LoW0FL9Xm5qQ9iFYsEc54GglOOBb72dQnut4XvOxHR74G8MMXnjFvoqXc1QkTWvIDKWvzv5DoRgA8zS/1H7qTwGVmIMCaiYp6v0Kq24acaRnjDDXCBKwARaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Of4lsz3c; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::4a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Of4lsz3c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::4a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-74.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfH42vnnz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:13:50 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=m/Ac+mzRFeJIEx6vjbGzkyHImn4ediK/dODwPh9sWhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813212; v=1; x=1795418012;
 b=Of4lsz3cWS4D1+2RzZ0YuO2qq8m9vzH9D4ohHHkX1LUolYMmrGPtNmcDVOW3nyylod4IMiyI
 PbLC48TuoyBZYroXhjPdCb1y8qQ0SEc0mEPaWtwk/mgKDGHXkctwTMqGsGoKStIaPsfCfbLnLfg
 tNu4JyqvgfNjbpk0aL2n5VwY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id afbccf1c33743f40;
	Mon, 16 Nov 2026 07:13:32 +0000
X-Mizu-Trace-ID: afbccf1c33743f40
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
Subject: [PATCH v5 00/11] mm/vmalloc: fix up vmap error handling
Date: Mon, 16 Nov 2026 15:13:14 +0800
Message-Id: <20261116071325.263682-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__vmap_pages_range_noflush() and friends can install some PTEs before
failing and leave them mapped, and the kernel callers do not agree on
who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
roll back what they mapped before the failure, while
vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
__vmalloc_area_node() rely on the mapping functions cleaning up and
do not call anything like vunmap_range() themselves. When the same
range is mapped again, the attempt hits the leftovers and fails with
a warning in vmap_pages_pte_range(). A leftover huge pmd is worse.
During the retry, vmap_try_huge_pmd() calls pmd_free_pte_page() on
it, and the x86 implementation cannot tell a leaf entry from a page
table and frees the mapped page.

After discussing with Suren and Ulad [1], we move the rollback into
the mapping functions. A failed vmap leaves nothing mapped, and the
callers no longer clean up after it.

Patch 1 gives __vunmap_range_noflush() a can_resched argument, the
failure paths can be reached with a non-blocking gfp mask and the
undo must not schedule there. Patch 2 is the KMSAN part, the shadow
and the origin of a range are mapped by two separate calls, so the
rollback there has to cover both. Patches 3 and 4 reject an unaligned
range at the entries of vmap_page_range() and __vunmap_range_noflush().
Patch 5 only flushes the cache once the mapping succeeded. Patches 6
to 9 add the rollback to the mapping functions, one entry per patch,
vmap_page_range(), __vmap_pages_range_noflush(), the KMSAN metadata
and the batched vmap() path. Patches 10 and 11 drop the powerpc and
percpu cleanups that are not needed anymore.

Changes since v4:
- new patch 1, the unmap paths can run under a non-blocking gfp mask
  and must skip cond_resched(); it carries a Fixes: tag so it travels
  to stable together with patch 2
- drop v4 patch 2, the KMSAN-disabled vunmap skip. !kmsan_enabled
  does not mean no metadata was installed, KMSAN_WARN_ON() can clear
  the flag at runtime, on Suren's review
- v4 patch 3 now warns and returns -EINVAL at vmap_page_range(),
  instead of BUG_ON()ing inside vmap_range_noflush()
- drop v4 patch 4, the walk check. No in-tree caller passes an
  unaligned range to vmap_pages_range_noflush_walk(), the vmap
  allocator guarantees the alignment for vmalloc()/vmap()/
  vm_map_ram()
- v4 patch 5 warns and bails out instead of BUG_ON(), following
  Ulad's review of v4
- v4 patch 7 is split into patches 6 to 9, one mapping entry per
  patch. The batched vmap() path is covered now too, on Suren's
  request

[1] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

v4 link: https://lore.kernel.org/all/20261110112546.261415-1-hao.ge@linux.dev/
v3 link: https://lore.kernel.org/all/20261026080329.140244-1-hao.ge@linux.dev/
v2 link: https://lore.kernel.org/all/20261019054531.87652-1-hao.ge@linux.dev/
v1 link: https://lore.kernel.org/all/20261009063619.112313-1-hao.ge@linux.dev/

Hao Ge (11):
  mm/vmalloc: skip cond_resched() in the vmap unmap paths when atomic
  mm/kmsan: undo the shadow mapping when the origin mapping fails
  mm/vmalloc: reject an unaligned range in vmap_page_range()
  mm/vmalloc: reject an unaligned range in __vunmap_range_noflush()
  mm/vmalloc: only flush the cache after the vmap succeeded
  mm/vmalloc: undo what vmap_page_range() mapped on failure
  mm/vmalloc: undo what __vmap_pages_range_noflush() mapped on failure
  mm/vmalloc: drop the KMSAN metadata in vmap_pages_range_noflush() on
    failure
  mm/vmalloc: undo what vmap_pages_range_batched() mapped on failure
  powerpc: drop redundant unmaps of failed vmap mappings
  mm/percpu: stop unmapping the CPU that failed to map

 arch/powerpc/kernel/isa-bridge.c |   5 +-
 arch/powerpc/kernel/pci_64.c     |   4 +-
 include/linux/kmsan.h            |   8 +-
 mm/kmsan/hooks.c                 |  18 ++--
 mm/kmsan/shadow.c                |   9 +-
 mm/percpu-vm.c                   |   5 +-
 mm/vmalloc.c                     | 154 +++++++++++++++++++++++--------
 mm/vmalloc.h                     |   6 +-
 8 files changed, 151 insertions(+), 58 deletions(-)

-- 
2.25.1


