Return-Path: <linuxppc-dev+bounces-20711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4516BCD484A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMy139Qz2yCL;
	Tue, 12 May 2026 00:06:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508366;
	cv=none; b=VvIJEFeNof6iEgvDSMB8omn+cWLtt1HrJN1g7fnABr4Klfn5GKoWozHpJuFBzJdu9eZPzP5y9Qm4kjfTRl0JMlfRxor/ZhcfSjpmwh0ZWYcXAihv0WUY5CyY9Hdnt5LQiJsRjArhRD6NaA8i2g2ZLEqC3UbScFgtaTrtoexItyJCVv7T0xb7Vvc35q7Qri+STFShhsB7DAL4qj0CBCNY3rvH1ThQKi/Qu7OtAgeQxdtJjYFj0l1HF3E7GK9sznPSgkfY294Y+3QyewP2D/OsRoKHRZ8pZy7Ai3zyPJS0jhinijsEyaj6DeBNIDhnAKzP6/G6tI7YuGOvUuD08ScLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508366; c=relaxed/relaxed;
	bh=9Hxie3l6GF/3E3owdSqmOU0xCneMvVXO4cvVixoG97o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkumjDeD6ElRf4Yc0Jrhfc3hlmKnLVIB/nk4Be31SaL86De1jNddcXxMnb1wskqwiCTFKUJR3Yy8Cyg5ZZ3RsYRdf1LRrsm2mDfMnd6dh9+HtZoUwP7ugmXs8gx37/ZSMqsaUo8DObXG1nFcMDx+vMSYniO8PWPdm2Nb8l7K26G8+E2djL3ZrtSaGDEtG33tgZYfJtDbBL+h+L2rvW/OlQ9XBO3o69CjTbpPTXunuMOBp1HbJAJ6WpXIBm/nnzrvv2kEDcJB9WOUzCHGsCxaahvuLmBW6ahCzlTxsNZYyUJIXucTAfTZxD/HwbY4U0On5EFdOP2EcydDLu/6RF38mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VzzaUGht; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VzzaUGht;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMx3hZdz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:06:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83DC443768;
	Mon, 11 May 2026 14:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A89C2BCC9;
	Mon, 11 May 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508363;
	bh=MFrlSNsTp04kT+A7ReVQ6q1RUJiMOyuWN+whgS79KCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VzzaUGhtjmv+hgICpWb9Ds9RkOduoJ8mQ0Y/DcgBVY2dFaaRVfcVxiN2SbUKQuwiL
	 o7eRr+5Toxr4lABnCNoOTIMMN4aJ7fOgqOVvyGtkdg6QrUqs7rUeaGOqi3u1nVPDkg
	 Ksz0MxzCsMSNEnnyFYKhliTDT4hT3Njg5ZT2r8cMD3/8wzL/mBhdvfWXpE7D+1LW98
	 rN7lvX13lEtdJbla8okiBqaGSKrxpTp5HtBwVqWJp27YyraoMyd04koJ5hVKbMZSfn
	 dFRNDUbp6ZtPNR/BNeg+D8gkJkfsmTb8oqE4KzJl4JXpHPBQHLEyE3u3AiI6BbVR9e
	 ixKjUMbFwUVSQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:33 +0200
Subject: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").

But it really was never used it besides for safety-checks ever since it was
introduced in commit 04753278769f ("memory hotplug: register section/node
id to free"), where we had the comment:

	5) The node information like pgdat has similar issues. But, this
	   will be able to be solved too by this.
	   (Not implemented yet, but, remembering node id in the pages.)

Of course, that never happened, and we are not planning on freeing the
node data (pgdat/pglist_data), during memory hotunplug.

So let's just stop marking the pgdat as NODE_INFO.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 74c1116626c8..cce1d560f094 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-	unsigned long i, pfn, end_pfn, nr_pages;
+	unsigned long pfn, end_pfn;
 	int node = pgdat->node_id;
-	struct page *page;
-
-	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
-	page = virt_to_page(pgdat);
-
-	for (i = 0; i < nr_pages; i++, page++)
-		get_page_bootmem(node, page, NODE_INFO);
 
 	pfn = pgdat->node_start_pfn;
 	end_pfn = pgdat_end_pfn(pgdat);

-- 
2.43.0


