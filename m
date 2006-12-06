Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C85A67D37
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:33:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NXhML011059
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:33:43 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6NXHEG195686
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:33:17 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6NXGrc020634
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:33:17 -0500
Date: Wed, 6 Dec 2006 17:33:16 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/16] Spidernet Refactor RX refill
Message-ID: <20061206233316.GD4649@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061206223223.GH17931@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Refactor how spider_net_refill_rx_chain() is called. 
No functional change; this just simplifies the code
by moving the subroutine call to a more appropriate spot.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 16:01:49.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 16:02:58.000000000 -0600
@@ -1023,10 +1023,8 @@ spider_net_decode_one_descr(struct spide
 	/* ok, we've got a packet in descr */
 	result = spider_net_pass_skb_up(descr, card, napi);
 refill:
-	descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	/* change the descriptor state: */
-	if (!napi)
-		spider_net_refill_rx_chain(card);
+	descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	return result;
 }
 
@@ -1205,8 +1203,11 @@ spider_net_set_mac(struct net_device *ne
 static void
 spider_net_handle_rxram_full(struct spider_net_card *card)
 {
-	while (spider_net_decode_one_descr(card, 0))
-		;
+	int rc = 1;
+	while (rc) {
+		rc = spider_net_decode_one_descr(card, 0);
+		spider_net_refill_rx_chain(card);
+	}
 	spider_net_enable_rxchtails(card);
 	spider_net_enable_rxdmac(card);
 	netif_rx_schedule(card->netdev);
