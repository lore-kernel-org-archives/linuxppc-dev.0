Date: Thu, 6 Sep 2001 15:19:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Init code for ppc405 enet
Message-ID: <20010906151923.F20279@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following patch adds module init code to the ppc405 enet driver,
so that it no longer needs additions to Space.c to be initialised.

diff -urN ../linuxppc_2_4_devel/drivers/net/ppc405_enet.c linux-bungo/drivers/net/ppc405_enet.c
--- ../linuxppc_2_4_devel/drivers/net/ppc405_enet.c	Tue Aug 28 15:06:46 2001
+++ linux-bungo/drivers/net/ppc405_enet.c	Thu Sep  6 11:50:16 2001
@@ -31,6 +31,7 @@
  */

 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
@@ -54,7 +55,6 @@

 #include "ppc405_enet.h"

-int		ppc405_enet_probe(struct net_device *);
 static int	ppc405_enet_probe1(struct net_device *);
 static int	ppc405_phy_speed(void);
 static int	ppc405_phy_duplex(void);
@@ -95,27 +95,7 @@
 static volatile int	ppc405_enet_ack_slot = 0;
 static volatile int	ppc405_enet_rx_slot = 0;

-
-/*
- * Maintain the initial probe as a sub function just in case it is wished
- * to have this driver as a module later.
- */
-int ppc405_enet_probe_done = 0;
-
-
-
-int
-ppc405_enet_probe(struct net_device *dev)
-{
-	if (ppc405_enet_probe_done)
-		return -ENODEV;
-
-	ppc405_enet_probe1(dev);
-
-	ppc405_enet_probe_done = 1;
-	return 0;
-}
-
+static struct net_device ppc405_enet_dev;

 static int
 ppc405_enet_open(struct net_device *dev)
@@ -1265,6 +1245,28 @@
 	return  crc_value;
 }

+static int __init init_ppc405_enet(void)
+{
+	int rc;
+
+	rc = ppc405_enet_probe1(&ppc405_enet_dev);
+	if (rc)
+		return rc;
+
+	rc = register_netdev(&ppc405_enet_dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void __exit exit_ppc405_enet(void)
+{
+	unregister_netdev(&ppc405_enet_dev);
+}
+
+module_init(init_ppc405_enet);
+module_exit(exit_ppc405_enet);

 /*
  * Local variables:


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
