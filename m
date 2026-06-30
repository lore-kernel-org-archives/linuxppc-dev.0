Return-Path: <linuxppc-dev+bounces-23218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191DEC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:05:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqRJs5LVGz2yhP;
	Wed, 01 Jul 2026 01:05:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831901;
	cv=none; b=R8GB0QCjwZJNKO0KKjskF+qAKQPaaYcvaL9Wj3sdr93fe0d2Tlkn2SrNUdNsoJBHdy9dG+wIPYUrwd24g2AXZHrU3mGkTDzAGzJLo3n8roPh3AhQFactltI4qMIW2AcnZfLKhTKBq7FufSFFtZlNa1lM6eFyvaNc+hjd5vbIORC1sKp2qBkragTSiJ23X3h9+HO9HgiWQygT50pPc5g6z6hiRF9U7RRJgZeWDvkOLy1xmS0mz5LC2y4o8elvrLSh0CT7WtFdO6/qcgUSf/UBItixkyscCDYi6mnSxXxRcZzxurNaAeethmyptZAz/9A8w2rG/kmuCgPP/E4yHr37Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831901; c=relaxed/relaxed;
	bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBGeneZmhHVOlLC2yzXnHy7eYLCrYnZzpC6laQXpd9JTrFOVD01piYbJMHkrCWrWRDe99YyIUc1D6zNbxBo5l3VxX0mAoEta0fZURLEAm6e5MIINkeJw2pxO5q+JjoLkkNoZ0Z2HvsywYNViOzdhNdsafE9vouZR5tXryv+lTPyyQnX49ZGzG+xXEGvK3Xt8YjGY73PQseD9wHXqOua+BsIjKq7EvAGYeAHxJr5LP02+ep+iI3SgFmN4WTCvAYfYkHJ4XGv6HLO6Cu602IA8O9u7xyklhs6PXyMg8j+19YuPI7fwybXqhSol+aCEtBsHgcvUyjXYo3IHdCVCgDSbzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuGht0s6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuGht0s6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqRJs0KQhz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:05:00 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso17335295ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831899; x=1783436699; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
        b=MuGht0s6dph8eCNfNO+JEZ3xQeVwu4dYJpmXPXBgp8FJyyZtWtKy/ghheLCMeNSZqh
         NlYms8uBQ+mcbPSHXlpil4sT3GM3A1lY3d6SPXA1DNKuH9Byw0OZpNIFWn8j2HiaJ524
         XT+oqAZfEepQtcNaEMoQKZQOSOVvhW/Y9tAyVVnu8VpBiCnEQ8t/vkhIb+GlmZVu1UCu
         9S91k8JI9uAxZ3X0X/248z2YGX8Ej4G8mi4IiQRrTG9Is7FYkCet0KgrS9F3BMYx+P3B
         WDTAbE9C6zN1w5U4/YKZU9CKSejtWN7EIlePuKJw4jHc9hqAiSZ0/nSQClmqMngCGvMJ
         YUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831899; x=1783436699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
        b=H4xt64V7xz/TpzVdv0VpcvZVyva3tr0u5Veyi6sgZNsCkRbIBHsN213XoqTMldhBcW
         RZ1Q3KRqK76FbTJjawoZ558Kb7mpQZnsQW3BTzv2wu/rRRYDacQsuqF4pEuhpBl9dztn
         VxZ0gFkqu5QUNvx2nIPeVRCRJ/StGngrpnLuWXbFScbhoNpdEopUB5tmVBY4T+vdlgtB
         d8QWakXaMZMQ2Kv2XjdHkyq7dGPAjxparkN0vaead9vXDpUXvJceintRHNV167HxMf2N
         5moXtyKvt+WKeQ3CAJX5wJMwR6WxXXjT2NegbI3fzDYLmq64cxu3CXzvLTXgcKDty2w8
         4dhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZjTXyh8GJk+mzQ3MRTo7b4qG041MLMZyU9HFSEBHDoD8iVNPH+a7/AhZN3TM7Hx2T+egKJmwrmq/dOe0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmiBFhPYGRh/1wYxk8SX8a261yQllKkMFafPuEdnH1AB/7DIUx
	baFrwKsroUTqeTtfzOeCz2E8csbICzdsKdsXRHTnZfbbiXLWEV/hCRGM
X-Gm-Gg: AfdE7cnmgVPehbAO1K50egY2+lVfmH3EJyzMT8P+ikJB7bwZfEYjPP8myS+ylvip2bX
	+98FwsT295lU2IyKu1PtNRp1DJUSdHh0Zl1a1JYa//Affjx2eIk/2NsRgbasrCW6K1Dd+gpwOnQ
	CbomIRf3ppqIWHg/SXGJBUJTqwq3m0PxCzpJtv3dLphmNipYbDtinT00VX53s+mhk0usdwKD0RK
	BGSQjiCcOMhHsH2CkGiERLB5yCMb+6XIgjVnAjHeNzagiTKoyyA8AFz1aoJSteV5l3VzqrD1EmX
	RUM4WyWS/RBnSW8Q5qBiAzMu0d4zJkMT0LKamHJDfEDXJezeaghhHOVvjBV0VdqPW/sjv/KsxIc
	iXJZmTwlCVPpmIAjMd9PUejWe6oVDSfy1G6GQHCuaKARqiiH0fgfSs2357smmRsTUAJBMtzAeWg
	ZgxS6YhN0=
X-Received: by 2002:a17:903:b4e:b0:2ca:5d24:720b with SMTP id d9443c01a7336-2ca5d247390mr6710495ad.39.1782831898986;
        Tue, 30 Jun 2026 08:04:58 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70bc0sm16250465ad.10.2026.06.30.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:04:58 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 6/8] powerpc64/kasan: Remove unreachable invalid range check in kasan_init_phys_region()
Date: Wed,  1 Jul 2026 00:04:11 +0900
Message-ID: <20260630150413.1718632-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630150413.1718632-1-ekffu200098@gmail.com>
References: <20260630150413.1718632-1-ekffu200098@gmail.com>
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

kasan_init() maps each memblock region with for_each_mem_range() and passes
it to kasan_init_phys_region(), which does nothing when start >= end.
for_each_mem_range() never returns an invalid range, so start < end always.

Therefore the start >= end check is unreachable, so remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/powerpc/mm/kasan/init_book3e_64.c | 3 ---
 arch/powerpc/mm/kasan/init_book3s_64.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 0d3a73d6d4b0..0ed372fb8b09 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -68,9 +68,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index dcafa641804c..ccfbfb894637 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -24,9 +24,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
-- 
2.43.0


