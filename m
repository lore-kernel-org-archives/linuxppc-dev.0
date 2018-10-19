Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82CFECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:27:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D55F21470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42btDX5VDzzDqCh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:27:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bt825Q7DzF3Vg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:23:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bt823frMz9sCm; Fri, 19 Oct 2018 15:23:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bt82305cz9sD9; Fri, 19 Oct 2018 15:23:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/time: Fix clockevent_decrementer initalisation for PR
 KVM
Date: Fri, 19 Oct 2018 15:23:19 +1100
Message-Id: <20181019042319.9457-1-mpe@ellerman.id.au>
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
Cc: paulus@samba.org, anton@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In the recent commit 8b78fdb045de ("powerpc/time: Use
clockevents_register_device(), fixing an issue with large
decrementer") we changed the way we initialise the decrementer
clockevent(s).

We no longer initialise the mult & shift values of
decrementer_clockevent itself.

This has the effect of breaking PR KVM, because it uses those values
in kvmppc_emulate_dec(). The symptom is guest kernels spin forever
mid-way through boot.

For now fix it by assigning back to decrementer_clockevent the mult
and shift values.

Fixes: 8b78fdb045de ("powerpc/time: Use clockevents_register_device(), fixing an issue with large decrementer")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 40868f3ee113..68e8f963d108 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -989,6 +989,10 @@ static void register_decrementer_clockevent(int cpu)
 
 	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
 		    dec->name, dec->mult, dec->shift, cpu);
+
+	/* Set values for KVM, see kvm_emulate_dec() */
+	decrementer_clockevent.mult = dec->mult;
+	decrementer_clockevent.shift = dec->shift;
 }
 
 static void enable_large_decrementer(void)
-- 
2.17.2

