Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C8B1B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 00:21:57 +1000 (EST)
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CDB8DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 00:21:55 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.14.3/8.13.8) with ESMTP id n74EKIJN765104
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 14:20:18 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n74EKHhW2703614
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 16:20:17 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n74EKGpv027969
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 16:20:17 +0200
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 2.6.31] ehea: Fix napi list corruption on ifconfig down
Date: Tue, 4 Aug 2009 16:20:15 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908041620.16542.hannes.hering@linux.vnet.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the napi list handling when an ehea interface is shut down to
avoid corruption of the napi list.

Signed-off-by: Hannes Hering <hering2@de.ibm.com>

---

diff -Nurp -X dontdiff linux-2.6.31-rc5/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.31-rc5/drivers/net/ehea/ehea.h	2009-08-01 02:40:45.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea.h	2009-08-03 17:59:26.696079433 +0200
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0101"
+#define DRV_VERSION	"EHEA_0102"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.31-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.31-rc5/drivers/net/ehea/ehea_main.c	2009-08-01 02:40:45.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-08-03 17:59:26.696079433 +0200
@@ -1545,6 +1545,9 @@ static int ehea_clean_portres(struct ehe
 {
 	int ret, i;
 
+	if (pr->qp)
+		netif_napi_del(&pr->napi);
+
 	ret = ehea_destroy_qp(pr->qp);
 
 	if (!ret) {
