Return-Path: <martin-langer@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 220AADDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Sep 2008 17:51:38 +1000 (EST)
Received: from ml by tuba with local (Exim 4.50) id 1KcF3U-00010N-HO
	for linuxppc-dev@ozlabs.org; Sun, 07 Sep 2008 09:51:32 +0200
Date: Sun, 7 Sep 2008 09:51:32 +0200
From: Martin Langer <martin-langer@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix major revision number for Freescale cores
Message-ID: <20080907075132.GA3563@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some 74xx cores by Freescale are using the configuration field instead 
of the major revision field for their revision number. This patch 
corrects the wrong behaviour for those ppc cores including my one.

There is a reference document at Freecale. It decribes the PVR register. 
The patch is based on that pdf. You can find the document here:
http://www.freescale.com/files/archives/doc/support_info/PPCPVR.pdf

Signed-off-by: Martin Langer <martin-langer@gmx.de>


--- arch/powerpc/kernel/setup-common.c.ORIGINAL	2008-09-06 23:26:50.000000000 +0200
+++ arch/powerpc/kernel/setup-common.c	2008-09-06 23:27:11.000000000 +0200
@@ -254,8 +254,21 @@
 	/* If we are a Freescale core do a simple check so
 	 * we dont have to keep adding cases in the future */
 	if (PVR_VER(pvr) & 0x8000) {
-		maj = PVR_MAJ(pvr);
-		min = PVR_MIN(pvr);
+		switch (PVR_VER(pvr)) {
+		case 0x8000:	/* 7441/7450/7451, Voyager */
+		case 0x8001:	/* 7445/7455, Apollo 6 */
+		case 0x8002:	/* 7447/7457, Apollo 7 */
+		case 0x8003:	/* 7447A, Apollo 7 PM */
+		case 0x8004:	/* 7448, Apollo 8 */
+		case 0x800c:	/* 7410, Nitro */
+			maj = ((pvr >> 8) & 0xF);
+			min = PVR_MIN(pvr);
+			break;
+		default:	/* e500/book-e */
+			maj = PVR_MAJ(pvr);
+			min = PVR_MIN(pvr);
+			break;
+		}
 	} else {
 		switch (PVR_VER(pvr)) {
 			case 0x0020:	/* 403 family */
