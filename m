Return-Path: <linuxppc-dev+bounces-20857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839D6CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0N1kscz2yFl;
	Wed, 13 May 2026 23:08:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677700;
	cv=none; b=mVnO/Zq/sIUQQpZJJ5SJWDzbJnZPbj8EnF1/JSoKD7bKrsctGevConMrzRqGSa25HqYmdS+cijPVIbLKiuGIE8sm3AQSsuJV4DVKMXzAiBUMabWl9gL0xubui1FKXq/1CW79lMB5jv8ZbrNu+lhgpWJF4lkp7TMS5kmmL6Vb05v4PJO5EnKQwu7oVizE821OrpWQa4w+o/anP51eOOQb92gMPB9G1fkZeWo2Gpcc5X3S9oypaT1fx6OvlIW/WbHYN5i7VST2H1ui95wB2ViDCiAByYvBRXLh3uE7ayNG2XKoxDMOffqvRxAc7lNYPK36sk/rAFSNHeMcqBBCtx+q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677700; c=relaxed/relaxed;
	bh=DYuPvzchRBegO13WUUAUtcrTx/HN+dPBsLEtJBVtJ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUl4OSeL7OIRyo274GziUWhJ8GvLd+fH8uU+8bHswM8uzjq5J3GCdJJkhArYgwLAVnQ4rDQCQicz2dLqHOuWxxRDNXwIC0D5i6JCfFLrTmZ82NkCGKJM4hUeH8WeWNroBKHZhkbTPxRnHL4ossCtTA9XtUmARuf6I5m3m94iBVEG1I1cykGC6WxBETM2tF8TLM5uyxhGx3CSifON0hSKCH/uKtKnJsrQtTStjJShVlyqoei5eVjgASO3g0RdzrlmOuqA7fT0ullIre2ltxDth4VPot/0RW9iBm1kYKHXiQwQHbXJ6fk5oip9jyaWVqXSXGAwiuqB228LyOLzmxmWCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TCNxrNFM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TCNxrNFM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0M3gwXz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:19 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso67439625ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677698; x=1779282498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYuPvzchRBegO13WUUAUtcrTx/HN+dPBsLEtJBVtJ7M=;
        b=TCNxrNFMthRVxg56THa2FWyQRa0ifVScI1j0DczGoRMFMtf/8CfGO9En759m6alVNE
         HADvf+4zPL5nNSt+CYyjG+vDBUEY9f/dAABMLTCf0+e6fTxEZP0mDpzmfG7mwZpbA7Ko
         ZhjtAdWM1dPctYhmJqtqb9PZ2oHIGkq12KsquevlG2f7H07wP1vh68pqvGRRcWuo9QRi
         0dJ3jPOUfI/UmeZAZtp61yh53iLKqb/5hIhvU9gmxUaMGjxS+schEQaVYe2pnga78wqj
         QrBzR3IDIM18WX867Em6RMRM/n2WPXaIPEHx1d9CDtbh/0yjQBvIDoRCLIQLFo9V82zv
         HxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677698; x=1779282498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYuPvzchRBegO13WUUAUtcrTx/HN+dPBsLEtJBVtJ7M=;
        b=R7UqoUNMYJmmdBUZwmiPe+FgLdwAXZYs8jashWzW8aWZxCrVpyEZUw8C0spJivWRQj
         wguwPTvuDjDz/m4TC9ptH2qtA3NN4fndvw3hkMA4ZSKpBft+qt7akwbxp/ZS6iD5XdxK
         CfGljXeymTXO/Vohtd/1IuVSgGaEarWHZBluB6SNp8u3NbBZu2BFigyINWhOcJ/6OsR5
         NwSkJvM2N4WZoa8mTcbNI0HCENkNzGzNIj5zmMX16whkew2AZ0uXcSR3/XBQkhFYh0hb
         FldYvaFqPg4AfCVyhBCQ5iyG9ygPX7GaVV9JhWDVGLwujZIEOZc6jMupTFuempNJwi4+
         1+dw==
X-Forwarded-Encrypted: i=1; AFNElJ/2PNRCdyaIy1xAdFtY25U8VvugGfP0VNWg9aRPPKL++slfT/XUB+tP/hMoUUCNBjMmsGW7LoqsYtpJ5gs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2r87DVmv0XvtlauZGpC6DX9sMZGebH1cym48OIpcFYufQHP8R
	Myb+BlRjn4s/I55+99whoMf1XNsbEhyFu5ubcnHVQbOTBBMaRc50g+9sNPR6RkJhwRw=
X-Gm-Gg: Acq92OHlAGhImXCqa64cKQeby9m20qjB2pA+NVnaqEg8jkayppRtgPh/PZ5JDYllaS0
	3QY+/Uf4pJf7uk2gYhox1jtVl20JoTXvGGb316x9IIj68JUIZ24qckpGkhkO/+0QGPJ3+xr4jnE
	WQVwKkR3yhN6PvPAeC9uD3kgtu5gAy/7ILuFw9+k9JDN/EKwJhy610K2ae+UjXhd1fnp9iLnN+8
	KpHPes6yev7Rz9UAkLzUDPQdwWvF71Xs2hruVaY1uCZH0dYI71EwaI5C+U3JY9/xPfuGvWfth/c
	OthIKt6buKmfJdlK86xIxZMwpcuTmYpYF+uxOHuIuijEbfqLFtOnFu6kk9R1DqM6QrHhTzQFHm7
	w0nKr3ggaHQiz/MmryyKtmZ2geNPHJ0LVcAUIM1vibbl7BHoo0QOjGtlN3o0GtOv8qPmiTc6yt5
	2/QZkLK8Aue+HHDjM/pm9xphtERxCkZh3mJNbajfGhmpDsSCQGKaZZKqCKHPE=
X-Received: by 2002:a17:903:46c4:b0:2bd:2de3:51ad with SMTP id d9443c01a7336-2bd3043ca95mr32656455ad.34.1778677697132;
        Wed, 13 May 2026 06:08:17 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:16 -0700 (PDT)
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
Subject: [PATCH v2 08/69] mm/mm_init: Defer sparse_init() until after zone initialization
Date: Wed, 13 May 2026 21:04:36 +0800
Message-ID: <20260513130542.35604-9-songmuchun@bytedance.com>
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

free_area_init() is responsible for initializing pgdat and zone state.
Calling sparse_init() from there mixes in later vmemmap and struct page
setup, which makes the initialization flow less clear.

Defer sparse_init(), sparse_vmemmap_init_nid_late(), and memmap_init()
until after free_area_init() completes, when zone initialization is fully
done. This keeps free_area_init() focused on zone setup and ensures that
sparse_init() runs with the relevant zone state already available.

This is also a prerequisite for later hugetlb vmemmap changes that need
zone information during early sparse vmemmap setup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v1->v2:
- Restore the set_pageblock_order() change suggested by Mike Rapoport
- Add Mike Rapoport's Reviewed-by
---
 mm/mm_init.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 12fe21c4e26c..c14491c2dad3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1826,7 +1826,6 @@ static void __init free_area_init(void)
 	bool descending;
 
 	arch_zone_limits_init(max_zone_pfn);
-	sparse_init();
 
 	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
@@ -1915,11 +1914,7 @@ static void __init free_area_init(void)
 		}
 	}
 
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
-
 	calc_nr_kernel_pages();
-	memmap_init();
 
 	/* disable hash distribution for systems with a single node */
 	fixup_hashdist();
@@ -2691,10 +2686,17 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	int nid;
+
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
 	free_area_init();
+
+	sparse_init();
+	for_each_node_state(nid, N_MEMORY)
+		sparse_vmemmap_init_nid_late(nid);
+	memmap_init();
 }
 
 /*
-- 
2.54.0


