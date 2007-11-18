Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id DA5E0DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 09:36:33 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so953938uge
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 14:36:32 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Subject: [PATCH 4/21] ide/Kconfig: fix mpc8xx host driver dependencies
Date: Sun, 18 Nov 2007 23:15:19 +0100
MIME-Version: 1.0
Message-Id: <200711182315.19408.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Only LWMON, IVMS8, IVML24 and TQM8xxL platforms have the needed
defines (IDE0_BASE_OFFSET and friends) in the platform header file.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -951,7 +951,7 @@ config BLK_DEV_Q40IDE
 
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
-	depends on 8xx && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
+	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
 	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
