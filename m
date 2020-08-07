Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0895C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:18:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1B720866
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1B720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNSC64K9DzDqCW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 00:18:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=chenzefeng2@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNMG34wmtzDqdl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2020 20:35:52 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4114BBCFA8119EC0047F;
 Fri,  7 Aug 2020 18:20:04 +0800 (CST)
Received: from linux_supse12sp4_workstation.huawei.com (10.67.189.177) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 7 Aug 2020 18:19:56 +0800
From: chenzefeng <chenzefeng2@huawei.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <christophe.leroy@c-s.fr>, <tglx@linutronix.de>, <chenzefeng2@huawei.com>,
 <bigeasy@linutronix.de>, <npiggin@gmail.com>
Subject: [PATCH] powerpc:entry_32: correct the path and function name in the
 comment
Date: Fri, 7 Aug 2020 18:19:56 +0800
Message-ID: <20200807101956.67454-1-chenzefeng2@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.177]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 08 Aug 2020 00:07:55 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 zengweilin@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Update the comment for file's directory and function name changed.

Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8420abd4ea1c..9937593d3a33 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -696,8 +696,8 @@ handle_dabr_fault:
  * to the "_switch" path.  If you change this , you'll have to
  * change the fork code also.
  *
- * The code which creates the new task context is in 'copy_thread'
- * in arch/ppc/kernel/process.c
+ * The code which creates the new task context is in 'copy_thread_tls'
+ * in arch/powerpc/kernel/process.c
  */
 _GLOBAL(_switch)
 	stwu	r1,-INT_FRAME_SIZE(r1)
-- 
2.12.3

