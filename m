Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44616606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T/A15Ll0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHVt6WqQz2y89;
	Sun, 08 Nov 2026 00:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059430;
	cv=none; b=akFZcmVCUpDl6uEuhdyfTJbgN3jKBX8I8YP4etE7bnLA6u55+jCwriDbhLOTbCt9p3f3VuyTr8dxP6d2GHEs28p2I6IOvzt4poiYyGEKW6PM1See5inLYxvHxDidVfd7hAVd/N8VIHAhrNJf07X4uTRGm9YVi25JM/zzu53QL5PPww2zLrHV1vaZ/qYR0ek3sTDVgeTconCc508ohUEiKCsGbekL2Xapj35V0/YXoFNXHhiFWasBlTQvb/HfSXfs5ZDUYl2M6DdqiMJ+Hd5/BqI6cDrP2mVViGkQKZswXI2D2riBX/zTYQTMVeA3zrTdPOHT3HAP2kawHH6u92ZtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059430; c=relaxed/relaxed;
	bh=Af7cKlFoogk/50NAo6rFkgmdxcBnIE+i0cwBb3cAFcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBpIQq+ygEbhVmYg7ZY9rWEw14DVnBzuDHHl9QDxR6Vo14dc9WzMOxjutgQ5xw/KgkY+1QNZZCnJi2+GjAGVj3fp2XSjRCk0xqNJJrTa9bMTSzO5rlf3EtzIh9jo+krvY9PzuU0bGSCz47+XrPLDDqpqczwj+o4mfMElISlXFfZfK2QhF4hf0lG1VKC8tnREKA7ULULlgAfZ1wKq97NYmk6eQJPOYxTI0Wm85PM4BSeJYF/AFSnF6az/oXeYX33ke5KRL57sJ08+YMIO4fhDqGeGYbceFe1o+9QmHtwbQMgrfZILpCrjwdnGY+cemSrjLbiwg65quHFzipx7GnV1XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T/A15Ll0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T/A15Ll0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHVt2HdQz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:30 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-37198ed3727so263386eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059428; x=1794664228; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Af7cKlFoogk/50NAo6rFkgmdxcBnIE+i0cwBb3cAFcE=;
        b=T/A15Ll0Gn2V07OkyCqOLmNKvV2RxOzcpwxvP02uEMF0PAW49lhKXtSjnEA0QzIZW0
         R0InH2e77/pA+sG9hXX8F0WUkUp9Tn9u5FGcNYhlTrsRCuwAAbpf+egcjhl4FdB7JCa5
         qL8nXZvmPP9q9N4c5765ZBKj5rtV5mmIQMfGvfiC0Fq2x4WIAE6mGflZsbCmbQxE+ioT
         ElHA8dA1eZd+7pGsvcFZAfYjeh73BdgTM0jTmnSzs6WJxuvgNYhXv+O6QHrKVJz9mdXr
         mEN+/9gI+kr5mpVm/sj7quBEMeMtiCpP1XLdrdwXY0pDYGwO3zkFz0BAF8EolstQ0uP8
         hzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059428; x=1794664228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Af7cKlFoogk/50NAo6rFkgmdxcBnIE+i0cwBb3cAFcE=;
        b=0tmPHNs162cvwp3bWZ4vLalp6GChkFQ8lhjrU3sHwzp+t3hhmFTk0qYbMbf4L92aYA
         LMljeRgPeQ15+z3juIQeaNlvs8DdDofDVS99pBHyKRIqxzpYLLItMjkkIw46n+/eZWpC
         goTjZkWFBwIExIZD5uV6DwiqtdVoQblhRdg1mbgdDF4T7EBVwRTRVkXL6WCVbSUyi6mA
         3jIVGOrboY6PvSHEUtcToqetU6UhLkrHi7Gffapp7iD/qgTlJLTznSzG4NlJVH63zqRA
         FkkYBI8H2fS3YoOvmuafwUjjuRwnuVC6KHNvO5nKUX6ITKRG5+A30R46rMXWMDzbIbf4
         wZtw==
X-Forwarded-Encrypted: i=1; AKwUvBz7LJ0dYXrbvYiCAMpUcnO5rSNlqICO0Pc9HBA7h2woQ+elr+kgs49hqufS/D7cJM64/F/Xgg96AzMALcw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+O0PlxDCRpQjkJZb1v4ABd5Yr06QZJIW74EvTkc81wpbuCU/wF
	Druu8auymaQZXq05O62Zdy8/x+oGiIDd1KNAsuG61F+thdWTMq6Cfkuu
X-Gm-Gg: AYBFou2ZgdwqHCSP8xI4RJu1BkJI99QLB0REN6dEj0lrZ39DRONe0ehcis9PTF25DkA
	Cxhot749KpvkUU0oWUHDWqkSVQN2Hl8a7pg4kQDS8G2o2bq4hp0QG6j3TdPfHV6UmyNju7p2688
	lj+x1KLNIG8xe8X3EEtKlprJpyTeZmSdSW5dcLRSKNAnVBphN/2GvH/3DEhNdOUAc/4rAUV7ggY
	c2PEgJcPXhRUy8xGPEt2snttyFeQrcnjG1UlxLwTzRLr01p+FehArid3oSUBXBHHAFBOJF+YoDG
	AK9ym85aNjuEMhOmtTo+GcibXicxoC1MMPeShnFxrxF3hy5uwJUCVYCzv/x8EEuX36EMvzlIWFA
	Gy7QjFh7XkBZn7emyjDWnmrnTfHCTpuoNSRvcd1gQqbzfTf9T3ux3el5oc372Q7bm/y+hxVBvNN
	0TyjwZRAzkGPFAd34RuA9WFJP7fFjVB2KuY2Nwy2QLFQ8Yj8YHiJhSeOog/wSDc19eAusK76M/G
	kpjYmd9qbcS/76M7Ca9lbF1xLLHWEygX8Ga5MNqEy76iRBCAhu1wenjnk2Rh9olRhfo9uRhcm1h
	LSw579X1rOQ68/Dl+7Dx6pCzOcz4rGAIX3RdVN8QMaCKSY3OuZJ4hTPBhg==
X-Received: by 2002:a05:7300:c00c:10b0:343:5f5f:eef0 with SMTP id 5a478bee46e88-370f7c856a4mr3702462eec.21.1794059427852;
        Sat, 07 Nov 2026 05:50:27 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:27 -0800 (PST)
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
Subject: [PATCH v12 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
Date: Sat,  7 Nov 2026 21:49:47 +0800
Message-Id: <20261107134953.748622-5-jiangwenxiaomi@gmail.com>
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

From: Wen Jiang <jiangwen6@xiaomi.com>

clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).

Now that vmap uses vmap_pte_set_huge()/vmap_pte_clear_huge(),
mm/vmalloc.c is no longer a caller of set_huge_pte_at() on arm64. The
only remaining callers passing &init_mm are in arch/powerpc, which uses
its own implementation. Remove the dead branch.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
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


