Return-Path: <linuxppc-dev+bounces-20028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DDAF34C45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yJn23Qbz2yqf;
	Fri, 24 Apr 2026 12:56:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999369;
	cv=none; b=lL7cUduF+gtLnC1OZZt4oJjN2wWyDBi+YKJdXbpWnp1sSu2i8mAozuySwoXl5xZBqIL13CNUjibWdgyxr8zakthPz/MA4qx0IUEd6jwrfRyi9/lpzsNSJGlJN+j7SnRSgrrJ0mTRr6p4vp17zL+jMBbK1lBy0XvmCGvQsrbTU2aellmvKM5v492bl5fhZ48Wg3qhposzh3MtDGbFaHUwTLANBJtNre7vENSJ7nw7VbjKiNgi9loGLLdtCJMMV/U8A04wbpPwhZ0mISqtMCM16tAPsekLqP2VxdgBk/Ncn/s2oje9mtl0bIlXaPHuodFora+05NYd3gKfGUnD40o0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999369; c=relaxed/relaxed;
	bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wa/gBpWKVTNGhxzfZU1voUq0HSzGlh8+Wc+IMULsZr/ytyr/XriF6O/hRvNcnaktQbZqVSRHmRCDhnvb1+5JANKeXLEHGYqia4hS5dq8WWj1ezyEAaBam2NwNggA6myUVjb4gYiFmXp6usZo+ZToBGkFm8BaaKoy4Eg/PR04uBdulGS+MDKq0D4ZaE1WsSB/ppUkpF7uva3yVX3wx+zz8iJ7kSos9JLzQsHydkpe3L15QeIPdqacLVRsBlAe4KnpILp9rYYnRigntgisQ/sPN1hQuyhO2tkZq+opkvOR58qn/7/enheXNy15xcjU9imz5KR1tgSh+yN4IRVXeFV0Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UQA31Yo9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UQA31Yo9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yJm4gLNz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:08 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ad9f316d68so33165955ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999367; x=1777604167; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=UQA31Yo906kMKHUIa/rUD6cVXIMkDtykDpaKTyN+u01POX3zCR0n3o/6sjl//OfcOD
         bfNRCkFSOyipSu77XE67D6k5L8fyGQ0+Lgupa26PkWmoyQ3o4qpceh62hnpLsJbDMM1a
         u+uyq87juhDCQ+4Kt0W4kx2MRZSnausyDtwskQOqSIbtnjXQOaTY31myoZQeyTOwmAM6
         fJNK296i6DcjK6Kw72aDuuqJKHU65J84J4UeuCykqDglCOfOUTPBT4Db+546ED//b2Od
         okfE5O/g/EXzYyMsgrFxOXDK6UabsqoEmTEjxb/cwcLaBRlhamqqVMaQf/Mm5koszXAz
         61wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999367; x=1777604167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=aDHq5pdOq5eDXXZCo8fFT1H2oif5aAcoV3VjH4s54YVmy/HaN3vjfia9lAaC0sns6+
         e1WwPcdLflZPxNqDN2o0TkXK57ohuTS24k3UJoYbjZJAKEouCpZ4ECFVfnXvYVnAnqNG
         9q7hTzCDfmwvp8nOKf4khf7abqZTTOwaYB/Wkm5FM1lFCRgNcDkymXOkYSlC9YyCWYmV
         5zZlAvPvf6IAg07PGnu2Gs6drjia3kVc43efRsRW2UjskQ5Qz7PCgZRRzA2f5QQDVxVh
         l7zVH474S4oJFvbNm1lVWChN+2XgZCipftDLsWLK+V4aUHU5zY07i9lFaPSjPQ9TU2br
         LCsw==
X-Forwarded-Encrypted: i=1; AFNElJ9fDyFR8lzzmz9UVZc0a94pvSdf0NGCcovF+cWp0DLZ4DdumjbdmPoEEaeG8xUvslqJVYQoVW1lj5Bjbl0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXjURJziQ8cgQptbkWYpWwdnlFTmSTZ7FlHnl98mUzUvRGgboZ
	pski6pLUbNtyx+ncskdjX/ZUVtRD1EBLLg/dIHO6n9OMwgle0Z1+Gg1BpFFY7M7RIOE=
X-Gm-Gg: AeBDiesHRVtUoZa2drtep10j0sgoz4b7HmOWk9AFX3f6dlWqJ+TW6D9ZBPM3+DrUEyy
	RHsyXZDThhGal9vyqwULrQ/Q5s5/V5PNd7UD3MxgjMIbqzLawKytZFUTrR6DBdwUt/PdmhKv1hh
	KevLJM0c3CJWo1g7lu6ncgAf3XB4n2rsGLK7EPJh2J0TVoiROM+aAcvNpKdoRq5Eq0NTdwgF9xi
	itKf9FhF1kgDsnJLNbEiPq2JbjWKilp91K/w2AZDw9fkRoFSsDPnURDGDy+o0l2qJBJtWqXVGpz
	yoBZUYIFKttsAGax5x4vvs0hq+z5fsIoRu5ABTYqFM6iU39a9jPVeLswd+REUDO3e1IXJkMyLHe
	I6E+GCtGsHqNAUbWojyJUsj25NJ6l0TMLkUjhgQlwbKmF+RTzqxC9M+bbk5ixPhKlpSM6Hz7YZK
	myL/oKrQDY7PgS/cZuWdmwg6ICm9OM4QYv3/0ToDDeNOpEpf9LO/ajX4k=
X-Received: by 2002:a17:903:2412:b0:2b2:42f8:1a4b with SMTP id d9443c01a7336-2b5f9f3a987mr327922445ad.27.1776999366531;
        Thu, 23 Apr 2026 19:56:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:06 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 2/7] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Fri, 24 Apr 2026 10:55:42 +0800
Message-Id: <20260424025547.3806072-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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

In create_altmaps_and_memory_blocks(), when arch_add_memory() succeeds
with memmap_on_memory enabled, the vmemmap pages are allocated from
params.altmap. If create_memory_block_devices() subsequently fails, the
error path calls arch_remove_memory() with a NULL altmap instead of
params.altmap.

This is a bug that could lead to memory corruption. Since altmap is
NULL, vmemmap_free() falls back to freeing the vmemmap pages into the
system buddy allocator via free_pages() instead of the altmap.
arch_remove_memory() then immediately destroys the physical linear
mapping for this memory. This injects unowned pages into the buddy
allocator, causing machine checks or memory corruption if the system
later attempts to allocate and use those freed pages.

Fix this by passing params.altmap to arch_remove_memory() in the error
path.

Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..0bad2aed2bde 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1468,7 +1468,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size, nid,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, NULL);
+			arch_remove_memory(cur_start, memblock_size, params.altmap);
 			kfree(params.altmap);
 			goto out;
 		}
-- 
2.20.1


