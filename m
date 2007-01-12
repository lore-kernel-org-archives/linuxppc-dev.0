Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57A96DDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:58:52 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0C9wmTZ018485
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:58:48 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0C9wmvY023786
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 18:58:48 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0C9wjME013416
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:58:46 +0900 (JST)
Message-Id: <200701120958.l0C9wige019852@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 19:01:11 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 1/4] libata.h: add low-level I/O calls
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

struct ata_io_operations has low-level I/O calls to access
the taskfile registers. The idea comes from drivers/ide
IN*/OUT* calls.

Current access functions in libata (ex: inb()) is replaced
by these calls, like
	inb()  ->   ap->io_ops->INB()

To initialize this operation in ata_port, there are
additional members in ata_probe_ent, ata_host and ata_port_info.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/include/linux/libata.h.orig	2007-01-13 01:02:28.000000000 +0900
+++ linux-2.6.20-rc4/include/linux/libata.h	2007-01-13 01:03:24.000000000 +0900
@@ -372,6 +372,7 @@ struct ata_probe_ent {
 	struct list_head	node;
 	struct device 		*dev;
 	const struct ata_port_operations *port_ops;
+	struct ata_io_operations *io_ops;
 	struct scsi_host_template *sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
@@ -405,6 +406,7 @@ struct ata_host {
 	unsigned int		n_ports;
 	void			*private_data;
 	const struct ata_port_operations *ops;
+	struct ata_io_operations *io_ops;
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
@@ -534,6 +536,7 @@ struct ata_eh_context {
 struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
+	struct ata_io_operations *io_ops;
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
@@ -655,6 +658,18 @@ struct ata_port_operations {
 	u8   (*bmdma_status) (struct ata_port *ap);
 };
 
+struct ata_io_operations {
+	void (*OUTB)(u8 addr, unsigned long port);
+	void (*OUTW)(u16 addr, unsigned long port);
+	void (*OUTL)(u32 addr, unsigned long port);
+	void (*OUTSW)(unsigned long port, void *addr, u32 count);
+
+	u8  (*INB)(unsigned long port);
+	u16 (*INW)(unsigned long port);
+	u32 (*INL)(unsigned long port);
+	void (*INSW)(unsigned long port, void *addr, u32 count);
+};
+
 struct ata_port_info {
 	struct scsi_host_template	*sht;
 	unsigned long		flags;
@@ -662,6 +677,7 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
+	struct ata_io_operations *io_ops;
 	void 			*private_data;
 };
 
@@ -727,7 +743,8 @@ extern int ata_pci_clear_simplex(struct 
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_init(struct ata_host *, struct device *,
-			  unsigned long, const struct ata_port_operations *);
+			  unsigned long, const struct ata_port_operations *,
+			  struct ata_io_operations *);
 extern void ata_host_remove(struct ata_host *host);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
@@ -761,6 +778,7 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port);
 
 /*
  * Default driver ops implementations
@@ -1179,20 +1197,11 @@ static inline u8 ata_irq_ack(struct ata_
 			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		       mmio + ATA_DMA_STATUS);
-
-		post_stat = readb(mmio + ATA_DMA_STATUS);
-	} else {
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
-		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	}
+	host_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	ap->io_ops->OUTB(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+		      ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	
+	post_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 
 	if (ata_msg_intr(ap))
 		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
