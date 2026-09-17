Return-Path: <linuxppc-dev+bounces-27546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48AEC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4958B5z30M6;
	Thu, 17 Sep 2026 15:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623021;
	cv=none; b=nLyWjfqeKvyVB6D94LaudTaID463ClSKjNnWZFQRRPsL0awQbdp4++Tho/3wwsz6TVTcPwhMaMbF0Eal6Tk6wk9qKtsgX+AnxSkRzY/76UO93yrucQz8cFuDkMf5CuznDmbMuVWpk/66tV2RmnWhwDq0FyIg/xfRsBS9m6jIHDYKX1+7kWrc2qR29SNnjHHWPs/a7nZ2rxwGHmn+tZHz+WfcDhd89N1iCqaPK0yPRBgMtPKyIMb5xg2LgNAmjRnfkwVBMl7ERngcsy64NUBU+1qKQY4ObX8iguiNNfzBlUouuE8nCvzk4Wx732uu/VLh/PMhDxi7D6CTwRP8HmUIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623021; c=relaxed/relaxed;
	bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRWoA2oLigSfIyk1rknRizFxRdnRXywKIp/D91n0cGzvX15wuYuGfRTA5b+Pn+HPEyaJYa/uyq7yh8RnoBto+i7bYSt5G2NMVAckeXDqq5ogONkbdY/dSzqty522iAN2LK4xozofLS/QjLSGzCLks0iETBw03YNJdBmAecA8oys4XnUAIdoDlNvoVtfP5wjzfmqPCgEUP2osuPcoNRymzLgRJ9hoq5iliKLu622fQjdzhH/8NjnkzL+KEdbI+rbp8Yg8+/4PBObc6fUxITv6Lgh+Q1ZEibAr4+8g0icklz0en8AA42jKluCs/A1lKjV386vMOjXZ4tXvy88bskaHEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UOGLaxEz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UOGLaxEz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqJ72nbz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:20 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-39b350c6920so379072a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623019; x=1790227819; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
        b=UOGLaxEzVpjHLB7U3kn5wPX+6cEyZH3tOdkBm4WYi4yaETXrAWkU97frMcQAr+jbeW
         StUrOCCI4TDzlHFCoXnExRo29KFouexuw0B5eVFMTXtu5tw1cy0R8y4GjOuZkVu/feKy
         gG7wHbyms4J9yVATbdhmH81TbfdQaTG5nCYwdbi/gWfzBbEa6F//E6/toE81Uuc1kEdi
         Ri1E+MJunAyFcBKRa4z1ZhUEIcX0hFKvHU1r7J8hZOKwBk0mwdhIbX2bGTa/Ghmd0h5j
         OeAlZ+iHn1hbevBYq/wD39QB76e3+W3FqvcsS8pKvKHqauAx2MmZhl1rD7tdHorEuVUy
         pbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623019; x=1790227819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
        b=hzKSUV02U3Gba9i7Smd1ryWsGngdXkSWkFz/UaZG84PnkjTaZ31nbFetP9yUD7haVe
         Frk37asZ9aW9BoO2OGtEpHYYennJoxzYHRKWfY8dakI8hXSY4ZhmLd2bGfXqIQOj0wRq
         JRMiRGz+7uhD5qcLjlr9WexHar/zlypx57PZyfzenizN1zpuqdjtcpF4t0UQlHzUreHo
         jDEFsg/bWkRGnlgjpl56sOeF9YVKsSYVgFMFGF5b/GQoVl46NuPLJZ1F5myZGOFUR6rO
         5AYUQAhQigR6FtIIvX/Mulf810tdIy4JUWuDGyGZIjB8+0fQEcmoYrDQhcr/+VQFOjoc
         VJ2A==
X-Forwarded-Encrypted: i=1; AKwUvBzvbGhGUepkVFv3s41mp2F/vMYg70+YqMl9VyGBFWsYeUBOP6lYk9uywsEXk/c9TEwkkBqsYi91Wki+sRk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ntLP36bE/AG+dAR2A4xT9Bo2dSCkYqcArvIj3Q8Wfn4x27nQtK
	Bhh6km6ibJ6XHEhaON8wMmEaPrWh96gHf53mxywTBSsZgG/lZ85VFE3E
X-Gm-Gg: AYBFou0ILBjKZlHwg7JRzSDWrRx1kLfJ0zT3vTYINBMmT3nxA3kFbHC2gLMIm593LWI
	AhZofZthjrcjhanilbogqyNTql4wHaLUK17V5gnW3TnwaaXyyvx/8KTCANi2RUe6/ZhXGHsYCFt
	ZyLFZVVeA0yWiko+ZYMHxNtZOwk28Q35OvhimQO9KQahIKOETV0mH+Vb5wfGr7or5b/1S8IcX3x
	Qg+pOOeVZukwYXLe78O+nG9c0grc5XxQeGR7LgbzdXFMXDGSckM+BI30Zb8SGrl04oxl6uVJsdl
	FTKeNdZeUiIxU/0Uhgje6q6MDQAFIrakuafyymHsJCJCmxhqBrCl4p3luuRU1p7zf4z5MM7uWr/
	SYl+dbzAcbbx8yk5f8Ab18K0pdK5KlZK7h7XTYE3emTxgK7gHSh+H75JazNLgl8PJIX/jHvsaD6
	/l36Du9qUOCRj/UcThNGx6mV9ysEH7LQJl3YxlVIeFbntQFFZWXtkJ9wfPXlN7WmWgh9+JXiBJ5
	3uEXcVZ2hnyv43pHfiqorpY04saHpJ+C3XPkg==
X-Received: by 2002:a17:90a:d644:b0:39e:288:80c9 with SMTP id 98e67ed59e1d1-39e1e4d3fd1mr12367022a91.19.1789623018896;
        Wed, 16 Sep 2026 22:30:18 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:18 -0700 (PDT)
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
Subject: [PATCH v8 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Date: Thu, 17 Sep 2026 13:29:28 +0800
Message-Id: <20260917052933.188679-6-jiangwenxiaomi@gmail.com>
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

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
blocks, reducing both PTE setup and TLB flush iterations.

For CONT_PTE_SIZE-aligned ranges, return a mapping size that may cover
multiple CONT_PTE blocks, capped below PMD_SIZE. These sizes are vmalloc
mapping spans, not HugeTLB hstate sizes.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 4ec1acd3c1b34..4053b1ec1902e 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -23,10 +23,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 						unsigned long end, u64 pfn,
 						unsigned int max_page_shift)
 {
+	unsigned long size;
+
 	/*
 	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
 	 * aligned in both virtual and physical space, then we can pte-map the
 	 * block using the PTE_CONT bit for more efficient use of the TLB.
+	 * The returned mapping size may cover multiple CONT_PTE_SIZE blocks,
+	 * capped below PMD_SIZE.
 	 */
 	if (max_page_shift < CONT_PTE_SHIFT)
 		return PAGE_SIZE;
@@ -40,7 +44,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
 		return PAGE_SIZE;
 
-	return CONT_PTE_SIZE;
+	size = min3(end - addr, 1UL << max_page_shift, PMD_SIZE >> 1);
+	size = round_down(size, CONT_PTE_SIZE);
+	return size;
 }
 
 #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
-- 
2.34.1


