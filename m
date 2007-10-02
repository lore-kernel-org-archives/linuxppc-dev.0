Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D43FDDF18
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:02:18 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l92C17SX023047
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 16:01:07 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l92C17EO023044
	for linuxppc-dev@ozlabs.org; Tue, 2 Oct 2007 16:01:07 +0400
Date: Tue, 2 Oct 2007 16:01:07 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix typo in new EMAC driver.
Message-ID: <20071002120107.GA21847@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1191283028.10089.15.camel@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix an obvious typo in emac_xmit_finish.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/ibm_newemac/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -ruNp linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
--- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2007-10-01 17:23:35.000000000 +0400
+++ linux-2.6/drivers/net/ibm_newemac/core.c	2007-10-01 17:44:57.000000000 +0400
@@ -1232,9 +1232,9 @@ static inline int emac_xmit_finish(struc
 	 * instead
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
-		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
-	else
 		out_be32(&p->tmr0, EMAC4_TMR0_XMIT);
+	else
+		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
 
 	if (unlikely(++dev->tx_cnt == NUM_TX_BUFF)) {
 		netif_stop_queue(ndev);
