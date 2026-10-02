Return-Path: <linuxppc-dev+bounces-28733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF67CA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:11:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30k1yFpz30V4;
	Fri, 02 Oct 2026 19:10:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932246;
	cv=none; b=CcjtvsltDWiNciSLQYhg8PBsnSAr4+E4a6BTYgK/c9t7+4uANWvQVgAExbJJbBI4V8ocKc4rq7FNexl2jaS1iZ4S08OzPDZyBYrdytBkw100sP34dtdhhQigi7X5A32eNOT1D2QQG/9uOtahqD4ImMbPXWHVbwsYNvYjoO+1S+OUmcd/YYwy7BJOA75TbJ8f7A3KXapotjdpNW2lH9082LEFc+K/ME7M6oplJLnBA/uLczG0XqC0blruxXa6DO9tYkuzfXBuTnKw5qQJcZe1KLndw/dNJDdow5nYwwaLMeQwQq5uuiR8fT8luFxVmZnHwYayt3BaV+r2EeDQNfM2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932246; c=relaxed/relaxed;
	bh=2/5XOnfiZIWhHaazfIksBYAhb1bM+JDK1FK2T/8kf0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e52kOrfu8ehv6A+cq4Fp045ZIPs9fKmFp42zqqE0CXbzWYBweDcUUWtsXarICcfEBy0erhWpwdcVZyDkWh4O0emxZhT8PfTMbfqJ0nf/sGEaRSSuhlis6Y/XEmVuYWqLYNWs+zTxb/fAZUc1FjEBlT0RIXymh93nDHm3iaQd6GKANwIAH48gXMd7mXOLh0lnrt0GCK8mDvTJXP99BY4dHcOZk6fhbgz0+romevEaZ2mjMONhKejsfiS1PnUxUFrt/9UQ0zF+OdN3sVvfIGD/Aif8do9ijLwaeyCrmsdvqaqp60/NcyvHcxqzFO1d0525XMTt09UOrdzdN3KYn77gLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXG43JKm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXG43JKm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30h6X73z3bxp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:44 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747ed9866so51488515ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932243; x=1791537043; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/5XOnfiZIWhHaazfIksBYAhb1bM+JDK1FK2T/8kf0k=;
        b=BXG43JKmZKaryjRPd9itUKVZJVGK1pbkJFVp356MMjz4zrP0oKJGpbxN9jD/QUG0po
         P0Dwl/Zy1NXaCaBGrnBleKz14XuvcXRY23Hm4qnn8InS+r/Oyix5Sh7BXgcpTietgfE9
         lh7o8zBvDpEAWIWi1uL+GCuvPRNwtDC1wElLohnf8Bmtsssvz0tqrmdLGwVeS8K1xPIb
         eGN6Ry+HBAaqsvUooXNtCIRSG8/xJv/yKh6rTEMgWQDTtSrBx7DSxGT1c0dn9QqNZlE2
         PIeLU8Ipqc2vK6slf4qY3I1A+YpW6+tIIbeGlKNZQnrxGVkF8X0nVttMY2EFCUufEgDT
         cinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932243; x=1791537043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/5XOnfiZIWhHaazfIksBYAhb1bM+JDK1FK2T/8kf0k=;
        b=lmk1vXc/TO3nfnpzSKaMsGsbEvBl0c+EggXmZm2CgLR5X8hT6N71VKw5hJfwvJRHZn
         ExlEWOorwBiZ380u0tDhX0oXT0fKUg2nO2hdg0oiO1mSluhkW0r9zbx/0XFt4x1MYNPv
         ByEejWciq+YfiQKwfoNTUpsbhv7ohWc7HBvScMn8FL5PU2xG5rMMVJX3olSuoK90UqnW
         5gueh0kPRZs/M4xkFJGKJCjHydOusj8AijQh+Zcqne6UlELZw+NCJw2jSawsuT/kdN35
         1cUG7Z8y3gYHuXziNDQ+QLyQ5bmz5DRzkknyQfUNnZpr0dOs3W4gQtctcnvYnirOEKRt
         6hVw==
X-Forwarded-Encrypted: i=1; AKwUvByCdDwS4gaQ4bm0T5qo+KGT/Be6XR0qpELIMhFdfG7FT7lsryouBWJXFAaM3qw/xWpTHp2nmyajPv6BuSU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mZ8WpxLW8mdxkzb85p6loWWofrAJgZayccDv21oQho2WnN76ZS
	laJ/C8/q075t0L7RbK3oJ2eT13eg5vxBDspj0aY/QcJLqO2hDXYODCr1
X-Gm-Gg: AYBFou347ysxPWynFSHGOgtvO3Kuuxqur3BmzYfU/mPX9o8euwfOODCHU31o/9khf0K
	KUANMNQ83gCQejIj1cCjzQpkzY6cealEwJOrwwpbgNRImYyjQGYC2l3j6vcTPchOi9js8PaetjN
	ndeKNyyCPtdppQ11qJImtPExWjLj4aFMzYLTP1GVl/E6ShFEL1/ObTGTh7YW8f+nW6awywtyl+X
	jJJ8VVZ7QEpu+KC/9J4XSSvzxEF8IqrDTXIanV3YMyQ+zsDxxMIAxUV5Bd6/HwNqhYTUxhTxf2C
	Kp/KHUjIc4+MZdrdFrpQe+dw7DvnHa0L4Ak+J28L0+VHK69Jbah6mgh2YJkxxoaWMgoctAoCo9h
	eWsb85ufsiGJQ905789SuvvVPK4Tn6+VbgdN07SoNzKTVB9YBVX0grAlBF1v7rTCGOmBqRrbRBI
	j03Ygc7oNDdKBSvGVnnkUBK73CmG3gKd4w8yYiDuHmqBMRytUHXy0d+ckGrEqYfFLxTh47tJIV9
	JNufodt18j096sRJm1rew==
X-Received: by 2002:a17:902:ebcd:b0:2d7:107c:917b with SMTP id d9443c01a7336-2e498517c3cmr18629185ad.0.1790932243081;
        Fri, 02 Oct 2026 02:10:43 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:42 -0700 (PDT)
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
Subject: [PATCH v10 08/10] mm/vmalloc: extract vm_shift() to consolidate mapping shift selection
Date: Fri,  2 Oct 2026 17:09:45 +0800
Message-Id: <20261002090947.869220-9-jiangwen6@xiaomi.com>
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

Extract the vmalloc mapping shift selection from
__vmalloc_node_range_noprof() into vm_shift(), preparing for reuse by the
vmap batching path.

No functional change.

Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 99bd22c086bf8..aae6141aaebf5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3568,6 +3568,14 @@ void vunmap(const void *addr)
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
@@ -4079,11 +4087,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
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


