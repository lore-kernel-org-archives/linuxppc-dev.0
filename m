Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 09 Apr 2008 07:51:07 +1000
Subject: [PATCH] ata: Fix pata SIL680 build on arch/ppc
Message-Id: <20080408215204.73730DE0A8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 0f436eff54f90419ac1b8accfb3e6e17c4b49a4e breaks build on
arch/ppc as it doesn't implement the machine_is() macro.

This fixes it by using CONFIG_PPC_MERGE instead which represents
arch/powerpc only, while CONFIG_PPC is set for both.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 Index: linux-work/drivers/ata/pata_sil680.c
===================================================================
 drivers/ata/pata_sil680.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/drivers/ata/pata_sil680.c	2008-04-09 07:47:23.000000000 +1000
+++ linux-work/drivers/ata/pata_sil680.c	2008-04-09 07:47:29.000000000 +1000
@@ -270,7 +270,7 @@ static u8 sil680_init_chip(struct pci_de
 		tmpbyte & 1, tmpbyte & 0x30);
 
 	*try_mmio = 0;
-#ifdef CONFIG_PPC
+#ifdef CONFIG_PPC_MERGE
 	if (machine_is(cell))
 		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 #endif
