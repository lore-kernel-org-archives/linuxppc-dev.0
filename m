Return-Path: <tklein@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FB21DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 22:32:21 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n1JBWFN5030967
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 11:32:15 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n1JBWEwo3199196
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 11:32:14 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n1JBWEJj007413
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 11:32:14 GMT
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: Fix memory hotplug handling
From: Thomas Klein <tklein@de.ibm.com>
Date: Thu, 19 Feb 2009 12:32:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902191232.12152.tklein@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	Hannes Hering <hering2@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added missing set_bit() to disable data transfer when a memchange notification is handled

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---
diff -Nurp -X dontdiff linux-2.6.29-rc4/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.29-rc4/drivers/net/ehea/ehea.h	2009-02-18 16:59:54.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2009-02-18 17:01:12.000000000 +0100
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0098"
+#define DRV_VERSION	"EHEA_0099"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.29-rc4/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.29-rc4/drivers/net/ehea/ehea_main.c	2009-02-18 16:59:54.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-02-18 17:01:12.000000000 +0100
@@ -3517,12 +3517,14 @@ static int ehea_mem_notifier(struct noti
 		/* Readd canceled memory block */
 	case MEM_ONLINE:
 		ehea_info("memory is going online");
+		set_bit(__EHEA_STOP_XFER, &ehea_driver_flags);
 		if (ehea_add_sect_bmap(arg->start_pfn, arg->nr_pages))
 			return NOTIFY_BAD;
 		ehea_rereg_mrs(NULL);
 		break;
 	case MEM_GOING_OFFLINE:
 		ehea_info("memory is going offline");
+		set_bit(__EHEA_STOP_XFER, &ehea_driver_flags);
 		if (ehea_rem_sect_bmap(arg->start_pfn, arg->nr_pages))
 			return NOTIFY_BAD;
 		ehea_rereg_mrs(NULL);
