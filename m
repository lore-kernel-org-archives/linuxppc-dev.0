Return-Path: <linuxppc-dev+bounces-20897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B21CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvH65CChz2yLP;
	Wed, 13 May 2026 23:21:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678466;
	cv=none; b=RD38xHBPe/lM2ZskvERWi3VvnrCYnEuM/6DrGbLjHoimsblP0HALTOPGu+uNZZsWvPgfNS8d4Iv3mzvCaj4WlRe+oDXyPTovqtqrATvUCmrhnVFXwRZu7zsOc6Ia4fVUHiXI3JvGQfg7NeLxEFzWGsRHt4wgbVeYA2RyrlUDsrsCnSVhJy/voX/eJT13y63QlAaQWd91ukE5Bd17HdyCpOAthBKcvjJyD8FLw9GxNPoDVriasLGndHXVietcyfYgUpaSaYjIUiE3o1ZL60/5u4IMYfaCOBS5WE6I3DjDJWVjwOMFgnH0rYtAuv4rSwRFZI+QhuHNDDPyRiaozcpZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678466; c=relaxed/relaxed;
	bh=kmMHI/Oobz3lupMdXI7U03Ar3ucRA9ahppmUoHlMfZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7DnWBuJ3csRJ8UAyjdnkT8V6GV51/QFeHl4muW42DWlHEESAkroVkTHLsr2n+t9LBTNEw3trgVPBUxmlxQf5VOSaqS08Zcnw1gLdN+uw3tcrjA9zfs4jSHMibTOb8y/VoN+hjVKhwEalC+uOvg6u0JJvORwJEo3fV12RS0aMxLAkXf4DCpevdatSVieHElXEl04unIpQA7aAnJGUf2vTNDE7Ykkz6yBLmRLc8ad9XtzyaCxPGKe/2Jhmpi5Ym1Hy8CyaqaxyVPZpM31bmhwuLx+KiPh0etJcHXKNLJm76E73vk8GBtv2Ju7FRFdotEy3JT7NXJLtjiC7TZgpAW9pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hODH5IjH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hODH5IjH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvH60x9Kz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:06 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so3373110a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678464; x=1779283264; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmMHI/Oobz3lupMdXI7U03Ar3ucRA9ahppmUoHlMfZ0=;
        b=hODH5IjHPgl651hlSW+rmJIWfvVjZu6/mIwGopxvNKjNX4oCWLz0HQle5zZyJHELRX
         bLWumRVC5n2V9ejXr9lVpyg1RA/+zn7S0xPGcTlMqlMk6/cUfebjiV7ZdT+5XrBRJM+q
         Mb5FMuzaejmGnpKygc7dadvb8JdRVDCBfJC6HHkUQCIOStp5Y1ZkMTLyDSiQ5OSNW5gS
         aAKIoYFa92qJFLQZYYRZztLcCILwjBFSdKH1X2sILRq6N+rpm90GlcE/Vc1R9pRtDg3l
         pSUlj8ysxUCmGK99s9kn+9fTYH1nKLpf9DEqHx6rsUp8UNsKn9wpuTVmHYEOK4ej3/9Q
         v+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678464; x=1779283264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmMHI/Oobz3lupMdXI7U03Ar3ucRA9ahppmUoHlMfZ0=;
        b=siIh/5DtZHyWEbXRdtNw1a709eq1zRV00jRzez6xh+xVP/IzSzJsHNer8EUIngq8f8
         R/q5co10mlMr+XL79G2RozoNB5Iv6gbYhqCdkpRLWrpW3ilQ2s8D8Ogx7Zjz9urqH0r5
         mqExvxhui/T46RGK4uHSUkUCLgtW/uYJk4rPnCkwdHnlEiDIsB4K6HeTOdmZLBu+UPpa
         xtiQrUZY6Feeoj5jreyAm1ZDAD9kKfpUd7U6APoIUVHRx/1Mkh/9o92KGxJ7zuq46xHF
         bUJqaUp71EitOSRoxari4Q4gAf2KGak+BD1lYvnbztRcKww9q31ymwtC0Fl42+w8G/Xx
         r7Fg==
X-Forwarded-Encrypted: i=1; AFNElJ8/gNAaCKdXzFyIRndOPem7nQt9cvqYYpFB1hXvBJ1QtdAUcx9YK2g4k+l1FLp8ognl0j3CcrjoNbCFL10=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzD+4Tw7RWHyR40y2kIWJu2KK1ThYdIVbDoxgLixb9TBcLXPnyR
	cVZsPgJNddTjMx+p6FXL2/vSRdPmFV1vf60LiB1JCfsv9aSHgCP+cltCGNRLrVidzMA=
X-Gm-Gg: Acq92OELRNEydRqAZpb+dmJu1kQCzjTr/UI7x7BHv3+ISH2QfnSOTjMqmTbtckEGa32
	86CpQCrZ6xqRDkQmvzink4krIVskqer/pE4k4ilLVuShSUNJEqPtSbgn56uKgHDFHTmba9Cxnew
	lQIOOvbXoCawWyiPUha8kkj7C4XmWLe59YXxWwXl/jSzgqp8H0GL9bX3BJgFauwCExHicO4sWVr
	JIxAbrt0OmWMhrrOXxpv/UZxTBtj4ZCcQce/HIiPMR2wKfkj4+rqxqBh02ips4nJeG+RDPWdtdd
	NIbPWK6gm9OpjSfzQNYBLy+Lng0Os3DZM9o8a46NGMa/oITv7K9IM8gev87HM1Ne0DkJb51r2a9
	Ttya8nmkW8j7qv0cYR1H2eVND0VPNn+LWpFo+jHIdb99lijYuE/1AC2r5EtpKMV9LTT3wKGC8Wx
	BzJ55L3XTA2Q0ousISPYVO5ej60VlTv2R8+V9TADjoKURjn2HRmxM89d27aSog
X-Received: by 2002:a17:90b:51ca:b0:366:3df3:fe45 with SMTP id 98e67ed59e1d1-368f3e43e84mr3548880a91.19.1778678463950;
        Wed, 13 May 2026 06:21:03 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.20.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:03 -0700 (PDT)
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
Subject: [PATCH v2 48/69] mm/sparse-vmemmap: Inline vmemmap_populate_address() into its caller
Date: Wed, 13 May 2026 21:20:13 +0800
Message-ID: <20260513132044.41690-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

vmemmap_populate_address() no longer has any callers that need the
returned PTE.  Its only remaining user just checks whether the call
succeeded.

Inline it back into vmemmap_populate_basepages() and return -ENOMEM
directly on failure.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 46 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 9811c92ad258..5d5cd5f73365 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -234,8 +234,8 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-						  struct vmem_altmap *altmap)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -243,32 +243,24 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	pgd = vmemmap_pgd_populate(addr, node);
-	if (!pgd)
-		return NULL;
-	p4d = vmemmap_p4d_populate(pgd, addr, node);
-	if (!p4d)
-		return NULL;
-	pud = vmemmap_pud_populate(p4d, addr, node);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_populate(pud, addr, node);
-	if (!pmd)
-		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
-	if (!pte)
-		return NULL;
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
-{
-	for (; start < end; start += PAGE_SIZE)
-		if (!vmemmap_populate_address(start, node, altmap))
+	for (; start < end; start += PAGE_SIZE) {
+		pgd = vmemmap_pgd_populate(start, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = vmemmap_p4d_populate(pgd, start, node);
+		if (!p4d)
 			return -ENOMEM;
+		pud = vmemmap_pud_populate(p4d, start, node);
+		if (!pud)
+			return -ENOMEM;
+		pmd = vmemmap_pmd_populate(pud, start, node);
+		if (!pmd)
+			return -ENOMEM;
+		pte = vmemmap_pte_populate(pmd, start, node, altmap);
+		if (!pte)
+			return -ENOMEM;
+		vmemmap_verify(pte, node, start, start + PAGE_SIZE);
+	}
 
 	return 0;
 }
-- 
2.54.0


