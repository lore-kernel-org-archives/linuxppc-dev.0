Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F4CC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17DC60BD3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A17DC60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZR9S1LZZz3dDc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 18:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZR8h5HsTz308Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 18:07:16 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZR4Z5S8jzcjVG;
 Wed, 28 Jul 2021 16:03:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:11 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:10 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
 <ast@kernel.org>, <ryabinin.a.a@gmail.com>
Subject: [PATCH v2 1/7] kallsyms: Remove arch specific text and data check
Date: Wed, 28 Jul 2021 16:13:14 +0800
Message-ID: <20210728081320.20394-2-wangkefeng.wang@huawei.com>
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

After commit 4ba66a976072 ("arch: remove blackfin port"),
no need arch-specific text/data check.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 16 ----------------
 include/linux/kallsyms.h       |  3 +--
 kernel/locking/lockdep.c       |  3 ---
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..817309e289db 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -64,22 +64,6 @@ extern __visible const void __nosave_begin, __nosave_end;
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
 #endif
 
-/* random extra sections (if any).  Override
- * in asm/sections.h */
-#ifndef arch_is_kernel_text
-static inline int arch_is_kernel_text(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
-#ifndef arch_is_kernel_data
-static inline int arch_is_kernel_data(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
 /*
  * Check if an address is part of freed initmem. This is needed on architectures
  * with virt == phys kernel mapping, for code that wants to check if an address
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 6851c2313cad..2a241e3f063f 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -34,8 +34,7 @@ static inline int is_kernel_inittext(unsigned long addr)
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) ||
-	    arch_is_kernel_text(addr))
+	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..64b17e995108 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -803,9 +803,6 @@ static int static_obj(const void *obj)
 	if ((addr >= start) && (addr < end))
 		return 1;
 
-	if (arch_is_kernel_data(addr))
-		return 1;
-
 	/*
 	 * in-kernel percpu var?
 	 */
-- 
2.26.2

