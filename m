Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D4C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 11:56:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzGdJ3Mpkz3bb0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 22:56:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzGcm0pP3z2xtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2022 22:55:47 +1100 (AEDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JzGZZ181wz9sgD;
 Wed, 16 Feb 2022 19:53:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:35 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:35 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <benh@kernel.crashing.or>, <paulus@samba.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
Date: Wed, 16 Feb 2022 20:11:07 +0800
Message-ID: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: akpm@linux-foundation.org, songyuanzheng@huawei.com, npiggin@gmail.com,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts commit 602946ec2f90d5bd965857753880db29d2d9a1e9.

If CONFIG_HIGHMEM enabled, highmem will be disappeared with max_mapnr
set to max_low_pfn, see mem_init(), 

  for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
        ...
	free_highmem_page();
  }

Revert it and will fix virt_addr_valid() check in the next patch.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 602946ec2f90 ("powerpc: Set max_mapnr correctly")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v4:
- new patch
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8e301cd8925b..4d221d033804 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -255,7 +255,7 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	set_max_mapnr(max_low_pfn);
+	set_max_mapnr(max_pfn);
 
 	kasan_late_init();
 
-- 
2.26.2

