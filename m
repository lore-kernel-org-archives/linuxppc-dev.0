Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD1C21007D6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 18:01:40 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7581YK3028115
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 03:01:34 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix compile error in mpc85xx_mds.c
Date: Thu,  5 Aug 2010 03:01:33 -0500
Message-Id: <1280995293-6445-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function 'mpc85xx_mds_setup_arch':
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: 'np' undeclared (first use in this function)
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: (Each undeclared identifier is reported only once
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: for each function it appears in.)

Some code cleaned dropped need decleration of 'np'.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c8be7b5..ebd2b2f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -357,6 +357,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct pci_controller *hose;
+	struct device_node *np = NULL;
 #endif
 	dma_addr_t max = 0xffffffff;
 
-- 
1.6.0.6
