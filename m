Return-Path: <linuxppc-dev+bounces-20223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5749DFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YHm4l5kz2yvD;
	Tue, 28 Apr 2026 18:19:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364356;
	cv=none; b=M2OWWsKauAN7S7cG7YOlh1QfAgEaSmjODBZAHAnU+BQ0ZgdwehNRh6INflh6esF1EAWUFneVzZqkc/gR76cLplWxki/mnz309rUQNjKHL0mpQBcvJNCKmjJ95dxHkl+KeXc2f55GXS9aaq56BGtRSj91DOLby8kmJTZ96MpClpDgushjLNenlbW0kzY/QqShAfKt+8IGAYRuPQMtgKBEgvnxoTY7VhDVZnyPBCbGn+P+ge9irMyqOlERp7K1v4QbLJp9Uy67+3UzO4jY6xbWwW1Z+XE0Gut+9xQIJv4heWZchJ3QbnCaRixO/aDrGuBQ1Ee1M0degIiKWlCw9i9Maw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364356; c=relaxed/relaxed;
	bh=HM345nkBQh5gaxmYsV6Qr69X0RaLtEwieY1kCbsL1/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVVBdu8X0AALjQieNeK++tmzQTvZegB1eq+WigoY3aTPkX9VGGqmdeATXBCblbo43CXk0E25BhKEzfiaXsmGRdkYyoA//saMz5igzE2cLw9YT/Hq1FMzuCQbe+kS5AFHUN5qSo1KP387LlHvZwFsSuH1Shm2aNDI0s+a9h9iPFgaE/Z/fxSiwjrnBauxtJyQtwTkHk+mWz8TuYytI2ZywW1f80dwVlWQ3H+kNU6Md6rOorzJ8NQHkiZg1UlQ4pFejWf1tC9J0gGGquQnoV0LvFUb6SaAPhh8PldKwdgYpd1ytJ5ElKFZ+Zq8D/E79MiEpsDYfO9YGN5cceQX5BUy1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DJz6Izlh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DJz6Izlh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YHm0MfBz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:15 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c7973f67f4dso3296695a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364354; x=1777969154; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM345nkBQh5gaxmYsV6Qr69X0RaLtEwieY1kCbsL1/U=;
        b=DJz6Izlhw8oJY2gbU+sGSMlQwbVrExoOW094ukCLEofeNcieLZeE/vP7ynFs7blaHF
         WrQo09IHKTn9dwYqy4B+iNysm6rF+aXVjo4PD8Um5YQVK1jUNBs1Crq6J64r69OWpD0Q
         Qo4B6iFseARZn96ytFi5GAQssFs6w4nQvIYGzrdQi1h3Xpj/xou0pFkop0GhpS9DQPXW
         XNia/aYI1DhWQ+Q3g3bbPubEw9XvkoCK1sE627Hc+q2IND0+XaC4FgLBUtV+UzwLw8ix
         iNbxA6zDnUeIxTW+urC9/uGgyXbWlFOoO/S3WtYfdBQvwFJbHJ01vRwjQR5Xmtl6rQ2K
         qgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364354; x=1777969154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HM345nkBQh5gaxmYsV6Qr69X0RaLtEwieY1kCbsL1/U=;
        b=LQUAaxzvH+OXOPqnpvEmTwKtxrpzZDAIB+3bfoKzzfYZwSL+7705HBxSOQOSq51uea
         8LCrqXuSPWXie+yDmGg9RLsKgojOF1/JENgLD31U7GzLDrItpu1B7gft9/Tm2PzpcPRO
         ARnLr1kY4Mu//EsQZTtL+FiUmV8AJ3M3vM1evBC/aUlSDNC0XkXRnWSlzr7q/OlJt7l0
         QM5IDF8k/NkgimN8cNr7JrDadcvw+kM1Mm4B48KXss89Uxc/Z6Ja8RuqakkRZOh6yXVd
         QTiwWvkJBs0mCC7UNWN54t2du3RwwnLQLt51TLWebZfyOfkJZ2IbFp1aMxjEWa2ttdSW
         DNdg==
X-Forwarded-Encrypted: i=1; AFNElJ8bRRR9hEMhfV1rvmW08p0MGES0Z/BGoTMy9GnsAEX7MS2nk4i80eZa3oe8o3SkJcYEiKuSI3gfJRmBxEc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrOVGs8UtzHwuhN1rzPE4Rfwr+xtBC9pWIRDScFUdAA4rxeL0Z
	a/JNKeUqY+TkzTgjVMtxklm+UtOrV/wsYBvgx61lzp7qGYRXyxugJl6mSGKkod0KAZs=
X-Gm-Gg: AeBDietyJPaXPBxKJqduZGzmlGghLmAgHuhCBoX37zkXMwupinwTraKxYIjqo02vt+R
	rJzSy0BbAM9B4yU96bLZ8f/ZbdWbLZtqq+nMYiJbIG8Ebo7w+y0aNEBbmdfFj4SCQ4CxAI5a9dR
	Z9+GvX+/H2UUK/yOpcr3uB+vxK4g+9kGlxTI6w1k/WY8XTVJxDqO6eylYmKavJFbgTQQc/4tVQj
	NT2M0F4ooIEwYyHzu+d6EKeiCfx72BN7yWwIPkCYJdYZpssx59ywZV4fWxL2uFgvJdTZomfK/sw
	Syq6/4c5gsGa+AGJYWZxSVCXHhg8ZYzQqoxjnaJCSEHqYZ4G2phfNzm6kdPwN8diLhtXCWm8SVy
	eeWK/XPG9bX+8iy2PgN5PQkbxBtYDvg8Di+pyrGnRNp40aYEA0SXbAjvEmAPFMGAiNTOivSsrbs
	7s1gw/dxcCMOWT8aG7D726OI7t/tmSPHdcpfZDZn5Dtr+RuPwmwE6ruxQ=
X-Received: by 2002:a17:90b:5804:b0:35f:b230:5889 with SMTP id 98e67ed59e1d1-36491ccd608mr1594024a91.6.1777364354086;
        Tue, 28 Apr 2026 01:19:14 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:13 -0700 (PDT)
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
Subject: [PATCH v8 2/6] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Tue, 28 Apr 2026 16:18:51 +0800
Message-Id: <20260428081855.1249045-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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
index 4426abb05655..e3352284f635 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1469,7 +1469,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
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


