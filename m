Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 603F8DDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 18:56:59 +1000 (EST)
Subject: [PATCH] Fix non-terminated PCI match table in PowerMac IDE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Sat, 06 Oct 2007 18:52:27 +1000
Message-Id: <1191660747.6540.5.camel@pasglop>
Mime-Version: 1.0
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Heikki Lindholm <holindho@cs.helsinki.fi>,
	Paul Mackerras <pmac@au1.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI device table in the powermac IDE driver isn't properly
terminated. Depending on how your kernel is linked and other random
factors, you can end up with this driver matched against any other PCI
device in your system, possibly crashing at boot.

Thanks to Heikki for tracking this down with me, the bug have been there
for some time, though it rarely hurts due to luck. In this case, the
switch from .22 to .23-rc9 is causing it to show up due to differences
in the resulting layout of .data I suppose.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

If that can still make it in .23, that would be great. I'll also get it
in the various -stable releases.

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index f19eb6d..2fb047b 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1546,6 +1546,7 @@ static struct pci_device_id pmac_ide_pci_match[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{},
 };
 
 static struct pci_driver pmac_ide_pci_driver = {
