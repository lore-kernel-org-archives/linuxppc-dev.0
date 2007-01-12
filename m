Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB0CCDE256
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:59:29 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0C9xQd7013325
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:26 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0C9xQdp012915
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 18:59:26 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0C9xQVR016966
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:26 +0900 (JST)
Message-Id: <200701120959.l0C9xPWF020562@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 19:01:52 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 3/4] libata-sff.c: add low-level I/O calls
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using low-level I/O calls, similar functions
(ex: ata_tf_load_pio() and ata_tf_load_mmio()) can be merged.
And some branches which check MMIO/PIO flag can be removed.
The idea comes from drivers/ide IN*/OUT* calls.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-sff.c.orig	2007-01-13 01:01:56.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-sff.c	2007-01-13 01:03:05.000000000 +0900
@@ -56,10 +56,7 @@ u8 ata_irq_on(struct ata_port *ap)
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
+	ap->io_ops->OUTB(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
@@ -68,91 +65,42 @@ u8 ata_irq_on(struct ata_port *ap)
 }
 
 /**
- *	ata_tf_load_pio - send taskfile registers to host controller
+ *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
  *	Outputs ATA taskfile to standard ATA host controller.
+ *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ *	hob_lbal, hob_lbam, and hob_lbah.
  *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_tf_load_pio(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
-
-	if (tf->ctl != ap->last_ctl) {
-		outb(tf->ctl, ioaddr->ctl_addr);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
-
-	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		outb(tf->hob_feature, ioaddr->feature_addr);
-		outb(tf->hob_nsect, ioaddr->nsect_addr);
-		outb(tf->hob_lbal, ioaddr->lbal_addr);
-		outb(tf->hob_lbam, ioaddr->lbam_addr);
-		outb(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
-	}
-
-	if (is_addr) {
-		outb(tf->feature, ioaddr->feature_addr);
-		outb(tf->nsect, ioaddr->nsect_addr);
-		outb(tf->lbal, ioaddr->lbal_addr);
-		outb(tf->lbam, ioaddr->lbam_addr);
-		outb(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
-	}
-
-	if (tf->flags & ATA_TFLAG_DEVICE) {
-		outb(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
-
-	ata_wait_idle(ap);
-}
-
-/**
- *	ata_tf_load_mmio - send taskfile registers to host controller
- *	@ap: Port to which output is sent
- *	@tf: ATA taskfile register set
+ *	This function waits for idle (!BUSY and !DRQ) after writing
+ *	registers.  If the control register has a new value, this
+ *	function also waits for idle after writing control and before
+ *	writing the remaining registers.
  *
- *	Outputs ATA taskfile to standard ATA host controller using MMIO.
+ *	May be used as the tf_load() entry in ata_port_operations.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-
-static void ata_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		ap->io_ops->OUTB(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
-		writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
-		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
-		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
-		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		ap->io_ops->OUTB(tf->hob_feature, ioaddr->feature_addr);
+		ap->io_ops->OUTB(tf->hob_nsect, ioaddr->nsect_addr);
+		ap->io_ops->OUTB(tf->hob_lbal, ioaddr->lbal_addr);
+		ap->io_ops->OUTB(tf->hob_lbam, ioaddr->lbam_addr);
+		ap->io_ops->OUTB(tf->hob_lbah, ioaddr->lbah_addr);
 		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
 			tf->hob_feature,
 			tf->hob_nsect,
@@ -162,11 +110,11 @@ static void ata_tf_load_mmio(struct ata_
 	}
 
 	if (is_addr) {
-		writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
-		writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
-		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
-		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
-		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		ap->io_ops->OUTB(tf->feature, ioaddr->feature_addr);
+		ap->io_ops->OUTB(tf->nsect, ioaddr->nsect_addr);
+		ap->io_ops->OUTB(tf->lbal, ioaddr->lbal_addr);
+		ap->io_ops->OUTB(tf->lbam, ioaddr->lbam_addr);
+		ap->io_ops->OUTB(tf->lbah, ioaddr->lbah_addr);
 		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
 			tf->feature,
 			tf->nsect,
@@ -176,87 +124,13 @@ static void ata_tf_load_mmio(struct ata_
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
-		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		ap->io_ops->OUTB(tf->device, ioaddr->device_addr);
 		VPRINTK("device 0x%X\n", tf->device);
 	}
 
 	ata_wait_idle(ap);
 }
 
-
-/**
- *	ata_tf_load - send taskfile registers to host controller
- *	@ap: Port to which output is sent
- *	@tf: ATA taskfile register set
- *
- *	Outputs ATA taskfile to standard ATA host controller using MMIO
- *	or PIO as indicated by the ATA_FLAG_MMIO flag.
- *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
- *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
- *	hob_lbal, hob_lbam, and hob_lbah.
- *
- *	This function waits for idle (!BUSY and !DRQ) after writing
- *	registers.  If the control register has a new value, this
- *	function also waits for idle after writing control and before
- *	writing the remaining registers.
- *
- *	May be used as the tf_load() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_tf_load_mmio(ap, tf);
-	else
-		ata_tf_load_pio(ap, tf);
-}
-
-/**
- *	ata_exec_command_pio - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues PIO write to ATA command register, with proper
- *	synchronization with interrupt handler / other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static void ata_exec_command_pio(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
-
-       	outb(tf->command, ap->ioaddr.command_addr);
-	ata_pause(ap);
-}
-
-
-/**
- *	ata_exec_command_mmio - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues MMIO write to ATA command register, with proper
- *	synchronization with interrupt handler / other threads.
- *
- *	FIXME: missing write posting for 400nS delay enforcement
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static void ata_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
-
-       	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
-	ata_pause(ap);
-}
-
-
 /**
  *	ata_exec_command - issue ATA command to host controller
  *	@ap: port to which command is being issued
@@ -270,81 +144,12 @@ static void ata_exec_command_mmio(struct
  */
 void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_exec_command_mmio(ap, tf);
-	else
-		ata_exec_command_pio(ap, tf);
-}
-
-/**
- *	ata_tf_read_pio - input device's ATA taskfile shadow registers
- *	@ap: Port from which input is read
- *	@tf: ATA taskfile register set for storing input
- *
- *	Reads ATA taskfile registers for currently-selected device
- *	into @tf.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_tf_read_pio(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	tf->command = ata_check_status(ap);
-	tf->feature = inb(ioaddr->error_addr);
-	tf->nsect = inb(ioaddr->nsect_addr);
-	tf->lbal = inb(ioaddr->lbal_addr);
-	tf->lbam = inb(ioaddr->lbam_addr);
-	tf->lbah = inb(ioaddr->lbah_addr);
-	tf->device = inb(ioaddr->device_addr);
-
-	if (tf->flags & ATA_TFLAG_LBA48) {
-		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = inb(ioaddr->error_addr);
-		tf->hob_nsect = inb(ioaddr->nsect_addr);
-		tf->hob_lbal = inb(ioaddr->lbal_addr);
-		tf->hob_lbam = inb(ioaddr->lbam_addr);
-		tf->hob_lbah = inb(ioaddr->lbah_addr);
-	}
-}
-
-/**
- *	ata_tf_read_mmio - input device's ATA taskfile shadow registers
- *	@ap: Port from which input is read
- *	@tf: ATA taskfile register set for storing input
- *
- *	Reads ATA taskfile registers for currently-selected device
- *	into @tf via MMIO.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	tf->command = ata_check_status(ap);
-	tf->feature = readb((void __iomem *)ioaddr->error_addr);
-	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
-	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
-	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
-	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
-	tf->device = readb((void __iomem *)ioaddr->device_addr);
+	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
-	if (tf->flags & ATA_TFLAG_LBA48) {
-		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
-		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
-		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
-		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
-		tf->hob_lbah = readb((void __iomem *)ioaddr->lbah_addr);
-	}
+       	ap->io_ops->OUTB(tf->command, ap->ioaddr.command_addr);
+	ata_pause(ap);
 }
 
-
 /**
  *	ata_tf_read - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
@@ -363,45 +168,26 @@ static void ata_tf_read_mmio(struct ata_
  */
 void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_tf_read_mmio(ap, tf);
-	else
-		ata_tf_read_pio(ap, tf);
-}
+	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-/**
- *	ata_check_status_pio - Read device status reg & clear interrupt
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile status register for currently-selected device
- *	and return its value. This also clears pending interrupts
- *      from this device
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-static u8 ata_check_status_pio(struct ata_port *ap)
-{
-	return inb(ap->ioaddr.status_addr);
-}
+	tf->command = ata_check_status(ap);
+	tf->feature = ap->io_ops->INB(ioaddr->error_addr);
+	tf->nsect = ap->io_ops->INB(ioaddr->nsect_addr);
+	tf->lbal = ap->io_ops->INB(ioaddr->lbal_addr);
+	tf->lbam = ap->io_ops->INB(ioaddr->lbam_addr);
+	tf->lbah = ap->io_ops->INB(ioaddr->lbah_addr);
+	tf->device = ap->io_ops->INB(ioaddr->device_addr);
 
-/**
- *	ata_check_status_mmio - Read device status reg & clear interrupt
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile status register for currently-selected device
- *	via MMIO and return its value. This also clears pending interrupts
- *      from this device
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-static u8 ata_check_status_mmio(struct ata_port *ap)
-{
-       	return readb((void __iomem *) ap->ioaddr.status_addr);
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		ap->io_ops->OUTB(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+		tf->hob_feature = ap->io_ops->INB(ioaddr->error_addr);
+		tf->hob_nsect = ap->io_ops->INB(ioaddr->nsect_addr);
+		tf->hob_lbal = ap->io_ops->INB(ioaddr->lbal_addr);
+		tf->hob_lbam = ap->io_ops->INB(ioaddr->lbam_addr);
+		tf->hob_lbah = ap->io_ops->INB(ioaddr->lbah_addr);
+	}
 }
 
-
 /**
  *	ata_check_status - Read device status reg & clear interrupt
  *	@ap: port where the device is
@@ -417,9 +203,7 @@ static u8 ata_check_status_mmio(struct a
  */
 u8 ata_check_status(struct ata_port *ap)
 {
-	if (ap->flags & ATA_FLAG_MMIO)
-		return ata_check_status_mmio(ap);
-	return ata_check_status_pio(ap);
+	return ap->io_ops->INB(ap->ioaddr.status_addr);
 }
 
 
@@ -441,58 +225,29 @@ u8 ata_altstatus(struct ata_port *ap)
 	if (ap->ops->check_altstatus)
 		return ap->ops->check_altstatus(ap);
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
-	return inb(ap->ioaddr.altstatus_addr);
+	return ap->io_ops->INB(ap->ioaddr.altstatus_addr);
 }
 
 /**
- *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-	/* load PRD table addr. */
-	mb();	/* make sure PRD table writes are visible to controller */
-	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	writeb(dmactl, mmio + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
+ *	Writes the ATA_DMA_START flag to the DMA command register.
+ *
+ *	May be used as the bmdma_start() entry in ata_port_operations.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+void ata_bmdma_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 	u8 dmactl;
 
 	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+	dmactl = ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	ap->io_ops->OUTB(dmactl | ATA_DMA_START,
+	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
 	 * flush the mmio write.  However, control also passes
@@ -507,95 +262,42 @@ static void ata_bmdma_start_mmio (struct
 	 */
 }
 
+
 /**
- *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
+ *	Writes address of PRD table to device's PRD Table Address
+ *	register, sets the DMA control register, and calls
+ *	ops->exec_command() to start the transfer.
+ *
+ *	May be used as the bmdma_setup() entry in ata_port_operations.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 dmactl;
 
 	/* load PRD table addr. */
-	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		mb();	/* make sure PRD table writes are visible to controller */
+	ap->io_ops->OUTL(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
 	/* specify data direction, triple-check start bit is clear */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl = ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
 	if (!rw)
 		dmactl |= ATA_DMA_WR;
-	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	ap->io_ops->OUTB(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
 
-/**
- *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	outb(dmactl | ATA_DMA_START,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-}
-
-
-/**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes the ATA_DMA_START flag to the DMA command register.
- *
- *	May be used as the bmdma_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_start(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_start_mmio(qc);
-	else
-		ata_bmdma_start_pio(qc);
-}
-
-
-/**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes address of PRD table to device's PRD Table Address
- *	register, sets the DMA control register, and calls
- *	ops->exec_command() to start the transfer.
- *
- *	May be used as the bmdma_setup() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_setup_mmio(qc);
-	else
-		ata_bmdma_setup_pio(qc);
-}
-
 
 /**
  *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
@@ -611,17 +313,12 @@ void ata_bmdma_setup(struct ata_queued_c
 
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
+	unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+
 	if (!ap->ioaddr.bmdma_addr)
 		return;
 
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio =
-		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-		writeb(readb(mmio), mmio);
-	} else {
-		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-		outb(inb(addr), addr);
-	}
+	ap->io_ops->OUTB(ap->io_ops->INB(addr), addr);
 }
 
 
@@ -640,11 +337,7 @@ void ata_bmdma_irq_clear(struct ata_port
 u8 ata_bmdma_status(struct ata_port *ap)
 {
 	u8 host_stat;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	host_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	return host_stat;
 }
 
@@ -664,17 +357,10 @@ u8 ata_bmdma_status(struct ata_port *ap)
 void ata_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-			mmio + ATA_DMA_CMD);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	}
+	/* clear start/stop bit */
+	ap->io_ops->OUTB(ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		      ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_altstatus(ap);        /* dummy read */
@@ -696,10 +382,7 @@ void ata_bmdma_freeze(struct ata_port *a
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
+	ap->io_ops->OUTB(ap->ctl, ioaddr->ctl_addr);
 
 	/* Under certain circumstances, some controllers raise IRQ on
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
