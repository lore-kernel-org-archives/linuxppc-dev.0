Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AF606D807
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6HnYRJq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHWG1vGgz2yDD;
	Sun, 08 Nov 2026 00:50:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059450;
	cv=none; b=U3OzjiOSkxw+nVT2l9aWRmLSYmn3/ifxNawVIZP3E4tVoi5yldpFbqGIus8ve1X1oOHYqGXEKB8lrh7/Ki5gF/r+pkahifYaBxjW6cLlKhtTwoVUsRopyQHlzIDwKCbv8PlO5wofa00LNbD2KorCSaOovLmjggYry3IrNFtmIcxaSEBcBh54l2vNMqP+CN75n1fcDauijp4ErZ25GEQPKweUiT9I+03Y+y+N+HOjR7nlgnceiYYFzBSr+YxxmqwJn7iv9WC1YsLUHAZoYmu5g4ZTesGOeWVOkgox4V2qSEAQOIxh3vnqIEximBcaZHrcGVFeAr9CmiCciElmg05zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059450; c=relaxed/relaxed;
	bh=felPx3uV3OszLiAgjC6qYiNB56VtKrw17gOMSvN5MlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0bxkn9ZzSozxsjP9o65XMmj4mZbOVjWcFttAE3IbBgfIou1OS6pT04hGqelAW4PaI5/Z0kTRq9x8Oa73nE+l+W5f5mYEvB3QKKuTX6XYupb/ysdxbMp8GVedQVTG0O/hK0FsfujlcAWpX9YdMQoO1NqCOtSvy9p6kkTYOfUFnBpu9qr1xwOwOrUNlYOMlmSM3gcfmGPV6KPJBqkp98+Pp8VIVC9IUhvfbqzLZ/3Ls8vXGVHZo5dA8ZpwcaCvS1qYbopYQE5JpoHYCpL/wlejhJCpcBUBpwxRgGnDBFUhOH0zvgLtE0R1ssRAo6agvZgisI1wc4GAPFyOfST4nITCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6HnYRJq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6HnYRJq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHWF4dwfz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:49 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-19305bcb72cso1478572c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059447; x=1794664247; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=felPx3uV3OszLiAgjC6qYiNB56VtKrw17gOMSvN5MlY=;
        b=t6HnYRJqH8QxhdbxhHZljYZnmiKYlRpwEd9oag1nj6YiOr3j/TmumDOW6XNZyLRpee
         i8Au1dGmsz7TFdBGrL7kDZz9GRWxQ7Hoday9Es7JZZpGII5COqKQ0o1SI+GJlVGoIC2F
         DC7Jl90fs3/JB4jGs6eewu0uLW6X5o2cid8w1Gqx6Zc05yiIAfr116bHpi5yzgDL0/b2
         PplwXNO8cwxulPDxy6rqocElPN0yQe/9UbAQxPHuJ+shELD/1Oxi6+JFli1vjGUAovBz
         n9wabzibNg6UPLBmQTML6Ajzta2fuc+Vd9E3UPlTU1RPdm9/DLyN/fDtrus8BKJn+ITU
         B8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059447; x=1794664247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=felPx3uV3OszLiAgjC6qYiNB56VtKrw17gOMSvN5MlY=;
        b=t2rKuvAzVrrX8pZ05pevGBeRKJx36A3xMT9joQ6Uy8C2OnFXHwbjk0Q8l4rmYOOhPz
         3HtCAqEfg2oNj/ftG+f6zVK6YyFMOIP+rVWJS8j5/2KltdaCYbZ2JYV30LUGPvBzW0Wo
         tn2/BS5vfztxUrM/S3FtyklbHJru6yV5dZ0VqoycZ3vVJJhUYS595Kq09ellukEr7ivm
         UeVhPuZYFbGxkSzAPl1Cxr5LQ+JYFO5uNjf7Eh+fz7qX1X8FgkME57g8GIL24SChtFEo
         fpsirk1R6MBN9rZWRP5xUAfzLKculebhrl9uK3VjtqxkRJs/tcsARJ3Tj2L5AjilNvVf
         gJ1Q==
X-Forwarded-Encrypted: i=1; AL+hErHX4TzsmI7VhTtp/RGwO6e6r6UbLtWla3pyy00t16qDimDFhIEIlfUYZO155bpZ+aRUTM3dN5fn+u3+Yo4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/IfdUR80W2LUGJMQO41r3xY7fYnG8kRO+SefOywNj4sURwOabz
	/+9th1oYfV87ouKvIYhoH+qFJ7C59j3fWuE6jmJ/dKrjlzsQKowhkx6z
X-Gm-Gg: AYBFou1pkdgmReG5iQJ9sfrqwJB0TwnyzczLnFOtO2wtcsQ4U9Fx1WB6hT4BL9qHEi2
	c+qszwdFJASn18Mu7PFJ480kosnzYVclt3aIfcifPyIbweAoQBDn/Hnda60g9THVqXDKXrol6WW
	Xp3WkEYRLULWWiOsb1fS926uLvNViwg+roon1zL25BuvZunCIkaNwVJhw8kOdIGQntOWTUSRaH/
	2Xa92RJLZhadQLeNTmmRyxLdi2PC6tk4wP7Rj8fmtRMgVXVFbfstOCYZcxMNnuoS/izkTohesc+
	iZcufwK3PjlEPmB5ao6iHWbY3rvdYSHXcQJ6LO4vD8QGDa9Prguae32hi6A376oLwIUebiqdVj3
	Jzn0xblJxbZaWKi7W8UgbVIPM5wqGOyvUWShEofemEHN6F8dEAn7FV2OjA7G543eALCWH5YMsIL
	eCYfaNC65glIVked85ePbl6DjP51ERLoPHFtFZMoghTOqxm+LSivv4VZ3NHgCKS+hYMVL8okcro
	QBXjPO/yXca+AriMEwi4lpv2yeBW2WlSRYx+oqEYFdUBa/XmHm5PJhTw5NamC6bTiHSxqwF5T9M
	z/4w+8uUeFBTUYHExxcCR8Mvaoq/j5cVLgDviUnBVtTeoEQylS+sOgWnnA==
X-Received: by 2002:a05:693c:88cd:20b0:370:1333:5e84 with SMTP id 5a478bee46e88-37013335ee3mr5769315eec.11.1794059447224;
        Sat, 07 Nov 2026 05:50:47 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:46 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 07/10] mm/vmalloc: extend page table walk to support larger page_shift sizes and eliminate page table rewalk
Date: Sat,  7 Nov 2026 21:49:50 +0800
Message-Id: <20261107134953.748622-8-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

vmap_pages_range_noflush_walk() (formerly vmap_small_pages_range_noflush())
provides a clean interface by taking struct page **pages and mapping them
via direct PTE iteration. This avoids the page table rewalk seen when
using vmap_range_noflush() for page_shift values other than PAGE_SHIFT.

Extend it to support larger page_shift values, and add PMD- and
contiguous-PTE mappings as well.

Rename it to vmap_pages_range_noflush_walk() since it now handles
more than just small pages.

For vmalloc() allocations with VM_ALLOW_HUGE_VMAP, we no longer need to
iterate over pages one by one via vmap_range_noflush(), which would
otherwise lead to page table rewalk. The code is now unified with the
PAGE_SHIFT case by simply calling vmap_pages_range_noflush_walk().

The pages array may hold several physically discontiguous chunks that
are mapped with the same @shift. If the virtual range is not aligned to
the chunk size, a PMD boundary can split a chunk, and the walk resumes
in the next PMD in the middle of it. arch_vmap_pte_range_map_size()
only checks CONT_PTE_SIZE alignment there and could map past the end of
the chunk, so clamp each PTE-level mapping to the remainder of the
current chunk.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 88 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e3ea9581e68d0..f2dd9bef4de0f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -558,8 +558,11 @@ void vunmap_range(unsigned long addr, unsigned long end)
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
+	const unsigned long chunk_pages = 1UL << (shift - PAGE_SHIFT);
+	unsigned long pfn, size, chunk_end;
+	unsigned int nr_pages;
 	int err = 0;
 	pte_t *pte;
 
@@ -590,9 +593,13 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 		}
 
-		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
-		(*nr)++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		pfn = page_to_pfn(page);
+
+		/* A PMD boundary may split a chunk; never map past its end. */
+		chunk_end = addr + ((ALIGN(pfn + 1, chunk_pages) - pfn) << PAGE_SHIFT);
+		size = vmap_set_ptes(pte, addr, min(end, chunk_end), pfn, prot, shift);
+		nr_pages = PFN_DOWN(size);
+	} while (pte += nr_pages, *nr += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
@@ -602,60 +609,88 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+
+		if (shift >= PMD_SHIFT) {
+			struct page *page = pages[*nr];
+			phys_addr_t phys_addr;
+
+			if (WARN_ON(!page))
+				return -ENOMEM;
+			if (WARN_ON(!pfn_valid(page_to_pfn(page))))
+				return -EINVAL;
+
+			phys_addr = page_to_phys(page);
+
+			if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, shift)) {
+				*mask |= PGTBL_PMD_MODIFIED;
+				*nr += 1U << (PMD_SHIFT - PAGE_SHIFT);
+				continue;
+			}
+		}
+		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+		pgtbl_mod_mask *mask, unsigned int shift)
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int err;
 
 	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
-			return -ENOMEM;
+		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask, shift);
+		if (err)
+			return err;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages)
+/*
+ * It can take an array of pages which are not all contiguous, but it
+ * may have contiguous chunks, as hinted by @shift.
+ */
+static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int shift)
 {
 	unsigned long start = addr;
 	pgd_t *pgd;
@@ -670,7 +705,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask, shift);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -693,28 +728,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
-
 	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
 		return -EINVAL;
 
-	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
-			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
+		page_shift = PAGE_SHIFT;
 
-	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
-		int err;
-
-		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
-					page_to_phys(pages[i]), prot,
-					page_shift);
-		if (err)
-			return err;
-
-		addr += 1UL << page_shift;
-	}
-
-	return 0;
+	return vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-- 
2.34.1


