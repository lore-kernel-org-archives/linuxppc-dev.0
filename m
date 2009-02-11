Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [194.196.100.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55BF7DDDB0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 23:29:14 +1100 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n1BCT4Lk032029
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 12:29:04 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n1BCT48W1532066
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 12:29:04 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n1BCT3Oa021442
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 12:29:04 GMT
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: jeff@garzik.org
Subject: [PATCH] ehea: Fix: Remove adapter from adapter list in error path
Date: Wed, 11 Feb 2009 13:29:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902111329.02954.hannes.hering@linux.vnet.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove adapter from adapter list before freeing data structure in error path.

Signed-off-by: Hannes Hering <hering2@de.ibm.com>

---

diff -Nurp -X dontdiff linux-2.6.29-rc4/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.29-rc4/drivers/net/ehea/ehea.h	2009-02-11 13:13:42.036506588 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2009-02-11 13:14:04.197540184 +0100
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0097"
+#define DRV_VERSION	"EHEA_0098"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.29-rc4/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.29-rc4/drivers/net/ehea/ehea_main.c	2009-02-11 13:13:47.812542928 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-02-11 13:14:04.197540184 +0100
@@ -3448,6 +3448,7 @@ out_kill_eq:
 	ehea_destroy_eq(adapter->neq);
 
 out_free_ad:
+	list_del(&adapter->list);
 	kfree(adapter);
 
 out:
