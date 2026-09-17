Return-Path: <linuxppc-dev+bounces-27547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D2EC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4L66wHz30P3;
	Thu, 17 Sep 2026 15:41:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623029;
	cv=none; b=Uspvk8N/Z1qZpLAEGm1Nwx6MR4Zxi+/zW8xLr9nPOMHPUD7JmnjxwLEy5TkAyrGZlFsIZiFHkATy5plMF8wFqECQuukg9gmCEURrt+w0cILvP6Bbu9EnYS9Dt3Nw+yvxMelpJm9fKdF2Y7iloYOrdye45AtXvtADvyeH+MKiIbTNzCuR2ePjm379BlL+lfrJIeMrcdIbUR1legqsr1Khoc7kI3ThU6kC53Nssjoacaxq68Gw7CckcRiorusI6PZCXfLUEr9QmRnV9Z9Z07c5P8F8/bwo8efKh02yLypbG8YRt5cE7Qbxcse0lcshlJA98JvMRlh1KZ+0hwpwJsITvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623029; c=relaxed/relaxed;
	bh=G8iXtJFaILHaNQYB7TRtsKAUY5yHxckNGkamGztIiuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GS2OR+NJLKUd6LOBCr04iFwCKDJ8/D+UxOtGRwefc5bqvBq9t8CGux0bfIFt987MzTLLRhLSAxSSE/uOEbEU5fEJbMEcsFTMsJOFVd9J4LqJc+FGShKaSsyydFhrMYRmM1yCo6a3y9fBDyBYyPn9bGmG9yr+eNGcW+YagDniFFWwsUSibUMjaNMG6wwbJmotXY19f6MoIbWZ7NmoFjqOozsEfC3Xd0QUQFfRyc4tbXUA4pSATqeC70ryxQV2kovJlr2c19orgyn8Mx+L2MJxOIRT/HFl/q2598XUhUKIoHmMZ+IPIFfB+p/fE37nhCw2GIJsHm8N157+7LDQ3/zzeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVDBVtCa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVDBVtCa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqT14x7z2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:29 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-39d654f02baso349117a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623027; x=1790227827; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8iXtJFaILHaNQYB7TRtsKAUY5yHxckNGkamGztIiuQ=;
        b=AVDBVtCa0AQAZSXmCFa3bibEozRHGlwc7oCzs28VqKlTzaraUmIn43Is+08fzruwl1
         0AI4pFSbG0irgGDqlupd+UJoy4mkE0ne28R384lLrBs2Eu3FNpxDdsrhLPFqoHiPQ7LV
         Of3ond68voVyVWPuzida0sXYSL/rFIY6KOm1odx18qL7eUvEgEPr5/hhlJEEZQ3s9veE
         lsBxBetrCSTO+IfXQ+oYWxvXiKlnjK2vcogaD/o2UfYPXjq3n/pF1CQV8PdLq1vJDaEO
         g7PGcXwZ6QZIBGrmMObolYw9cru1yc9LExJyLZ5KTCF9Yp0r8G7Ihw3mQeqODrpp7MtO
         Fknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623027; x=1790227827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8iXtJFaILHaNQYB7TRtsKAUY5yHxckNGkamGztIiuQ=;
        b=deSp8lA3vHbgigDXkJS3rRH1sk9KsEJNiApqzMDDf+kjzGdAysQZGhqn3gIP1wBwLd
         ODb/bUjnat+uqc09EUZ4MVWrhfKOR7JhkdC/Xm7tp1f5sXna2Rx5YJfAQQTLw+hdmROf
         Xz0wPirdbtdjMl16OLVhfVuzZztxO9t7c+Fbo+mPkvszozKxz45mCnv0lPgyPSGKDhBW
         EJ1OiJzWWfY1JYv6TwE4+R2ESZm0xeRQbqwIRg35JliY7UPCLRnT6zqT0QYQoiij3uY5
         94oMzIc1V2PuYAkIaMr969KTjVa9gv/PxAsZwWCg6+0HI4sI1iZB+6cc/x5u8UJFcXMI
         z/rg==
X-Forwarded-Encrypted: i=1; AKwUvBxG0h/SLMIZ2D7FfU2oQyTnHHTSWeNeZY8vBaD9f0XInnoZ3VjmbkNetvZfGwr5k1uqXoAOjsdv3AKsdws=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mSDFx9KXHEgShxVWkw61pe9BeK4QMOtUW88AlypWT9tN2NsPFp
	pBDZeoJpOM91rxe0yyPhIv+kSrXaAigxYCkuV3g1I7Zt2WOXpQCIbYLD
X-Gm-Gg: AYBFou2JKd+ptgxBU3ALQivnLsXM3O9VoCqCIYGIEeznqlxUaPLi+acA5tmwD7i4BIN
	11mAjCFUbmEmKTnZ3T9VmO2U/Oa+M/VDbXJsNrrn8P2yNpSEZUfwVx083hu+N6Qb8paK+dZqANz
	S3AZPMl9gOydkotnkgO1VYBI9OMJlSewZdFOcDfQhXMlheTq95a4voEdT8rE5kSfMqH4PJIkIFu
	Z/rAwAhe7qICRvTIUfI8e7fZ3oj4g37OpsadMWNCDr9vHpneDBgMeK5vSEk+i8eS6hLzO7zL8Hn
	Yv+PPhbgIkh5CteQDYPtGkBNsLW/oFcqdg1dCib2r30tSz+nCK799hV+ko38gMNXHYHIDxWgkro
	Bl1tTrKp0nE6LLP4+Nz5HMmG63bUYE8yycOCb/BIwmXuk2OGsBgGRmItYhCZG6sAc7bPmjFvqpx
	ZdzZszRAkom9Csmsc/Muud+cGoEoZ9XIAZZ0YlCFZ0wpQ4ORfaCGQlmxkH1xkx/O0S5ru0fS0fF
	5Fp3K5p/TDHit1zeGe9hF9pa4A=
X-Received: by 2002:a17:90b:4e88:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39e1e30ba45mr13210240a91.11.1789623025225;
        Wed, 16 Sep 2026 22:30:25 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:24 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
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
	ryan.roberts@arm.com,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v8 06/10] mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
Date: Thu, 17 Sep 2026 13:29:29 +0800
Message-Id: <20260917052933.188679-7-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
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

From: Wen Jiang <jiangwen6@xiaomi.com>

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
index 025b3a848d564..a0508bdb7d36f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -90,6 +90,29 @@ struct vfree_deferred {
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
@@ -98,6 +121,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	u64 pfn;
 	struct page *page;
 	unsigned long size;
+	unsigned int steps;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -118,15 +142,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
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


