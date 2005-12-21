Return-Path: <ak@muc.de>
Received: from mail.muc.de (colin.muc.de [193.149.48.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "", Issuer "muc.de e.V." (not verified))
	by ozlabs.org (Postfix) with ESMTP id E65AD688E3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2005 23:18:45 +1100 (EST)
Date: 21 Dec 2005 13:12:01 +0100
Date: Wed, 21 Dec 2005 13:12:01 +0100
From: Andi Kleen <ak@muc.de>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Message-ID: <20051221121201.GA54164@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Don't allow CONFIG_PMAC_BACKLIGHT on pmac64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


For 2.6.15rc6-git2

Don't allow to set CONFIG_MAC_BACKLIGHT on pmac64. It won't compile.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux-2.6.15rc6git2/drivers/macintosh/Kconfig-o linux-2.6.15rc6git2/drivers/macintosh/Kconfig
--- linux-2.6.15rc6git2/drivers/macintosh/Kconfig-o	2005-12-21 12:27:45.000000000 +0100
+++ linux-2.6.15rc6git2/drivers/macintosh/Kconfig	2005-12-21 13:07:47.000000000 +0100
@@ -103,7 +103,7 @@
 # on non-powerbook machines (but only on PMU based ones AFAIK)
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU && (BROKEN || !PPC64)
+	depends on ADB_PMU && !PPC64
 	help
 	  Say Y here to build in code to manage the LCD backlight on a
 	  Macintosh PowerBook.  With this code, the backlight will be turned
