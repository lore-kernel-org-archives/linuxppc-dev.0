Return-Path: <linuxppc-dev+bounces-28729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26D3CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30H43RBz30Bd;
	Fri, 02 Oct 2026 19:10:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932223;
	cv=none; b=NeLwq5P6qOhU0GdWtG/HWGPHb0vgxQQZffjzCJu0hSfCGoRf3X+MA1wIidnAzrro9sNtr1uhifOr8fnonMKPAx9PldXB/nhqpLOoBGG6L4XIRrL+qVUA57q4sBS7NJ1CLIqdpVcUO6EjpYbdjGZgpAE5fwEqzIPAbk/r56ItLSjdKos4JheRJI8vAdmUZs3Og7VIFbCLp97nGM3JnKJCofLnI/t2P6GABvJ3hdxp3pK86k1cEl0BIa6im2FuVvYC46QcX05l1CuabxHjTkOBjg+D+ryUMeHeCc6mGff5QHv7JGrRfX2xey6OYHS6uKmYJp1jl/j8mDDD0+1H3qQsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932223; c=relaxed/relaxed;
	bh=nTdpftTlHppV79iqmYzW2DHPoEL/OonFlSGPOrnWHYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LF4q/HYjsZiforTJ9qRbZDbJ0xV51uXmJr/ONECVXAuTVU8xTJkjWMw/ZJtFlUbtqPyjCFBrhvhlYsRcgx0OFpCXImnD40r1QeitmUXhK8SPrjUvIclN7LKsKLRru0xlkzuMIKCv7U+4oTvLwQRd+rDLO6ycdoBnJ+d7qje4RKBZag0/anXhDQ4U16OzBK7Aeykc5pdeYttXqvfdMzKuE9Y0om0mU2kPRnV1hN6FpmYQIi6RVaUN23CeVpbKh/vx0b0CMsD8IJDA6iSfMwO6uHo2Md3yhduT2yG30dCSiKp77WvJEHwUefJV/E1rBEvag2SOq+K1BVh0W+Umq9/5ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HGuuXYeZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HGuuXYeZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30G2P2Gz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:22 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747eb79f7so33797335ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932220; x=1791537020; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTdpftTlHppV79iqmYzW2DHPoEL/OonFlSGPOrnWHYM=;
        b=HGuuXYeZSz9fbqrd1elXX1r3FC1tLUbl8A/ThvOEulP15obwF9+s6DQ6oxNzPl7YZZ
         wH8GbAm6et85TSRytJWUAVIY0obCHNF1HrFrzRxY7I+h5hNLhhRscrd5vVk5/iMBLlQZ
         W7oL9s3j3QXxi3URQRdGDVhVCCxOh1DG7Ebf/EeeORlEW+fi37D0YEtaBnDI7ybNVwwU
         AsPiTCj3RJRRNKHjblsgL+g/L3FQ3kuydZgNQdNxRoqrqkIaJEw5FkY4x8m0PSJO6RIX
         cICw4KY/cfT43uPBiVUb7+6gbKiaYcHhNjdpPuPpFW/1LjfGupkJFIKMRD/aTUeusxgr
         J+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932220; x=1791537020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTdpftTlHppV79iqmYzW2DHPoEL/OonFlSGPOrnWHYM=;
        b=XA/vcxOgmFH2LPEaf7FPHl6Lw3OQJCByhVV4LAOYMt5Z4b8fDTa9To50PEU+F3Ku+J
         DufOZaKKhw4eFTHO/cJ08aWIMMY2YTxf6aBUaff5MArN9HgjHNEB0nAslu9UXYDUJxsX
         kWxTjxaHuQMF/OUD9pwhQrG6PGkofLa1W/jpUQGdtQqmzc+24GqGE9UksrvQVFgfLE2b
         1aH0Ufxyu8eBJWoD4l5eMczkBM40nPNrupIo1cU+4bP4bsdOX88PR7wptUC0mVR+iEFK
         UpxJgLtEh+YCsaxW53XM6fqAdhry7DxVeMxnMmZf0xf2LD2C79xZIlh537XvzymTUTD7
         c56Q==
X-Forwarded-Encrypted: i=1; AKwUvBwSd8Yeffg7i0jsuhKZsaeW4E4Y0esaGD5Lf5g2nXsbC539grH+YrNjgzU93RWSomrfU6Mj0nZy8KVwZQ0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ5m8nXt7NFr4OkgBAiuug1j+aZ9tSqcXuAWAOXj7n1qWJwAQwu
	qDmO0MQt6byjEyjQquVTpk76B0SbKXhL2bhTxSeapRQkvYytKACXF9Dd
X-Gm-Gg: AYBFou3f6Tmt9y6xzyNCum7P2Ok3rZ+/4Uf6VVLP+se5C9mhKAzVrSyGEhMyNXlt4i2
	dPIL0ByjzHMtA+QEWuoMwG5pleY/MtNtdI9KN29sARvJNEORY+HEdQkGJjwFFHIuAu1d5Xzfy+Z
	+yk2GjbsCEnQRH85gcaQzNSSdLp9aH5zCXbKk8v4KhECWwa32LTHo1KJE3DFbryG5cADBmzWVb1
	fGgocbD3XXZYE+jQ5jW8OnROEDiYk4QxdrieBqmW2fsckxmAYuxCzbhICcowobW+P2SChyUmkx1
	Y5XqM14dcM22wpBHcaq8E+MtKpVZO5lRWvff7BUuGg8X3EcnyrKGbbOILNAxaulN0G0jYWueK5O
	/NcxoZWrcxU81lkIW+s0QRGACuHcHy4sq5FwylmtbZ48OjMZeAU0RkaIiQl6e3YRVIEGfbzlkQj
	3R9zPB3izvdwPizx8H1Dx6SnTggKIdGPlPgx/d2rWYYNLWT+GKnbIbiafaJ2Oakqa20rsM0ROZu
	R+bq3OsE85cRIgbqCcpKQ==
X-Received: by 2002:a17:902:e88e:b0:2e3:598:75d5 with SMTP id d9443c01a7336-2e49b6ad85fmr18169625ad.74.1790932220371;
        Fri, 02 Oct 2026 02:10:20 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:18 -0700 (PDT)
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
Subject: [PATCH v10 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
Date: Fri,  2 Oct 2026 17:09:41 +0800
Message-Id: <20261002090947.869220-5-jiangwen6@xiaomi.com>
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

clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).

Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
longer a caller of set_huge_pte_at() on arm64. The only remaining
callers passing &init_mm are in arch/powerpc, which uses its own
implementation. Remove the dead branch.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/mm/hugetlbpage.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 8e799c1fe0aa6..ce247b06fe03d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 
-	if (mm == &init_mm)
-		flush_tlb_kernel_range(saddr, addr);
-	else
-		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
+	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.34.1


