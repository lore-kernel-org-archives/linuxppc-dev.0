Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 723D12C02C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 18:47:53 +1000 (EST)
Received: from mail188-co1 (localhost [127.0.0.1])	by
 mail188-co1-R.bigfish.com (Postfix) with ESMTP id D56393C0248	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 08:45:33 +0000 (UTC)
Received: from CO1EHSMHS025.bigfish.com (unknown [10.243.78.249])	by
 mail188-co1.bigfish.com (Postfix) with ESMTP id 9BA2A4C0044	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 08:45:31 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q698li8I012272	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 01:47:44 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3 v2] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL
 MPIC.
Date: Mon, 9 Jul 2012 14:16:35 +0530
Message-ID: <1341823595-15696-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should use the MPIC_LARG_VECTORS flag while intializing the MPIC. 
This prevents us from eating in to hardware vector number space (MSIs)
while setting up internal sources.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index a98eb77..61c7225 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1211,7 +1211,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	if (of_get_property(node, "single-cpu-affinity", NULL))
 		flags |= MPIC_SINGLE_DEST_CPU;
 	if (of_device_is_compatible(node, "fsl,mpic"))
-		flags |= MPIC_FSL;
+		flags |= MPIC_FSL | MPIC_LARGE_VECTORS;
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
-- 
1.7.2.2
