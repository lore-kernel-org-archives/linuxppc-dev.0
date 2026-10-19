Return-Path: <linuxppc-dev+bounces-29674-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA0CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 05:44:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7PdJ4zt6z2yFk;
	Mon, 19 Oct 2026 16:44:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::37"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792388692;
	cv=none; b=O24i4b8450RGdGF9ZjTzGalZHEYF6SA6kSf7oBTIdgtv/39Sg+g79EGGcUv+KQ8tuFGcNQePnPtK7ozJlwGXzxNaeWNiM2or/OUgdkzf2wh49URiMBga242KF9o2vsAf+68WoF9F/kA4Upu2CPwpk2dLehsgtZe2bN7a25mRZZ+a2p6pNK/hp0n0dZ3HHXZTRR2dZJq7S7ezk7OOWegNNRnWTG+xD6xMF48t+2Qi4qozK7h0lKoSL/kQrCXVUdeJ7iZ8AbnEqmepgQV89TEcVY7mEaidkKc57Nqz3Ko5qTFosqk3bXconZ94uZl9ByRH5YvaCsP0e6RGgufh/aFYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792388692; c=relaxed/relaxed;
	bh=+6ZqACnwDVOYevq4rqpa5/GtWYY8/UtRNGkYuP5pwxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibWy8CZ6wi7LNWoDrMBf4pY2awzXyZyKnD8HipF0XZkGobKMOo5z/9FZZxqBqTaB44CBJynm3VwTSzx53dNk+IiQFMlwNyJJeEU0/X6PNzh1t+jZFz9nKeQAxnKo59oWDfyPmaWjdFacdXYP79HkaTT1GAIO8YKayRPHgUdpbT/7Hnp42gIne6tFlRtSlYoW5bxHmxZjjZ1kbLMfQg92am6qTTRC7V6oCu21XIHwtyj+YsyXhykVqfdBIsBwKYS9JnS7aTBZDnDz5vMTeWKWWBMWpcu6UiJfJIHHFwUHHBHJC3ppz4hEaoeFPnaxxKxTejZnou4cHPN6ogtCBOMELQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOww4fgF; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::37; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOww4fgF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::37; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-55.mta1.migadu.com [IPv6:2001:41d0:203:375::37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7PdD3mDNz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 16:44:47 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=NgIDSiBf+W9hFun6Xtj0W0UuOklbtmBkmOYHyjYvVA0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388669; v=1; x=1792993469;
 b=HOww4fgFjV71Hz7vsm2uGaKVLDEyT4i59txhBK7XXLFycSg+wlY58DA94D/PHxKKnnkySoBL
 vwpBIicBxftFZdtzPMBsdQcXx9epQFKEND/TmOlWiuMgxgc3YoYQQrh99e/y6FXkX6BaZJ3ZPC8
 nLtYWKqTbJbLOz5GtkJGTfSg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 30a8a1b7f0517040;
	Mon, 19 Oct 2026 05:44:29 +0000
X-Mizu-Trace-ID: 30a8a1b7f0517040
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
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm/kmsan: undo the shadow mapping when the origin mapping fails
Date: Mon, 19 Oct 2026 13:45:26 +0800
Message-Id: <20261019054531.87652-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019054531.87652-1-hao.ge@linux.dev>
References: <20261019054531.87652-1-hao.ge@linux.dev>
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

kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
the origin pages. If the second mapping fails, the first one is left
mapped, and the callers do not roll it back. The next vmap of the
same metadata range hits the stale PTEs again and BUG()s on the huge
mapping path, or gets -EBUSY with a WARN_ON() on the small page one.

Undo the shadow mapping on that error path, the same way
kmsan_ioremap_page_range() cleans up after a partial failure.
__vunmap_range_noflush() only clears the PTEs; nothing has touched
the shadow mapping, so no TLB flush is needed.

Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
Cc: stable@vger.kernel.org
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/shadow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 0c88d89bf0d6..2166086d3dc3 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 					    o_pages, page_shift);
 	kmsan_leave_runtime();
 	if (mapped) {
+		/* Undo the shadow mapping set up above. */
+		kmsan_enter_runtime();
+		__vunmap_range_noflush(shadow_start, shadow_end);
+		kmsan_leave_runtime();
 		err = mapped;
 		goto ret;
 	}
-- 
2.25.1


