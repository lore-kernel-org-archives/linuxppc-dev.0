Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 389FD67A82
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 18:13:06 +1100 (EST)
Date: Wed, 16 Mar 2005 01:12:51 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503160108470.17765@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix FEC ethernet intialization on MPC8540 ADS board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

The PHY interrupt for the DM9121 PHY connected to the FEC ethernet port 
does not work on the MPC8540 ADS board.  If we tell the driver that the 
PHY does not have an interrupt the FEC works properly on the MPC8540 ADS 
board.

Signed-off-by: Roy Zang
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-16 01:08:48 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-16 01:08:48 -06:00
@@ -109,7 +109,7 @@
 	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->board_flags = 0;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 3;
 	/* fixup phy address */
