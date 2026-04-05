Return-Path: <linuxppc-dev+bounces-19349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC475EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXW66WbRz2yrW;
	Sun, 05 Apr 2026 22:55:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393730;
	cv=none; b=OZAEF8LGdpHLT1bW7/qdz2PVnM4mg7Mad646i01YamxYdo64wYEuYk5ZnAbMJY0Ouc+EF4HuEHWbiG/bglVxQ4oOsxeETtl1ilsH6scb7mrz6e0IlTNrG3Dq6GcUT48JsCVr6sev9MrHFAtDg08loh6NCEaYL/yeRxg8NmJcLYPZ7CozskY6BUWyZGXFV1Wp6x4iZRs6lqNFtZclroPNLMx9ZPHejS2/MfEhn6LTtmwVcAbP9xsh2oYbWGgye9Qa+a47Z6zGfpqDsz+186ncq7BcFusn1fxTdhp77KRaBwdPjrx2sfrM7INVy7JNYFwPHQxdM24QNv/95L83dpjZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393730; c=relaxed/relaxed;
	bh=2JrFioPtriOOEM2n2rZ0j26nDzRll/vGxWzMg0geq/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6OzYWjLs/wBVAj0+nzrbPHrcc486+iPZhiDRASj4IYqKB1e9QI8PxfdG9vlEbyerjF0VP1/vwbvnU4fhOmWTZvB+GSrzKRy47qIer83pAX3BWUJXJRY+QcRzNS4w1RQGc3zAxmRSSobyzH3/Ks4B65psNm4RC57fSYoBgUbenkCIn0OZ69vt51t+zL7pBdnYZ4dbJC6VHTPpLepqcBzrocrGwH4aZZt7N/fYvPYmroHv/Rh4darAWlD8nFJebZ04iOYoJ2QRMocrMwb6nVbpRMIrID1ekSJ5n3lpm5aRQcmha98HNZklqQDnNv7Fo8UqBJ1F+Adn46OqPoMNpJrrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ilM/9sud; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ilM/9sud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXW5739Kz2ykf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:29 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so2933091a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393728; x=1775998528; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JrFioPtriOOEM2n2rZ0j26nDzRll/vGxWzMg0geq/4=;
        b=ilM/9sudzUJduSqplbCU10DWRqwDcGIo6y2YDAQ/odYL7R4E4/EM7dnnBhf9NdN8/m
         YQQZw+58plFUx+RXUIfLTE3pd1kjSl1kpobE8M1Lje30ynA4801P4/3vlgxw2O6YpJF3
         MxP/TDGmihvdwPns5cCHLpQCvrt4FhPBausynBb4R102l0/vqq3I9Q1nLT1QNtphIsSj
         JbJ45fhIPQHBhGHQ710Vk5DAR3crD+e5I+bXJ1hQcxngfaLUSoYB764MJHnLps4mqOFM
         VSemFKqC5vtgN1pb3fL77dVZfaEAp0nfVhZ+kHWCSXJ85pilCCCaNrBY26/xXR4QcVO4
         rLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393728; x=1775998528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JrFioPtriOOEM2n2rZ0j26nDzRll/vGxWzMg0geq/4=;
        b=qx0wK5W0xvOjrOuG7h4PkXqw+9C6QWD/cEqiM8A7ccMTHIwi1qammW461b1FidPEkO
         qyuF7jVn8R7lYTAIPhx7D1bJEkKDG33Sf/lxW5O/YrvjlFiS3cXvDu3aVoNbPVct5pzg
         ABYiBLJMyVuOYvP2MdIrcyM9cUPN3W8Y5TLG1ELovX6KNAu+dLF70QN9lpK9CRuv7Ga5
         zB6zIFD8OAH5RgS1myfD1eTPEd+HH34m5HjQw2Pz+KMzjRAl4Co8qhqdbnsQ68bCBwTz
         LCybopSXXMholB8b5LexIbbOK1kFduQaOoUz0WEp807zPXsEWHP7wsUMycjnF/ISY11U
         RbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOrs3h5yJ66uVcY7oYfKj811DBapwVEOZH/KhTV945qCr0/FaP03z1+6Kg9Inxo+4+haT3XO56ssKLI4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmNK53JFyjIAEUfxf/q/l07hsnBqKR4UAgJmFCA4MUCFOYAR5T
	wxIGzvQ2sn63QBWy/v6lfNOXWh6dX5LvuPodtVN7uayfyJqZCSjzOvOuhpSy5W3/U+I=
X-Gm-Gg: AeBDiesKb3dbeqHmDlRSj1SuyycRKHExGHyQWzfJZVb+R7d+E69S5C5exykYf8t1zIe
	Bi7b62m73IRqoSyiLJyxEspOn95DJqSezIqInZIyH9CPVL9CvmHD/KP6fvxYunNmxYSCD1ZjewF
	IgsVJM8DBI7FAcRH0F8rto/pl7SX6HkL2u5egR6lj9Y5v/qEkZUx/g6GV+hP7deSluD54w2Vv1G
	sbK8aIMRpgmOC48O5O6WZCIeIsmmCotFEC6uFpfv0tAAMgctdJuwLMScFLLbaTO0p+XTLq4kRgk
	McFMJ5Xu+mkHF7YF6jw0OQ06f/Ei1B0Qg6dqYVPwI81E9l5ZMkxtp50In4G+GFguaEKoMxinHaw
	Pgny5xm9Y1+mUQ5gUIXhpUtCA/zhYZsn81O2XT0sr0ZXgaQdU6z3K98z4iZUIXq9tlSPmfO8RQy
	w16/1Xibkmecxr2+sP+50/wGzzgjV/62JbNnu8G9JsXwQ=
X-Received: by 2002:a17:90b:134f:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35de691a6bamr8984676a91.23.1775393727846;
        Sun, 05 Apr 2026 05:55:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:27 -0700 (PDT)
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
Subject: [PATCH 19/49] mm/sparse-vmemmap: remove the VMEMMAP_POPULATE_PAGEREF flag
Date: Sun,  5 Apr 2026 20:52:10 +0800
Message-Id: <20260405125240.2558577-20-songmuchun@bytedance.com>
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

The VMEMMAP_POPULATE_PAGEREF flag is only used to ensure that we call
get_page() when slab is available, as mentioned in the comment:
"and through vmemmap_populate_compound_pages() when slab is available".

Since we can check slab_is_available() directly, the flag and the
associated argument passing can be removed to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 26cb55c12a83..3fdb6808e8ab 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -33,13 +33,6 @@
 #include <asm/tlbflush.h>
 
 #include "hugetlb_vmemmap.h"
-
-/*
- * Flags for vmemmap_populate_range and friends.
- */
-/* Get a ref on the head page struct page, for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_PAGEREF	0x0001
-
 #include "internal.h"
 
 /*
@@ -152,8 +145,8 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+					      struct vmem_altmap *altmap,
+					      unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(ptep_get(pte))) {
@@ -175,7 +168,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (slab_is_available())
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -248,8 +241,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -269,7 +261,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -280,15 +272,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn,
-					    unsigned long flags)
+					    unsigned long ptpfn)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
 		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn, flags);
+					       ptpfn);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -306,7 +297,7 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 {
 	if (vmemmap_can_optimize(altmap, pgmap))
 		return vmemmap_populate_compound_pages(start, end, node, pgmap);
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -382,7 +373,7 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 		return -ENOMEM;
 
 	for (maddr = addr; maddr < addr + headsize; maddr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(maddr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(maddr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -390,8 +381,7 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 	/*
 	 * Reuse the last page struct page mapped above for the rest.
 	 */
-	return vmemmap_populate_range(maddr, end, node, NULL,
-				      page_to_pfn(tail), 0);
+	return vmemmap_populate_range(maddr, end, node, NULL, page_to_pfn(tail));
 }
 #endif
 
@@ -518,8 +508,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)));
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -527,13 +516,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(next, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
@@ -543,8 +532,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)),
-					    VMEMMAP_POPULATE_PAGEREF);
+					    pte_pfn(ptep_get(pte)));
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.20.1


