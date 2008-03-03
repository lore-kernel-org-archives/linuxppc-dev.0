Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADFA5DDECC
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 23:52:12 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m23Cq7gt373316
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 12:52:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m23Cq7PV1790014
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 12:52:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m23Cq7Da006795
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 12:52:07 GMT
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: Fix missing Kconfig dependency
Date: Mon, 3 Mar 2008 13:52:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803031352.06322.osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed Kconfig: ehea driver requires sparse mem

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
diff -Nurp linux-2.6.25-rc3.org/drivers/net/Kconfig linux-2.6.25-rc3/drivers/net/Kconfig
--- linux-2.6.25-rc3.org/drivers/net/Kconfig	2008-02-24 22:25:54.000000000 +0100
+++ linux-2.6.25-rc3/drivers/net/Kconfig	2008-03-03 13:36:48.000000000 +0100
@@ -2513,7 +2513,7 @@ config CHELSIO_T3
 
 config EHEA
 	tristate "eHEA Ethernet support"
-	depends on IBMEBUS && INET
+	depends on IBMEBUS && INET && SPARSEMEM
 	select INET_LRO
 	---help---
 	  This driver supports the IBM pSeries eHEA ethernet adapter.
