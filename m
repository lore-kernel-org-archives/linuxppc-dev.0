Return-Path: <linuxppc-dev+bounces-26704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA9EC79FAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf80w0ppFz2yFK;
	Tue, 08 Sep 2026 13:04:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836656;
	cv=none; b=A9+VRUYXJjcb9AG9NMXFRwunvL31rGL9RNVWL4LKH92psHfKdbHXHsM+E5BJAEWigXrmeY9TGycKDwZkMYrBYIz3byqFdbdghR3peii52ArdDayq44rvf0wOdIG1pLWKO5JZRIAdLvYHnXhq+TX/E/XVgpm1qkEWvX/9Fu/wv1qfrR90ZeaYH3PosLc3yspppetR+0Fn8NwPnzHbELeRE6py0m9gBeaTDYjRK/1iXUatCTA4LkcoY5YhkHQxyGlaNWxfrx22qwnmIrC6Rq9mFxffKsIf0RAXZKSAmc9MG8xRP3ozYRIVG5XXREHvFixjOUpqEo3Gn3SwMrIo4jEpog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836656; c=relaxed/relaxed;
	bh=w9QdH6WsgivxpcgrN4flEbJh0Z1iEZy30Xh6LMeUuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQl+11TevCNA5uN/e04BaEg9CIlt2BVZOfEnimlsAoIgIvjrhPtZstWrpK892/6zIF5HP4Q6yg5CbIZnMlubH0NVnXCRUpnzBTyY2LJHUholplwE7hJ08acNlpp3SI9iYJJ0st4cCHdSuja8ONdsxTU1+rbh/N7S78evKM0TW/RYPrkI9yjl5hpz/IUEO11hnVMWMjCYVcBPuNg2+AJ2dGumKbPoawzBw2AoX8pCQOy0akIZIc82eSu9Zb+rFyKiwnDhP5zi75krkwAWM+uTsdGXCwuRIptXGCxdD8ioRNPMIJK2bZtq1QKyK3v72pysbd2Bilmqbzirqw0Z5OGLQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EiNjC7Th; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EiNjC7Th;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf80v0bR5z2yps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:14 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8525efa7274so2750557b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836653; x=1789441453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9QdH6WsgivxpcgrN4flEbJh0Z1iEZy30Xh6LMeUuak=;
        b=EiNjC7ThQ7QC18SqgYdGTAaNy+/Oy5DlFySHOZvrvXYjKWWdgkNVkuH97MT54n+PvO
         fi5rrVcOLiCgadRbTnxmsWQHAL5ltRbW+3jxhcemBbLu/kaqIN2f3bWqZWABZlZzaEdF
         rH1Kj9oo/NvOZqSKan+IFC6jZtreBLXK/vMj0uLNF1uL1en9LROzU/gML89siBj9Hopy
         aY/ZQ+I2nSNSqCRoEi183dtDikZYANps5CYqtMEA5JDWASjO/LBKHJmgSp7XtXoTusbQ
         wCeFONj0uAr6U7wbIlEB+cPEg4zcp9KOrG+2GCInTt1EZVmKx2ZPXFG0BQpcCP7vxuin
         k7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836653; x=1789441453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9QdH6WsgivxpcgrN4flEbJh0Z1iEZy30Xh6LMeUuak=;
        b=hpyjDXuXxFoL5Ym6A68iBydEBiNDKAUh7qK59K3TWvc3mSnRtIXTIexLNbIvkz2sC2
         c6H/qAf0cs2C8edKfLn4zt7dTzcvI9AyBFbFv4y5ZL8me2LiCQGDBhiy2h2QkYhmq5mK
         5AQKUETZvscb5Ia8CBw5o8RwH9BfIeFYbef9h7BoOMRk572v2dmgSL3l1r+wkgahElTq
         J9jKdJr7Z6swQm3vQDzSyoqYjS0gRGizpCQycV+UA5DmleQk06sJTbyOvQTSlmvDQ93+
         p9DCHS3dvYD247SjTvoJVSfehM10mqXPCl1pFtdjspWYubw6MpTFevpGITxKkjU5HQAZ
         r4IQ==
X-Forwarded-Encrypted: i=1; AKwUvBzz3UBrlL2UUEkLvtzxYiOUHFkjpyOjVr7WUYEQbnzHjNW3djmiYrpuoF0fZGM5Ma/iOp6JORC/TUWbW+w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k5/e4fye7cPkUpFknx1t5yD7zGtSiEtbOnQv8hYPmd5OQ5dOhJ
	Lj5szHEeB70AY18kjU73iSRlKv/vJBh+tOtHy83hrjj0n2QafIfeoJrk3uBBRQO58b0=
X-Gm-Gg: AYBFou0MdUcCyro5qUaHzjSQIeD12t4PIyePRSYaAPsH8ibCF3NrEyTHX8gN7sszlac
	6pTwE/P7dlVyvVXR/4zdjtp5N3/2JbsbM/A+unCm7yo34pjx2x14erld9o8wAWP5wfXuUDO/QTb
	SgA9m4ECa0JV409xAGBpZ99t6P5kOZafdN6p6B9iEat7X17dv/VHNSYWxLvAPK/wA8qvqTvchs+
	zl8oxvJ5WGl+fizma7Tlhhns7FD8uxHJTkUDO0UNvWjpghe0+lR1e1X23xfcdMphVp7Shwk9Sy4
	th8ijI0/c6c/h3Jlv5aiZO1n5dI+QtnIBY8IuPoBTMMRUP0ChcE1eKlMsYIAANlKR4oiyA1xCVB
	hDUV1dlyaX5WOad1bLMatT4aJ6j8mGrix6KxrGQqNVYqwRV/DKcn/GfuUZcpDIUD7yUK9MBTXMW
	IkVnFfG8IU094K7aBbXbS8kLAAuplPgLqLVODkuTEpp1va3LoidsgPk2SEzi7Aa1wMVMd0hs1Qd
	prJhf76i0r1224+NFV1YGDQ
X-Received: by 2002:a05:6a00:3021:b0:857:727c:a1f3 with SMTP id d2e1a72fcca58-8616907fefamr35713322b3a.21.1788836652665;
        Mon, 07 Sep 2026 20:04:12 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:11 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 03/11] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Tue,  8 Sep 2026 11:03:27 +0800
Message-ID: <20260908030335.96549-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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

init_compound_tail() is only used by vmemmap_shared_tail_page(), where
the shared tail page setup intentionally passes NULL as the compound head.

Keeping this helper in mm/internal.h exposes that special case to the rest
of the MM code and can make the NULL head argument look generally valid.
Open-code the initialization at the only call site so the special-case use
stays local to sparse vmemmap optimization.

No functional change intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 mm/internal.h       | 9 ---------
 mm/sparse-vmemmap.c | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index da14c56fb24e..0dca33db068f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -786,15 +786,6 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
-static inline void init_compound_tail(struct page *tail,
-		const struct page *head, unsigned int order, struct zone *zone)
-{
-	atomic_set(&tail->_mapcount, -1);
-	set_page_node(tail, zone_to_nid(zone));
-	set_page_zone(tail, zone_idx(zone));
-	prep_compound_tail(tail, head, order);
-}
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 70143dd8b579..e453ce4675a0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -189,7 +189,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
 		page = (struct page *)addr + i;
 		mm_zero_struct_page(page);
-		init_compound_tail(page, NULL, order, zone);
+		atomic_set(&page->_mapcount, -1);
+		set_page_node(page, zone_to_nid(zone));
+		set_page_zone(page, zone_idx(zone));
+		prep_compound_tail(page, NULL, order);
 	}
 
 	page = virt_to_page(addr);
-- 
2.54.0


