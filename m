Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8B0067C1E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:00:08 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL05kx003417
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:00:05 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL05fJ545176
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:00:05 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL04JM017167
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:00:05 -0600
Date: Tue, 10 Oct 2006 16:00:04 -0500
To: akpm@osdl.org
Subject: [PATCH 4/21]: powerpc/cell spidernet force-end fix
Message-ID: <20061010210004.GA4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bugfix: when cleaning up the transmit queue upon device close,
be sure to walk the entire queue.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:21:40.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:22:49.000000000 -0500
@@ -699,6 +699,8 @@ spider_net_release_tx_descr(struct spide
 
 	/* unmap the skb */
 	skb = descr->skb;
+	if (!skb)
+		return;
 	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
 			PCI_DMA_TODEVICE);
 	dev_kfree_skb_any(skb);
@@ -751,7 +753,8 @@ spider_net_release_tx_chain(struct spide
 
 		default:
 			card->netdev_stats.tx_dropped++;
-			return 1;
+			if (!brutal)
+				return 1;
 		}
 		spider_net_release_tx_descr(card);
 	}
