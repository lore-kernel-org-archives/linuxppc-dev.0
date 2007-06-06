Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28CEADDD07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 04:53:21 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l56IrIeX242334
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 18:53:18 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l56IrIDX3510426
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 20:53:18 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l56IrHTS012138
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 20:53:17 +0200
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.22-rc4] ehea: Fixed possible kernel panic on VLAN packet
	recv
Date: Wed, 6 Jun 2007 20:53:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706062053.16986.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a possible kernel panic due to not checking the vlan group
when processing received VLAN packets and a malfunction in VLAN/hypervisor
registration.


Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


diff -Nurp -X dontdiff linux-2.6.22-rc4/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.22-rc4/drivers/net/ehea/ehea.h	2007-06-05 02:57:25.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-06-06 12:53:58.000000000 +0200
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0061"
+#define DRV_VERSION	"EHEA_0064"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.22-rc4/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.22-rc4/drivers/net/ehea/ehea_main.c	2007-06-05 02:57:25.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-06-06 12:53:58.000000000 +0200
@@ -451,7 +451,8 @@ static struct ehea_cqe *ehea_proc_rwqes(
 				processed_rq3++;
 			}
 
-			if (cqe->status & EHEA_CQE_VLAN_TAG_XTRACT)
+			if ((cqe->status & EHEA_CQE_VLAN_TAG_XTRACT)
+			    && port->vgrp)
 				vlan_hwaccel_receive_skb(skb, port->vgrp,
 							 cqe->vlan_tag);
 			else
@@ -1910,10 +1911,7 @@ static void ehea_vlan_rx_register(struct
 		goto out;
 	}
 
-	if (grp)
-		memset(cb1->vlan_filter, 0, sizeof(cb1->vlan_filter));
-	else
-		memset(cb1->vlan_filter, 0xFF, sizeof(cb1->vlan_filter));
+	memset(cb1->vlan_filter, 0, sizeof(cb1->vlan_filter));
 
 	hret = ehea_h_modify_ehea_port(adapter->handle, port->logical_port_id,
 				       H_PORT_CB1, H_PORT_CB1_ALL, cb1);
@@ -1947,7 +1945,7 @@ static void ehea_vlan_rx_add_vid(struct 
 	}
 
 	index = (vid / 64);
-	cb1->vlan_filter[index] |= ((u64)(1 << (vid & 0x3F)));
+	cb1->vlan_filter[index] |= ((u64)(0x8000000000000000 >> (vid & 0x3F)));
 
 	hret = ehea_h_modify_ehea_port(adapter->handle, port->logical_port_id,
 				       H_PORT_CB1, H_PORT_CB1_ALL, cb1);
@@ -1982,7 +1980,7 @@ static void ehea_vlan_rx_kill_vid(struct
 	}
 
 	index = (vid / 64);
-	cb1->vlan_filter[index] &= ~((u64)(1 << (vid & 0x3F)));
+	cb1->vlan_filter[index] &= ~((u64)(0x8000000000000000 >> (vid & 0x3F)));
 
 	hret = ehea_h_modify_ehea_port(adapter->handle, port->logical_port_id,
 				       H_PORT_CB1, H_PORT_CB1_ALL, cb1);
