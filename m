Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 3261367CE3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:37:38 +1100 (EST)
Message-Id: <20061102125624.568115000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:55:57 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 02/16] replace CONFIG_PPC_MULTIPLATFORM with
	CONFIG_PPC_PMAC in tulip driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

replace CONFIG_PPC_MULTIPLATFORM with CONFIG_PPC_PMAC in
drivers/net/tulip/de4x5.c. It is needed for a pmac specific hook but
has nothing with to do with PPC_MULTIPLATFORM

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6/drivers/net/tulip/de4x5.c
===================================================================
--- linux-2.6.orig/drivers/net/tulip/de4x5.c
+++ linux-2.6/drivers/net/tulip/de4x5.c
@@ -473,9 +473,9 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include <asm/uaccess.h>
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+#endif /* CONFIG_PPC_PMAC */
 
 #include "de4x5.h"
 
@@ -4151,7 +4151,7 @@ get_hw_addr(struct net_device *dev)
     /* If possible, try to fix a broken card - SMC only so far */
     srom_repair(dev, broken);
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_PPC_PMAC
     /*
     ** If the address starts with 00 a0, we have to bit-reverse
     ** each byte of the address.
@@ -4168,7 +4168,7 @@ get_hw_addr(struct net_device *dev)
 		    dev->dev_addr[i] = ((x & 0x55) << 1) + ((x & 0xaa) >> 1);
 	    }
     }
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+#endif /* CONFIG_PPC_PMAC */
 
     /* Test for a bad enet address */
     status = test_bad_enet(dev, status);

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
