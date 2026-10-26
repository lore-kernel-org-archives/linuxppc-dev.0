Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F41606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPwEjNnj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmNr2JCWz2yMP;
	Mon, 26 Oct 2026 19:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::9a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001852;
	cv=none; b=OR9gA3JFzQ3jo1LJq+cH2Cy/kyQGUONzxcw/Q9oCC+T6BtN24nRF5717DW+hpM1KcURbzrPwq9HmeQjNhYxeWDlGs4ScfmOkYQr2/pVhhLa+WMih3th5D0ClC+xovNOT16e3iHf81iXEQsomr5IS8AVhuBFkcJCWMBYSVk6FZL0HU+E5yNDI2Eq4ltShDMHNKHFjA1SErgN55HdJFdoWfVxTo2iI+xFJmxOegzH2y1Z4+YEVtP4ZsziUAyVN8JBIdOq11SSHpnzEZ1ERfLCT4XDKJEqx5V1F/O/POWWQzfhCmR4WFDHlNkTYvFhVS8NzM/79uyKBXKdosqgqVltqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001852; c=relaxed/relaxed;
	bh=s7UpNzJhxi6pbxSVCU4gh2Lq8z17O8RRANPyNHLrRsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPpUOyAmy6catnutsu4lwu+nqXTz81oqEaS4d3pGC9M2+nI1t4k9CAiHg4Xvx0uxoRda9am9qN/JCTWzsqsYiRHlvcXqlx0Ft03oMjRlQprEO96emq0gqvcwNIoKULWTFt6TXyCOdumOXDYmVrPGuBhF9VjjZqMVo3LFw85oqvvGuoZqayoz3D8yImp6ayy6KZlfC0tlF/Tx0XPigZnXi+ZXdGFY2T6m1lQwIS9IZjEWgkqSH9waY4EmtwVfHGvjZRxc6pAQXerGsEZ+vO48V2pA8a9crsllH3LaYgVde4BM8jXxYkGncp963XQ883lZjqbcbBrV+ixDEo0hPGQ61g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPwEjNnj; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::9a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPwEjNnj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::9a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-154.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmNq1FWWz2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:04:10 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=L2pE27MmJcqFI/acr+I6vj36nyWahlUmHNuT0rwtvaI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001832; v=1; x=1793606632;
 b=jPwEjNnjIiitNEmkjI4VBLoOWBANcxCgYNyVhiyZBDBqdtJdMqQPPcae4ETQcHteNkIc6YwG
 GclGvCXkz2EW4Q6vnGkm2w8nuRFfWHag/WZJfB/igvy6kooD+gNG5G/SeKm+qoCeLjZE+EYBYii
 vCmDz4CGH1XBisuEuonv48Z4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 57ab905e822cd4de;
	Mon, 26 Oct 2026 08:02:31 +0000
X-Mizu-Trace-ID: 57ab905e822cd4de
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
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
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Hao Ge <hao.ge@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v3 00/10] mm/vmalloc: fix up vmap error handling
Date: Mon, 26 Oct 2026 16:03:19 +0800
Message-Id: <20261026080329.140244-1-hao.ge@linux.dev>
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
range is mapped again, the attempt hits the leftovers and fails, with
a BUG() in vmap_pte_range() for huge mappings and a warning on the
small-page path.

After discussing with Suren and Ulad [1], we move the rollback into
the mapping functions. A failed vmap leaves nothing mapped, and the
callers no longer clean up after it.

Patch 1 is the KMSAN part. The shadow and the origin of a range are
mapped by two separate calls, so the rollback there has to cover
both. Patch 2 is its disabled-KMSAN counterpart. Patches 3 to 7
clean up the range checks and error reporting: unaligned ranges are
clamped or rejected, the callers get the real error code instead of
a flat -ENOMEM, and the cache is only flushed once the mapping
succeeded. Patch 8 adds the rollback
to __vmap_pages_range_noflush() and vmap_page_range(). Patches 9 and
10 drop the powerpc and percpu cleanups that are not needed anymore.

Changes since v2:
- new patches 3 to 7 fix the range checks and the error reporting;
  the empty range check of v2's patch 3 moved into patch 6
- patch 8 (was patch 3) skips cond_resched() in the rollback when
  the caller's gfp mask cannot block
- commit messages reworded

[1] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

v2 link: https://lore.kernel.org/all/20261019054531.87652-1-hao.ge@linux.dev/
v1 link: https://lore.kernel.org/all/20261009063619.112313-1-hao.ge@linux.dev/

Hao Ge (10):
  mm/kmsan: undo the shadow mapping when the origin mapping fails
  mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
  mm/vmalloc: clamp an unaligned range in vunmap_pte_range()
  mm/vmalloc: propagate errors in vmap_pages_p*d_range()
  mm/vmalloc: reject an unaligned range in vmap_pages_pte_range()
  mm/vmalloc: reject empty and unaligned ranges in
    __vmap_pages_range_noflush()
  mm/vmalloc: only flush the cache after the vmap succeeded
  mm/vmalloc: undo partial mappings inside the mapping functions
  powerpc: drop redundant unmaps of failed vmap mappings
  mm/percpu: stop unmapping the CPU that failed to map

 arch/powerpc/kernel/isa-bridge.c |   5 +-
 arch/powerpc/kernel/pci_64.c     |   4 +-
 include/linux/kmsan.h            |   8 +-
 mm/kmsan/hooks.c                 |  21 ++++--
 mm/kmsan/shadow.c                |   9 ++-
 mm/percpu-vm.c                   |   5 +-
 mm/vmalloc.c                     | 125 ++++++++++++++++++++++---------
 mm/vmalloc.h                     |   6 +-
 8 files changed, 127 insertions(+), 56 deletions(-)

-- 
2.25.1

