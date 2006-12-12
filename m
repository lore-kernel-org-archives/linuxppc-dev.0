Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id C0B6367BDD
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:07:08 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id kBC276ai026207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 11:07:06 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kBC270Q6011847
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 11:07:00 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kBC270gd026062
	for linuxppc-dev@ozlabs.org; Tue, 12 Dec 2006 11:07:00 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kBC26xIG004987
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 11:06:59 +0900 (JST)
Message-Id: <200612120206.kBC26wHr022838@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 12 Dec 2006 11:08:24 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH] drivers/ata: PATA driver
	for Celleb
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone,

This is the patch (based on 2.6.19) for PATA controller of
Toshiba Cell reference set(Celleb). Last month I sent the 
patch for drivers/ide and received some useful comments.
I'm sorry for the late reply, because I have reimplemented
the libata version.

I use some static functions in libata-core.c because it makes
ata_scc.c simpler. Therefore in this patch, these functions are 
defined using EXPORT_SYMBOL_GPL() and some inline functions are 
move to libata.h. If you mind it, please tell me.

This patch set is intended to be merged to 2.6.20.

Signed-off-by: Kou Ishizaki <kou.ishizaki at toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi at toshiba.co.jp>
---

Index: linux-2.6.19/drivers/ata/Kconfig
diff -c linux-2.6.19/drivers/ata/Kconfig:1.1.1.2 linux-2.6.19/drivers/ata/Kconfig:1.3
*** linux-2.6.19/drivers/ata/Kconfig:1.1.1.2	Tue Oct 24 13:38:08 2006
--- linux-2.6.19/drivers/ata/Kconfig	Wed Dec  6 09:35:02 2006
***************
*** 483,488 ****
--- 483,497 ----
  
  	  If unsure, say N.
  
+ config ATA_SCC
+ 	tristate "Toshiba's Cell Reference Set IDE support"
+ 	depends on PCI && PPC_CELLEB
+ 	help
+ 	  This option enables support for the built-in IDE controller on
+ 	  Toshiba Cell Reference Board.
+ 
+ 	  If unsure, say N.
+ 
  endif
  endmenu
  
Index: linux-2.6.19/drivers/ata/Makefile
diff -c linux-2.6.19/drivers/ata/Makefile:1.1.1.1 linux-2.6.19/drivers/ata/Makefile:1.3
*** linux-2.6.19/drivers/ata/Makefile:1.1.1.1	Fri Oct  6 10:42:11 2006
--- linux-2.6.19/drivers/ata/Makefile	Wed Dec  6 09:35:03 2006
***************
*** 57,62 ****
--- 57,63 ----
  obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
  # Should be last libata driver
  obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
+ obj-$(CONFIG_ATA_SCC)   	+= ata_scc.o
  
  libata-objs	:= libata-core.o libata-scsi.o libata-sff.o libata-eh.o
  
Index: linux-2.6.19/drivers/ata/ata_scc.c
diff -c /dev/null linux-2.6.19/drivers/ata/ata_scc.c:1.3
*** /dev/null	Tue Dec 12 08:33:56 2006
--- linux-2.6.19/drivers/ata/ata_scc.c	Mon Dec 11 11:48:45 2006
***************
*** 0 ****
--- 1,2038 ----
+ /*
+  * ata_scc.c - Support for IDE interfaces on Celleb platform
+  *
+  * (C) Copyright 2006 TOSHIBA CORPORATION
+  *
+  * This code is based on drivers/ata/ata_piix.c:
+  *  Copyright 2003-2005 Red Hat Inc
+  *  Copyright 2003-2005 Jeff Garzik
+  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
+  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+  *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+  *
+  * and drivers/ata/libata-core.c:
+  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+  *  Copyright 2003-2004 Jeff Garzik
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License along
+  * with this program; if not, write to the Free Software Foundation, Inc.,
+  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+  */
+ 
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+ #include <linux/pci.h>
+ #include <linux/init.h>
+ #include <linux/blkdev.h>
+ #include <linux/delay.h>
+ #include <linux/device.h>
+ #include <scsi/scsi_host.h>
+ #include <linux/libata.h>
+ 
+ #define DRV_NAME                "ata_scc"
+ #define DRV_VERSION             "0.1"
+ 
+ #define PCI_DEVICE_ID_TOSHIBA_SCC_ATA            0x01b4
+ 
+ /* offset of CTRL registers */
+ #define SCC_CTL_PIOSHT          0x000
+ #define SCC_CTL_PIOCT           0x004
+ #define SCC_CTL_MDMACT          0x008
+ #define SCC_CTL_MCRCST          0x00C
+ #define SCC_CTL_SDMACT          0x010
+ #define SCC_CTL_SCRCST          0x014
+ #define SCC_CTL_UDENVT          0x018
+ #define SCC_CTL_TDVHSEL         0x020
+ #define SCC_CTL_MODEREG         0x024
+ #define SCC_CTL_ECMODE          0xF00
+ #define SCC_CTL_MAEA0           0xF50
+ #define SCC_CTL_MAEC0           0xF54
+ #define SCC_CTL_CCKCTRL         0xFF0
+ 
+ /* offset of BMID registers */
+ #define SCC_DMA_CMD             0x000
+ #define SCC_DMA_STATUS          0x004
+ #define SCC_DMA_TABLE_OFS       0x008
+ #define SCC_DMA_INTMASK         0x010
+ #define SCC_DMA_INTST           0x014
+ #define SCC_DMA_PTERADD         0x018
+ #define SCC_REG_CMD_ADDR        0x020
+ #define SCC_REG_DATA            0x000
+ #define SCC_REG_ERR             0x004
+ #define SCC_REG_FEATURE         0x004
+ #define SCC_REG_NSECT           0x008
+ #define SCC_REG_LBAL            0x00C
+ #define SCC_REG_LBAM            0x010
+ #define SCC_REG_LBAH            0x014
+ #define SCC_REG_DEVICE          0x018
+ #define SCC_REG_STATUS          0x01C
+ #define SCC_REG_CMD             0x01C
+ #define SCC_REG_ALTSTATUS       0x020
+ 
+ /* register value */
+ #define TDVHSEL_MASTER          0x00000001
+ #define TDVHSEL_SLAVE           0x00000004
+ 
+ #define MODE_JCUSFEN            0x00000080
+ 
+ #define ECMODE_VALUE            0x01
+ 
+ #define CCKCTRL_ATARESET        0x00040000
+ #define CCKCTRL_BUFCNT          0x00020000
+ #define CCKCTRL_CRST            0x00010000
+ #define CCKCTRL_OCLKEN          0x00000100
+ #define CCKCTRL_ATACLKOEN       0x00000002
+ #define CCKCTRL_LCLKEN          0x00000001
+ 
+ #define QCHCD_IOS_SS            0x00000001
+ 
+ #define QCHSD_STPDIAG           0x00020000
+ 
+ #define INTMASK_MSK             0xD1000012
+ #define INTSTS_SERROR           0x80000000
+ #define INTSTS_PRERR            0x40000000
+ #define INTSTS_RERR             0x10000000
+ #define INTSTS_ICERR            0x01000000
+ #define INTSTS_BMSINT           0x00000010
+ #define INTSTS_BMHE             0x00000008
+ #define INTSTS_IOIRQS           0x00000004
+ #define INTSTS_INTRQ            0x00000002
+ #define INTSTS_ACTEINT          0x00000001
+ 
+ 
+ typedef struct scc_ports {
+ 	void __iomem *ctl_base;
+ 	void __iomem *dma_base;
+ } scc_ports;
+ 
+ /* PIO transfer mode table */
+ /* JCHST */
+ static const unsigned long JCHSTtbl[2][7] = {
+ 	{0x0E, 0x05, 0x02, 0x03, 0x02, 0x00, 0x00},   /* 100MHz */
+ 	{0x13, 0x07, 0x04, 0x04, 0x03, 0x00, 0x00}    /* 133MHz */
+ };
+ 
+ /* JCHHT */
+ static const unsigned long JCHHTtbl[2][7] = {
+ 	{0x0E, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00},   /* 100MHz */
+ 	{0x13, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00}    /* 133MHz */
+ };
+ 
+ /* JCHCT */
+ static const unsigned long JCHCTtbl[2][7] = {
+ 	{0x1D, 0x1D, 0x1C, 0x0B, 0x06, 0x00, 0x00},   /* 100MHz */
+ 	{0x27, 0x26, 0x26, 0x0E, 0x09, 0x00, 0x00}    /* 133MHz */
+ };
+ 
+ /* DMA transfer mode  table */
+ /* JCHDCTM/JCHDCTS */
+ static const unsigned long JCHDCTxtbl[2][7] = {
+ 	{0x0A, 0x06, 0x04, 0x03, 0x01, 0x00, 0x00},   /* 100MHz */
+ 	{0x0E, 0x09, 0x06, 0x04, 0x02, 0x01, 0x00}    /* 133MHz */
+ };
+ 
+ /* JCSTWTM/JCSTWTS  */
+ static const unsigned long JCSTWTxtbl[2][7] = {
+ 	{0x06, 0x04, 0x03, 0x02, 0x02, 0x02, 0x00},   /* 100MHz */
+ 	{0x09, 0x06, 0x04, 0x02, 0x02, 0x02, 0x02}    /* 133MHz */
+ };
+ 
+ /* JCTSS */
+ static const unsigned long JCTSStbl[2][7] = {
+ 	{0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x00},   /* 100MHz */
+ 	{0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05}    /* 133MHz */
+ };
+ 
+ /* JCENVT */
+ static const unsigned long JCENVTtbl[2][7] = {
+ 	{0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00},   /* 100MHz */
+ 	{0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02}    /* 133MHz */
+ };
+ 
+ /* JCACTSELS/JCACTSELM */
+ static const unsigned long JCACTSELtbl[2][7] = {
+ 	{0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00},   /* 100MHz */
+ 	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01}    /* 133MHz */
+ };
+ 
+ 
+ static void scc_set_piomode (struct ata_port *ap, struct ata_device *adev);
+ static void scc_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+ static void scc_tf_load (struct ata_port *ap, const struct ata_taskfile *tf);
+ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf);
+ static void scc_exec_command (struct ata_port *ap, const struct ata_taskfile *tf);
+ static u8 scc_check_status (struct ata_port *ap);
+ static u8 scc_check_altstatus (struct ata_port *ap);
+ static void scc_std_dev_select (struct ata_port *ap, unsigned int device);
+ static void scc_bmdma_setup (struct ata_queued_cmd *qc);
+ static void scc_bmdma_start (struct ata_queued_cmd *qc);
+ static void scc_bmdma_stop (struct ata_queued_cmd *qc);
+ static u8 scc_bmdma_status (struct ata_port *ap);
+ static void scc_data_xfer (struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data);
+ static inline u8 scc_irq_on (struct ata_port *ap);
+ static inline u8 scc_irq_ack (struct ata_port *ap, unsigned int chk_drq);
+ static void scc_hsm_qc_complete (struct ata_queued_cmd *qc, int in_wq);
+ static int scc_hsm_move (struct ata_port *ap, struct ata_queued_cmd *qc, u8 status, int in_wq);
+ static void scc_pio_task (void *_data);
+ static unsigned int scc_qc_issue_prot (struct ata_queued_cmd *qc);
+ static void scc_bmdma_freeze (struct ata_port *ap);
+ static void scc_bmdma_thaw (struct ata_port *ap);
+ static void scc_bmdma_drive_eh (struct ata_port *ap, ata_prereset_fn_t prereset, ata_reset_fn_t softreset, ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+ static unsigned int scc_devchk (struct ata_port *ap, unsigned int device);
+ static void scc_bus_post_reset (struct ata_port *ap, unsigned int devmask);
+ static unsigned int scc_bus_softreset (struct ata_port *ap, unsigned int devmask);
+ static int scc_std_softreset (struct ata_port *ap, unsigned int *classes);
+ static void scc_std_postreset (struct ata_port *ap, unsigned int *classes);
+ static void scc_error_handler (struct ata_port *ap);
+ static inline unsigned int scc_host_intr (struct ata_port *ap, struct ata_queued_cmd *qc);
+ static irqreturn_t scc_interrupt (int irq, void *dev_instance);
+ static void scc_bmdma_irq_clear (struct ata_port *ap);
+ static int scc_port_start (struct ata_port *ap);
+ static void scc_port_stop (struct ata_port *ap);
+ static void remove_mmio_scc (struct pci_dev *pdev);
+ static void scc_host_stop (struct ata_host *host);
+ 
+ static void scc_std_ports (struct ata_ioports *ioaddr);
+ static struct ata_probe_ent * scc_pci_init_native_mode (struct pci_dev *pdev, struct ata_port_info **port, int ports);
+ static int scc_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info, unsigned int n_ports);
+ static int setup_mmio_scc (struct pci_dev *dev, const char *name);
+ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+ 
+ 
+ static const struct pci_device_id scc_pci_tbl[] = {
+         { PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_SCC_ATA,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+ 	{ }	/* terminate list */
+ };
+ 
+ static struct pci_driver scc_pci_driver = {
+ 	.name			= DRV_NAME,
+ 	.id_table		= scc_pci_tbl,
+ 	.probe			= scc_init_one,
+ 	.remove			= ata_pci_remove_one,
+ 	.suspend		= ata_pci_device_suspend,
+ 	.resume			= ata_pci_device_resume,
+ };
+ 
+ static struct scsi_host_template scc_sht = {
+ 	.module			= THIS_MODULE,
+ 	.name			= DRV_NAME,
+ 	.ioctl			= ata_scsi_ioctl,
+ 	.queuecommand		= ata_scsi_queuecmd,
+ 	.can_queue		= ATA_DEF_QUEUE,
+ 	.this_id		= ATA_SHT_THIS_ID,
+ 	.sg_tablesize		= LIBATA_MAX_PRD,
+ 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+ 	.emulated		= ATA_SHT_EMULATED,
+ 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+ 	.proc_name		= DRV_NAME,
+ 	.dma_boundary		= ATA_DMA_BOUNDARY,
+ 	.slave_configure	= ata_scsi_slave_config,
+ 	.slave_destroy		= ata_scsi_slave_destroy,
+ 	.bios_param		= ata_std_bios_param,
+ 	.resume			= ata_scsi_device_resume,
+ 	.suspend		= ata_scsi_device_suspend,
+ };
+ 
+ static const struct ata_port_operations scc_pata_ops = {
+ 	.port_disable		= ata_port_disable,
+ 	.set_piomode		= scc_set_piomode,
+ 	.set_dmamode		= scc_set_dmamode,
+ 	.mode_filter		= ata_pci_default_filter,
+ 
+ 	.tf_load		= scc_tf_load,
+ 	.tf_read		= scc_tf_read,
+ 	.exec_command		= scc_exec_command,
+ 	.check_status		= scc_check_status,
+ 	.check_altstatus	= scc_check_altstatus,
+ 	.dev_select		= scc_std_dev_select,
+ 
+ 	.bmdma_setup		= scc_bmdma_setup,
+ 	.bmdma_start		= scc_bmdma_start,
+ 	.bmdma_stop		= scc_bmdma_stop,
+ 	.bmdma_status		= scc_bmdma_status,
+ 	.data_xfer		= scc_data_xfer,
+ 
+ 	.qc_prep		= ata_qc_prep,
+ 	.qc_issue		= scc_qc_issue_prot,
+ 
+ 	.freeze			= scc_bmdma_freeze,
+ 	.thaw			= scc_bmdma_thaw,
+ 	.error_handler		= scc_error_handler,
+ 	.post_internal_cmd	= scc_bmdma_stop,
+ 
+ 	.irq_handler		= scc_interrupt,
+ 	.irq_clear		= scc_bmdma_irq_clear,
+ 
+ 	.port_start		= scc_port_start,
+ 	.port_stop		= scc_port_stop,
+ 	.host_stop		= scc_host_stop,
+ };
+ 
+ 
+ static struct ata_port_info scc_port_info[] = {
+ 	{
+ 		.sht		= &scc_sht,
+ 		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY,
+ 		.pio_mask	= 0x1f,	/* pio0-4 */
+ 		.mwdma_mask	= 0x00,
+ 		.udma_mask	= ATA_UDMA6,
+ 		.port_ops	= &scc_pata_ops,
+ 	},
+ 
+ };
+ 
+ MODULE_AUTHOR("Toshiba corp");
+ MODULE_DESCRIPTION("SCSI low-level driver for Toshiba SCC PATA controller");
+ MODULE_LICENSE("GPL");
+ MODULE_DEVICE_TABLE(pci, scc_pci_tbl);
+ MODULE_VERSION(DRV_VERSION);
+ 
+ /**
+  *	scc_set_piomode - Initialize host controller PATA PIO timings
+  *	@ap: Port whose timings we are configuring
+  *	@adev: um
+  *
+  *	Set PIO mode for device.
+  *
+  *	LOCKING:
+  *	None (inherited from caller).
+  */
+ 
+ static void scc_set_piomode (struct ata_port *ap, struct ata_device *adev)
+ {
+ 	unsigned int pio = adev->pio_mode - XFER_PIO_0;
+ 	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;
+         void __iomem *cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
+         void __iomem *piosht_port = ports->ctl_base + SCC_CTL_PIOSHT;
+         void __iomem *pioct_port = ports->ctl_base + SCC_CTL_PIOCT;
+         unsigned long reg;
+         int offset;
+ 
+ 	reg = in_be32(cckctrl_port);
+         if (reg & CCKCTRL_ATACLKOEN)
+ 		offset = 1; /* 133MHz */
+ 	else
+ 		offset = 0; /* 100MHz */
+ 
+         reg = JCHSTtbl[offset][pio] << 16 | JCHHTtbl[offset][pio];
+         out_be32(piosht_port, reg);
+         reg = JCHCTtbl[offset][pio];
+         out_be32(pioct_port, reg);
+ }
+ 
+ /**
+  *	scc_set_dmamode - Initialize host controller PATA DMA timings
+  *	@ap: Port whose timings we are configuring
+  *	@adev: um
+  *	@udma: udma mode, 0 - 6
+  *
+  *	Set UDMA mode for device.
+  *
+  *	LOCKING:
+  *	None (inherited from caller).
+  */
+ 
+ static void scc_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+ {
+ 	unsigned int udma = adev->dma_mode;
+ 	unsigned int is_slave = (adev->devno != 0);
+ 	u8 speed = udma;
+ 	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;
+         void __iomem *cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
+         void __iomem *mdmact_port = ports->ctl_base + SCC_CTL_MDMACT;
+         void __iomem *mcrcst_port = ports->ctl_base + SCC_CTL_MCRCST;
+         void __iomem *sdmact_port = ports->ctl_base + SCC_CTL_SDMACT;
+         void __iomem *scrcst_port = ports->ctl_base + SCC_CTL_SCRCST;
+         void __iomem *udenvt_port = ports->ctl_base + SCC_CTL_UDENVT;
+         void __iomem *tdvhsel_port = ports->ctl_base + SCC_CTL_TDVHSEL;
+         int offset, idx;
+ 
+         if (in_be32(cckctrl_port) & CCKCTRL_ATACLKOEN) 
+                 offset = 1; /* 133MHz */
+ 	else 
+                 offset = 0; /* 100MHz */
+ 
+ 	if (speed >= XFER_UDMA_0)
+ 		idx = speed - XFER_UDMA_0;
+ 	else
+ 		return;
+ 
+         if (is_slave) {
+                 out_be32(sdmact_port, JCHDCTxtbl[offset][idx]);
+                 out_be32(scrcst_port, JCSTWTxtbl[offset][idx]);
+                 out_be32(tdvhsel_port,
+ 			 (in_be32(tdvhsel_port) & ~TDVHSEL_SLAVE) | (JCACTSELtbl[offset][idx] << 2));
+         } else {
+                 out_be32(mdmact_port, JCHDCTxtbl[offset][idx]);
+                 out_be32(mcrcst_port, JCSTWTxtbl[offset][idx]);
+                 out_be32(tdvhsel_port,
+ 			 (in_be32(tdvhsel_port) & ~TDVHSEL_MASTER) | JCACTSELtbl[offset][idx]);
+         }
+         out_be32(udenvt_port,
+ 		 JCTSStbl[offset][idx] << 16 | JCENVTtbl[offset][idx]);
+ }
+ 
+ /**
+  *	scc_tf_load - send taskfile registers to host controller
+  *	@ap: Port to which output is sent
+  *	@tf: ATA taskfile register set
+  *
+  *	Note: Original code is ata_tf_load_pio().
+  */
+ 
+ static void scc_tf_load (struct ata_port *ap, const struct ata_taskfile *tf)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+ 
+ 	if (tf->ctl != ap->last_ctl) {
+ 		out_be32((void __iomem *)ap->ioaddr.ctl_addr, tf->ctl);
+ 		ap->last_ctl = tf->ctl;
+ 		ata_wait_idle(ap);
+ 	}
+ 
+ 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+ 		out_be32((void __iomem *)ioaddr->feature_addr, tf->hob_feature);
+ 		out_be32((void __iomem *)ioaddr->nsect_addr, tf->hob_nsect);
+ 		out_be32((void __iomem *)ioaddr->lbal_addr, tf->hob_lbal);
+ 		out_be32((void __iomem *)ioaddr->lbam_addr, tf->hob_lbam);
+ 		out_be32((void __iomem *)ioaddr->lbah_addr, tf->hob_lbah);
+ 		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+ 			tf->hob_feature,
+ 			tf->hob_nsect,
+ 			tf->hob_lbal,
+ 			tf->hob_lbam,
+ 			tf->hob_lbah);
+ 	}
+ 
+ 	if (is_addr) {
+ 		out_be32((void __iomem *)ioaddr->feature_addr, tf->feature);
+ 		out_be32((void __iomem *)ioaddr->nsect_addr, tf->nsect);
+ 		out_be32((void __iomem *)ioaddr->lbal_addr, tf->lbal);
+ 		out_be32((void __iomem *)ioaddr->lbam_addr, tf->lbam);
+ 		out_be32((void __iomem *)ioaddr->lbah_addr, tf->lbah);
+ 		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+ 			tf->feature,
+ 			tf->nsect,
+ 			tf->lbal,
+ 			tf->lbam,
+ 			tf->lbah);
+ 	}
+ 
+ 	if (tf->flags & ATA_TFLAG_DEVICE) {
+ 		out_be32((void __iomem *)ioaddr->device_addr, tf->device);
+ 		VPRINTK("device 0x%X\n", tf->device);
+ 	}
+ 
+ 	ata_wait_idle(ap);
+ }
+ 
+ /**
+  *	scc_tf_read - input device's ATA taskfile shadow registers
+  *	@ap: Port from which input is read
+  *	@tf: ATA taskfile register set for storing input
+  *
+  *	Note: Original code is ata_tf_read_pio().
+  */
+ 
+ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 
+ 	tf->command = scc_check_status(ap);
+ 	tf->feature = in_be32((void __iomem *)ioaddr->error_addr);
+ 	tf->nsect = in_be32((void __iomem *)ioaddr->nsect_addr);
+ 	tf->lbal = in_be32((void __iomem *)ioaddr->lbal_addr);
+ 	tf->lbam = in_be32((void __iomem *)ioaddr->lbam_addr);
+ 	tf->lbah = in_be32((void __iomem *)ioaddr->lbah_addr);
+ 	tf->device = in_be32((void __iomem *)ioaddr->device_addr);
+ 
+ 	if (tf->flags & ATA_TFLAG_LBA48) {
+ 		out_be32((void __iomem *)ap->ioaddr.ctl_addr, tf->ctl | ATA_HOB);
+ 		tf->hob_feature = in_be32((void __iomem *)ioaddr->error_addr);
+ 		tf->hob_nsect = in_be32((void __iomem *)ioaddr->nsect_addr);
+ 		tf->hob_lbal = in_be32((void __iomem *)ioaddr->lbal_addr);
+ 		tf->hob_lbam = in_be32((void __iomem *)ioaddr->lbam_addr);
+ 		tf->hob_lbah = in_be32((void __iomem *)ioaddr->lbah_addr);
+ 	}
+ }
+ 
+ /**
+  *	scc_exec_command - issue ATA command to host controller
+  *	@ap: port to which command is being issued
+  *	@tf: ATA taskfile register set
+  *
+  *	Note: Original code is ata_exec_command_pio().
+  */
+ 
+ static void scc_exec_command (struct ata_port *ap, const struct ata_taskfile *tf)
+ {
+ 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+ 
+        	out_be32((void __iomem *)ap->ioaddr.command_addr, tf->command);
+ 	ata_pause(ap);
+ }
+ 
+ /**
+  *	scc_check_status - Read device status reg & clear interrupt
+  *	@ap: port where the device is
+  *
+  *	Note: Original code is ata_check_status_pio().
+  */
+ 
+ static u8 scc_check_status (struct ata_port *ap)
+ {
+        	return in_be32((void __iomem *)ap->ioaddr.status_addr);
+ }
+ 
+ /**
+  *	scc_check_altstatus - Read device alternate status reg
+  *	@ap: port where the device is
+  */
+ 
+ static u8 scc_check_altstatus (struct ata_port *ap)
+ {
+        	return in_be32((void __iomem *)ap->ioaddr.altstatus_addr);
+ }
+ 
+ /**
+  *	scc_std_dev_select - Select device 0/1 on ATA bus
+  *	@ap: ATA channel to manipulate
+  *	@device: ATA device (numbered from zero) to select
+  *
+  *	Note: Original code is ata_std_dev_select().
+  */
+ 
+ static void scc_std_dev_select (struct ata_port *ap, unsigned int device)
+ {
+ 	u8 tmp;
+ 
+ 	if (device == 0)
+ 		tmp = ATA_DEVICE_OBS;
+ 	else
+ 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+ 
+ 	out_be32((void __iomem *)ap->ioaddr.device_addr, tmp);
+ 	ata_pause(ap);
+ }
+ 
+ /**
+  *	scc_bmdma_setup - Set up PCI IDE BMDMA transaction
+  *	@qc: Info associated with this ATA transaction.
+  *
+  *	Note: Original code is ata_bmdma_setup_pio().
+  */
+ 
+ static void scc_bmdma_setup (struct ata_queued_cmd *qc)
+ {
+ 	struct ata_port *ap = qc->ap;
+ 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+ 	u8 dmactl;
+ 	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+ 
+ 	/* load PRD table addr. */
+ 	out_be32(mmio + SCC_DMA_TABLE_OFS, ap->prd_dma);
+ 
+ 	/* specify data direction, triple-check start bit is clear */
+ 	dmactl = in_be32(mmio + SCC_DMA_CMD);
+ 	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+ 	if (!rw)
+ 		dmactl |= ATA_DMA_WR;
+ 	out_be32(mmio + SCC_DMA_CMD, dmactl);
+ 
+ 	/* issue r/w command */
+ 	ap->ops->exec_command(ap, &qc->tf);
+ }
+ 
+ /**
+  *	scc_bmdma_start - Start a PCI IDE BMDMA transaction
+  *	@qc: Info associated with this ATA transaction.
+  *
+  *	Note: Original code is ata_bmdma_start_pio().
+  */
+ 
+ static void scc_bmdma_start (struct ata_queued_cmd *qc)
+ {
+ 	struct ata_port *ap = qc->ap;
+ 	u8 dmactl;
+ 	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+ 
+ 	/* start host DMA transaction */
+ 	dmactl = in_be32(mmio + SCC_DMA_CMD);
+ 	out_be32(mmio + SCC_DMA_CMD, dmactl | ATA_DMA_START);
+ }
+ 
+ /**
+  *	scc_bmdma_stop - Stop PCI IDE BMDMA transfer
+  *	@qc: Command we are ending DMA for
+  *
+  *	Note: Original code is ata_bmdma_stop().
+  */
+ 
+ static void scc_bmdma_stop (struct ata_queued_cmd *qc)
+ {
+ 	struct ata_port *ap = qc->ap;
+ 	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;
+ 	u32 reg;
+ 
+ 	while (1) {
+ 		reg = in_be32(ports->dma_base + SCC_DMA_INTST);
+ 		
+ 		if (reg & INTSTS_SERROR) {
+ 			printk(KERN_WARNING "%s: SERROR\n", DRV_NAME);
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_SERROR|INTSTS_BMSINT);
+ 			
+ 			out_be32(ports->dma_base + SCC_DMA_CMD,
+ 				 in_be32(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_PRERR) {
+ 			u32 maea0, maec0;
+ 			
+ 			maea0 = in_be32(ports->ctl_base + SCC_CTL_MAEA0);
+ 			maec0 = in_be32(ports->ctl_base + SCC_CTL_MAEC0);
+ 			
+ 			printk(KERN_WARNING "%s: PRERR [addr:%x cmd:%x]\n", DRV_NAME, maea0, maec0);
+ 			
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_PRERR|INTSTS_BMSINT);
+ 			
+ 			out_be32(ports->dma_base + SCC_DMA_CMD,
+ 				 in_be32(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_RERR) {
+ 			printk(KERN_WARNING "%s: Response Error\n", DRV_NAME);
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_RERR|INTSTS_BMSINT);
+ 			
+ 			out_be32(ports->dma_base + SCC_DMA_CMD,
+ 				 in_be32(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_ICERR) {
+ 			out_be32(ports->dma_base + SCC_DMA_CMD,
+ 				 in_be32(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START);
+ 			
+ 			printk(KERN_WARNING "%s: Illegal Configuration\n", DRV_NAME);
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_ICERR|INTSTS_BMSINT);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_BMSINT) {
+ 			unsigned int classes;
+ 			printk(KERN_WARNING "%s: Internal Bus Error\n", DRV_NAME);
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_BMSINT);
+ 			
+ 			/* TBD: SW reset */
+ 			scc_std_softreset(ap, &classes);
+ 			continue;
+ 		}
+ 
+ 		if (reg & INTSTS_BMHE) {
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_BMHE);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_ACTEINT) {
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_ACTEINT);
+ 			continue;
+ 		}
+ 		
+ 		if (reg & INTSTS_IOIRQS) {
+ 			out_be32(ports->dma_base + SCC_DMA_INTST, INTSTS_IOIRQS);
+ 			continue;
+ 		}
+ 		break;
+ 	}
+ 
+ 	/* clear start/stop bit */
+ 	out_be32(ports->dma_base + SCC_DMA_CMD,
+ 		 in_be32(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START);
+ 	
+ 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+ 	ata_altstatus(ap);        /* dummy read */
+ }
+ 
+ /**
+  *	scc_bmdma_status - Read PCI IDE BMDMA status
+  *	@ap: Port associated with this ATA transaction.
+  *
+  *	Note: Original code is ata_bmdma_status().
+  */
+ 
+ static u8 scc_bmdma_status (struct ata_port *ap)
+ {
+ 	u8 host_stat;
+ 	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+ 
+ 	host_stat = in_be32(mmio + SCC_DMA_STATUS);
+ 	return host_stat;
+ }
+ 
+ /**
+  *	scc_data_xfer - Transfer data by MMIO
+  *	@adev: device for this I/O
+  *	@buf: data buffer
+  *	@buflen: buffer length
+  *	@write_data: read/write
+  *
+  *	Note: Original code is ata_mmio_data_xfer().
+  */
+ 
+ static void scc_data_xfer (struct ata_device *adev, unsigned char *buf,
+ 			   unsigned int buflen, int write_data)
+ {
+ 	struct ata_port *ap = adev->ap;
+ 	unsigned int i;
+ 	unsigned int words = buflen >> 1;
+ 	u16 *buf16 = (u16 *) buf;
+ 	void __iomem *mmio = (void __iomem *) ap->ioaddr.data_addr;
+ 
+ 	/* Transfer multiple of 2 bytes */
+ 	if (write_data) {
+ 		for (i = 0; i < words; i++)
+ 			out_be32(mmio, cpu_to_le16(buf16[i]));
+ 	} else {
+ 		for (i = 0; i < words; i++)
+ 			buf16[i] = le16_to_cpu(in_be32(mmio));
+ 	}
+ 	
+ 	/* Transfer trailing 1 byte, if any. */
+ 	if (unlikely(buflen & 0x01)) {
+ 		u16 align_buf[1] = { 0 };
+ 		unsigned char *trailing_buf = buf + buflen - 1;
+ 
+ 		if (write_data) {
+ 			memcpy(align_buf, trailing_buf, 1);
+ 			out_be32(mmio, cpu_to_le16(align_buf[0]));
+ 		} else {
+ 			align_buf[0] = le16_to_cpu(in_be32(mmio));
+ 			memcpy(trailing_buf, align_buf, 1);
+ 		}
+ 	}
+ }
+ 
+ /**
+  *	scc_irq_on - Enable interrupts on a port.
+  *	@ap: Port on which interrupts are enabled.
+  *
+  *	Note: Original code is ata_irq_on().
+  */
+ 
+ static inline u8 scc_irq_on (struct ata_port *ap)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 	u8 tmp;
+ 
+ 	ap->ctl &= ~ATA_NIEN;
+ 	ap->last_ctl = ap->ctl;
+ 
+ 	out_be32((void __iomem *)ioaddr->ctl_addr, ap->ctl);
+ 	tmp = ata_wait_idle(ap);
+ 
+ 	ap->ops->irq_clear(ap);
+ 
+ 	return tmp;
+ }
+ 
+ /**
+  *      scc_irq_ack - Acknowledge a device interrupt.
+  *      @ap: Port on which interrupts are enabled.
+  *
+  *	Note: Original code is ata_irq_ack().
+  */
+ 
+ static inline u8 scc_irq_ack (struct ata_port *ap, unsigned int chk_drq)
+ {
+ 	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
+ 	u8 host_stat, post_stat, status;
+ 
+ 	status = ata_busy_wait(ap, bits, 1000);
+ 	if (status & bits)
+ 		if (ata_msg_err(ap))
+ 			printk(KERN_ERR "abnormal status 0x%X\n", status);
+ 
+ 	/* get controller status; clear intr, err bits */
+ 	host_stat = in_be32((void __iomem *)ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+ 	out_be32((void __iomem *)ap->ioaddr.bmdma_addr + SCC_DMA_STATUS, host_stat | ATA_DMA_INTR | ATA_DMA_ERR);
+ 	
+ 	post_stat = in_be32((void __iomem *)ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+ 
+ 	if (ata_msg_intr(ap))
+ 		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+ 		       __FUNCTION__,
+ 		       host_stat, post_stat, status);
+ 
+ 	return status;
+ }
+ 
+ /**
+  *	scc_hsm_qc_complete - finish a qc running on standard HSM
+  *	@qc: Command to complete
+  *	@in_wq: 1 if called from workqueue, 0 otherwise
+  *
+  *	Note: Original code is ata_hsm_qc_complete().
+  */
+ 
+ static void scc_hsm_qc_complete (struct ata_queued_cmd *qc, int in_wq)
+ {
+ 	struct ata_port *ap = qc->ap;
+ 	unsigned long flags;
+ 
+ 	if (ap->ops->error_handler) {
+ 		if (in_wq) {
+ 			spin_lock_irqsave(ap->lock, flags);
+ 
+ 			/* EH might have kicked in while host_set lock
+ 			 * is released.
+ 			 */
+ 			qc = ata_qc_from_tag(ap, qc->tag);
+ 			if (qc) {
+ 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
+ 					scc_irq_on(ap);
+ 					ata_qc_complete(qc);
+ 				} else
+ 					ata_port_freeze(ap);
+ 			}
+ 
+ 			spin_unlock_irqrestore(ap->lock, flags);
+ 		} else {
+ 			if (likely(!(qc->err_mask & AC_ERR_HSM)))
+ 				ata_qc_complete(qc);
+ 			else
+ 				ata_port_freeze(ap);
+ 		}
+ 	} else {
+ 		if (in_wq) {
+ 			spin_lock_irqsave(ap->lock, flags);
+ 			scc_irq_on(ap);
+ 			ata_qc_complete(qc);
+ 			spin_unlock_irqrestore(ap->lock, flags);
+ 		} else
+ 			ata_qc_complete(qc);
+ 	}
+ 
+ 	ata_altstatus(ap); /* flush */
+ }
+ 
+ /**
+  *	scc_hsm_move - move the HSM to the next state.
+  *	@ap: the target ata_port
+  *	@qc: qc on going
+  *	@status: current device status
+  *	@in_wq: 1 if called from workqueue, 0 otherwise
+  *
+  *	Note: Original code is ata_hsm_move().
+  */
+ 
+ static int scc_hsm_move (struct ata_port *ap, struct ata_queued_cmd *qc,
+ 			 u8 status, int in_wq)
+ {
+ 	unsigned long flags = 0;
+ 	int poll_next;
+ 
+ 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
+ 
+ 	/* Make sure ata_qc_issue_prot() does not throw things
+ 	 * like DMA polling into the workqueue. Notice that
+ 	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
+ 	 */
+ 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
+ 
+ fsm_start:
+ 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+ 		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+ 
+ 	switch (ap->hsm_task_state) {
+ 	case HSM_ST_FIRST:
+ 		/* Send first data block or PACKET CDB */
+ 
+ 		/* If polling, we will stay in the work queue after
+ 		 * sending the data. Otherwise, interrupt handler
+ 		 * takes over after sending the data.
+ 		 */
+ 		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+ 
+ 		/* check device status */
+ 		if (unlikely((status & ATA_DRQ) == 0)) {
+ 			/* handle BSY=0, DRQ=0 as error */
+ 			if (likely(status & (ATA_ERR | ATA_DF)))
+ 				/* device stops HSM for abort/error */
+ 				qc->err_mask |= AC_ERR_DEV;
+ 			else
+ 				/* HSM violation. Let EH handle this */
+ 				qc->err_mask |= AC_ERR_HSM;
+ 
+ 			ap->hsm_task_state = HSM_ST_ERR;
+ 			goto fsm_start;
+ 		}
+ 
+ 		/* Device should not ask for data transfer (DRQ=1)
+ 		 * when it finds something wrong.
+ 		 * We ignore DRQ here and stop the HSM by
+ 		 * changing hsm_task_state to HSM_ST_ERR and
+ 		 * let the EH abort the command or reset the device.
+ 		 */
+ 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
+ 			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+ 			       ap->id, status);
+ 			qc->err_mask |= AC_ERR_HSM;
+ 			ap->hsm_task_state = HSM_ST_ERR;
+ 			goto fsm_start;
+ 		}
+ 
+ 		/* Send the CDB (atapi) or the first data block (ata pio out).
+ 		 * During the state transition, interrupt handler shouldn't
+ 		 * be invoked before the data transfer is complete and
+ 		 * hsm_task_state is changed. Hence, the following locking.
+ 		 */
+ 		if (in_wq)
+ 			spin_lock_irqsave(ap->lock, flags);
+ 
+ 		if (qc->tf.protocol == ATA_PROT_PIO) {
+ 			/* PIO data out protocol.
+ 			 * send first data block.
+ 			 */
+ 
+ 			/* ata_pio_sectors() might change the state
+ 			 * to HSM_ST_LAST. so, the state is changed here
+ 			 * before ata_pio_sectors().
+ 			 */
+ 			ap->hsm_task_state = HSM_ST;
+ 			ata_pio_sectors(qc);
+ 			ata_altstatus(ap); /* flush */
+ 		} else
+ 			/* send CDB */
+ 			atapi_send_cdb(ap, qc);
+ 
+ 		if (in_wq)
+ 			spin_unlock_irqrestore(ap->lock, flags);
+ 
+ 		/* if polling, ata_pio_task() handles the rest.
+ 		 * otherwise, interrupt handler takes over from here.
+ 		 */
+ 		break;
+ 
+ 	case HSM_ST:
+ 		/* complete command or read/write the data register */
+ 		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+ 			/* ATAPI PIO protocol */
+ 			if ((status & ATA_DRQ) == 0) {
+ 				/* No more data to transfer or device error.
+ 				 * Device error will be tagged in HSM_ST_LAST.
+ 				 */
+ 				ap->hsm_task_state = HSM_ST_LAST;
+ 				goto fsm_start;
+ 			}
+ 
+ 			/* Device should not ask for data transfer (DRQ=1)
+ 			 * when it finds something wrong.
+ 			 * We ignore DRQ here and stop the HSM by
+ 			 * changing hsm_task_state to HSM_ST_ERR and
+ 			 * let the EH abort the command or reset the device.
+ 			 */
+ 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+ 				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+ 				       ap->id, status);
+ 				qc->err_mask |= AC_ERR_HSM;
+ 				ap->hsm_task_state = HSM_ST_ERR;
+ 				goto fsm_start;
+ 			}
+ 
+ 			atapi_pio_bytes(qc);
+ 
+ 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
+ 				/* bad ireason reported by device */
+ 				goto fsm_start;
+ 
+ 		} else {
+ 			/* ATA PIO protocol */
+ 			if (unlikely((status & ATA_DRQ) == 0)) {
+ 				/* handle BSY=0, DRQ=0 as error */
+ 				if (likely(status & (ATA_ERR | ATA_DF)))
+ 					/* device stops HSM for abort/error */
+ 					qc->err_mask |= AC_ERR_DEV;
+ 				else
+ 					/* HSM violation. Let EH handle this */
+ 					qc->err_mask |= AC_ERR_HSM;
+ 
+ 				ap->hsm_task_state = HSM_ST_ERR;
+ 				goto fsm_start;
+ 			}
+ 
+ 			/* For PIO reads, some devices may ask for
+ 			 * data transfer (DRQ=1) alone with ERR=1.
+ 			 * We respect DRQ here and transfer one
+ 			 * block of junk data before changing the
+ 			 * hsm_task_state to HSM_ST_ERR.
+ 			 *
+ 			 * For PIO writes, ERR=1 DRQ=1 doesn't make
+ 			 * sense since the data block has been
+ 			 * transferred to the device.
+ 			 */
+ 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+ 				/* data might be corrputed */
+ 				qc->err_mask |= AC_ERR_DEV;
+ 
+ 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+ 					ata_pio_sectors(qc);
+ 					ata_altstatus(ap);
+ 					status = ata_wait_idle(ap);
+ 				}
+ 
+ 				if (status & (ATA_BUSY | ATA_DRQ))
+ 					qc->err_mask |= AC_ERR_HSM;
+ 
+ 				/* ata_pio_sectors() might change the
+ 				 * state to HSM_ST_LAST. so, the state
+ 				 * is changed after ata_pio_sectors().
+ 				 */
+ 				ap->hsm_task_state = HSM_ST_ERR;
+ 				goto fsm_start;
+ 			}
+ 
+ 			ata_pio_sectors(qc);
+ 
+ 			if (ap->hsm_task_state == HSM_ST_LAST &&
+ 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+ 				/* all data read */
+ 				ata_altstatus(ap);
+ 				status = ata_wait_idle(ap);
+ 				goto fsm_start;
+ 			}
+ 		}
+ 
+ 		ata_altstatus(ap); /* flush */
+ 		poll_next = 1;
+ 		break;
+ 
+ 	case HSM_ST_LAST:
+ 		if (unlikely(!ata_ok(status))) {
+ 			qc->err_mask |= __ac_err_mask(status);
+ 			ap->hsm_task_state = HSM_ST_ERR;
+ 			goto fsm_start;
+ 		}
+ 
+ 		/* no more data to transfer */
+ 		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
+ 			ap->id, qc->dev->devno, status);
+ 
+ 		WARN_ON(qc->err_mask);
+ 
+ 		ap->hsm_task_state = HSM_ST_IDLE;
+ 
+ 		/* complete taskfile transaction */
+ 		scc_hsm_qc_complete(qc, in_wq);
+ 
+ 		poll_next = 0;
+ 		break;
+ 
+ 	case HSM_ST_ERR:
+ 		/* make sure qc->err_mask is available to
+ 		 * know what's wrong and recover
+ 		 */
+ 		WARN_ON(qc->err_mask == 0);
+ 
+ 		ap->hsm_task_state = HSM_ST_IDLE;
+ 
+ 		/* complete taskfile transaction */
+ 		scc_hsm_qc_complete(qc, in_wq);
+ 
+ 		poll_next = 0;
+ 		break;
+ 	default:
+ 		poll_next = 0;
+ 		BUG();
+ 	}
+ 
+ 	return poll_next;
+ }
+ 
+ /**
+  *	scc_pio_task - queue task
+  *	Note: Original code is ata_pio_task().
+  */
+ 
+ static void scc_pio_task(void *_data)
+ {
+ 	struct ata_queued_cmd *qc = _data;
+ 	struct ata_port *ap = qc->ap;
+ 	u8 status;
+ 	int poll_next;
+ 
+ fsm_start:
+ 	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+ 
+ 	/*
+ 	 * This is purely heuristic.  This is a fast path.
+ 	 * Sometimes when we enter, BSY will be cleared in
+ 	 * a chk-status or two.  If not, the drive is probably seeking
+ 	 * or something.  Snooze for a couple msecs, then
+ 	 * chk-status again.  If still busy, queue delayed work.
+ 	 */
+ 	status = ata_busy_wait(ap, ATA_BUSY, 5);
+ 	if (status & ATA_BUSY) {
+ 		msleep(2);
+ 		status = ata_busy_wait(ap, ATA_BUSY, 10);
+ 		if (status & ATA_BUSY) {
+ 			ata_port_queue_task(ap, scc_pio_task, qc, ATA_SHORT_PAUSE);
+ 			return;
+ 		}
+ 	}
+ 
+ 	/* move the HSM */
+ 	poll_next = scc_hsm_move(ap, qc, status, 1);
+ 
+ 	/* another command or interrupt handler
+ 	 * may be running at this point.
+ 	 */
+ 	if (poll_next)
+ 		goto fsm_start;
+ }
+ 
+ /**
+  *      ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
+  *      @qc: command to issue to device
+  *
+  *	Note: Original code is ata_mmio_data_xfer().
+  */
+ 
+ static unsigned int scc_qc_issue_prot (struct ata_queued_cmd *qc)
+ {
+ 	struct ata_port *ap = qc->ap;
+ 
+ 	/* Use polling pio if the LLD doesn't handle
+ 	 * interrupt driven pio and atapi CDB interrupt.
+ 	 */
+ 	if (ap->flags & ATA_FLAG_PIO_POLLING) {
+ 		switch (qc->tf.protocol) {
+ 		case ATA_PROT_PIO:
+ 		case ATA_PROT_ATAPI:
+ 		case ATA_PROT_ATAPI_NODATA:
+ 			qc->tf.flags |= ATA_TFLAG_POLLING;
+ 			break;
+ 		case ATA_PROT_ATAPI_DMA:
+ 			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+ 				/* see ata_dma_blacklisted() */
+ 				BUG();
+ 			break;
+ 		default:
+ 			break;
+ 		}
+ 	}
+ 
+ 	/* select the device */
+ 	ata_dev_select(ap, qc->dev->devno, 1, 0);
+ 
+ 	/* start the command */
+ 	switch (qc->tf.protocol) {
+ 	case ATA_PROT_NODATA:
+ 		if (qc->tf.flags & ATA_TFLAG_POLLING)
+ 			ata_qc_set_polling(qc);
+ 
+ 		ata_tf_to_host(ap, &qc->tf);
+ 		ap->hsm_task_state = HSM_ST_LAST;
+ 
+ 		if (qc->tf.flags & ATA_TFLAG_POLLING)
+ 			ata_port_queue_task(ap, scc_pio_task, qc, 0);
+ 
+ 		break;
+ 
+ 	case ATA_PROT_DMA:
+ 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+ 
+ 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+ 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+ 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+ 		ap->hsm_task_state = HSM_ST_LAST;
+ 		break;
+ 
+ 	case ATA_PROT_PIO:
+ 		if (qc->tf.flags & ATA_TFLAG_POLLING)
+ 			ata_qc_set_polling(qc);
+ 
+ 		ata_tf_to_host(ap, &qc->tf);
+ 
+ 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+ 			/* PIO data out protocol */
+ 			ap->hsm_task_state = HSM_ST_FIRST;
+ 			ata_port_queue_task(ap, scc_pio_task, qc, 0);
+ 
+ 			/* always send first data block using
+ 			 * the ata_pio_task() codepath.
+ 			 */
+ 		} else {
+ 			/* PIO data in protocol */
+ 			ap->hsm_task_state = HSM_ST;
+ 
+ 			if (qc->tf.flags & ATA_TFLAG_POLLING)
+ 				ata_port_queue_task(ap, scc_pio_task, qc, 0);
+ 
+ 			/* if polling, ata_pio_task() handles the rest.
+ 			 * otherwise, interrupt handler takes over from here.
+ 			 */
+ 		}
+ 
+ 		break;
+ 
+ 	case ATA_PROT_ATAPI:
+ 	case ATA_PROT_ATAPI_NODATA:
+ 		if (qc->tf.flags & ATA_TFLAG_POLLING)
+ 			ata_qc_set_polling(qc);
+ 
+ 		ata_tf_to_host(ap, &qc->tf);
+ 
+ 		ap->hsm_task_state = HSM_ST_FIRST;
+ 
+ 		/* send cdb by polling if no cdb interrupt */
+ 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
+ 		    (qc->tf.flags & ATA_TFLAG_POLLING))
+ 			ata_port_queue_task(ap, scc_pio_task, qc, 0);
+ 		break;
+ 
+ 	case ATA_PROT_ATAPI_DMA:
+ 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+ 
+ 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+ 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+ 		ap->hsm_task_state = HSM_ST_FIRST;
+ 
+ 		/* send cdb by polling if no cdb interrupt */
+ 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+ 			ata_port_queue_task(ap, scc_pio_task, qc, 0);
+ 		break;
+ 
+ 	default:
+ 		WARN_ON(1);
+ 		return AC_ERR_SYSTEM;
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ /**
+  *	scc_bmdma_freeze - Freeze BMDMA controller port
+  *	@ap: port to freeze
+  *
+  *	Note: Original code is ata_bmdma_freeze().
+  */
+ 
+ static void scc_bmdma_freeze (struct ata_port *ap)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 
+ 	ap->ctl |= ATA_NIEN;
+ 	ap->last_ctl = ap->ctl;
+ 
+ 	out_be32((void __iomem *)ioaddr->ctl_addr, ap->ctl);
+ }
+ 
+ /**
+  *	scc_bmdma_thaw - Thaw BMDMA controller port
+  *	@ap: port to thaw
+  *
+  *	Note: Original code is ata_bmdma_thaw().
+  */
+ 
+ static void scc_bmdma_thaw (struct ata_port *ap)
+ {
+ 	/* clear & re-enable interrupts */
+ 	ata_chk_status(ap);
+ 	ap->ops->irq_clear(ap);
+ 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+ 		scc_irq_on(ap);
+ }
+ 
+ /**
+  *	scc_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
+  *	@ap: port to handle error for
+  *	@prereset: prereset method (can be NULL)
+  *	@softreset: softreset method (can be NULL)
+  *	@hardreset: hardreset method (can be NULL)
+  *	@postreset: postreset method (can be NULL)
+  *
+  *	Note: Original code is ata_bmdma_drive_eh().
+  */
+ 
+ static void scc_bmdma_drive_eh (struct ata_port *ap, ata_prereset_fn_t prereset,
+ 				ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+ 				ata_postreset_fn_t postreset)
+ {
+ 	struct ata_eh_context *ehc = &ap->eh_context;
+ 	struct ata_queued_cmd *qc;
+ 	unsigned long flags;
+ 	int thaw = 0;
+ 
+ 	qc = __ata_qc_from_tag(ap, ap->active_tag);
+ 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
+ 		qc = NULL;
+ 
+ 	/* reset PIO HSM and stop DMA engine */
+ 	spin_lock_irqsave(ap->lock, flags);
+ 
+ 	ap->hsm_task_state = HSM_ST_IDLE;
+ 
+ 	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
+ 		   qc->tf.protocol == ATA_PROT_ATAPI_DMA)) {
+ 		u8 host_stat;
+ 
+ 		host_stat = scc_bmdma_status(ap);
+ 
+ 		ata_ehi_push_desc(&ehc->i, "BMDMA stat 0x%x", host_stat);
+ 
+ 		/* BMDMA controllers indicate host bus error by
+ 		 * setting DMA_ERR bit and timing out.  As it wasn't
+ 		 * really a timeout event, adjust error mask and
+ 		 * cancel frozen state.
+ 		 */
+ 		if (qc->err_mask == AC_ERR_TIMEOUT && host_stat & ATA_DMA_ERR) {
+ 			qc->err_mask = AC_ERR_HOST_BUS;
+ 			thaw = 1;
+ 		}
+ 
+ 		ap->ops->bmdma_stop(qc);
+ 	}
+ 
+ 	ata_altstatus(ap);
+ 	ata_chk_status(ap);
+ 	ap->ops->irq_clear(ap);
+ 
+ 	spin_unlock_irqrestore(ap->lock, flags);
+ 
+ 	if (thaw)
+ 		ata_eh_thaw_port(ap);
+ 
+ 	/* PIO and DMA engines have been stopped, perform recovery */
+ 	ata_do_eh(ap, prereset, softreset, hardreset, postreset);
+ }
+ 
+ /**
+  *	scc_devchk - PATA device presence detection
+  *	@ap: ATA channel to examine
+  *	@device: Device to examine (starting at zero)
+  *
+  *	Note: Original code is ata_pio_devchk().
+  */
+ 
+ static unsigned int scc_devchk (struct ata_port *ap,
+ 				unsigned int device)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 	u8 nsect, lbal;
+ 
+ 	ap->ops->dev_select(ap, device);
+ 
+ 	out_be32((void __iomem *)ioaddr->nsect_addr, 0x55);
+ 	out_be32((void __iomem *)ioaddr->lbal_addr, 0xaa);
+ 
+ 	out_be32((void __iomem *)ioaddr->nsect_addr, 0xaa);
+ 	out_be32((void __iomem *)ioaddr->lbal_addr, 0x55);
+ 
+ 	out_be32((void __iomem *)ioaddr->nsect_addr, 0x55);
+ 	out_be32((void __iomem *)ioaddr->lbal_addr, 0xaa);
+ 
+ 	nsect = in_be32((void __iomem *)ioaddr->nsect_addr);
+ 	lbal = in_be32((void __iomem *)ioaddr->lbal_addr);
+ 
+ 	if ((nsect == 0x55) && (lbal == 0xaa))
+ 		return 1;	/* we found a device */
+ 
+ 	return 0;		/* nothing found */
+ }
+ 
+ /**
+  *	scc_bus_post_reset - PATA device post reset
+  *
+  *	Note: Original code is ata_bus_post_reset().
+  */
+ static void scc_bus_post_reset (struct ata_port *ap, unsigned int devmask)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 	unsigned int dev0 = devmask & (1 << 0);
+ 	unsigned int dev1 = devmask & (1 << 1);
+ 	unsigned long timeout;
+ 
+ 	/* if device 0 was found in ata_devchk, wait for its
+ 	 * BSY bit to clear
+ 	 */
+ 	if (dev0)
+ 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+ 
+ 	/* if device 1 was found in ata_devchk, wait for
+ 	 * register access, then wait for BSY to clear
+ 	 */
+ 	timeout = jiffies + ATA_TMOUT_BOOT;
+ 	while (dev1) {
+ 		u8 nsect, lbal;
+ 
+ 		ap->ops->dev_select(ap, 1);
+ 		nsect = in_be32((void __iomem *)ioaddr->nsect_addr);
+ 		lbal = in_be32((void __iomem *)ioaddr->lbal_addr);
+ 		if ((nsect == 1) && (lbal == 1))
+ 			break;
+ 		if (time_after(jiffies, timeout)) {
+ 			dev1 = 0;
+ 			break;
+ 		}
+ 		msleep(50);	/* give drive a breather */
+ 	}
+ 	if (dev1)
+ 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+ 
+ 	/* is all this really necessary? */
+ 	ap->ops->dev_select(ap, 0);
+ 	if (dev1)
+ 		ap->ops->dev_select(ap, 1);
+ 	if (dev0)
+ 		ap->ops->dev_select(ap, 0);
+ }
+ 
+ /**
+  *	scc_bus_softreset - PATA device software reset
+  *
+  *	Note: Original code is ata_bus_softreset().
+  */
+ static unsigned int scc_bus_softreset (struct ata_port *ap,
+ 				       unsigned int devmask)
+ {
+ 	struct ata_ioports *ioaddr = &ap->ioaddr;
+ 
+ 	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+ 
+ 	/* software reset.  causes dev0 to be selected */
+ 	out_be32((void __iomem *)ioaddr->ctl_addr, ap->ctl);
+ 	udelay(10);
+ 	out_be32((void __iomem *)ioaddr->ctl_addr, ap->ctl | ATA_SRST);
+ 	udelay(10);
+ 	out_be32((void __iomem *)ioaddr->ctl_addr, ap->ctl);
+ 
+ 	/* spec mandates ">= 2ms" before checking status.
+ 	 * We wait 150ms, because that was the magic delay used for
+ 	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
+ 	 * between when the ATA command register is written, and then
+ 	 * status is checked.  Because waiting for "a while" before
+ 	 * checking status is fine, post SRST, we perform this magic
+ 	 * delay here as well.
+ 	 *
+ 	 * Old drivers/ide uses the 2mS rule and then waits for ready
+ 	 */
+ 	msleep(150);
+ 
+ 	/* Before we perform post reset processing we want to see if
+ 	 * the bus shows 0xFF because the odd clown forgets the D7
+ 	 * pulldown resistor.
+ 	 */
+ 	if (scc_check_status(ap) == 0xFF) {
+ 		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
+ 		return AC_ERR_OTHER;
+ 	}
+ 
+ 	scc_bus_post_reset(ap, devmask);
+ 
+ 	return 0;
+ }
+ 
+ /**
+  *	scc_std_softreset - reset host port via ATA SRST
+  *	@ap: port to reset
+  *	@classes: resulting classes of attached devices
+  *
+  *	Note: Original code is ata_std_softreset().
+  */
+ 
+ static int scc_std_softreset (struct ata_port *ap, unsigned int *classes)
+ {
+ 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+ 	unsigned int devmask = 0, err_mask;
+ 	u8 err;
+ 
+ 	DPRINTK("ENTER\n");
+ 
+ 	if (ata_port_offline(ap)) {
+ 		classes[0] = ATA_DEV_NONE;
+ 		goto out;
+ 	}
+ 
+ 	/* determine if device 0/1 are present */
+ 	if (scc_devchk(ap, 0))
+ 		devmask |= (1 << 0);
+ 	if (slave_possible && scc_devchk(ap, 1))
+ 		devmask |= (1 << 1);
+ 
+ 	/* select device 0 again */
+ 	ap->ops->dev_select(ap, 0);
+ 
+ 	/* issue bus reset */
+ 	DPRINTK("about to softreset, devmask=%x\n", devmask);
+ 	err_mask = scc_bus_softreset(ap, devmask);
+ 	if (err_mask) {
+ 		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+ 				err_mask);
+ 		return -EIO;
+ 	}
+ 
+ 	/* determine by signature whether we have ATA or ATAPI devices */
+ 	classes[0] = ata_dev_try_classify(ap, 0, &err);
+ 	if (slave_possible && err != 0x81)
+ 		classes[1] = ata_dev_try_classify(ap, 1, &err);
+ 
+  out:
+ 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+ 	return 0;
+ }
+ 
+ /**
+  *	scc_std_postreset - standard postreset callback
+  *	@ap: the target ata_port
+  *	@classes: classes of attached devices
+  *
+  *	Note: Original code is ata_std_postreset().
+  */
+ 
+ static void scc_std_postreset (struct ata_port *ap, unsigned int *classes)
+ {
+ 	DPRINTK("ENTER\n");
+ 
+ 	/* re-enable interrupts */
+ 	if (!ap->ops->error_handler) {
+ 		/* FIXME: hack. create a hook instead */
+ 		if (ap->ioaddr.ctl_addr)
+ 			scc_irq_on(ap);
+ 	}
+ 
+ 	/* is double-select really necessary? */
+ 	if (classes[0] != ATA_DEV_NONE)
+ 		ap->ops->dev_select(ap, 1);
+ 	if (classes[1] != ATA_DEV_NONE)
+ 		ap->ops->dev_select(ap, 0);
+ 
+ 	/* bail out if no device is present */
+ 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
+ 		DPRINTK("EXIT, no device\n");
+ 		return;
+ 	}
+ 
+ 	/* set up device control */
+ 	if (ap->ioaddr.ctl_addr)
+ 		out_be32((void __iomem *) ap->ioaddr.ctl_addr, ap->ctl);
+ 
+ 	DPRINTK("EXIT\n");
+ }
+ 
+ /**
+  *	scc_error_handler - Stock error handler for BMDMA controller
+  *	@ap: port to handle error for
+  *
+  *	Note: Original code is ata_bmdma_error_handler().
+  */
+ 
+ static void scc_error_handler (struct ata_port *ap)
+ {
+ 	scc_bmdma_drive_eh(ap, ata_std_prereset, scc_std_softreset, NULL,
+ 			   scc_std_postreset);
+ }
+ 
+ /**
+  *	scc_host_intr - Handle host interrupt for given (port, task)
+  *	@ap: Port on which interrupt arrived (possibly...)
+  *	@qc: Taskfile currently active in engine
+  *
+  *	Note: Original code is ata_host_intr().
+  */
+ 
+ static inline unsigned int scc_host_intr (struct ata_port *ap,
+ 					  struct ata_queued_cmd *qc)
+ {
+ 	u8 status, host_stat = 0;
+ 
+ 	VPRINTK("ata%u: protocol %d task_state %d\n",
+ 		ap->id, qc->tf.protocol, ap->hsm_task_state);
+ 
+ 	/* Check whether we are expecting interrupt in this state */
+ 	switch (ap->hsm_task_state) {
+ 	case HSM_ST_FIRST:
+ 		/* Some pre-ATAPI-4 devices assert INTRQ
+ 		 * at this state when ready to receive CDB.
+ 		 */
+ 
+ 		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+ 		 * The flag was turned on only for atapi devices.
+ 		 * No need to check is_atapi_taskfile(&qc->tf) again.
+ 		 */
+ 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+ 			goto idle_irq;
+ 		break;
+ 	case HSM_ST_LAST:
+ 		if (qc->tf.protocol == ATA_PROT_DMA ||
+ 		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+ 			/* check status of DMA engine */
+ 			host_stat = ap->ops->bmdma_status(ap);
+ 			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+ 
+ 			/* before we do anything else, clear DMA-Start bit */
+ 			ap->ops->bmdma_stop(qc);
+ 
+ 			if (unlikely(host_stat & ATA_DMA_ERR)) {
+ 				/* error when transfering data to/from memory */
+ 				qc->err_mask |= AC_ERR_HOST_BUS;
+ 				ap->hsm_task_state = HSM_ST_ERR;
+ 			}
+ 		}
+ 		break;
+ 	case HSM_ST:
+ 		break;
+ 	default:
+ 		goto idle_irq;
+ 	}
+ 
+ 	/* check altstatus */
+ 	status = ata_altstatus(ap);
+ 	if (status & ATA_BUSY)
+ 		goto idle_irq;
+ 
+ 	/* check main status, clearing INTRQ */
+ 	status = ata_chk_status(ap);
+ 	if (unlikely(status & ATA_BUSY))
+ 		goto idle_irq;
+ 
+ 	/* ack bmdma irq events */
+ 	ap->ops->irq_clear(ap);
+ 
+ 	scc_hsm_move(ap, qc, status, 0);
+ 	return 1;	/* irq handled */
+ 
+ idle_irq:
+ 	ap->stats.idle_irq++;
+ 
+ #ifdef ATA_IRQ_TRAP
+ 	if ((ap->stats.idle_irq % 1000) == 0) {
+ 		scc_irq_ack(ap, 0); /* debug trap */
+ 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
+ 		return 1;
+ 	}
+ #endif
+ 
+ 	return 0;	/* irq not handled */
+ }
+ 
+ /**
+  *	scc_interrupt - ATA host interrupt handler
+  *	@irq: irq line (unused)
+  *	@dev_instance: pointer to our ata_host_set information structure
+  *
+  *	Note: Original code is ata_interrupt().
+  */
+ 
+ static irqreturn_t scc_interrupt (int irq, void *dev_instance)
+ {
+ 	struct ata_host *host = dev_instance;
+ 	unsigned int i;
+ 	unsigned int handled = 0;
+ 	unsigned long flags;
+ 
+ 	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+ 	spin_lock_irqsave(&host->lock, flags);
+ 
+ 	for (i = 0; i < host->n_ports; i++) {
+ 		struct ata_port *ap;
+ 
+ 		ap = host->ports[i];
+ 		if (ap &&
+ 		    !(ap->flags & ATA_FLAG_DISABLED)) {
+ 			struct ata_queued_cmd *qc;
+ 
+ 			qc = ata_qc_from_tag(ap, ap->active_tag);
+ 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+ 			    (qc->flags & ATA_QCFLAG_ACTIVE))
+ 				handled |= scc_host_intr(ap, qc);
+ 		}
+ 	}
+ 
+ 	spin_unlock_irqrestore(&host->lock, flags);
+ 
+ 	return IRQ_RETVAL(handled);
+ }
+ 
+ /**
+  *	scc_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+  *	@ap: Port associated with this ATA transaction.
+  *
+  *	Note: Original code is ata_bmdma_irq_clear().
+  */
+ 
+ static void scc_bmdma_irq_clear (struct ata_port *ap)
+ {
+ 	void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + SCC_DMA_STATUS;
+ 	if (!ap->ioaddr.bmdma_addr)
+ 		return;
+ 
+ 	out_be32(mmio, in_be32(mmio));
+ }
+ 
+ /**
+  *	scc_port_start - Set port up for dma.
+  *	@ap: Port to initialize
+  *
+  *	Allocate space for PRD table using ata_port_start().
+  *	Set PRD table address for PTERADD. (PRD Transfer End Read)
+  */
+ 
+ static int scc_port_start (struct ata_port *ap)
+ {
+ 	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;
+ 	int rc;
+ 
+ 	rc = ata_port_start(ap);
+ 	if (rc)
+ 		return rc;
+ 
+ 	out_be32(ports->dma_base + SCC_DMA_PTERADD, ap->prd_dma);
+ 	return 0;
+ }
+ 
+ /**
+  *	scc_port_stop - Undo scc_port_start()
+  *	@ap: Port to shut down
+  *
+  *	Reset PTERADD and Free the PRD table.
+  */
+ 
+ static void scc_port_stop (struct ata_port *ap)
+ {
+ 	struct scc_ports *ports = (struct scc_ports *) ap->host->private_data;
+ 
+ 	out_be32(ports->dma_base + SCC_DMA_PTERADD, 0);
+ 	ata_port_stop(ap);
+ }
+ 
+ /**
+  *	remove_mmio_scc - Free the private data
+  *	@pdev: pci_dev to shut down
+  */
+ 
+ static void remove_mmio_scc(struct pci_dev *pdev)
+ {
+ 	struct scc_ports *ports = pci_get_drvdata(pdev);
+         unsigned long ctl_addr = pci_resource_start(pdev, 0);
+         unsigned long dma_addr = pci_resource_start(pdev, 1);
+         unsigned long ctl_size = pci_resource_len(pdev, 0);
+         unsigned long dma_size = pci_resource_len(pdev, 1);
+ 
+ 	pci_set_drvdata(pdev, NULL);
+         iounmap(ports->dma_base);
+         iounmap(ports->ctl_base);
+         release_mem_region(dma_addr, dma_size);
+         release_mem_region(ctl_addr, ctl_size);
+ }
+ 
+ static void scc_host_stop (struct ata_host *host)
+ {
+ 	struct scc_ports *ports = host->private_data;
+ 
+ 	ata_host_stop(host);
+ 	remove_mmio_scc(to_pci_dev(host->dev));
+ 	kfree(ports);
+ }
+ 
+ 
+ /**
+  *	scc_std_ports - initialize ioaddr with SCC PATA port offsets.
+  *	@ioaddr: IO address structure to be initialized
+  *
+  *	Note: Original code is ata_std_ports().
+  */
+ 
+ static void scc_std_ports (struct ata_ioports *ioaddr)
+ {
+ 	ioaddr->data_addr = ioaddr->cmd_addr + SCC_REG_DATA;
+ 	ioaddr->error_addr = ioaddr->cmd_addr + SCC_REG_ERR;
+ 	ioaddr->feature_addr = ioaddr->cmd_addr + SCC_REG_FEATURE;
+ 	ioaddr->nsect_addr = ioaddr->cmd_addr + SCC_REG_NSECT;
+ 	ioaddr->lbal_addr = ioaddr->cmd_addr + SCC_REG_LBAL;
+ 	ioaddr->lbam_addr = ioaddr->cmd_addr + SCC_REG_LBAM;
+ 	ioaddr->lbah_addr = ioaddr->cmd_addr + SCC_REG_LBAH;
+ 	ioaddr->device_addr = ioaddr->cmd_addr + SCC_REG_DEVICE;
+ 	ioaddr->status_addr = ioaddr->cmd_addr + SCC_REG_STATUS;
+ 	ioaddr->command_addr = ioaddr->cmd_addr + SCC_REG_CMD;
+ }
+ 
+ /**
+  *	scc_pci_init_native_mode - Initialize native-mode driver
+  *	@pdev:  pci device to be initialized
+  *	@port:  array[2] of pointers to port info structures.
+  *	@ports: bitmap of ports present
+  *
+  *	Note: Original code is ata_pci_init_native_mode().
+  */
+ 
+ static struct ata_probe_ent *
+ scc_pci_init_native_mode (struct pci_dev *pdev, struct ata_port_info **port, int ports)
+ {
+ 	struct ata_probe_ent *probe_ent =
+ 		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+ 	int p = 0;
+ 	unsigned long bmdma;
+ 	struct scc_ports *scc_port = pci_get_drvdata(pdev);
+ 
+ 	if (!probe_ent)
+ 		return NULL;
+ 
+ 	probe_ent->irq = pdev->irq;
+ 	probe_ent->irq_flags = IRQF_SHARED;
+ 	probe_ent->private_data = port[0]->private_data;
+ 
+ 	if (ports & ATA_PORT_PRIMARY) {
+ 		probe_ent->port[p].cmd_addr = (unsigned long)(scc_port->dma_base + SCC_REG_CMD_ADDR);
+ 		probe_ent->port[p].altstatus_addr =
+ 		probe_ent->port[p].ctl_addr =
+ 			probe_ent->port[p].cmd_addr + SCC_REG_ALTSTATUS;
+ 		bmdma = (unsigned long)scc_port->dma_base;
+ 		if (bmdma) {
+ 			probe_ent->port[p].bmdma_addr = bmdma;
+ 		}
+ 		scc_std_ports(&probe_ent->port[p]);
+ 		p++;
+ 	}
+ 
+ 	probe_ent->n_ports = p;
+ 	return probe_ent;
+ }
+ 
+ /**
+  *	scc_pci_init_one - Initialize/register PCI IDE host controller
+  *	@pdev: Controller to be initialized
+  *	@port_info: Information from low-level host driver
+  *	@n_ports: Number of ports attached to host controller
+  *
+  *	Note: Original code is ata_pci_init_one().
+  */
+ 
+ static int scc_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
+ 			     unsigned int n_ports)
+ {
+ 	struct ata_probe_ent *probe_ent = NULL;
+ 	struct ata_port_info *port[2];
+ 	int rc;
+ 
+ 	DPRINTK("ENTER\n");
+ 
+ 	BUG_ON(n_ports < 1 || n_ports > 2);
+ 
+ 	port[0] = port_info[0];
+ 	if (n_ports > 1)
+ 		port[1] = port_info[1];
+ 	else
+ 		port[1] = port[0];
+ 
+ 	/* FIXME: Really for ATA it isn't safe because the device may be
+ 	   multi-purpose and we want to leave it alone if it was already
+ 	   enabled. Secondly for shared use as Arjan says we want refcounting
+ 
+ 	   Checking dev->is_enabled is insufficient as this is not set at
+ 	   boot for the primary video which is BIOS enabled
+          */
+ 
+ 	rc = pci_enable_device(pdev);
+ 	if (rc)
+ 		return rc;
+ 
+ 	/* TODO: If we get no DMA mask we should fall back to PIO */
+ 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+ 	if (rc)
+ 		goto err_out;
+ 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+ 	if (rc)
+ 		goto err_out;
+ 
+ 	if (n_ports == 2)
+ 		probe_ent = scc_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+ 	else
+ 		probe_ent = scc_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
+ 	
+ 	if (!probe_ent) {
+ 		rc = -ENOMEM;
+ 		goto err_out;
+ 	}
+ 
+ 	pci_set_master(pdev);
+ 
+ 	if (!ata_device_add(probe_ent)) {
+                 rc = -ENODEV;
+                 goto err_out_ent;
+         }
+ 
+ 	kfree(probe_ent);
+ 
+ 	return 0;
+ 
+ err_out_ent:
+ 	kfree(probe_ent);
+ err_out:
+ 	pci_disable_device(pdev);
+ 	return rc;
+ }
+ 
+ /**
+  *	setup_mmio_scc	-	map CTRL/BMID region
+  *	@pdev: PCI device we are configuring
+  *	@name: device name
+  */
+ 
+ static int setup_mmio_scc (struct pci_dev *pdev, const char *name)
+ {
+         unsigned long ctl_addr = pci_resource_start(pdev, 0);
+         unsigned long dma_addr = pci_resource_start(pdev, 1);
+         unsigned long ctl_size = pci_resource_len(pdev, 0);
+         unsigned long dma_size = pci_resource_len(pdev, 1);
+ 	struct scc_ports *scc_port;
+         void __iomem *ctl_base, *dma_base;
+ 
+ 	scc_port = (struct scc_ports*)kzalloc(sizeof(struct scc_ports), GFP_KERNEL);
+         if (!scc_port)
+                 return -ENOMEM;
+ 
+         if (!request_mem_region(ctl_addr, ctl_size, name)) {
+                 printk(KERN_WARNING "%s: IDE controller MMIO ports not availabl\
+ e.\n", DRV_NAME);
+                 goto fail_0;
+         }
+ 
+         if (!request_mem_region(dma_addr, dma_size, name)) {
+                 printk(KERN_WARNING "%s: IDE controller MMIO ports not availabl\
+ e.\n", DRV_NAME);
+                 goto fail_1;
+         }
+ 
+         if ((ctl_base = ioremap(ctl_addr, ctl_size)) == NULL)
+                 goto fail_2;
+ 
+         if ((dma_base = ioremap(dma_addr, dma_size)) == NULL)
+                 goto fail_3;
+         pci_set_master(pdev);
+         scc_port->ctl_base = ctl_base;
+         scc_port->dma_base = dma_base;
+         pci_set_drvdata(pdev, (void *)scc_port);
+ 
+         return 0;
+ 
+ fail_3:
+         iounmap(ctl_base);
+ fail_2:
+         release_mem_region(dma_addr, dma_size);
+ fail_1:
+         release_mem_region(ctl_addr, ctl_size);
+ fail_0:
+ 	kfree(scc_port);
+         return -ENOMEM;
+ }
+ 
+ /**
+  *	scc_init_one - Register SCC PATA device with kernel services
+  *	@pdev: PCI device to register
+  *	@ent: Entry in scc_pci_tbl matching with @pdev
+  *
+  *	LOCKING:
+  *	Inherited from PCI layer (may sleep).
+  *
+  *	RETURNS:
+  *	Zero on success, or -ERRNO value.
+  */
+ 
+ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+ {
+ 	static int printed_version;
+ 	struct ata_port_info port_info[2];
+ 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+ 	struct scc_ports *ports;
+ 	unsigned long port_flags;
+ 	int rc;
+         void __iomem *cckctrl_port, *intmask_port, *mode_port, *ecmode_port;
+         u32 reg = 0;
+ 
+ 	if (!printed_version++)
+ 		dev_printk(KERN_DEBUG, &pdev->dev,
+ 			   "version " DRV_VERSION "\n");
+ 
+ 	rc = setup_mmio_scc(pdev, DRV_NAME);
+ 	if (rc < 0)
+ 		return rc;
+ 
+         ports = pci_get_drvdata(pdev);
+         cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
+         mode_port = ports->ctl_base + SCC_CTL_MODEREG;
+         ecmode_port = ports->ctl_base + SCC_CTL_ECMODE;
+         intmask_port = ports->dma_base + SCC_DMA_INTMASK;
+ 
+         /* controller initialization */
+         reg = 0;
+         out_be32(cckctrl_port, reg);
+         reg |= CCKCTRL_ATACLKOEN;
+         out_be32(cckctrl_port, reg);
+         reg |= CCKCTRL_LCLKEN | CCKCTRL_OCLKEN;
+         out_be32(cckctrl_port, reg);
+         reg |= CCKCTRL_CRST;
+         out_be32(cckctrl_port, reg);
+ 
+         for (;;) {
+ 		reg = in_be32(cckctrl_port);
+ 		if (reg & CCKCTRL_CRST)
+ 			break;
+ 		udelay(5000);
+         }
+ 	
+         reg |= CCKCTRL_ATARESET;
+         out_be32(cckctrl_port, reg);
+ 
+         out_be32(ecmode_port, ECMODE_VALUE);
+         out_be32(mode_port, MODE_JCUSFEN);
+         out_be32(intmask_port, INTMASK_MSK);
+ 
+         if (in_be32(ports->dma_base + SCC_DMA_STATUS) & QCHSD_STPDIAG) {
+ 		printk(KERN_WARNING "%s: failed to detect 80c cable. (PDIAG# is high)\n", DRV_NAME);
+ 		remove_mmio_scc(pdev);
+ 		kfree(ports);
+                 return -EIO;
+         }
+ 
+ 	port_info[0] = scc_port_info[ent->driver_data];
+ 	port_info[1] = scc_port_info[ent->driver_data];
+ 	port_info[0].private_data = ports;
+ 	port_info[1].private_data = ports;
+ 
+ 	port_flags = port_info[0].flags;
+ 
+ 	return scc_pci_init_one(pdev, ppinfo, 1); /* n_ports must be 1 */
+ }
+ 
+ static int __init scc_init (void)
+ {
+ 	int rc;
+ 
+ 	DPRINTK("pci_register_driver\n");
+ 	rc = pci_register_driver(&scc_pci_driver);
+ 	if (rc)
+ 		return rc;
+ 
+ 	DPRINTK("done\n");
+ 	return 0;
+ }
+ 
+ static void __exit scc_exit (void)
+ {
+ 	pci_unregister_driver(&scc_pci_driver);
+ }
+ 
+ module_init(scc_init);
+ module_exit(scc_exit);
Index: linux-2.6.19/drivers/ata/libata-core.c
diff -c linux-2.6.19/drivers/ata/libata-core.c:1.1.1.4 linux-2.6.19/drivers/ata/libata-core.c:1.4
*** linux-2.6.19/drivers/ata/libata-core.c:1.1.1.4	Fri Dec  1 13:45:53 2006
--- linux-2.6.19/drivers/ata/libata-core.c	Wed Dec  6 12:00:47 2006
***************
*** 600,606 ****
   *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
   */
  
! static unsigned int
  ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
  {
  	struct ata_taskfile tf;
--- 600,606 ----
   *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
   */
  
! unsigned int
  ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
  {
  	struct ata_taskfile tf;
***************
*** 2297,2322 ****
  }
  
  /**
-  *	ata_tf_to_host - issue ATA taskfile to host controller
-  *	@ap: port to which command is being issued
-  *	@tf: ATA taskfile register set
-  *
-  *	Issues ATA taskfile register set to ATA host controller,
-  *	with proper synchronization with interrupt handler and
-  *	other threads.
-  *
-  *	LOCKING:
-  *	spin_lock_irqsave(host lock)
-  */
- 
- static inline void ata_tf_to_host(struct ata_port *ap,
- 				  const struct ata_taskfile *tf)
- {
- 	ap->ops->tf_load(ap, tf);
- 	ap->ops->exec_command(ap, tf);
- }
- 
- /**
   *	ata_busy_sleep - sleep until BSY clears, or timeout
   *	@ap: port containing status register to be polled
   *	@tmout_pat: impatience timeout
--- 2297,2302 ----
***************
*** 3787,3793 ****
   *	Inherited from caller.
   */
  
! static void ata_pio_sectors(struct ata_queued_cmd *qc)
  {
  	if (is_multi_taskfile(&qc->tf)) {
  		/* READ/WRITE MULTIPLE */
--- 3767,3773 ----
   *	Inherited from caller.
   */
  
! void ata_pio_sectors(struct ata_queued_cmd *qc)
  {
  	if (is_multi_taskfile(&qc->tf)) {
  		/* READ/WRITE MULTIPLE */
***************
*** 3814,3820 ****
   *	caller.
   */
  
! static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
  {
  	/* send SCSI cdb */
  	DPRINTK("send cdb\n");
--- 3794,3800 ----
   *	caller.
   */
  
! void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
  {
  	/* send SCSI cdb */
  	DPRINTK("send cdb\n");
***************
*** 3943,3949 ****
   *	Inherited from caller.
   */
  
! static void atapi_pio_bytes(struct ata_queued_cmd *qc)
  {
  	struct ata_port *ap = qc->ap;
  	struct ata_device *dev = qc->dev;
--- 3923,3929 ----
   *	Inherited from caller.
   */
  
! void atapi_pio_bytes(struct ata_queued_cmd *qc)
  {
  	struct ata_port *ap = qc->ap;
  	struct ata_device *dev = qc->dev;
***************
*** 3984,4016 ****
  }
  
  /**
-  *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
-  *	@ap: the target ata_port
-  *	@qc: qc on going
-  *
-  *	RETURNS:
-  *	1 if ok in workqueue, 0 otherwise.
-  */
- 
- static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
- {
- 	if (qc->tf.flags & ATA_TFLAG_POLLING)
- 		return 1;
- 
- 	if (ap->hsm_task_state == HSM_ST_FIRST) {
- 		if (qc->tf.protocol == ATA_PROT_PIO &&
- 		    (qc->tf.flags & ATA_TFLAG_WRITE))
- 		    return 1;
- 
- 		if (is_atapi_taskfile(&qc->tf) &&
- 		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
- 			return 1;
- 	}
- 
- 	return 0;
- }
- 
- /**
   *	ata_hsm_qc_complete - finish a qc running on standard HSM
   *	@qc: Command to complete
   *	@in_wq: 1 if called from workqueue, 0 otherwise
--- 3964,3969 ----
***************
*** 6122,6127 ****
--- 6075,6081 ----
  EXPORT_SYMBOL_GPL(ata_std_softreset);
  EXPORT_SYMBOL_GPL(sata_std_hardreset);
  EXPORT_SYMBOL_GPL(ata_std_postreset);
+ EXPORT_SYMBOL_GPL(ata_dev_revalidate);
  EXPORT_SYMBOL_GPL(ata_dev_classify);
  EXPORT_SYMBOL_GPL(ata_dev_pair);
  EXPORT_SYMBOL_GPL(ata_port_disable);
***************
*** 6178,6180 ****
--- 6132,6141 ----
  EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
  EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
  EXPORT_SYMBOL_GPL(ata_do_eh);
+ 
+ EXPORT_SYMBOL_GPL(ata_dev_try_classify);
+ EXPORT_SYMBOL_GPL(ata_pio_sectors);
+ EXPORT_SYMBOL_GPL(atapi_send_cdb);
+ EXPORT_SYMBOL_GPL(atapi_pio_bytes);
+ EXPORT_SYMBOL_GPL(ata_dev_select);
+ EXPORT_SYMBOL_GPL(ata_probe_ent_alloc);
Index: linux-2.6.19/include/linux/libata.h
diff -c linux-2.6.19/include/linux/libata.h:1.1.1.4 linux-2.6.19/include/linux/libata.h:1.2
*** linux-2.6.19/include/linux/libata.h:1.1.1.4	Tue Nov 14 11:16:27 2006
--- linux-2.6.19/include/linux/libata.h	Wed Dec  6 09:37:13 2006
***************
*** 752,757 ****
--- 752,764 ----
  extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
  			     unsigned long interval_msec,
  			     unsigned long timeout_msec);
+ extern void ata_dev_select (struct ata_port *ap, unsigned int device, unsigned int wait, unsigned int can_sleep);
+ extern unsigned int ata_dev_try_classify (struct ata_port *ap, unsigned int device, u8 *r_err);
+ extern void ata_pio_sectors (struct ata_queued_cmd *qc);
+ extern void atapi_send_cdb (struct ata_port *ap, struct ata_queued_cmd *qc);
+ extern void atapi_pio_bytes (struct ata_queued_cmd *qc);
+ extern struct ata_probe_ent *ata_probe_ent_alloc (struct device *dev, const struct ata_port_info *port);
+ 
  
  /*
   * Default driver ops implementations
***************
*** 762,767 ****
--- 769,775 ----
  extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
  extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
  extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
+ extern void ata_dev_select (struct ata_port *ap, unsigned int device, unsigned int wait, unsigned int can_sleep);
  extern u8 ata_check_status(struct ata_port *ap);
  extern u8 ata_altstatus(struct ata_port *ap);
  extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
***************
*** 1265,1268 ****
--- 1273,1323 ----
  	return (struct ata_port *) &host->hostdata[0];
  }
  
+ /**
+  *      ata_tf_to_host - issue ATA taskfile to host controller
+  *      @ap: port to which command is being issued
+  *      @tf: ATA taskfile register set
+  *
+  *      Issues ATA taskfile register set to ATA host controller,
+  *      with proper synchronization with interrupt handler and
+  *      other threads.
+  *
+  *      LOCKING:
+  *      spin_lock_irqsave(host lock)
+  */
+ 
+ static inline void ata_tf_to_host(struct ata_port *ap,
+                                   const struct ata_taskfile *tf)
+ {
+         ap->ops->tf_load(ap, tf);
+         ap->ops->exec_command(ap, tf);
+ }
+ 
+ /**
+  *      ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+  *      @ap: the target ata_port
+  *      @qc: qc on going
+  *
+  *      RETURNS:
+  *      1 if ok in workqueue, 0 otherwise.
+  */
+ 
+ static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+ {
+         if (qc->tf.flags & ATA_TFLAG_POLLING)
+                 return 1;
+ 
+         if (ap->hsm_task_state == HSM_ST_FIRST) {
+                 if (qc->tf.protocol == ATA_PROT_PIO &&
+                     (qc->tf.flags & ATA_TFLAG_WRITE))
+                     return 1;
+ 
+                 if (is_atapi_taskfile(&qc->tf) &&
+                     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+                         return 1;
+         }
+ 
+         return 0;
+ }
+ 
  #endif /* __LINUX_LIBATA_H__ */
