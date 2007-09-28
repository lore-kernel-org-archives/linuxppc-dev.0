Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DD21DDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 00:45:48 +1000 (EST)
Message-Id: <20070928142322.592627000@sunsite.dk>
References: <20070928142113.163317000@sunsite.dk>
Date: Fri, 28 Sep 2007 16:21:14 +0200
From: jacmet@sunsite.dk
To: galak@kernel.crashing.org,
 leoli@freescale.com,
 linuxppc-dev@ozlabs.org
Subject: [patch 1/2] Fix mpc834x USB-MPH configuration.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc834x USB-MPH configuration got broken by commit
6f442560021aecf08658e26ed9a37e6928ef0fa1. The selection bits in SICRL
should be cleared rather than set to configure the USB MUXes for the MPH.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/platforms/83xx/usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.23-rc8/arch/powerpc/platforms/83xx/usb.c
===================================================================
--- linux-2.6.23-rc8.orig/arch/powerpc/platforms/83xx/usb.c
+++ linux-2.6.23-rc8/arch/powerpc/platforms/83xx/usb.c
@@ -76,14 +76,14 @@
 			if (port0_is_dr)
 				printk(KERN_WARNING
 					"834x USB port0 can't be used by both DR and MPH!\n");
-			sicrl |= MPC834X_SICRL_USB0;
+			sicrl &= ~MPC834X_SICRL_USB0;
 		}
 		prop = of_get_property(np, "port1", NULL);
 		if (prop) {
 			if (port1_is_dr)
 				printk(KERN_WARNING
 					"834x USB port1 can't be used by both DR and MPH!\n");
-			sicrl |= MPC834X_SICRL_USB1;
+			sicrl &= ~MPC834X_SICRL_USB1;
 		}
 		of_node_put(np);
 	}

--
Bye, Peter Korsgaard
