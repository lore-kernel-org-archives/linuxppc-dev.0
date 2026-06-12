Return-Path: <linuxppc-dev+bounces-22530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A2CCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:59:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5P76z6pz3brC;
	Fri, 12 Jun 2026 13:59:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236763;
	cv=none; b=PRt9Ws1xkoSOx5uEQQkMds3jKOB+AUEzhlL8DQ9e2NYNVCDEcUuS5WromcJIs1AOkc4qk9DNXzxUQpU2J6yHySoJTTwr06X7A+/kEtah32iHv+rMXZc52GdRwA/dQB6PAA2XfnBy6bsRi6fB1roWYzDnvZ3QFt8hdT7UAwmh1l2km9jENNYRnXsZB46CeHq8VI2MfNxBtsMfCxGx0JhncGT/GIEsrHmsA7197oQBhEBQaxQ143AClzNCo3B+CVqK4uBvoVkm9r6hCEX+17xh/dh/4Ib7H2gadI6SgX2XLIK10dYqv7+uiJClLU2XgW1EIl8umPL4mRPlizuAZfrKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236763; c=relaxed/relaxed;
	bh=GLckvYu5EL2MaiuWaMvOvK8C88YkCBw4frh2Emu1ze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGG/jAHeXEbSMqWuA86Aeb/w20D9NXOs86J2u6jBNrUVSb9quJD3KGO/T/y4HM+pqzm33mrz8eloq8yZyqOBtUUTMSfhyBhkbQsqTVc+7j8KAihahoYh5Rfpxx8LBpcCUzlkkjSZMuCmKn6pydvWNbRuyUMtHegd8mAyODR/tiysug7OE/kAtIEMCXnCjmb6XkX4HAercY+u1b6DOpFBMwSFHg+vXeMvi4ld3wvN/87F7slN9H+4EBMkNB8ln2Nlx8X1Wkqc1KYzkMl747VbTasJ9vbe4nizBUEYTSB5syVjkFwcpPWgljuNGiz6E+MlliL90uoIMvJ4gHFcXmDj2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eN9pVal2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eN9pVal2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5P71BTvz3btc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:23 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-842307473b5so454757b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236761; x=1781841561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLckvYu5EL2MaiuWaMvOvK8C88YkCBw4frh2Emu1ze4=;
        b=eN9pVal2IouKvSN261yfW+CbHfjML1H1SM+cJzpqOhm2NN7z5JfwoeUuamuVRWX6ZC
         VlcdyqL+P8NROAg8bAmvRiLb+izla03pb5dJwWD4XCjgujTI13+Vm5KoRmYRGswgjED3
         aKdW48+k4goghQn5QTLcsLYGPYPIJ4foJz3EOLs4O+qs9opSBsiX54Npm1ZTMkxjO3Ww
         lcVzmx2HtMRfNVw/TSiiIBwEJ0QmVcL48hFo7IF81gqajaaTkFk5lmlvMWQyKrFb3XYs
         rAcH6uxl5MZuHXBu4f27UmMVZ5/VlLoi4YMSo4jedlnzt1m/0lrjFg2wrmJiHQdepgi2
         LZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236761; x=1781841561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLckvYu5EL2MaiuWaMvOvK8C88YkCBw4frh2Emu1ze4=;
        b=fOJQlM1cWN+74RDtfmC9VafTlStElzuotT1bFsIlcScmRnIKEh7eBiZFWBZ3JkCZp9
         9br7zCcoz/Jd99M7p3L7gO0YFtxedLSJIM0lroStOMuF2VsK6wmfRXDWvOV+JJjDQpv/
         pK3VXgfDEu2Au/yVhKbjtsCZom9+dpN/z2pHP+nOo5SQ6i/hftPAghfqjVhTs/G+ki0u
         8RCtUGNyhCUl6Fi9NeoCHVFBdwl9qEY/DyUrLSe/dP7ybwCoIJc7Ot3vNmjAnyh9NPTs
         +IAUn9LjMhvTQHXqfLm6IpDh44vO2xsrwLXcMBhsnn7cwHqe9nP84hgmKBgLQgcIpSu1
         5HRA==
X-Forwarded-Encrypted: i=1; AFNElJ+ztOgKvOJLyRKzi9I8GZtT4PhikYx8BPtZLtFo63USkmCTPuedAr5BTfStbAyii8zdOiNHrXLgOFWl8XA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxS5Zp+P+69lFv0bB0Y57mmPXVjaccL22fXHbl7Q+hVFzPm5i1
	wwWqDLFY9eB+Zi4fZQwCU6fM+RPsay77I3pv7+4w4HjWMU8rLuYFMlWBaulJlc60y60=
X-Gm-Gg: Acq92OGXG6o3Ud/5advgdJPSiRNXJFTs7EjX4cSxG4yeV2kURf9vZy8/YaIyanz/2SD
	OmEXwwBooZxVMk0twLN6Ldwg00bQAE2oIC/Gv/G1OXPYkvO7MYXN8062WUN30a0+mCnHvVWSmEL
	gzUC35J1ECIMqbxKR1aebLl6PblLx7eBVuvfLb8He9JAV2Ocy9Gf50YFLHFPNv7SP2tJ6jbw422
	v5HjFIzlToH42OQWltYdVDbZqQHAn7DF5svS8iv1cWqYK2x7u+qO4ApuAblvkzFm+YdnQG45Ae5
	1062/aeV/kTasrNKHDXJanheFvzbDaLKRVx+CbZcgarhANCwF9yg8yZTmXk/QOo3gpWpTOYaYop
	Yf+XhYqbWKsqkXDU2oMmoz9bO/hcD8VvKIcxFV8PVLFCsN12dGwKUCdNV/PPLu4wHBQrrsbSxCW
	TqfdlyF3PWnHp/0WmVG7s6f3fURZClxX6dnAW/xrhyLL8=
X-Received: by 2002:a05:6a00:2d19:b0:842:4f49:71bc with SMTP id d2e1a72fcca58-8434cecab4dmr1092576b3a.46.1781236761177;
        Thu, 11 Jun 2026 20:59:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:20 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/19] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
Date: Fri, 12 Jun 2026 11:58:46 +0800
Message-ID: <20260612035903.2468601-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
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


