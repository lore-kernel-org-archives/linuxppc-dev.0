Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E53B5DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 12:04:51 +1100 (EST)
Date: Mon, 19 Nov 2007 19:04:43 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: mpc832x mds: Fix board PHY reset code
Message-Id: <20071119190443.7c04ae6b.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Li Yang <leoli@freescale.com>, peter.vanackeren@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

currently the board-level PHY reset code for the mpc832x MDS messes with
reset configuration words source settings which is plain wrong (it
looks like this board code was cut-n-pasted from the mpc8360 mds code,
which has the PHY reset bits in a different BCSR); this patch points
the PHY reset code to the proper mpc832x mds PHY reset bits in the BCSR.

Signed-off-by: Peter Van Ackeren <peter.vanackeren@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 972fa85..9e3bfcc 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -90,10 +90,11 @@ static void __init mpc832x_sys_setup_arch(void)
 
 	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
 			!= NULL){
-		/* Reset the Ethernet PHY */
-		bcsr_regs[9] &= ~0x20;
+		/* Reset the Ethernet PHYs */
+#define BCSR8_FETH_RST 0x50
+		bcsr_regs[8] &= ~BCSR8_FETH_RST;
 		udelay(1000);
-		bcsr_regs[9] |= 0x20;
+		bcsr_regs[8] |= BCSR8_FETH_RST;
 		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
-- 
1.5.2.2
