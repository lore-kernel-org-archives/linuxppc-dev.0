Return-Path: <linuxppc-dev+bounces-27551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7167C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:42:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4m71l8z30TP;
	Thu, 17 Sep 2026 15:42:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623053;
	cv=none; b=Z/gkSa1TgU7iIF4O4DHg8G9XljWnHllhZwjvzR+Ld4RN9MqXRaxXGJkm+H3ONOsh/qcB2PjGuR8vb/GcPXAT7eyYG22MQ8iS7sl1ZS1/NrwQFfx9O98GsUoGKxBXsrzvOzcaB8wY3oWPJnd9erEYo1UR9SBqz3DJV7KD9FF+e8+MvZTz5nXJm3nTWw386TbpQMfJI+Z17+SA9HrPSa5itkbq76dLqZtiK9DjmAcEp3mq2d6GZnESZ60kEcdegq0DcArrDH3wn8MT5zw1db7HZMoVzc2F/JzfdXAUWzwR06LseaR0rzbnl6LwTGvDxO5eAQ+EzBalsePuo2HVJe9zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623053; c=relaxed/relaxed;
	bh=/8rYVhg/v6BbsXS7Hdm4I0mlpI54bk8irnJCIlnxFJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcsPALaJ56v7F02mn6f7DTw47xOpyQpDARyt4ERVuPzPzbJ9cSCELYpnESwViE72LELKrkHdXpA2lqbBYT9jwVfQWG4AWRW4aspacBT/W1jK6dUIn0FL/B9H0UvABRnQBHddBj/iuzmwji3wpSwBHib/ZOOSaLQA0ANLkZo4RbeFw413NOS4o96HJnO0NAhW43kuxi+yli41RFIUvv79XW6tWizIAOScrnfAkguA22hSJI/NDED1sa+x396wzCeFaZXDMg63YKA+IHHY0csvVLqX6lGUjknp8y3WIpTlOLZZVDMBpY5o5IgW2TcocFFxpuLKmtHSGglx+DqH/a3zNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoMB58vH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OoMB58vH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com [IPv6:2607:f8b0:4864:3b::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqx0K5kz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:53 +1000 (AEST)
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so457549a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623051; x=1790227851; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8rYVhg/v6BbsXS7Hdm4I0mlpI54bk8irnJCIlnxFJI=;
        b=OoMB58vHSb4KnxhZ7yqdyqNQDTxaq1cgq+0Y3qDJDf7WAwHeYibtxGaLU+7f6nCODT
         mIwbc6VKMn11sxXYmAzFFXy7PHm2CzKDksqWbf/v0zP7OWFML0Cc1OeA64J1qcslUzhL
         +3JkCHq6Epbg/NNDW83Zx6LaAHzGDQtv2hspgMD9GlV+1Ocb90wz3qlHPHojLKPTeDOy
         T1kOcSronsqYf3w32HMoTKg48YA14fN6Ao81lP7ROY7aACE8ORPJYg1c04/mrnT7K3sb
         2s1B7bndkLTUE1TAnbcnfC23IxL/TuRKQk19ZOsbG2UvF/0amgDFGH4lOtuE6xWes7tS
         8u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623051; x=1790227851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8rYVhg/v6BbsXS7Hdm4I0mlpI54bk8irnJCIlnxFJI=;
        b=OkWoM3DjTNJLp/0tq0DArWqqdAN6ghv3WN98wOsWR4GlF8NVlfDouKlo4MOGtlqnd/
         i36QRXOfa3YgE8UT+8dQykBWpznUZqWKU2zO+1ClEJ20y8z3NuzZejhtZNgT5E4tEN1E
         Es2spZTpSNCGr3lN6J47LUhhVtQcX1nz/c+2HRPjszDkkR3QObaU88//qTD0x/6tv0ZT
         HocCm+aqJNnTpzsWATNuRb+pBW40ph0QjQ3afEkAH6nSC7LVy1Zy20bdjA4xh8rSUuuH
         1rfA4KDSxH1GvavK5ZXQK6UUlzEX5rbZQPit5E5SDYxhbbyvfHeF2xNaKpHMrkSjxJ9h
         vlWw==
X-Forwarded-Encrypted: i=1; AKwUvBxCewRxDaDCjRWTEBpKy6UAbqjkyZFzaHGDHB4gIAyc3itFGqhEFl9xVO17TjXbbZZxac4Ls5OaxoMhOqE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mhUMNpW3dlh7Pjtl0OAezcFzNYxN3GNdoZ2h8AFF1uyvhBAs9u
	oXDchBRjrIJHwHpch3jQ1RnB2yFvuiUJT2FMV+OWK8hTbbZaoDslyVtw
X-Gm-Gg: AYBFou0UKIbPcwXtbbQV70CQ37PlmJV03EGlFEeJQz84oKOtmy4MnV3PXVdr/pM8sUt
	lW1QMDGf+crDGUfxtcPPoKAmAa0h8YN+tbV6reGtIrxZxJNXNOmYvbEH0e9PNF73OmfTA92sMoI
	RWr3s3UkvE/MCxV9hnVdl57eC13PI/SvjhqmcbUaPxiIfSAR/4CRgP53ql285wYMLNkln3w7Qth
	A2SJj3cWasbCCA3WCR/bhMJFTh8Ls/N8JMBKNiIRYc+tIQp3kf4qFzcqVe6kkZIiDHuCRkNHLDG
	kQGigDJhiatFcyBBpdl3xa99Ho4lZ56x05A14ozaRmmq1blAk/RW4SOihOFbxhN6TvjF6U3mbnp
	vfhkSEYCVZ/9gprCMghLexxRkT62O1z7tb+lCOZZpdSysDML6rG+aDgA1IpFd2AMhafjWfsf29F
	ESz0SPE4ARqTE776w/+fj8LK4jrm1PRg1TLl1CGQHJyNOeX2LAMFAnFXSj+xht/9v1HZduoWQ10
	EIj7W8Qo8MMltJAEIoXvtmsaprk+2JI0F2bGwM=
X-Received: by 2002:a17:90b:2b4c:b0:39d:f024:c7ec with SMTP id 98e67ed59e1d1-39e1e484b5emr13289860a91.16.1789623051007;
        Wed, 16 Sep 2026 22:30:51 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:50 -0700 (PDT)
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
Subject: [PATCH v8 10/10] mm/vmalloc: align vm_area so vmap() can batch mappings
Date: Thu, 17 Sep 2026 13:29:33 +0800
Message-Id: <20260917052933.188679-11-jiangwenxiaomi@gmail.com>
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
index bce2d2c09f546..84413def1d771 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3306,6 +3306,14 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
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
@@ -3619,6 +3627,30 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
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
@@ -3657,7 +3689,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	size = (unsigned long)count << PAGE_SHIFT;
-	area = get_vm_area_caller(size, flags, __builtin_return_address(0));
+	area = vmap_get_aligned_vm_area(size, flags, prot,
+				__builtin_return_address(0));
 	if (!area)
 		return NULL;
 
-- 
2.34.1


