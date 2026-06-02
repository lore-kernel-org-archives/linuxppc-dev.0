Return-Path: <linuxppc-dev+bounces-21886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7613CD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67Y4Zgdz3bpp;
	Tue, 02 Jun 2026 20:11:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395113;
	cv=none; b=CPxpsidQ+68ks3os7NtFi8IDJduhG1pK5Jqu8sNVgQv/FSWck8xbMNi83r07NRxlKadPOGk4yyBPBnwcXm/DBb5GkekgUanK5c3H/79Zfro3g6R4RgQ4E+9j57HQbrzDrythne1NVlsfHQByMt0cjW5Exio6upWhag8EHbOe+SLaymBhaunSd8CWLVrlLgkRzljKmZp75YiCndM7YX90FY1DGCOr6PJ1tYLGoSGp6paE5byEShANMAQZsErmMCP/rjThkPvGFPI0lEtaqPdn9gotCwwj5D6H+adrJ2DNk/4D0n0ZMcOpNU0hao2NP22/l1g+SXzoL4pIKE6XF5l5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395113; c=relaxed/relaxed;
	bh=ePux0+p+Er7H/YD/Nlp/8ECZIcHxOs0LOb73zwAatVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWVlZzpWMiz7cSRS0GiN2s1R6vYPAAuM/fA2VY9m+R8Rx4h2zkff2L2RTSFnIxB38/zmw4S57Fu/+Za4nua4vaWpyZlMhrbAJbUF5ZcK9y6VjqfYchuYQxDa22MaCbpI1LszRRfBlo8o4TkgbYOskJrhVx0OF4lbSbIbINixdzQrVv8p7vBTpbOO76NQ7WMlRgfmlyQDCDmZPr6MyAYqo0zVWFqY1CR0hGK/yYJcF2XDhHtUAdEebf7kqfvmgeSOhOz/v8yi8BSxZhbJf8r3VsiAwMQJZ7G2dtf/0z28JP7aPlJKKScl6gXM52sAqOF45TxTgPyBvc/uf/Wi0y71Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CB08yiyE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CB08yiyE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67Y0McJz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:52 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1043584b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395111; x=1780999911; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePux0+p+Er7H/YD/Nlp/8ECZIcHxOs0LOb73zwAatVo=;
        b=CB08yiyERU0tTY6oHHm1Bn9ynBogJ3xV00AuLbdxcZ4eDYHt5Vb6FlsMPg4pQsxOH2
         /xmcgKZs/wDYIRWkqAX9X6z85Pk5OJFk+MLGhI2XYWq6dk4NwEE0oMZcL+OW3adKe5R8
         qAwhI2ONqSsIU87/wxvRA6/pqpsehUjJtoug4Z9xJzCJ6JBPv0l4VOjv1uKCfVPSusoF
         oCDLvEXRCKuPyGYhFigdZFiMgT4UPcofx+lXnMvYXNXKYUEncaCS9oDpEGqIzBcoUCdX
         a/wQDRX87oT3uVFswYArf85RFVoQ4SbVgROvcX1fA2aV5qV8AaLHhXBT+GkdEZfeXrQD
         f3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395111; x=1780999911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePux0+p+Er7H/YD/Nlp/8ECZIcHxOs0LOb73zwAatVo=;
        b=q58rX6pfbaNGPxYOl+w0e6AQrgMdMPFliB1+urLyF2MOgB1yQOIxyFGmAfoCycZOiJ
         h1fG0Xm7R8WiRWieecu9vK0HsavemFtaBfLaxhGSx7WVNvbGdnWtF8N0/VkcI9jW1c6p
         l5r+VmivfFMLXGhq4zpbi2UYlv6SGX0CmaA+2snj4iejwX0Y24EMhxELr4uXaCoQuA0/
         qOA1EiA7Sd76Z40YqRdOZrMB2pBC3cv7OrrFNSKJ3QH1bg2egun72wTL5tNLvXvFRqnQ
         CYDkSfBjQhm6yHql12DnEot+cG9neR1qujHNQ8bblIdwq3Jyqy2+hXbkIctcmRWEQjlu
         WkOg==
X-Forwarded-Encrypted: i=1; AFNElJ+d4UAecmCCf/dUN5XNSjkJJkvwM4kUMltSy0u/4y8kpZqg5Sx+D5+kCKhDA0qZ9z7mhOUnCya9zfDpp9U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxEa6C6hAUj+veXn+bcRvcQQPnNRGUUD5zG8AL6Eqf7cMPTgSe
	Q7RExsDfeCeXP+jnY8Y0cbo0AcN0es4QvsTxjQ+83GmZdickpkS8Ba2ULH6d/mD6Lv8=
X-Gm-Gg: Acq92OG/2g6s1K9AbTQbYSNkteq+tp1yF+ih5abaRZ0DXApaKzJhJ6Q8UnpEyo0qKUR
	i1c+LsjJvgXhcAwYLfsLaZ5oF1lw5r8t/tFQv+0Tft7npe9nGm3NWb+d+1Dq7PJ20KFpLzHQjsR
	ZN/Q1UetpqNWPayed82riDqEeuHm+HD75qyyvMmMLih/MEuhxST6qS1Ui2uKdm18Tz+as1fy5Nw
	zV63lco3PTA8+7sC8A6LEDNc/O0LxsuwvGYy/mrHMA0i0jTawIX23wk5H6skB+KlHtZj5R6tmMv
	8UVhSqYbARC8ulalpzFKHXP0PU0WQVW1xBtCiOO/o4HLu24elqpCMcH5OByM2wsBFPLRYXO8Mc0
	ifranOX0+KGIdFcPOyf2XWkq+LDIJgDNC3aSkgNny9iida7XCdSYfCRR1yI3yWHou6Lkj2iKlgx
	vujvR/rewIktEiLkaOET3tdCkd739cvy3yZMTDsOkdpeSNykz/srWNq+oBYmHuecDdbA==
X-Received: by 2002:a05:6a00:22c5:b0:842:7d47:28bb with SMTP id d2e1a72fcca58-8427d473274mr311986b3a.47.1780395110901;
        Tue, 02 Jun 2026 03:11:50 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:50 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v3 11/19] mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
Date: Tue,  2 Jun 2026 18:10:31 +0800
Message-ID: <20260602101039.1867613-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
---
v2->v3:
- collect Reviewed-by from Oscar Salvador
---
 mm/mm_init.c | 4 ----
 mm/sparse.c  | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 44512f3b3544..41b83dd18c01 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2689,16 +2689,12 @@ void __init __weak mem_init(void)
 
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


