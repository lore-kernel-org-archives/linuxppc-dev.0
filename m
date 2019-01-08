Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DAC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B1920651
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B1920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YrfB3fvQzDqRx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YrYG0bjNzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43YrYF6gGZz9sMM; Tue,  8 Jan 2019 23:05:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43YrYF5tYyz9sN8; Tue,  8 Jan 2019 23:05:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Show PAGE_SIZE in __die() output
Date: Tue,  8 Jan 2019 23:05:00 +1100
Message-Id: <20190108120500.2547-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108120500.2547-1-mpe@ellerman.id.au>
References: <20190108120500.2547-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The page size the kernel is built with is useful info when debugging a
crash, so add it to the output in __die().

Result looks like eg:

  kernel BUG at drivers/misc/lkdtm/bugs.c:63!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE PAGE_SIZE=64K SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: vmx_crypto kvm binfmt_misc ip_tables

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 431a86d3f772..fc972e4eee5f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -268,6 +268,18 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 	else
 		seq_buf_puts(&s, "BE ");
 
+	seq_buf_puts(&s, "PAGE_SIZE=");
+	if (IS_ENABLED(CONFIG_PPC_4K_PAGES))
+		seq_buf_puts(&s, "4K ");
+	else if (IS_ENABLED(CONFIG_PPC_16K_PAGES))
+		seq_buf_puts(&s, "16K ");
+	else if (IS_ENABLED(CONFIG_PPC_64K_PAGES))
+		seq_buf_puts(&s, "64K ");
+	else if (IS_ENABLED(CONFIG_PPC_256K_PAGES))
+		seq_buf_puts(&s, "256K ");
+	else
+		BUILD_BUG_ON(1);
+
 	if (IS_ENABLED(CONFIG_PREEMPT))
 		seq_buf_puts(&s, "PREEMPT ");
 
-- 
2.20.1

