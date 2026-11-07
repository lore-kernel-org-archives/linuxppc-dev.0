Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B950606A330
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6BWww2O
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHWN2Q25z2yHD;
	Sun, 08 Nov 2026 00:50:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059456;
	cv=none; b=iSULoB9taued/Uk6uNG0VTLDK7VQi9Ngu/ZnKw1YDCxLXkTfp3PVBQvhnf8yUu67leZdXFg0gvBwdA+yaMEvPvK3KVUK3MmTrH5UwHxF+aFlghIc6gLU7lNPTvdRQibFQhIY6PSIpjfdyeZ0pIvxkFtozCmrlEFjnG3rHwh5aTmIBeIw2EokF76GLzm9tdUPReyg84IWLSXuhiN9YYaBW7G6vOmdim4MaPKsaXf0UQ91aJwvG3EsbST/bmAAWOVUar9gRGLULl37Ri1pB27vFqb8nl0gmEz0Gv0MdCCRad8wvnqsMNLXYSg/yCXrc27+JQSjV9RnxiuzOB74T++QgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059456; c=relaxed/relaxed;
	bh=3gOi0SI6UE3i3Ok6KJpgZYZu7b8c3dBRXUCOezx+hkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK9xIf4ttUeypAkD2FS2PeqqxyA4zIgu2tzT+EgegdBOA5Xrerf105vCBc0cOV4U2Oo5PkbJSKOj298UDVrQtzR8iM5rqx81SHa7nRUTFsml1dVA2ooHhaWJB7J4mxqC+8M4VVZtLhdDJJEJ7Kg2qcKqLr1EZdP03ciPWQfMMIN1nCKGG2znFq6n0PHTQp+qTcXIpT7N9NiYafJNI7mXoJnmLHGzl1zTah5lb79Fx+u1b+ua8J2GJYeL/prJZoxm4BRD9M5aZ4bM4qhcLNh9ec8ZutK1b3g1bvw4wqW27d+PErtBjwlA5ssLFw7KGkgCldIzQQKczj/lQspJgQyylw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6BWww2O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6BWww2O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHWM4tF8z2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:55 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-37000e7234bso2608397eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059454; x=1794664254; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gOi0SI6UE3i3Ok6KJpgZYZu7b8c3dBRXUCOezx+hkA=;
        b=r6BWww2OE5y1ssdhu3ViSnQhhYjEry12ihBSI/iGfQKWHMRTju4Vjmkjf324hEEJWW
         7K3F+RPKe986rBOhE+ZFoak27DEZ1i7GTxdi3/VrvEzeQs4xdthYQY3hwrKEhtuEEx7+
         SaJy1JAA4N0ErW7YWnkyHw04DunOJgL+V30l/8po76QVwikullPKzwJLrIOicFBanL12
         npjgbDJ0zBeuvxQIDZU5WN+PAVdCfc8X6nSOGk0cvwxNAfdqtp0JRp0TAJyOJ0P5EWsh
         QoUwpe3HejRTDZBrJ88wYvzR6CtjmOAdqmBOhbzNZfZuEElccSVnJWTts60M6DrwgJU5
         MQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059454; x=1794664254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gOi0SI6UE3i3Ok6KJpgZYZu7b8c3dBRXUCOezx+hkA=;
        b=qH9wSFy3w17OZgxygwF2tB3vpw1/Hg9YSQRp4N9VEoVshdp2eeK3nA2dyfTLBHxvtS
         w8pzQx0ky15i6UWmJLx/8kfwmIcBkk85rhlsmSFgw+9g6TOaQ9PZ/S2E+QPFZZWE7+63
         AUUJMybV9RpqnW5nI3TqrEbEoxJMw4oyplKwMYFo/7Mhah1XprbKObrvq7jcT5yA6Lix
         EMDHf9AdXW6c3wdDpEh0xYO7uoFKlc0B+dw6ntnXpgTgrUsPuoFB+OMxt8e1dpECFsvN
         lbGAqsGtf0gu6jbUihFY0Y4ArwwaAZHJLtAEHXr573zW3BDFFhX30lZY+f72jHQKsJZu
         LTqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEsllooeh7LcDOpaO/yb7FtvXPbP2GHZQP4ThfAo+CDf4gDATNTNvKyyh4DlqFtcGlGiMnPxFWwSiL02w=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/e0XQh8y+PW3V4O6IhN9lGS5qoOjWjATQ4ymCa4DQ6ZSJMvusj
	v35pLUiqVuDk0UMiB1uvfycgob8AUXdvnrXcnizDGXEwgQBUs8vqvWc1
X-Gm-Gg: AYBFou0/2WUYV5iKmlMSYiVykewdmcS6eT3OlTrJXKLBl0g72QspgsSxo2jX4b3uiP7
	BuOyx+LkPFN5v0xtKJv6OaZqQwSlA46X2q3kRqw7Xeau6/RMkfF0FHmur0sf8a4XFKPwaNmdGjt
	1D8Yez59qVZYzogyApWwGFnQDxfcfw9+FISBzFi/9Yl4meplpQ/Uk5ikuSAMSKe+7u5wOlxoxbe
	BCgPvQbq0y9zqCaJk39MiU0GBdvFIczs1jrxdWMwVx5a3tgkUV2rgREcbHKhNHZ2uu7qMkePSRT
	auUOMX47pbX51i9499evVAa9Xs4RGOJN0yYO1gG7uETnksAeGY8rd4Uxxd69cmeLB25e/EwtT5a
	k340IlGS9x0e7Ly14XZduDS8Giu3MWIZjckcFLJ56iMYCFQE2ZwJpBfTkcebXRSJ9Dcvv3IeXeF
	+36WYUgWd6WzD7RUt905xuHn5zBvRGWT8FKaEJwMnXxfQkvTWbkVSLPXWPKjZOAsBwcFFEzBUMP
	WXopuQm/YzVAkd/CN5TRyOW9DSwBmTAqCvdwXrgLG7hUFcDX4zymg03yDdvoUTmJJXuJ6YUC/Ok
	qi971E3WrTG1PsPz3OAmAWe/36D8lgNrHou4Ck/yGPJTTNZilhswkUU8RA==
X-Received: by 2002:a05:693c:8843:b0:351:207d:bff4 with SMTP id 5a478bee46e88-36f72cc18dcmr8373352eec.4.1794059453503;
        Sat, 07 Nov 2026 05:50:53 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:53 -0800 (PST)
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
Subject: [PATCH v12 08/10] mm/vmalloc: extract vm_shift() to consolidate mapping shift selection
Date: Sat,  7 Nov 2026 21:49:51 +0800
Message-Id: <20261107134953.748622-9-jiangwenxiaomi@gmail.com>
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
index f2dd9bef4de0f..884e178405171 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3609,6 +3609,14 @@ void vunmap(const void *addr)
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
@@ -4128,11 +4136,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
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


