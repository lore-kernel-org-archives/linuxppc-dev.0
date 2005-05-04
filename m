Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2C291679F5
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 14:13:48 +1000 (EST)
Date: Tue, 3 May 2005 21:52:19 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505032150260.19926@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Simplified PPC core revision report
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can identify new Freescale PPC cores by the fact that the MSB of the PVR is
set.  If we are a new Freescale core the decode of major/minor revision numbers
is simplified so we dont have to add new case checks for a every new Freescale
core.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1ecd8eef1f05b100f3933a7de25f88a3314b0a97
tree 739c8916a8f4edd214007de1dd8610d0e1c49235
parent cc75b79f8142eb8a50432cf612bb1ab189136cd0
author Kumar K. Gala <kumar.gala@freescale.com> 1115174649 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> 1115174649 -0500

Index: arch/ppc/kernel/setup.c
===================================================================
--- 79fd2184cd5cfee440f3ca2952f7c9f834ece443/arch/ppc/kernel/setup.c  (mode:100644 sha1:e97ce635b99e6d84640457c775c77d7eb49f4efb)
+++ 739c8916a8f4edd214007de1dd8610d0e1c49235/arch/ppc/kernel/setup.c  (mode:100644 sha1:5dfb42f1a1529d561bf73b5b5c1411a3e51f6402)
@@ -221,27 +221,26 @@
 			return err;
 	}
 
-	switch (PVR_VER(pvr)) {
-	case 0x0020:	/* 403 family */
-		maj = PVR_MAJ(pvr) + 1;
-		min = PVR_MIN(pvr);
-		break;
-	case 0x1008:	/* 740P/750P ?? */
-		maj = ((pvr >> 8) & 0xFF) - 1;
-		min = pvr & 0xFF;
-		break;
-	case 0x8083:	/* e300 */
-		maj = PVR_MAJ(pvr);
-		min = PVR_MIN(pvr);
-		break;
-	case 0x8020:	/* e500 */
+	/* If we are a Freescale core do a simple check so
+	 * we dont have to keep adding cases in the future */
+	if ((PVR_VER(pvr) & 0x8000) == 0x8000) {
 		maj = PVR_MAJ(pvr);
 		min = PVR_MIN(pvr);
-		break;
-	default:
-		maj = (pvr >> 8) & 0xFF;
-		min = pvr & 0xFF;
-		break;
+	} else {
+		switch (PVR_VER(pvr)) {
+			case 0x0020:	/* 403 family */
+				maj = PVR_MAJ(pvr) + 1;
+				min = PVR_MIN(pvr);
+				break;
+			case 0x1008:	/* 740P/750P ?? */
+				maj = ((pvr >> 8) & 0xFF) - 1;
+				min = pvr & 0xFF;
+				break;
+			default:
+				maj = (pvr >> 8) & 0xFF;
+				min = pvr & 0xFF;
+				break;
+		}
 	}
 
 	seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
