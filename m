Return-Path: <linuxppc-dev+bounces-19368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C2F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXYT3YpYz2ynh;
	Sun, 05 Apr 2026 22:57:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393853;
	cv=none; b=Up5CE7uQDAcqp8tJLQc/xZ/v3nPay2Dt5Sy5IaXhG8oUDdL2jWiFPs6WvuoKu9mrMAuVxIw/ri1bVWqDFEK50sp0rzrRoQZHgyjXA3mt2EQole+/FiHIU06nWiLJWnUVnBFHZ1Hazu1uVf/3X4JNCV4ENZMw29Wr/uKdYgVT7il7kNLKedRpQhE3s7sMaIZAKT1xQx/ytpmIkhNIyMyo1UMVS04Tg0Z6K2A+pkT8hHnYo5MUkuTHKI2IvBg3AqsvfLEsAX1J40e1f46T4O+L92y0OM6z4QM7RQuNKtGtTPOg4UDnA7lMxkeRBufePzTw8WZOYC3KpYaxmqEX1aHJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393853; c=relaxed/relaxed;
	bh=yEhjAbTiZVKX8bAZfBAftf7xoJQ7IQs8AgKwKN6i98g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBkHQC+39/vT9uJlxMbbIFdNhZ2+5MM7XjkMhHY7uqEd6eMGPkirPX9qNcZ2LUOHj66o3+mk4etH9KhvRVUOdf2FnrtOPpAxthCoGvgW3kyVZkvpwBYleNqgT4qS2xOQzKYqqor5dGq5Oqm14kZmivgP5hJcFH5EpJKBe03oK03FUt6BcLonIaN8LnubxqWx+wd7XqegJv+ODfLYnPEmHCl4S6BKI/czzp0Ce8VkEWmzW40bLioTQlqWCklqELit9j0E82IXlYHwYyaUoDsOS7nREcPJsMh1DKgWZ2+d71UUIhpiud/uZcTLLci834+jTo0HiIJ9rsQyw8iOcemVmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rwhj73zI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rwhj73zI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXYS4fTQz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:32 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2009659a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393851; x=1775998651; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEhjAbTiZVKX8bAZfBAftf7xoJQ7IQs8AgKwKN6i98g=;
        b=Rwhj73zIBColMgko++1vsQMTafL9QwxR0u6UYOhNMsj2NgffLk/ReMSOn3uum56r92
         e8SyVDIK8PypecQZpKlLflYXyfAoA21BqKWhIusWxADqB4s4simstcXcvFOmqXi8DZW8
         AqkUDHx3O7AI9W1T5IngAyCF1ixGBVpDuqSpWlya3gyc/rXiVtGt+9Xmkj7U5xCo5HKC
         f9zYlujKLon2LpjqTy6cqVoxIbnXNvMi+ea8/uHtmnORKB5KBAy1BfTG6o4BkxcG+w42
         ybBuSb6Ll9lqIpZQgfMekD3oKhk7yqfFd/LUM2K61zGYXtTinXeY/2RpqP14w6YF1oX3
         1xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393851; x=1775998651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yEhjAbTiZVKX8bAZfBAftf7xoJQ7IQs8AgKwKN6i98g=;
        b=inJDIHAO7CBM//316gEI3QFHy5Avwq+pOmkRCtKzfaMfyEE8A1nDlungVuJYsXoMlr
         YCOxH3VHF+BRK1m7yUJ3ImEYjs6k2cvmJPHggNkyJ8mN/J+xi6ptf5GhnIr8lB7OZuBv
         68oG7GyWgoMvINLg+VIIorQGjYorNm6JSHfcyZKF26+oLoqOSVGu8/b90UWYYuQILMWw
         m4iK9dAVv7sOxz3SZNKsfwwkOCgB9jvyzlHMxgp8ZHinaCzZ5AXJ0SkoXx4gLEGfG/gW
         JkvwCeZoQweh3InQelXpEnE0gl0DvDzLMeiL0KtmlKK5e24ZAZKvUasim+zmp7CTOY4s
         TWXg==
X-Forwarded-Encrypted: i=1; AJvYcCW8iD/BQ06I9sxkdgppWVSmMxXsGLNJzyUxPxboqmkERraFAyo87BPvaDlfP+3xrTxAwZn+ufAhILUn84o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzA5p9bdEwLwR5MQB7VuzuWtwkJ9TY/BSgUHAJVLIONH7W4pzbk
	DgwkTrDH0WPW7wo8SY9tb+VuUORkD3yNkD3TpGKCfqT33SlTinuyoh/d4/4+4UShX4c=
X-Gm-Gg: AeBDietHFClQPuadr5hkcbg4W9KvTZTEXAgRPetjNYR7v87RYQm1uFytHicdcP3jfjr
	jXuH5dZJtxgMWQEgvjpUBHqrXK8snZYd28Mu+2Pr0De5ryYi7tFrKonrZR+17lX0nZ9BMTuPXCu
	n14tww4O4fg1sfDzqnOUMFZ0QCHzRh4mzcImGD4r/R9S8Kh50UXl+RugkOHO5SGDaQxdc9okI8G
	orMt7WKCa0GtTkDIsn7qRXNk8ufjOftbosd+4cbzikWpNrSduTO8Z/d9OYxuQJq8SxCChAdi/2e
	d70VRW3vEU9YStdgCKRf21VqqgKjX4y1euOlxqargir4Emm64yicNs/qkkTMxDmFG57vlPHzYvB
	LP006FcaiOAAWkkx5fTJVtSI+eyBI2QbEPEAd5cmKLdIiERiQIwE8POtqJ/yymInTrcptEBlXQC
	7Oj6oMsW5Jgd/noBW+sELpfZ1zSWqAWQIL0qvwxDAq0cc=
X-Received: by 2002:a17:90b:2b4b:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35de69aec1bmr9125066a91.28.1775393850723;
        Sun, 05 Apr 2026 05:57:30 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:30 -0700 (PDT)
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
Subject: [PATCH 38/49] mm/sparse-vmemmap: remap the shared tail pages as read-only
Date: Sun,  5 Apr 2026 20:52:29 +0800
Message-Id: <20260405125240.2558577-39-songmuchun@bytedance.com>
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

HugeTLB enforces Read-Only mappings for HVO to prevent illegal
write operations, whereas DAX currently does not, which introduces
potential security risks.

Now that we are unifying the HVO logic for HugeTLB and DAX, we can
remap the shared tail pages as read-only directly in
vmemmap_pte_populate(). This ensures that both HugeTLB and DAX
benefit from the read-only protection of vmemmap tail pages right
from the point of mapping establishment.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd7b0e1e5aba..c70275717054 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -176,14 +176,17 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		if (slab_is_available())
 			get_page(page);
 		ptpfn = page_to_pfn(page);
+
+		/* Remap shared tail page read-only to catch illegal writes. */
+		entry = pfn_pte(ptpfn, PAGE_KERNEL_RO);
 	} else {
 		void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 		if (!p)
 			return NULL;
 		ptpfn = PHYS_PFN(__pa(p));
+		entry = pfn_pte(ptpfn, PAGE_KERNEL);
 	}
-	entry = pfn_pte(ptpfn, PAGE_KERNEL);
 	set_pte_at(&init_mm, addr, pte, entry);
 
 	return pte;
-- 
2.20.1


