Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01C13DDE37
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:53:02 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBqptM119804
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:52:52 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBqpws2867304
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:52:51 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBqorS018669
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:52:51 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 2/7] ehea: Fixing firmware queue config issue
Date: Mon, 22 Jan 2007 12:52:50 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221252.50724.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix to use exactly one queue for incoming packets in all
firmware configurations

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 13:59:07.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:01:38.000000000 +0100
@@ -998,7 +998,7 @@ static int ehea_configure_port(struct eh
 		     | EHEA_BMASK_SET(PXLY_RC_JUMBO_FRAME, 1);
 
 	for (i = 0; i < port->num_def_qps; i++)
-		cb0->default_qpn_arr[i] = port->port_res[i].qp->init_attr.qp_nr;
+		cb0->default_qpn_arr[i] = port->port_res[0].qp->init_attr.qp_nr;
 
 	if (netif_msg_ifup(port))
 		ehea_dump(cb0, sizeof(*cb0), "ehea_configure_port");
