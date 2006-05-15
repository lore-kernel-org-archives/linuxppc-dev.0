Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 594C267B7A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:58:57 +1000 (EST)
Subject: [PATCH] powerpc: Fix ide-pmac sysfs entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 15 May 2006 16:58:37 +1000
Message-Id: <1147676318.21291.105.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like the generic ide code now wants ide_init_hwif_ports() to
set the parent struct device into the ide_hw structure (new field ?).
Without this, the mac ide code can cause the ide probing code to explode
in flames in sysfs registration due to what looks like a stale pointer
in there (happens when removing/re-inserting one of the hotswap media
bays on some laptops).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Andew: That's a 2.6.17 candidate 

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2006-04-19 15:04:47.000000000 +1000
+++ linux-work/drivers/ide/ppc/pmac.c	2006-05-15 16:43:20.000000000 +1000
@@ -553,6 +553,8 @@
 
 	if (irq != NULL)
 		*irq = pmac_ide[ix].irq;
+
+	hw->dev = &pmac_ide[ix].mdev->ofdev.dev;
 }
 
 #define PMAC_IDE_REG(x) ((void __iomem *)(IDE_DATA_REG+(x)))
 
