Return-Path: <linuxppc-dev+bounces-19354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939BAF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWl2b2Rz2ytj;
	Sun, 05 Apr 2026 22:56:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393763;
	cv=none; b=m8vC6ED2oYjn+YTYFCWDIKrb6Cqw0NGBJCI77Nn3mcdaVpK3yT1FrD05yTcFPyssx5uP8K3W+6mPjARen3rr5y3IbIlOX+1S/R0ZVVbbWsivUJALmdNbLb4RQwADNrXyK2F0vCxkQmRbGmgkxu0v9U86ubNBNYe2pFRxCiX7cr9zrjEJ+BatIwutsjQFvzvLaiiS79XyIq8al3vgWvMihIR/Jd/vzD6DQ+4vgq77zFUHjngWckYWvZkXx6rNkkjjkaw1ILVPN0ODc6GyZrS3jb6kco7Hx3G847PG67Q2hD3WuMXRkDhySXA4cl5WvHV7OmXYjYK9naxnEBCuXaKevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393763; c=relaxed/relaxed;
	bh=Mltk+8iYdxXiKYafIwHZmXXZQXNazh8dOc5/PN4fBuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1MpaxxBfWYgW5o+bDcKeaULxlg1ynitPFhOgfGvns/QI82JEx9JQllHrri/3RG8Hr7JTgYfiB/kUBIGgWUWI11CGNmJqdSiaMHiiPGDhEC6qRekuZwFLFBrGVqqU8x6Io7y7krSugC4IBXZGt03L4KuVwwGQsBhM28wKDU4Qgw6nXLI2m6b2FoQf05AuqluLc2R/wD19LyZjyM2rRAXj1UgFG5ZMnZWe7N9V8l6FXSgSuXhCJ4yMHHwYbgLybnXANauxkqhBi8zk2MCtT/ivxouUVaIKWBkpUEa+b9+UeFjQ6ncGAm++tcBtiocZgsc3qG/oT2/Ey7Ggacm28LssQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Bai+42H6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Bai+42H6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWk588fz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:02 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35d9827661bso1534770a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393761; x=1775998561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mltk+8iYdxXiKYafIwHZmXXZQXNazh8dOc5/PN4fBuo=;
        b=Bai+42H6I3qU5Zc7VNz+5PoBbGFLdHlFAx5WVBpoaxEKP6neZ1fOaIrKhtU72c1CqC
         I9ehXL4g6hXJdpT2ov5UoP2xu+zR1tJaFmgTCK8IHRKcQOFLfhUxDKekiCivoYHOnt6F
         08DHptYnvX+QW/0uoQTXfdgc2NQoPJqha3e71snoB6QJ7gVTu1UshpVJX+80fdBTF0ay
         FH2s219++GOSiJPVmrgKQaUEadRyt0SXJXdo2d7qLVv9prn5+miQhsQtATYOxK3Q9ohP
         FGbuQt5jQKHnVTt7Ul1icWLMdwAQEbNQ7JfXtHUgiocbdWZcdPrANk75WMFNAYhyFk0A
         bhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393761; x=1775998561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mltk+8iYdxXiKYafIwHZmXXZQXNazh8dOc5/PN4fBuo=;
        b=azGH5VjI1pr/olOpfP+4CLfJi5i8Yjh7uVWRj0bsltB2rjcA5Yx+Ahdu4xaiukL+Vn
         z6AHlDyo9aBXQnzXbF1Ar5LQVEBstzGwadk22Tk2cN/kB07nzo35ofhYX/23/y6kWLYZ
         wlLKI3aODW4bL17744Y/mLdL2+Chv03qXmPH/woHgjqZN5gkdUIOSma2T6AifO2ZNmp8
         CqTyH4Q5hU/Gl6LCiZ87CSktTUMksGxVYeRagGXGK9d3c7AGPykhnb4j9dtOUH8vs6Vl
         VjjS7uPbyddh7PSGn9voNa9S6lVvnyCY5l3yWfUk2QiFd9ocsHq3g2SVuASUBSRRNucg
         2zbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDAsxDYmL9srXF2q5AkOflH4LDW10Zgo7WyzhDA0XanNsup8x7Ut/2In8tpnzWj+MSucHtycPo5L2v8Lg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyH2s1J3Z0rh/6bvX0YZ4VAoJ13iqCrnqiB7dQfP9jVtyGdox9F
	Y53lJ9znOtVkAZmron4qew1NadJGmfZcPtDRQdMzoWDIlw1ZUfaw/7T8MO8uij3jnYQ=
X-Gm-Gg: AeBDietEvC15skG59zrH9fXgTfUxJ2oAWFezSmmZ2zRzuhm5Nc47tYGRXlcmuBXhDFz
	Ef5SS2Hq4yO0RBvCJhyBr0m4BX0Zlc12ZRxXXgDwIo7Kd2mrKeZGaghHhvDtY+ydK+eri/BHGlX
	FKhOK59k8kG86sduyfgZWoqhtRyUX25h6OJJ5Y0G+Wb1+ZAvkWX4ygzbOeESpJC9E94QhH6PK7C
	TcUZA2031k1X0zWAL4xGZNJvWaryktQN6YREx6q7BPAJF66OxiG4+K6hj/E/EObYR+GFuzwZ3DV
	PhnsJn9ggLxTknJdMwbbIW4ISBPBY01Ji+CVhjZhWgKPjDOKRm+vN1SGbvebCo7a+u8/8+fwx3P
	kuzLJhwXK40gjRc+CEMckzV0+oy1zstf/Yuq+AUnFQQcrxVDsq8JR+R9ifCUy2ODzO3XeDkLTgJ
	LGRgPnFjwhLVJw0MwSMCKK6W+WJ0Ea05iYtyHENGsZoIDya2iWMPxJbQ==
X-Received: by 2002:a17:90b:4986:b0:359:855f:ff96 with SMTP id 98e67ed59e1d1-35de6942cf7mr8878256a91.17.1775393760754;
        Sun, 05 Apr 2026 05:56:00 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:00 -0700 (PDT)
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
Subject: [PATCH 24/49] mm/sparse-vmemmap: initialize shared tail vmemmap page upon allocation
Date: Sun,  5 Apr 2026 20:52:15 +0800
Message-Id: <20260405125240.2558577-25-songmuchun@bytedance.com>
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

Previously, the shared vmemmap tail page allocated in vmemmap_get_tail()
was intentionally left uninitialized. This was because the subsequent
memmap_init_range() would unconditionally overwrite any initialization done
here, forcing subsystems (like HugeTLB) to compensate and perform the
initialization later in their own specific routines (e.g., hugetlb_vmemmap_init()).

Thanks to the previous patch, memmap_init_range() is now aware of the
section's compound page order and safely skips the redundant initialization
for these optimizable compound vmemmap pages.

Because the overwrite issue is resolved, we can now fully initialize the
shared tail pages (via init_compound_tail()) immediately upon allocation
in vmemmap_get_tail(). This simplifies the initialization flow and removes
the need to defer this work to specific subsystems.

Note that the initialization logic in hugetlb_vmemmap_init() is not removed
yet. It will be completely removed once HugeTLB switches to the new memory
section compound page order mechanism.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 9f70559df4e8..2a6c3c82f9f5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -340,18 +340,11 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
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
2.20.1


