Return-Path: <B31383@freescale.com>
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:Enable USB2 controller node for P1020RDB
Date: Wed, 18 Jan 2012 11:20:39 +0530
Message-ID: <1326865839-3612-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree-discuss@lists.ozlabs.org,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable USB2 controller node for P1020RDB. USB2 controller is used only
when board boots from SPI or SD as it is muxed with eLBC

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
(branch next)

 arch/powerpc/boot/dts/p1020rdb.dtsi |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/p1020rdb.dtsi
index b5bd86f..17559c4 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1020 RDB Device Tree Source stub (no addresses or top-level ranges)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -192,15 +192,12 @@
 		phy_type = "ulpi";
 	};
 
-	/* USB2 is shared with localbus, so it must be disabled
-	   by default. We can't put 'status = "disabled";' here
-	   since U-Boot doesn't clear the status property when
-	   it enables USB2. OTOH, U-Boot does create a new node
-	   when there isn't any. So, just comment it out.
+	/* USB2 is shared with localbus. It is used
+	   only in case of SPI and SD boot after
+	   appropriate device-tree fixup done by uboot */
 	usb@23000 {
 		phy_type = "ulpi";
 	};
-	*/
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-- 
1.7.1
