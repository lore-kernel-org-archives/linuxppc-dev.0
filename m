Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D4C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:01:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7221B20672
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7221B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439RMr0C8QzDr7m
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 18:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439RKL2nRqzDr7K
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 17:59:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 439RKL1zQ4z9s0t; Thu,  6 Dec 2018 17:59:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 439RKL1V7Fz9s3Z; Thu,  6 Dec 2018 17:59:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/ipic: Remove unused ipic_set_priority()
Date: Thu,  6 Dec 2018 17:58:59 +1100
Message-Id: <20181206065859.28244-1-mpe@ellerman.id.au>
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
Cc: dan.carpenter@oracle.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ipic_set_priority() has been unused since 2006 when the last usage was
removed in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
host_ops interface, add set_irq_type to set IRQ sense").

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ipic.h |  1 -
 arch/powerpc/sysdev/ipic.c      | 28 ----------------------------
 2 files changed, 29 deletions(-)

v2: Also remove the declaration, as noticed by Thiago.

diff --git a/arch/powerpc/include/asm/ipic.h b/arch/powerpc/include/asm/ipic.h
index fb59829983b8..3dbd47f2bffe 100644
--- a/arch/powerpc/include/asm/ipic.h
+++ b/arch/powerpc/include/asm/ipic.h
@@ -69,7 +69,6 @@ enum ipic_mcp_irq {
 	IPIC_MCP_MU   = 7,
 };
 
-extern int ipic_set_priority(unsigned int irq, unsigned int priority);
 extern void ipic_set_highest_priority(unsigned int irq);
 extern void ipic_set_default_priority(void);
 extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 6300123ce965..8030a0f55e96 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -771,34 +771,6 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	return ipic;
 }
 
-int ipic_set_priority(unsigned int virq, unsigned int priority)
-{
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp;
-
-	if (priority > 7)
-		return -EINVAL;
-	if (src > 127)
-		return -EINVAL;
-	if (ipic_info[src].prio == 0)
-		return -EINVAL;
-
-	temp = ipic_read(ipic->regs, ipic_info[src].prio);
-
-	if (priority < 4) {
-		temp &= ~(0x7 << (20 + (3 - priority) * 3));
-		temp |= ipic_info[src].prio_mask << (20 + (3 - priority) * 3);
-	} else {
-		temp &= ~(0x7 << (4 + (7 - priority) * 3));
-		temp |= ipic_info[src].prio_mask << (4 + (7 - priority) * 3);
-	}
-
-	ipic_write(ipic->regs, ipic_info[src].prio, temp);
-
-	return 0;
-}
-
 void ipic_set_highest_priority(unsigned int virq)
 {
 	struct ipic *ipic = ipic_from_irq(virq);
-- 
2.17.2

