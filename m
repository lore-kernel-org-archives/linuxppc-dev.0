Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EE3CDDF3E
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 00:18:51 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m59EHdav389912
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 14:17:39 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m59EHdSp2003132
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 15:17:39 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m59EHcFJ013037
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 15:17:39 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH][2.6.26] ehea: set mac address fix
Date: Mon, 9 Jun 2008 15:17:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806091617.38396.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, hering2@de.ibm.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

eHEA has to call firmware functions in order to change the mac address
of a logical port. This patch checks if the logical port is up
when calling the register / deregister mac address calls. If the port
is down these firmware calls would fail and are therefore not executed.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---

diff -Nurp -X dontdiff linux-2.6.26-rc4/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.26-rc4/drivers/net/ehea/ehea_main.c	2008-05-26 20:08:11.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2008-06-09 15:42:17.000000000 +0200
@@ -1766,16 +1766,20 @@ static int ehea_set_mac_addr(struct net_
 	mutex_lock(&ehea_bcmc_regs.lock);
 
 	/* Deregister old MAC in pHYP */
-	ret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
-	if (ret)
-		goto out_upregs;
+	if (port->state == EHEA_PORT_UP) {
+		ret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+		if (ret)
+			goto out_upregs;
+	}
 
 	port->mac_addr = cb0->port_mac_addr << 16;
 
 	/* Register new MAC in pHYP */
-	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
-	if (ret)
-		goto out_upregs;
+	if (port->state == EHEA_PORT_UP) {
+		ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+		if (ret)
+			goto out_upregs;
+	}
 
 	ret = 0;
 
