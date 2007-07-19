Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 340FCDE1C8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:48:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6JFmY7q008729
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 11:48:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6JFmUc4207824
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:48:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6JFmLw7032210
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:48:21 -0600
Message-Id: <200707191548.l6JFmKi3032157@d03av03.boulder.ibm.com>
Subject: [PATCH 3/4] ibmveth: Add ethtool TSO handlers
To: santil@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 19 Jul 2007 10:48:20 -0500
In-Reply-To: <1184860086366-patch-mail.ibm.com>
References: <1184860086366-patch-mail.ibm.com>
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

 linux-2.6-bjking1/drivers/net/ibmveth.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/net/ibmveth.c~ibmveth_ethtool_get_tso drivers/net/ibmveth.c
--- linux-2.6/drivers/net/ibmveth.c~ibmveth_ethtool_get_tso	2007-07-19 08:39:31.000000000 -0500
+++ linux-2.6-bjking1/drivers/net/ibmveth.c	2007-07-19 08:39:31.000000000 -0500
@@ -761,7 +761,9 @@ static const struct ethtool_ops netdev_e
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
