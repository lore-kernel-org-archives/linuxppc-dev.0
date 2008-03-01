Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75C68DDEEC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 01:43:49 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m21Ehjtu028110
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 09:43:45 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m21EhjOW308736
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 09:43:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m21EhjbK009402
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 09:43:45 -0500
Date: Sat, 1 Mar 2008 08:41:40 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 3/2][NEWEMAC] Use status property for unused/unwired EMACs
Message-ID: <20080301084140.7abc703e@zod.rchland.ibm.com>
In-Reply-To: <20080301081600.74598ce4@zod.rchland.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert ibm_newemac to use the of_device_is_available function when checking
for unused/unwired EMACs.  We leave the current check for an "unused" property
to maintain backwards compatibility for older device trees.  Newer device
trees should simply use the standard "status" property in the EMAC node.

The taishan DTS file is updated to reflect this.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/dts/taishan.dts |    4 ++--
 drivers/net/ibm_newemac/core.c    |    7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/dts/taishan.dts
+++ linux-2.6/arch/powerpc/boot/dts/taishan.dts
@@ -234,7 +234,6 @@
 
 
 			EMAC0: ethernet@40000800 {
-				unused = <1>;
 				linux,network-index = <2>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
@@ -253,9 +252,9 @@
 				phy-map = <00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				status = "disabled";
 			};
 		 	EMAC1: ethernet@40000900 {
-				unused = <1>;
 				linux,network-index = <3>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
@@ -274,6 +273,7 @@
 				phy-map = <00000001>;
  				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
+				status = "disabled";
 			};
 
 		 	EMAC2: ethernet@40000c00 {
--- linux-2.6.orig/drivers/net/ibm_newemac/core.c
+++ linux-2.6/drivers/net/ibm_newemac/core.c
@@ -2552,8 +2552,11 @@ static int __devinit emac_probe(struct o
 	struct device_node **blist = NULL;
 	int err, i;
 
-	/* Skip unused/unwired EMACS */
-	if (of_get_property(np, "unused", NULL))
+	/* Skip unused/unwired EMACS.  We leave the check for an unused
+	 * property here for now, but new flat device trees should set a
+	 * status property to "disabled" instead.
+	 */
+	if (of_get_property(np, "unused", NULL) || !of_device_is_available(np))
 		return -ENODEV;
 
 	/* Find ourselves in the bootlist if we are there */
