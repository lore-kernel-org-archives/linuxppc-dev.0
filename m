Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DBDCDDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 06:31:25 +1100 (EST)
Subject: [PATCH] Fix Maple PATA IRQ assignment.
From: David Woodhouse <dwmw2@infradead.org>
To: alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Content-Type: text/plain
Date: Mon, 01 Jan 2007 19:31:15 +0000
Message-Id: <1167679875.22068.350.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the Maple board, the AMD8111 IDE is in legacy mode... except that it
appears on IRQ 20 instead of IRQ 15. For drivers/ide this was handled by
the architecture's "pci_get_legacy_ide_irq()" function, but in libata we
just hard-code the numbers 14 and 15.

This patch provides asm-powerpc/libata-portmap.h which maps the IRQ as
appropriate, having added a pci_dev argument to the
ATA_{PRIM,SECOND}ARY_IRQ macros.

There's probably a better way to do this -- especially if we observe
that the _only_ case in which this seemingly-generic
"pci_get_legacy_ide_irq()" function returns anything other than 14 and
15 for primary and secondary respectively is the case of the AMD8111 on
the Maple board -- couldn't we handle that with a special case in the
pata_amd driver, or perhaps with a PCI quirk for Maple to switch it into
native mode during early boot and assign resources properly?

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0673dbe..1857707 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -484,6 +484,7 @@ config PPC_MAPLE
 	select PPC_970_NAP
 	select PPC_NATIVE
 	select PPC_RTAS
+	select ATA_NONSTANDARD if ATA
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7645f2b..bf44f6d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -879,7 +879,7 @@ static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 	probe_ent->n_ports = 2;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = ATA_PRIMARY_IRQ;
+		probe_ent->irq = ATA_PRIMARY_IRQ(pdev);
 		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
 		probe_ent->port[0].altstatus_addr =
 		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
@@ -894,9 +894,9 @@ static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 
 	if (port_mask & ATA_PORT_SECONDARY) {
 		if (probe_ent->irq)
-			probe_ent->irq2 = ATA_SECONDARY_IRQ;
+			probe_ent->irq2 = ATA_SECONDARY_IRQ(pdev);
 		else
-			probe_ent->irq = ATA_SECONDARY_IRQ;
+			probe_ent->irq = ATA_SECONDARY_IRQ(pdev);
 		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
 		probe_ent->port[1].altstatus_addr =
 		probe_ent->port[1].ctl_addr = ATA_SECONDARY_CTL;
diff --git a/include/asm-generic/libata-portmap.h b/include/asm-generic/libata-portmap.h
index 9202fd0..ec742ca 100644
--- a/include/asm-generic/libata-portmap.h
+++ b/include/asm-generic/libata-portmap.h
@@ -1,12 +1,12 @@
 #ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
 #define __ASM_GENERIC_LIBATA_PORTMAP_H
 
 #define ATA_PRIMARY_CMD		0x1F0
 #define ATA_PRIMARY_CTL		0x3F6
-#define ATA_PRIMARY_IRQ		14
+#define ATA_PRIMARY_IRQ(dev)	14
 
 #define ATA_SECONDARY_CMD	0x170
 #define ATA_SECONDARY_CTL	0x376
-#define ATA_SECONDARY_IRQ	15
+#define ATA_SECONDARY_IRQ(dev)	15
 
 #endif
--- /dev/null	2006-12-19 10:44:19.206057770 +0000
+++ b/include/asm-powerpc/libata-portmap.h	2006-12-31 00:32:04.000000000 +0000
@@ -0,0 +1,12 @@
+#ifndef __ASM_POWERPC_LIBATA_PORTMAP_H
+#define __ASM_POWERPC_LIBATA_PORTMAP_H
+
+#define ATA_PRIMARY_CMD	0x1F0
+#define ATA_PRIMARY_CTL	0x3F6
+#define ATA_PRIMARY_IRQ(dev)	pci_get_legacy_ide_irq(dev, 0)
+
+#define ATA_SECONDARY_CMD	0x170
+#define ATA_SECONDARY_CTL	0x376
+#define ATA_SECONDARY_IRQ(dev)	pci_get_legacy_ide_irq(dev, 1)
+
+#endif
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 03f6338..6a38c9b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -19,6 +19,10 @@ config ATA
 
 if ATA
 
+config ATA_NONSTANDARD
+       bool
+       default n
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI


-- 
dwmw2
