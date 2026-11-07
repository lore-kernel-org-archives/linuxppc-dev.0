Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB14606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=by7exXNG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHW06jKwz2y71;
	Sun, 08 Nov 2026 00:50:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059436;
	cv=none; b=VQ/gmk4gwMxD5j14dA2yjc0N62I+zhl0T6V9iNs33ZoiQ+iHGDoMUDYe2PfswsoUKn4KjHX7WYQaR9SHmNsA1H6Svwpbk5ER9WBmaEA5mOvKx9JuUmAKpRQ0kfLK71HEPz1K/cxypkm3bl9H14bZztQ6EFkopgLJkosrU43edqnXPhvGt3QBO3APCCMdvGyhPUKfpr1lL+tNffPYsrPwncY+rqylvaMqR4kBSRRZG9/xOnJhJSqtnOJVhGph9AneJvYNA/6VXtuJsOG41465Psf2PEBhU1fwsisKh3ADwpk02G5SSWG4B13vIafskb+AbXRdxMIZQdzbOGEMMLO76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059436; c=relaxed/relaxed;
	bh=LValEK7sCbZl9kgj7RilnfIodlMc9vaM8NFPGguTOMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvlYrQ0QKid++BPwjP70zjUjxkJbvTqPNu1KZdmA+O7b9v/EIqSBxviCCB4RuR+Vmw7C2Yd4OmzclKdsU9xJK3SVkMo1ksr2TWXibn9xPcl/ZDCoz9XLRF5IjoB0H7teYTVE1FjZ5Q1uHonhYtzG+8qboJL+t/5JmlNXXxX0sPMnpJCQOKZVBK787LN6x0uteom15xedCNM+GfnHcHrgtJCwXFUJS1GZkicyoDMf/HXxNXMDi3A9DU3HbhDJA/5cgc4/UxXP4vh4VGrqIQ8H3lMSD65o3dfl77Iiv84wGDw4lex0bVpkas71NEBP58GLlN8n/PDcKZbHjzqfk9Repw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=by7exXNG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=by7exXNG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHW02ZS4z2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:36 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2441856eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059434; x=1794664234; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LValEK7sCbZl9kgj7RilnfIodlMc9vaM8NFPGguTOMw=;
        b=by7exXNGB6wOPCi/ysjQaC1DJxrSCDNOi8qSwWUBR0oYGQrHotvMoNeNBz03rvv3OB
         6J5gGIpZobqHEfPmbAfVv3RNEHriE1WPEvK2FpSCR+BEIKTJWEoGmQJ1CGcbqdU8MYUx
         8cyK+Hq7cYz0OQ4NyRH2GpqE0qGO6ZVp+1ktudMoWa++eFZqAqh9rg2T6YcwQTuLSK+Z
         XCprG4njNPv/muTGvq0XQmOJXP6j0e2Vgeqn1uG6cBeF4kdC3qxf+lYKag6/2kQW5DNf
         Dpa70e9nYXKSfWNzflVJr8jEMQbj0U/poO9t6qquClg1X/cOi4ithmc7QPPbFH1Qyoc1
         2Oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059434; x=1794664234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LValEK7sCbZl9kgj7RilnfIodlMc9vaM8NFPGguTOMw=;
        b=CWpp0TxZ2g4nMILujbPooWRMNgmaqZE42pEGkuoOQFwVbVCH4q1Y1mg9YkJLU/l0pc
         jvB2cyoSS8fwZjgLYGaMV4zxqkt7TM7RmF9oLntWCrWxkjOMELw3Hc59/BV7Kup/Wto7
         jSaZClfzW2zKnHHV0fWU+M3REGg3okn36V5LRAVokU28wK6S5fhXkBXPFmcfHHPb2aDF
         muqJPwEBSpI9wWE9q+nuMY2kRn7RrKu3nQ5a1vU3XafaAE2kPzdy/d+SQiGPlwdeNLWc
         6CSRJrvX6O15KMjml0YnwDGVJRWTvFDrqU9Nq/AfGi7grLO2weJHYc2857U+GWhNP9HL
         gGIg==
X-Forwarded-Encrypted: i=1; AL+hErEUrqx4U6gqZoB+9TEQhzlNZ4JwoVj3t4ccUyljZjnnzbZK0TEyXZag3QrN6r3D+P3zI0+4PwDvAlGel+U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+8UcU3k/1vvbELmDA9ciIftBTao7anMcK5/drP6JPthyPRgrua
	NqZcHPQvxX+JFpzWbHo2sWd1K5dbEklbJ+BxcDaGNJpt7XlcESnRYRzd
X-Gm-Gg: AYBFou3uO+APQcl3ZT/7g10r42fjPLHGA17G4+eGhac8BQaHQ01cjw/V86ooht+Nilx
	jQrHqfBN3y8L7idUzDzG78geMwMQtnhyUIKNM4xnEcgEktEGoU9SqIcuiHSdr5y5ThVr9tA4/bh
	tKW75f4/Kc4L2KIIdi9p0xmAtPAZ+w4fbMTZAKFQXoOUnYh+0NGaRB5fYNNdx+GIwQSObGsGZzL
	J8Oyld2n7sS2v4qRRMbmoJ4+HlhVxULKMdconWFFsclFG3phns6eSz9KbOG/RhEBRtyzDLor9r2
	nxEUCHjN1nKbYmOUx0aAbe5JRybY0QQ3WsVz+uHy+St5txKUGOCWDCXWSDTXURZPcBUVoUuC5AT
	C/Lo1a4665H+fwOeHOLaXcpR3e5Wxzuz4nxutKaRFxzaGIuyexhVmez2JUsdGsROCHf1QZ9e+1K
	ioP8pw2Ryp7LOKEbb2r51JiOt0QYYByZAzc1F/HFIrliFPdrUT7louAWpnosCKHkNo3APrKUPIy
	o0F6PmvBhRPiLKMyj81en8aMdeBk96rDItCIHnisQkaMuhsHLv0gyC/QEaEmLFxPvsKhGXH++cq
	QXuAPCtBvXIJxK09mKUE0c4z6FVIya3AiTHmVMTTob0nkRceGmAwUO1CRQ==
X-Received: by 2002:a05:693c:66cc:20b0:36a:1452:8dad with SMTP id 5a478bee46e88-36f7612b26dmr7574830eec.20.1794059434348;
        Sat, 07 Nov 2026 05:50:34 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:33 -0800 (PST)
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
Subject: [PATCH v12 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Date: Sat,  7 Nov 2026 21:49:48 +0800
Message-Id: <20261107134953.748622-6-jiangwenxiaomi@gmail.com>
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

Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
blocks, reducing both PTE setup and TLB flush iterations.

Previously the function returned a single CONT_PTE_SIZE for an aligned
range, so the caller mapped one CONT_PTE block per iteration. Now, for a
CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
that fits within both the remaining range and the caller's max_page_shift,
so a single vmap_pte_set_huge() call installs several CONT_PTE blocks at
once.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 4ec1acd3c1b34..c29704a19e276 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -23,10 +23,12 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 						unsigned long end, u64 pfn,
 						unsigned int max_page_shift)
 {
+	unsigned long size;
+
 	/*
-	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
-	 * aligned in both virtual and physical space, then we can pte-map the
-	 * block using the PTE_CONT bit for more efficient use of the TLB.
+	 * If the range is at least CONT_PTE_SIZE and naturally aligned in both
+	 * virtual and physical space, return the largest CONT_PTE-aligned size
+	 * that fits, for more efficient use of the TLB.
 	 */
 	if (max_page_shift < CONT_PTE_SHIFT)
 		return PAGE_SIZE;
@@ -40,7 +42,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
 		return PAGE_SIZE;
 
-	return CONT_PTE_SIZE;
+	size = min(end - addr, 1UL << max_page_shift);
+	size = round_down(size, CONT_PTE_SIZE);
+	return size;
 }
 
 #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
-- 
2.34.1


