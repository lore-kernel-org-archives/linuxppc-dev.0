Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A03AC4320A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7454960BD3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 08:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7454960BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZRC61JgQz3dtw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 18:09:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZR9L5brLz3cnM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 18:07:50 +1000 (AEST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZR4h5hQCzZtpq;
 Wed, 28 Jul 2021 16:03:48 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:12 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:11 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
 <ast@kernel.org>, <ryabinin.a.a@gmail.com>
Subject: [PATCH v2 3/7] sections: Move and rename core_kernel_data() to
 is_kernel_core_data()
Date: Wed, 28 Jul 2021 16:13:16 +0800
Message-ID: <20210728081320.20394-4-wangkefeng.wang@huawei.com>
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

Move core_kernel_data() into sections.h and rename it to
is_kernel_core_data(), also make it return bool value, then
update all the callers.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 14 ++++++++++++++
 include/linux/kernel.h         |  1 -
 kernel/extable.c               | 18 ------------------
 kernel/trace/ftrace.c          |  2 +-
 net/sysctl_net.c               |  2 +-
 5 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 817309e289db..26ed9fc9b4e3 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -142,6 +142,20 @@ static inline bool init_section_intersects(void *virt, size_t size)
 	return memory_intersects(__init_begin, __init_end, virt, size);
 }
 
+/**
+ * is_kernel_core_data - checks if the pointer address is located in the
+ *			 .data section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .data, false otherwise.
+ */
+static inline bool is_kernel_core_data(unsigned long addr)
+{
+	return addr >= (unsigned long)_sdata &&
+	       addr < (unsigned long)_edata;
+}
+
 /**
  * is_kernel_rodata - checks if the pointer address is located in the
  *                    .rodata section
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1b2f0a7e00d6..0622418bafbc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -230,7 +230,6 @@ extern char *next_arg(char *args, char **param, char **val);
 
 extern int core_kernel_text(unsigned long addr);
 extern int init_kernel_text(unsigned long addr);
-extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
diff --git a/kernel/extable.c b/kernel/extable.c
index b0ea5eb0c3b4..da26203841d4 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -82,24 +82,6 @@ int notrace core_kernel_text(unsigned long addr)
 	return 0;
 }
 
-/**
- * core_kernel_data - tell if addr points to kernel data
- * @addr: address to test
- *
- * Returns true if @addr passed in is from the core kernel data
- * section.
- *
- * Note: On some archs it may return true for core RODATA, and false
- *  for others. But will always be true for core RW data.
- */
-int core_kernel_data(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sdata &&
-	    addr < (unsigned long)_edata)
-		return 1;
-	return 0;
-}
-
 int __kernel_text_address(unsigned long addr)
 {
 	if (kernel_text_address(addr))
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6fb3e6e1ffc..d01ca1cb2d5f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -323,7 +323,7 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	if (!ftrace_enabled && (ops->flags & FTRACE_OPS_FL_PERMANENT))
 		return -EBUSY;
 
-	if (!core_kernel_data((unsigned long)ops))
+	if (!is_kernel_core_data((unsigned long)ops))
 		ops->flags |= FTRACE_OPS_FL_DYNAMIC;
 
 	add_ftrace_ops(&ftrace_ops_list, ops);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index f6cb0d4d114c..4b45ed631eb8 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -144,7 +144,7 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 		addr = (unsigned long)ent->data;
 		if (is_module_address(addr))
 			where = "module";
-		else if (core_kernel_data(addr))
+		else if (is_kernel_core_data(addr))
 			where = "kernel";
 		else
 			continue;
-- 
2.26.2

