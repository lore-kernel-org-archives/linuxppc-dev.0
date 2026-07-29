Return-Path: <linuxppc-dev+bounces-24959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16BCC54F52
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 01:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8vrf62tjz2ym1;
	Wed, 29 Jul 2026 11:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785288578;
	cv=none; b=Td144qhDkvqgHOhFA5QCqBPjpNYHyBB1BgBx3ecDoDUyAUoofJST0xIAFGpFo4gEgQNWJq+4AzU/R5Sx/PARb2oOOlxbhD8lQB037aekLmhUSTh7o43I4ltFNgldKZf0jFK/mgQd1Wr5E3gEYAfbC96ws6D7BvE1H5hUUlo6MG/fSYg4z7QWkh9PjFNT4eLFRMyG7V1O6usaI0XZ4pfP1x+DweV35PFrkQKMQKUa4wF7uQe6csiYHZ3ZaqaEK9D29i+7bVYt6qz0yMQcYigl2goGRscc81g7MeE6leHMjEW1f7zS9pp3AtQjA8OZhawmCbhqaOssPsJvqfdA2I0KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785288578; c=relaxed/relaxed;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqDM6N6XS55O3Hy7U1ivJ4Z0kIhFd+hdUrcL0wj81GkxXR2mr9RT2f80NXdJFjfzGJ23yLWzNq9ywv7FQ/Xcw65bSvYrlDQIU/1Ir+CGnTRfR17S0VJlKvH/HGLVMkbGTtJCIraL9o4db7yecRbw1pPr/XN3Wz7SJUudgz5wxpp3j5tqg0yx2KMzJXoZTvgwCwtBLz8uCe7txpEgFhjp/palwlPN9jbP/6lGWvPuUzy5fm9mWJxrujLRKOAjX7bkBZ9RlM/lo2J3npEPpnkSDbJAkNLt88RPGDqW81b2CxY9s8aIB00v2EPGAQTPVi2N9ywXPyXi3XLcDQ2ndGjKzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zezNzsem; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zezNzsem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8vrd27mDz2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:29:36 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=;
	b=zezNzsembULU7OU1aBZKtmlXYMfqiyhuVd/0EUpFld6FoKfxvHy2SHqOb479kLgfg3L85Cdx8
	mFcP9trpiR6AmY+SzOas+7DcEuqhunASSnlRjjHpU37cVuiHPs/aDYZIE2xooHwPbR2Wc2GwkHB
	XJSpwQlYQPqIbe7aKweQzg0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h8vdb0LJpz1cyVy;
	Wed, 29 Jul 2026 09:20:03 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AEED4056C;
	Wed, 29 Jul 2026 09:29:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 09:29:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <sourabhjain@linux.ibm.com>, <rppt@kernel.org>,
	<baoquan.he@linux.dev>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ritesh.list@gmail.com>, <bauerman@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/3] powerpc/kexec_file: Fix null-ptr-def in extra size calculation
Date: Wed, 29 Jul 2026 09:29:47 +0800
Message-ID: <20260729012948.2797865-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729012948.2797865-1-ruanjinjie@huawei.com>
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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


