Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Sep 2021 07:38:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9E961039
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Sep 2021 07:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D9E961039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HHHgh2RZxz3c8S
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Sep 2021 17:38:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HHHfj2NYzz2yQ6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Sep 2021 17:37:31 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HHHBw3bBRz1DHCy;
 Sun, 26 Sep 2021 15:16:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:11 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:10 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
 <ast@kernel.org>, <ryabinin.a.a@gmail.com>, <akpm@linux-foundation.org>
Subject: [PATCH v3 6/9] sections: Provide internal __is_kernel() and
 __is_kernel_text() helper
Date: Sun, 26 Sep 2021 15:20:45 +0800
Message-ID: <20210926072048.190336-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
References: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
Cc: bpf@vger.kernel.org, paulus@samba.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

An internal __is_kernel() helper which only check the kernel address ranges,
and an internal __is_kernel_text() helper which only check text section ranges.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 29 +++++++++++++++++++++++++++++
 include/linux/kallsyms.h       |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 811583ca8bd0..a7abeadddc7a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -186,4 +186,33 @@ static inline bool is_kernel_inittext(unsigned long addr)
 	       addr < (unsigned long)_einittext;
 }
 
+/**
+ * __is_kernel_text - checks if the pointer address is located in the
+ *                    .text section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .text, false otherwise.
+ * Note: an internal helper, only check the range of _stext to _etext.
+ */
+static inline bool __is_kernel_text(unsigned long addr)
+{
+	return addr >= (unsigned long)_stext &&
+	       addr < (unsigned long)_etext;
+}
+
+/**
+ * __is_kernel - checks if the pointer address is located in the kernel range
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in the kernel range, false otherwise.
+ * Note: an internal helper, only check the range of _stext to _end.
+ */
+static inline bool __is_kernel(unsigned long addr)
+{
+	return addr >= (unsigned long)_stext &&
+	       addr < (unsigned long)_end;
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 8a9d329c927c..5fb17dd4b6fa 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -26,14 +26,14 @@ struct module;
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
+	if (__is_kernel_text(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
 static inline int is_kernel(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
+	if (__is_kernel(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
-- 
2.26.2

