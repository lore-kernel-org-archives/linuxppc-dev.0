Return-Path: <SRS0=l0Nn=JE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F7C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 12:51:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F0461279
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 12:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F0461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFklx4S19z3cCc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 22:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yukuai3@huawei.com; receiver=<UNKNOWN>)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFklX1TNCz2xgP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 22:50:48 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkhx59Rnz16J2r;
 Wed,  7 Apr 2021 20:48:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:50:38 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/smp: Make some symbols static
Date: Wed, 7 Apr 2021 20:59:03 +0800
Message-ID: <20210407125903.4139663-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
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
Cc: yukuai3@huawei.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com, yi.zhang@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sparse tool complains as follows:

arch/powerpc/kernel/smp.c:86:1: warning:
 symbol '__pcpu_scope_cpu_coregroup_map' was not declared. Should it be static?
arch/powerpc/kernel/smp.c:125:1: warning:
 symbol '__pcpu_scope_thread_group_l1_cache_map' was not declared. Should it be static?
arch/powerpc/kernel/smp.c:132:1: warning:
 symbol '__pcpu_scope_thread_group_l2_cache_map' was not declared. Should it be static?

These symbols are not used outside of smp.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 arch/powerpc/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5a4d59a1070d..63ccc70bdd0d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -83,7 +83,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
-DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
+static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
@@ -122,14 +122,14 @@ static struct thread_groups_list tgl[NR_CPUS] __initdata;
  * On big-cores system, thread_group_l1_cache_map for each CPU corresponds to
  * the set its siblings that share the L1-cache.
  */
-DEFINE_PER_CPU(cpumask_var_t, thread_group_l1_cache_map);
+static DEFINE_PER_CPU(cpumask_var_t, thread_group_l1_cache_map);
 
 /*
  * On some big-cores system, thread_group_l2_cache_map for each CPU
  * corresponds to the set its siblings within the core that share the
  * L2-cache.
  */
-DEFINE_PER_CPU(cpumask_var_t, thread_group_l2_cache_map);
+static DEFINE_PER_CPU(cpumask_var_t, thread_group_l2_cache_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
-- 
2.25.4

