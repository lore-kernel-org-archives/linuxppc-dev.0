Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D063C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:26:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EB420840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EB420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FqZf3hjQzDq9s
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 12:26:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FqMt4R5ZzDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 12:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44FqMt26Bxz9ryj; Fri,  8 Mar 2019 12:16:42 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44FqMt0Q9nz9s9h; Fri,  8 Mar 2019 12:16:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 06/10] powerpc/64: Setup KUP on secondary CPUs
Date: Fri,  8 Mar 2019 12:16:15 +1100
Message-Id: <20190308011619.22402-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308011619.22402-1-mpe@ellerman.id.au>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Russell Currey <ruscur@russell.cc>

Some platforms (i.e. Radix MMU) need per-CPU initialisation for KUP.

Any platforms that only want to do KUP initialisation once
globally can just check to see if they're running on the boot CPU, or
check if whatever setup they need has already been performed.

Note that this is only for 64-bit.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v5: Unchanged.

 arch/powerpc/kernel/setup_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 47ffa0885081..72358a5022fe 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -390,6 +390,9 @@ void early_setup_secondary(void)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
 
+	/* Perform any KUP setup that is per-cpu */
+	setup_kup();
+
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
-- 
2.20.1

