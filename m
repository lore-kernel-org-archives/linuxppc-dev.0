Return-Path: <linuxppc-dev+bounces-24734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2370C531CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkn6g3gz2yl0;
	Thu, 23 Jul 2026 23:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812369;
	cv=none; b=MLtQA0vbAq2JapM4GUJjk6htyKZoSxwYmT73uZCZi9c7Vu/N2S8cL87/afSR+UMD5rYoTGQMWpMUiaQnXuO2NXGp2UPpLnVe97r4iua7htin9GoVAHLP4jU15N8Ppuej1Na63tH2VHmJXjCT4gZ2xP3lREJprII9ByD37UgfOlyUjrMj+RoJVuWSYrRbHcZ2MvIJxIa+ZOFVE8tgSX1SEkYFmab/WnDA9PSy40oBezyiCX3yz3uA1sQuWkWaoyHs2kah7+apIlsLY4Ncgy4QIeeaxmfkI7rkj9GdxI4CJ32RSXhX7KPeEnm57B6DAQGG41zv8gbyDEM73HVdzlX7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812369; c=relaxed/relaxed;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJGjuxnL/tJPDhOD6GEmSYtgnM+IR2vaWTmpBHQfjIg7dwH9sQZ0saFfpBOIePM7Io9qctM2ZZZzblg+jZz7mrD+O8KwShGCq4fJ4oK8h/0hMcQNgexXVDz9C/2i+D07oyGClu30qa7a6ihUgv/4quZLPhroF68W1oBgSuc3a3toTroth4kQ5eAet6XMtyfJnig2Gm274Q637k2p7t0bDLyRx7nS/qh16eDoCrzZNRLxpNL6qa+1etJw/FGVqe51OUIrefT+1CXCAZRr4gAFKwNmFBQ4ZK4aV+9gsEbDRiEkHa2+EO0mycY0dIOO1uUzJFUFdkVmWvOB//s512CgCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zezNzsem; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zezNzsem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkk15xFz2ygJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:43 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=;
	b=zezNzsembULU7OU1aBZKtmlXYMfqiyhuVd/0EUpFld6FoKfxvHy2SHqOb479kLgfg3L85Cdx8
	mFcP9trpiR6AmY+SzOas+7DcEuqhunASSnlRjjHpU37cVuiHPs/aDYZIE2xooHwPbR2Wc2GwkHB
	XJSpwQlYQPqIbe7aKweQzg0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWc5Fbbzcb2y;
	Thu, 23 Jul 2026 21:03:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 970464057D;
	Thu, 23 Jul 2026 21:12:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 2/8] powerpc/kexec_file: Fix null-ptr-def in extra size calculation
Date: Thu, 23 Jul 2026 21:12:36 +0800
Message-ID: <20260723131242.1537633-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

A static Sashiko AI review identified a potential NULL pointer
dereference in kexec_extra_fdt_size_ppc64().

On platforms without any reserved memory regions,
get_reserved_memory_ranges() can return 0 while leaving 'rmem'
unallocated as NULL. Passing it directly leads to a kernel panic when
evaluating 'rmem->nr_ranges'.

Add a NULL check for 'rmem' to prevent this crash.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 0d3ff067331e ("powerpc/kexec_file: fix extra size calculation for kexec FDT")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..6075b1c88511 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -664,7 +664,7 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image, struct crash_mem *
 		extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
 
 	/* Consider extra space for reserved memory ranges if any */
-	if (rmem->nr_ranges > 0)
+	if (rmem && rmem->nr_ranges > 0)
 		extra_size += sizeof(struct fdt_reserve_entry) * rmem->nr_ranges;
 
 	return extra_size + kdump_extra_fdt_size_ppc64(image, cpu_nodes);
-- 
2.34.1


