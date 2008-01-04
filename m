Return-Path: <hollisb@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 985BDDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 10:27:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m04MOr4x001019
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 17:24:53 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m04NRQ5U118020
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 16:27:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m04NR7Ph023539
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 16:27:07 -0700
Subject: [PATCH] enable built-in networking for Sequoia defconfig
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Jan 2008 17:26:54 -0600
Message-Id: <1199489214.9673.18.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable EMAC driver for Sequoia (and while we're in there, disable
Macintosh drivers for Sequoia and Bamboo).

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff --git a/arch/powerpc/configs/bamboo_defconfig b/arch/powerpc/configs/bamboo_defconfig
--- a/arch/powerpc/configs/bamboo_defconfig
+++ b/arch/powerpc/configs/bamboo_defconfig
@@ -372,9 +372,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
-CONFIG_MACINTOSH_DRIVERS=y
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
diff --git a/arch/powerpc/configs/sequoia_defconfig b/arch/powerpc/configs/sequoia_defconfig
--- a/arch/powerpc/configs/sequoia_defconfig
+++ b/arch/powerpc/configs/sequoia_defconfig
@@ -446,9 +446,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
-CONFIG_MACINTOSH_DRIVERS=y
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
@@ -459,10 +457,28 @@ CONFIG_NETDEVICES=y
 # CONFIG_VETH is not set
 # CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=128
+CONFIG_IBM_NEW_EMAC_TXB=64
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_NEW_EMAC_DEBUG is not set
 CONFIG_IBM_NEW_EMAC_ZMII=y
 CONFIG_IBM_NEW_EMAC_RGMII=y
+# CONFIG_IBM_NEW_EMAC_TAH is not set
 CONFIG_IBM_NEW_EMAC_EMAC4=y
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
