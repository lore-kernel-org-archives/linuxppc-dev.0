Return-Path: <linuxppc-dev+bounces-29675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA4CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 05:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7PdT1dWvz2yFk;
	Mon, 19 Oct 2026 16:45:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::3d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792388701;
	cv=none; b=Z7pqFj66ukIL0upqTUe38nMEb4T656AEw6lffIYyIOY9UeVC9pR5euZKlPqizFe8X6wZtTrjs7+PqYajjbAM1FafLZvh+927pGpvsY6mr6D8cjyh+Fl/UQ+oq4HllEu3DRB4FCd6J7X8KrBZmaO/lORUHHsfhGK84zgk6ldUSddrzUXuJgAcHHQsz70NZo277yId7kL0pL5P4Jndzsh+KQJynsk63jQrsKpeUQQNZaQy6K3h7cEK4dsr2GfObWV10a9e60uS5lJmmouQehZbbYUHb6Fz2vUF9DgYVhgoUX62PsNPNy2tuUuD1EXVGAwo8AKUa4W5voVq+pMdk1QZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792388701; c=relaxed/relaxed;
	bh=T+9Qd1EiOisPixLhutF5jakBYAwkW++rsmcsp3LsZmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOc1VKuTUA5+AkEzBVH5vJWYM8YUX988gHuL1fA2q/JyQSww/i+KvcqWteq+q7viUqgLy5KSqOFF4Xotc9QnpvJkpX4/hGZ2aN52UQyOlwh+FxGVJobkxkfXpehNzH3MnoIrtV8O5m1chnldIIMXhuTAIPQ/HWHbLO/kMkFHSUNGfx4HmLC2ph1rsawBu56U+V2b+mVMZc1UG2QNZsJTCgJCBmL64/Fjhy7pzgikO3N15yTetwUXdKQ4rH7tlYtBnUrTmMBxGjvq2NlNJ8pnFC7Kql7gdPJ5WSeLoIdY58+J2DPJIMQjAc3n7CzDDkxauwqnikYNPNI2goURirRXmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LXMQysiY; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::3d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LXMQysiY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::3d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-61.mta1.migadu.com [IPv6:2001:41d0:203:375::3d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7PdS0wgzz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 16:44:59 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=jI5S7DnMABKHgHPyx67JhTXtEoMrV2Dra+q2YxZKaQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388681; v=1; x=1792993481;
 b=LXMQysiYPWO3HNSd53mGDPCBeb7wxM+DE/QZnDjN9xDBrQd4jqK9zLAkXwrrpWtuuZqGTGDJ
 t0/I6/j/BMdpu/oSnujBbSL8nU50XnQWXM3bewCeU0sOZGh8g+eXLub7dsq83fSiCtISOOmN9ln
 FuDA2ysFe5JVIzH50/c8f584=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e942bbcb9cfd9b02;
	Mon, 19 Oct 2026 05:44:41 +0000
X-Mizu-Trace-ID: e942bbcb9cfd9b02
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
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] mm/vmalloc: undo partial mappings inside the mapping functions
Date: Mon, 19 Oct 2026 13:45:28 +0800
Message-Id: <20261019054531.87652-4-hao.ge@linux.dev>
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

After discussing with Suren and Ulad, we decided to put the rollback
into the entry points of the vmap API rather than into every low-level
helper. __vmap_pages_range_noflush() undoes the whole range it was
asked to map when it fails, and vmap_page_range() undoes its range
for the ioremap-style mappings.

The rollback is __vunmap_range_noflush(), it only clears the PTEs,
no TLB flush, nothing has touched these mappings.
vmap_pages_range_noflush() drops the KMSAN metadata when the data
mapping fails, and an empty range bails out with -EINVAL now, which
used to BUG_ON() on the small-page path and map nothing at all on
the huge-page one.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Suggested-by: Uladyslau Rezki <urezki@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 44e0eb32708f..75aa5acf5566 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
 	if (!err)
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
 					       ioremap_max_page_shift);
+	if (err)
+		__vunmap_range_noflush(addr, end);
+
 	return err;
 }
 
@@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
+	int err = 0;
+
+	if (WARN_ON_ONCE(addr >= end))
+		return -EINVAL;
 
 	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
-			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
-
-	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
-		int err;
-
-		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
+			page_shift == PAGE_SHIFT) {
+		err = vmap_small_pages_range_noflush(addr, end, prot, pages);
+	} else {
+		for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
+			err = vmap_range_noflush(addr, addr + (1UL << page_shift),
 					page_to_phys(pages[i]), prot,
 					page_shift);
-		if (err)
-			return err;
+			if (err)
+				break;
 
-		addr += 1UL << page_shift;
+			addr += 1UL << page_shift;
+		}
 	}
 
-	return 0;
+	/* Undo the PTEs installed before the failure. */
+	if (err)
+		__vunmap_range_noflush(start, end);
+
+	return err;
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
@@ -715,7 +726,16 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (ret)
 		return ret;
-	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+
+	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	/*
+	 * The page tables undo themselves on failure. Tear down the
+	 * metadata that was fully set up before the mapping failed.
+	 */
+	if (ret)
+		kmsan_vunmap_range_noflush(addr, end);
+
+	return ret;
 }
 
 static int __vmap_pages_range(unsigned long addr, unsigned long end,
-- 
2.25.1


