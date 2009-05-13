Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CAD1CDE015
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:05:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4DM4veC023867
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 17:05:03 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl_rio: Fix compile warnings
Date: Wed, 13 May 2009 17:04:57 -0500
Message-Id: <1242252297-22206-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We we build with resource_size_t as a 64-bit quantity we get:

arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_setup':
arch/powerpc/sysdev/fsl_rio.c:1029: warning: format '%08x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'
arch/powerpc/sysdev/fsl_rio.c:1029: warning: format '%08x' expects type 'unsigned int', but argument 5 has type 'resource_size_t'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_rio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index abdb124..c5aa179 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1026,8 +1026,7 @@ int fsl_rio_setup(struct of_device *dev)
 		return -EFAULT;
 	}
 	dev_info(&dev->dev, "Of-device full name %s\n", dev->node->full_name);
-	dev_info(&dev->dev, "Regs start 0x%08x size 0x%08x\n",	regs.start,
-						regs.end - regs.start + 1);
+	dev_info(&dev->dev, "Regs: %pR\n", &regs);
 
 	dt_range = of_get_property(dev->node, "ranges", &rlen);
 	if (!dt_range) {
-- 
1.6.0.6
