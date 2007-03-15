Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D717DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 17:28:32 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l2F6SSpj011032
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 15:28:28 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l2F6SS8d004490
	for linuxppc-dev@ozlabs.org; Thu, 15 Mar 2007 15:28:28 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l2F6SS1G027889
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 15:28:28 +0900 (JST)
Message-Id: <200703150628.l2F6SPa3028035@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 15:30:25 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: bzolnier@gmail.com, torvalds@linux-foundation.org
Subject: [PATCH] BLK_DEV_IDE_CELLEB dependency fix
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's bool and it depends on BLK_DEV_IDE
 => should depend on BLK_DEV_IDE=y

And move it to "if BLK_DEV_IDEDMA_PCI" block because it depends on 
BLK_DEV_IDEDMA_PCI.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ide/Kconfig linux-2.6.21-rc3.mod/drivers/ide/Kconfig
--- linux-2.6.21-rc3/drivers/ide/Kconfig	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ide/Kconfig	2007-03-15 23:49:33.000000000 +0900
@@ -769,6 +769,14 @@ config BLK_DEV_TC86C001
 	help
 	This driver adds support for Toshiba TC86C001 GOKU-S chip.
 
+config BLK_DEV_IDE_CELLEB
+	bool "Toshiba's Cell Reference Set IDE support"
+	depends on PPC_CELLEB && BLK_DEV_IDE=y
+	help
+	  This driver provides support for the built-in IDE controller on
+	  Toshiba Cell Reference Board.
+	  If unsure, say Y.
+
 endif
 
 config BLK_DEV_IDE_PMAC
@@ -800,14 +808,6 @@ config BLK_DEV_IDEDMA_PMAC
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
 
-config BLK_DEV_IDE_CELLEB
-	bool "Toshiba's Cell Reference Set IDE support"
-	depends on PPC_CELLEB
-	help
-	  This driver provides support for the built-in IDE controller on
-	  Toshiba Cell Reference Board.
-	  If unsure, say Y.
-
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
 	depends on SIBYTE_SB1xxx_SOC
