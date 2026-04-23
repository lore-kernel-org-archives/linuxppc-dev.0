Return-Path: <linuxppc-dev+bounces-19994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8DF99342
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:19:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SCB50Qjz2yY0;
	Thu, 23 Apr 2026 17:19:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928774;
	cv=none; b=acgcR8YAw1PkY7y0vXHwZmIJlZvnZR+Xak7l9JXRHOTjZ6rDa1ttB+q/Vf/0eKKvzCRpyetzyVGWda0s5/FCh54OM2HBevGyEAqBqFz2nC+Xl9GK5yoQ0gC02GpPWIXrJRw3JdXePrhncuW9jh84byjUYUsmy62cpZ1IYw46UfVgZDsp8vaHp5mY1F3qpAMvL/jIU+RQz5CAjJ9GEApCR7kOUhDEPD2D8BuE5jLSeVnlJJX7QhWKs6NIGkWLkOIeUUv/aNbV//Q9rrwZU0Fapy8Y89RE8xYmnhL4TOLE68TfvOkhejWJkOAZpPudW6CVb9JdHurPVs46CtJ0z9+0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928774; c=relaxed/relaxed;
	bh=h2yTHOksAu1ksVjTp1X1iUbz+KUOcAtP7+OrJQBUO/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFnLWjQDdtzahjZGXc9xxO34+acBDUzhgIvqhJHimCgaa+Gy8+h9+39vyw50dVw7Fsm8ORcJGLtKzVujflCgoMYQIt1AwW42qepyv9fmnz+LsJopT0Sz1swBL/4RwHbLHnrXNaUDvsowkI328HxCN7OBdGe2VGc67pFjn4ZnamAv2n0+SBWng8EDKOHH3J7//SAK6IHwTdgN6Uii1eIjz16KF6ucOdOopMT7RnBpqhRSPwIcAnPhX1yAqzfPvc4dKH+f+qk9JDCC6qKUTpmHcwH5VvIMpDDSZdlbSvTBc5flvjPOwh9FCXcItjOgLUgNyM129O8DmNuiOFZUq/9c3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YOoH1KRJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YOoH1KRJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SCB0Nf8z2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:33 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso5015424a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928772; x=1777533572; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2yTHOksAu1ksVjTp1X1iUbz+KUOcAtP7+OrJQBUO/Q=;
        b=YOoH1KRJrowuxN/O/oScpclQnCXZpaccbguv8pg5aZFl4woYjF+RViyaD0ZkdTKd+D
         edsUkkic6GKnzt+xC8uMo0phgau6HUvEEtZdAG19VWtN4n3fMBxxYV5Tot3cFVa1pWIh
         pqbF3pzzXB39QbCMTUvW6sd7TQeDV4xAK+kEaOg3yeW8OxJrR0yLGyWVACTZPQBzni65
         NX3pEfQNdnnhDvNDC/nzr9p5mp0MLVeehCEquvalbsH6m61PXXsHIc5TK5NcyzFdnfYy
         aghxc7W+POvoZBLaPI2Q9tDmU6I9aGsOhhEWk/A6WP+zBNtrp8U0c+02Xf+PbqiHEndg
         X9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928772; x=1777533572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2yTHOksAu1ksVjTp1X1iUbz+KUOcAtP7+OrJQBUO/Q=;
        b=anaSK7/NXv/QlEdGpWKzasa4oUPeooZ8VrA+8sSCDLRmBC5CuyEd4qIFNXVNfVcTC7
         AHvTc5atz4DU7gvCdERv80A0YiFeGfL2BaulUF2CWkd7o9wzyj/d8uI6r7oeE4AJtZIp
         Zpyn3LBhCMASXl5vPZmuNcAIe509t5HOd4kdKu3afWzOxXtrTtjWe6toVoLtrLJS8aMr
         XQih+tTvF6CTuHX50qHMMsTQLaj1dCuJRNtqaFZW1UBBoP/N1/i7RcJ5l19SxC4vnPPc
         evv7MDOuf6YUP5Ac7flWLm3JLYmvBb7rwAeF4uszwhUG5Xzv3TySJuE1/PQymyDdFUEI
         CrDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8a0i7zQZTI5gQGnq0vvhhggokavLB0QeWwdwuXKI2aDXfN1qCo3TJEtORANJ/dljbDCABEF5+bzdE3vzw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxP70kyhTTmAsn1xaPc0D/8KJ1VHmQ27FLxRumGopUgt9zQj49N
	WsyomcVTroF3NJnzLrY+641eB9jYPr6FZvnAVKE759n0QQwZdl8YRV0QLFVkjq0I3uY=
X-Gm-Gg: AeBDiev/VebuSIiwwykiY7cqsgVNTMbCKXqDgKca08InCWV6fP705ZVrYt45GyN9hpw
	qeEJGBBmaMFxKVd4guIibSaTa+YNWI+rj2Sf3GfLCmPk64PwTfZgzs0KbJqI/ocXKfviUvZkFD2
	U9lnt7/GThDq+DVBWbef0tH/Bgz2Lvc0c3uUT2DDcnY8s6zGfYsocwnrAhWWJCj77mVoDxhhLQZ
	rX6aukPkpJ3NF8b9UO9UGWrmLYmEkSmVgii+Z8HJfDNQXpU5KBzTlzgtajLEj/2BzhPpFkBAuMB
	NOtFxf1XGcHiiyl4Lpuxct4wgUvAcy3J/gWH8wAJM8hGDJW74W++dicao//F9Mjf9+u+cVE4Ehs
	DzZoKeRkbjSMLxlKwEe6xIbp18jnk7To/MPpXTrWGUTrE4HMJgRxI9trWmZXliZFyWRulaeeIih
	c3x5QeZG5Em06A76tm9fF61G9v6/g6gd45bMq/xYK2kXh6DxlAv6Grjg==
X-Received: by 2002:a17:90b:3d01:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-361404af0a4mr28368736a91.23.1776928771838;
        Thu, 23 Apr 2026 00:19:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:31 -0700 (PDT)
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
Subject: [PATCH v5 v5 2/6] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Thu, 23 Apr 2026 15:19:07 +0800
Message-Id: <20260423071911.1962859-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260423071911.1962859-1-songmuchun@bytedance.com>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
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
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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


