Message-ID: <3C60B28E.7080803@brocade.com>
Date: Tue, 05 Feb 2002 20:35:26 -0800
From: "Amit D. Chaudhary" <amitc@brocade.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch for latest ppc405_enet.c in source.mvista.com
Content-Type: multipart/mixed;
 boundary="------------070806070703080100060509"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070806070703080100060509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please find attached and pasted below patch for ppc405_enet.c for comments.
The bk tree at source.mvista.com was based on 2.4.18-pre7 today when I
picked it up.

One change involves setting the flags for EMAC_IER, the manual does not
mention any defaults hence using 0 for it did not seem appropriate.

The second is a minor change of stats as the code uses transmit channel
0, the check for flag in ISR ought to be for the same.

Regards
Amit


--- ppc405_enet.c	Tue Feb  5 18:52:43 2002
+++ ppc405_enet-3.c	Tue Feb  5 19:38:23 2002
@@ -291,6 +291,12 @@ ppc405_enet_open(struct net_device *dev)
  	mtdcr(DCRN_MALIER, MALIER_DE |
  	      MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);

+
/* set the EMAC IER (Interrupt Enable Register) */
+

+
emac_ier = EMAC_ISR_PP   | EMAC_ISR_BP   | EMAC_ISR_RP |
+
            EMAC_ISR_SE   | EMAC_ISR_PTLE | EMAC_ISR_ALE |
+
            EMAC_ISR_BFCS | EMAC_ISR_ORE  | EMAC_ISR_IRE;
+
  	emacp->em0iser = emac_ier;
  	eieio();

@@ -1214,11 +1220,12 @@ ppc405_eth_mac(int irq, void *dev_instan
  /*	if (tmp_em0isr & EMAC_ISR_DBDM) fep->stats.ZZZ++;		*/
  /*	if (tmp_em0isr & EMAC_ISR_DB0 ) fep->stats.ZZZ++;		*/
  /*	if (tmp_em0isr & EMAC_ISR_SE0 ) fep->stats.ZZZ++;		*/
-/*
if (tmp_em0isr & EMAC_ISR_TE0 ) fep->stats.ZZZ++;		*/
+
if (tmp_em0isr & EMAC_ISR_TE0)
+
	fep->stats.tx_aborted_errors++;
  /*	if (tmp_em0isr & EMAC_ISR_DB1 ) fep->stats.ZZZ++;		*/
  /*	if (tmp_em0isr & EMAC_ISR_SE1 ) fep->stats.ZZZ++;		*/
+/*
if (tmp_em0isr & EMAC_ISR_TE0 ) fep->stats.ZZZ++;		*/
  	if (tmp_em0isr & EMAC_ISR_TE1)
-
	fep->stats.tx_aborted_errors++;
  /*	if (tmp_em0isr & EMAC_ISR_MOS ) fep->stats.ZZZ++;		*/
  /*	if (tmp_em0isr & EMAC_ISR_MOF ) fep->stats.ZZZ++;		*/


--------------070806070703080100060509
Content-Type: text/plain;
 name="ppc405_enet.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc405_enet.diff"

--- ppc405_enet.c	Tue Feb  5 18:52:43 2002
+++ ppc405_enet-3.c	Tue Feb  5 19:38:23 2002
@@ -291,6 +291,12 @@ ppc405_enet_open(struct net_device *dev)
 	mtdcr(DCRN_MALIER, MALIER_DE |
 	      MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);

+	/* set the EMAC IER (Interrupt Enable Register) */
+
+	emac_ier = EMAC_ISR_PP   | EMAC_ISR_BP   | EMAC_ISR_RP |
+	           EMAC_ISR_SE   | EMAC_ISR_PTLE | EMAC_ISR_ALE |
+	           EMAC_ISR_BFCS | EMAC_ISR_ORE  | EMAC_ISR_IRE;
+
 	emacp->em0iser = emac_ier;
 	eieio();

@@ -1214,11 +1220,12 @@ ppc405_eth_mac(int irq, void *dev_instan
 /*	if (tmp_em0isr & EMAC_ISR_DBDM) fep->stats.ZZZ++;		*/
 /*	if (tmp_em0isr & EMAC_ISR_DB0 ) fep->stats.ZZZ++;		*/
 /*	if (tmp_em0isr & EMAC_ISR_SE0 ) fep->stats.ZZZ++;		*/
-/*	if (tmp_em0isr & EMAC_ISR_TE0 ) fep->stats.ZZZ++;		*/
+	if (tmp_em0isr & EMAC_ISR_TE0)
+		fep->stats.tx_aborted_errors++;
 /*	if (tmp_em0isr & EMAC_ISR_DB1 ) fep->stats.ZZZ++;		*/
 /*	if (tmp_em0isr & EMAC_ISR_SE1 ) fep->stats.ZZZ++;		*/
+/*	if (tmp_em0isr & EMAC_ISR_TE0 ) fep->stats.ZZZ++;		*/
 	if (tmp_em0isr & EMAC_ISR_TE1)
-		fep->stats.tx_aborted_errors++;
 /*	if (tmp_em0isr & EMAC_ISR_MOS ) fep->stats.ZZZ++;		*/
 /*	if (tmp_em0isr & EMAC_ISR_MOF ) fep->stats.ZZZ++;		*/


--------------070806070703080100060509--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
