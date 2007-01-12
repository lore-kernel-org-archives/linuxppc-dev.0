Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11A7CDDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:59:15 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0C9xC9c013149
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:12 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0C9xCVx012627
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 18:59:12 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0C9xB95016603
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:11 +0900 (JST)
Message-Id: <200701120959.l0C9xAKT026918@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 19:01:37 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 2/4] libata-core.c: add low-level I/O calls
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
(ex: ata_pio_devchk() and ata_mmio_devchk()) can be merged.
And some branches which check MMIO/PIO flag can be removed.
The idea comes from drivers/ide IN*/OUT* calls.

By default, depending on the flag, default_pio_ops or default_mmio_ops
are used as low-level I/O calls. If your device needs special I/O calls
(ex: 32bit access in Celleb), you must initialize .io_ops in ata_port_info
and pass it to appropriate initialization functions (ex: ata_pci_init_one()).

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-core.c.orig	2007-01-13 01:01:50.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-core.c	2007-01-13 01:02:58.000000000 +0900
@@ -598,51 +598,7 @@ void ata_dev_disable(struct ata_device *
 }
 
 /**
- *	ata_pio_devchk - PATA device presence detection
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
- *
- *	This technique was originally described in
- *	Hale Landis's ATADRVR (www.ata-atapi.com), and
- *	later found its way into the ATA/ATAPI spec.
- *
- *	Write a pattern to the ATA shadow registers,
- *	and if a device is present, it will respond by
- *	correctly storing and echoing back the
- *	ATA shadow register contents.
- *
- *	LOCKING:
- *	caller.
- */
-
-static unsigned int ata_pio_devchk(struct ata_port *ap,
-				   unsigned int device)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 nsect, lbal;
-
-	ap->ops->dev_select(ap, device);
-
-	outb(0x55, ioaddr->nsect_addr);
-	outb(0xaa, ioaddr->lbal_addr);
-
-	outb(0xaa, ioaddr->nsect_addr);
-	outb(0x55, ioaddr->lbal_addr);
-
-	outb(0x55, ioaddr->nsect_addr);
-	outb(0xaa, ioaddr->lbal_addr);
-
-	nsect = inb(ioaddr->nsect_addr);
-	lbal = inb(ioaddr->lbal_addr);
-
-	if ((nsect == 0x55) && (lbal == 0xaa))
-		return 1;	/* we found a device */
-
-	return 0;		/* nothing found */
-}
-
-/**
- *	ata_mmio_devchk - PATA device presence detection
+ *	ata_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
  *
@@ -659,7 +615,7 @@ static unsigned int ata_pio_devchk(struc
  *	caller.
  */
 
-static unsigned int ata_mmio_devchk(struct ata_port *ap,
+static unsigned int ata_devchk(struct ata_port *ap,
 				    unsigned int device)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -667,17 +623,17 @@ static unsigned int ata_mmio_devchk(stru
 
 	ap->ops->dev_select(ap, device);
 
-	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+	ap->io_ops->OUTB(0x55, ioaddr->nsect_addr);
+	ap->io_ops->OUTB(0xaa, ioaddr->lbal_addr);
 
-	writeb(0xaa, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0x55, (void __iomem *) ioaddr->lbal_addr);
+	ap->io_ops->OUTB(0xaa, ioaddr->nsect_addr);
+	ap->io_ops->OUTB(0x55, ioaddr->lbal_addr);
 
-	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+	ap->io_ops->OUTB(0x55, ioaddr->nsect_addr);
+	ap->io_ops->OUTB(0xaa, ioaddr->lbal_addr);
 
-	nsect = readb((void __iomem *) ioaddr->nsect_addr);
-	lbal = readb((void __iomem *) ioaddr->lbal_addr);
+	nsect = ap->io_ops->INB(ioaddr->nsect_addr);
+	lbal = ap->io_ops->INB(ioaddr->lbal_addr);
 
 	if ((nsect == 0x55) && (lbal == 0xaa))
 		return 1;	/* we found a device */
@@ -686,27 +642,6 @@ static unsigned int ata_mmio_devchk(stru
 }
 
 /**
- *	ata_devchk - PATA device presence detection
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
- *
- *	Dispatch ATA device presence detection, depending
- *	on whether we are using PIO or MMIO to talk to the
- *	ATA shadow registers.
- *
- *	LOCKING:
- *	caller.
- */
-
-static unsigned int ata_devchk(struct ata_port *ap,
-				    unsigned int device)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		return ata_mmio_devchk(ap, device);
-	return ata_pio_devchk(ap, device);
-}
-
-/**
  *	ata_dev_classify - determine device type based on ATA-spec signature
  *	@tf: ATA taskfile register set for device to be identified
  *
@@ -923,11 +858,7 @@ void ata_std_dev_select (struct ata_port
 	else
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
-	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(tmp, (void __iomem *) ap->ioaddr.device_addr);
-	} else {
-		outb(tmp, ap->ioaddr.device_addr);
-	}
+	ap->io_ops->OUTB(tmp, ap->ioaddr.device_addr);
 	ata_pause(ap);		/* needed; also flushes, for mmio */
 }
 
@@ -2623,13 +2554,8 @@ static void ata_bus_post_reset(struct at
 		u8 nsect, lbal;
 
 		ap->ops->dev_select(ap, 1);
-		if (ap->flags & ATA_FLAG_MMIO) {
-			nsect = readb((void __iomem *) ioaddr->nsect_addr);
-			lbal = readb((void __iomem *) ioaddr->lbal_addr);
-		} else {
-			nsect = inb(ioaddr->nsect_addr);
-			lbal = inb(ioaddr->lbal_addr);
-		}
+		nsect = ap->io_ops->INB(ioaddr->nsect_addr);
+		lbal = ap->io_ops->INB(ioaddr->lbal_addr);
 		if ((nsect == 1) && (lbal == 1))
 			break;
 		if (time_after(jiffies, timeout)) {
@@ -2657,19 +2583,11 @@ static unsigned int ata_bus_softreset(st
 	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
 
 	/* software reset.  causes dev0 to be selected */
-	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	} else {
-		outb(ap->ctl, ioaddr->ctl_addr);
-		udelay(10);
-		outb(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
-		udelay(10);
-		outb(ap->ctl, ioaddr->ctl_addr);
-	}
+	ap->io_ops->OUTB(ap->ctl, ioaddr->ctl_addr);
+	udelay(20);
+	ap->io_ops->OUTB(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
+	udelay(20);
+	ap->io_ops->OUTB(ap->ctl, ioaddr->ctl_addr);
 
 	/* spec mandates ">= 2ms" before checking status.
 	 * We wait 150ms, because that was the magic delay used for
@@ -2770,10 +2688,7 @@ void ata_bus_reset(struct ata_port *ap)
 
 	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
 		/* set up device control for ATA_FLAG_SATA_RESET */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
+		ap->io_ops->OUTB(ap->ctl, ioaddr->ctl_addr);
 	}
 
 	DPRINTK("EXIT\n");
@@ -3167,10 +3082,7 @@ void ata_std_postreset(struct ata_port *
 
 	/* set up device control */
 	if (ap->ioaddr.ctl_addr) {
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
-		else
-			outb(ap->ctl, ap->ioaddr.ctl_addr);
+		ap->io_ops->OUTB(ap->ctl, ap->ioaddr.ctl_addr);
 	}
 
 	DPRINTK("EXIT\n");
@@ -3919,19 +3831,13 @@ void ata_mmio_data_xfer(struct ata_devic
 			unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->ap;
-	unsigned int i;
 	unsigned int words = buflen >> 1;
-	u16 *buf16 = (u16 *) buf;
-	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
 	/* Transfer multiple of 2 bytes */
-	if (write_data) {
-		for (i = 0; i < words; i++)
-			writew(le16_to_cpu(buf16[i]), mmio);
-	} else {
-		for (i = 0; i < words; i++)
-			buf16[i] = cpu_to_le16(readw(mmio));
-	}
+	if (write_data)
+		ap->io_ops->OUTSW(ap->ioaddr.data_addr, buf, words);
+	else
+		ap->io_ops->INSW(ap->ioaddr.data_addr, buf, words);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
@@ -3940,9 +3846,9 @@ void ata_mmio_data_xfer(struct ata_devic
 
 		if (write_data) {
 			memcpy(align_buf, trailing_buf, 1);
-			writew(le16_to_cpu(align_buf[0]), mmio);
+			ap->io_ops->OUTW(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
 		} else {
-			align_buf[0] = cpu_to_le16(readw(mmio));
+			align_buf[0] = cpu_to_le16(ap->io_ops->INW(ap->ioaddr.data_addr));
 			memcpy(trailing_buf, align_buf, 1);
 		}
 	}
@@ -3969,9 +3875,9 @@ void ata_pio_data_xfer(struct ata_device
 
 	/* Transfer multiple of 2 bytes */
 	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, words);
+		ap->io_ops->OUTSW(ap->ioaddr.data_addr, buf, words);
 	else
-		insw(ap->ioaddr.data_addr, buf, words);
+		ap->io_ops->INSW(ap->ioaddr.data_addr, buf, words);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
@@ -3980,9 +3886,9 @@ void ata_pio_data_xfer(struct ata_device
 
 		if (write_data) {
 			memcpy(align_buf, trailing_buf, 1);
-			outw(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
+			ap->io_ops->OUTW(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
 		} else {
-			align_buf[0] = cpu_to_le16(inw(ap->ioaddr.data_addr));
+			align_buf[0] = cpu_to_le16(ap->io_ops->INW(ap->ioaddr.data_addr));
 			memcpy(trailing_buf, align_buf, 1);
 		}
 	}
@@ -5621,12 +5527,14 @@ void ata_port_init(struct ata_port *ap, 
 		ap->udma_mask = ent->pinfo2->udma_mask;
 		ap->flags |= ent->pinfo2->flags;
 		ap->ops = ent->pinfo2->port_ops;
+		ap->io_ops = ent->pinfo2->io_ops;
 	} else {
 		ap->pio_mask = ent->pio_mask;
 		ap->mwdma_mask = ent->mwdma_mask;
 		ap->udma_mask = ent->udma_mask;
 		ap->flags |= ent->port_flags;
 		ap->ops = ent->port_ops;
+		ap->io_ops = ent->io_ops;
 	}
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
@@ -5732,6 +5640,126 @@ static struct ata_port * ata_port_add(co
 	return ap;
 }
 
+/*
+ *	Conventional PIO operations for ATA devices
+ */
+
+static u8 ata_inb (unsigned long port)
+{
+	return (u8) inb(port);
+}
+
+static u16 ata_inw (unsigned long port)
+{
+	return (u16) inw(port);
+}
+
+static void ata_insw (unsigned long port, void *addr, u32 count)
+{
+	insw(port, addr, count);
+}
+
+static u32 ata_inl (unsigned long port)
+{
+	return (u32) inl(port);
+}
+
+static void ata_outb (u8 val, unsigned long port)
+{
+	outb(val, port);
+}
+
+static void ata_outw (u16 val, unsigned long port)
+{
+	outw(val, port);
+}
+
+static void ata_outsw (unsigned long port, void *addr, u32 count)
+{
+	outsw(port, addr, count);
+}
+
+static void ata_outl (u32 val, unsigned long port)
+{
+	outl(val, port);
+}
+
+/*
+ *	Conventional MMIO operations for ATA devices
+ */
+
+static u8 ata_mm_inb (unsigned long port)
+{
+	return (u8) readb((void __iomem *) port);
+}
+
+static u16 ata_mm_inw (unsigned long port)
+{
+	return (u16) readw((void __iomem *) port);
+}
+
+static void ata_mm_insw (unsigned long port, void *addr, u32 count)
+{
+	unsigned int i;
+	u16 *buf16 = (u16 *) addr;
+	void __iomem *mmio = (void __iomem *) port;
+
+	for (i = 0; i < count; i++)
+		buf16[i] = cpu_to_le16(readw(mmio));
+}
+
+static u32 ata_mm_inl (unsigned long port)
+{
+	return (u32) readl((void __iomem *) port);
+}
+
+static void ata_mm_outb (u8 value, unsigned long port)
+{
+	writeb(value, (void __iomem *) port);
+}
+
+static void ata_mm_outw (u16 value, unsigned long port)
+{
+	writew(value, (void __iomem *) port);
+}
+
+static void ata_mm_outsw (unsigned long port, void *addr, u32 count)
+{
+	unsigned int i;
+	u16 *buf16 = (u16 *) addr;
+	void __iomem *mmio = (void __iomem *) port;
+
+	for (i = 0; i < count; i++)
+		writew(le16_to_cpu(buf16[i]), mmio);
+}
+
+static void ata_mm_outl (u32 value, unsigned long port)
+{
+	writel(value, (void __iomem *) port);
+}
+
+static struct ata_io_operations default_pio_ops = {
+	.OUTB                   = ata_outb,
+	.OUTW                   = ata_outw,
+	.OUTL                   = ata_outl,
+	.OUTSW                  = ata_outsw,
+	.INB                    = ata_inb,
+	.INW                    = ata_inw,
+	.INL                    = ata_inl,
+	.INSW                   = ata_insw,
+};
+
+static struct ata_io_operations default_mmio_ops = {
+	.OUTB                   = ata_mm_outb,
+	.OUTW                   = ata_mm_outw,
+	.OUTL                   = ata_mm_outl,
+	.OUTSW                  = ata_mm_outsw,
+	.INB                    = ata_mm_inb,
+	.INW                    = ata_mm_inw,
+	.INL                    = ata_mm_inl,
+	.INSW                   = ata_mm_insw,
+};
+
 /**
  *	ata_sas_host_init - Initialize a host struct
  *	@host:	host to initialize
@@ -5745,12 +5773,16 @@ static struct ata_port * ata_port_add(co
  */
 
 void ata_host_init(struct ata_host *host, struct device *dev,
-		   unsigned long flags, const struct ata_port_operations *ops)
+		   unsigned long flags, const struct ata_port_operations *ops,
+		   struct ata_io_operations *io_ops)
 {
 	spin_lock_init(&host->lock);
 	host->dev = dev;
 	host->flags = flags;
 	host->ops = ops;
+
+	if (!io_ops)
+		host->io_ops = flags & ATA_FLAG_MMIO ? &default_mmio_ops : &default_pio_ops;
 }
 
 /**
@@ -5790,7 +5822,7 @@ int ata_device_add(const struct ata_prob
 	if (!host)
 		return 0;
 
-	ata_host_init(host, dev, ent->_host_flags, ent->port_ops);
+	ata_host_init(host, dev, ent->_host_flags, ent->port_ops, ent->io_ops);
 	host->n_ports = ent->n_ports;
 	host->irq = ent->irq;
 	host->irq2 = ent->irq2;
@@ -6110,6 +6142,7 @@ ata_probe_ent_alloc(struct device *dev, 
 	probe_ent->mwdma_mask = port->mwdma_mask;
 	probe_ent->udma_mask = port->udma_mask;
 	probe_ent->port_ops = port->port_ops;
+	probe_ent->io_ops = port->io_ops;
 	probe_ent->private_data = port->private_data;
 
 	return probe_ent;
@@ -6500,3 +6533,5 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+
+EXPORT_SYMBOL_GPL(ata_probe_ent_alloc);
