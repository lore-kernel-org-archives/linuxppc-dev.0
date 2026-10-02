Return-Path: <linuxppc-dev+bounces-28731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF4DCA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30W0Bnyz30RN;
	Fri, 02 Oct 2026 19:10:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932234;
	cv=none; b=LUeoJuDFctnBvY0EyxjfVEeGT7kX1mb9wfY37Pzo7KD2mjt4RRkC3X+JZgh5Zr/7kiN2kQGgisysSqBnv0KD0XKtqBSZ8f5+za3sVccdDEoSPOPSdA2ThdCaVnMX8EgrK3CU06kIrFkQGwbzoeu+RRRUYcl+etMRkEirp3S32JYHH0SXPiCi3QmymH2y677/O78y4Ev7Ql1jJXpxDN082WInnofJJfpuIo9S1rRCql8RBoJTKJLSibsWoT5mdwuuFN4GO005e5/LVDhROMkEz5zHiGM8i5sgTAHA/7mzlXfqp2IPVBrDfa8hmRnlOU592S8jIJilmbJfITLoc0ayAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932234; c=relaxed/relaxed;
	bh=ChtYARSDq8iagNWO9IImP3K9FjWMJua7ZspoYb+TKU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djXyJCKzIn+jSSZYa6LdD+xElCvFaTsmhJmZo4WWrEm1maq/wgLg2MkKsdFrwNeAPlDtgrHEenXI2DA+aIjIlxIFThpDwaW+m/CLhXmrtOXFxRdhLARIfNlBeo0YUVJhG105leOkO7IDw/pgiMudaNkAmuGDwO+TQ/xyoRbRewAdvDGpa6PvJqz4IGflFtK4Rp2efpf5cXtgjvndR28CPgMDKcO1coCGRVE0GyHXuhsyshg9eELeJiiyaxcRgtl0b8r6+aX9o5a2iFQzaRf5SzTInMCIqxe294l+6U3Iys9TjHrUEcLUR4STA/UfF1JAi9ElDFfS0RuguzP5WYt+cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kF03zPGT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kF03zPGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com [IPv6:2607:f8b0:4864:39::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30T4bC7z2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:33 +1000 (AEST)
Received: by mail-pj2-x2a.google.com with SMTP id d9443c01a7336-2e2d58a3b05so30798875ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932231; x=1791537031; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChtYARSDq8iagNWO9IImP3K9FjWMJua7ZspoYb+TKU4=;
        b=kF03zPGTLttYz0R0yniw3bpnCLQy/8R44McmOdpuZ91/QucKIPYixwvgEejppnvSUl
         2wn8UqPtX2fBCtYc2Ucr8J4qwI7TLJ43NpZ5ha2M1BZB26RK7TSeO6GvrVtH9LZ3Yjwc
         V1VatPXaWmulHotA/OlGq+/8sF6LePQO2QdV77CZC4GAmfzv2cJWkYh/os2pj1sZOyx9
         ZR83SKK9DkHQ2lCcnJdmBflIVaFH1j2/6U6hGGJXpxwcG/pSgIxz7axKilynYCXYnZ7q
         oJUsHgswmIfKKYprVRnBVOhNKtZkW+j13L1O2trc330QZxAHxn9HMonL19eL7oEHRSjZ
         rGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932231; x=1791537031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ChtYARSDq8iagNWO9IImP3K9FjWMJua7ZspoYb+TKU4=;
        b=EjIwtnfUgfm3emIjwhkC+SyxPeWdlIxbXXNQe5iMj2/48tr1jJGgKOWMvWMzLtXvNB
         pMrw+W0uN4l4BoaPuqHV3QgyrWcPC8olO/aL4ypnkKeoGw3WsVKzYl3YU2FKe8RG7I2n
         LROO17DWBk0rCyoRiA/kLjGQC/2CJibwU5iCuJaBbOVfz5jMRkw+AjUhSd91VFxlsaJB
         f3XGWrx8TRPIb0MvRcPKLqS+BqF2Qe12UQEU6qFnatIpm6OER45G0aXoXc+OLjIJDolv
         WdJHdfDUDSwkdB0idyClV2G2tYswMicxXdaP82WcdUWVhFdtlzBVciAY9dXeFNNqkfWr
         u/7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxQxYoTnUDjOl0LT2uE0F+0e0r/aYvrGWal6F8hwSTfxa2zrrjz0ZJI+ntVH6jL/7pfDRRVQkdkd26ixxw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKHQ/LmpTEmSMYcA6qShzYGAt5w9YVEP/4bE13CMgo+3sL26xEh
	6SueVAfx4oIbHeSypn9VOHbpBqEPj1gUoHbgAUp9fb0Ji6bS3Vr8kzLL
X-Gm-Gg: AYBFou37q+ipXb9DcyQrf8C8j093j7KnkblUkwZa3jlTABTMPsbBB0NA5p01CKqY1IJ
	60IT2CBVjLEe1KV9k0i92SkGbvxqoh/PPN6omSk06plEQ4mqXD++TKTxbHjopZA2JLP1UZiShq9
	tLwdcpGN96yUWqkdVD8CDTh2pl/fc0Amw5wBAhIFINLdw5w/So3l4Z3ZIbArJQQeRQ7rVPqeIR/
	8H6PwkvHQTydPVlObOjN+Dj7ZESlyHbtHqPfgnDGQejkGnOJK90tVm59Fg3rmFOjAAWSd5Ti8Du
	Z5LQKXEE8hmq0I4NAdKSDbP94LaGiwvme/uBSXi+6mxVR5qJKHh/5FYk5tQTU/ag7bPhff3eEhz
	GT0VrzWze10I7Wo44lgQw4561cxMw7ndZfZVyER/VIvqqtpAzZwa8T/WkM8rTPEjfB7TnP3HJwZ
	EsaSApS+zYiYEdQ8VXF0wh1uWsLZyLr34xDRapYPAcDvgtJWFmHetfBPNSY0shj2MrkyDHo8Pu9
	2C+bpN5LydIFF57TAzKUw==
X-Received: by 2002:a17:903:1cd:b0:2e2:e6f1:5e10 with SMTP id d9443c01a7336-2e49a10450emr17761045ad.4.1790932231246;
        Fri, 02 Oct 2026 02:10:31 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:30 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
X-Google-Original-From: Wen Jiang <jiangwen6@xiaomi.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v10 06/10] mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
Date: Fri,  2 Oct 2026 17:09:43 +0800
Message-Id: <20261002090947.869220-7-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002090947.869220-1-jiangwen6@xiaomi.com>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
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

Extract the common PTE mapping logic from vmap_pte_range() into a
shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
PTE mappings in a single function, preparing for the next patch which
will extend vmap_pages_pte_range() to also use this helper.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fb757d95bde25..72ec1b48a76de 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -92,6 +92,29 @@ struct vfree_deferred {
 static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
 
 /*** Page table manipulation functions ***/
+
+/*
+ * Try contiguous mappings at the PTE level for arches which support them, and if
+ * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
+ *
+ * Return: mapping size.
+ */
+static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
+		unsigned long addr, unsigned long end, u64 pfn,
+		pgprot_t prot, unsigned int max_page_shift)
+{
+	unsigned long size;
+
+	size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
+	if (size != PAGE_SIZE) {
+		pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
+		return size;
+	}
+
+	set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
+	return PAGE_SIZE;
+}
+
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift, pgtbl_mod_mask *mask)
@@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	u64 pfn;
 	struct page *page;
 	unsigned long size;
+	unsigned int nr_pages;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			BUG();
 		}
 
-		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
-		if (size != PAGE_SIZE) {
-			pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
-			pfn += PFN_DOWN(size);
-			continue;
-		}
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte += PFN_DOWN(size), addr += size, addr != end);
+		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
+		nr_pages = PFN_DOWN(size);
+	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
-- 
2.34.1


