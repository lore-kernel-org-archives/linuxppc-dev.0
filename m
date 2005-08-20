Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6E30C67FA7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 12:32:07 +1000 (EST)
Date: Fri, 19 Aug 2005 19:32:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050820023204.GA6805@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix EMAC Tx channel assignments for NPe405H
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix PowerPC NPe405H EMAC Tx channel assignments. EMAC unit in this 
chip uses common for 4xx "two Tx / one Rx" configuration.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/platforms/4xx/ibmnp405h.c b/arch/ppc/platforms/4xx/ibmnp405h.c
--- a/arch/ppc/platforms/4xx/ibmnp405h.c
+++ b/arch/ppc/platforms/4xx/ibmnp405h.c
@@ -34,7 +34,7 @@ static struct ocp_func_emac_data ibmnp40
 	.zmii_mux	= 1,		/* ZMII input of this EMAC */
 	.mal_idx	= 0,		/* MAL device index */
 	.mal_rx_chan	= 1,		/* MAL rx channel number */
-	.mal_tx_chan	= 1,		/* MAL tx channel number */
+	.mal_tx_chan	= 2,		/* MAL tx channel number */
 	.wol_irq	= 41,		/* WOL interrupt number */
 	.mdio_idx	= -1,		/* No shared MDIO */
 	.tah_idx	= -1,		/* No TAH */
@@ -46,7 +46,7 @@ static struct ocp_func_emac_data ibmnp40
 	.zmii_mux	= 2,		/* ZMII input of this EMAC */
 	.mal_idx	= 0,		/* MAL device index */
 	.mal_rx_chan	= 2,		/* MAL rx channel number */
-	.mal_tx_chan	= 2,		/* MAL tx channel number */
+	.mal_tx_chan	= 4,		/* MAL tx channel number */
 	.wol_irq	= 41,		/* WOL interrupt number */
 	.mdio_idx	= -1,		/* No shared MDIO */
 	.tah_idx	= -1,		/* No TAH */
@@ -58,7 +58,7 @@ static struct ocp_func_emac_data ibmnp40
 	.zmii_mux	= 3,		/* ZMII input of this EMAC */
 	.mal_idx	= 0,		/* MAL device index */
 	.mal_rx_chan	= 3,		/* MAL rx channel number */
-	.mal_tx_chan	= 3,		/* MAL tx channel number */
+	.mal_tx_chan	= 6,		/* MAL tx channel number */
 	.wol_irq	= 41,		/* WOL interrupt number */
 	.mdio_idx	= -1,		/* No shared MDIO */
 	.tah_idx	= -1,		/* No TAH */
