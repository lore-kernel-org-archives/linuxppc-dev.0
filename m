Return-Path: <linuxppc-dev+bounces-21877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF161CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66Z2zxFz2yb9;
	Tue, 02 Jun 2026 20:11:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395062;
	cv=none; b=FmdObxqjpt5SXeRZF9qJJTstBMdqk6yFpzuFnkbiwr7fVPm38XUtKEY7RATLdkr0MWagFcHu1B3RWnZRe7TluUAFe7Bw+mcMnCc7+asrP62+Ul5Zo7n0wQZMyD1S0i5kwMc20fxSuYI7H/WUuzSLGgSW4OxuLrZIiG7vgz/9iVn/lzo94KK1pVNkbZL8/qCMh/Zf/dNy7KOGgm83SoPx71X/zicv7CEVm+B7kkGZSicmLsUSIn4rGqw7nvWjAEThCtGLLKLvWQVAKMevqrA3q4Ffq4dC1+KD0WwlpA+4NVtYe2NItA+ZSdEoTZfT79PipRva17M9wXR50pIg8vKnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395062; c=relaxed/relaxed;
	bh=aE8gFeezLetNlZxC9KnzUv4webDUXLM7puFdMIz+EH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nof8h1bQJIzLzH+abx6jdMdSipOFVgpPyLZfQ6/xn61Cq+S7Xpv4ZnGV1zWHuDzcCwgXzlLecu2neiQdWmGYcxvGLfrB+EHxS82IAn5QoOjvCZdpzwovDKsnFTxwz9UghgZs5D18O7h5HMVtG1NK/68ua45uXfORBGA0qG0jArf58HjSigqAj1CezJyjArRbDbZJy4jxMtYsns4/l+fJlH+8RvRlzSzUcnUk43xhEbulsiEW4xmi8OadrEUdAb9JUYx2KtERqWFlZE88+DJnuyV4uoP6mJS04VXQpD1XB0wh/ASdibi+RaK1z8C4WvT663rOwkrQloq4udaSBTJFkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=l430NkFG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=l430NkFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66Y4lX2z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:01 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8423f869421so1673922b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395060; x=1780999860; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE8gFeezLetNlZxC9KnzUv4webDUXLM7puFdMIz+EH0=;
        b=l430NkFGcFUfh2I0Wy6Ui+HzvCQK9hnEvOXptXcG8VG+Io+8t+hTrb73OQtM94NGho
         nGiDsHEavFa9LDsS2A4Jdbyhds89CQszQqFmRHfwNem66Zzil7yJV8s6/PR4MZ5g7bSs
         r2dkRnKHrXxqxLfvDrkRoAYW/Am8sCNDxHU0d3cHpaKVWWQzT/2PXN9Ds1ktwGXtxKHe
         WGH2EAQ55w3Jmvb4ewdj5BJqGwBUAHxckE2MOwetTiw0Jl8QK5FFn+bGxHAA/TSqvkX3
         9SBt7wFPwHJpEtqaY9KODnsCh8RDdl6u/XRPAPLackmM87cSADr4GjcHlqlmcqAhuOsR
         yVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395060; x=1780999860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aE8gFeezLetNlZxC9KnzUv4webDUXLM7puFdMIz+EH0=;
        b=f/+Rxp2rq16/2YH0VEHOeDW5beMdUpA/VPTUDlWRUCmYMZNqwrFpS9kiWhdRQr+mX9
         e3tMBvKvWDCrd8534pGxl9Qp4ri2tc9L3kfg6lJtW73SsHqniGrAW4ppW1i/sdg9NK8M
         iDmmy1gUZcIdqOwLnrxhduV2YYmDWPvsOZR0nszIfnZztaVHZWmTscDGrRv4o5bJ/i/v
         axXfzSOyq6UjonmLhxpTMyxGNnnUO+AWg96bmD6LmmMb62iv/90Uf1eh5tcdYJHhaPR5
         3h3X9PMz1OYsRVKbn24J5EgQ7XZVA/m87Ng7egiB1YF/Tut7o/O+Cy6V7ZI+3I3xFitQ
         ZlUw==
X-Forwarded-Encrypted: i=1; AFNElJ/bsHWP6VdMoDd80sFjQKjBSTL533mXMIjkfLJaOBASRO7VbEFvQBD5jBoxvFNVioBSelPUGLfx5NwShnQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQHSUMr2W3gOFZONPjsWDD9uv6cCUQ3STfBEWQgsKCI9LittpM
	cKBYmmSgq64BcP4wuv0pyd+5irzGfhkwa3a30dv5C6xfXucVxuF3cdl2HY6u/5fuv+4=
X-Gm-Gg: Acq92OEJO9NEWrs+Vp5ZoKazO0R+NIAQ6SvZc82odSSWypKFzshGINp5ESO38/e/DaK
	7tzx3lq8dWyQeCPfC5v7XmRQpIDo7F0KmLl2ex9PprAmRVSSwhFIK8Qa5xHiJIvVsWfGqWSQTXq
	Uz597QZ3GEQiHZeOgPNWJViewJOerY0zyKitSiVHcRPWC9gBlwgtV+C9ETVYvCXLnTwuPkOk3jJ
	XkphISbuO3GCdXpADTrDksHtKuSQD693Vuu6B61L+lQxkYNtrCnfOQzpTjH3x7a732zycGzZ+WV
	vV1UHAsPkPCGkW0Vl3DIy/I8Yks5TiAZh3F4xVSBvzuyvuh4x6hfcplcHzyFrUECqGhVmoLUMwF
	GGNvUZ5nsqsj2iH72dwsX4lp/Uh+vR8nqgb7NL4jERVd2IdzeF9A/u8EP1hB3OctKO1WyNZCGRi
	Aw2jJc5C81ZDAuW8VSWRzeSviNYl/3gqdmU0yFZW2pG0kwSvNj372nouY=
X-Received: by 2002:a05:6a00:1ad4:b0:842:5d9b:d590 with SMTP id d2e1a72fcca58-8425d9bd996mr6238843b3a.30.1780395059676;
        Tue, 02 Jun 2026 03:10:59 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:10:59 -0700 (PDT)
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
Subject: [PATCH v3 02/19] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
Date: Tue,  2 Jun 2026 18:10:22 +0800
Message-ID: <20260602101039.1867613-3-songmuchun@bytedance.com>
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
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- collect Acked-by from Oscar Salvador
---
 mm/hugetlb_vmemmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c713c0d2593a..ea6af85bfec1 100644
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


