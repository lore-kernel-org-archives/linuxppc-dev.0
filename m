Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 11:27:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Disable old EMAC driver in arch/powerpc
Message-ID: <20070628012757.GE15298@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The EMAC driver, in drivers/net/ibm_emac, for the embedded Ethernet
MAC found in PowerPC 4xx embedded chips is not suitable for
arch/powerpc.  It will not build because it relies on the old arch/ppc
OCP mechanism.  BenH has a new, device-tree aware version of the
driver which will work in arch/powerpc, but until it's merged, this
patch will disable the old, non-building version.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/Kconfig
===================================================================
--- working-2.6.orig/drivers/net/Kconfig	2007-06-28 11:16:31.000000000 +1000
+++ working-2.6/drivers/net/Kconfig	2007-06-28 11:16:37.000000000 +1000
@@ -1187,7 +1187,7 @@
 
 config IBM_EMAC
 	tristate "PowerPC 4xx on-chip Ethernet support"
-	depends on 4xx
+	depends on 4xx && !PPC_MERGE
 	help
 	  This driver supports the PowerPC 4xx EMAC family of on-chip
           Ethernet controllers.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
