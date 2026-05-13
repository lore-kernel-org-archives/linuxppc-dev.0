Return-Path: <linuxppc-dev+bounces-20870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D2CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1m2hD3z2ySf;
	Wed, 13 May 2026 23:09:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677772;
	cv=none; b=kok7WT1mFLzhWzqrbTdI1Yx87NRtITlSyk8SMyMUxTV39qppQDDYDVQzBDImywAMrpeaTjAwzeFtm0TK/urrJBOe+BkDUE35w6oO5fhiTIqh7kgx3eK2Vzl2pE4o8CKj83T8AG1EDf3PWZ46M/wsP1dJIqczYi2gpUI3sOkawUdtQXn/h5ZnraVLavA4Yp/QQ5OaVMotOTipsZbOCkqdiUQNOAxCfcgh64bqIRvWci1CIbxOHlGkJyu7S9HqKgXeKRXrCW87RddM3mLlOV6NHeupBXjPd9ei5oPwu9eH6KVgrXH7/gOgB4Q16fSRk4jO4dPmH+s4aypG32pJao32uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677772; c=relaxed/relaxed;
	bh=G/meEdlZTZDHs3WMdtJ4iXM2mc4vrDnOJRWI7aUMJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/4lMk3u/ol4nZ9UUDi+Xz2nIq3Ml6qRxpdvnHtTeiYkv+5TfWvys0v0cJ1Jjio+HQXotB/gZMw0awbtJl0Vber2gavj+QLfI2k+m0dtcU2vrR2Q7XGpnR7sKGafqLqOOgMfqqNEzau59z7V9kj+9Wxy9eWswWhJz3WKpeDD847W63o1t+Ahu1qRsJvSNkqlYgbtI5POXJs6rc6C/NK1iMYG46EV+1beuOFjZ26HTMt2cYs3f1CAB8KztNMmMxGvPVuBp0WsoIWtqJdU16BArgxg0iq+NRYexCDUgQWyN1J80ET7+XKh4AKij43vT/hZ5WAhxBZcwXo/kK7gfO+dRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=djn+rtZw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=djn+rtZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1l5NgDz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:31 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2bcd730e090so24803715ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677770; x=1779282570; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/meEdlZTZDHs3WMdtJ4iXM2mc4vrDnOJRWI7aUMJSw=;
        b=djn+rtZwDh3yKk1ZD5naOuebg9z/N6T0xVSEiONNWtJ2PZS+2eUQie4elmjQUoJ71z
         +yVpNQ7AfV5I/Hab0bQuiFuAwaPK2CKzPZ8w32YTSGykal1KkwjBr49xmx63qtoA6RNB
         1T2R5Y66Yo6dD+EhUKMZACq9Ct0pU1DiTei/2TABNvfhKqjoX6ydUjIYLzLv93NkrNAS
         jvAc5Gg9EsCxQhGKvAfaPOibtXKDS4sGUB2tOBHauD8/clzAOc9Bd0gURQ8bG6H+MWxp
         guotdUPGESJjdZfOAmmlwH5KzelK0wIoIEGqVoUC6Y4uQbkdit6EF3hj3kegV1edrHhJ
         8rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677770; x=1779282570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/meEdlZTZDHs3WMdtJ4iXM2mc4vrDnOJRWI7aUMJSw=;
        b=l1ED7UILXva5V/GuMHBuC8HHkWinqObVRA/cDgMD/mJMkZiBRG1CvheoCX3vfRI33b
         KyEEROCip5uOFyB2BL88rrtV9eOx1kHLFBYl/lpMugHMo2SE1Iq2OUxLvt+DnDxoSZcK
         3pFTVsbKLla1utwhFH1r82zNTZjYIRLorJsaXcal0D8iJ0fwg+Xupw8oweqf08ymztXv
         Yhl3E04TWX2jXTZbBc/969IKXeOq1nQ/ynWNPqxs3segyGe/K5bx6Euhy+30bC09we0l
         a5fxGKjOkM13r/VRcsA20mUyi9WhEAL41NDca1JVpmRAe26WjZr3LcPyFd/zHChBBaXP
         uWpw==
X-Forwarded-Encrypted: i=1; AFNElJ9jsHRe3972A2pLiXtmtlE2yBB3eTY5E1JYR7eslt2844lhm3gqAonyv7SfNzBTwnTpSkMZFwBZYg39XSw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxCGFki6pvt7xou7jvQbvBnu6EUDsWhNXDjMxBRw1tFSO+dx0uI
	wdUcGzcM7hBobIOBe9hexv/CTa3/NQjrOWOks3Ni0ZKEx+XKwvHJoR6CbMO0eK0x7hY=
X-Gm-Gg: Acq92OEh7OEyQOVaSUNfEqcs3Prv38f3gu0jmTrDNrHAAaxEvPH/Za8hkZ6tKMPQ7Yu
	x896/N4JM6zhaq7Kq+8r+rMWbLMVPJ1rvs553UaE8ONpWxhdIP61QIZtpqJ6S7QhGpXKcQKuCy6
	9RwL6mA/6dQHDrdWVQ9b6VOGCYfdbuNsyo70mOqiko79a2Q0LAqPM9zbRNn9EZMQcRv/5XwCEn8
	QhVBLEhXayG8XZF+DkrlnnkjoIyI0xelovFVF9A6ONgOGW08CF+nENbi3td9kHTFEs2wgN3gBQ2
	TLKdxrRshSd3W2RD6gSxWra3GE7CH1X4FphdCwfQ+AJxl9RSa42qgF0h4ZvdUBREwjBkYHqaACZ
	QMhpJkXc4aDSLOhWTVXVjPC91KqkVBARh2ncSVgrC7a5XebVCAtlX0sz19pIfYbr9N/qSCy04On
	4VHvvAW98nSQGhnsBNEjqRRqugzj39XDoQsRxOTI59aS0UDctFI7I7MOtd3vc=
X-Received: by 2002:a17:903:38c8:b0:2b0:6f21:8289 with SMTP id d9443c01a7336-2bd30210f0dmr30869055ad.25.1778677769571;
        Wed, 13 May 2026 06:09:29 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:28 -0700 (PDT)
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
Subject: [PATCH v2 21/69] mm: Rename vmemmap optimization macros around folio semantics
Date: Wed, 13 May 2026 21:04:49 +0800
Message-ID: <20260513130542.35604-22-songmuchun@bytedance.com>
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

The existing vmemmap optimization macros are named in terms of tail
pages, but they actually describe which folio sizes can use the
optimization and how much vmemmap backing an optimized folio keeps.

Rename them to reflect that meaning directly. This makes the names work
for both HugeTLB and other folio-based users such as DAX.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 18 ++++++++++--------
 mm/hugetlb.c           |  4 ++--
 mm/hugetlb_vmemmap.c   |  2 +-
 mm/sparse-vmemmap.c    |  4 ++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 362e16497533..40b1cea98b82 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -107,13 +107,15 @@
 	 is_power_of_2(sizeof(struct page)) ? \
 	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
 
-/*
- * vmemmap optimization (like HVO) is only possible for page orders that fill
- * two or more pages with struct pages.
- */
-#define VMEMMAP_TAIL_MIN_ORDER (ilog2(2 * PAGE_SIZE / sizeof(struct page)))
-#define __NR_VMEMMAP_TAILS (MAX_FOLIO_ORDER - VMEMMAP_TAIL_MIN_ORDER + 1)
-#define NR_VMEMMAP_TAILS (__NR_VMEMMAP_TAILS > 0 ? __NR_VMEMMAP_TAILS : 0)
+/* The number of vmemmap pages required by a vmemmap-optimized folio. */
+#define OPTIMIZED_FOLIO_VMEMMAP_PAGES		1
+#define OPTIMIZED_FOLIO_VMEMMAP_SIZE		(OPTIMIZED_FOLIO_VMEMMAP_PAGES * PAGE_SIZE)
+#define OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES	(OPTIMIZED_FOLIO_VMEMMAP_SIZE / sizeof(struct page))
+#define OPTIMIZABLE_FOLIO_MIN_ORDER		(ilog2(OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES) + 1)
+
+#define __NR_OPTIMIZABLE_FOLIO_ORDERS		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
+#define NR_OPTIMIZABLE_FOLIO_ORDERS		\
+	(__NR_OPTIMIZABLE_FOLIO_ORDERS > 0 ? __NR_OPTIMIZABLE_FOLIO_ORDERS : 0)
 
 enum migratetype {
 	MIGRATE_UNMOVABLE,
@@ -1146,7 +1148,7 @@ struct zone {
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	struct page *vmemmap_tails[NR_VMEMMAP_TAILS];
+	struct page *vmemmap_tails[NR_OPTIMIZABLE_FOLIO_ORDERS];
 #endif
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f0a0e31d624..53448b05ca11 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3318,7 +3318,7 @@ void __init hugetlb_struct_page_init(void)
 	struct zone *zone;
 
 	for_each_zone(zone) {
-		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
+		for (int i = 0; i < NR_OPTIMIZABLE_FOLIO_ORDERS; i++) {
 			struct page *tail, *p;
 			unsigned int order;
 
@@ -3326,7 +3326,7 @@ void __init hugetlb_struct_page_init(void)
 			if (!tail)
 				continue;
 
-			order = i + VMEMMAP_TAIL_MIN_ORDER;
+			order = i + OPTIMIZABLE_FOLIO_MIN_ORDER;
 			p = page_to_virt(tail);
 			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
 				init_compound_tail(p + j, NULL, order, zone);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 952216a49bcb..e9906d32a64c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -495,7 +495,7 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 
 static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
 {
-	const unsigned int idx = order - VMEMMAP_TAIL_MIN_ORDER;
+	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 	struct page *tail, *p;
 	int node = zone_to_nid(zone);
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d7e9fb47f7ee..39529245d790 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -318,12 +318,12 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	unsigned int idx;
 	int node = zone_to_nid(zone);
 
-	if (WARN_ON_ONCE(order < VMEMMAP_TAIL_MIN_ORDER))
+	if (WARN_ON_ONCE(order < OPTIMIZABLE_FOLIO_MIN_ORDER))
 		return NULL;
 	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
 		return NULL;
 
-	idx = order - VMEMMAP_TAIL_MIN_ORDER;
+	idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 	tail = zone->vmemmap_tails[idx];
 	if (tail)
 		return tail;
-- 
2.54.0


