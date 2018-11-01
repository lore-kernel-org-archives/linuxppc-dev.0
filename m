Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 05:22:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A50520820
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 05:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A50520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ltrZ4kXTzF3Mc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 16:22:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ltpW5HvQzF3H8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 16:21:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42ltpW4lvWz9sPg; Thu,  1 Nov 2018 16:21:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42ltpW4VNyz9sPh; Thu,  1 Nov 2018 16:21:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm/64s: Fix preempt warning in slb_allocate_kernel()
Date: Thu,  1 Nov 2018 16:21:05 +1100
Message-Id: <20181101052105.17973-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With preempt enabled we see warnings in do_slb_fault():

  BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u33:0/98
  futex hash table entries: 4096 (order: 3, 524288 bytes)
  caller is do_slb_fault+0x204/0x230
  CPU: 5 PID: 98 Comm: kworker/u33:0 Not tainted 4.19.0-rc3-gcc-7.3.1-00022-g1936f094e164 #138
  Call Trace:
    dump_stack+0xb4/0x104 (unreliable)
    check_preemption_disabled+0x148/0x150
    do_slb_fault+0x204/0x230
    data_access_slb_common+0x138/0x180

This is caused by the get_paca() in slb_allocate_kernel(), which
includes a call to debug_smp_processor_id().

slb_allocate_kernel() can only be called from do_slb_fault(), and in
that path interrupts are hard disabled and so we can't be preempted,
but we can't update the preempt flags (in thread_info) because that
could cause an SLB fault.

So just use local_paca which is safe and doesn't cause the warning.

Fixes: 48e7b7695745 ("powerpc/64s/hash: Convert SLB miss handlers to C")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index c3fdf2969d9f..2f5c0a10fac1 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -715,7 +715,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 			return -EFAULT;
 
 		if (ea < H_VMALLOC_END)
-			flags = get_paca()->vmalloc_sllp;
+			flags = local_paca->vmalloc_sllp;
 		else
 			flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
 	} else {
-- 
2.17.2

