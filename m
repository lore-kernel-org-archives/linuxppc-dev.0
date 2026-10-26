Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA2606A322
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmPY5KgGz2ygg;
	Mon, 26 Oct 2026 19:04:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001889;
	cv=none; b=Niai5t79P+SfeeYp3yU4k6A7YvQtV4YcEJa4TBLAXE5Afq8H+zkvw4i5c5ANbDQ8/ZP0ezDYpuBNw4Qj9SO+RskipUhGvFYOKGANQC2cFscNM4YrwZHM897KhmfrEgRkZ0sAH4FEQHtC041Evw37Kej0rudM6Pb+YfgPmruzShiBKMqTYOOJVSuTgzNxIMbys1fmOQSJQ8THyYtmkvg28d41kFQWKI68IqzKm1pNdscD+QTHRSHk1pssxbRPOk0vMt+xBJwV8ONvGTCCoAhbMc9UvwjRsvWFYp4mPEjWgQHmLr3zjOxsSnYTCIqKFhd1IldzM8vnqC27Binp8wEvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001889; c=relaxed/relaxed;
	bh=xQRfqxKZWPdgYi3rSnDhlWYdHqbhXbBOf3zmvKiqynk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeN1Wy2l6zD0SHJ0nbcunf5vLJrhyMfXaJNofjWzRisQEP0l1PtP469ZJoa8UOESjHISxn5gFAfyZyiYp2/ZGMhiNyASjnEe5k2LUVrtNjwLGKvo3dYxD8pnK3b6d3vO6gg5gluuKKABsI2IcxITTR/LGdeCeRysnPO6zTjqdoaholP2QXsdogcu99+EjdDgJIH0ez08xnNeuTuEwXbgIjj0D4QRnV/OXHAperwaAlKTFlp7epnlP1bbCLfTf/DR4p9d1NiR3Jj/ga1oR1/lXhwt2iFwyxup7Z6IH+eZxxpAdlYTMzcFTMHCWnkBUjRwCVsKWEHOM9KITmdWbM15Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M+ToEqvo; dkim-atps=neutral; spf=pass (client-ip=95.215.58.158; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M+ToEqvo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.158; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmPX5FJsz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:04:48 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=a517G3/D9CvqFMgtLJh4XZJvZjho3byqSfkgyTokHGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001870; v=1; x=1793606670;
 b=M+ToEqvoNfXw+i1jqNb7wKiPTGlGgJlzlPjazrBl0jmZvgaWwgUcqJpIjpq7axs+WB+Ye2zp
 eh0rcouT8DuCqp3BHu+dQuHXPUWsCp/hFF5/mERACHsBHJ2c91STsUpGpyhEHMbPcKZAEodnAor
 nEhWxrOrohMy3vbDGie0pkgo=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8477b878ce637510;
	Mon, 26 Oct 2026 08:03:10 +0000
X-Mizu-Trace-ID: 8477b878ce637510
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
	linux-mm@kvack.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 07/10] mm/vmalloc: only flush the cache after the vmap succeeded
Date: Mon, 26 Oct 2026 16:03:26 +0800
Message-Id: <20261026080329.140244-8-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026080329.140244-1-hao.ge@linux.dev>
References: <20261026080329.140244-1-hao.ge@linux.dev>
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
 mm/vmalloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4d74144dfaff..96e15d6cfc6d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -359,11 +359,14 @@ int vmap_page_range(unsigned long addr, unsigned long end,
 
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
-	flush_cache_vmap(addr, end);
 	if (!err)
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
 					       ioremap_max_page_shift);
-	return err;
+	if (err)
+		return err;
+
+	flush_cache_vmap(addr, end);
+	return 0;
 }
 
 int ioremap_page_range(unsigned long addr, unsigned long end,
@@ -745,8 +748,11 @@ static int __vmap_pages_range(unsigned long addr, unsigned long end,
 	int err;
 
 	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
+	if (err)
+		return err;
+
 	flush_cache_vmap(addr, end);
-	return err;
+	return 0;
 }
 
 /**
-- 
2.25.1


