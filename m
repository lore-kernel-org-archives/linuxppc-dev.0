Return-Path: <linuxppc-dev+bounces-27971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7120EC98309
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrZ0WPXz30RN;
	Wed, 23 Sep 2026 16:29:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144958;
	cv=none; b=BrQv4uCiVshvU8fWxITraTlm0mjF6aiHVnUqag5tljnAlDMUkm0T19BFVvMdRUWTl7AfSr/jg3dVTLZBtFuqcvTJlGYt9oc6PpLUpZUMdMI90JdyZJVRKOtkqW8K3qwhkWITRXmV/T9D9BMlB4HaR4rTavpvvi46z5/X6RCSKHDMcKg/9A7bLXfF8QPJF7cInVp6YZ44FV/zYhcpTgpoHkaD/GhoRAKJRhrhJE7xekQheoE/0IGo37EgBf2HaiqejjokxiSX0rw2GWXHRuE3N2tQTWFFCR2QUX6K+eUvrk9XEMEZpceQ4ysx4m0zdtiv/x54dqKfEDuTopISWo5GdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144958; c=relaxed/relaxed;
	bh=XMhtuKKM9junrQcHfwBMD2RoOkQktkfIp1wjOSUMcpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlyFsTHV/wrmDIYsYniC1D6R8xbhGHBKlu70F060K/I2ozDoCT92D8qap4ujVtv8708/VWh0gR027SXap0qT6BE+4l8F9msRCqp3xHz6aB7TJmM/iVZ5awpuGLka0DGuBi/tZFZzSgr34vtl0Otai8D/FKJaVCt80YFqgX4QOPJlYIubFQ4yTG/qdloSbMPUsuS/BMXhDUh/W8CQ+CNfk4YsahKmMykeOBWRDCLdnMTUE99viUzxro0LDt506sk44Mp1xOe2RsKVysszBv7oVvMc2lE5Fwa8wYUWBSzne7qnJwjiKw55afgoVTNZmea7lJvG7e3VVceEjjuCHZ/GSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FY2lnBam; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FY2lnBam;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrY2BF7z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:17 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ec6188so2474625ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144955; x=1790749755; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMhtuKKM9junrQcHfwBMD2RoOkQktkfIp1wjOSUMcpY=;
        b=FY2lnBamb5B/69kuBnZ/QK1BdEYQVgH+XlH+biT30Rjn+RIfc5usKc5Qh1YRVNGAE1
         NFxvxKI3VbaswrkPmsxGypNMM1imMKDtRKcG6QPS+yWBSQPJ6mFFtnlQpiaShgLGQvF/
         HHRwGJPhu3YpBlVa69PT9o7O8yy13EkZg52jBt8fQ8RdaVQej1b7CnryfUtNEJMq2Q5S
         2DqJcft2SC3muiAbiON75S/DJe/D1cnp9ERPTXRVvNVxoo7P+BaoSAVkNKBchMLujCNU
         +bNKXj1iXo8TTJa/2Y864vYmWubq7hoaF3q1ZYRLMDsowTpseLeGqJjvexfTXqUY4HLB
         7FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144955; x=1790749755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMhtuKKM9junrQcHfwBMD2RoOkQktkfIp1wjOSUMcpY=;
        b=SAxKN8kPtGtx9ke6nOw0tveBJOaTBPavGiw1dxdxkfyPZOWQJ9z0hCDV8baTmqe7Uu
         gOP3gbWl57xfaTHyFBLuSiDrGYyGzC4a5ugVu531Eu3VYJFggd2d88gYnCn/IZV219F5
         kydCQM6ygGWCfWdKYawhmShkMQSGeMG61H29YflzDzqsEx5LzYvlvcOoyJlefWpvWRiv
         vofGzbGbCyUTFjro5pIsTYqAmx9HQGU3g2oXfaqA800NiVq4D7XzTKO8qHAusBZzcnnc
         pJcwR/sbaRUpq4Vx+yFj/tPGvHJXCS5itemROZHdqkuAQNT6d/mZHFq8mipigVg5MynJ
         3MFg==
X-Forwarded-Encrypted: i=1; AKwUvBzP6thwA7uWApZpw7lllH2vR449+2ohkN3QlKgrBgkfqmqQjxqUkHA9iy8oBek+3twSfOAHDXj3ekDhaeQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mL0fPaSMShmrmABhvuSqmtAVboJN9TRGoqgVtxRvUsBpHOTy/f
	XiAdfnSkDw43Mr2rkFITTxZ2Ba5xIb+cpQxb0K5v1/7W2VdrSZklJNTT
X-Gm-Gg: AYBFou0wPtGT8Ml6/9Nfk1hmGYHSUa0VIeUetX0wdtyghp4DNqBu5/dJma0FjAqyneX
	bBzkHgobsEW+PlahDTugzz+SqhinaY9CVhToz0hd1yOR03di52cjtJhj+5Q5JwbN3LAmjIipuVY
	laldJsQbDbUTUEUOa2qwENoe/YTXMSgtribJcHBimxpz0+qIvpjO4NQrVsCfsU9AL+DcKmmXnsQ
	5yMpTXh2yjwDb0CdiEkpkAAqiYpK3KqunOc8eK5lKiliKscRZI25v/oJPS03S1JcrxF4RyQO77w
	AWorhiy27vB7L0iXJX59ZN+HnAAYKl0Uw/XUpCyI7hdB7y4pxdzTUFDf9NJtQDNhyfrdFyDgaBy
	u9O5AM2NT4ORZyG+pmtqKF5cekoxTR9Qez2tKfK+BvegYnJ3LfyXfyXrgqs5QYMpOXjlf6EKK4O
	zyoUkOvTfS3xZYfIJlWbXPXpeLAChIQhib2KfeFelfFB7AXCbFdaH4jFP19PUCIQ96JZkHmHmM+
	vbl0IQlcZS+c02EURdSNg==
X-Received: by 2002:a17:902:ccc2:b0:2dd:c100:4249 with SMTP id d9443c01a7336-2df69de978fmr13493295ad.45.1790144955081;
        Tue, 22 Sep 2026 23:29:15 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:14 -0700 (PDT)
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
Subject: [PATCH v9 06/10] mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
Date: Wed, 23 Sep 2026 14:28:28 +0800
Message-Id: <20260923062832.479455-7-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923062832.479455-1-jiangwen6@xiaomi.com>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
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
---
 mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fb757d95bde25..d475e52110e4a 100644
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
+	unsigned int steps;
 
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
+		steps = PFN_DOWN(size);
+	} while (pte += steps, pfn += steps, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
-- 
2.34.1


