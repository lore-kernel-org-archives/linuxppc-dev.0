Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18D60A6F4E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mVkWfYh/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP48D3PKPz3bbm;
	Tue, 10 Nov 2026 22:25:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::1d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309932;
	cv=none; b=o3EBDcbMZk9QY23yVvXNEWC50jzEu7SFHpfhGNVgi79bD6wJx3x/IVQRsj6mSBdzOgOe8kTNF6WchvLgyGEwDmneQQakE/85m3HUzXENyzoVHtYMy8txmu3c6ed9eRv8AUVY12+C7wuhUZlCDf2g9eDF6bmEOmLofQaCjpmlpIEk94VKWjtbIqF9p+d3tefacDjyM17wiPTGmJH0UHkqKgITp5y+Lrh7YM7igysDT9pLgYeBtHGFmpZNxNJD6dDxPo9+VvB1NjrnqguUTLSQYCtTTihtrIoXyvT9BO1iOlKkczdw1gQ2oUPtM6wSSN3Nwha3bbLacUgSetYDqrZaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309932; c=relaxed/relaxed;
	bh=njIoOXK5zMREOncg8mUAQGqPEShsE5xs29xDkWFtyUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACl1Ad3ft64N2gz4U/HO6Kb+/MHurKqSsa0piFYqZWLvMgi4sDe1keVoTlV8aj1ElWzVPgwF9jRHkqWN8fBvrQUpuqEsmnNIWBCRxLjw3t5cOa4V1aP6r7/kDGwGAH84KDOl8STt1j67eNoaMslhr2xw0g8u7DwOXazVMt+sFheB/wkFSA5DJvYVFPrnLonqBzMcOO13+foL+eTl559azEXPXHTy5IUEBT3dNRCQiGg/OdNKvf0PEYJyrUgXgVgREf8Z153sxpbtE+ULz/oKtaq//Vy2p0nTCN2fBrFARWPZw0QxaZ3NTfPUAzlfh5JJM6Tv4iByE8ql7Egy9TXRXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mVkWfYh/; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::1d; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mVkWfYh/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::1d; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP48C3vGvz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:25:31 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=BPShZdqjxGXzG9YjR46DA5wDrW3cgTzpgUAq+Dua6mc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309913; v=1; x=1794914713;
 b=mVkWfYh/OU5ocR0W3SIgvgFGay1eXuZ9K2ZVcborArx5MMPEOCDYFyeFOxuvPOfLou+64Lbj
 NxviIlOtEWv4pnOnogTcpp3NFs6KhEcTsaL6ycgwbASbu3WK9k8ORbYH9DHGuAFwa6g6CJimA+3
 WU9vvPNnJDjYBbYQqi7Xo5Z8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id aaa1849df80259f7;
	Tue, 10 Nov 2026 11:25:10 +0000
X-Mizu-Trace-ID: aaa1849df80259f7
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
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 6/9] mm/vmalloc: only flush the cache after the vmap succeeded
Date: Tue, 10 Nov 2026 19:25:43 +0800
Message-Id: <20261110112546.261415-7-hao.ge@linux.dev>
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

vmap_page_range() and __vmap_pages_range() call flush_cache_vmap()
before they even look at the error code. A failed mapping is never
used, so the flush is pointless at best.

According to the Sashiko review it is worse than pointless on UML:
flush_cache_vmap() there is flush_tlb_kernel_range(), which syncs the
PTEs into the host OS. Flushing a half-installed mapping therefore
leaves host mappings behind for a range that was just freed again.

Only flush when the mapping, and for vmap_page_range() also the KMSAN
metadata, is fully set up.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0565cbfe325c..3f98056f8c7e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -369,10 +369,12 @@ int vmap_page_range(unsigned long addr, unsigned long end,
 
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
-	flush_cache_vmap(addr, end);
 	if (!err)
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
 					       ioremap_max_page_shift);
+	if (!err)
+		flush_cache_vmap(addr, end);
+
 	return err;
 }
 
@@ -758,7 +760,9 @@ static int __vmap_pages_range(unsigned long addr, unsigned long end,
 	int err;
 
 	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
-	flush_cache_vmap(addr, end);
+	if (!err)
+		flush_cache_vmap(addr, end);
+
 	return err;
 }
 
-- 
2.25.1


