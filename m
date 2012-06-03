Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FCF9B703A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 17:43:31 +1000 (EST)
Received: from mail76-va3 (localhost [127.0.0.1])	by mail76-va3-R.bigfish.com
 (Postfix) with ESMTP id 4EA5920031C	for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2012 07:42:50 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.240])	by
 mail76-va3.bigfish.com (Postfix) with ESMTP id 7F6DC10008B	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 07:42:48 +0000 (UTC)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3 v2] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL
 MPIC.
Date: Sun, 3 Jun 2012 13:13:20 +0530
Message-ID: <1338709400-31191-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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
