Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76AE167CD4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:46:32 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NkTWG006836
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:46:29 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6NkTq0531994
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:46:29 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6NkSWo002620
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:46:29 -0700
Date: Wed, 6 Dec 2006 17:46:28 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 14/16] Spidernet Avoid possible RX chain corruption
Message-ID: <20061206234628.GN4649@austin.ibm.com>
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


Delete possible source of chain corruption; the hardware
already knows the location of the tail, and writing it
again is likely to mess it up.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 16:03:16.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 16:03:18.000000000 -0600
@@ -1195,7 +1195,6 @@ spider_net_handle_rxram_full(struct spid
 	while (spider_net_decode_one_descr(card, 0));
 
 	spider_net_refill_rx_chain(card);
-	spider_net_enable_rxchtails(card);
 	spider_net_enable_rxdmac(card);
 	netif_rx_schedule(card->netdev);
 	spider_net_rx_irq_on(card);
