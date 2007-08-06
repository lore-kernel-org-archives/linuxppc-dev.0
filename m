Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 117C5DDECB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:42:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76JgU7h027065
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:42:30 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76JgTOm256344
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 13:42:29 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76JgTxG016219
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 13:42:29 -0600
Message-Id: <200708061942.l76JgSnp016148@d03av04.boulder.ibm.com>
Subject: [PATCH 3/6] ibmveth: Add ethtool TSO handlers
To: santil@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2007 14:42:27 -0500
In-Reply-To: <11864293333377-patch-mail.ibm.com>
References: <11864293333377-patch-mail.ibm.com>
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	brking@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add handlers for get_tso and get_ufo to prevent errors being printed
by ethtool.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/net/ibmveth.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/net/ibmveth.c~ibmveth_ethtool_get_tso drivers/net/ibmveth.c
--- linux-2.6/drivers/net/ibmveth.c~ibmveth_ethtool_get_tso	2007-07-19 11:18:38.000000000 -0500
+++ linux-2.6-bjking1/drivers/net/ibmveth.c	2007-07-19 11:18:38.000000000 -0500
@@ -759,7 +759,9 @@ static const struct ethtool_ops netdev_e
 	.get_tx_csum		= ethtool_op_get_tx_csum,
 	.set_tx_csum		= ibmveth_set_tx_csum,
 	.get_rx_csum		= ibmveth_get_rx_csum,
-	.set_rx_csum		= ibmveth_set_rx_csum
+	.set_rx_csum		= ibmveth_set_rx_csum,
+	.get_tso			= ethtool_op_get_tso,
+	.get_ufo			= ethtool_op_get_ufo
 };
 
 static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
_
