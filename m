Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AD4FADDF1A
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:45:56 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 426898810
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 22:45:55 +0500 (SAMST)
Date: Fri, 5 Oct 2007 21:46:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] [POWERPC] mpc85xx_mds: reset UCC ethernet properly
Message-ID: <20071005174647.GC32145@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071005174015.GA11016@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apart from that the current code doesn't compile it's also
meaningless with regard to the MPC8568E-MDS' BCSR.

This patch used to reset UCCs properly.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 57e840a..6913e99 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -113,18 +113,22 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}
 
 	if (bcsr_regs) {
-		u8 bcsr_phy;
-
-		/* Reset the Ethernet PHY */
-		bcsr_phy = in_be8(&bcsr_regs[9]);
-		bcsr_phy &= ~0x20;
-		out_be8(&bcsr_regs[9], bcsr_phy);
-
-		udelay(1000);
-
-		bcsr_phy = in_be8(&bcsr_regs[9]);
-		bcsr_phy |= 0x20;
-		out_be8(&bcsr_regs[9], bcsr_phy);
+#define BCSR_UCC1_GETH_EN	(0x1 << 7)
+#define BCSR_UCC2_GETH_EN	(0x1 << 7)
+#define BCSR_UCC1_MODE_MSK	(0x3 << 4)
+#define BCSR_UCC2_MODE_MSK	(0x3 << 0)
+
+		/* Turn off UCC1 & UCC2 */
+		clrbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+		clrbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+
+		/* Mode is RGMII, all bits clear */
+		clrbits8(&bcsr_regs[11], BCSR_UCC1_MODE_MSK |
+					 BCSR_UCC2_MODE_MSK);
+
+		/* Turn UCC1 & UCC2 on */
+		setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+		setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
 
 		iounmap(bcsr_regs);
 	}
-- 
1.5.0.6
