Return-Path: <brking@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A32C2DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 05:29:12 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7AJT9Hw023092
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 15:29:09 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7AJT9Mw459092
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 15:29:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7AJT8Hl028414
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 15:29:08 -0400
Message-Id: <200708101929.l7AJT836028371@d01av02.pok.ibm.com>
Subject: [PATCH 3/6] ibmveth: Add ethtool TSO handlers
To: santil@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2007 14:29:08 -0500
In-Reply-To: <11867741331983-patch-mail.ibm.com>
References: <11867741331983-patch-mail.ibm.com>
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

 linux-2.6-bjking1/drivers/net/ibmveth.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/net/ibmveth.c~ibmveth_ethtool_get_tso drivers/net/ibmveth.c
--- linux-2.6/drivers/net/ibmveth.c~ibmveth_ethtool_get_tso	2007-08-08 10:46:28.000000000 -0500
+++ linux-2.6-bjking1/drivers/net/ibmveth.c	2007-08-08 10:46:28.000000000 -0500
@@ -767,6 +767,8 @@ static const struct ethtool_ops netdev_e
 	.set_tx_csum		= ibmveth_set_tx_csum,
 	.get_rx_csum		= ibmveth_get_rx_csum,
 	.set_rx_csum		= ibmveth_set_rx_csum,
+	.get_tso			= ethtool_op_get_tso,
+	.get_ufo			= ethtool_op_get_ufo,
 };
 
 static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
_
