Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id DF76F2C059
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 04:52:53 +1100 (EST)
Date: Tue, 7 Dec 2004 10:52:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: jgarzik@pobox.com
Message-ID: <20041207105250.C13540@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][EMAC] allow rx of the maximum sized VLAN tagged packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Patch enables EMAC to receive maximum sized VLAN tagged packets. 

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== drivers/net/ibm_emac/ibm_emac.h 1.1 vs edited =====
--- 1.1/drivers/net/ibm_emac/ibm_emac.h	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac.h	2004-08-24 12:19:41 -07:00
@@ -98,7 +98,7 @@
 #endif				/* CONFIG_IBM_EMAC4 */
 #define EMAC_M1_BASE			(EMAC_M1_TX_FIFO_2K | \
 					EMAC_M1_APP | \
-					EMAC_M1_TR)
+					EMAC_M1_TR | EMAC_M1_VLE)
 
 /* Transmit Mode Register 0 */
 #define EMAC_TMR0_GNP0			0x80000000
===== drivers/net/ibm_emac/ibm_emac_core.c 1.2 vs edited =====
--- 1.2/drivers/net/ibm_emac/ibm_emac_core.c	2004-06-04 08:50:36 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_core.c	2004-08-24 12:18:27 -07:00
@@ -1335,6 +1335,9 @@
 
 	/* set frame gap */
 	out_be32(&emacp->em0ipgvr, CONFIG_IBM_EMAC_FGAP);
+	
+	/* set VLAN Tag Protocol Identifier */
+	out_be32(&emacp->em0vtpid, 0x8100);
 
 	/* Init ring buffers */
 	emac_init_rings(fep->ndev);
