Return-Path: <linuxppc-dev+bounces-19339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE0DF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTq1HpJz2yps;
	Sun, 05 Apr 2026 22:54:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393663;
	cv=none; b=fwrCuM/QH+WT/Bi8eRGmzX+3Vo02I4UWb+kTKC5S0h82QYfanVKwfPhGvmKqKc69WmsP18YJrG7sboVeoq8bP/gtaC3XOMpDnIvdxcA9+8VKpZUqQLEFUnMUwySNVwXvi7695EOn53L0/o6bXXV4dHIydqwf8OCPj5rK0ErDQiaT/VAJCbyLaeTqWm9D6u38iJjfgmr+Rf0DVmJvJpOh7H7kaq5sCEEU3J3qRyAvGOkSo+rPjnCa9merabYm+2VrbmcPSKYbZjnb7JXDEpJES8I8bWB3cpYm/0++0IfeBAUs7d9gfXjQc5L3DjSTdHUnK9q4To0Cx1ODVqnhWeEW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393663; c=relaxed/relaxed;
	bh=32+AkcMilp9VVAfduQufKDvkeOaHLrnbBWuUoleVhXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5e1/EU/knnr7CMucccnY5SdTWXyLAk5GqaQoGbbmadOmqmmmiMwN5gvWj1sa0AG6B3ugqiAtoCjbcU1qDhTbId40r6+1b8TmlrL1KKBqWvwe4AVmossBApnCUm7LYmm2zu1wf2CGh0j42vPqCMFgMBr5MKffmLosoanz9/AHyPWxSnGLglp+At0N4dHONn0Vx8IkElp1kBe+atNCcnYxa32TGijE9C/+ln01VH9uRKIJ3aljvoC7FRY5MQFp0wVnjME/Wp01jXWgFd871sdfBpe4vGD4E5k0MUkvAWs/PDwMfCL9tXAn4umO38UtMdjbhTDjWVpxtXCfLgLC3DjBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U8lAvZWk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U8lAvZWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTp3c6sz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:22 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2818413a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393660; x=1775998460; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32+AkcMilp9VVAfduQufKDvkeOaHLrnbBWuUoleVhXI=;
        b=U8lAvZWkPlKJOA8h/bUUhtssi8mbm9l1sA7qAb/3pyk6iosCcC7G9inqNsB6jkN5gQ
         dqCtcYkVZsTDf3UDdI7qE1La9nC2Ce4hmmMOAoEDAJYNah8fJ/JO9nuqNwFNLLSC5CQa
         uBwrI+sxuVfIq708liMMIWmFkpw1VLSpbi7d9+vFNqmDCg/g9Xjunw/LdjiVWTFY6gFN
         gFiWS0QoZ4fSuidXM5DYTKRVMiR0oaWzWNGjm8EOCcjd3zSgJrP2ImY5yd30ii93cMXJ
         1vGC0bgJQDFu3HnbrtDmm02RtIxvw4TJRUJZ15IdX16fwzZaD1KM43obRPmho/BGeKzk
         McGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393660; x=1775998460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32+AkcMilp9VVAfduQufKDvkeOaHLrnbBWuUoleVhXI=;
        b=Gi8hCQqcTF19SgqAa3xxMzxeKxKk8IJZewzczV9cZAx0nD/eQcR8nTycBJVC28eHS8
         5u38p7wILiRbjA6AglQne4pLwy429papJclko+RXvNI17Po7fx4xncnVyQ++USMdqJz9
         AY7zKxZvVPgMdDFaJCcfJtPfhnw4pR0wNApHnCIsYlH3t0wqUeOmdKeVNN1UPGdEnYPe
         9hGzLmNhONAMR9hjeKcxiioTaVWt+a+x7TDcyfcgR5rPd/l+rT/yCUkjRqJkW67OKxjL
         QkOxT+xPTWYCI0T5/ky/xbMrEHpBYvvrY4TcJ5zNyME3WoLxzEzskJFvCFIcE8UuTRf7
         8cxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX328+vTKSvMQDO6dnqkrDiOxk2/9VeBr3NsGRUrb0ZWR7SvL6QBisnCcyhIomkW1ZqRqf+tFW2bu5lpuc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyw3xbmoauWoW0p/7qwVpYbNt1wJcO/98F/1V1Z5x9jzOlqqlw/
	wh48jXoZizdxlwKtkU1WYwea6Mv0CPsCfHZ6MtbrHxnKxX+Hcg+8rUBBcIpTSRauRXU=
X-Gm-Gg: AeBDiesiiD3wjdH6y3qjWr1BARvjo5m5cbc5Uu91jU//5Papg97n4WACQEOfLB5IDwb
	id+cDj6LmnUnQymB5EAeu+OM3ZfAxGjkOuB5KZgMhMm/w3eZ5aWs3s00+eqOS70xCNLT5xXBqUT
	ZiMnig35NfrNH3qZpp3i8zBcenjJz5wI487L8fOKCR7ASH9Zhk7yzOjHEc8jOtTKgLLg8rb1u58
	a0P09pGrRzW1UDQ/rc8mromPNLpii6jaESR+myBxES8V5rzcib81mZJZ1gjsrzpAMv/v4Yq9D+p
	EFG0u93MM2+Uziti9E0kvHbEMzbGgnDniGU4xl9UxyrbQtHXJnLp0sM3k47pRNjNyIfU4ayinos
	4yjtNNz/V54FHSWm1zZRCR0OspBengI7Bmx1yyKcyfOPh4RGzkKxkd7SUrfe/tmSjYL3LMQ7t6F
	90FXdOsszMMGM0PefkV8f9+UOvGiZFizAQVK7TFqfoy8k=
X-Received: by 2002:a17:90b:5111:b0:35d:93ff:2855 with SMTP id 98e67ed59e1d1-35de67eba6amr8915799a91.8.1775393660266;
        Sun, 05 Apr 2026 05:54:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:19 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 09/49] mm: panic on memory allocation failure in sparse_init_nid()
Date: Sun,  5 Apr 2026 20:52:00 +0800
Message-Id: <20260405125240.2558577-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

When vmemmap pages allocation or usemap allocation fails, sparse_init_nid()
currently only marks the corresponding section as non-present. However,
subsequent code like memmap_init() iterating over PFNs does not check for
non-present sections, leading to invalid memory access (additional,
subsection_map_init() accessing the unallocated usemap as well).

It is complex to audit and fix all boot-time PFN iterators to handle these
partially initialized sections correctly. Since vmemmap and usemap allocation
failures are extremely rare during early boot, the more appropriate approach
is to expose the problem as early as possible.

Therefore, use BUG_ON() to panic immediately if allocation fails, instead of
attempting a partial recovery that leads to obscure crashes later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index effdac6b0ab1..5c12b979a618 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				   unsigned long map_count)
 {
 	unsigned long pnum;
-	struct page *map;
-	struct mem_section *ms;
-
-	if (sparse_usage_init(nid, map_count)) {
-		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
-		goto failed;
-	}
 
+	if (sparse_usage_init(nid, map_count))
+		panic("The node[%d] usemap allocation failed\n", nid);
 	sparse_buffer_init(map_count * section_map_size(), nid);
 
 	sparse_vmemmap_init_nid_early(nid);
 
 	for_each_present_section_nr(pnum_begin, pnum) {
+		struct mem_section *ms;
 		unsigned long pfn = section_nr_to_pfn(pnum);
 
 		if (pnum >= pnum_end)
@@ -374,16 +370,12 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 
 		ms = __nr_to_section(pnum);
 		if (!preinited_vmemmap_section(ms)) {
+			struct page *map;
+
 			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-					nid, NULL, NULL);
-			if (!map) {
-				pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
-				       __func__, nid);
-				pnum_begin = pnum;
-				sparse_usage_fini();
-				sparse_buffer_fini();
-				goto failed;
-			}
+							nid, NULL, NULL);
+			if (!map)
+				panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
 			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
 							   PAGE_SIZE));
 			sparse_init_early_section(nid, map, pnum, 0);
@@ -391,19 +383,6 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 	sparse_usage_fini();
 	sparse_buffer_fini();
-	return;
-failed:
-	/*
-	 * We failed to allocate, mark all the following pnums as not present,
-	 * except the ones already initialized earlier.
-	 */
-	for_each_present_section_nr(pnum_begin, pnum) {
-		if (pnum >= pnum_end)
-			break;
-		ms = __nr_to_section(pnum);
-		if (!preinited_vmemmap_section(ms))
-			ms->section_mem_map = 0;
-	}
 }
 
 /*
-- 
2.20.1


