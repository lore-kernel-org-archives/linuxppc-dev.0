Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C182CC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:09:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BD660F41
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15BD660F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZRBm5bWKz3d7t
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 18:09:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZR9J1bmGz3cnT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 18:07:48 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZR1q3JLXzYcwd;
 Wed, 28 Jul 2021 16:01:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:15 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:14 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
 <ast@kernel.org>, <ryabinin.a.a@gmail.com>
Subject: [PATCH v2 7/7] powerpc/mm: Use is_kernel_text() and
 is_kernel_inittext() helper
Date: Wed, 28 Jul 2021 16:13:20 +0800
Message-ID: <20210728081320.20394-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use is_kernel_text() and is_kernel_inittext() helper to simplify code,
also drop etext, _stext, _sinittext, _einittext declaration which
already declared in section.h.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/pgtable_32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index dcf5ecca19d9..13c798308c2e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -33,8 +33,6 @@
 
 #include <mm/mmu_decl.h>
 
-extern char etext[], _stext[], _sinittext[], _einittext[];
-
 static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
 
 notrace void __init early_ioremap_init(void)
@@ -104,14 +102,13 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 {
 	unsigned long v, s;
 	phys_addr_t p;
-	int ktext;
+	bool ktext;
 
 	s = offset;
 	v = PAGE_OFFSET + s;
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
-		ktext = ((char *)v >= _stext && (char *)v < etext) ||
-			((char *)v >= _sinittext && (char *)v < _einittext);
+		ktext = (is_kernel_text(v) || is_kernel_inittext(v));
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
-- 
2.26.2

