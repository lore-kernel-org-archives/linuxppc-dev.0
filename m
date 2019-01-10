Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87305C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:04:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C1D214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C1D214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b4S26npYzDqdm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:04:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b4Hs6vqYzDqdR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 22:57:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43b4Hs50lkz9sLt; Thu, 10 Jan 2019 22:57:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43b4Hs3nkMz9sN8; Thu, 10 Jan 2019 22:57:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/3] powerpc/64s: Add MMU type to __die() output
Date: Thu, 10 Jan 2019 22:57:37 +1100
Message-Id: <20190110115737.30931-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110115737.30931-1-mpe@ellerman.id.au>
References: <20190110115737.30931-1-mpe@ellerman.id.au>
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

On Power9 machines (64-bit Book3S), we can be running with either the
Hash table or Radix tree MMU enabled. So add some text to the __die()
output to tell us which is enabled, for the case where all you have is
the oops output and no other information.

Example output:

  kernel BUG at drivers/misc/lkdtm/bugs.c:63!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: kvm vmx_crypto binfmt_misc ip_tables x_tables

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2: New.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a872c64618ad..5e917a84f949 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -257,9 +257,11 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024,
+	       early_radix_enabled() ? " MMU=Radix" : "",
+	       early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ? " MMU=Hash" : "",
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
-- 
2.20.1

