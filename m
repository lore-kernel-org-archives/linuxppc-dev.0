Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC1C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:07:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5217220651
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5217220651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yrbb70ZDzDqRb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 23:07:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YrYF4ntqzDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43YrYF255Dz9sMM; Tue,  8 Jan 2019 23:05:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43YrYF0B3Tz9sMQ; Tue,  8 Jan 2019 23:05:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Use seq_buf to avoid pr_cont() in __die()
Date: Tue,  8 Jan 2019 23:04:59 +1100
Message-Id: <20190108120500.2547-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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

Using pr_cont() risks having our output interleaved with other output
from other CPUs. Instead use a seq_buf to construct the line and then
print it as a whole.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 64936b60d521..431a86d3f772 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -38,6 +38,7 @@
 #include <linux/kdebug.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
+#include <linux/seq_buf.h>
 #include <linux/smp.h>
 #include <linux/console.h>
 #include <linux/kmsg_dump.h>
@@ -255,26 +256,34 @@ NOKPROBE_SYMBOL(oops_end);
 
 static int __die(const char *str, struct pt_regs *regs, long err)
 {
+	char buf[128]; /* enough for all flags and a long platform name */
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, sizeof(buf));
+
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
 	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
-		printk("LE ");
+		seq_buf_puts(&s, "LE ");
 	else
-		printk("BE ");
+		seq_buf_puts(&s, "BE ");
 
 	if (IS_ENABLED(CONFIG_PREEMPT))
-		pr_cont("PREEMPT ");
+		seq_buf_puts(&s, "PREEMPT ");
 
 	if (IS_ENABLED(CONFIG_SMP))
-		pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
+		seq_buf_printf(&s, "SMP NR_CPUS=%d ", NR_CPUS);
 
 	if (debug_pagealloc_enabled())
-		pr_cont("DEBUG_PAGEALLOC ");
+		seq_buf_puts(&s, "DEBUG_PAGEALLOC ");
 
 	if (IS_ENABLED(CONFIG_NUMA))
-		pr_cont("NUMA ");
+		seq_buf_puts(&s, "NUMA ");
+
+	if (ppc_md.name)
+		seq_buf_puts(&s, ppc_md.name);
 
-	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
+	printk("%s\n", buf);
 
 	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
 		return 1;
-- 
2.20.1

