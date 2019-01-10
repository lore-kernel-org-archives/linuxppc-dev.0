Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75529C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB78214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB78214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b4Kw5BLLzDqfc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 22:59:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b4Hq73N5zDqdR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 22:57:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43b4Hq65bPz9sN4; Thu, 10 Jan 2019 22:57:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43b4Hq5HPnz9sMQ; Thu, 10 Jan 2019 22:57:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/3] powerpc: Stop using pr_cont() in __die()
Date: Thu, 10 Jan 2019 22:57:35 +1100
Message-Id: <20190110115737.30931-1-mpe@ellerman.id.au>
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
from other CPUs. Instead print everything in a single printk() call.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

v2: Use a single printk with (mostly) compile time checks rather than
constructing the string with seq_buf.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 64936b60d521..164fc92895be 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -257,24 +257,14 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
-		printk("LE ");
-	else
-		printk("BE ");
-
-	if (IS_ENABLED(CONFIG_PREEMPT))
-		pr_cont("PREEMPT ");
-
-	if (IS_ENABLED(CONFIG_SMP))
-		pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
-
-	if (debug_pagealloc_enabled())
-		pr_cont("DEBUG_PAGEALLOC ");
-
-	if (IS_ENABLED(CONFIG_NUMA))
-		pr_cont("NUMA ");
-
-	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
+	printk("%s %s%s%s%s%s %s\n",
+	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
+	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
+	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
+	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
+	       IS_ENABLED(CONFIG_NUMA) ? " NUMA" : "",
+	       ppc_md.name ? ppc_md.name : "");
 
 	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
 		return 1;
-- 
2.20.1

