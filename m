Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB240DDF95
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 00:30:33 +1100 (EST)
Date: Sat, 3 Mar 2007 14:24:31 +0100 (MET)
Message-Id: <200703031324.l23DOVjO003638@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: benh@kernel.crashing.org, bzolnier@gmail.com
Subject: [PATCH 2.6.21-rc2] pmac ide: fix pmac_ide_dma_host_on() declaration
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Building 2.6.21-rc2 on a PowerMac, I get:

drivers/ide/ppc/pmac.c: In function 'pmac_ide_setup_dma':
drivers/ide/ppc/pmac.c:2042: warning: assignment from incompatible pointer type
drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_host_on':
drivers/ide/ppc/pmac.c:1988: warning: control reaches end of non-void function

These occur because ->dma_host_on should be a function
returning void, but pmac.c bogusly declares it as returning
int, and furthermore fails to return a value from it.

Correcting the return type to void fixes both warnings.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.21-rc2/drivers/ide/ppc/pmac.c.~1~	2007-03-03 12:31:07.000000000 +0100
+++ linux-2.6.21-rc2/drivers/ide/ppc/pmac.c	2007-03-03 13:18:56.000000000 +0100
@@ -1983,7 +1983,7 @@ static void pmac_ide_dma_host_off(ide_dr
 {
 }
 
-static int pmac_ide_dma_host_on(ide_drive_t *drive)
+static void pmac_ide_dma_host_on(ide_drive_t *drive)
 {
 }
 
