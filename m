Date: Mon, 8 Apr 2002 19:51:10 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: Tom Rini <trini@kernel.crashing.org>, akuster@mvista.com
Subject: merge slip? on ocp enet
Message-ID: <20020408195110.C17127@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii

I don't know if this is the correct patch, but as it is now
it doesn't compile. With this fix I did test out the driver
and it works ok, but there could be some other problems that
slipped through.

What are the plans for find_emac_isr? It just adds somes
warnings to the compile now.

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="enet.diff"

===== ibm_ocp_enet.c 1.28 vs edited =====
--- 1.28/drivers/net/ibm_ocp/ibm_ocp_enet.c	Mon Apr  8 08:55:54 2002
+++ edited/ibm_ocp_enet.c	Mon Apr  8 19:36:11 2002
@@ -1178,17 +1178,16 @@

 	disable_irq(irq_resource[0][BL_MAL_RXDE].irq);

-	/* This determines which emac is sending the interrupt */
+	for (i = 0; i < emac_dev_count; i++) {
+		dev = emac_dev[i];
+		fep = dev->priv;
+
+                /* This determines which emac is sending the interrupt */
 		if (! (get_mal_dcrn(DCRN_MALRXEOBISR(fep->mal))
 		       & emac_rx_mask[fep->emac_num])) {
 			continue;
 		}

-	for (i = 0; i < emac_dev_count; i++) {
-		dev = emac_dev[i];
-		fep = dev->priv;
-
-
 		set_mal_dcrn(DCRN_MALRXEOBISR(fep->mal),
 			     emac_rx_mask[fep->emac_num]);


--BXVAT5kNtrzKuDFl--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
