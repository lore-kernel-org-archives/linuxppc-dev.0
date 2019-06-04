Return-Path: <SRS0=V6lO=UD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0075C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 03:09:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4702D2608F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="YefQKOZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4702D2608F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Hxjl2wX0zDqcw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 13:09:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Hxdr0kmRzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 13:06:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="YefQKOZU"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 45Hxdm5hJRz9s3l;
 Tue,  4 Jun 2019 13:06:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1559617580;
 bh=E7lcWW3aV8S6bVg3YGZI00UEKcNXL8qyHfOaUm1DPqA=;
 h=From:To:Cc:Subject:Date:From;
 b=YefQKOZUSqgfnqJVjV4rc/ifx7kX+5fc2Mdo5omAwa8OzzShT4obiI46z6hy122o6
 TeFMbe+6xcf7MIHWq5X/52uqOVPLLW5V0q7/wUFR3ZLFuVB+yvzoVywuGzTghDu/LY
 IGL1diy0CTpZXiNVf7TF8JULYSUdUBNzmek/IMiVcPUEbNBDYdapxk7z/pSkMjnQTD
 JdCc1x/locYSAIr6QzYxen+X/ph8mmoxdGrfbJDBUJNliVOLZdsOnF9IPWSlzibiW3
 VJip0TNdhu3ZtzFGG+6gzwNRDL4ZgU9/eLGAJVErsTbA0VNRY13hQZlU4U4NKJZftz
 H0teW+18Gf2TA==
Received: by neuling.org (Postfix, from userid 1000)
 id E565B2A0AA9; Tue,  4 Jun 2019 13:00:38 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Subject: [PATCH v5 1/2] powerpc: silence a -Wcast-function-type warning in
 dawr_write_file_bool
Date: Tue,  4 Jun 2019 13:00:36 +1000
Message-Id: <20190604030037.9424-1-mikey@neuling.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Mathieu Malaterre <malat@debian.org>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, hch@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mathieu Malaterre <malat@debian.org>

In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
option") the following piece of code was added:

   smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);

Since GCC 8 this triggers the following warning about incompatible
function types:

  arch/powerpc/kernel/hw_breakpoint.c:408:21: error: cast between incompatible function types from 'int (*)(struct arch_hw_breakpoint *)' to 'void (*)(void *)' [-Werror=cast-function-type]

Since the warning is there for a reason, and should not be hidden behind
a cast, provide an intermediate callback function to avoid the warning.

Fixes: c1fe190c0672 ("powerpc: Add force enable of DAWR on P9 option")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index da307dd93e..ca3a2358b7 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -384,6 +384,11 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
+static void set_dawr_cb(void *info)
+{
+	set_dawr(info);
+}
+
 static ssize_t dawr_write_file_bool(struct file *file,
 				    const char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -403,7 +408,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+		smp_call_function(set_dawr_cb, &null_brk, 0);
 
 	return rc;
 }
-- 
2.21.0

