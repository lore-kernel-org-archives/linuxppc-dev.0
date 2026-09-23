Return-Path: <linuxppc-dev+bounces-27975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836EC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:30:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRs03NqYz30VF;
	Wed, 23 Sep 2026 16:29:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144980;
	cv=none; b=KdvEQ5y3SdeUs2TX7TL9HVA/M4uDg16R5VaZ8giRkkX+TAdjP0sK/pE6OluPrRlhWihfvD84a3Tm/ne0GcZk/A1LyBlE8bHsVvHU21kW9MHRcwo4LhW3Rb53mL6EIrl2pPEEX0y6+/yCSB5HOlwZWTQ7ucgzqGIrh6/E7L3a2e9AZpiWWt2ShJ+9AkX8k4ipHRb4VzRi57gErdxQzoKdLGm9d9NWjc4Uvr5dz4Xdywsn3lqfhcxfG98H70VJX8iBZ+UTCH1GlITIuzUOqy8bo/4NKOI7F8jJ6rZJQHY3nO87FQqXisjbzF640bzUQMw2a5l1MwAcDpLUIvwtU5bGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144980; c=relaxed/relaxed;
	bh=Qz31YaIUZL0HkPkLOInD8YA56WfSRIuJpUh6x60MqwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VrxvZ2hW+TnbuqS/lBuQw6ZWtw/0/B0k+IgAAs4vR1QqDFKp+BAGHzz6H8AtUicgt9UrgmhCvrCV6K/P5td4bCUpfZ2Z+bSQz3oFniAeqk2wTuDwuwyBUoXXtRIrFx5IIEiaCKtbKZZvouNzzEPXe/wo07Qra396t6wBgagQEB3JcA5MbO/ekyCkVR5vw+HmmzPIGHHOLWzPTh5mB82kPU0it8CWxQG77DkjE9Qc/X32gWsIYwknIEviMsoax/2mYKWgj2bu0Ps2Ts/Rgks+0j6QpEv+7bIW+4/ouwVjvWJTrAH2YEUXTBald4/7uud4ymQBZKgYE72giUxsJZKYWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nr/tG5fn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nr/tG5fn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrz558Bz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:39 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db18fe433fso2719995ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144978; x=1790749778; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz31YaIUZL0HkPkLOInD8YA56WfSRIuJpUh6x60MqwE=;
        b=nr/tG5fnAmM5i3qJQ0gGgVPps3pwOnUBUy3svI8HU7Im/rD5usRi7JQWu9dlooGxnF
         Ad+YsDH2b+H9aP8OxdsiWs48N96iyB2NuSPxUNozfFZd0JepLkx15cYONDcS5TdRy6J9
         96ZsBNo/YoOyvQxj8q23S7u7QbUoQrE8fnmoCWTkkomFkUBF4iZqZZGmgmY2C9mabUmZ
         +tsJtSV0bKZXS4GuV3g0lTq1PBt7QPt0h/nBjrVV0YNwCnB7GCBcZqUL6A75OjSfV+Yi
         HMWaIQLNqmJmyuEDYqUCPO53heC4mP1hlbz2mkRGHeLbIGaYdogl/EJhwd4nbsYA3F0i
         PYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144978; x=1790749778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qz31YaIUZL0HkPkLOInD8YA56WfSRIuJpUh6x60MqwE=;
        b=OtL/dE2y989GNUuSZ4R0ozvQPSGrNBbLiegoPsYrMdB1o7JZC0GKokoQcOldCvAhoT
         NRmRM+46IB6Fp9ZmVkIzQs5Eva4Kq2N+qwAGmfx1MkwhzXypvR/7x1uFzfH7Pi6PbVt2
         X0wknTXhISllEHc22p1oVG81Z9mt+1wrJuEFCCbK9VtuZm5wyRwVKDIBBCZtoMeRvpW2
         Cegr7wZxFuaq5aKM6BkJilfNlfFwj3DByS9MxHN/nSt8zPkHYSbZGMOvOIs1z9ZARU3u
         psz+xQ1MLULZH6mvSBfM7ZDnErXILh04eKmsJfYNtnRxG8T4zuaH3LWd3PY3BvKsw1A2
         VffQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9BiUYDIrBoBZ8mrqhuiDNdBoJsDe2rf4RV6n9j1gSznejpL+ryBeD+AXtaoB5AF3kdgpN4ZvjML/wVlw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kHikQR6jEVYq3EstuiB1UFeHGxfsesVuqQ3LeDyyGMeQGgkqtw
	B5kPHxXmn3CWQQ34sktpcafQGQI2CJ2Nx3XEAvyt1RBMsWi7yazjR7OE
X-Gm-Gg: AYBFou22GSRKXcO7P0WG1FkBosqrTvCuPk9frSXkkWbecisxNhrF4BWn0Ur1mq4WbIY
	9KuHgsUxyaJdLRtHP9aPcmTUSxH6bK97yofpgD1c+FcgsDY1BvP4a2OJTvlg6q5eYzW3tVRMCqw
	Izy7MoIszEUWKFd06KLeJPiyGksudLs08CnTPF+LaixEvYV00AqlZK/r9xDmEPzKMF5jSgPjLo7
	dfpk0QtBbvMiiO8h+PktP50weJh6apskkkC9Yf3+H0qKsKbaJcG5GGn5oAC5VAN7EaLaLOD6qL4
	WdkQUsgEghh4OW3RFvbqb5S7jZbNn3h+ZgTOR1/PJisMAA0w2ZKDv3IRgyeVKCYZi0wzz5isKOy
	DtQr6Bg30Y8FLHfvI3uUeZYLHBu/+FANKSs2kp50HDL1miZhEg2XIaym1dv8JKmDKjCiBGXA6s9
	QOJUPiNpQDnTsqq49Y5N3k80brUfEwYMa5+xA46gr2z2H6mgSceKlFTS+xdLG/B/Zy9pvptVFdw
	AQTCwCJXUF/uGmaEG8SGA==
X-Received: by 2002:a17:902:d483:b0:2dd:c053:c20b with SMTP id d9443c01a7336-2df69ddf0cbmr15391165ad.39.1790144977728;
        Tue, 22 Sep 2026 23:29:37 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:37 -0700 (PDT)
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
Subject: [PATCH v9 10/10] mm/vmalloc: align vm_area so vmap() can batch mappings
Date: Wed, 23 Sep 2026 14:28:32 +0800
Message-Id: <20260923062832.479455-11-jiangwen6@xiaomi.com>
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
index 37cddb7f45a4f..1a3b191885024 100644
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


