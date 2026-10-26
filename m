Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DB606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I3GMj6ft
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmPH5Dvzz2yft;
	Mon, 26 Oct 2026 19:04:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ac"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001875;
	cv=none; b=OufA3wP80UZddD1SopI4m8WUQamRAZdJvkqyeU9c52/Y2aFq2WAWx02KiSiHXjRKSHsvPxLWNhzQsCj/RLs8AzHb+hEIOKwA/vFDrWB8pHb+VwUjrOSC2H0ZTxU8CocFkonCCylzA5OAubXqHTK4V9q5BkVz2lTEi/k79FOOMx9UL2ki4/wTiBJenznhTNDrvy+JDT/wSsHI1BrBliRjMb27OKAcv845rZIuD7UsYmIznd9XxYCi95HQDqw4v3ckzt8RLxlWPaPYmpqQA3nT+fms6LALzhjos0xOzFf/dJdWoBSQ/ljMdKMS29tj6bVykZBTq1w8dvTKaEIBBmtCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001875; c=relaxed/relaxed;
	bh=Ua/GwnSU9LJOYkv1rGO2E2qJAAhF1zPUAvQ24xV9DW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ne/HMn1CCo01mS/fvrN603O7Uq19KsteQqrf4pWgN2GFfB2kFpq4CSuUZ4oeTeY8I2rStif+a0gKkmGwjw+JdTBKqWb3Y4g3+8Q4nX6QxA5ZbeZxrq3+e9h6LDayDBxDzDLJ051br87nvLhAXSWKFCLl0j0ID2oBr6v+aiVapjBlSqIde4MMV5dVFJrG57Fp0y2fhOY9RGloKD7ZHjqrT0LiPb2YbssiA+cY7ZPmrz68xtmToP7EdUW/0+7iwGdZyElugXnT63gxGtIuqIyPFBBhzb1KE9apDfSsTjRhot2ip2xdXsxf/Vt6QavHiqYRgAC+Mh+eM3kEOXh/VEavyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I3GMj6ft; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ac; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I3GMj6ft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ac; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmPG52vLz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:04:34 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=ExnTYg0MMPYD5DKsFA/XjypuB+/Tj0Yq/PSjWL3PWFU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001856; v=1; x=1793606656;
 b=I3GMj6ftPo/5ZE+SMr4NIIdYohOkRn2plD/UlLo7f/bOiSmeyph97sTe4IlSW++uvaFnMpIg
 pHgRYpT5tpQcx9vZQcDd6cy13+m9Y51/VjhkDLUQ2ZYkrfWI3WNAxQp5WTqjg9EjS5gyxb3kt3i
 KThnasg/adOGMvpGpGw0Qbtc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id fd68075ab15c9be6;
	Mon, 26 Oct 2026 08:02:56 +0000
X-Mizu-Trace-ID: fd68075ab15c9be6
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Hao Ge <hao.ge@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v3 04/10] mm/vmalloc: propagate errors in vmap_pages_p*d_range()
Date: Mon, 26 Oct 2026 16:03:23 +0800
Message-Id: <20261026080329.140244-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026080329.140244-1-hao.ge@linux.dev>
References: <20261026080329.140244-1-hao.ge@linux.dev>
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

vmap_pages_pmd_range(), vmap_pages_pud_range() and
vmap_pages_p4d_range() return -ENOMEM whenever the level below them
fails.  But vmap_pages_pte_range() can also return -EINVAL for a
page without a valid pfn and -EBUSY for a pte that is already
mapped.  Pass the error up as-is instead, like the vmap_p*d_range()
helpers for vmap_page_range() do.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7131f60d1a8e..d60b99b81ec9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -600,16 +600,18 @@ static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err = 0;
 
 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask);
+		if (err)
+			break;
 	} while (pmd++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
@@ -618,16 +620,18 @@ static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 {
 	pud_t *pud;
 	unsigned long next;
+	int err = 0;
 
 	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask);
+		if (err)
+			break;
 	} while (pud++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
@@ -636,16 +640,18 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int err = 0;
 
 	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask);
+		if (err)
+			break;
 	} while (p4d++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
-- 
2.25.1


