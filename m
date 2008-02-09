Return-Path: <martin-langer@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E77DBDDE40
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 04:54:31 +1100 (EST)
Received: from ml by tuba with local (Exim 4.50) id 1JNtno-0000qd-UT
	for linuxppc-dev@ozlabs.org; Sat, 09 Feb 2008 18:47:48 +0100
Date: Sat, 9 Feb 2008 18:47:48 +0100
From: Martin Langer <martin-langer@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix for Freescale ppc cores: major revision detection
Message-ID: <20080209174748.GA3245@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ppc cores by Freescale are using the configuration field instead of the 
major revision field for their major revision number. Those field 
definitions come from include/asm-powerpc/reg.h.

Look at the pdf below and you will see that PVR_MAJ() does a wrong shift 
for ppc cores by Freescale. This patch fixes it.

http://www.freescale.com/files/archives/doc/support_info/PPCPVR.pdf


Signed-Off-By: Martin Langer <martin-langer@gmx.de>


--- arch/powerpc/kernel/setup-common.c.ORIGINAL	2008-02-08 22:22:56.000000000 +0100
+++ arch/powerpc/kernel/setup-common.c	2008-02-09 18:18:36.000000000 +0100
@@ -241,7 +241,7 @@
 	/* If we are a Freescale core do a simple check so
 	 * we dont have to keep adding cases in the future */
 	if (PVR_VER(pvr) & 0x8000) {
-		maj = PVR_MAJ(pvr);
+		maj = (pvr >> 8) & 0xF;
 		min = PVR_MIN(pvr);
 	} else {
 		switch (PVR_VER(pvr)) {
