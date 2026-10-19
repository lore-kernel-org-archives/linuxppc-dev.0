Return-Path: <linuxppc-dev+bounces-29678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2775CCF2D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 05:46:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Pfm0lD7z2yFk;
	Mon, 19 Oct 2026 16:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::4d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792388768;
	cv=none; b=Fmu0cCiw/xkczgPDoZsEMmNBHcpWChk6gEl7EyAHMBXb05WUoUCPgudvpOJsVq/ByHtjTs6MItgS0RAOYIqpvPnRoa/PM2FpsWRp8lDAdo589EQ2vlrM0mQk9FEZyQvFvU8DqSgnnLYLF0ZixlqK0V+7+Yh+xxn8qaJdG3YY9NHQXCuPjp18GW1rOTJJBEYY6mNARcrWgtI2i9lRfoy/HuJ2klYyZWhWB9KMSqn+C+v4OXiqvG4CjIO37T0k1FYrYdax1R4xEd5j/hHvlXODVdUv5YjoBlyKD8omAHzKbi4NGTXvmbx2icmvCTGajsfzfl7owCX1vQ1DoD8TS9/8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792388768; c=relaxed/relaxed;
	bh=Csd/DWIbabNfDXhiBNfIrUSLSOKx+oLs3xGRISDhTSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lzQ8CNDKSaMsq5Eag8+IKO1sm5pieWHBkqGKsVVfnvE/0KM8y6eod7wlwBAggpMEI6nQbNX0nO/LCciPbxTtj5P6G79CCPoxJREXUDD8ssxVeIgKAXonKc6kC7A2eT1hnyZBEweK/jgK+5TcCt++xm+n0zruUgnoOwWbVnnQnVot3gFbNKmBfpFHih5MWhXxDOBRzt4P/QI2XJzKxOR9jg5q2L2R6qlZmcci8Y6ZCTl/yifXpK+JLR2Zrj79Xa2cukJypveWf47RxvfdD9ErhRPZ5x2ZzUDY8cQ2YctAlqa8qgk+v2imz65hKeNd0RDHTkHmK0w9Am/txTlvooKIag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i3qSEYkB; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::4d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i3qSEYkB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::4d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-77.mta1.migadu.com [IPv6:2001:41d0:203:375::4d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Pfk3hgnz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 16:46:06 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/fcqj4m3aIuWshJpvmCFywqs73fNC8e2m8IxJm9UhVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388748; v=1; x=1792993548;
 b=i3qSEYkBOifN/5iXZh3ZerSvSalZVCvdw4zSD0ITGIN1xVBxk5prJgoN3oQC/KlfGcrE5SJD
 q90Su2r9/rqBgOkv3IcZ81C2gYYwwUJJ1fkRHK5apBqRGuecnmZ/cef6Rrl1loXoEMXTqGjm9/I
 TpaIiyz/MF2sck9yLdNTJ0X0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c488493aed6b46f9;
	Mon, 19 Oct 2026 05:44:21 +0000
X-Mizu-Trace-ID: c488493aed6b46f9
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v2 0/5] mm/vmalloc: make the mapping functions undo their partial mappings
Date: Mon, 19 Oct 2026 13:45:25 +0800
Message-Id: <20261019054531.87652-1-hao.ge@linux.dev>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vmap_pages_range_noflush() and friends can install some PTEs before
failing and leave them mapped, and the kernel callers do not agree on
who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
roll back what they mapped before the failure, while
vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
__vmalloc_area_node() rely on the mapping functions cleaning up and
do not call anything like vunmap_range() themselves. When the same
range is mapped again, the attempt hits the leftovers and fails, with
a BUG() in vmap_pte_range() for huge mappings and a warning on the
small-page path.

After discussing with Suren and Ulad [1], we move the rollback into the
mapping functions. A failed vmap leaves nothing mapped, and the
callers no longer clean up after it.

[1] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

Patch 1 is the KMSAN part. The shadow and the origin of a range
are mapped by two separate calls, so the rollback there has to
cover both. Patch 2 is its disabled-KMSAN counterpart. Patch 3 adds
the rollback to __vmap_pages_range_noflush() and vmap_page_range().
Patches 4 and 5 drop the powerpc and percpu cleanups that are not
needed anymore.

Changes since v1:
 - Add patch 2. Sashiko reported that an empty range that hits patch 3's
   WARN_ON_ONCE() trips __vunmap_range_noflush()'s BUG_ON() through
   kmsan_vunmap_range_noflush() when kmsan=0. Patch 2 adds the
   kmsan_enabled check the unmap side was missing.
 - Pick up Reviewed-by tags from Suren and Ulad on patches 1, 4 and 5.
 - Add Cc: stable to patch 3.

v1 link: https://lore.kernel.org/all/20261009063619.112313-1-hao.ge@linux.dev/

Hao Ge (5):
  mm/kmsan: undo the shadow mapping when the origin mapping fails
  mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
  mm/vmalloc: undo partial mappings inside the mapping functions
  powerpc: drop redundant unmaps of failed vmap mappings
  mm/percpu: stop unmapping the CPU that failed to map

 arch/powerpc/kernel/isa-bridge.c |  5 ++--
 arch/powerpc/kernel/pci_64.c     |  4 +--
 mm/kmsan/hooks.c                 |  3 +++
 mm/kmsan/shadow.c                |  4 +++
 mm/percpu-vm.c                   |  5 ++--
 mm/vmalloc.c                     | 44 +++++++++++++++++++++++---------
 6 files changed, 45 insertions(+), 20 deletions(-)

-- 
2.25.1


