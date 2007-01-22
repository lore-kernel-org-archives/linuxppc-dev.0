Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 800ACDDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:53:27 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBrMWd110494
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:53:22 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBrLIl721008
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:53:21 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBrLv5007697
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:53:21 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 3/7] ehea: Modified initial autoneg state
	determination
Date: Mon, 22 Jan 2007 12:53:20 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221253.20959.osstklei@de.ibm.com>
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

Logical partitions are not allowed to (try to) set the autonegotiation status.
This patch removes the respective function call from the port setup function.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:02:20.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:11:30.000000000 +0100
@@ -642,6 +642,8 @@ int ehea_sense_port_attr(struct ehea_por
 		break;
 	}
 
+	port->autoneg = 1;
+
 	/* Number of default QPs */
 	port->num_def_qps = cb0->num_default_qps;
 
@@ -2334,8 +2336,6 @@ static int ehea_setup_single_port(struct
 
 	INIT_LIST_HEAD(&port->mc_list->list);
 
-	ehea_set_portspeed(port, EHEA_SPEED_AUTONEG);
-
 	ret = ehea_sense_port_attr(port);
 	if (ret)
 		goto out;
