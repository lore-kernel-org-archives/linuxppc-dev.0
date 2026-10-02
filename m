Return-Path: <linuxppc-dev+bounces-28735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0BBCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:11:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30x0by8z30VX;
	Fri, 02 Oct 2026 19:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932256;
	cv=none; b=lFj1wPoow648hqJEGUNi7V79NFjr8yc+aJMQzEvfMShbMk7THTtwYVBzuzFyoeEBZ63RM/6Qchf08r/EkS2irdq7dKBdGHTrv2VaUkjgg2Eo34PeLnqbHyrrCIJFqN6j30mBQdANTpy+WrabyPj4NUdxiAt4/pF0kut6I8NHvRP5wKIclLDZ0+L8t3W0iB5pAV2+THcrQpKS0+bvdqxS4+bOx8F8/qPQZNTfTiWATPq2JwgMT/fRo4ZkxXzirrDIl6TvuNVWhoTmM6iePsY84bs54oG/fwk/qkI+S5C3w0rGLXA+AYXfFfuPAhhKaepV1NNQLRIZoSu3KauXQClmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932256; c=relaxed/relaxed;
	bh=nr+lcidngyc0ulTQrlYku4smM8GtiOinATZrrJ6f6Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHlOdBUt/QKYKBQCyP1+zTeTn1P3cmrv04o32AwxJAIVcHVlJQJ27buymWvtpUzw9/35eAXZkLR+zyDZlqzjmsq4vMhN27aDvxZsehCxc4C69B2spEEuRMRfOSYzzQWZ68SbOp/JILhd4Eh9fr2gzGSaQ9ZG81XQxxo/LtCHIG4WEQ/NpuvLzOtx+CnSzy0yb5yJJaJv/YU2z4ltxwhiFh4fik+wH+DpVaxv1BMxU4P5JecyZl2FNMXESiY9tFJn8VMIABLWMCMvzQiOjGC25pbanjvvlvKbAAZiTp4Hnnj7xz7Y3pZQeZGYcquzDbqCjIVrV2YbGRMQthEi0EEvKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pldF9UWI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pldF9UWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30w1Qz4z30VQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:56 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747eb79f7so33798975ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932254; x=1791537054; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nr+lcidngyc0ulTQrlYku4smM8GtiOinATZrrJ6f6Ao=;
        b=pldF9UWIzFCp+lEObU8Dj5Jlv7ql1YtbJpuQE1o9wLfilyY8qeqYITPMeB9hPIhc3z
         GpkYniQv6WkTUXV3GE8cHW6TzF7iSbw+yfxDoAChZqCGFBo+FF56do4GSR08Z6J6V3Ay
         MzVnsm3tlHmqmeRxFSGV1eecwXGwKe3v/WOsXV/LkBIkLFjfv61MU4ILOE/E5a2hmm9e
         1Fm7qRRy5gHWiqr9NCXNwU1DTgOfvxXp0yQifq04YM14V/iIJJUp9beteFJz3MiNHUCz
         +aNhtTbeGA3BTTPHBZANV0efio2CveROBdkaGjafFixvEdR0xK6DmZKv/+2BdhM9c9Wm
         Vpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932254; x=1791537054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nr+lcidngyc0ulTQrlYku4smM8GtiOinATZrrJ6f6Ao=;
        b=rxx4QAgYda1pjdBOxaTmbMqiBlYCG01wcjeIffeh6LEnCg1CdUL8WSQawndjNAiDYr
         W5lNnjI8WTyYcICWBCFmMalxJAq81DI/011WBqdSieQ/sZ7rV56gMk9CA6AapCxxG2PY
         fDYCLtJyqlCJZcCmIiYl/NJqBp+KzbklX7pgP0LONBvw7AQApHT6vsdi/OvDyYDp4p2J
         xZ5AknEzbmDge95RIPDFaBA3TDkAKQlApzHtNM8vEud2tGfy5QcXQPzpb4WJzHhL3U9k
         bN9z3UEI8buRH/s0rmr+0LICCdLMn8Z24GYGQf37q5txEI16EMVwwD2tLVAlDZ4xKDWq
         f+pQ==
X-Forwarded-Encrypted: i=1; AKwUvByNdDlWPGYQELQNSvW5K8dRdA2DR69fT3KOtG0kp5JCvT/zbKJ/IfiJV3NFj0QDIM3lpT94EflM3M41pZQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKKA19IQ1Uz503IRIGw0Ie70qFecwrNHl69pM8fMgqcCBFuH38A
	/J0w0leDcNhHB93EN6nc8acaP/rB1Mdxe2TIwwuVHxMI0/tINBDE4wz+
X-Gm-Gg: AYBFou0k0nHlJ4R3v5PQut9+J5V9NMDkuJV31kGV5F/OYcBz/IQestF0MLAdhfEc4Vb
	m//6Ylyyi3lhhGfMRybXrMLFmlRO5ixvuqfP5E8qgF7NsiKv0AdOxvxvNEaCmFQKCRuoDoMTR1K
	JUsRIN/I6s+qycgXwQG01dS/Ztah37Wv5GW25roecExKXqMhXpS3oNUfenjroqxK4mdKIHa7Xev
	4ZwDApmb5iqdes/nDoV92Tl8EG3b/6eMNHT9CJ8kbseMgRWnkwrTXF1oEuNfw2RuH1ZZdiInhlx
	SBm5DBIEb1hJSwuQydl55cOl52BG2ydbw0HD09YomleoqSpxPaQgaGOLw4gzueCIWGuJHfQEI2e
	h40g55rCnXBaTkY/jCptHgSPZRDD83rCfU6hhOxKDg41N4I6J5RAn2eE/3FTWCMVb0NGtcpkK+p
	9JRZFEMjucO07O0EVM68WkgaVKComQku/rfSvR7rZ82N4NiDfW8HZVmQ/zCTZ+xJHmlUiRixyOf
	kzCmNlDWKuI+L+rol7DUbySREjyMoc2
X-Received: by 2002:a17:902:d98c:b0:2dd:5363:3219 with SMTP id d9443c01a7336-2e49b4e303cmr20733295ad.20.1790932254082;
        Fri, 02 Oct 2026 02:10:54 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:53 -0700 (PDT)
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
Subject: [PATCH v10 10/10] mm/vmalloc: align vm_area so vmap() can batch mappings
Date: Fri,  2 Oct 2026 17:09:47 +0800
Message-Id: <20261002090947.869220-11-jiangwen6@xiaomi.com>
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

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

Try to align the vmap virtual address to PMD_SHIFT or a
larger PTE mapping size hinted by the architecture, so
contiguous pages can be batch-mapped when setting PMD or
PTE entries. We do not expect any significant overhead for
this.

Add __get_vm_area_node_aligned_caller() as a wrapper over
__get_vm_area_node() to simplify repeated calls with fixed
arguments.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4acd1ec27604b..3555dc3794e4c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3328,6 +3328,14 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+static struct vm_struct *__get_vm_area_node_aligned_caller(unsigned long size,
+		unsigned long align, unsigned long flags, const void *caller)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  NUMA_NO_NODE, GFP_KERNEL, caller);
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
@@ -3655,6 +3663,30 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 	return err;
 }
 
+static struct vm_struct *vmap_get_aligned_vm_area(unsigned long size,
+		unsigned long flags, pgprot_t prot, const void *caller)
+{
+	struct vm_struct *vm_area;
+	unsigned int shift;
+
+	if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE) {
+		vm_area = __get_vm_area_node_aligned_caller(size, PMD_SIZE,
+				flags, caller);
+		if (vm_area)
+			return vm_area;
+	}
+
+	shift = arch_vmap_pte_supported_shift(size);
+	if (shift > PAGE_SHIFT) {
+		vm_area = __get_vm_area_node_aligned_caller(size, 1UL << shift,
+				flags, caller);
+		if (vm_area)
+			return vm_area;
+	}
+
+	return __get_vm_area_node_aligned_caller(size, PAGE_SIZE, flags, caller);
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
@@ -3693,7 +3725,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	size = (unsigned long)count << PAGE_SHIFT;
-	area = get_vm_area_caller(size, flags, __builtin_return_address(0));
+	area = vmap_get_aligned_vm_area(size, flags, prot,
+				__builtin_return_address(0));
 	if (!area)
 		return NULL;
 
-- 
2.34.1


