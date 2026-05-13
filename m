Return-Path: <linuxppc-dev+bounces-20860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D077CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0h4gWwz2yL8;
	Wed, 13 May 2026 23:08:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677716;
	cv=none; b=D2KnRuFi2wrXUwXhn8uBwD7oGokKoCeY014Oc1xs2SDwZZTOa3FYotYnmNvMvHe15l1XFQgdxO3lkzCsZjJmP9+S/CAGM0Lt/VmpAH0UDHdz1VdlVY/DYPAsVEiTHp2MJsw43uGLYQP9ryqMG355PekODoABHg2EzyaQ3VcTz6H0rYicpJoW14jpsf3DWvpAXLFbXM1e/6XJ9W01XUwD6S7IS2KoN1ZgeYoXwerKgg9QCTyq3/tUh+U73cz05/jRpbxloq4tNbhLyJstjuQ3HX2FyLITyXFyW5DLOV+xQa/rwIl5VjxEkt8XdTszm1FtzM38xcFGPjGZkSlOdRhCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677716; c=relaxed/relaxed;
	bh=Dehsx8fG7S5ip+vlcPIiCfZ+EzOUnANbQVn1Jj1cBa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmAcaBCGHaojY3AtnecI/3xuRAPfXbPw4U1XecdqoFWf/f9a5vspPYKqMj4jN9lHvTiV4NUq9BeD+mBkxaZmXIS2SZj9BCJtX5SCTE8JJnh+RzL7vB93jzzrcORMx3n4cf9jPZWkI46dKU7mEKanWUKt+krYgtVHY7b2Qum1TsYi6yGqYRRkNyViUvJ4wRq1IiU2hAA2d2pt4DL6i1RIp/xLw9eRJWDzJh4O1irQ7OVkyh4XPUgJCDk75+H8AVlWSXl3V6aJYGikBblHi4Tsyhgdkw+x3MuMyqFhnvkHAn1njODiraedCJn3Cfng9hBbfrhqKC7VK7nC76diiYs5Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XZ2r/iWl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XZ2r/iWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0g466Yz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:35 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b788a98557so50687705ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677714; x=1779282514; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dehsx8fG7S5ip+vlcPIiCfZ+EzOUnANbQVn1Jj1cBa8=;
        b=XZ2r/iWlYNLNsgqujm819Vg9OmbxRTtBwi+NPuxBYBh/eal37Yg0kMshhw2ld2+hOZ
         PVNblz5j2xazT/EEMrytpzz71PNypdrH42+F2Uygbtue2H8TW3em8uXuAKi5r+VRw+k6
         p2RcoCwGz9uGQBrfVzLJcUrdhuHwK88NifLh1z9VpjkgZUosdng9Tcu7lK44dchTHbcD
         fWDldlpRIALiZ/HTVr99zDYZ7uO187DyOMTRhDdW6I9fJjD3M3/aLuKYVayPAasYfOXV
         UlTxDZWUR7PK1fbDuQnTfrn6JwgZUcL3OwEXyw7qo02992tVhZHcw248PSEtmhFsxUpW
         YHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677714; x=1779282514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dehsx8fG7S5ip+vlcPIiCfZ+EzOUnANbQVn1Jj1cBa8=;
        b=KacjImci4xYap0y4wkNkAPkoE/tu9fTiuK3VrzNsR0d4SCdv99kWQcJpTdURwWphFE
         haK3uIeo+pL2HQKM6ekjHLuxUhG7uNAJth3ppjr2YmWLGAOg1XCJJP6NAQpqjZSfSYZe
         k0m3DmUfaDNyzLTgUdT5gJ6mzmA+AUppsXu99jpMsOF/dSgcWk2mUaEEUmA6LHTmzFRO
         2dWMEdAFIeagl6lSrNMu2lq3TiLHzyjmIJ3PKiplhsBm6Kg6qBHf9R825/e86KRpi5Up
         VmuWzwOJzGheOYyWiJgvV9ycFid0OKq50s2VrtFSnpFFCwT0Rwm6k9xNYgTEpC72N5jE
         nQvA==
X-Forwarded-Encrypted: i=1; AFNElJ9z10Zizd/1jYlHw9NKONW1xbBuhtWEBnnaJH4UroKsZCX51LIXXudHedmKobJQr16P5waEeXvstkqCIwU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz9jaTyyAxk4Ff5V1PfsdCroBqC6934QWO2uftjdJO4kdWdIO6c
	9/31Rdb3rXcvwYnW+Ic1DzjANo5reN8ZBo4cCKJNv6rMJiByVlaIUEBofbM+Xwn3H1k=
X-Gm-Gg: Acq92OHFbM+ZlgpBxCWBYgg3u45VGSiHRjEkuKjgv5BSP4oXJ4wc/4ZciE9UkB6r9a7
	tgcjefC4VsWVHD+iws6JBhEKbfwTAx56yTvrSa34z4oUvewE4jjQTpkEzaL2arrZpmFRsT+N0fR
	WVAQMAzVO1yto2S7z7N5gNHYQW1U9F4NawRFL0PeJ4fA2mQe5FJ5mITF5VHn98VLFL4TVICqrDe
	5AmBSNl6fmA5HfQpt3Xt3BkeTtMxCmSn1JuGO9QiM68QSDnHujqXUObZTPovpdby2G3UcvXIKa2
	wmII2vdER5+gDMsi7fPJf08b4UzdSxgEZ7SFAO1u9qt3Swh+hIffwXO5Qb7uh3FYqccg729d07h
	7QRiYDrCJvXnlXYPhq2ZW0uWOZRl1EqxxUp8dQOJtj5fUHmHiyj30WpsY/i9A/aWIkM8vAI+s6I
	SbHOakdbdP3fH57+yb7sXZGg46CiNNXbMmm/Q6NiFS/hpmPH+prZfwjfm4rhA=
X-Received: by 2002:a17:903:1a68:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2bd26f13117mr34896815ad.0.1778677713521;
        Wed, 13 May 2026 06:08:33 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:33 -0700 (PDT)
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
Subject: [PATCH v2 11/69] mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
Date: Wed, 13 May 2026 21:04:39 +0800
Message-ID: <20260513130542.35604-12-songmuchun@bytedance.com>
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

sparse_vmemmap_init_nid_late() is still called separately from
mm_core_init_early(), away from the rest of the sparse initialization
path.

Now that sparse_init() runs after zone initialization, call
sparse_vmemmap_init_nid_late() from sparse_init_nid() instead. This
keeps both sparse_vmemmap_init_nid_early() and
sparse_vmemmap_init_nid_late() in the sparse setup path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v1->v2:
- Add Reviewed-by from Mike Rapoport
---
 mm/mm_init.c | 4 ----
 mm/sparse.c  | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6646d4b47796..165b83c9a9c3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2686,16 +2686,12 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
-	int nid;
-
 	free_area_init();
 
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
 	sparse_init();
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
 	memmap_init();
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 324213d8bdcb..3917a47153d8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -320,6 +320,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 		}
 	}
 	sparse_usage_fini();
+	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.54.0


