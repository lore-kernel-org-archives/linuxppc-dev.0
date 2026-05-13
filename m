Return-Path: <linuxppc-dev+bounces-20851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3519BCD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFtzk5qdvz2yQL;
	Wed, 13 May 2026 23:07:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677666;
	cv=none; b=VCcehzMLx8ss+HcMAyvHJs0tgV14p9S6l4m8aZpsSxXqJD2cNqB0vIC6GDeWKJNc7i5fPX5c75YFgByPjHeLw2ssXFOyaBpJvD5xP7OMLm1LOy/YmMyXChF9wfNzUnU7MeYgA8rKIaXjjJgIbRsxGQ6OegtG+X046PyOdwIjlTjGXXyTzZMb+baUbZ7B8E6cJllVJPKc5WRxn9ZOjXBonDuLgfE5skri05lRkQ9KZt9WKitPgjf6j3zbadfT4MUkgqrqzqZTFkWy5W7ObHp3P2CEIeWDyomwxHKo6ND9SYfhRLVjb9GE5NB2ZuHgtbYWy4TsLRVxxQL87MrarDVtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677666; c=relaxed/relaxed;
	bh=Bn/gOs/8i5hYCJdtJbGnpMg4EbzU/bTW8mznM7ekqW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUHXNH00BR0KfNJ+tf2cZjXiZ59aFGNCcJvXRLL/sABH/GmMzYxSQizE8fDDVL///uuZK/AutQfSbDo4eAhjuiZNP0j21J8+rvBw3Jrp0FwupNQK0RZ8Bp9WILf3EKT2f/pktaodO/QmTcjlRAlJIr298q6eOKLAqlrnNTS8lYVjJIHIxoJ9GKmu68aFKzwik843eojwfMZ4gAvt1NC9iqSSAj6hAKMCj3x1S3nZD8f0oa0ZdNeDbHTgX+iHLpas0V/DFQb3nSIRL82nqVnFWbvwtN52Jz6WJEhBxWwh8bIJpgNTtJzSdhh9lazi1tTdelD65o1H9zohQbnnOxuhQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PiEcvlXA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PiEcvlXA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFtzk1YWcz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:07:46 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso67430585ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677664; x=1779282464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn/gOs/8i5hYCJdtJbGnpMg4EbzU/bTW8mznM7ekqW8=;
        b=PiEcvlXALLFUcvqNzp90I1u0wOcGjPdF5v0js4mTdGti512Tx1J0A3faArhtoLXYfT
         bs5J0/voRvOsYrS3adaMJ3BC5qApb8ieSOqu73WC9JNrr/kTcLkzCySMKD///5d5wRDN
         3clJZF3ZiqJwe8Hv2g1xOd4tcsH2WaXlIEVbwUWtGx5cHL03aXjK+rvQ0rz+jJSaB769
         QQtr9ZRKZFMxTyFXNCAaos3Rs1WtgvofxVdPT2i4DAMioNuQqH6iQxoRvj1tF5PmoNXq
         CvKHUtJaOWc0xRnoXo83OORhw910o6MWuMWpzN+5UN29lnQOGr7T3Acm4tQK8NhIpVHu
         ZzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677664; x=1779282464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bn/gOs/8i5hYCJdtJbGnpMg4EbzU/bTW8mznM7ekqW8=;
        b=E16frLfBMGk2oxeNDs+Qfa5TpdWiIOeF0XEwPqUsJTHHHK+oR13fQVnOknEyVIooRl
         8FdCkfFGYsoU9g4rT8KwV8wyzcTeDcs7PvJ/uFN0jP4dGkmg6unkmaTor1nxd0bbAAry
         zjwnB1h2uHh6nR70A7Huv4E1Pw7r6/NOwz7uvQN2WRDGxEvW9U7EZbBvWG1o1FHcFgOw
         N9Xe3JY3LjWfflCvDxyxLMhyN/3JM3KoHBgldrTeH0eANzWJE4JB7GzKOB2JOisv5B0i
         TBU+uYrzZhkPvnAcw9YYEJOoaWKIDkuf/zNcQSV/ujKfOlQ8rT1b1ndW0F374CZTFPH0
         /8Qw==
X-Forwarded-Encrypted: i=1; AFNElJ/mIIChubq69ldO9r/HnA/gUTvtvaAqA6Min0juyO6kKdjSIqvEyx8kOLkZjj57y7/12rUWuJ17HDN3xmc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcxmKlDg1d/mhtaMuBihobHGkWXBu1Lygyuljqq/HsQvnMKHQa
	Td1UeGvHL1KeNgNNBKAGi1hObs5E1yA4Plx2wLASZgVDkunMZpVRzPsE/0/Q19bnChk=
X-Gm-Gg: Acq92OH86qqNaAaneI1+PuYLwHG18eU1jW1xAfVUKaXysD4PWT7vYS4NArMk6OGyP83
	o17L3EPZiTx57/BE3ijAdmgb3ekHDaLuJW5DdoJBZ7FUUSY8JsX44EIjptDRSnTu6LGKDCcLOmB
	IenTUjWvFfX7hA+zSmki7ZyzX8SvCyMvBP080F8e489rWa246oUb/47MJQ1Xcn/YpIuXdCOg36K
	E24KCB0L8qrNFB/+lG0A3u+8FDB+CYLyu1Z+SbILoBLrffknPyTKVGAtCynsNKfExDijniLpwf9
	KYjozRCzcVbhplm6ivvKyLnOVhogxf7x7wUNDPsXlSI91KiEGDJJ1QjCl5m+iXDHyDGEbK9Ki7R
	+EsSYGjQcXv4dARtqgbpRf1kB87VRCL/TPeafcBOkvu8//wOqMl18kKUow5anVsoGgjR/msnVAM
	Btn5Mw3XaWxHaZhiMxjlNYTaXVVWsy6wOUnQ57Bn6qgGnMF8LUsyQj3Xzf6AA=
X-Received: by 2002:a17:903:bcb:b0:2b9:cd2d:6f14 with SMTP id d9443c01a7336-2bd2f4f740fmr22511335ad.2.1778677663953;
        Wed, 13 May 2026 06:07:43 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:43 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 02/69] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
Date: Wed, 13 May 2026 21:04:30 +0800
Message-ID: <20260513130542.35604-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

__hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handling
bootmem HugeTLB folios.

The section number passed to register_page_bootmem_memmap() is derived from
the vmemmap virtual address of folio->page instead of the folio PFN, so the
bootmem memmap metadata can be registered against the wrong section. The
helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it expects a
page count, not a size in bytes. In addition, the write-protect range is
based on pages_per_huge_page(h), which does not cover the full HugeTLB
vmemmap area and can leave part of the shared tail vmemmap mapping writable.

Fix the section lookup to use folio_pfn(folio), use
HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages, and
use hugetlb_vmemmap_size(h) for the write-protect range.

Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 62e61af18c9a..4f58cd940f61 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -635,12 +635,12 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			 * mirrored tail page structs RO.
 			 */
 			spfn = (unsigned long)&folio->page;
-			epfn = spfn + pages_per_huge_page(h);
+			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
+			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 
-- 
2.54.0


