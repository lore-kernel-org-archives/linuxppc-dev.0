Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7F606B138
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qETCMMq8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkzh6qczz2xwZ;
	Tue, 03 Nov 2026 21:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701088;
	cv=none; b=QiAAOWn1v+RgQCEmZ8pERZrrUN/4uNd0Th1CAr4u0VC0U2cKvH4VomUeCIkyBcvABt79KC0jlhs0fd1jAbiAtYpUuqQ1EA0w7r1dFRLtMzg6vT7P82HTwGmWZ0qJZMed/GFL+gFlKMuAAh2VZF/fXOxL+AoU2muaYKJ9RyjcfUyG0P6o/5SNI5dz8KXoDXcx152IT1aoG1eKSeQiTnPcUCrEWAy1T96lmYbTE9HSkuj+HaxZUm711KsrhNqXDfsFGbQ3EiFopvtyZkAlPZvWEIEwNuJU4Sq8fxh0RqsIqRsPTFc5Z6c142Wv6vssTbX/AKeMukPUS2rWImM41mKpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701088; c=relaxed/relaxed;
	bh=H9wZERoTK73TzMKQ9KwUyuGxqQabGqZnw2K4sCikbaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS11zTuFxxKh9qlg9I5V4ZKxBFhpAzrOxwZ8CPwOVGscrYdwiWQ+rpBAK9nUgiCThqbkwMMqs/XJcOjSR+y7caFzp/uxlxYd3/SASEUBSFU+NVCa/YXRqyc8rIb5XjlKj5jel2wQ9ED3Zr1A5UfVUDAUdeiu4hQWDYsQjuycFtYJPb4Wov9F4Bm/M1Eec0El2luygJPe0Iz83TOZq3F2YP20nVx0ff1nFoim9mON/htaL7/JVQwPDMJEwjHpWFT6Xo9R8bqE303OOGspSpRop6+HB7WJwwf1YYogenccq8F64zdnk5+B3+edWvb9o+yH6JZcqSdVWQJeXg58guZz4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qETCMMq8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qETCMMq8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkzh1tFcz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:18:08 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-35c76e9614aso5491385eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701086; x=1794305886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9wZERoTK73TzMKQ9KwUyuGxqQabGqZnw2K4sCikbaQ=;
        b=qETCMMq8H6r2riYIdZ+Aympp5jWv4KdrUC9aW6b55Bsx80oE/NnYZkRLCInxBKjfVH
         sJd+3lAy3eNpQYSnVIJnYAFTCVdd48YaWL8E5MwcE28md9v5XASUKHtgqscc4WCxAUli
         FX2QycW4z7riDcC7YupL7VgrXHtomF66QbvO5RlDItLWz7LIJzE5i8OSwQ1mf7Db+jTA
         JMpA66MiFngYSsEA8WySTCli31qjWhPnedIix2cBOipZdAp+Om9mOgLGzNWFVNV07Sj3
         aBSGaOgbzbEnjfyZfXEzVddE/mtogIFwhWluViJoAJR1zFgyUuv7lvZ6RTipUezDPMHE
         5Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701086; x=1794305886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9wZERoTK73TzMKQ9KwUyuGxqQabGqZnw2K4sCikbaQ=;
        b=UDbYGlAgzCUnoR22FacU74kfoQdSuE1OBaxM6qIUdLHUhJtI8sfztlIei34SMllKDE
         +v3Ti0Ax8WtzBfjNhSI3bgobr8fmwTd2CNfYOEW0oOm4gzDKXR2LP9QWxmm5aD2E0cFD
         L2UyTrHRYn/xOdwpwne+y5O3S/wYoUBC04pfoW0ddiAatjnnMaRggD6q1k0h0EweZ0/L
         2MN9CGMMEiY9tQVC7qhCEn2+rT9wssx6uHozrx3TtcK7lueXizyrGEwD7NT59wSYxDNM
         phRTmXK2QxM/aHplfGH5tYZoRmI8ImAS5npe/VRGTbjKxNPcy1FTsvgCn9zXaws5LChS
         hS/g==
X-Forwarded-Encrypted: i=1; AKwUvBzLaVZYjE9h877JVpuGJ88AsQIkoninOdploXTvsO63KJlRgrKkz5wthHIN8Bku57yn8SLNo95H9HGNrT0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Ap6fz3jTCpI/zUnzYza32+XldR8y9JlDZshjR7/WNRB4b7bHG
	c5iwNMRJpb4DXY7nMaeHbBQhivmdRDHaDNycPczUpqR6/7PKSNCyCkwL
X-Gm-Gg: AYBFou0viy2CJlGTEwMkmVSYtd9TpPXPK3mZoYELoKses1xAZB1/Y8czr/6PxJoqBSf
	u/Y6BNnBYVqq2nLTV6V5N/GIoaOlZYcGd384FVJy+3I5/cdwiwgKa6tQ1703XHq3OXFkRX3lz3L
	307GhQw63IIKj3frbp7DgeGUQw1XJXSAe8gq3WI8Gyae83Flx9menq0LH2vv17y+iKjeMXvb49o
	5lHRUKk2VWgPSyLiG/v09INXOD2iQXpoJZu1I6yYlqYEFTOYzoXTEYcfbBLtECQvpkVrhWqH6H4
	yCNVOSmwniHsCRtrVAJy+6wePP3q4ilHEpQBEuaeskjN5q0NbjW30nphA9RAUIdVPoKvZc6Ur7Y
	zTARk5uiIEGldHJRPgX3B91fvXCySFdCS86v1k1KYQA5vOewHktO5YD39He7wb81i1LrpDO7LAi
	4FR5LdF37wutGwjawd2uIPLvVIWgSXqwbgcPFRPZIICNarKTBQ3D+MXxLvwfleFY8GYywddOE8p
	ZdySFjYh0RyQltggwH7idQ7hejPURxqLqABoNS7aKkKDPGQWmoI5LByraACQloIll+hNPYKuaP6
	NcggwmNREe9EZ4BIOStvWT3ccEAZj9zMsmbEi0yRMLoKtCim/wQ=
X-Received: by 2002:a05:7300:c019:20b0:36b:f09f:924a with SMTP id 5a478bee46e88-36bf09fa41emr1925693eec.14.1793701086055;
        Tue, 03 Nov 2026 02:18:06 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:18:05 -0800 (PST)
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
Subject: [PATCH v11 08/10] mm/vmalloc: extract vm_shift() to consolidate mapping shift selection
Date: Tue,  3 Nov 2026 18:16:56 +0800
Message-Id: <20261103101658.766905-9-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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

Extract the vmalloc mapping shift selection from
__vmalloc_node_range_noprof() into vm_shift(), preparing for reuse by the
vmap batching path.

No functional change.

Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61f2b6fbbcd9..ee2c1ec4ff1f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3605,6 +3605,14 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
 
+static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
+{
+	if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
+		return PMD_SHIFT;
+
+	return arch_vmap_pte_supported_shift(size);
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
@@ -4124,11 +4132,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		 * supporting them.
 		 */
 
-		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
-			shift = PMD_SHIFT;
-		else
-			shift = arch_vmap_pte_supported_shift(size);
-
+		shift = vm_shift(prot, size);
 		align = max(original_align, 1UL << shift);
 	}
 
-- 
2.34.1


