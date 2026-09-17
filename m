Return-Path: <linuxppc-dev+bounces-27549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14744C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4Y4F3Xz3bbW;
	Thu, 17 Sep 2026 15:41:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623040;
	cv=none; b=Zo9pLm7I7OTfg8CgXSeoqsvnzkF/iAcBmwdFMu5HTPGqMyXvXQ1+iWuD4OXq3a4hUrp64s+yFDpGegkWsFrVtuE+ip3Trk+wQ15yLy0FWj6EU+Nv4DbaD3SewIbxlDmoDP3aIxx0qZrfxzpylP4Y9jZ1A6jdCMcTQNwJWwPm0C9kFzihXlNV0qXoRmns2f6mstqS/6x/w3nq1k6gRzKmhzwZnx5ruRIG9grLu0//xCkhg8MplmmsF8lUG6nPsBZnq2LT0DAa4xbXCTj3OcO2vg5OfonuOt5uTbTV2MrbfyUeBKMUOXU7w4ONyqsjRe/R01B6XEKHy6QL/3ffEL3uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623040; c=relaxed/relaxed;
	bh=NzaNd9dh5gQiSMMbEDA26vNGMF5WFO7Tl8lfuiT6OXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sv/ybc7EYgQSEWgzScmrUDRKI3i7cLTQwlecTR2UnWxmXlxxy/VoXPQjYM7dMMome1qKVhJqegfDa0p5lj2bLW5/17Vm4bS6hngF5hDKgHpvvYAaCIBcqrc8urGy92GwCw80V9JraEma/I7i8rNCe3QCqKRpg+jKlayb2mFIt73NUL6OXYy077UjAxJQtKITtZhokBb2teUcS19XmhAVnOubcPoJWYDCb0WlazOs8NyoSpYDeHpA4wzinTQLnE9KXLQnfAsyJkIlRRbdAzKRUatlBqhzule/t1cqI9IrOKoVb9rW/Mw8guosdANolLr43wep/Up9NN6Dm5VVH8EL0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K9VqGY7E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::15; helo=mail-pz2-x15.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K9VqGY7E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::15; helo=mail-pz2-x15.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x15.google.com (mail-pz2-x15.google.com [IPv6:2607:f8b0:4864:3b::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqh0nqhz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:40 +1000 (AEST)
Received: by mail-pz2-x15.google.com with SMTP id 41be03b00d2f7-cc4c3304784so299070a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623038; x=1790227838; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NzaNd9dh5gQiSMMbEDA26vNGMF5WFO7Tl8lfuiT6OXc=;
        b=K9VqGY7EGyKk02ymT3DNB00iqRN+1zKcpkxAzm0fjRSyYHgLbjWp2i0S067n8xP7cD
         2LFbPfGfmodQKw5K4ryETfm/QIwWw3tU7YZOU0RUHUNDv8nVK6Wk7/+IuyrcIb1N0xZQ
         mlaMDL8XxPWe1BouOo7qUAlLA7YKGWBfcjdCGXNFcl3y4Lqbnci/Zajg4pi/vHyxRQFd
         VnuZ/kpz7vdQfIOUo+oIEl6TON5a2dRtDf8GWtIPRjIaxoQcqZYcHfbEy0TvzCBhdhOo
         KULrmer5OfxIkCFiTFiaPB1D44tAOwamTykWx92BFjX9J3IKaNmW5hDZY5ji2s3zReu7
         gGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623038; x=1790227838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NzaNd9dh5gQiSMMbEDA26vNGMF5WFO7Tl8lfuiT6OXc=;
        b=XlEEIAB1JfabJxS6cy7VH1noTadtiZXaZ4HczJaXhNibrIH2pSrPiClyl2neAiQE4I
         R9NmsMuFBYfmpvCzIAvvREDpM/tgF0TQ4r8EaQmYEuBm2GbQZ/L7vhomrRpYoaHvUjuW
         J+yhDd6E8woU/pTCxsfw6hCoyXKmQrUt3Gvxx9/vjqSscZwIRmRFPGGRc2NrdKQoG7MI
         py91v+CKI4DTyKoKFlaIMb/UDYRkIyrTAbPmnK1uMTXW2OG1/mt94OOMJLUG+ptepq/o
         h3Du/3tl9t2PAe0EqbFFg0f8+gJrCBYsolzSf+l/eo16pa3TVJNCXMSsZjelRS9dkWXA
         WgLw==
X-Forwarded-Encrypted: i=1; AKwUvBy52JWrBTljHuJWkIj0kR8Tdickeh6ohK9ejufcbmVufiozAvFUET4BrtG0/935/dXWIQj0QqIzYH3+M7w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ny84fdAl5/TjO4mcrrWzzMdHVC12KTdM2BspaFFcJkFG9Yny+0
	GpAPk28tdYVnS6U59S66x/kR/c1xSJLRhWDzzYZM9eJ6rV15dUXfsj6q
X-Gm-Gg: AYBFou0rtfjk13vs2sExCzqqlV1XhE2O76c/+q8uZBCai06oCjndIUEg5iftqN8UfvP
	74uhy99L9Ju9yvfvQLHyFqQPdaByv1oc5bCaIyW6sS5HfqvWl8wMXmVmnBg5Flrk+f2z8x04p2t
	otAMqaxTnphQrE0wJXibZ1BtQINh/OKmulpnHean0Ps8KfhWUz+EA+SlV/dkUD4YJUpzO30dEGX
	oSLgaukpnaXqPZxjJ74RikIAx1tKmaJBi6FsCtLPSYynoOc86l7Geq0Ratau8oEU1IDUzpbeDbK
	Brv9O6Gw7yP3C3qKNx5+nKrbzwB35EE0RUGB+pGdWiG6ZeMzBkHC9gPbP5jw7kbw3PaisXW4zWC
	pI6GImyqPAnRPqV2c7fMnGGJzAymAUlVAurtw/u6RLUKQzcY8d8urhwK3Nhy1k2p9KHONgxDfsI
	zy62w5K2wxiaBefJ8XVhM3sraA3mzsVwsPCH5JSkAwt8VBlCn4TuRyCqR0oXAv27PlgAozfDAm5
	s20uNpdxhgo8PZDfw5k6aiJbfM=
X-Received: by 2002:a17:90b:3b91:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e1e2bf7a7mr16057715a91.6.1789623038178;
        Wed, 16 Sep 2026 22:30:38 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:37 -0700 (PDT)
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
Subject: [PATCH v8 08/10] mm/vmalloc: extract vm_shift() to consolidate mapping shift selection
Date: Thu, 17 Sep 2026 13:29:31 +0800
Message-Id: <20260917052933.188679-9-jiangwenxiaomi@gmail.com>
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
index cf1daf931a6f6..ed868afd8194d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3532,6 +3532,14 @@ void vunmap(const void *addr)
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
@@ -4039,11 +4047,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
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


