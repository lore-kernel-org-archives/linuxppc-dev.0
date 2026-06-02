Return-Path: <linuxppc-dev+bounces-21876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6170CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66T20zHz3br2;
	Tue, 02 Jun 2026 20:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395057;
	cv=none; b=TK+v+el3HF4tqFpgT3sE7aIyZ0xxSW9CDdTN4QWGNAZ5B7xozMKoCnifd7Ffqsi87m7j7Z29f/2ir+rLihRFUcO/7T095KMDZL1vTZPupJBWLac08dydTNSZap6YPsA0Q5RaIoFTzdlABbjxq9S5nRDaN6pLoyey1qXBf3DKXUvuyF68g+XcaA4wY+COAtjbJzrYvwsibtn4Dqu7Oq7IY8i6TF52emmuKLfrQh2BneqT6fbOXNlaWZqZwjOI9jT7q8/KPbYMBf71EOvWIqN7pSJ0QxuolsnJ2JdZ7Fd7aetlZZdPmziwPIIwOSbEjm5FOEp+qMuLmAi/UJNvbnP8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395057; c=relaxed/relaxed;
	bh=BDasRSBzRzMBw4N3DGUFq9UV94c4KSJz0jxvz4ocu1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4YJ/Vk4cxOXK78UUFmTiTh5AqKJSMA7XpxLqqxAptgrR2n1pG0HhKK21pFAcUKZ+VEZiQ1EXkCtE+MtLVOphL+5UahTMCHSICn2wxdmH1JFtTdy4nt1puc7pv1UpJpoQ+CBangBL0DmPcO4X03y5TtOjRIFw8h7M3uo3FlXd2xVbvvtYrOFugYlp2t13lGCS3tPUJTgMz0hFeCCEvFerbn5MVx1RKV35VW5YCNs43s+kvBJ0yee4RlchUHmg0vDCWYN5RRppWVejESQhz64LF43NBquFVSdZRLNeLHFb+IHTAmzW/k3d1CtQddDUIPq83oMsOQGbfuqoTKeDOXXvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SUmxObG1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SUmxObG1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66S2QTdz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:56 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c85893bce34so1075482a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395054; x=1780999854; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDasRSBzRzMBw4N3DGUFq9UV94c4KSJz0jxvz4ocu1Q=;
        b=SUmxObG1WhJyrSMAlmtwhJnY01B6ormnY3Lj/rPtTL1KNyZWvUCOOZaU8xFGk8HKZ+
         tB7U1oSFHVK25mujce7BqTaKW9WV+zRDDEp5cE05qpQIlOWep2T7OHSWRfLLCV1DcYnI
         BHR5qSvW4nWB6PK/uVMVFlKWpYWPHseo9HOo5JEy9+86VgP7dC9WaZhj9bAOp0dvRdFS
         LNvuHhhagvy/GUB16NOF+HXeVDBew9qGeEzPGATWHLFnxXQOgnZwwEAKP5yFPF1U08cI
         /dy2SUQQexzJ2rcEwciLLL2r7FD/a8BNiPX7ohh2DiBrF3CwBBjNZfWqADQ43bTm5jdj
         5xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395054; x=1780999854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDasRSBzRzMBw4N3DGUFq9UV94c4KSJz0jxvz4ocu1Q=;
        b=Kqu70/845WBJU5j207fnnaBo6a8PHILpktCbAea91go2OZa+AhH3wpW1Jd0zfn5wzx
         xavr31q+UWqiSarPL1aEhatzjrRSbiyM9p0aZ17OdBQBKeDxIeTyU6XwBMEyHjvtz6Jy
         FbNhJSjscyIP0O/dxXXVG8dlzpAEAJJf/nfFGd9e6+LPwFn/+9GZ/TrcYcUCCzBRJ/KE
         hET1FmEcCIIgSMuBD0ET1gkIng+7TReAgEvSt+LmsJUImc8AiPrE/McHTPVoB8S/7P05
         Yi8na9P3NOL+upphz4fTYmgmjHoI1woMj8537iKPFWGeNkrVmYg338+KUMHCN/d9mPtO
         Hy2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/V3jaMgc52HEHbp3DNSPYh8VXvyMX7hiDXvILnnQNybR+f2kmAuBxkF/7m2orhbYehLdyFgvduUwA7818=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBrIqf+0AZE5zjssAF0j9FKAO6N3GeNv1EW0U88Tfn9yx6b1VJ
	sdCx5/fnjbS6hczGzsCO0yBxYg9kdb0b5Gql9OlYgU9M6cqvuhsL4r57LQnVJw02SUY=
X-Gm-Gg: Acq92OGmcafBSYpPd/ZRIaJKeYnUGBK/MWzhCLjjr/PYkem+JKdJLaM2JLf8B45h1Wb
	GTJUQTTLQbUr1hybOanOWLL8ZfMEMn2y1qXT8sNsrERZnq8+w0KWWM3r3EeQPK5DOpnAEjMpCgh
	MOwK/fCgYk1qSgZOMCph+/tV/m6/R8n2669nkzNN7zKV7+kmrGk16yg4VL4EjqGm4cwOZqfrLJP
	gFpcsvHJ+oIzGhRbMf/amC3Xe6TPTby3R+QO/GkMCNpqtSxaAYfunYV0N7oj0GBIO3qmhJENh8i
	nJExgf9OhpPzCc84d602cyRRKkNHhsyR0TvZ65x5Jd8935iAbYTuzlxpHhYJXJgvdJ4e1OOjNzA
	TYQ1gLYEIp5PT9JafGXT6dUdlhoMytOAqkzsI7f/QNEJko53eQ+R6Cy8Igcqb8AJgoDjtBedvPE
	+pesKuutnBXlgmmIsraHuUGRENtn9kM5TL8PyjfGSECsd0Wd+rxbnaYos=
X-Received: by 2002:a05:6a00:4406:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-8424327755cmr10725987b3a.46.1780395054175;
        Tue, 02 Jun 2026 03:10:54 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:10:53 -0700 (PDT)
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
Subject: [PATCH v3 01/19] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
Date: Tue,  2 Jun 2026 18:10:21 +0800
Message-ID: <20260602101039.1867613-2-songmuchun@bytedance.com>
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

Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].

Those shared tail pages were initialized in hugetlb_vmemmap_init(), but
bootmem HugeTLB folios are prepared earlier from gather_bootmem_prealloc().
With hugetlb_free_vmemmap=on, prep_and_add_bootmem_folios() can access
pageblock flags on bootmem HugeTLB pages whose mirrored tail struct pages
already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
get_pfnblock_bitmap_bitidx() then dereferences the still-uninitialized
shared tail page and can panic during boot.

Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), before
bootmem HugeTLB folios are processed, and drop the later initialization
from hugetlb_vmemmap_init().

This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
assertion is evaluated.

Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- add a comment explaining why shared tail pages must be initialized from
  gather_bootmem_prealloc() before hugetlb_vmemmap_init() runs (per Oscar
  Salvador)
- update the stale sparse-vmemmap comment to point to gather_bootmem_prealloc()
  as the bootmem HugeTLB shared-tail initialization site (reported by Oscar
  Salvador)
---
 mm/hugetlb.c         | 25 +++++++++++++++++++++++++
 mm/hugetlb_vmemmap.c | 17 -----------------
 mm/sparse-vmemmap.c  |  2 +-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..cd55524c7e30 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3365,6 +3365,31 @@ static void __init gather_bootmem_prealloc(void)
 		.max_threads	= num_node_state(N_MEMORY),
 		.numa_aware	= true,
 	};
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
+			struct page *tail, *p;
+			unsigned int order;
+
+			tail = zone->vmemmap_tails[i];
+			if (!tail)
+				continue;
+
+			order = i + VMEMMAP_TAIL_MIN_ORDER;
+			p = page_to_virt(tail);
+			/*
+			 * prep_and_add_bootmem_folios() can access pageblock
+			 * flags on bootmem HugeTLB pages, so initialize the
+			 * shared tail struct pages here before bootmem folios
+			 * start using them.
+			 */
+			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
+				init_compound_tail(p + j, NULL, order, zone);
+		}
+	}
+#endif
 
 	padata_do_multithreaded(&job);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 133b46dfb09f..c713c0d2593a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -870,27 +870,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static int __init hugetlb_vmemmap_init(void)
 {
 	const struct hstate *h;
-	struct zone *zone;
 
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
-	for_each_zone(zone) {
-		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
-			struct page *tail, *p;
-			unsigned int order;
-
-			tail = zone->vmemmap_tails[i];
-			if (!tail)
-				continue;
-
-			order = i + VMEMMAP_TAIL_MIN_ORDER;
-			p = page_to_virt(tail);
-			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
-				init_compound_tail(p + j, NULL, order, zone);
-		}
-	}
-
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
 			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 112ccf9c71ca..8f41b73fb674 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -342,7 +342,7 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	 *
 	 * Any initialization done here will be overwritten by memmap_init().
 	 *
-	 * hugetlb_vmemmap_init() will take care of initialization after
+	 * gather_bootmem_prealloc() will take care of initialization after
 	 * memmap_init().
 	 */
 
-- 
2.54.0


