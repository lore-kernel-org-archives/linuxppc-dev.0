Return-Path: <linuxppc-dev+bounces-27545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27377C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll434mH0z2yr0;
	Thu, 17 Sep 2026 15:41:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623014;
	cv=none; b=ZXU0KedlKSf4bhSyDM73bGbi1ruSgwVrvm88Y8ysJGARlxafhaXcRIyl9lPeQSvz7pQTCB/L7wTBAXYgE1ZfRtmejeL+WbdpIS6fHjAAlQCqbkJng5hVQoEUFTxDwoLSVJOxE+jG9jcC7ttnXRsmqbV60ya+c/PTRXWKQ4V4Z8CqCtY667eYpsr63ZO7oi/dNOrdeHO2UiEn8c5ZMXwH8yQXb474ulZOYc0avwrKihxJx5qdC/RJ6iabNR2MHZbNM5dCnknSsDqqs2/cAgQEUky7ZpIbjZJ8q79ZdUg2oD+dBSAb9NDPQieJe3CMb/Dnuv1YUUODJTF77l8DONH1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623014; c=relaxed/relaxed;
	bh=ynKYarepbWl9Bt2lXEeL1/lRyqq80+H1joWy3Adf4T8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/gaGBTsEPkYJHt5PEFepkc6eTngnQX2rAzxJRefxTt2i+NWMGXiklIV5fXxrbFpWnfifF6rKzW+k2YTke9Fh7RuKZqaD1NvHSyFEFhQCglT01gmOIkXiWKNCA95jXLdnShTTpt8PWMyB+x4Uo5j1n5vr657hCLg4X+s0SZMTmho7a8rfiSc0l6Iaj0maEHQ27bhVy+CSKy01Vz2xWTUr3v2ZVLGLHWS/PrrLIfGjRtod5wMoOylKeMmso5pa4OO4wF5DAdDeyTuxJ4582ZBJ38KPwTOuerNvBq4znf5bz2PDX7XoTKap+3aOi94A3GdUoqlm9dvLD2ygOsB1bBM5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VjBh6tPr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VjBh6tPr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkq92bcgz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:13 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id d9443c01a7336-2dd88a115c1so4476485ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623011; x=1790227811; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynKYarepbWl9Bt2lXEeL1/lRyqq80+H1joWy3Adf4T8=;
        b=VjBh6tPrQyCXroru0ZcbL/J81nlnNdblB2ZBmZX6aAWDIXEXc0kguX5ztXfK1KHHDI
         cWKmaUi1ARtP3CPv/xYcpH4FMI0ep544PfM6P/QyzTX3aHQsPNDCKoHUDjqeQ2Dps+V8
         IbZSYJW9msbyCgMZPM9+mjcr1SgbsG1HYFKD9+ZaExGwI/ZiAw61rlDEP/MGryda9XtT
         wnJ6mLvtiX0FuuouJ4bK1/nxP5MhgovLY6LU8mGAYHpuG5IMlum+pGjed/VO2ZiTTEZd
         IOmckTea9d+d6ZEciHsNsAYu1nqZdozLu0u7UG0NZx8N16KbAoN9prOC2kf5dB2kLV9y
         AvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623011; x=1790227811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynKYarepbWl9Bt2lXEeL1/lRyqq80+H1joWy3Adf4T8=;
        b=RDE76Rd+6iY/Bjag7L7fq5yWJcAHiDOJSG5zbj6W4BHyREMTMZ3w7milUC/+U3Y6Tn
         QuS+JLThOOIUySzkW+pAiuX6RI7lJsGHHIpigPC1hBNc6OCb0W0rM16HCNuhapvcApir
         Gil9lLzpoBXHJz06XiEm7smWZkafsk/Yh9ZZwPxecPsL4gEMDPcICWJ0pBjHs88Y0b9c
         bcajNDhHz4+KIAz3FQSDu8Ns+K60Gv2LUvtcsKQ612+4roQpHdN36VV13Z7YvrIK9dvf
         g/JLq/Q8zFQmL3yxRxYE71y43+oB0N5JVS1DbH55Hsb7VPsYmGeQ8LDPpsuG4zNgLfGQ
         gsvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzatxFv+5McNwLiuX9rZjyvyMfXoa4zn2pC8/FJcfFmUBNU0jN6837szjEUQ/keE2AoL/UBW4o6OofLbGU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lrzkgOkXBqCeCk6QvGB6mjt0S2Vxdypb52w75kTs+WyZQeocID
	syz0M5Yld37DSTuAFhMYCmRdlE1YjdFz7yFFgGJ6PPDeXTHYlefXIK2H
X-Gm-Gg: AYBFou1cUQre7BPX+Qf0D9zu4I/NoALj0Na+ERfI+poIaubfWUXfA6O1gUfalVI4zFz
	I2B+47mcMV4l7aEUi5HpCWVQGeeWLGk292Y/mk9uaDj0Zgmo0elHknmqjlGn6+0PJGzpJBcdKNg
	NFcSkYbRJ1ctFGsOghka8k8rgcjPMLJQ5ZQihQh/95QBQvlI4OusLbw4ZgPloqSF3NcYTM5ZQ99
	7PFhIIQyQrj7vR0az4XGgg5FbofCzWWgqApRny7yQyuXPTLDZ0JzhZaIa7gqJXZM2MbDvAqrOTA
	tA+BCL/+O/e+9s0Ls1xRUMRGyC2LkTzgm+0mExc294lXjFMBMmP9fPwxpxNQvOoNvxXBCXDemov
	ap2cMVeWiIR6LT6qjXRuzPeHlhUcANXBxJUyNVdi4mfybl6bRls6m6LYmU5tRczdqTkqd3ISnKa
	G6TbzwT9waF0fi0LAon2n6bLWdFVJaEx4oEnxS2Rne/EXDKNU7qBSmRwKdE4rQ1A0Vm/7uS/hg2
	gsalob5Sw0QgjNZx+Z9dO+Xy4M=
X-Received: by 2002:a17:90b:2803:b0:39d:ef3e:9035 with SMTP id 98e67ed59e1d1-39e1e324463mr17718864a91.10.1789623011402;
        Wed, 16 Sep 2026 22:30:11 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:10 -0700 (PDT)
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
	ryan.roberts@arm.com
Subject: [PATCH v8 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
Date: Thu, 17 Sep 2026 13:29:27 +0800
Message-Id: <20260917052933.188679-5-jiangwenxiaomi@gmail.com>
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

clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).

Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
longer a caller of set_huge_pte_at() on arm64. The only remaining
callers passing &init_mm are in arch/powerpc, which uses its own
implementation. Remove the dead branch.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
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


