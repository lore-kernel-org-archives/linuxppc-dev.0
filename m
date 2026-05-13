Return-Path: <linuxppc-dev+bounces-20859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3A0CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0b0ZLLz2yFP;
	Wed, 13 May 2026 23:08:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677711;
	cv=none; b=c60Lk1YiKZQXQns5qOafZFG0sihYORCqQLSNBD2qkNEiio8nw+tpll/zFsEJTx18ABpBZ/rkJnezRm9EBKFx9BxqKGgQf/voZFsOK09m7bcTCPLGtFH22DO9e2655xlWsiiXuO43xqpXxN6arJM2jZco5brrZvOogaC+2Q+QQIWVzP1PAfRtNBaPjMIEpHg0i/EizxXTP7iIcXWTikQeX/QNcdEXAesD8KFI++k0+Ww0J+8kLbhw7SnC7piGCdlHQ/+FUr64x/I0q8odZoFHzBDsQ5Ww7kMPO108VtNISBxfi0vPWwkP9VjA++X78bL36e2l8Jo/FPlUcerc7IDe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677711; c=relaxed/relaxed;
	bh=/LCdC6mqaLMXTH7aZ0tMWbwialgwYp0mO7Qo6rGSxZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/ffbf9OZxkObyejWFZIgbbPuvTnY8MSFSfN+1WL2Q42aY76s4ufAatG0wO+xRt7T6432gqOFfobUSjwIj0sQCYuZMobJU/JxO92mX7g5L/8yW0uwMlQ3Uw0pFYQVYIvJVSCyCZhXO1Y7mrpko607OEX3gpfkedWKaN53/9AJk7Cif0Du3WOEAFbWXEYIj4SopV+XyvL2xeYdldqxkasf8bWINzGIqPhUzBjYSSf9D3aHt49GxlXZJjhuIZPAnY7vQoO5Ul8JbFWBJrXKSVgX8sISL1KzgQH0ATHjdAh7TC3E38NXUffKbdfj5OigrlpO92oyRB0pYD9jBEsRgBwVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hDKoqrpm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hDKoqrpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0Z3Bb0z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:30 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2aaed195901so33207465ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677708; x=1779282508; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LCdC6mqaLMXTH7aZ0tMWbwialgwYp0mO7Qo6rGSxZM=;
        b=hDKoqrpmoEDMujzJuuQjYBrYGlMKk3tLtPTCL5VMTysQ+6lMQEAcwB+tKHFzYnKgP+
         H+FzoZGgJjkDTbtR7s4tiuVd7FYPSsKVnoNaaQFAPZXubRmif9D2UE2UyKsPZEWnaxTi
         XCNeuvwL1jIkSLNFfPsz5VhL5lBz2kBdIGB4at37jz4VLYfoXFe+c3yHwJcsoUybMnOI
         1doRZz6fu2OtNloMYsElfrq/lKp/EsTcTYKarVyA9WO9X1U+GOJnJNwN+p2JzDDaWG+T
         vwe9qpCV0nSJSBsSegdk+GBaoqWfdBKB/9Fp4gYaYfA9IUKdAi6cwVA9DMLayEpo9hmo
         DjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677708; x=1779282508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LCdC6mqaLMXTH7aZ0tMWbwialgwYp0mO7Qo6rGSxZM=;
        b=LGkAxTOgQt4EH4eCVHjZSRDkrtila+d8Afqz2cYz6ZARwjs4QNxbFDpsqNBCVmAb+k
         icIzHg3ij63enVV9BP1DVeHWcD5iQUuMPGRP6W9C7/KUUui0Tpcg68cImhX2b2lyVEQU
         SddZgnqdRuz/y++/NSY2o94VlN3zBt1b234xgcD0j+3UAsTtf7Sq25OIpnDLWPxM7pe4
         amw7t3SqO0yl+c11EGhqG/qweQ6MhVLNgWNz8vZt9HhhSfpwjHcyFq/z2oHKORiJnGaK
         YNsshNO63B4bISQjlLgiMnD6N3D9xfXiEApzN4boYb/Q7aKUJX0DQuYbPo72Q1L0C9ZB
         tOiw==
X-Forwarded-Encrypted: i=1; AFNElJ/nqtJHFyEV9nYF5lBeK63F4wnz5diI2YA4Qah2tb0SDbsY8M8X16wOmHnLm1gbkpQVMd+xqypliQnYxI8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWz9A/9CqrqcqvdPUDVJzJPirT7BZpPFmHjgcQFx3SjNuOELtf
	cW9/+EezZjs/WY1RkbtmzppDc3ELWdebTvs2zH+sSEEh69yGFLGMHm/9aBO4oM5PyZQ=
X-Gm-Gg: Acq92OGb4HtWyxeRS8TQ33zu5c2lPgZfaSSeU0+Hmo2zxYJ3Q7L44ExB7HU9EwR2TyN
	T4uWnhOQieD6w/ZNfUGurZE4SUbNQaeELu9xPkgWaLpWyQ+fFCHt3UjfQmuP6rKBNXIDNRMVF39
	U+6Way3V7OPXEogLONcH8yVLoZduIEuMj6xSsMQoYO3FVbc+BJkUhkZg+vGXUEmhpyD5FCPkKdx
	3TUILdEs5qMk8nX2NGgvaIT8XjGhW+d5Rrrr3ZmmN7lOh0NLjPlGJhTz0TpHJEr439+I+uwnXNK
	hizMSe+d6FX5Wse5m6qoVe1YefqoTQLvbUfh7sCMV3yN3m51i2O7hLOOBG64Uhcf5t/jB+wPOVM
	7J1fp/DUL3B/8g63yHEHxageEFORmMlB8zPekVrhQZXCM0wxmvI5XLfJvLw/RnbvdcHpS7LUmfG
	rXShG6pwwAKbrabsoDtSfzSLrxbCKfoWlVy4ZQfH7RaBRjtCf2WAkuizUA7Pwr2FOwgeCyXA==
X-Received: by 2002:a17:903:4b03:b0:2b2:a267:784a with SMTP id d9443c01a7336-2bd275c818dmr34598845ad.24.1778677708025;
        Wed, 13 May 2026 06:08:28 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:27 -0700 (PDT)
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
Subject: [PATCH v2 10/69] mm/mm_init: Remove set_pageblock_order() call from sparse_init()
Date: Wed, 13 May 2026 21:04:38 +0800
Message-ID: <20260513130542.35604-11-songmuchun@bytedance.com>
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

free_area_init() already sets pageblock_order before sparse_init() runs
for CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, so sparse_init() does not need to
call set_pageblock_order() again.

With that call removed, set_pageblock_order() is only used in mm/mm_init.c.
Make it static.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v1->v2:
- Move the removal of set_pageblock_order() into this patch
- Update the commit message accordingly
- Add Reviewed-by from Mike Rapoport
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 mm/sparse.c   | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 28d179cbc451..6bd9aa37b952 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1436,7 +1436,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
 
-extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75f98abfed97..6646d4b47796 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1508,7 +1508,7 @@ static inline void setup_usemap(struct zone *zone) {}
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __init set_pageblock_order(void)
+static void __init set_pageblock_order(void)
 {
 	unsigned int order = PAGE_BLOCK_MAX_ORDER;
 
@@ -1534,7 +1534,7 @@ void __init set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __init set_pageblock_order(void)
+static inline void __init set_pageblock_order(void)
 {
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 85557ef387c7..324213d8bdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -343,9 +343,6 @@ void __init sparse_init(void)
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
-	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-	set_pageblock_order();
-
 	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
 		int nid = sparse_early_nid(__nr_to_section(pnum_end));
 
-- 
2.54.0


