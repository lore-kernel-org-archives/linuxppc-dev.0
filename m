Return-Path: <linuxppc-dev+bounces-21878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B35CD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66g4TFPz2ysb;
	Tue, 02 Jun 2026 20:11:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395067;
	cv=none; b=mevitmdE8bXvj1urrq/2cOGObfcD7j4JzfnjxGKFhAaZWvdsv0/E9JpHO7yhDXMMMFvMHhzOid+vrac7vg2AGGGyw01p50LZwjRugfnXbutG9wOeh+2b1uepnl8u1Z8XXiDW75iarN6VI/sxmlDcvI4wJkvY+L3p8MW6904AvWX5eIx2c0Onmw05JW1r2Jm5zawidHHz0BYlKswwWBABFNBdas29KhiCcJQy5o1g0JSdyxeXLjnVNlDmZ1+0D0+N7JjOghHZNazwCB9Y/Lebu6QXdsKrWNTEP/BTy5JAtA95U3EGI4/TYMD2OX2TtB5z7LvodOqyMCoqTVP7e67BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395067; c=relaxed/relaxed;
	bh=Y0lfog+XMb7vxf8z5NRAN8W4fHvuXnUL6M7vrh2PtXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bml/3qPjdNtjymNrTzKOJ4l6tHEMKGjCUY8TR5dXRNBWKy3Pa/q1OR7MTJ1GogMn84c0Xvlagy4s/NZbm+S2dRnkFhVseivlqa/lqCuchryX+6qoJwL2gkPutl05EOXIXAfwBu+PgMlJFKvtv7RFt7wq/3HSkt0tnGSZapraBZRdh6dIzCJkiCFZKi+U5lFytQ8Qub09TO5dRg76w2iIZZkoGqNXsZ3cWLZS7Zjb5UV/7/vr/SloIoNrx+vOHLgnbB+1SNeJcvbizsU1vV/L684NJyH7YD0qaeVsVDLCyaNrWAIW6fHc/xLTwgU02wWWF8IjpC5O3XfVetCwMGYfmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=J3Xb5qTg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=J3Xb5qTg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66f6s29z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:06 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8423f1d8902so843652b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395065; x=1780999865; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lfog+XMb7vxf8z5NRAN8W4fHvuXnUL6M7vrh2PtXs=;
        b=J3Xb5qTgChu1Hk4bQMVq6wBfDIIlVEkseg2jqoOQZZYGmNO6r9H11vV4DxI8CxU5jr
         w6r57IAKi0JY+T7nqC4dJ7GkTBNQYQtq3JUa09Ivla45mV3EvwTOk/TI7SGI34BINeQq
         Cd2CehzgQOH2OyFnbAeDGM/DjZFo/8nL5z6C9piNARoKe4uqGfsau/WWpcn489r/5WPq
         q7jfXYvjQ/LgcjrzLKz62m/3gdJyz5IWbvzlhIaD5OHUodfIbK2iQjEW/25Ms5NyHQJo
         sJQJv3u9WzpxKxpsXcq65XqS/wJb4ulMi2h9igksQHIUat0o6XnQnybLy/e5/74yyjVw
         mIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395065; x=1780999865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0lfog+XMb7vxf8z5NRAN8W4fHvuXnUL6M7vrh2PtXs=;
        b=UCY4PhoQfY7E7kuVaDN8FqEZFrq6goEN4ogCFVLPbxO3hycx3LC1WKZNxbVn7ljFjC
         synOUT3PCbrCqn7PfOtxvS4TAOu5Z6Pk+Rd9TAwjAQro75Mh4pvrRT4MO2QamZJVLMRw
         wc1pqUc0G4jivqJaz8JdGZ9fP09yqGJCJcg+/vzm0R7Vs6AfSKUWKD5jD0KKk16Lx+xS
         Fixrb5hgy/Zlvug48zg6bRNY2ikjtHTMUfNT/pl0UoHBMbj+qX9CMnqFWFXD9XDVxGRa
         DsT/k4uUAin3fNGCvHm/NT1i9/zuY9s/pFaU+FkveB+6gFEAbStVE3RcT8GGMvZBqcno
         F9IA==
X-Forwarded-Encrypted: i=1; AFNElJ92CuQoCvnwI7D1mpBt4SNRWjZGfzyLWKUuXb/dE9DMU4PmskVodWlvygUINkmFnSqv6uBmh7xAUz3lz2U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZ6bE0wMlydSBMuHDWUsDOiDhEXTH9yY7BJxBrXmxhJ9k6iehf
	3WAN3rwnLBpXvcdbyBZ9Huv5wWXCZedzFK9TImCZgJ894YQ5HEGBRPjBMIlLL6J1T1M=
X-Gm-Gg: Acq92OEwpeU8+4IrtRdzALeS6n7XZZqZfGpIJ4ZcRM+TJC4YfDEYgUGW1NA785UwoDz
	CD4B0MmB09Z/5iaYxy9MfDdj4IM6awajws0Y6pJDnU4obO6XbWZaIwpwEte6wxk2Fm99ALr1H+a
	Gz8dWu9b0U0TNoPmMAVGnqNLzG+TuxEL6thSvtRcUN8GrG6w/7P6xcB6bo8tmMVUqUKrMTlhWbS
	o5GcsFFrqLNn6eIWDtIoOjSt+PWtwCUiIGFyY9/caP5vZ5+tBhLKd3sNC2zyyITkjh7uHNxFOIM
	dQjVpgfZWCUpT+4oTNDs0ZkCcFsQdHopkz+2SG5WhAGqH3Z7snjc3jkhIjBjN7qeDhL+C2E83kC
	wwRLI4SmVQ8efL7noy21iEQPOX8NZGkdjggUKYrw1ktJnHOUmPTrbqBrBjJmQfV/FIrEsNZaNTl
	JE1xzdkZaCGFc0aEKwiqpz1Tf2Ihm/WlD5uXOkLD+7oLlnqLQ7MqwHk1s=
X-Received: by 2002:a05:6a00:1a86:b0:83a:7565:3505 with SMTP id d2e1a72fcca58-842253d0cb1mr14807615b3a.8.1780395064752;
        Tue, 02 Jun 2026 03:11:04 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:04 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 03/19] powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
Date: Tue,  2 Jun 2026 18:10:23 +0800
Message-ID: <20260602101039.1867613-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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

vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
offset within a compound page and to decide whether the current
vmemmap slot should be populated as a head page mapping or should reuse
a tail page mapping.

However, addr_pfn is advanced manually in parallel with addr.  The loop
itself progresses in vmemmap address space, so each PAGE_SIZE step in
addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
addr_pfn is compared against nr_pages in data-PFN units, it should
advance by the same number of PFNs.  The existing manual increments do
not match that and therefore do not reliably track the PFN
corresponding to the current addr.

As a result, pfn_offset can be computed from the wrong PFN and the code
can make the head/tail decision for the wrong compound-page position.

Fix this by deriving addr_pfn directly from the current vmemmap address
instead of carrying it as loop state.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- collect Acked-by from Oscar Salvador
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 10aced261cff..cf692b2b5f7b 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1314,7 +1314,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	 * covering out both edges.
 	 */
 	unsigned long addr;
-	unsigned long addr_pfn = start_pfn;
 	unsigned long next;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1335,7 +1334,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
 			/* existing huge mapping. Skip the range */
-			addr_pfn += (PMD_SIZE >> PAGE_SHIFT);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}
@@ -1348,11 +1346,11 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			 * page whose VMEMMAP_RESERVE_NR pages were mapped and
 			 * this request fall in those pages.
 			 */
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
 			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
 			pte_t *tail_page_pte;
 
@@ -1376,7 +1374,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				if (!pte)
 					return -ENOMEM;
 
-				addr_pfn += 2;
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
@@ -1392,7 +1389,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				addr_pfn += 1;
 				next = addr + PAGE_SIZE;
 				continue;
 			}
@@ -1402,7 +1398,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		}
-- 
2.54.0


