Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA9606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KJB9dJ9A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGNHW4m3vz30g6;
	Sat, 31 Oct 2026 01:08:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793369319;
	cv=none; b=hyiOZ1Sv2tueExoX/z+POTnOjCrQVlSuSsBE3LL7X4FFBGo2oIxzvK9nAci8JjZ2WSsQ2jZQhAM/Oys8UBsyOW5G6liOFQ2Ktl+mizpibqAHWc5wmsETUixJC3yQKUuxYsIxfN4I7nGKv2tT8AyTe9VFgIi/86e3sZ3fLRpdYNjBri43Mz3BiFjhERBxq/lAeDK5e65D3D+GPRunyYKwpd8JI7ywcKyqelT+tiAGuAU4f8MmmTT0eODafJnkVqKD8szbT9wz5S8luLbDXAmV0oAoRil9+KCyuFOT089QXG36LWHbocCAl7Q0vDVxp7l0HuOePcWhr05Z1glsmphh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793369319; c=relaxed/relaxed;
	bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4GFi8Rh0WNPwA2yqXKAxC1CUn8qenrtDQR0seeSGlNdq9kdYH+EnAedbh1iJq0gmA6k+EuAAxfEiYJDdeuQD/Od/pjCK0phoPmtlvcc2T8z6aoDcUJT4aFMH/0VB2k4PQhv+G4Y+i6REJz1FCVj+ypz/ovhcldkzbVOyLu/h7cJdEalhtM84w8bRu/eOzpJt7J7KpAX0O1Fh0ip4TORAnppaC0VlIg3FYX6y2sw8l8YTvohNSOuAWtCiV6dhzJJ4LtBs8mM1AT0BdTYpQ837Y9FSYuKJzwCMlu0tg54yEs+hdlp3tIw9CKL8szGH85gq92cAVzXDJBsJ7w9rHR1GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KJB9dJ9A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KJB9dJ9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGNHV4rK3z2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 01:08:38 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2e946155442so6576515ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369315; x=1793974115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=KJB9dJ9ATPaijWm+CxXgVWpdpam4IZwKjMry+UmErlK6P8sil38KUv7GdYLPROH81c
         sW3BTiBWZvUZOoe6c6LHdcMkfXd3rte+9OBwaegg7sHA0GOH5m8BwlFFBlay/mVzIK04
         nvZ5AiE80bz7jPSoZ4PgWqOkSx67QHLT+c3NeZy1wfneML3rr3avnuzmzeujK7pZrrKb
         xhmEyX2+jiDj1JaD6bhOSdmcdDIv2Tdx7rtttyPrTvKdjNdze57h/OUDr87+R67PaHrN
         /QqzO2QKTxIYvrociMu5ngBbtm3gqTPD7/dg0oA5O5UoWCvtDrDmqx8lGyfPH+4RUK/p
         rJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369315; x=1793974115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=RkzyVs1AeHTpNo3GRhJRTN0B3e5gOU9yYLNgq83y/8EOR2LLNCIJzq/tUdQzP9L0+K
         UahEGcuvhR1pU9Ed4yvltgKkIYEBpBPEweMFYorqWVIaWzc4l/iapqaJlMB7zY0rLWbN
         tiVDZeBoTRKMPBrBEPX1R2vNsdHrL4oX83ZfXRaJSocFbUwEt6nJdtMPIAvbUiZvGxAd
         YSAE4Kf+7wyjPARUMSGdPeej3x7XOkxAkIL0vhrStiLBUr+i5VxLi679lCsC2yqmwVGc
         p4p1zBvAlsnnbckNA0xxvnPL00jyh2qslu5ERE7pPqLnj7hveWV0+YV9v5OWf/l/H7WC
         557w==
X-Forwarded-Encrypted: i=1; AKwUvByXlkIHVGB0D00CdHUWMj974w/h3Pj5n1oSezFNy6UX2HcEny0wCK7A43BPvp9/lHH7a1vJ88NV840D7bg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLDM6pV7qS6we6M71jMCJYTJpsp2W3+qlk8wue0XovxPBw0XlJX
	aisYAwT0YQnojNxMWzgWfXgbbnifNGQcB/ifPbBcmWehMFgCSMiQYHbbN20RjyK+Kao=
X-Gm-Gg: AYBFou0Cm0enqXTW9ICuseOcOYSiXT2LAVX7iQXxdhGR+7XZuRipJ8WvSIeAJLIBxQX
	cZX8SmNILcgL+9KZ+lldEUvoPb5FFeaWOzkgWuXq5M8Y3qxv6U70DVZgT12cO3okZZ8nTrTDJ7Z
	tdjQi1p2IToEb/+28WC4PpZRTqZxP0zEW3lw7Xky7jwrHF7jG3VrmtFRzU3JZilCbt3R5uIIArt
	S+Pc9IHVqH3j2GZQG42vB6hDYeSzNKQ3BDEJIhdYLqe/j1WznagK0YJdBmit1aA5Qw5OFjdoJk8
	v2wk1GOz7t0/77FEL/QDsGczwcCXKOASKcyQqnC3+bLbLeD4JgNv3+Wh3ja4TxiDwCJionGVpXk
	4GQjC/yl2Q/EIHI6JYSsDEdffzstdrL4busIBTicoJU5jBQfNMdNZFNE1Vlx48fvay/3AEzf8oS
	Aak7eQ4fjbWHUYqIGZtJ/mYF34tjvDdDV/6uaWVjE0MPvQVd6h9Nq54ivGuIo/AmpzNEgy3J4PH
	chRRaJTsPQ3hzotpZX413+K+PNdAQfywM6YsJQd+OzEks0nL3l9MejUazm5x5OlYcKofsG8D9qh
	miRdtdlG92MwygEMylbfSundd7BtEcgn2YfQloiCHgeFZ5xcvxM=
X-Received: by 2002:a17:902:e5c1:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb36414ef0mr26789535ad.5.1793369315295;
        Fri, 30 Oct 2026 07:08:35 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:34 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Fri, 30 Oct 2026 22:07:17 +0800
Message-ID: <20261030140720.1256062-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmemmap_populate_compound_pages() is no longer used outside
radix_pgtable.c.

Make it static and drop the unused dev_pagemap argument from
its only remaining caller to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..8452a2714cb1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -356,11 +356,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ebac5f9058f6..2924604fbb38 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1117,7 +1117,9 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1132,7 +1134,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
 	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		return vmemmap_populate_compound_pages(pfn, start, end, node);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1228,10 +1230,9 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node)
 {
 	/*
 	 * we want to map things as base page size mapping so that
-- 
2.54.0


