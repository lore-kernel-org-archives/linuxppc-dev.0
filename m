Return-Path: <linuxppc-dev+bounces-27970-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF848C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrR37lPz2yqL;
	Wed, 23 Sep 2026 16:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144951;
	cv=none; b=HrNbdlENQ+LSyOg4QoysITY+BdxLqIpKkD/se4K01rSrPBsxf8LS6FkeOPpkKH1N+HXZhP8iaA6Yx4NkECfCS41kinio8PoxajCgqyHjIdIyA0nFZhG/agIL9uU5mXqXmPkSOVbkXFaxYWSvbQHJdTIIiKsGP45KegIdMYorxwzsDQuybSyEH1pjlgGwvqNi1wm4Edc7+TYFHc71p2gKsjYVRbqlzNIw0zJU6jwKbuxOEsSDhaoXYN44OMqRQqlhMwO51eDK3IPexzjIayec6sj/ShD1EuytXtRFrnr4LiH5NVi5nZ6kHuMnGGGX3qrDZfxnNFrc5VaTRSGlDU0AhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144951; c=relaxed/relaxed;
	bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGWM7+QHYREZ26bIkPUd5bxaj7S4tyixRzkKzGgGh8qXOWqEpAJx+RqJhQH9E1mDSsHenozy8vSVaN7deG3sjDwYKF/F9QK71PAMdl0Qcesc9nRye+mi2gHGJyKrPDo2vdB19A+JwcuOxp1A93dsm/1RxB5qsGgmulpfEfGnNWtl3Ij3APtI1qKTOoDsYCq1z2yv3DorzL4yALo2VgoibhFC5ZdsRZFSqwQH3uy80pFDgrF22EkzWPdY99HvTQL1KW4wquKLyQVZovBwLB/1zG9FU8ha4iri/jmAp6wyQ8b4qN5jZEB447K7kz1YxDcVPK0bg/gnK4dhvTlQCZzc5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6ZYEsiA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6ZYEsiA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrQ45BBz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:10 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id d9443c01a7336-2d747ee1f9bso2842235ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144948; x=1790749748; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
        b=E6ZYEsiAvSE0pHrTBhzVfrB5wUfHISR2cfAEmxaBfyUZl/w6++62L4qttjstllyfnB
         dbo0HW0dDyb4mwkabPwlE1PwUCuCTcqL/SilFA6lcmWtNP2sfCBQNb6qe3VP7oZwhnaQ
         Fd5ZHsUPaj7eyefACLa4azPrMdSUbIu86tboBCjSoaX7gTibPHJTpkwgHL993XSBMx1C
         a65HdioMMGwju52K9Hyo9I9u5jKckU7dFIo/wrlEgIBu/srnF/hz1qa465km9a+dE8ki
         7Pncv77gye8eCQG3g9uykzbX+5T9mY6+FDEcvaTZcv5miwI0NQb0Aaddv2Pldu89mie5
         eM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144948; x=1790749748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRHIBzX1Ph+VWLlGic49OjVgc6epG84F5iB9tVuXpJQ=;
        b=OgRkzTK3j5va4SVF/ojBIwuwleC/UcWCJYQcwCMTmUkMMfwe9wUut7ZeJqX3WiCqO6
         XT3cAhKGTaaVOJ/+74NTbd2Ji4LJAuhZmV1usXrqv7PwHDvfxqpFRk2Gwf6eIMu8VLcn
         WaKQp8Uh5POA2KdOILQInr9CSM4htCGmC//NwLeeSC1jF492U2LwVoc6AUDcDqmYNT5M
         i8ujjrwRRtZcOrZkSZvWg6zFi+dO/CT9ni/mWxG52Ni089p/vhu2WDWi1K8XhRsXH1n2
         GEwp8p/RFxB89XFGEFwp/4N9f7UR2xeVb7HbVVmzRNBrOeOLhwy5mxFD3667IVpYvUOd
         UzZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuMsVNxjoASQx90V4Bq0pPjamcVKl8KWELZ+zTSk33iOSlOcxPtMvJL+uYoV5/eS9cjqnIj6qsHH5gkhE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lRAd5k2jdSYV9yLd43YMOl4mCx7pi919i3xrh3fkAzC9jC/oxx
	401K4aEqEDDYU0iASEjNsTQZ5kcMiTu84RHLA30so6DfbKfTYtWNGeMkZ0ylsb+n
X-Gm-Gg: AYBFou3lPdDMBpytxbk9BvIEighC3aZ4GE4n2nP1y0Yfdg8r524Vc7qfLfzOatdNYwo
	55EugZ3ClK6YmQJwKrI7LWl2F81QYZSmuKWblRugp3oc7Mpz84M+zgv6pP7fgqyTwBZ64IfQAAa
	SMiK8hPCXvtIe+0i0y3+bwXHYpEFF7p8ddZZlilU+aSuxfjSOMOxkmfJdvngUf/sOW0UbonYzUz
	AkMkQ5/67NMVNrPRSUvg9JLX+w80ljJ8OXpUWIFGN4EIjveptoXzmkggyAG+XvIkU7IFlIttJIl
	O6CdLXMbnNaCJsCi6lDAnJaulAMO4oD+oDpGCUbBvQizu2hSUIvVnud8B1BNzIWJviKtrnWtjnz
	PraFKJ8UbYJ4K686wdQm+PJUZnuhVhbIUdWkfu+DgZPbI4BeFaxqCXZb2vmCjWdPTEpclcLz/kd
	tapqXnFJEFC/9a189uK7Tw8xNUO0+sJJ6JwJZINldW+xzw8UvSf80IGM4IGogFK56zAcXKbMT08
	6lOz9i3kDyOXHGys4YocQ==
X-Received: by 2002:a17:902:ce0e:b0:2dd:ad73:5b6c with SMTP id d9443c01a7336-2df69d56537mr15363405ad.28.1790144948204;
        Tue, 22 Sep 2026 23:29:08 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:07 -0700 (PDT)
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
Subject: [PATCH v9 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Date: Wed, 23 Sep 2026 14:28:27 +0800
Message-Id: <20260923062832.479455-6-jiangwen6@xiaomi.com>
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


