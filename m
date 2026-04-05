Return-Path: <linuxppc-dev+bounces-19337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C312EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTX2sK8z2yng;
	Sun, 05 Apr 2026 22:54:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393648;
	cv=none; b=KCga1O8dO5quuW/6ji+KaOsPRM1kTP/jjISOhcugEaRDJoyOlwPVdkolGp94Vbob+r1qubQ/claesY2z41aPb33K44SMMf1qxDUFodns9bySwBcWaNOhKA1YltIG0teP/ELaNPqqQlzvApz2ycE8dgRlYZVdERs1rJra/NjTUjjZDWmahilUjB3YUuRTuxQXqTbr+F9hOD6ljHwZh5/PpJqnvEX59cOKIHKEL441dGtoJEx25/llBxVQqjgPbO5dpaEUCGd27nL+xx7fYjIzfpa0Hf8YDyNn2Ddi16KTvqaEjWn5Cz1PTjdB6CGXkNY5Mdo4o7iVcnh59n8lkg8J5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393648; c=relaxed/relaxed;
	bh=k9npI1C6XAEv6UQdoRbep1PBwjjWINNu45ua4UkL2pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axyfrge47KWvFUQJhdxA5bNZSX/6CLkEyqCn4UJuLxNafXXxu7Sf/C77ZxqPOfTX49HvGxssEAts0S0IYBy60TB3Jmxb+OHhdgadFVJTK7Ye3AX0ntOMCyzigsAcZlnGgk15846ulcQl3uUnOfnZZgj5WS19lII8Mf6A8jnIH4XqtzzM53R+YqOCwXWY5JOOpJyxzn/Tk9BZR6Uj3+L7nQpMbjuEiebkUik2K/2qlrWdvrM00CgMbpHvXQAd7dZeVt4fuYcAvpmpA2m0i0nJAn/RusDZHmu5r+nMQ9rRiLAc5AbHhZCfJL4xTUxvSriEV/JXW/KAhzo1d+zpahdH9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a4joPc1O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a4joPc1O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTW4Frkz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:07 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1898921a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393646; x=1775998446; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9npI1C6XAEv6UQdoRbep1PBwjjWINNu45ua4UkL2pA=;
        b=a4joPc1OiMqLtF8PfGknMnM3QEwdPio7SvBbrqSoYqTR2Fd6aP1zkMgxRG5wJsiE3R
         IsdXVY58KOd4a5DffZP+ocxkR8M7EmPJtRsdOFDrD2cUY3HE9vMR9ndUAs5FgBT98Fzk
         NBdTciKNBo2ihHFFO4LILeparhfS+nb4FEEpHkr+59EFzqJfBQX6z0EmcbPG4GewwvOc
         5MIjx3m0LfKNFVwjwC7146jxjfetjVeDChHPRXN8pRBreHKk+GZEmG1oVYScSsLx38/I
         NenxyHmGECEzynIdfBxb2nyBungEJApImMYUlcLEDc01eMMvknbkSIvUkse/VHRJEAWH
         OdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393646; x=1775998446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9npI1C6XAEv6UQdoRbep1PBwjjWINNu45ua4UkL2pA=;
        b=PT372BGiYPCoJJ/b+B63G99kG4EFnTng8jvqXS4uAm5Zt8Bqw47OgYzmWDi7IukFev
         Xyd27FF6cwvHohCPKmMCoeSeSAeskG950pGdwa7PWnX8fKLS9b6wYUrz+pVK+1h4yIbg
         4p4wNZEIXtJJTWxx0Szp8IlaNGsdB8zj/3L7ajEoA8tJIsbJyhCKSWXXtXJfV2+c63X+
         3hYmxJsC5X9N9p/K3eqzUoFooE1+cVs34AJQaTIFRWZa3hIujpNx7J4vfQr0O0cmZIW8
         jc++BMtfS5rrpgAzr2mff+ZlPoWMCZxPuiToLNJnZF+5oyLw5JYYLBFjvRa6znWkCPFp
         jjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV1aJGX9jsuSjYSEN8+GbG3hKrYo2v67M6aIbrmbVUvC6jeHRTFDmgu9Ip4wc33CzpqyXwJhghI2c/Wqk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypoXYULiX5O8dqrjhhLRZr3FtIWvsuuuarIAaMEv6vwfnz0XB2
	n1ubCNvKwZInxmAzXZOnb9Zj+Wn/zlYhghAPkRspm3qRqB2YJ/i+bggoyXzH/A3+18g=
X-Gm-Gg: AeBDieu41mp5/ty/sd8rWTfMtF3uTZid4Qla73YqB0YH1bP+EfkKjoiywQAdMKxp1LU
	P0WEgZifDure+AJsjMKZj5WGEgkW4spRsmi4LaxuLW0+2tz/jk2g3TWaMEWy8tl1i/YLx7t/x//
	A+yWr5HlQxGcejIempLFygRqskN1KZQoZqmowzPn2Yf42V+mwcD7031S+X//r/7u5AIRE2+PLVz
	f3wCw8flKLq34WS5wa0/4Ev0+dzK9cxy/JYY1VfzB9Dc4Q7OELuhPNGUIgDY9d5kipEjAZZd0Wi
	p137bjrXgURzAF3+UgFmezx0w8ou0/c9bws+01Y/BhZ+wXgDdyRHCJl4ZpzU8J1TaslrXkodhiS
	jx7mHIZOWHxvgnDE3YlzzARAfZHvshsNmsh/YLIW1TWEQbLooLZ66Fgwryd6sg1wX3DnoAkQdd/
	Q/I8c7WCP4YaUGpNcb2I7VCwtvm1Q0/Y05ndjatcpVfD0=
X-Received: by 2002:a17:90b:586d:b0:35b:e4f8:7ac5 with SMTP id 98e67ed59e1d1-35de686380bmr8252102a91.7.1775393645672;
        Sun, 05 Apr 2026 05:54:05 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:05 -0700 (PDT)
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
Subject: [PATCH 07/49] mm/mm_init: use pageblock_migratetype_init_range() in deferred_free_pages()
Date: Sun,  5 Apr 2026 20:51:58 +0800
Message-Id: <20260405125240.2558577-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Simplify deferred_free_pages by replacing the duplicate loops for
initializing pageblock migratetype with a call to
pageblock_migratetype_init_range to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4936ca78966c..a92c5053f63d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1974,13 +1974,12 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
+	pageblock_migratetype_init_range(pfn, nr_pages, MIGRATE_MOVABLE);
+
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
-					false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1988,12 +1987,8 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
-					false);
-		__free_pages_core(page, 0, MEMINIT_EARLY);
-	}
+	for (i = 0; i < nr_pages; i++)
+		__free_pages_core(page + i, 0, MEMINIT_EARLY);
 }
 
 /* Completion tracking for deferred_init_memmap() threads */
-- 
2.20.1


