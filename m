Return-Path: <linuxppc-dev+bounces-20864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC42CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv162snRz2yNn;
	Wed, 13 May 2026 23:08:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677738;
	cv=none; b=VLzGb7m1pt0CVKyJ5RzdqNvrBKJ6uIJGvIZnCa3et+zMOtSqTssevEX3riFNrlbJL20DnXL3uLT2h71ik0egHyU+GXNx6rbRYl5Jy9S3raJMMGT+r+jtwffyEPnbD1ViC9LZdn8X9Mi13l9WF/nUa0+/m+CASyM0WBy5aSwXQZ79WQQEROuZvzdjdNToxmcYGiZYhNYuy5of14YoiT+eLCmpKrhBsWTNL9SvHfi2AEY0Pmzi9+EeFpVAqyOqoLqE9mKI8sLAQ8d2lQhSUjRJQki1qX3g+vwhksxDTgGjYRF9QRm2kOew/9JlLM/1fPteUIR0v9mUcj0XlB4z0vfmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677738; c=relaxed/relaxed;
	bh=NFXyqH1Cou6po67hW+Tbj9/tmuAtnCuDUU0al6ZhZaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6n27XHLhtbj/OGCQVOHWO/fsmEvqgv35DhWUw62CwDAY7eicgiVo2dlkezyePHrq6As4p1Gu4sO+6/hiuFbfgkj9piBfs8t9edUdEalB9eHw5UT6TYqUBLJ5UHoBHRdJvugMw8YgExXWlCXJLAGih0kbfEmnuigR67sw+ZaegHIYE2s5J9C5NHzXCokJaSDNskWdbp/I2O2rCFiEuiaAjDE81WomtEnZX1kc8HBwIz1ZlWOeO7bBzvPv59ePN1celU68DWv9cwMnDWNNy737RgZd47b+iMcy3Cm2gMU+9zKF4/VRw7m8koLviBNwrDeqSqjYk60aOQLSWKoKb0KqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lypCB+y3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lypCB+y3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv154Z8Lz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:57 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so5416304a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677736; x=1779282536; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFXyqH1Cou6po67hW+Tbj9/tmuAtnCuDUU0al6ZhZaU=;
        b=lypCB+y3tE4naiwjbjdYlG+VKasfDGJkqnnGeB6QlSB9nRhtqi2OK1HLKHdrlIL/l8
         DygHwwufWPbQLUwDEBLzJ0iuDOH27b+oxrgYcK/DX1vgrU7eFFGf7U619T5IEws6s501
         gApbM9bziOXdNeCVkEeZnWd3evWlM1rNT3G8e2ZkqcQ2yPpiBDkAo8FLrJseA8HQrE+Z
         Zc1Eum4nhPoxpKxU3PQvZnjipg6NqpaY527LITsf/az6gKbet9cbOA4rblLd1wlTwj0O
         q/6gyAuvEQ87xiRc+rWFKFShiFcJcrr/ECAfhcRZITF4Wpl37sadRAx7pLp09OCo2Dkb
         GgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677736; x=1779282536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFXyqH1Cou6po67hW+Tbj9/tmuAtnCuDUU0al6ZhZaU=;
        b=hPF+1Ltl8CD0GOs6dt51nsWpvXDhLpGb9RVI+g+TWldf2opITm+kxGPQAfD+jk6CvF
         FwCEuUqXFOzUrW/otCI1tD79aP3bhyXKrdCAqgv5RHl5tjSr9uVnBL6Bte1fY5i2Zrm/
         TuFX3X4avkcFYpyiLpSfXyM1zSunsFYVPUe3HIi+cuwUKPMSGeYop6oW4joGvK3mNoer
         CL+qRyH8tIVXqgOv5wKRYCjC6S+tjMbkp/R7ED+AriAiMIbhnvfKNoqv7+V3MX91ZJrZ
         +KD9Wz6xSvGxg92lyYupqu7de6AzqENbTEd38g05q45lxjoPxJ+6+qWyo/mWmypTjpOx
         nphw==
X-Forwarded-Encrypted: i=1; AFNElJ8VZ1peo92Z3JC/v7458WnX3cWShe5r2Up29jSmP4KAIeeQFYAovOzEqurKtkBRlfIFRmi8KMURy43fk9k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSdTLA6vUTt0XVzUworErji2MkP1wqz1QV83G839lkvNsSHslI
	ivvi4ajLwgrVA6MlrAcSSOpfvZxM22IUoTLiDG+IhUi614lKnqk3URg3nLwEWxjCr5c=
X-Gm-Gg: Acq92OFS7F4nUTYwPxV3ya6Vxi8SAhn3c3X8S4itC95ozzlJklQZRb3ioYAdo/q0RK7
	SU47McPDZcNWTDEfKszgQu04gJIzefV3j4A3nM3h0R6PrcQpePKxEuozMNpxI59aLxHmS0e4iuZ
	SlU5c7BKJyV3HCX313WSpDcOXyNsWlWXAuhSR2QVkDYvgS4QNKS5IVnq55x42G1YBU1Go1y3jyZ
	R19GQLAZnTS1zYOLEUI1YHfPW7i7S+RMBnutRZ9jAegqicspbxU6Cda7OClTWJipttARZKec6D3
	WJkjYkzo//ZNbDuZ7+O1aqacTYuhvHgRR+ag9k/Cjs73HStMiDNVsAqy+pSmrcfd/fbD2h00q73
	CeRTVjk1bnNN1bpxKpjwxl/9GlYd8RO1MzUCKJCYXC8xpvrWTQKAZUp80Bj7RAPrmBAhr7+Vwlm
	a6Yyauh7Zz5XPStaAjD+JoCF3D40uSgZrIYxHvJGBdxCLBMQ4IZ/gAYsLiUEg=
X-Received: by 2002:a17:90a:d00e:b0:368:b724:6d53 with SMTP id 98e67ed59e1d1-368f398cc9dmr3518409a91.4.1778677735539;
        Wed, 13 May 2026 06:08:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:55 -0700 (PDT)
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
Subject: [PATCH v2 15/69] mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
Date: Wed, 13 May 2026 21:04:43 +0800
Message-ID: <20260513130542.35604-16-songmuchun@bytedance.com>
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

Bootmem HugeTLB pages currently defer HVO setup to
hugetlb_vmemmap_init_late(), because the optimization needs zone
information.

Now that zone initialization is available earlier, the bootmem HVO setup
can be done directly from hugetlb_vmemmap_init_early(). This lets
gigantic HugeTLB pages apply HVO as soon as they are allocated.

Bootmem gigantic pages that span multiple zones are now filtered out
when they are allocated, so the remaining bootmem gigantic pages seen by
later hugetlb initialization are already zone-valid. As a result,
hugetlb_vmemmap_init_late() no longer needs to handle bootmem HVO setup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 67 +++++++++-----------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4f58cd940f61..e2251bc47444 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -745,6 +745,8 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
 	return true;
 }
 
+static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
+
 /*
  * Initialize memmap section for a gigantic page, HVO-style.
  */
@@ -752,6 +754,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
 {
 	unsigned long psize, paddr, section_size;
 	unsigned long ns, i, pnum, pfn, nr_pages;
+	unsigned long start, end;
 	struct huge_bootmem_page *m = NULL;
 	void *map;
 
@@ -761,6 +764,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	section_size = (1UL << PA_SECTION_SHIFT);
 
 	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+		struct zone *zone;
+
 		if (!vmemmap_should_optimize_bootmem_page(m))
 			continue;
 
@@ -769,6 +774,14 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		paddr = virt_to_phys(m);
 		pfn = PHYS_PFN(paddr);
 		map = pfn_to_page(pfn);
+		start = (unsigned long)map;
+		end = start + hugetlb_vmemmap_size(m->hstate);
+		zone = pfn_to_zone(nid, pfn);
+
+		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
+					 zone, HUGETLB_VMEMMAP_RESERVE_SIZE))
+			panic("Failed to allocate memmap for HugeTLB page\n");
+		memmap_boot_pages_add(DIV_ROUND_UP(HUGETLB_VMEMMAP_RESERVE_SIZE, PAGE_SIZE));
 
 		pnum = pfn_to_section_nr(pfn);
 		ns = psize / section_size;
@@ -800,60 +813,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
 
 void __init hugetlb_vmemmap_init_late(int nid)
 {
-	struct huge_bootmem_page *m, *tm;
-	unsigned long phys, nr_pages, start, end;
-	unsigned long pfn, nr_mmap;
-	struct zone *zone = NULL;
-	struct hstate *h;
-	void *map;
-
-	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return;
-
-	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
-		if (!(m->flags & HUGE_BOOTMEM_HVO))
-			continue;
-
-		phys = virt_to_phys(m);
-		h = m->hstate;
-		pfn = PHYS_PFN(phys);
-		nr_pages = pages_per_huge_page(h);
-		map = pfn_to_page(pfn);
-		start = (unsigned long)map;
-		end = start + nr_pages * sizeof(struct page);
-
-		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
-			/*
-			 * Oops, the hugetlb page spans multiple zones.
-			 * Remove it from the list, and populate it normally.
-			 */
-			list_del(&m->list);
-
-			vmemmap_populate(start, end, nid, NULL);
-			nr_mmap = end - start;
-			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-
-			memblock_phys_free(phys, huge_page_size(h));
-			continue;
-		}
-
-		if (!zone || !zone_spans_pfn(zone, pfn))
-			zone = pfn_to_zone(nid, pfn);
-		if (WARN_ON_ONCE(!zone))
-			continue;
-
-		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
-					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
-			/* Fallback if HVO population fails */
-			vmemmap_populate(start, end, nid, NULL);
-			nr_mmap = end - start;
-		} else {
-			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
-			nr_mmap = HUGETLB_VMEMMAP_RESERVE_SIZE;
-		}
-
-		memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-	}
 }
 #endif
 
-- 
2.54.0


