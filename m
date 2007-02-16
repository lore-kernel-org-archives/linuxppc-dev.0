Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8914DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 09:17:44 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1HIBOf-0005TC-3B
	for linuxppc-dev@ozlabs.org; Fri, 16 Feb 2007 16:17:41 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add missing of_node_put() in mpc86xx_hpcn_init_irq().
Date: Fri, 16 Feb 2007 16:17:41 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HIBOf-0005TC-3B@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 030f9b2..f42f801 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -119,6 +119,8 @@ mpc86xx_hpcn_init_irq(void)
 	DBG("mpc86xxhpcn: cascade mapped to irq %d\n", cascade_irq);
 
 	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
 	set_irq_chained_handler(cascade_irq, mpc86xx_8259_cascade);
 #endif
 }
-- 
1.5.0.rc3.ge4b0e
