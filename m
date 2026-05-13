Return-Path: <linuxppc-dev+bounces-20895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED4FCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:13:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv4N69Ktz3dhR;
	Wed, 13 May 2026 23:11:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677908;
	cv=none; b=c6IYlIc+RcMgOz3yjhzdv9/XIrsi1yXYBqVT1hW4CsHi/xpfDygnU615WXg0u+zO65WvNzhQc8zG0nCqQgUmwMh2+CfF86tRpYy94GUCWZNbiRZHI5wBJLyQghiyJrVunCQ89+lztWG37gcBZIULOs+D6hHAbvUvjR/0EeGZ88Pc/Msdn4TLxKommKYMDE+6Ayng9ZU4wXfHRBBXqEzUe1B/KryYICJR+fS9X8rxxSh4TtZMEH3a1HtKDHtmOH7vKdEEZIrzzYLAbWKjBZI2P7eiFM/ycUoE4Z8+7CZxM6OaLeZmoWj1q6w1xjyTTkMjb0rowqpzusDJBXC4k+SDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677908; c=relaxed/relaxed;
	bh=j+OzHiBv3aopKwtOQIdTMG6i3QI+K667v1klhZuAIPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8hMaS6riQAcPM7JDCTukLFNYBtDr3GPz4Vrim5KWDD9YY1NhkMqSfM3QUdnDynJGJ4zbB5gDuBoopg1p3r4STbBjahr8FYRTSQI8my7Z6/zsvGhyfTxTlC7laUGJljLu94rvOHB27JRVTY4vmL+TqnMTEZTqOGSJ1aMcxa/tqrQGXQKXF4KfpqSBPkv6z1FSkApv7eSfyXCt4/ITk5AKylBUUzg1RiFLkrYFXguSNHhCyLQbC/IJ/dG4hKL3pL9WdmVD4xyVgyKkyqEgL6hOGIzC+Jrz6qPxESXKkQ7ldJgCPCegSWe3omvLgGWs8ph3aCYKf9QDhRP/eDiE6Sgxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IKXmOgFX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IKXmOgFX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv4N0vhYz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:48 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ba17c8cfacso68353625ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677906; x=1779282706; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+OzHiBv3aopKwtOQIdTMG6i3QI+K667v1klhZuAIPI=;
        b=IKXmOgFXheYqA03qcTBDzUBZ5+w1NcEoqUYzyrLAQvT8h8vB6Z3myzxLoHbHQcYROC
         puQuZ2h28CjbV5b2DCUS2c99hA4rkAM4dvCZEyBjc8YrV4rn2ukE8dstCaKY91O5rHNe
         KDsww/qdY7L2bHG8ep8LvmB/DaTyswKynyyaL4WxEiUC7seEit7d0jTbiVWh7u8X5rx/
         zLq/mmsytQMDLSqBtaupr2mgki6e511+IiS3kSb/sD6swN7nI1sQtFXmgKGTB0wIsqCh
         e52jleBhkgfrYTKj68G6lyasMGOMgHmptmnvweFlPArz54ll4vrUEuTC5cRRFk3eFqXA
         kUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677906; x=1779282706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+OzHiBv3aopKwtOQIdTMG6i3QI+K667v1klhZuAIPI=;
        b=Ftvu9n/OnFqGHS5VCQ9Qs8psdCSngKZfJMVt5GuYm2UzQLlt1rClhmtbhCmRxYnOEJ
         UsGmHJ1FeJjNtbnVbU0Y+2cpvR5Z2ilTw89+uce3T0K8bvXzoqZD5dzOKdCFScRDKrql
         YK+DJ/o7beUCM6ikCb//1B1JOijBHpQXpOP/Fi+gYYMp6AqSO0gBMRl2HmPwBLDMLJG7
         3edxkGzhsdx6JXAYaIx7y+RnCPY6/8iHwvFCc6TjhkLyV6mPHAhgAIf8wE/GZ4CEifHE
         aCtXLLQbwSrmoQ/BqbUuWBoVtsab8FSBE6uCQnY6aDNXFs09WRrM/t7sLhQtvCZ4qKG7
         dEtw==
X-Forwarded-Encrypted: i=1; AFNElJ96QNQfn9MqwjhQqhJnpRJlA5kYVuROt+HAqWn4XJzuZJ/Gy06besK/+gXdr/IZCKvFBzTD/I34f+P3NWM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySyAeglP5BjeR7LkSz92nHJhci2UvQtvdh4aoeIsdH2HIDSWTY
	lyVxGcUOUQukAi5YC0KB+uqetBosufPnSyL7naeFoOE2S5pu79hW2dM9ABZxvWB15GM=
X-Gm-Gg: Acq92OG5miWELn/d2+xx6Uiplc8YwJAS2PEwrjgpdaYrVERxqgFhM7A8z9H9m/PFsEg
	h2bbUbUvtTeIgN6/v0eP6OvCuF/yuJJKCv6FewFdYi5dQnPxnwl39r/lJbUzMDCajor+ONcNe1U
	bOkP43/q4v1+29AydBEloQJyCQsEXlJVZUs8AGcNtcTaSRveXc8CdRvtOmaPBtSBcskc2c7veZ+
	s3ewjA7AneYk0my2A0UN7sTIAFnSAD50lqmrw21eKagFbtEzoj/lZ0gMI3Y3GNjgOu5YVyJpSz3
	FPRjElUwfB3UITD+UmBjC1xzobejP+7KnVJH9boJIaUf2m9B6Jr1SoIYhuXa9DJ1Q6bLYGfu56l
	MhRnPqb/8A1iJqdxSwhDAxYaNl5KQNStnK3Cz/ZQhzLf19q/bKdakGL7SyeDPlvB4h2PZfrSU9/
	PXY/hMBOSc0Xtxq64ICMMpTDTEHgNOSoUB3Xw0ZADCszccpTO5mbWcBs2UoyE=
X-Received: by 2002:a17:903:120a:b0:2b9:fb0b:b727 with SMTP id d9443c01a7336-2bd27714d46mr39411895ad.39.1778677905970;
        Wed, 13 May 2026 06:11:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:44 -0700 (PDT)
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
Subject: [PATCH v2 46/69] mm/sparse-vmemmap: Map shared vmemmap tail pages read-only
Date: Wed, 13 May 2026 21:05:14 +0800
Message-ID: <20260513130542.35604-47-songmuchun@bytedance.com>
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

Shared vmemmap tail pages are now installed through
vmemmap_pte_populate().

Map those shared pages with PAGE_KERNEL_RO so writes to shared tail
vmemmap entries fault immediately instead of silently corrupting shared
metadata.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 182d0c7dd1e7..9811c92ad258 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -158,7 +158,8 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		if (slab_is_available())
 			get_page(page);
 
-		entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
+		/* Map shared tail page read-only to catch illegal writes. */
+		entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_RO);
 	} else {
 		void *vaddr = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
-- 
2.54.0


