Return-Path: <linuxppc-dev+bounces-20712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11090CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhN31y3Tz2yD6;
	Tue, 12 May 2026 00:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508371;
	cv=none; b=a5E3SmDjZMB5ZFTF8apPoUc9/6bJVn+Ot0F2uVeP0yqcYwCCU1appg9mNhqEFoNpXfobYC/IBcpaD/rtCjWtsG009sWRbo2EbVtxheKaEDDwppsmajcP38OtDtwsa5FGvCS+9A7P4+FZ33LlwO2mPKg3yt/w54+TJr54FtWIhDtCDjpz9xIMntHfnpXnDjakySF1s+DuPh0vvtGF/YykE28lLuYP4cTyx7naj0cmZcC/Fue6OHqEWvTKH5GE3VaxSkA5adM3Ak5/x6gFL2z1zAaFJtBh2Thaj+k9+WxJh7WK2E7LMYv1htvZ1Am7pDJOxvnmSL7/+Xy3Amd3oynD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508371; c=relaxed/relaxed;
	bh=2mKTc398hqCNIyVV1mxRFzypz9k5PW9K0UCO/3rhqKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gs6TpyeuVSBOE+oC8xU5CeygU+E2iyEEvAtujPdmOXS67YdAtm7cqEht91QM5T2diuWsvYXMxJtLGf1EujZj9DE1pVSO+3jucffwElwttHZVUTLbtX0+Fteb6YmZmSSydhVGw5sr/8GlEUEkl/g6PUhydoUGnCYdEKTZRkbweSBtrjiookfGx/JQ8u4TTAWYB76pzdnWhFjqMG4tpffHuOzEsJu3aynFj1qRFvcdNz9ppEypgqdByWf8k+nNm47mb1JaQsWw/meZL1lreviEVa4dZ7hmzY4EfExZ4s8aXvKmOAI/ewBP/41VcwLct90EozXouB1ZJYAGMnCq8pwvxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FkHD5Qko; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FkHD5Qko;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhN24c3mz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:06:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9971560138;
	Mon, 11 May 2026 14:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3134C2BCB0;
	Mon, 11 May 2026 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508368;
	bh=Df7YQtlt1u58ew8l6Y3LcE6eBp8Ob9c95zjKPT1feMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FkHD5QkoYoiTQo6rsfptPtJyyjVmT203uCGrdm3RY3TRoKsGoRzuEBRzTLOM/MoDg
	 MayWcxnF91mKM6xXDqXD9sGLU9DDrFF/Wd0FcMZBhsbYliBwps+T+lJ6mRl4OaaReO
	 AlharA0hbNn+y6DBkFP+QQAyvIrUPUFzFmpPv9Aeut02HsJDMZ8DCG5+AYe4QiH1Jo
	 8RHEPoYqRTLWsqkE6/OR/o79ST9ZtLIw1kKnllAjVgvLKKr3BbYRA+dtRv8sj5b0ws
	 pNwKalE2Qqrlt/eCvy2KefMfl81e24Y17AgpykKyxL2jc/Kn4MflcxXJ6feg6RoApD
	 oitkf0c1mdkoQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:34 +0200
Subject: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as
 MIX_SECTION_INFO
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
Message-Id: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
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

We never free the ms->usage data for boot memory sections (see
section_deactivate()). And to identify whether ms->usage was allocated
from memblock, we simply identify it by looking at PG_reserved.

Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
Let's just stop doing that.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index cce1d560f094..0fa78db7fbc0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -38,10 +38,8 @@ void put_page_bootmem(struct page *page)
 
 static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
-	unsigned long mapsize, section_nr, i;
+	unsigned long section_nr;
 	struct mem_section *ms;
-	struct mem_section_usage *usage;
-	struct page *page;
 
 	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
 	section_nr = pfn_to_section_nr(start_pfn);
@@ -50,14 +48,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 	if (!preinited_vmemmap_section(ms))
 		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
 					     PAGES_PER_SECTION);
-
-	usage = ms->usage;
-	page = virt_to_page(usage);
-
-	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
-
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
 }
 
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat)

-- 
2.43.0


