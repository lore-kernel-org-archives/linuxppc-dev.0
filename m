Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 033A167A6C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:01:07 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j49C5gpZ006853
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 15:05:45 +0300 (EEST)
Message-ID: <427F4D38.70102@intracom.gr>
Date: Mon, 09 May 2005 14:44:56 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
	Eugene Surovegin <ebs@ebshome.net>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------010001040104020807050902"
Subject: [PATCH  01/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010001040104020807050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

The following patch is a combined FCC/FEC ethernet driver
for the Freescale line of PowerQUICCs.

FECs on 8xx and FCCs on 82xx are supported.

This part of the patch contains makefiles and friends.

Regards

Pantelis

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------010001040104020807050902
Content-Type: text/x-patch;
 name="fs_enet-01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-01.patch"

--- linux-2.6.11.7-fs_enet.orig/drivers/net/Kconfig
+++ linux-2.6.11.7-fs_enet/drivers/net/Kconfig
@@ -1810,6 +1810,7 @@ config NE_H8300
 	  controller on the Renesas H8/300 processor.
 
 source "drivers/net/fec_8xx/Kconfig"
+source "drivers/net/fs_enet/Kconfig"
 
 endmenu
 
--- linux-2.6.11.7-fs_enet.orig/drivers/net/Makefile
+++ linux-2.6.11.7-fs_enet/drivers/net/Makefile
@@ -182,6 +182,7 @@ obj-$(CONFIG_IBMVETH) += ibmveth.o
 obj-$(CONFIG_S2IO) += s2io.o
 obj-$(CONFIG_SMC91X) += smc91x.o
 obj-$(CONFIG_FEC_8XX) += fec_8xx/
+obj-$(CONFIG_FS_ENET) += fs_enet/
 
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_NET_FC) += fc/
@@ -197,3 +198,6 @@ obj-$(CONFIG_IRDA) += irda/
 obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+
+obj-$(CONFIG_FS_ENET) += fs_enet/ mii.o
+
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/Kconfig
@@ -0,0 +1,4 @@
+config FS_ENET
+	tristate "Freescale Ethernet Driver"
+	depends on NET_ETHERNET && (8xx || 8260)
+	select MII
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the Freescale Ethernet controllers
+#
+
+obj-$(CONFIG_FS_ENET) += fs_enet.o
+
+obj-$(CONFIG_8xx) += mac-fec.o
+obj-$(CONFIG_8260) += mac-fcc.o
+
+fs_enet-objs := fs_enet-main.o fs_enet-mii.o mii-bitbang.o mii-fixed.o

--------------010001040104020807050902--
