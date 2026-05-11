Return-Path: <linuxppc-dev+bounces-20709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92A4CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMl5XQYz2y8F;
	Tue, 12 May 2026 00:05:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508355;
	cv=none; b=PWv9Tc3tBf/E/RQVWWDUgCkM6MZHmXZH4iYAreSd+iGtY9z5fwGGnTur1GfmbIrhkiy7M3zO/z3aFMQr8yoqyUa58TpuFqCxl+LyI8/n8OmMW5xieDaPGqWWjGJqQeGDvdkIgtEx+qwtK5zJHjxBe/PxgyII3MdeH52V+GKS3ZUX/hfAG3VNOKYaLXbroTi4nzvkjUi4uOTlOoEKrGI35/6BSHfcYKXOddcMUeYPrEvQxV37Hmh6e8OXkaFzV4/kGiCptD8x44PWazJY22nIvZgJl06VG2UNw9W5fIfBA5Zhb9JFV7rUC1g3KlviNCt4o5Dad3n/3A4ReyDFLkypVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508355; c=relaxed/relaxed;
	bh=ZC4r38RDJedpfkVWmxeFcuvQv0qCmJ9k9gsjGbbNczQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjRfdzSLMljNuMKohTYa4v1gZxhMQkWX3mAk0jkJqtlYtwtKO/KyebOJ4NzbF5QSDcCD3GZGJJeM0xbpVNi3OZ16Bu3T/LB0apZek4/+VLr86HkXRo8t6IQvDz70lUUjhUiuwbhaT33/A7TZQuXFv7yxRp+5bjuwtoH4RbH0dOwApMKQ0CJj5A9qp5O0dWHraZHP31MIJ3z1OdLT1ZdCdmVd+pcYyPN0xiXFm3OMPLyEOCVRddjKHHFaALuxfrJ7xKGpK6Q06/uEL8KEInT+PnICWFQUXoE0G5pT3bzD8+kQ77SZivS4tRNjRWEL5Xs8CQq+GZb3L4a6tR5QZfvnqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jFn6rc26; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jFn6rc26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMl1kJ0z2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:05:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B4C4140564;
	Mon, 11 May 2026 14:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2174AC2BCB0;
	Mon, 11 May 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508353;
	bh=/pOfZWbC9cprP4CiwJVpUWxqpXHz/aiDjfQglaSBebg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jFn6rc26M9OimLWckkvKk1AgDXLVRQ8KuE9cyARG9LjU74GLBScBL5ialIQnbM93F
	 woMLS+u4RhxAlTgupssA1sorXxYcum1WHRotK0UyqZjoAHHLvfS5PwOCqEMfqH2g8r
	 Cq6VkdIkThwjJBi6COurSnGP5bgL8ouiUkmuGTHsbRH4o4xgsR3kjwiycdRBvsBiO2
	 EqB5/uXejMTMhTCiE4a8cj5wkeQVQTyhoqboCovHIJmID6kpbkjYI8zq+oCBt75XsQ
	 4FAMUU+RPV64+1jg9eyDe2vR8+R3iYSWTAGj2PrJYzw8WeYR7XTO71JWBIFUgLxaAI
	 9DNXm86BpBjXA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:31 +0200
Subject: [PATCH 3/8] mm/bootmem_info: stop using PG_private
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
Message-Id: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
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

Nobody checks PG_private for these pages, and we can happily use
set_page_private() without setting PG_private. So let's just stop
setting/clearing PG_private.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index a0a1ecdec8d0..6e2aaab3dca9 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
 {
 	BUG_ON(type > 0xf);
 	BUG_ON(info > (ULONG_MAX >> 4));
-	SetPagePrivate(page);
 	set_page_private(page, info << 4 | type);
 	page_ref_inc(page);
 }
@@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
 
 	if (page_ref_dec_return(page) == 1) {
-		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);

-- 
2.43.0


