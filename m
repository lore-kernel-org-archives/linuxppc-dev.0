Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E570CDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 05:19:46 +1100 (EST)
Date: Mon, 5 Nov 2007 12:15:51 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc: handle mpc8360 rev. 2.1 RGMII timing erratum
Message-Id: <20071105121551.a28b5446.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

if on a rev. 2.1, adjust UCC clock and data timing characteristics
as specified in the rev.2.1 erratum #2.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   31 ++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0f3855c..0a72260 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -96,14 +96,39 @@ static void __init mpc836x_mds_setup_arch(void)
 
 	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
 			!= NULL){
+		uint svid;
+
 		/* Reset the Ethernet PHY */
-		bcsr_regs[9] &= ~0x20;
+#define BCSR9_GETHRST 0x20
+		clrbits8(&bcsr_regs[9], BCSR9_GETHRST);
 		udelay(1000);
-		bcsr_regs[9] |= 0x20;
+		setbits8(&bcsr_regs[9], BCSR9_GETHRST);
+
+		/* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
+		svid = mfspr(SPRN_SVR);
+		if (svid == 0x80480021) {
+			void __iomem *immap;
+
+			immap = ioremap(get_immrbase() + 0x14a8, 8);
+
+			/*
+			 * IMMR + 0x14A8[4:5] = 11 (clk delay for UCC 2)
+			 * IMMR + 0x14A8[18:19] = 11 (clk delay for UCC 1)
+			 */
+			setbits32(immap, 0x0c003000);
+
+			/*
+			 * IMMR + 0x14AC[20:27] = 10101010
+			 * (data delay for both UCC's)
+			 */
+			clrsetbits_be32(immap + 4, 0xff0, 0xaa0);
+
+			iounmap(immap);
+		}
+
 		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
-
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-- 
1.5.2.2
