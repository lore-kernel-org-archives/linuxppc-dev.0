Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 840BD67BDF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 03:14:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k92HEm0w021641
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:14:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k92HEdsA283568
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:14:39 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k92HEcKH029340
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:14:39 -0400
Date: Mon, 2 Oct 2006 12:14:38 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number
	info.
Message-ID: <20061002171438.GC4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929232139.GL6433@austin.ibm.com>
	<200609301233.45871.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200609301233.45871.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 30, 2006 at 12:33:45PM +0200, Arnd Bergmann wrote:
> Am Saturday 30 September 2006 01:21 schrieb Linas Vepstas:
> >
> >  static int __init spider_net_init(void)
> >  {
> > +       printk("spidernet Version %s.\n",VERSION);
> > +
> 
> This is missing a printk level and a space character. 

Revised patch below.

> More importantly,
> you should not print the presence of the driver to the syslog, but
> the presence of a device driven by it.

Most device drivers seem to print version numbers in the module_init 
routines (i.e. right before calling pci_register_driver), rather than 
in the probe routines; so this patch follows this convention.

--linas

This patch adds version information as reported by
ethtool -i to the Spidernet driver.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>


----
 drivers/net/spider_net.c         |    3 +++
 drivers/net/spider_net.h         |    2 ++
 drivers/net/spider_net_ethtool.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 16:44:17.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 12:00:15.000000000 -0500
@@ -55,6 +55,7 @@ MODULE_AUTHOR("Utz Bacher <utz.bacher@de
 	      "<Jens.Osterkamp@de.ibm.com>");
 MODULE_DESCRIPTION("Spider Southbridge Gigabit Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
@@ -2303,6 +2304,8 @@ static struct pci_driver spider_net_driv
  */
 static int __init spider_net_init(void)
 {
+	printk(KERN_INFO "Spidernet version %s.\n", VERSION);
+
 	if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
 		rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
 		pr_info("adjusting rx descriptors to %i.\n", rx_descriptors);
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-09-29 16:44:17.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-02 11:57:32.000000000 -0500
@@ -24,6 +24,8 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
+#define VERSION "1.1 A"
+
 #include "sungem_phy.h"
 
 extern int spider_net_stop(struct net_device *netdev);
Index: linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net_ethtool.c	2006-09-29 16:33:43.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c	2006-09-29 16:44:18.000000000 -0500
@@ -76,7 +76,7 @@ spider_net_ethtool_get_drvinfo(struct ne
 	/* clear and fill out info */
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
 	strncpy(drvinfo->driver, spider_net_driver_name, 32);
-	strncpy(drvinfo->version, "0.1", 32);
+	strncpy(drvinfo->version, VERSION, 32);
 	strcpy(drvinfo->fw_version, "no information");
 	strncpy(drvinfo->bus_info, pci_name(card->pdev), 32);
 }
