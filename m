Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id EB179DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 20:09:48 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2699jDE013887
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 02:09:46 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2699gBl028239
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 03:09:43 -0600 (CST)
Message-ID: <45ED302A.1090006@freescale.com>
Date: Tue, 06 Mar 2007 17:11:06 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Kumar <galak@kernel.crashing.org>
Subject: [PATCH] minor fixes for 834x_mds USB setup code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix broken node manipulating code, and clarify inaccurate comment.

Signed-off-by: Li Yang <leoli@freescale.com>
---
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index e5d8191..8aa9a93 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -55,9 +55,9 @@ static int mpc834x_usb_cfg(void)
 	struct device_node *np = NULL;
 	int port0_is_dr = 0;
 
-	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL)
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr")) != NULL)
 		port0_is_dr = 1;
-	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL){
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-mph")) != NULL){
 		if (port0_is_dr) {
 			printk(KERN_WARNING
 				"There is only one USB port on PB board! \n");
@@ -103,8 +103,8 @@ static int mpc834x_usb_cfg(void)
 		return -1;
 
 	/*
-	 * if MDS board is plug into PIB board,
-	 * force to use the PHY on MDS board
+	 * if Processor Board is plugged into PIB board,
+	 * force to use the PHY on Processor Board
 	 */
 	bcsr5 = in_8(bcsr_regs + 5);
 	if (!(bcsr5 & BCSR5_INT_USB))
