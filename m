Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77233DDFE1
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 05:26:24 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id m34IObTl018210
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 22:24:37 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id m34IObYH018207
	for linuxppc-dev@ozlabs.org; Fri, 4 Apr 2008 22:24:37 +0400
Date: Fri, 4 Apr 2008 22:24:37 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: use machine_device_initcall() instead of
	device_initcall() for warp_nand
Message-ID: <20080404182437.GA18185@ru.mvista.com>
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

With a multiplatform kernel, once built we always have warp_setup_nand_flash() called
and NDFC probed, no matter what machine we actually run on. This potentially can cause
problems (such as kernel crash), since NDFC is probed at a warp-predefined address.
Using machine_device_initcall() NAND devices are registered if we run on a warp only.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/platforms/44x/warp-nand.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/platforms/44x/warp-nand.c	2008-03-06 14:39:46.000000000 +0300
+++ linux-2.6.bld/arch/powerpc/platforms/44x/warp-nand.c	2008-04-04 22:03:36.000000000 +0400
@@ -11,6 +11,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/ndfc.h>
+#include <asm/machdep.h>
 
 #ifdef CONFIG_MTD_NAND_NDFC
 
@@ -100,6 +101,6 @@ static int warp_setup_nand_flash(void)
 
 	return 0;
 }
-device_initcall(warp_setup_nand_flash);
+machine_device_initcall(warp, warp_setup_nand_flash);
 
 #endif
