Return-Path: <linuxppc-dev+bounces-28584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF2CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:28:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvzTs1C38z2y24;
	Thu, 01 Oct 2026 01:28:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790782129;
	cv=none; b=gkP4dKReSMYEGr2hlG6NHTcaURt/1hO5xztmwh3t63M2iRdPa5WFyo+jxuWP10Fqb4eyqh+vS8sXV4dbaXqFF3jHNSM8Qc3p2GGC0p5ePWGTcAAI/5MPeCb3YZP3D9xLWihPw0AkfWAXYN2QyoQDMkaZD85H5wrVBj5dskkz9ktDHd7eICbAWRFDT/0hN5P+ZCdCNgD298b8kMfvhMOqAdDDn2onB35aenAKmEKOmEJ83K8irJj8p5XPTwPF9PLoLKpNBdWwSNR8lRmVsNRzhmH7JQWkw/a6tnG7huuSyfoEfBeh9Grw+lKL7TEo1dd4gJ6Eb8eV5H+A/3Z2HeZhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790782129; c=relaxed/relaxed;
	bh=cc+9rKSOSGawoxpJ2ipg52Wvw6p1Y1gNn8hY21fAsGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI7AaGPTvYxsifY/uQab5XWUatBjNi7IGf6+GMipRSFJNxXS9kRnjNa1L+y/kktjZewyncI5LIkkx05H18VfJZ3UyBqJkxLp2DIz6b14kDVXmWSvXB0HNRmgiq6BMbAb6kWZKqGjtnyGN7A79XX6p2pWopo2+Ey0mckS3o/TcVXQOdKnwUm3aCeJnH4O+H+oqM4s8wd5B5KhFNaqTdJAO/pAY5lpP5g2oaC/ynQfWENLA76YPN8TbhSE5C/Wd/7yZ/yGG92l0GNERuBSSX2khFcUpbUjE9kWxkzqlgIqbeJSs2+/oxIy1WzVot7x7a1fq/8UGvYrGeiCNR6MVbf4ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k/NbjruL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k/NbjruL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvzTp6Y9fz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:28:46 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e46a15703so5235263eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790782124; x=1791386924; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc+9rKSOSGawoxpJ2ipg52Wvw6p1Y1gNn8hY21fAsGA=;
        b=k/NbjruLUxOaYrZTN9UvPFWFhqnFooRTBpuKNK2zGmKPE3E0O2NyuubISm0cO3L+QH
         JOKmGXTioo2+MyPUmpPWL8pFxTCK0SFwYvFDHRFjeHURnDa0lHkkGhwTAc/E5Jx7Fvux
         px+VvPuEUMfqvenobmD6dv9P4K6FqCkvl7cSRzKuxaBRVot6IuKaTrwfuueKRtxTAKnG
         wa3Z94KslnMoLZkFkNlcz4AspvyiMSHMl7coktYhRY4MdDI6emtTLQOhnXww7WgtgZwr
         BHDI65ViSECVWOvwAtWojNIvFLWoxQZRh0DxAvUqsH+NjNWgyC0y6Q8rZkpNC/8kQzss
         L0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782124; x=1791386924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc+9rKSOSGawoxpJ2ipg52Wvw6p1Y1gNn8hY21fAsGA=;
        b=wauAf0Wiqzf7aVEvA4Pm6lmScuOGAIugNkM+JIbHfxkF0Rx5ugij8Y4Hw3l1UAeZEJ
         6BE7y83eMAK5kYU3I3EQLsDnDQzGlEzXmeuV0MpqII9zLBEvz/5vDyEPve1vQXMLUv7S
         VHUWiuZM+7E/MUQjl2GOtvlWAhWn3hr2X6+fv4nXHurQq5wKbuewoPUlUGDzR0OZWvT2
         V2L2jHJ6yV435QInIPcgi4hEmk/fuNUy43Wb0EX7nQwCogdIFNuhEcUt6mjQpoZrVuMA
         xhKul5UPAhBfrqclHI0POriKbB1QBr52Xx6UVl6S91oYi/A+2uX9tWSYRdpNeno+fUG+
         pAQw==
X-Forwarded-Encrypted: i=1; AKwUvBxLn4K0xz3IoYjdRMQ7x7V8tvwGEJuKFKTU24x/YV87QZ4y39p3I6DBxH/5fb3yMJtYubpk+7SaUj18LUU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL0cuO04ubuTYGgIdLHLU4AgFjR/Kk0FBv/VmC8QBMkqm3dq/+k
	QELdrya4bfZfzaUdHrCqoBNPnRC0nb1fitHveESd508PHngS9fa6plLSpCehoi/4hPI=
X-Gm-Gg: AYBFou0IcXCJUYSxFWv2PsyOWzc4Zcpsc/MPay6azVm1f88d4zA3sISI+MC49Dk0cic
	uaHSytrWuCrgdtB2JPELINnJWqfoyEGBTOaNtX8YLL9OUeRSmJyB6K3C1yaiyDXKpp+dQZWFuy8
	aUVt03MIta6BwPOUF7vBBFZ8oJqH78GDSIlzVnLZNR+MpqlLR7L4QD4TfGDbjWG2FMblF/1XJWu
	XhS+GgYgDvdzWL4Stx1F08z5icuTrquiebOHwZl4fY4RP0ORQCUepXj3/0NRqIqAQdMbQmC9t3Q
	u7aT8KyouN6FvLF2GMw+lgcBokj4zuNdxtDFZdZVs0hgpouHnf24qTNbR1p/WekXZuyW6MuZRHW
	/b48oTZve6yzgN7zwlc4pNGIV3NP3VZym8XeMo7K1RDgF0i1Prp9iL5znnWHqiCNCQ7JDNdegpW
	2B7/8wGcPWP/kvp0rcowgAEmZ/Sm41/HIMJM7INIwuQCEJ2m7+akKMZ3yCpkCgpg5Sn4SxHQny+
	zUYhxHmgH0LD6lNa7M=
X-Received: by 2002:a05:7301:fc04:b0:339:85bf:dd89 with SMTP id 5a478bee46e88-34cdd2a42a2mr2004450eec.35.1790782123219;
        Wed, 30 Sep 2026 08:28:43 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5b3ea3csm5750493eec.23.2026.09.30.08.28.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 08:28:42 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH] fixup! powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Wed, 30 Sep 2026 23:28:26 +0800
Message-ID: <20260930152826.76084-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-10-songmuchun@bytedance.com>
References: <20260930140627.57431-10-songmuchun@bytedance.com>
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

The PowerPC radix path takes one reference for every PTE that maps the
shared tail page. Unlike the generic path, get_page() lets the counter
continue after it becomes non-positive and eventually cycle to zero.

Use try_get_page() so vmemmap population fails before the shared page
reference count can cycle, matching the generic implementation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9ca28e4a610a..a3332f32ffb2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1042,13 +1042,17 @@ static pte_t * __meminit radix__vmemmap_pte_populate(pmd_t *pmdp, unsigned long
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
-			get_page(reuse);
+			if (!try_get_page(reuse))
+				return NULL;
 			p = page_to_virt(reuse);
 			pr_debug("Tail page reuse vmemmap mapping\n");
 		}
-- 
2.54.0


