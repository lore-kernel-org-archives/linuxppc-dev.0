Return-Path: <linuxppc-dev+bounces-20874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CACD4F39
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2B1HC7z2yVP;
	Wed, 13 May 2026 23:09:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677794;
	cv=none; b=OteIVCOKM+Kw+znmMD9jaKo81/WtcNA0PRhiRV+SSrI2+K9Cyb/10I5KBKJHCHjT3+sfhJlhId9UroHnGCMrNR+jYrnZC8k8ecyiP30nuOd+M63+Xz64PSKV4IFp6U/zRvW7L53hZgUNgVU6qnFtsx6tncETkz0oawPAm6azIPKTyr97hd4XoUmHG9HMZ8vbiwIbWFBSdg2HP2DHh6OAlrAlMChAZ6WFeUwe5xT07+uDbGoWICnUf62RvwHtYTvVtR/o2p1IMg4pN4uNCI5bF9D1rsVkG8v2dMGOgilNPZPf25oXB3tndWDb5kaKDiiWrgI+ZChqR8TvRJRdKPWNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677794; c=relaxed/relaxed;
	bh=1fKIdS9sH5LMxvvJtquNIgVu8JwU6IdO6x0CAgaX0p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU8UwIOnT2gAUXnQt8gVNRrzgeJpDAnlQiLR0ZMKsxiDk5wnnh/zxpTiGeZcS57OxDbqVRGbQg/VQAFj61NFROykG3XUhBdAxCc6DOanNMff/vwH1viOVUPSiREvK3ZZN0Xvga18I0+HLwGe0CbpTvVku1GugCi++p21lqRmByDK9CEZl9vbjKDTJVYWBpAQUY1sJkoKo0hY5Ok4iKusE7l3xlytgTFu62QSj+7IumMNuNDGqImYONqwUC0or6zPsyn8NR/uKbxp+EUCcyrUfK3hPTGlHMmt/WHaZY51P0UHcs/ziXgHsUNzpaN40tLSUNN3NoDS9Vox4KWXWfAvuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lC8x25jZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lC8x25jZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv293qsPz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:53 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ba17c8cfacso68319535ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677792; x=1779282592; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fKIdS9sH5LMxvvJtquNIgVu8JwU6IdO6x0CAgaX0p4=;
        b=lC8x25jZB5nQioWDh4l2mGI+H5vLiRnL2QH9qh3e/aOX2WLiVatjGbsUbFsJDRWeK1
         oU0hX0XF3P6YL7TQbbiqjF/3OOzmlqgGtkluprPCyWrGh2poMP0GIh7mdClGOuewxJpS
         X5TSS/s7K+zfd5+YQUfhkrQ5v4Dw1JteN+LWRihZC+sWaHukDhKgYCnbED4IsoO8YaxU
         QYAecZfLF8Th5+DpJS4s6WA+U5zfjXp5PV8eRfUGgl6RvzXHYdffVzTQUgXG5FQm8nwj
         V0lGMgYxRYvsrR7fevE0MwXl00yTjst6+HkaFGuSPNKKqzBZSJ0wKXBaAdl/T5bBlYpw
         440Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677792; x=1779282592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fKIdS9sH5LMxvvJtquNIgVu8JwU6IdO6x0CAgaX0p4=;
        b=ccCwWCrEkm4MeSNgy7wIyImInviD4DrM8gMkKYxzEZ5Imvbo5HqJPmp7lhx0I1XlwZ
         lgG4xCUbMfapV5fGC7G0I+XpsTF0PXlxgZ4yIoPwYI42+n4TwJC7W3JNJI0IUTYGBYL9
         x+FMiPktFLmEnMxvDY3Wr8D7Pf2CyVmbhYr3M07GBqVuY5VC8erOt4tnbClc1Hm5xs2V
         7c5nuE53uATsWhRJiVINaWYXj++h0lQ2bxDWFhzAiRhdfAUfik9a3/6GUsmNDsmJtHBi
         Ed9U+6mrO57EwhIERgp+z8IYvh8V6QhbdhtE2q2HUUNaH+IBk8wFrRoJw0PjKCKk0bIg
         CghQ==
X-Forwarded-Encrypted: i=1; AFNElJ9S1SGJtR2RsydJaVlveWdzi4yyJQkddtbMdErt28LCpfdtkTtd5WIQSsJBrRRV9uRtxBpEC41OwI1wjtw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8cMxKgNjjHHDLe3jQxYgZR4Tg6scnHAmsUU8Et+yx/SX6+aev
	hHfzyZuLEkq2/gpVcoOYTKg9dd4SU5VmpYyXqYvfdo+8ho2WdcevtjKD31429Q3OKjE=
X-Gm-Gg: Acq92OH396jZEMZCqjnnCvyBn9DbVsVhcVtsIiFgeBrmEDt2/tXjzXCBo5Z7kl3OHrV
	yCRU65IL3grPyBTryFzGL3Ho23S6+bOHDFzW7dpy02c1y8IFRwHLHpFni96a6FDqwiT/7lc29qJ
	LBaCGQ7FRJcIFsr1OlLwrS/qFoBYH1ML7veLxMYwmr6ndCp6kms4kKFiBSbsNOLyWmkzp2duOp/
	QNrJvoEWKyJh6rk3e6vayb0J5+QHZ/tYddaGJSnXPvM51DGg7T0SsRI7VBi2xvJUEOWie6+r8ax
	PcTHGU+uksPOneuq2g0Kt+tpsk3XSqgulBKTmIpyet8gFSO9+4duX6y32WmdBCmAZA8vtui2RTy
	HQCMF+NrdTLZVetIw8fpNlrRx8Bey7gg6RiJT12Nj4d4EE5Hf0UZjc+c83HdVPKalF6pz506BNy
	thdRuvA4Fg5gsu6EFUbnGXWX3Y8mUX0BxVehobfODPv2jtzga1Pbu71Cff9VQ=
X-Received: by 2002:a17:903:b06:b0:2b2:50bd:83b3 with SMTP id d9443c01a7336-2bd27176414mr37032205ad.10.1778677791500;
        Wed, 13 May 2026 06:09:51 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:51 -0700 (PDT)
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
Subject: [PATCH v2 25/69] mm/sparse-vmemmap: Initialize shared tail vmemmap pages on allocation
Date: Wed, 13 May 2026 21:04:53 +0800
Message-ID: <20260513130542.35604-26-songmuchun@bytedance.com>
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

The shared tail vmemmap page allocated in vmemmap_get_tail() used to be
left uninitialized, because memmap_init_range() would later overwrite
it.  That forced users such as HugeTLB to defer the initialization to
their own setup paths.

Now that memmap_init_range() skips shared tail vmemmap pages, initialize
them immediately in vmemmap_get_tail() with init_compound_tail()
instead.

This moves the initialization to the point where the shared tail page is
allocated and avoids relying on deferred handling in individual users.
The remaining deferred initialization in HugeTLB will be removed once it
switches to the section compound page order mechanism.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 39529245d790..60d5330a8399 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -328,18 +328,11 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	if (tail)
 		return tail;
 
-	/*
-	 * Only allocate the page, but do not initialize it.
-	 *
-	 * Any initialization done here will be overwritten by memmap_init().
-	 *
-	 * hugetlb_vmemmap_init() will take care of initialization after
-	 * memmap_init().
-	 */
-
 	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 	if (!p)
 		return NULL;
+	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
+		init_compound_tail(p + i, NULL, order, zone);
 
 	tail = virt_to_page(p);
 	zone->vmemmap_tails[idx] = tail;
-- 
2.54.0


