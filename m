Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D22E867B60
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:25:05 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IMP2Jx021266
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:25:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IMP18K238414
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:25:01 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IMP1iu031305
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:25:01 -0600
Date: Fri, 18 Aug 2006 17:25:00 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20060818222500.GK26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



This patch adds version information as reported by 
ethtool -i to the Spidernet driver.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>

----
 drivers/net/spider_net.c         |    3 +++
 drivers/net/spider_net.h         |    2 ++
 drivers/net/spider_net_ethtool.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-11 11:34:16.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-11 11:38:48.000000000 -0500
@@ -55,6 +55,7 @@ MODULE_AUTHOR("Utz Bacher <utz.bacher@de
 	      "<Jens.Osterkamp@de.ibm.com>");
 MODULE_DESCRIPTION("Spider Southbridge Gigabit Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
@@ -2293,6 +2294,8 @@ static struct pci_driver spider_net_driv
  */
 static int __init spider_net_init(void)
 {
+	printk("spidernet Version %s.\n",VERSION);
+
 	if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
 		rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
 		pr_info("adjusting rx descriptors to %i.\n", rx_descriptors);
Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-11 11:19:47.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-11 11:38:48.000000000 -0500
@@ -24,6 +24,8 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
+#define VERSION "1.1 A"
+
 #include "sungem_phy.h"
 
 extern int spider_net_stop(struct net_device *netdev);
Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net_ethtool.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net_ethtool.c	2006-06-17 20:49:35.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net_ethtool.c	2006-08-11 11:38:48.000000000 -0500
@@ -55,7 +55,7 @@ spider_net_ethtool_get_drvinfo(struct ne
 	/* clear and fill out info */
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
 	strncpy(drvinfo->driver, spider_net_driver_name, 32);
-	strncpy(drvinfo->version, "0.1", 32);
+	strncpy(drvinfo->version, VERSION, 32);
 	strcpy(drvinfo->fw_version, "no information");
 	strncpy(drvinfo->bus_info, pci_name(card->pdev), 32);
 }
