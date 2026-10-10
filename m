Return-Path: <linuxppc-dev+bounces-29176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B94CA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 11:55:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22HL3H5rz2yqx;
	Sat, 10 Oct 2026 22:55:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791633342;
	cv=none; b=cMDeZynzq/cICavjGS4BdMXtf7R4eeGBYptpjbx8dkVEUbSHLppFniqYi6Pmjc/1hGUbIknB8cAAmOHBQ3+W5lSVtLKxFgmp07CunDvHedwxBtkF6Z6Pwy2IsHJyjdlvI4ewPeVOZCRLLZVrOKUzRc35M6Acdmv+utZ0kMXaq4OZTbNBWEq1/rnc8rbIW83xEHLhBOao/8M8M3T3Y+0exVDbgGLjZN7349gmyydrkF1eN6OWPVjI6wqSxJOn0IWvvwkblvv5HrVi6uLwCUcOtEJXayRHLO+eut4f2yYyWtxiFcjhtCfsOAK6Gj+XV5fmskIymZQsWSkvrmACi/vMog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791633342; c=relaxed/relaxed;
	bh=X4UPkDBQVV7L4PDyWtNF9o8eWvpDhSzjJx3UHj11yEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMMW5sIqoblv1GzowcbQJ3EDSYxTc6+Xz3ob0lB24nWNEFLIxZZRiQxSMSn8qU3GjRAwjoOZsYDUf+5SlODxhGxkpxfUPWVk2YvOKtURSC5q0lSXLyFN+xGn+AHtHejCGIdfYpER3Iy+mW6hWacGmo/je3f4ijsIf2KuknydTdz9OPQfXfna6tvHe0bpOq1PEBdoO73NFScu6JHMdyy16CyMI4HUkrWHLXmkHc91ZE/aVLqF1r/XcwYiHjz/DNWPSH3VqXWdDuMr1SzC9ZV2ShZxDyWH6nIMEABDNXltyfcrbDQz6hQ0N5IKSeQlU8+zrbAB5xLQeKSkW+a0LDqZ1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E4quDBxs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E4quDBxs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22HH4qFPz2y8f
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 22:55:38 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1710613a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791633335; x=1792238135; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4UPkDBQVV7L4PDyWtNF9o8eWvpDhSzjJx3UHj11yEY=;
        b=E4quDBxsXtYoHa9PfTE+MyznvUh4J6MqM2J5qMqkguFJ+A4pXynnINhxraH14eEJHP
         pmbRMYwg9HyZ/dcVpzgItvOj35vsK4Man5j16Ezh7zlVPkEH5gw6+urfu5WHQYbVR/cE
         sguLBwBUT3jEhhhspfnY+8G6AHkPcQE2yCTaExsj4f8Ud/Yz9kUb/5vndhK3XkruR3jK
         mF2KGAdldZRiVVF8aUcsk5u70tzWM3PiPjCudfDrSEJAny26HPijpDMiZNKzeEBR1j2K
         49FlrGj0ZX/NwFk3vzq1uyuO7UJPiOIfKuE2KwkwaBgT8O1nEYKE6eEwhduoWmNxgp+3
         ixCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791633335; x=1792238135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4UPkDBQVV7L4PDyWtNF9o8eWvpDhSzjJx3UHj11yEY=;
        b=B13yFTxWqPuOVGF8fhHvekIx/Iv1iH6cR1sItcGMobfqwRjjZmaxZCbJ9pNdBX4flb
         gmk+x5UhJq+HanBS5PmI38AMc/0WPcrql9L/09IRBBJXg55qRCNRY7LTyaIrLBABiRXz
         +4977nUaZUOhF0RcVAmE3MhzmI6yoDTX5KdNviCHV8A5bb5dV5TMqMUt6jC+wGoT9Pj6
         Az93O88jQdBm8ndwv3Da3JZZWXyxHscwBDbRM3HSRcAn9b4yN6NemwTPX33L9pY5neGm
         ipGdUwWXCd7GXRV0rDFStJZPZRAR2JJ90YEcksH6ds0Eh3rAmlNdvAn1Tu5PaHPwIiiY
         0EZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFn6ePQTpGNx0aBSRiSl4PpfN3AmDnwmmGQqP6IQQiVct+39PoGCs3jY71Qm+Ap5lQzl5TzewdR/iOITU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKEZQOqAj8UGzPKPPDIhzEkXfwJjRbdBgEbXgKTxXdni9d3A+6w
	Ypo/v2w+T8vCbHupfa4NZVr2T64zaAt072+r5mm4e39IwQ7gbX0XDm/70QvjPJj1eXg=
X-Gm-Gg: AYBFou2LmeNeOZmoyDTsMI3FUzmKllJrtzQm8GMhD/7+FdB+SPVxdq11cG7hbJXmkBu
	7lGd+/f0UUn43AEy3mXBYqVgyGrg5Cpgxyv2dgQigibfsAGkqEV3rV0wR0UEJwiDKuZc36punFF
	OtdxhXkFj+3ZZnHCOLgOb8nQP/lGcShyH3pq4vI5h5BP02CKEyAZ396C6xV2g/d0/CjeZxbPRiP
	WcK+cyinbn/rUX1Os0jtzJ2dvnmuE/mpEa62kgm4IhJ296t7OrxchkT4X+Jg2saRA8oA2qWLgMx
	iPyfyZmEE0uDMs6h52Z+mccAoLZ+YbxeRyLPhGHkcZHJud5sJOV1W7IAYtXd0/kaInZol+UyitM
	5s1U/0Aa4SaNKKLC1g1YIk69O8n/f79taEhocWYMg31bWVsnmLZpbBF/k90c70Iyp6QcQyyk+Ib
	Zdu79kDnPhwVbBjQxJJMSqEUoyt4yKnXZD0IqlKCufCfsjI82qVX+n5TQhoio/na1eaaOIPpj4I
	hEA65i90SMRkSFtM5u6
X-Received: by 2002:a17:90b:2d06:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ab3ad0e976mr2419519a91.43.1791633334534;
        Sat, 10 Oct 2026 04:55:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm9813293a91.6.2026.10.10.04.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 04:55:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH] fixup! mm/mm_init: add zone mismatch warning during page init
Date: Sat, 10 Oct 2026 19:55:23 +0800
Message-ID: <20261010115523.4005071-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-7-songmuchun@bytedance.com>
References: <20261010075755.83339-7-songmuchun@bytedance.com>
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

Document the ordering of shared and retained struct page initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6deae33db882..4c17a892924d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -618,6 +618,10 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	/*
+	 * Shared tail struct pages are initialized during vmemmap population,
+	 * before retained struct pages reach here.
+	 */
 	vmemmap_optimization_verify_zone(page);
 }
 
-- 
2.54.0


