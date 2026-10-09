Return-Path: <linuxppc-dev+bounces-29098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2492CA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 13:32:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1SV11gtVz3048;
	Sat, 10 Oct 2026 00:32:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791527821;
	cv=none; b=gvl4A9ykn3mTHrEmqna3IZz2DUKBT/OVOQGYQbE5/GIDU+pHpZzMh4jbe1HX7lhjd0B7u2UtBthu5YEJSfzujLNUBdVZrx50D2Br9CI+Q+ZM5b5JiyLfYjKmyNgsrXHrCzXinUzAO4PYczIqENu4Cvib0MOauFzsEyPBW29xmVFzhroRbvW3qtozNEmqTJphjpIllm33pCX/gq6KQCf3DNcLx0IZz6qOi5IYwqz9FsaqcZlmxADM04+5M/kmMh+xQqAhw90Tdk27SCog4KQiRjZiiWKY2KvyCu6gbb9pogys2aAFuDHg1crNMs9FWptfudD2XMI27pSlc3D6xfhdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791527821; c=relaxed/relaxed;
	bh=ewDhzUV9xaVt5mKw3GI50ncC05J14fiW/QMxZNAxhg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouTy4F7+wvhCfrjrIwVBahkZ9o4kpr7oj+SMLjU7MF73l327rG0zbRf1MgaB4RvpA9eYczNnw6DMjDzH4SjkS9JaY9C0BhmKiRjTTc3Px/cnBX6BYvz6HaB4bqN1xwppdSwE4eihqSUJWqz3aZvoB9mAAorfq23WbfuaNOAT5AkiBEAByUhfp9t26kz3PMwiNoyR0Cq6mgCDAM4eOVHw5jeGq5ls5DLdiVrWbVLHMj4hxuF687wPb8FIMEn8uGIEthFSuTDmQeRCj6yrEIXeZMGKg4p/AmqBX7215r6nvjSC2ylcPg8QEK927GngKhV7ykrScG0P9MQY6df0UkZM5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZVS8Jh1p; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::34; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZVS8Jh1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::34; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-52.mta1.migadu.com [IPv6:2001:41d0:203:375::34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1HG460SDz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:37:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=tfre8IQfOGlwE6Sd6ZF0/CKAPq4d3X98BZ98KEdVsDo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791527800; v=1; x=1792132600;
 b=ZVS8Jh1pWa9v8hfNMqqJmp9XdZmxqNwS1O3/7/RKqFah0i3ZTetb6In6zyd4dPqvAv+syyrE
 sQHytZhDKU2IFcp7XsY62NMJYGHzVVh4wkLatZonQuAMfNv9M/5a3CWfAv1OGXF/sz1L+p1kIMC
 KC1Dz52wj+09iBXvRa9kg4w4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 20cf8800623ca6ae;
	Fri, 09 Oct 2026 06:35:12 +0000
X-Mizu-Trace-ID: 20cf8800623ca6ae
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
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
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/vmalloc: make the mapping functions undo their partial mappings
Date: Fri,  9 Oct 2026 14:36:15 +0800
Message-Id: <20261009063619.112313-1-hao.ge@linux.dev>
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

This moves the rollback into the mapping functions. A failed vmap
leaves nothing mapped, and the callers no longer clean up after it.

Patch 1 is the KMSAN part. The shadow and the origin of a range
are mapped by two separate calls, so the rollback there has to
cover both. Patch 2 adds it to __vmap_pages_range_noflush() and
vmap_page_range(). Patches 3 and 4 drop the powerpc and percpu
cleanups that are not needed anymore.

Hao Ge (4):
  mm/kmsan: undo the shadow mapping when the origin mapping fails
  mm/vmalloc: undo partial mappings inside the mapping functions
  powerpc: drop redundant unmaps of failed vmap mappings
  mm/percpu: stop unmapping the CPU that failed to map

 arch/powerpc/kernel/isa-bridge.c |  5 ++--
 arch/powerpc/kernel/pci_64.c     |  4 +--
 mm/kmsan/shadow.c                |  4 +++
 mm/percpu-vm.c                   |  5 ++--
 mm/vmalloc.c                     | 44 +++++++++++++++++++++++---------
 5 files changed, 42 insertions(+), 20 deletions(-)

-- 
2.25.1


