Return-Path: <linuxppc-dev+bounces-19331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF8F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:53:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXSq2Zxyz2ynn;
	Sun, 05 Apr 2026 22:53:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393611;
	cv=none; b=BlSkwAXhm00D+2uUAiQkEJZB0lBsILtzBr8qBU4DZEnzfaeS802CVc8YHNXEBJ9g5At1GaUwEb3DFyK7ohIPm/efOiizAPgx4NNbeImhlhua386akxEX4yQqxSkDrL+u/ufzCC7sh8b7aKnzRaOqMVwPz1fvXksQUiUnrVnIanqFoWZ2fmT0dRo3MYxrV2zzzuwt2nBRwnE6goKK2Uv306qGOiNQKyhLxFbZDzj4WjRN8VCHvibk+uTik1mT5em8vIt38As9NZxKNmij9FE8qCzABbvP18LNpKKD7BSh9tyOlsVHZ/z7bjQQRcYWD46C5dy68pbPaSyRl1eTBwv/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393611; c=relaxed/relaxed;
	bh=iSQZfRjRjpxozRWOnZuEHxRe4aXVCopNiKXhl9pDTQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYAyutbGp6Q3waEh4kjejUHL98zTTeznm4k7q1LJvYVP/xVUwbcVmXE5RZ0RUpuDpQWuRQQvHwQh8LywFBKCFQntIAzQ7Dw2eVX/nhX/7wSRa8ClHS1ygrbs8cDL+hmfFoTzv3XP9RpQKenUyTxNEWu7mTwBcgk29WWME4BsSxwKkzA/HuhxDATaUOsUyAMHwQ4JNFpEveBzc2WNzo7yQDC4Xn/U7MDv3pqvmL1f7U+tovwrr5Tk2YVQdi09IEITWoPadZfNgmqE1WqXZW22EPiqudJlgXgm3Du5mVEB4BBsg8jSFf4ajjgBNNWkpIG4RijnA3NSQGFqyd+R5wS1jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eK+EuRsY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eK+EuRsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXSp32GPz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:53:30 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2008874a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393608; x=1775998408; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSQZfRjRjpxozRWOnZuEHxRe4aXVCopNiKXhl9pDTQQ=;
        b=eK+EuRsY9ICzA6AxkeDLcGBCfYPsuZtBXb1byPoxZSFjY04lYLVSszoy56ysFkZFsv
         OKsQtP9fcXO62kK1oUKy9V5tcrayPruf0hG6QqIn1h4DnULtQKA5pEGpWs9O6eDuEJOh
         YHecqdI6Yxcx+Ehe+V80WWh0odj2eNc+eC2E7zxE8377f0gM5Fy48vDfpI4MOez1d81R
         MCb/TmLx2Q9mz+Z/qdWEPfn4Ai5xbhgJC/J8sek3pHAEBb0y1jyOmX3f212s9plr+rsg
         MhdwOZT0T2rq0TPhl6cq2uqDrIr7qHq0fgiPUHFgEgeo0Kxr+RZXuLX/g15gWDOUo5dv
         TyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393608; x=1775998408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSQZfRjRjpxozRWOnZuEHxRe4aXVCopNiKXhl9pDTQQ=;
        b=D60bqhkQ8iVYcHx4ePIGZRpLhHi2htj4PwMFsRGGaCi5cWKPFF4GYeHCq+7tkFyXFF
         4g/eVxjLPfRpBYnSy1xvD8wDi3SozQht2bw+MuIWb3IhTHyymYKdXAi39CKtw2N2X/Ck
         l5MdeLbA4nUWj1u+ydSlziCd2vs+4dm0hkZHkWp0j2v9nBe82VAMVGmkmGWp6r4BizvX
         zbl23dVqtJ11w0DVKzWwPj+p7q07HEMT5y8uQ7I07cXMHOGsoyVPjaGeevx4AxiHO1pk
         2iKJIJtEgSetWscEveFC6buusw6IokQzyNQbU5pKfBTd9yFR8KYpBoBc5GGqwgKS80uO
         OdqA==
X-Forwarded-Encrypted: i=1; AJvYcCV/F74+YlzfFlrKxLr1pOpZgXip4ZbPsB8kWkwlM7LBP9MbE0yOQ+1zSpbzRaee6HmAey6umN3KSQ2d0XU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7PcO2+6N1/AtXGRasCT0jM+StFg27e+1iMs7Vps57KMxNujrg
	hEEJDWMQicNZDA1vYLFbmcxqQd1lWz1xymcrCFsxwfC7uiLq5hOdXvOEEt+5UtqpENE=
X-Gm-Gg: AeBDietWJiF/zjfP+qt8GETovYHXwNl1oph0tWJf2WE70A55rRc8wJQQFcBK2ol5rOP
	VwxRGvnI3PAFSxWUc+CLwL8bROfXLoKau32nnwkr+qwjyaAIkFpIy3WsguP1FKHRXsvjCwJlqah
	lpChHIkKDV8v6ZyYup0SUwHsMAR8bOYHZXg6SZ3w4moF5c0SI8n5YtYyy60gTBtJLo26gZnl0gU
	fzIMVOxWXDWc/FIGh+NA3+174xf9GFTl66lJBxzed5bEZ3bbjqXSza10o5xvoAX8s5E9e39dcje
	1h4oyjFcpW0Tr4go4GTkhTA7pxwK9SMz0ro2Ut8earaOeXPBDU4c3YmN4QQkK8ZlwQp9idbD4OK
	TZBKu5YDVgX0aqvuO1Wp3sTtdDpILaf1TavDUEUF2u+abmsg8DdUWaNIn1obMYEOBew0pZ1/NfK
	Ye3Ki+pLIbzhOWGwllyQxjMcuIn+Rx9n1mn7bM4brJWnw=
X-Received: by 2002:a17:90b:4c4b:b0:35d:93ff:2854 with SMTP id 98e67ed59e1d1-35de680e77fmr9867916a91.8.1775393608080;
        Sun, 05 Apr 2026 05:53:28 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:53:27 -0700 (PDT)
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
Subject: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on memory hotplug error
Date: Sun,  5 Apr 2026 20:51:52 +0800
Message-Id: <20260405125240.2558577-2-songmuchun@bytedance.com>
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

In section_activate(), if populate_section_memmap() fails, the error
handling path calls section_deactivate() to roll back the state. This
approach introduces an accounting imbalance.

Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
memmap pages are accounted for only after populate_section_memmap()
succeeds. However, section_deactivate() unconditionally decrements the
vmemmap account. Consequently, a failure in populate_section_memmap()
leads to a negative offset (underflow) in the system's vmemmap tracking.

We can fix this by ensuring that the vmemmap accounting is incremented
immediately before checking for the success of populate_section_memmap().
If populate_section_memmap() fails, the subsequent call to
section_deactivate() will decrement the accounting, perfectly offsetting
the increment and maintaining balance.

Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..ee27d0c0efe2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -822,11 +822,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		return pfn_to_page(pfn);
 
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.20.1


