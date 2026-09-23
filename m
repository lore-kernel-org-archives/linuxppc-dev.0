Return-Path: <linuxppc-dev+bounces-27969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF011C98308
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrK316cz2xs1;
	Wed, 23 Sep 2026 16:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144945;
	cv=none; b=YJsushotwCk3MPqKrBxMliKmihNWqpV9ovSE4MwKZdcyf3Bw/HfgMJ7fgH337Uda07uTLMQiknuVAjbsMS0oD32/1nn/46NFfjmqC97/Lb5a19JMrv8rdyBzBesGfcHf74eQjBo60OcCUdNdDfwJyvAQcfTHrNrTWL/Y/NKxCu3al4XxVqwnvdthqEHb31nv3NV05TlRQvgqxLbwkJygFntDRsworkB92HHr19AxyrzDCY8N3agwnK28oFDblXiAqjJh8tHx0x5po8NuAKhbGu+PWHtcdQaXu0wxsxdPiYfK7ai6YE4ZnUt5H9Z57dCVW+RFcHExIyteZaOSLtXXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144945; c=relaxed/relaxed;
	bh=OYZzRE39rM1i8Kn24WfXB8ZLiPdAdycC2kyj5f6F4So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXHrUFCgc3SczsPgjThlrOaQkzEfbNZn3bWUeBqyjUnDefPb6p3rUmHSy9dVoYBVWEe2+Yx4G0NVD8QF+legw4u7TEvYNDHR4RqLytQr513pqvkOUyS5c0XxzOl+w24v+Vw3Y+TbNHTpg8qAGvFzp91nNcaiQUL9HRZqbi8iZJPFpDzhnJpwMPGCPMQ/iX2X7Ys/7RxVmS/Sa/DQOoxBfhHmp5FU9Z6gVPp/lsRFKq2oOu36kczjCln/D8e1Zv1HUANQPErsVWLxXX+4ZDmwVPKC2/aAT7nWy/xY8l1MxTc/vB4w64fTo+VyVHu3RkaU+8nNOiEnh/5gRv+FkzGS1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHtNoorO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::15; helo=mail-pj2-x15.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHtNoorO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::15; helo=mail-pj2-x15.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x15.google.com (mail-pj2-x15.google.com [IPv6:2607:f8b0:4864:39::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrJ4f0Rz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:04 +1000 (AEST)
Received: by mail-pj2-x15.google.com with SMTP id d9443c01a7336-2db1ca06a25so2457515ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144942; x=1790749742; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYZzRE39rM1i8Kn24WfXB8ZLiPdAdycC2kyj5f6F4So=;
        b=HHtNoorO0LqxnXMItryx8DLYZKIywcBBBu2mtp7jqeV0skEAVRL9ye2Ll9xzi9HY5z
         FVaFii2FQg5jhQW0tuttjD0fCWdGL/BefU4NCXzuKnvo9nKV24SaNwtM1DKzmGmatGFn
         SpjzP4Q6GMVbyG7Fii/4C52q/9gT9oJVNtokYFhiGqy4dKaH02gE+/s7Hy3Ha7xR3DTs
         pwUFbi4/LDryGSE0Xoi9iE8zjkH+AHZyUzxrUf7NpozM9OoYJKIqROEnyoatNCBcAebB
         kGO5r109nWKBSCOrgFHLENHqGJOB4g64xFeBQflMfnxhpiKlED1E4OBOBo64cIlGnPn9
         aIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144942; x=1790749742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYZzRE39rM1i8Kn24WfXB8ZLiPdAdycC2kyj5f6F4So=;
        b=kcpFcHoNJXCHKmNqaUBbpic7zFe+N6prNFBoG2DNDPefdhKneS/pVPA242BGuJNjxU
         x6cXlo7FbSgxL1p6ZUXf+LxeQFtVm201eWoqc+0xyGwyLAYzwx8O8GWp6TXQN0cNZBqO
         wOE7Qr/dX1h9Tl8+awMQtaaI2q+6X7lryGHaI9gCqMObf4dhILynEuHXi8eAnwCTrRz/
         bAs52uQdey0iOIwywTTGrgZNOjbsoFW8ZrRfwFXsximNUwMtpN6vsrG6yuqr2vRtbWkX
         92nc4sT6iYNt8/kEiSZc8+v2zIhOusZuFcPvBWGWzS7kk9F/djsk0ZtKl95I9p+3dZiI
         MWzA==
X-Forwarded-Encrypted: i=1; AKwUvBzWNX2dhF6JsMyDri4pSVUyHaH2WXOhq+1G4jfmjF0Cwre7PxJzPprWIxHjbdP1qcPlsQX54PJ5GxOkKJo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k737RmjX+fNzugMcB41PpsoubnDTY2yWfljn/1y+Q870uUV5cm
	NE3VUcbEIrUZWSW1ENu6rP/IAv9R3INZJBzjJkaZKtgctdH+baK5pPHb
X-Gm-Gg: AYBFou0LYyOTnmW2Q/oiCb/jwxCjaGYKMsjAXKo3w3TDRU22YInM7yuneL6SR0lGvN0
	B399BwKuL3tVsyhywvBYk/J3oVGKvljKKHpQHc92G173shRbbccP2SBZ63byRoFcprinuap/zS2
	ZLVfD5sAPsRXncZ1wJezKaBRGm7ocGNDpzyP8bDQoFMb+dYs0sKxLe4hsUz5+gngThJr7ArZEBg
	19IOu0GVgp+5dpGip95Pe1LoQjXtxhlpEM704GENVseSmQn3k4grqazUohTAtFevdjpqErLIthf
	lWNV/B1RJeVJhMLZaJYTpOFcHi7T81b0d7VLQ08FA2RnshPEMbVxz4Yme2yaMmqZ+BL5J2Ha9D+
	GJi/rzh23eE1qj9OLZ8EI0XRh0Qzp+vY8Vax5HUgv3DwSsZEef+eL5ESPdov52JtvkwIrAadLmV
	/NCUHxRcs3/kIlgxXyZyGkD/hH/MTdY1ui16L+xc+JbLVbSDFVeEd4CLxWMTM9SQqDKy5Cq3Bbo
	U3xfOZnTCydirkf4tvOI64=
X-Received: by 2002:a17:903:2350:b0:2db:31d5:1448 with SMTP id d9443c01a7336-2df69d689a1mr14297125ad.22.1790144942400;
        Tue, 22 Sep 2026 23:29:02 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:01 -0700 (PDT)
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
Subject: [PATCH v9 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
Date: Wed, 23 Sep 2026 14:28:26 +0800
Message-Id: <20260923062832.479455-5-jiangwen6@xiaomi.com>
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

clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).

Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
longer a caller of set_huge_pte_at() on arm64. The only remaining
callers passing &init_mm are in arch/powerpc, which uses its own
implementation. Remove the dead branch.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
---
 arch/arm64/mm/hugetlbpage.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 8e799c1fe0aa6..ce247b06fe03d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 
-	if (mm == &init_mm)
-		flush_tlb_kernel_range(saddr, addr);
-	else
-		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
+	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.34.1


