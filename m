Return-Path: <linuxppc-dev+bounces-27973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACFC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrp06T8z30Tp;
	Wed, 23 Sep 2026 16:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144969;
	cv=none; b=RF8nvD+8oFzbvnevc7m6sN6PqVFY/qQrWnDeMoRvPGv4wqpFUO9jlz4bPgNQpgZCSokEJYvca1bWablEd0ZDQV6YP4rYsBXspuzmHefw3qWETs26dBs/8Lu+0b8onkjYRYL2K/OkNstAIEIxO0fBXMQwDEWs4sb3WkK7R1368XmD2NnwIy13PTGLZxnCJcKhwceYRWDekjuetoDIcfCxEDBaC1jPcDhJeUCxRyg2I155znhOGmfb99XlLH0Zxywnu21dylTek06vhixSxpFRCy95T5qPtcymJAsVpDH/5WcsrQ+7828PfvrP0UPfBvd8mDstyqdV4mT6q1l7lNRzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144969; c=relaxed/relaxed;
	bh=BLJDwfik8v5sXhgfZiByNmP7K0w0uZHSBWxfXEf9m1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XElmo/7UQJloaP6V3oO+DjMyYOQNpGKcf54Ki5fBZgi0E+VRKM8ZZkpWruOoU8ta4lI8JhNfpUcfhiKB3u9qZbKzAW3YcP4ULnzjaOtuZf2CGi8UqQmek/XdNRIs0bwRoM2QfAbpqhi9EIzeadd8UBxhznyebvctyo8MwiqybmSRq/Fp4Iaa3owziRVYxSJDIrzN1J/vunOoPhWCDB6EHiEbTkC9965n9nkMCrKUHA3PlEWEL1yi5As0kY3AqfnpzfqLNT0Z9Ug+/LgcpLD+mO1d1KjlFlTwNRgtAh9Cb3qp42TWGKrJ9dC0xw6+2LxrKKwdMXGqp26yzJljVlvnAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TyOGZZdF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TyOGZZdF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrm6ncDz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:28 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2caced6038eso4078995ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144967; x=1790749767; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLJDwfik8v5sXhgfZiByNmP7K0w0uZHSBWxfXEf9m1M=;
        b=TyOGZZdF7nVUVhKeITB8bDHdo1/4ovNESn50AWJCPPDbRB20cfbTne+kmO8AW2YVSc
         4XGjkouCiJHDE6PYcqv46Qed3jarQkp1BBopdqd3iT4s5+v6EZwdNReqfEm/YG5DWXIA
         9LTtHS0//A66ywfY2V56pG0X0+jm6dD37aoJMF4haNR0nDm5TVW8P4QPqnR9MsVx/bbL
         OI5yfS5oYqCvpStQKgpjQjCuBWUyCmYsjIZfYSKY+hdjWjGHtDJecVC1niH27a/VLH3T
         8K/L4E3lBpReD+U/HRt7IcxMK/8GtEkhKrTL/OVOD7aqCdU1WYHrowxCtGYlmAgQEf1s
         csyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144967; x=1790749767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLJDwfik8v5sXhgfZiByNmP7K0w0uZHSBWxfXEf9m1M=;
        b=FLG5gGOnf4j2dZJstZCGk046HuO1Esi2HBe7WGwVVmTXurVOXA4NqKByki7UvMOLRm
         DNMxDtazzo3od/utrKB0gGjH65JC8l79F8guqIPavcslrbG17gXBxdCqPW/OOAxtSAd+
         Ytza4tPs2Pc1QC8MKIRnPaBu8xpAC1+4BbK8wGyxUfONplxmD6GMTH5d+02ftupMVOMh
         Lu7MjC4YZxhBNbSyFWhHPXsQFTyxZOMDmND4JGZf4/imKFui2OsPXkNtxPfPKCHPAbzo
         d5t6KypbGab6Yi/zQFrWJ+aw/GMHADLVuOUA4xg5f1anG2gL6fWd0/rtIDrI953/64bH
         oK6A==
X-Forwarded-Encrypted: i=1; AKwUvBwgLbl71hSaV/0JBtIVIR/pgRolzhvu50KZsg75/af2fHWAxyLiui/2k39ms8EGbZ/TZoj6qysV/jVkfbM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mpA4JS+bocp5V/xrzqSnTUxzNcRlmHWlpmExjNly3yJvUy1dsE
	4KZM1canf+ynx17anJZkmniPSBYHGzu/3C7z70sKGuFdbuuCIZbNeaFk
X-Gm-Gg: AYBFou0paiJ7erU1A93kXs9rkL1N2q3yyKqGfR5qffxLYKmP2mORDEv3LnunjkWQNge
	oho0NY4/BnrB8Fru/YraeuGKKjiJe9En2WnT9DyzB6QsY64il+z3UEqW31Q2d64yGMYtbI8ZGId
	El+k2P+zwH2L+I2dxyN8kGIwp+c6jINPL+rxMef95Qw3wlQI/JQh64yyrotbX03wzvcTxkQXuxq
	9qjRXEGWgM9WpQexYWWw1j6N7eZuWYfqS9J97Sq82NCenoBVtKifwNk9MbODD3VcAYzScuV2hc+
	KEmm3kbtKDpddKj709MBIrpSNe4tVpR3EOUD+JZGEqM52/18yJNh4KiPCvWsdO/tI1uAMhk52tO
	HYpXygNG4WENxE3wee1Sw4ZBkcTeRPy+WF4IQach2WFpd6j44nI71z65KllC2vWFW0Ir4kEzFzC
	EWpo7KqN72snk+YUnnZMxdh45M4PTDLKN2YlnZJW0HjmaGn2NogxnPt0SdcBjO3aSzBv2UwIN3v
	qOkJZqM5++LcA2m3JULtA==
X-Received: by 2002:a17:903:3c2c:b0:2d7:1cbd:9ceb with SMTP id d9443c01a7336-2df60aee398mr25552315ad.12.1790144966712;
        Tue, 22 Sep 2026 23:29:26 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:26 -0700 (PDT)
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
Subject: [PATCH v9 08/10] mm/vmalloc: extract vm_shift() to consolidate mapping shift selection
Date: Wed, 23 Sep 2026 14:28:30 +0800
Message-Id: <20260923062832.479455-9-jiangwen6@xiaomi.com>
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

Extract the vmalloc mapping shift selection from
__vmalloc_node_range_noprof() into vm_shift(), preparing for reuse by the
vmap batching path.

No functional change.

Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
---
 mm/vmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6e0dec73107a7..a43965016eb4d 100644
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


