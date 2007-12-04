Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 21CD1DE363
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:03:43 +1100 (EST)
Date: Tue, 4 Dec 2007 20:07:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 4/4] [libata] pata_platform: s/ioport_shift/reg_shift/g
Message-ID: <20071204170745.GD15599@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071204170442.GA10460@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch renames ioport_shift member of pata_platform_info
structure to reg_shift. Users of pata_platform are followed
appropriately.

Rationale of that change is: shifting applies to the whole memory
mapped region, not only to the command block of the ATA registers,
despite the fact that shifting is meaningless for ctl register.

This patch should make Sergei Shtylyov a bit more happy. ;-)

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/arm/mach-rpc/riscpc.c                      |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf533/boards/cm_bf533.c      |    2 +-
 arch/blackfin/mach-bf533/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf533/boards/stamp.c         |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537.c      |    2 +-
 arch/blackfin/mach-bf537/boards/generic_board.c |    2 +-
 arch/blackfin/mach-bf537/boards/stamp.c         |    2 +-
 arch/blackfin/mach-bf561/boards/cm_bf561.c      |    2 +-
 arch/blackfin/mach-bf561/boards/ezkit.c         |    2 +-
 arch/sh/boards/landisk/setup.c                  |    2 +-
 arch/sh/boards/renesas/r7780rp/setup.c          |    2 +-
 arch/sh/boards/renesas/rts7751r2d/setup.c       |    2 +-
 drivers/ata/pata_platform.c                     |    8 ++++----
 drivers/ide/legacy/ide_platform.c               |    4 ++--
 include/linux/pata_platform.h                   |    4 ++--
 16 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index a454451..be413c1 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -161,7 +161,7 @@ static struct platform_device serial_device = {
 };
 
 static struct pata_platform_info pata_platform_data = {
-	.ioport_shift		= 2,
+	.reg_shift		= 2,
 };
 
 static struct resource pata_resources[] = {
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 003e2ac..c9b20bd 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -685,7 +685,7 @@ static struct platform_device bfin_sport1_uart_device = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c b/arch/blackfin/mach-bf533/boards/cm_bf533.c
index 21df2f3..6cc697d 100644
--- a/arch/blackfin/mach-bf533/boards/cm_bf533.c
+++ b/arch/blackfin/mach-bf533/boards/cm_bf533.c
@@ -289,7 +289,7 @@ static struct platform_device isp1362_hcd_device = {
 #define PATA_INT	38
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 2,
+	.reg_shift = 2,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index be85203..030dc64 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -223,7 +223,7 @@ static struct platform_device bfin_uart_device = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index 8fde8d8..6ff0b88 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -340,7 +340,7 @@ static struct platform_device bfin_sport1_uart_device = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537.c b/arch/blackfin/mach-bf537/boards/cm_bf537.c
index c0fb06d..031da0f 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537.c
@@ -340,7 +340,7 @@ static struct platform_device bfin_mac_device = {
 #define PATA_INT	64
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 2,
+	.reg_shift = 2,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf537/boards/generic_board.c b/arch/blackfin/mach-bf537/boards/generic_board.c
index 09f4bfb..e217eb2 100644
--- a/arch/blackfin/mach-bf537/boards/generic_board.c
+++ b/arch/blackfin/mach-bf537/boards/generic_board.c
@@ -613,7 +613,7 @@ static struct platform_device bfin_sport1_uart_device = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 07b0dc2..daeb0d5 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -640,7 +640,7 @@ static struct platform_device bfin_sport1_uart_device = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_flags = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin/mach-bf561/boards/cm_bf561.c
index c19cd29..5628e34 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -280,7 +280,7 @@ static struct platform_device bfin_uart_device = {
 #define PATA_INT	119
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 2,
+	.reg_shift = 2,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 4ff8f6e..6894472 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -213,7 +213,7 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 #define PATA_INT	55
 
 static struct pata_platform_info bfin_pata_platform_data = {
-	.ioport_shift = 1,
+	.reg_shift = 1,
 	.irq_type = IRQF_TRIGGER_HIGH | IRQF_DISABLED,
 };
 
diff --git a/arch/sh/boards/landisk/setup.c b/arch/sh/boards/landisk/setup.c
index eda7176..46330f7 100644
--- a/arch/sh/boards/landisk/setup.c
+++ b/arch/sh/boards/landisk/setup.c
@@ -31,7 +31,7 @@ static void landisk_power_off(void)
 static struct resource cf_ide_resources[3];
 
 static struct pata_platform_info pata_info = {
-	.ioport_shift	= 1,
+	.reg_shift	= 1,
 };
 
 static struct platform_device cf_ide_device = {
diff --git a/arch/sh/boards/renesas/r7780rp/setup.c b/arch/sh/boards/renesas/r7780rp/setup.c
index 0fdc0bc..1fc9c9b 100644
--- a/arch/sh/boards/renesas/r7780rp/setup.c
+++ b/arch/sh/boards/renesas/r7780rp/setup.c
@@ -94,7 +94,7 @@ static struct resource cf_ide_resources[] = {
 };
 
 static struct pata_platform_info pata_info = {
-	.ioport_shift	= 1,
+	.reg_shift	= 1,
 };
 
 static struct platform_device cf_ide_device  = {
diff --git a/arch/sh/boards/renesas/rts7751r2d/setup.c b/arch/sh/boards/renesas/rts7751r2d/setup.c
index 8125d20..8bcca50 100644
--- a/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ b/arch/sh/boards/renesas/rts7751r2d/setup.c
@@ -62,7 +62,7 @@ static struct resource cf_ide_resources[] = {
 };
 
 static struct pata_platform_info pata_info = {
-	.ioport_shift	= 1,
+	.reg_shift	= 1,
 };
 
 static struct platform_device cf_ide_device  = {
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index d4cb231..3e7d2eb 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -114,7 +114,7 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
  *	@io_res: Resource representing I/O base
  *	@ctl_res: Resource representing CTL base
  *	@irq_res: Resource representing IRQ and its flags
- *	@ioport_shift: I/O port shift
+ *	@reg_shift: I/O port shift
  *
  *	Register a platform bus IDE interface. Such interfaces are PIO and we
  *	assume do not support IRQ sharing.
@@ -138,7 +138,7 @@ int __devinit __pata_platform_probe(struct device *dev,
 				    struct resource *io_res,
 				    struct resource *ctl_res,
 				    struct resource *irq_res,
-				    unsigned int ioport_shift,
+				    unsigned int reg_shift,
 				    int __pio_mask)
 {
 	struct ata_host *host;
@@ -202,7 +202,7 @@ int __devinit __pata_platform_probe(struct device *dev,
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
+	pata_platform_setup_port(&ap->ioaddr, reg_shift);
 
 	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
 		      (unsigned long long)io_res->start,
@@ -274,7 +274,7 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 		irq_res->flags = pp_info ? pp_info->irq_flags : 0;
 
 	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
-				     pp_info ? pp_info->ioport_shift : 0,
+				     pp_info ? pp_info->reg_shift : 0,
 				     pio_mask);
 }
 
diff --git a/drivers/ide/legacy/ide_platform.c b/drivers/ide/legacy/ide_platform.c
index 7bb79f5..3cee1b2 100644
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -41,9 +41,9 @@ static ide_hwif_t *__devinit plat_ide_locate_hwif(void __iomem *base,
 
 	hwif->io_ports[IDE_DATA_OFFSET] = port;
 
-	port += (1 << pdata->ioport_shift);
+	port += (1 << pdata->reg_shift);
 	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET;
-	     i++, port += (1 << pdata->ioport_shift))
+	     i++, port += (1 << pdata->reg_shift))
 		hwif->io_ports[i] = port;
 
 	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
diff --git a/include/linux/pata_platform.h b/include/linux/pata_platform.h
index 6a7a92d..a0fc6b0 100644
--- a/include/linux/pata_platform.h
+++ b/include/linux/pata_platform.h
@@ -7,7 +7,7 @@ struct pata_platform_info {
 	 * constantly spaced and need larger than the 1-byte
 	 * spacing used by ata_std_ports().
 	 */
-	unsigned int ioport_shift;
+	unsigned int reg_shift;
 	/* 
 	 * Indicate platform specific irq types and initial
 	 * IRQ flags when call request_irq()
@@ -19,7 +19,7 @@ extern int __devinit __pata_platform_probe(struct device *dev,
 					   struct resource *io_res,
 					   struct resource *ctl_res,
 					   struct resource *irq_res,
-					   unsigned int ioport_shift,
+					   unsigned int reg_shift,
 					   int __pio_mask);
 
 extern int __devexit __pata_platform_remove(struct device *dev);
-- 
1.5.2.2
