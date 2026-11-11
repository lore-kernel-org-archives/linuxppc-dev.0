Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15160A2605
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCU/liu6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPT5T4Zmtz2xlj;
	Wed, 11 Nov 2026 14:09:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794366573;
	cv=none; b=i49Wq1bzsCx7+FBvyY6nlgt1HtnoTtpg3FBouKzxQXtnqwGVQJJOM9tCUrQkSCoSINeLoAsL6ky7M6NwlKkrD1xbq3FGfCv1zXsxM1pEYqAspO3IziBuohFmIZzcKb4zAlpNqOLT+VqptCaEKTke9E+7XHaSMb9t5p/dPFGrdlTLXei08BqHFDahsuBiCq3Qq4r3hz/aPFoR/VImG0W129riYA7oEhlhQ2iMMR1j8vgWdN7AduDY838IYnggX/VrNKa+R9hmkHa5BCJzGMbvwd/Go0UBNzcY4ND2m/5JDGMumLf7M6ob/R+B2JvTU8F+9rgg9B6uZnsCAY8IoYs7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794366573; c=relaxed/relaxed;
	bh=Km95marAPwW2pP8wgGsfAj1lfQ/5UdjiVvHJl74YYFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0iQTg2d4a1o7FdlUuwUl4NZTxEbPRbclFZxa/2NyZaRk5F1aFQHEZW3hOalbxyFaNfveWdBJr74dmQ/FyzyyLXbgUUfwYQ9jmf44SnQfNCRxXO+ywsT728mttQNOvGTKIh352abZfXuM/9odZGI0s9g7gtsIQfPscyhMU58UcEhfu3K9AAoBPKWjL5ULduA0cT+ohGbrlXYc407EX9gKIEQm+MKyRFsv6X4m3XBSOmKcumxmyYENMz80RDN5eEkkn8ksCiXhrsL/cUaAarOeAfS3cPATlHLgAcogwCUqihKGXwotzAaGSV0vnc+osWq2fq1Av26zwtCOXHB4cyTtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCU/liu6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCU/liu6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPT5S6Mj3z2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:09:32 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso4202034eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366570; x=1794971370; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Km95marAPwW2pP8wgGsfAj1lfQ/5UdjiVvHJl74YYFY=;
        b=YCU/liu6G9w04vX34NnM71fNAp9LuH0R+jIpbfKe+jreuRiBjw3aq5Vieq4PmU5sKm
         pn+DAneGjIiKpqOWPSR7tM7NWj813ZcaIoURnSAskumHLxiVISyLGY3cYKZx7kBiTkP7
         69ZkOpEDVNc6cYc18cIiL7RkLDB2wtP3Y4Ewtpr1vYvMUqBCuv5rKNQwtTCJmsq0T3IN
         qFYz0787EJFD0w2I9adKpPI1wLoAEd4KTXqMNGa/z5bQAUv2Iq9iuaHVbGGXEshwaA+t
         gyeZ8cUZYfdzs/ttdtPpewDcuIbfF4EWfFUo8T7hUxfILLdnJSP/DcSmAGM2xaXXnY1v
         ITew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366570; x=1794971370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Km95marAPwW2pP8wgGsfAj1lfQ/5UdjiVvHJl74YYFY=;
        b=1lJJYYXqRXz5XL74WfdmV3cXq1HMSVC/RlhNTV4y9fjrYlKN4WsVLPLa41aOqpMt4N
         T0eqmaYJrIgZjvKrrAV2YUql7n7a5c6k0+FRfP1N/W6rBgJX/RGpuDX9B1+1AgtrJm8a
         AFmIcWugrraVa4C6lYRc2jr5FTpCey/wy5WQ1BBx5ooe6XGyxbbnqxF/ezBfWJXBjLi6
         3dqx66M3w4WWy49gUXAQCuU8r46vVcFjd2PTR6GTcDEvSkJ2a24NNojG73pD7faC6/qg
         3Xz+IH1QWHFXMclBoQxJ3fZqKPnc4vEDe6gjRrRSqylPw7f0o2ayVrjS/BYHRy1vu6oP
         Ax5A==
X-Forwarded-Encrypted: i=1; AL+hErG1IouVHOPPsra5zIDBvTEsAKW42w/q13YjABiJW17O+NwRaFN8qi+R+zpIWGMip65VSSBC0wZyF29DrLc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+43iLIPsj80sbllmQiW5ZWGnnxoNUSt8kcW0lIN1fdxtj+tVkp
	fw9IiTJP7Q9BpPfjgoAqe784knR7qiYsIQuFC0oDnQ9MrJTm93HHwvtv
X-Gm-Gg: AYBFou0p2WpoKR9kJYN2Tsp4N6/k91Bi9hFE24d84dhlX0fIQH1cRemGrKnQ9qBKey/
	NTQgBLvQ3GRCfjVnvhhSXnG3YkoHr7RQbr/FGhWxIvaa+eM58Mn5LigESVwoy3iJpOuEBio7RyZ
	06JkDfAzOnahPRRqlBpwr7XmqGllESX4MasoUlC/Vk92QipI39W4n9+SU3Rf5iYJfLWLG+vbj6y
	A19jOROXq7el6eluqQqA/7fjBofr2X/0C95z+p1cCdrcY5Z8wPU9OBbFMzalME6bFTGUe9agUqU
	DUcvQ3pj2hYvEgIqzIqK5H4xU/5LrlaJRd4EQ/d2yvxI1WY60ojnCEPApCXGZBNoU2YiHMNb2aG
	Z5MNmUAz+9rmuB9ktacmRGUrIzE1oAJSughaKwP8i9jn5V1aU5t66o1AimKKPrzkiIcHqAG2rWV
	4bHMW8dnSpi9RmwpDjBvtGZpzMG0udC26E8TeYh8d3lkVUY+OD4F8BeuJtOxMD5Yx92oxxYKIl2
	hKRfXfPdfPg+Sa8RGDiBCeAVTmFqdT/Z5/rZhH3zxwIKQK4L8XzaeSFJ6bKGO5zIi5GWK96k047
	8zWKMqXr8M9Ibkh7HrPjh5yX1VM+peU5zFa+sAXa8npvAhTsHvl86/VvOQ==
X-Received: by 2002:a05:7022:7e8c:b0:1b2:43cc:48 with SMTP id a92af1059eb24-1b3c03387cfmr1271942c88.33.1794366570168;
        Tue, 10 Nov 2026 19:09:30 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm9623484c88.13.2026.11.10.19.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:09:29 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org,
	baohua@kernel.org,
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
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/10] mm/vmalloc: extend page table walk to support larger page_shift sizes and eliminate page table rewalk
Date: Wed, 11 Nov 2026 11:09:20 +0800
Message-Id: <20261111030920.1297625-1-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-8-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-8-jiangwenxiaomi@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

Could you please fold this into this patch to use an unsigned long
page index in the walker?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6a150b11261a3..48240fb674b9d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -557,8 +557,8 @@ void vunmap_range(unsigned long addr, unsigned long end)
 }
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask, unsigned int shift)
+		unsigned long end, pgprot_t prot, struct page **pages,
+		unsigned long *nr, pgtbl_mod_mask *mask, unsigned int shift)
 {
 	const unsigned long chunk_pages = 1UL << (shift - PAGE_SHIFT);
 	unsigned long pfn, size, chunk_end;
@@ -608,8 +608,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 }
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask, unsigned int shift)
+		unsigned long end, pgprot_t prot, struct page **pages,
+		unsigned long *nr, pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -646,8 +646,8 @@ static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 }
 
 static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask, unsigned int shift)
+		unsigned long end, pgprot_t prot, struct page **pages,
+		unsigned long *nr, pgtbl_mod_mask *mask, unsigned int shift)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -666,8 +666,8 @@ static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 }
 
 static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask, unsigned int shift)
+		unsigned long end, pgprot_t prot, struct page **pages,
+		unsigned long *nr, pgtbl_mod_mask *mask, unsigned int shift)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -696,7 +696,7 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
 	pgd_t *pgd;
 	unsigned long next;
 	int err = 0;
-	int nr = 0;
+	unsigned long nr = 0;
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);

Thanks,
Wen

