Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC539C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 12:27:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B2D20850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 12:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B2D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4466sg5mBLzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 23:27:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4466pj52KZzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 23:24:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4466pj1zckz9s9T; Sat, 23 Feb 2019 23:24:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4466pj1T1Fz9s9y; Sat, 23 Feb 2019 23:24:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Simplify __secondary_start paca->kstack handling
Date: Sat, 23 Feb 2019 23:24:39 +1100
Message-Id: <20190223122439.24020-1-mpe@ellerman.id.au>
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
Cc: paulus@samba.org, matt@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In __secondary_start() we load the thread_info of the idle task of the
secondary CPU from current_set[cpu], and then convert it into a stack
pointer before storing that back to paca->kstack.

As pointed out in commit f761622e5943 ("powerpc: Initialise
paca->kstack before early_setup_secondary") it's important that we
initialise paca->kstack before calling the MMU setup code, in
particular slb_initialize(), because it will bolt the SLB entry for
the kstack into the SLB.

However we have already setup paca->kstack in cpu_idle_thread_init(),
since commit 3b5750644b2f ("[POWERPC] Bolt in SLB entry for kernel
stack on secondary cpus") (May 2008).

It's also in cpu_idle_thread_init() that we initialise current_set[cpu]
with the thread_info pointer, so there is no issue of the timing being
different between the two.

Therefore the initialisation of paca->kstack in __setup_secondary() is
completely redundant, so remove it.

This has the added benefit of removing code that runs in real mode,
and is therefore restricted by the RMO, and so opens the way for us to
enable THREAD_INFO_IN_TASK.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/head_64.S | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1c..3fad8d499767 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -801,21 +801,19 @@ _GLOBAL(pmac_secondary_start)
 	/* Set thread priority to MEDIUM */
 	HMT_MEDIUM
 
-	/* Initialize the kernel stack */
-	LOAD_REG_ADDR(r3, current_set)
-	sldi	r28,r24,3		/* get current_set[cpu#]	 */
-	ldx	r14,r3,r28
-	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
-	std	r14,PACAKSAVE(r13)
-
-	/* Do early setup for that CPU (SLB and hash table pointer) */
+	/*
+	 * Do early setup for this CPU, in particular initialising the MMU so we
+	 * can turn it on below. This is a call to C, which is OK, we're still
+	 * running on the emergency stack.
+	 */
 	bl	early_setup_secondary
 
 	/*
-	 * setup the new stack pointer, but *don't* use this until
-	 * translation is on.
+	 * The primary has initialized our kernel stack for us in the paca, grab
+	 * it and put it in r1. We must *not* use it until we turn on the MMU
+	 * below, because it may not be inside the RMO.
 	 */
-	mr	r1, r14
+	ld	r1, PACAKSAVE(r13)
 
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
-- 
2.20.1

