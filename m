Return-Path: <linuxppc-dev+bounces-20115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE47FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LvD04j2z2ySC;
	Sun, 26 Apr 2026 19:27:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195639;
	cv=none; b=PBV7ETudGkGr06IBRDi70rZzfhLZNb0y2qnEW7GQwKKlAgIILFJR9W/RJoWH9NOWSVtjtUwaCueW6v94d7XyVCRsvwsLPAzVCRXwYQlfCYbwlmu1PXA5WEMZxUpmT7EWFpP3h3rLF40BvCSTNDOpA8arbebfWm347haYCSvW3bCLzzPb3/4sG7bvYWHYTsHfTwq0fio8Wt3ViTTaj9gkdME8YdaJ4U4F70H2+nxTcMWFRlqf2hXSKPw+N6do8NAM0CrKZ/5f5BEzIPepxeyF+PTPo6yGA6+K2ubvc3aVE6nJJk/b3AW6D3ZAZ1uiskXoDV7kfMWW3/ZwPEMZQi5a/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195639; c=relaxed/relaxed;
	bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGa/nir1kU2XHdg3DfyrQ6YMIVVLy0lWY6UMq99yahWcyDHOTmMU7UHVUSfv7V6w5+SW7J0Eai9oMonFqhnYHvvEd6YobNZMsKX90UtICkWsLFjUSa9UbCSNUusXDQkIpXNcei/FN26PUEyYUqqsZK07Z9j5f7kHcCyLZzN2vZEF9neb76m023IGcDVeMO5q6eP+agB4fEeX6bPW6419HHH16kqwlq4K0NP2eIARnwT0hJhw8vHrmwDRsff9sfCkvRyAFnsIaEJzA5BeiRoN0HoNTsc0KsIiWiFiqIc3rPvu8wpDqVDfgmXB5wwxKxbGrC0oQO6tJNBUGrBAWqcE7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aGuR+cn+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aGuR+cn+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LvC23qwz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:19 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b7adb38d65so30869045ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195637; x=1777800437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=aGuR+cn+/dZAMzz/gxtx1g/ieZxGpnpiSg3rZTzdWwMdb3swmktFGzT4YiIpFGCkoX
         QVLJjmsVKzC3YLvT/OgqCn2c4fAFipNtmpM6bYD6sG7dS9VXY+OUtbEOxdo4TWFq91Wv
         VrNx9g1Xa+O91Xb+D2kMLF7OTXk4MqCC0yTE7+cjkwJ8dWOLj8+/uZSUP70NytKlwbG9
         dShbMOqkf7UA8VSSY+AItvrIudUSIneqmrYrzjPbGsjOvoNa4D84uBRHyb2sSm94fObS
         3H46H14iH9Gr4m0roxY1fA+GHomSqF2uHIReDfWiRY5D21wmbovuUsdqbRb9DuJmeUOn
         0rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195637; x=1777800437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=sJISP0NXPcxF/EsfvxsAvJYF2W4pKAvTHpDS/gjj7sUQLAlXEUh0+d/WmcsCKT0SLK
         nLKCpdBggtDVe0IPNJE7Wxr1GYjN9O1e2tvuSHqkHz1DmB9ekE4iyHEpgZvYjluK21kU
         05jjbhNu0VSEE+Il1Y/EEl8crC2Np7iIIldb1O12R3Tx/VQPN1Xe9p/OyRELkMPuJ1oZ
         K4hK0R/vZjpifG9/sU+EGGjWVsNGN4c9MmihZMnNmDzrnepE5jy9zKYVzpgtEhhAfG7Q
         kvkSwhgJ0xSKLw+GWeI9EnN/RpwWjb8EkpUIfTZZL5rpO+1rUqbpCGtX1+XeqqD4YPdU
         N9bg==
X-Forwarded-Encrypted: i=1; AFNElJ+yxKVUhSQavY8WB69/GOSmYjjRa81KeouljTu/Twbu4UMBDCQz0vyqGWuSqSNrzozeXQ97n/MQ6p4NhUE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtCNftc3C+/oRXunLOHG7KRyRvo/ZaOnmqakyupxriKk2Kw84S
	XP1HUmAu5jjZCgg47QT8oHZuiEsuvc9EvH3DWwJ229CtQEd4gLu2QpiY1/sUvEz5nEI=
X-Gm-Gg: AeBDietj+PwvCtlc03LXdVQN58Yki5TbaWXBBIHknJiuOidZOZBlkQja94LmHnqEjhu
	/f4b/nH4yF3TUBGpc5NElRJJul7K5QItsgmsgU49A/hR8ADf3QE29VbLkFo65oJe9IhOLSjzmd6
	xV7xKxklh/DzqgTSLyhbr8hM+DLrtPx3HigcyGP3vDs/A3R1JAS4zT8/1O1DOb4TfB3b6iWsPbw
	0t/oHpSh4fn3JBr0VTUDw123avyedkOym3E8F13Bzh9kW4X6jTMzqz0Q5NFgS7m9wLcCJAyYxBO
	CoTZfw0+hMp/8iYAhyxatU4s43FnbYvbBOV/YzGBoau2LP+OARLGeZWrko/10HMrNlQgCHWfsoM
	DvCUnFShnFr67ZA9U3/Xz4MaGxh9bzRgmhFvky04q6mJHHrfNAiCTGYCEStxReuYKPlflDeQeZv
	VZFUwyLfpjsk//vwRwclRnnpOiWRFr
X-Received: by 2002:a17:903:37c4:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2b7abc0448fmr145875755ad.9.1777195637394;
        Sun, 26 Apr 2026 02:27:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:17 -0700 (PDT)
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
Subject: [PATCH v7 2/6] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Sun, 26 Apr 2026 17:26:36 +0800
Message-Id: <20260426092640.375967-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
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


