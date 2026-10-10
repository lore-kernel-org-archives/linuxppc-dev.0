Return-Path: <linuxppc-dev+bounces-29170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6498FCA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x2d6pxhz3brH;
	Sat, 10 Oct 2026 18:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619161;
	cv=none; b=YydYq2782OEKJ4RUTfjuQBueET3uEZIzgASv85hvpxidIGsLlAKv97z15e8cdlVjaN44oMMovp851oy80psVTIHNSmZzqVfjKC5H6JjauNSBgIrIkxg4iLHYkHVy+HWv2ckyblao2eW9/8SV8kE3yPYrn6yVy/u92PXa73D9bzGmXDaN/yon99BeV9e1bohkpyfxgdKyN0tZL3KKaRkciQFdU4cx4Z0uXwdE528GwSoCHkNLgXJEsKb8+SZHvBmJqocCPXxgLQeATJEKKCWfdndf2shRivvYm8y3/zZe1+bfIXS1cj0Tu2FIDhsg7R9EL8zvksLQfTer214oLGXa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619161; c=relaxed/relaxed;
	bh=R9enHGmaDPvvJJBwJoSb9UIn3R22GPADXFoJJNtoblo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqHcvvG4zBrTcrozLXOMWqcgGPMk2Uq6EglXajnnO0hjQ64WWXYeE8PWIZ35noLgpG14wiiZoPXIUtJ8o1Cxw+JZUKWWdSadi6fHK5lMhWyB7w2cpOBj5NPKKBvUWbSUmJfInzCtsnoIbDJFz2hMAH9KRnqAOj1OyjqTUSW51UOVpFusVyo5CKUEdlpL0FaasCxIPJxfa7a6aLgZ8fEoqZNtA362wSvbE+SdLvXZD0wJE599KcH8r/0z5cJxfydjmZGgO6bV4j6H3PC6AEcPanYQ8ca7r4tC9i4O+RoUSeuYT5Q9D9Ej/TkgpuZaxSYrSQJoJbmBgwWqcXKvsPKG6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=heszNW/V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=heszNW/V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x2d1RtDz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:59:21 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso221159a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619159; x=1792223959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9enHGmaDPvvJJBwJoSb9UIn3R22GPADXFoJJNtoblo=;
        b=heszNW/VJF8/vBJV37RppUE2hrp2+ZRzo58uHYU3hY1CNGbKzrBr8nQa3GBAX0ASra
         7SV/O5fMNFW331AzZI4k82cRu/sdh9gMgYbPBUMY/NVGa6Zvbn9pKVGzOTd9VsH7fGps
         MCr+ZpR+qXn7+DNqUET7Kk7k3791IVEo0J+Wx3jY4YCqTRXIXr1U3UyquOK0vYxpyAAB
         rLr7TJHrQHTtGG1mqmvPGzxK2azgYFMXgmtRI6a5dp9BU9M/xwlh4jNnEujXQ/SoaKOn
         pf+BdQikR+3IzLuovVl3Sx4dmA/6tdgjK6ZumlDhuED6vBVd3ignFJ48b5JpMDbYobiP
         j8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619159; x=1792223959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9enHGmaDPvvJJBwJoSb9UIn3R22GPADXFoJJNtoblo=;
        b=yC4TIH7MFKVNwZU34ACc0BReORaUuPmx+LrWLl2nmyKTeUvCugNMwPpSFJ6W0iObUf
         kdJ0mEHry7oKhsJAChsUw2TJf4fpZ37wNA5k1IbStE5oOVxrNDLda1LRL+v+q/9eMVgF
         JBUZwUnoH0fl7L2EHdkadR+bs0Ae4NARVaDrET7ven2KoQyeSa8N3l/ANNGzXXtbsjmd
         281Ubdy02QHe9Td8Ml/BnL2PiyJwsv4yTt11eFJZeb8JmKDIPwQJnO7rytzYPwMBSVcP
         OLXX28peFApOuW9ddVIrvXxFXVITZ+6SVspR5cYYPqViE/5MLcobsLNl8RF2X5hWDuCi
         6xqg==
X-Forwarded-Encrypted: i=1; AKwUvByZbUS40ryWciO18r7QGJeMSOiTa4cPCrlsQ1ptzjYCNKR7gAwE/00Ez+M8YaVvy8EOwRFoyteuskcO3yM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLIHecByqPV2kH9thMDCBWG+ggdCHX6GhleX/xi1rxQrYtPcb4I
	wO/+sQP22xnBIe6gRcMtC6kOJViSVy7k71qehTQ6hZ3mLNSYx1v6MSXtRy+JC2jIfu0=
X-Gm-Gg: AYBFou1U/TvtgVEhTWhMr2PGCaac9xZlhHEHMjdAPMneC9LI6PI/GulEcCavK/MPyf5
	wgSlNOinYalmXHW8aS7dZlePZzj4BdTJHC2fh1ZgaFFIGTJxT9Z0IG0JdRyG7i3P7SKyyIuKB1P
	vy9Squ5mY7h7sb2OM9s9dWD2JJqxLIrId375RPdww46uIZl1J8yOkPukpF9PABDl7/O850cR3TT
	+TTwe3UjfQ7AJ7OBcDvvRpyMeaPOSIGQi6Yzsdf93CiHfbPm9Gp3DwDtlg+fa8RkwiMI6buIcMC
	jboT9MXe61cIJtRRZjZK1bSCkcV15xU++pwASTrdw5OLQRccRXd3Ynsz3g1G0TEiYXjz0EuXw9K
	tgncRr2IPTzDc8WKdM8VezxsPzt6Qt86e8FZQVn4im7Yrbm8ScdIko96OpnmFXKusN7W8Iz5Pq5
	H+bT3wxUdlxmFoajIPtUYTiTkUhU7rTH1tuxWcIPSI7THN2jzUiWPa7ghqK9j9gyTyGVm+PbFSF
	Ab3vDNKzv2CMqHgmQL3n82s2FdJnZIhGEr6Vg==
X-Received: by 2002:a17:90b:224c:b0:3a8:5d33:c615 with SMTP id 98e67ed59e1d1-3ab3a8d0ea3mr3496429a91.39.1791619158743;
        Sat, 10 Oct 2026 00:59:18 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.59.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:59:18 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 6/6] mm/mm_init: add zone mismatch warning during page init
Date: Sat, 10 Oct 2026 15:57:55 +0800
Message-ID: <20261010075755.83339-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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

For vmemmap-optimized sections, tail struct pages may be backed by
shared vmemmap pages. Those shared pages must carry the same page zone
ID as the struct pages initialized for the section.

Warn in __init_single_page() if the shared tail page has a different
page_zone_id(), which would indicate inconsistent initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Factor the zone check into a local helper (suggested by Mike Rapoport)
- Collect Reviewed-by from Lance Yang

v3:
- Collect Acked-by from Qi Zheng

v2:
- New patch.
---
 mm/mm_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1650d6bc1211..6deae33db882 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -593,6 +593,15 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	node_states[N_MEMORY] = saved_node_state;
 }
 
+static inline void vmemmap_optimization_verify_zone(struct page *page)
+{
+	const unsigned int order = pfn_to_section_compound_order(page_to_pfn(page));
+
+	VM_WARN_ON_ONCE(vmemmap_optimizable_order(order) &&
+			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
+			page_zone_id(page));
+}
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
@@ -609,6 +618,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	vmemmap_optimization_verify_zone(page);
 }
 
 #ifdef CONFIG_NUMA
-- 
2.54.0


