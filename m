Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E9A5267CA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 07:32:18 +1000 (EST)
Date: Tue, 26 Jul 2005 14:32:15 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050726213215.GB22717@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix 440SP MAL channels count
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

the following patch fixes MAL channels count in PPC 440SP OCP 
definition. PPC 440SP has only 1 EMAC attached to MAL.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
--- a/arch/ppc/platforms/4xx/ibm440sp.c
+++ b/arch/ppc/platforms/4xx/ibm440sp.c
@@ -36,8 +36,8 @@ static struct ocp_func_emac_data ibm440s
 OCP_SYSFS_EMAC_DATA()
 
 static struct ocp_func_mal_data ibm440sp_mal0_def = {
-	.num_tx_chans   = 4,    	/* Number of TX channels */
-	.num_rx_chans   = 4,    	/* Number of RX channels */
+	.num_tx_chans   = 1,    	/* Number of TX channels */
+	.num_rx_chans   = 1,    	/* Number of RX channels */
 	.txeob_irq	= 38,		/* TX End Of Buffer IRQ  */
 	.rxeob_irq	= 39,		/* RX End Of Buffer IRQ  */
 	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
