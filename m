Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967260A3806
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GPqeMPci
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP47T040pz3bbW;
	Tue, 10 Nov 2026 22:24:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::e0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309892;
	cv=none; b=DSh1PSQQ3iroQ2vEUsDdf0f4lXxXTZslCzAz2NOQlErSl8YnnxJp5CpnrQPWFmqxdwXrfVPrYbsCBYc1TSxD7jKkBWRatXamA3BV+ou3eYqtI5lbCkqgTRL4FIkkNW+0jP52rdwhxHdB1WX661X1lAuma3MblZPnM35ixaatZM2kCmM6mwJfGL2aUq80ZRxRVFAHYV4FAVDc4CtsMEW3J/9MBvbVLoSL7aSFGDHqC0p2//ohIH+c3OGV6mUhd2i925NChFEs8gDPKLm7btn3AmgPwBhGjZivKMuoDxmG/hpFK+iEuX6Cel3aciVBT5ZBYKTgiRj5ONY4G4zhybhGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309892; c=relaxed/relaxed;
	bh=jXkc4Pg22XsApi0R9EIbHkd3C60IxMCsWbohhWDu12w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrInlo+yXzsLFiLS+yJI/O5WKMqFTQDdmadxW9ZQsJIeffva08pdcosQzgtW/4K6/5SqegBGUqyBLBKBxAUjdOazsXBcAyoFqy7t8xyVZOtSkbAWj3eKykUajRX9f2Yc6fEDjN7CpyC/CyLvJNw+gI8VaefO78nXItEVqTtyMyXwL1L2CzDNKbKKmpVddGdzYTCRQ/6tVLC/x7HYuYyKIrSTWi8h0IcMANnPikMU1P8VdFdXxyPTYuVLmu9fpCGtkRCGhLfYVjo/f73rMGdu/Uh2saeN0AChLB9c/KAjdi1qCnavv5fQOsPN3v2oOAx5gf2G4V0IOTCrZNmfnGoBNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GPqeMPci; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::e0; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GPqeMPci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::e0; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP47P3Gmjz3bZs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:24:47 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=nFXXK04ww1DrtBAna3L3pCT6UTCtVZkSGjzMSb1SDQw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309863; v=1; x=1794914663;
 b=GPqeMPciOFNGyTY4nue/MBcE8VttIUU8w+tstDICqER3DfWu9vGO+mF1c0YpvPirnm8G9T24
 cMmiyhbeztZ3CA1I+xpC4R0aM02iDNjiNe3wu2gj/ZK/+eGia0E8PDV7OpENruPk5NHWj+xWx22
 TvqB2Uggo1eGyUS2/7HSWU08=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id cb9491708f7d4509;
	Tue, 10 Nov 2026 11:24:23 +0000
X-Mizu-Trace-ID: cb9491708f7d4509
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
Subject: [PATCH v4 0/9] mm/vmalloc: fix up vmap error handling
Date: Tue, 10 Nov 2026 19:25:37 +0800
Message-Id: <20261110112546.261415-1-hao.ge@linux.dev>
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

Patch 1 is the KMSAN part. The shadow and the origin of a range are
mapped by two separate calls, so the rollback there has to cover
both. Patch 2 is its disabled-KMSAN counterpart. Patches 3 to 5 bug
out on an unaligned range at the entry of the three range walkers.
Patch 6 only flushes the cache once the mapping succeeded. Patch 7
adds the rollback to __vmap_pages_range_noflush() and
vmap_page_range(). Patches 8 and 9 drop the powerpc and percpu
cleanups that are not needed anymore.

Changes since v3:
- drop v3 patch 3. The clamp papered over the caller bug, a bad
  range now BUG_ONs at the unmap entry
- drop v3 patch 4. The reworked walk (24bbe1c56f63a) propagates
  the errors already
- drop v3 patch 6. The walk below checks the range already
- the map side checks moved from the pte level to the entries of
  vmap_range_noflush() and the walk, and became BUG_ON, in line
  with the unmap side
- rebase onto the walk rework, commit messages updated accordingly

[1] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

v3 link: https://lore.kernel.org/all/20261026080329.140244-1-hao.ge@linux.dev/
v2 link: https://lore.kernel.org/all/20261019054531.87652-1-hao.ge@linux.dev/
v1 link: https://lore.kernel.org/all/20261009063619.112313-1-hao.ge@linux.dev/

Hao Ge (9):
  mm/kmsan: undo the shadow mapping when the origin mapping fails
  mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
  mm/vmalloc: BUG_ON() on an unaligned range in vmap_range_noflush()
  mm/vmalloc: BUG_ON() on an unaligned range in
    vmap_pages_range_noflush_walk()
  mm/vmalloc: BUG_ON() on an unaligned range in __vunmap_range_noflush()
  mm/vmalloc: only flush the cache after the vmap succeeded
  mm/vmalloc: undo partial mappings inside the mapping functions
  powerpc: drop redundant unmaps of failed vmap mappings
  mm/percpu: stop unmapping the CPU that failed to map

 arch/powerpc/kernel/isa-bridge.c |  5 +--
 arch/powerpc/kernel/pci_64.c     |  4 +-
 include/linux/kmsan.h            |  8 +++-
 mm/kmsan/hooks.c                 | 21 ++++++---
 mm/kmsan/shadow.c                |  9 +++-
 mm/percpu-vm.c                   |  5 ++-
 mm/vmalloc.c                     | 75 ++++++++++++++++++++++++--------
 mm/vmalloc.h                     |  6 ++-
 8 files changed, 94 insertions(+), 39 deletions(-)

-- 
2.25.1

