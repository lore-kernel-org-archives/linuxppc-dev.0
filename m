Return-Path: <linuxppc-dev+bounces-28360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73AC98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 04:42:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htTDW4Xsrz2yr0;
	Mon, 28 Sep 2026 14:42:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790570523;
	cv=none; b=WxWyHKFkCEodr1/fRBn5brQ6R2kIUybfGxjwkzCS3jTn7bgimwf5Mvl09PVm99IrGtemxHuEpmG252i/eTx3IJFz9qXuGQ2QbHIkxwQKemCaRuhADAGFP8rZ2QRRnSQJA4Q3CfWMkEmdIemhLxYQHF+vSl9b0BQF5e+hQRLxIn5w1DhQMF+L9XQ12Rbiy/x2miVJyD/zQRloDX1HZzbLVl/6YTF42a5VRNYcAA3N7/jSPSVsj+UyoC9Ey3ejh4+OEpo6fERb6eWNSerIv44tAS5MspPuWTThhmJZ/WRb5f8w7xFBBMFKK0h7OuNEd5zcONR9G+HTtMjGLYqB/IsmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790570523; c=relaxed/relaxed;
	bh=0OVW9hC5UCKC68y9iOXThuN5MokNCxQyIbNLFUKAbKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aveO6hVQQCb/0fJuQt1VtOIYcO16R/EvjVXL54lBVkcajZDe9sp5cZs1QzRu1cFOZ7BySLPqc/GDxy48oU1ipoFfp0veRpa0GdaZoAVYVZhdBGkPU4jNO3TAxqQxdDa/95h3wLyQM1Xwp8H02VKnTni4xyZbsHQVFhb2u3tIXr1OEqf9BSwx/rZRUQMHQkJBKqBrflWWCxjypZ7nV4mZb+7SeGE0MyPU2oL7GwTZY4luWuHteH6oKvT5mUIjbOay41Zzk7shP/+WwLw1qE0Fcp9qDJYHgojxOkRVBNrZ9q3zzhNQ1+Ja468O8bA7A94VbOEndNq43rPp7q1mVxvWyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=d3PL/Z8a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=d3PL/Z8a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com [IPv6:2607:f8b0:4864:3b::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htTDT5C78z2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 14:42:00 +1000 (AEST)
Received: by mail-pz2-x0e.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so449571b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790570518; x=1791175318; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OVW9hC5UCKC68y9iOXThuN5MokNCxQyIbNLFUKAbKE=;
        b=d3PL/Z8aujb2LXotIwvMklvc+b8pPLM0f0fi/apSUibS/riw1xKeYU1uNeGw2+Tpmd
         PBmMC5DS/MUROk9hhY7V77IYBNRuoHjQp0lZ3v20vD96ITeFCqqKq44rS1NDVu0v24Uo
         outYZe4KpJk1+HPb3nbVQfKENUxo58TikVGcDg4Fwf4MzxAyk7+Or55yVq6cY4Ssc6/Q
         K4HYBVSaOfVqY7eK6KzWtoKbATyuGOlUwX7IZ2eosRA4Mj4kfWSXaTQjrXnEiVW9JanS
         72fT/HXi9hQM0aRLVbshAPN3oLir8KscUElrqOyMa42yDDpKpgbloTejCLrkzKs+zMjF
         IFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570518; x=1791175318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OVW9hC5UCKC68y9iOXThuN5MokNCxQyIbNLFUKAbKE=;
        b=O0Zl6oIX7bnJqaEEJpVh7z/Yfi1BzrSDMMp9ZaoOalo8NggUSWOHJzu24gb+VynGsg
         Y6CT6CW7wmqYqxQQ+DSwoaPoAOOs7Dez4TLO80lQbjlw0KZEPy8Aezr9peyroV9fihPx
         ODbkDkhIbL60M4jkdRTFQKNCL1/5YSqr2ggDN1Nc7W64bjRPHxFtsyZWmu5Ryu0CX4Ww
         +i1DEUlsm9/9DHhZ5JYs918zkNwNCBokxopB2xtVfINCeE+8G2ZVkrqqeZj6qxUcDMhE
         n4qepuhUdEsbdyQZ+DxjQ2Ayyu8d2Yk78Vhx50Sr+gSGa1WnJ3uRQ6l6vVWbBaOm3dp4
         livg==
X-Forwarded-Encrypted: i=1; AKwUvBwnaWwpM2wYDfVoFK/osH2UP6i8FG6c0ZUpYd4HHBYVtASP9e+7n5+PLMkkt/UrTeDQjmVbPPj2i/J0RMQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kYwGTmmct0lfl0AWj7028predwCG/6mfVPDwOfPQs4Jkkmzwct
	3p21HJRVCg426KQXqwn603tdCUXTiFXF6bQUb/6SzULeMh34CwssW9lbNWiYaA/ox8k=
X-Gm-Gg: AYBFou3NF7y0qQTOvkZcp0wiR1tz3XAVqAO+ct7JIcCTezvhzmdqAflNboq0gwFhWTH
	GyH6JTSCbxjiAA9mQ7doU+MyedB2BGTKJGMkFODnMgbLX81XJAwehIxU+EhaTC1ae2mjpTP7aB7
	dxnvKwwdURVV56xdCZsLR5iO9hCiV2NOLvSt6uCZGO+3Cd07IbIb47fWT+elB97zAUHsU3s7lGz
	3T8TrF+aUJY27ygKKPCv3KVVMnIjLwNkbTO/9FNRxMliBczvCNZTlhFQe9cZLlW3DXMROJr0V7q
	m5SZZBRHjBW4K0ANEFFz6B7BTPgvaNOUkd8WN2CAokVuA5TUQJ+DhOrKikjUQprnfm51+tqWB5g
	ILey/IgJMxQVQ0zuY7Sfy25aQWiwvE0BPq23QU39ttwMN2/k2cmtZMfiZ4gRBaszJSIo8C2ZKdM
	kCdYAJ0vJLYiHfcNF79HlZqYBCA3Sh1nikmU6sZ3y8SLB1FNZbAOiwZ5MVbL0Z30tfX7cvBu+Oz
	P03ZMtkki+dNYSOHYfLfuQ/B2iS4w==
X-Received: by 2002:a05:6a00:3d09:b0:881:236b:748a with SMTP id d2e1a72fcca58-881236b74f5mr3613151b3a.16.1790570518137;
        Sun, 27 Sep 2026 21:41:58 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feae8d827sm3405869b3a.36.2026.09.27.21.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:57 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH] fixup! mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Mon, 28 Sep 2026 12:41:48 +0800
Message-ID: <20260928044148.3300333-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-8-songmuchun@bytedance.com>
References: <20260927025441.741633-8-songmuchun@bytedance.com>
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

Each PTE mapping the shared device DAX tail page takes a page reference.
A sufficiently large range could therefore cycle the reference count back
to zero if population were allowed to continue after it became
non-positive.

Use try_get_page() so further mappings fail once the reference count is no
longer positive. The section population error path tears down mappings
created for the failed section, while the warning makes this currently
impractical limit visible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b617ff1b985d..66de04f8863b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -278,14 +278,18 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			/*
 			 * When a PTE/PMD entry is freed from the init_mm
 			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
+			 * above. Thus this try_get_page() is paired with the
 			 * put_page_testzero() on the freeing path.
 			 * This can only called by certain ZONE_DEVICE path,
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
+			 *
+			 * Use try_get_page() to prevent the shared page refcount
+			 * from overflowing.
 			 */
-			if (flags & VMEMMAP_POPULATE_DAX)
-				get_page(pfn_to_page(ptpfn));
+			if ((flags & VMEMMAP_POPULATE_DAX) &&
+			    !try_get_page(pfn_to_page(ptpfn)))
+				return NULL;
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
-- 
2.54.0


