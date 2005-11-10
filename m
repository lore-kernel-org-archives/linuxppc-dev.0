Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 4AE0F686EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 19:02:45 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 10 Nov 2005 10:02:37 +0200
References: <1131605445.4691.4.camel@banana>
In-Reply-To: <1131605445.4691.4.camel@banana>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e6vcDuEg1jh4wNt"
Message-Id: <200511100902.38087.david.jander@protonic.nl>
Cc: =?utf-8?q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
Subject: [PATCH] 2.6: PRTPPC board-support was: Re: about MPC 8XX SPI Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_e6vcDuEg1jh4wNt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 10 November 2005 07:50, =E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMA=
IL wrote:
>     Anybody know where can found 'CPM SPI Driver' for MPC852T.I found a
> cpm_spi.c at /arch/ppc/8260_io directory in Linux 2.4.25.But I don't
> know how to program application to
> handle this driver.

Do you want it for 2.4 or 2.6? (I have both running on a mpc852T).
Here's a patch for 2.6.14 (denx-git tree).
Sorry to send you the complete patch for prtppc board support, but the spi=
=20
driver makes up most part of it, so it wouldn't be much smaller anyway ;-)

Regards,

=2D-=20
David Jander
Protonic Holland.

--Boundary-00=_e6vcDuEg1jh4wNt
Content-Type: text/x-diff; charset="utf-8";
	name="linux-2.6.14-20051107-prt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.14-20051107-prt.patch"

diff --git a/arch/ppc/8xx_io/Kconfig b/arch/ppc/8xx_io/Kconfig
--- a/arch/ppc/8xx_io/Kconfig
+++ b/arch/ppc/8xx_io/Kconfig
@@ -77,6 +77,14 @@ config ENET_BIG_BUFFERS
 config HTDMSOUND
 	bool "Embedded Planet HIOX Audio"
 	depends on SOUND=y
+	
+config CPM_SPI
+	bool "Simple CPM SPI driver"
+
+config CPM_SPI_BDSIZE
+	int "Size of Rx/Tx Buffer for SPI"
+	depends on CPM_SPI
+	default "16"
 
 # This doesn't really belong here, but it is convenient to ask
 # 8xx specific questions.
diff --git a/arch/ppc/8xx_io/Makefile b/arch/ppc/8xx_io/Makefile
--- a/arch/ppc/8xx_io/Makefile
+++ b/arch/ppc/8xx_io/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_FEC_ENET)	+= fec.o
 obj-$(CONFIG_SCC_ENET)	+= enet.o
 obj-$(CONFIG_UCODE_PATCH) += micropatch.o
 obj-$(CONFIG_HTDMSOUND) += cs4218_tdm.o
+obj-$(CONFIG_CPM_SPI)   += cpm_spi.o
diff --git a/arch/ppc/8xx_io/cpm_spi.c b/arch/ppc/8xx_io/cpm_spi.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/8xx_io/cpm_spi.c
@@ -0,0 +1,448 @@
+/*
+ * Simple CPM SPI interface for the MPC 8xx.
+ * 
+ * Copyright (c) 2002 Wolfgang Grandegger (wg@denx.de)
+ *
+ * This interface is partially derived from code copyrighted
+ * by Navin Boppuri (nboppuri@trinetcommunication.co) and
+ * Prashant Patel (pmpatel@trinetcommunication.com).
+ *
+ * This driver implements the function "cpm_spi_io()" to be 
+ * used by other drivers and a simple read/write interface 
+ * for user-land applications. The latter is mainly useful 
+ * for debugging purposes. Some further remarks:
+ *
+ * - Board specific definitions and code should go into
+ *   the file "cpm_spi.h".
+ *
+ * - For the moment, no interrupts are used. This be useful 
+ *   for (very) long transfers.
+ *
+ * Ported back from 2.4.25/mpc82xx to 2.6.14/mpc8xx by
+ * David Jander (david@protonic.nl)
+ *
+ */
+
+#ifndef EXPORT_SYMTAB
+#  define EXPORT_SYMTAB /* need this one 'cause we export symbols */
+#endif
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/device.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <asm/8xx_immap.h>
+#include <asm/mpc8xx.h>
+
+#include <asm/commproc.h>
+#include <asm/cpm_spi.h>
+
+#define DRIVER_NAME "cmp_spi"
+
+MODULE_AUTHOR("Wolfgang Grandegger (wg@denx.de)");
+MODULE_DESCRIPTION("Simple Driver for the CPM SPI");
+
+#undef DEBUG
+#ifdef DEBUG
+# define debugk(fmt,args...)    printk(fmt ,##args)
+#else
+# define debugk(fmt,args...)
+#endif
+
+#if defined(CONFIG_SCC2_ENET) && !defined(CONFIG_UCODE_PATCH)
+#error "I2C/SPI Microcode Patch is needed, please enable it!"
+#endif
+
+#define CPM_SPI_MAJOR 65	/* "borrowed" from "plink" driver */
+
+extern void invalidate_dcache_range(unsigned long start, unsigned long end);
+
+static volatile immap_t *immap = (immap_t *)IMAP_ADDR;
+
+static unsigned int dp_addr;
+static ushort r_tbase, r_rbase; 
+static cbd_t *tx_bdf, *rx_bdf;
+static u_char *tx_buf, *rx_buf;
+
+#if CPM_SPI_SWAP_BYTES
+static void swap_bytes(u_char *buf, int len)
+{
+	u_short *sbuf = (u_short *)buf;
+	while (len > 0) {
+		*sbuf = cpu_to_le16(*sbuf);
+		sbuf++; 
+		len -= 2;
+	}
+}
+#else
+#define swap_bytes(buf, len)
+#endif
+
+/*
+ * CPM SPI Kernel API function(s)
+ */
+ssize_t cpm_spi_io (int chip_id, int serial,
+		    u_char *tx_buffer, int tx_size, 
+		    u_char *rx_buffer, int rx_size)
+{
+	unsigned long flags;
+	int i;
+
+	/* 
+	 * Serialize access to the SPI. We have to disable interrupts
+	 * because we may need to call it from interrupt handlers.
+	 */
+	local_irq_save(flags); local_irq_disable();
+
+	rx_bdf->cbd_datlen = 0;
+	if (serial)
+		tx_bdf->cbd_datlen = tx_size + rx_size;
+	else
+		tx_bdf->cbd_datlen = tx_size > rx_size ? tx_size : rx_size;
+	if (tx_bdf->cbd_datlen > CONFIG_CPM_SPI_BDSIZE) {
+		printk("cpm_spi_io: Invalid size\n");
+		local_irq_restore(flags);
+		return -EINVAL;
+	}
+	if (tx_size > 0) {
+		memcpy(tx_buf, tx_buffer, tx_size);
+#ifdef DEBUG
+		printk("Tx:");
+		for (i = 0; i < tx_size; i++)
+			printk(" %02x", tx_buf[i]);
+		printk("\n");
+#endif
+		swap_bytes(tx_buf, tx_size);
+	}
+
+	flush_dcache_range((unsigned long) tx_buf, 
+			   (unsigned long) (tx_buf+CONFIG_CPM_SPI_BDSIZE-1));
+	flush_dcache_range((unsigned long) rx_buf, 
+			   (unsigned long) (rx_buf+CONFIG_CPM_SPI_BDSIZE-1));
+	invalidate_dcache_range((unsigned long) rx_buf, 
+				(unsigned long) (rx_buf+
+						 CONFIG_CPM_SPI_BDSIZE-1));
+
+	/* Setting Rx and Tx BD status and data length */
+	tx_bdf->cbd_sc = BD_SC_READY | BD_SC_LAST | BD_SC_WRAP;
+	rx_bdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+
+	/* Chip select for device */
+	cpm_spi_set_cs(immap, chip_id, 1);
+
+	/* Start SPI Tx/Rx transfer */
+	cpmp->cp_spcom |= 0x80;
+	
+	/* 
+	 * Wait until the Tx/Rx transfer is done. 
+	 */
+	for (i = 0; i < CPM_SPI_POLL_RETRIES; i++) {
+                udelay(1);
+		if ((tx_bdf->cbd_sc & BD_SC_EMPTY) == 0 && 
+		    (rx_bdf->cbd_sc & BD_SC_EMPTY) == 0)
+			break;
+        }
+
+	/* De-select device */
+	cpm_spi_set_cs(immap, chip_id, 0);
+
+	/* Check for timeout */
+	if (i == CPM_SPI_POLL_RETRIES) {
+		printk("cpm_spi_io: Tx/Rx transfer timeout\n");
+		local_irq_restore(flags);
+		return -EIO;
+	}
+
+#ifdef DEBUG
+	printk("Transfer time approx. %d us\n", i);
+	if (rx_bdf->cbd_datlen > 0) {
+		printk("Rx:");
+		for (i = 0; i < rx_bdf->cbd_datlen; i++)
+			printk(" %02x", rx_buf[i]);
+		printk("\n");
+	}
+#endif
+
+	/* Copy receive data if appropriate */
+	i = rx_bdf->cbd_datlen;
+#ifdef DEBUG
+	if (i != tx_bdf->cbd_datlen)
+	{
+		printk("i=%d tx_size=%d rx_size=%d\n", i, tx_size, rx_size);
+	}
+#endif
+	if (i > tx_bdf->cbd_datlen)
+	{
+		local_irq_restore(flags);
+		return -EIO;
+	}
+	swap_bytes(rx_buf, i);
+	if (rx_size > 0) {
+		if (serial) {
+			i -= tx_size;
+			memcpy(rx_buffer, rx_buf + tx_size, i);
+		} else {
+			memcpy(rx_buffer, rx_buf, i);
+		}
+	}
+	
+	local_irq_restore(flags);
+	
+	return i;
+}
+
+EXPORT_SYMBOL(cpm_spi_io);
+
+/*
+ * Prototypes for driver entry functions.
+ */
+static int
+cpm_spi_open(struct inode *inode, struct file *filp);
+static int
+cpm_spi_release(struct inode *inode, struct file *filp);
+static ssize_t
+cpm_spi_read(struct file *filp, char *buf, size_t count, loff_t *f_pos);
+static ssize_t
+cpm_spi_write(struct file *filp, const char *buf, size_t count, loff_t *f_pos);
+static int
+cpm_spi_init(void);
+static void
+cpm_spi_cleanup(void);
+
+/*
+ * File operations supported by this driver.
+ */
+struct file_operations cpm_spi_fops = {
+	owner:   THIS_MODULE,
+	open:    cpm_spi_open,
+	release: cpm_spi_release,
+	read:    cpm_spi_read,
+	write:   cpm_spi_write,
+};
+
+
+static int 
+cpm_spi_open (struct inode *inode, struct file *filp)
+{
+	int minor = MINOR(inode->i_rdev);
+
+	if (minor >= CPM_SPI_MAX_CHIPS)
+		return -ENODEV;
+
+	filp->private_data = (void *)minor;
+	// MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static int 
+cpm_spi_release(struct inode *inode, struct file *filp)
+{
+	// MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static ssize_t 
+cpm_spi_read(struct file *filp, char *buf, size_t count, loff_t *f_pos)
+{
+	u_char tx_kbuf[CONFIG_CPM_SPI_BDSIZE];
+	u_char rx_kbuf[CONFIG_CPM_SPI_BDSIZE];
+	int chip_id = (int)filp->private_data;
+	ssize_t size;
+	
+	debugk("cpm_spi_read: count=%d, chip_id=%d\n", count, chip_id);
+
+	if (count > CONFIG_CPM_SPI_BDSIZE)
+		return -ENXIO;
+	
+	if (copy_from_user(tx_kbuf, buf, count))
+		return -EFAULT;
+	
+	size = cpm_spi_io(chip_id, 0, tx_kbuf, count, rx_kbuf, count);
+	if (size < 0)
+		return size;
+	
+	if (copy_to_user(buf, rx_kbuf, size))
+		return -EFAULT;
+	
+	return size;
+}
+
+static ssize_t 
+cpm_spi_write(struct file *filp, const char *buf, size_t count, loff_t *f_pos)
+{
+	int chip_id = (int)filp->private_data;
+	u_char tx_kbuf[CONFIG_CPM_SPI_BDSIZE];
+
+	if (count > CONFIG_CPM_SPI_BDSIZE)
+		return -ENXIO;
+
+	if (copy_from_user(tx_kbuf, buf, count))
+		return -EFAULT;
+
+	return cpm_spi_io(chip_id, 0, tx_kbuf, count, NULL, 0);
+}
+
+/* Tx and Rx buffers are so small, we don't need to worry about 
+ * consistent alloc. Just make them static here (ugly, but simple).
+ */
+static unsigned char txbufspace[CONFIG_CPM_SPI_BDSIZE];
+static unsigned char rxbufspace[CONFIG_CPM_SPI_BDSIZE];
+
+static int 
+cpm_spi_init(void)
+{
+	int err = 0;
+	volatile spi_t    *spi;
+	
+	
+	printk (KERN_INFO "CPM SPI Driver: $Revision: 1.1 $ wg@denx.de\n");
+
+	/* Global pointer to internal registers */
+	immap = (immap_t *)IMAP_ADDR;
+
+	spi = (spi_t *)&cpmp->cp_dparam[PROFF_SPI];   
+
+#ifdef USE_IIC_PATCH
+        /* Check for and use a microcode relocation patch. */
+        if (spi->spi_rpbase)
+                spi = (spi_t *)&cpmp->cp_dpmem[spi->spi_rpbase];
+        printk("cpm_spi: using microcode patch (spi_rpbase=0x%p)\n", spi);
+#endif
+	
+        /* 
+	 * Initialize the parameter RAM. We need to make sure
+	 * many things are initialized to zero, especially in 
+	 * the case of a microcode patch.
+         */
+        spi->spi_rdp = 0;
+        spi->spi_rbptr = 0;
+        spi->spi_rbc = 0;   
+        spi->spi_rxtmp = 0;
+        spi->spi_tstate = 0;
+        spi->spi_tdp = 0;
+        spi->spi_tbptr = 0;
+        spi->spi_tbc = 0;
+        spi->spi_txtmp = 0;
+
+	/* 
+	 * Allocate space for one transmit and one receive buffer
+         * descriptor in the DP RAM.  
+         */
+        dp_addr = cpm_dpalloc(sizeof(cbd_t) * 2,0);
+        if (dp_addr == CPM_DP_NOSPACE) {
+		printk("cpm_spi: m8xx_cpm_dpalloc() failed\n");
+                return -ENOMEM;
+        }
+
+        /* 
+	 * Set up the IIC parameters in the parameter RAM. 
+	 */
+        spi->spi_rbase = r_rbase = dp_addr;
+        spi->spi_tbase = r_tbase = dp_addr + sizeof(cbd_t);
+
+	/*
+	 * Setting transmit and receive buffer descriptor pointers
+	 * intially to rbase and rbase. 
+	 */
+        spi->spi_rbptr = spi->spi_rbase;
+        spi->spi_tbptr = spi->spi_tbase;
+	
+        /* Setting CPCR */
+		while(cpmp->cp_cpcr & CPM_CR_FLG) ;
+        cpmp->cp_cpcr |= 
+		mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		udelay(1);
+        while(cpmp->cp_cpcr & CPM_CR_FLG) ;
+
+	/* Sets the SDMA configuration register. */
+        immap->im_siu_conf.sc_sdcr = 0x0001;
+
+        /* Set to big endian. */
+        spi->spi_tfcr = SMC_EB;
+        spi->spi_rfcr = SMC_EB;
+
+        /* Set maximum receive size. */
+        spi->spi_mrblr = CONFIG_CPM_SPI_BDSIZE;
+
+	/* 
+	 * Clear all pending SPI events and mask all possible SPI
+	 * interrupts. For the moment we don't use interrupts.
+	 */
+	cpmp->cp_spie = 0xff;
+	cpmp->cp_spim = 0x00;
+
+	/* 
+	 * Set SPI Mode register. 
+	 * Note: the board-specific definitions are in cpm_spi.h. 
+	 */
+        cpmp->cp_spmode = CPM_SPI_SPMODE | SPMODE_EN;
+
+	/* 
+	 * Initiliaze port pins for SPI
+	 *                  par dir odr
+	 * PB28 -> SPIMISO:  1   1   0
+         * PB29 -> SPIMOSI:  1   1   0
+         * PB30 -> SPICLK :  1   1   0
+	 */
+         cpmp->cp_pbpar  |=   0x000e;
+         cpmp->cp_pbdir  |=   0x000e;
+	 cpmp->cp_pbodr  &= ~(0x000e);
+
+	 /* 
+	  * Initialize board-specific port for chip select etc.
+	  * Note: the board-specific definitions are in cpm_spi.h. 
+	  */
+	 cpm_spi_init_ports(immap);
+
+	 /* Tx and Rx buffer descriptors. */
+	 tx_bdf = (cbd_t *)&cpmp->cp_dpmem[r_tbase];
+	 rx_bdf = (cbd_t *)&cpmp->cp_dpmem[r_rbase];
+
+	 /* Initialize Tx and Tx BD's */
+	 rx_bdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+	 tx_bdf->cbd_sc = BD_SC_LAST | BD_SC_WRAP;
+
+	 /* Allocate memory for Rx and Tx buffers */
+	 tx_buf = (u_char *)txbufspace;
+	 rx_buf = (u_char *)rxbufspace;
+	 debugk("rxbuf = 0x%p tx_buf = 0x%p\n", rx_buf, tx_buf);
+
+	 /* Set the bd's rx and tx buffer address pointers */
+	 tx_bdf->cbd_bufaddr = virt_to_bus(tx_buf);
+	 rx_bdf->cbd_bufaddr = virt_to_bus(rx_buf);
+	 debugk("pa:rxbuf = 0x%p pa:tx_buf = 0x%p\n", rx_bdf->cbd_bufaddr, tx_bdf->cbd_bufaddr);
+
+	 /* 
+	  * Finally register the driver.
+	  */
+	 err = register_chrdev(CPM_SPI_MAJOR, DRIVER_NAME, &cpm_spi_fops);
+	 if (err < 0) {
+		 printk("cpm_spi: Couldn't register driver (major=%d)\n", 
+			CPM_SPI_MAJOR);
+		 return err;
+	 }
+
+	return 0;
+}
+
+static void 
+cpm_spi_cleanup(void)
+{
+	unregister_chrdev(CPM_SPI_MAJOR, DRIVER_NAME);
+	cpm_dpfree(dp_addr);	
+}
+
+module_init(cpm_spi_init);
+module_exit(cpm_spi_cleanup);
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -504,6 +504,13 @@ config WINCEPT
 	  MPC821 PowerPC, introduced in 1998 and designed to be used in
 	  thin-client machines.  Say Y to support it directly.
 
+config PRTPPC
+	bool "PRTPPC"
+	help
+	  PRTPPC is a single-board computer module based on a Freescale MPC852T
+	  embedded processor. It is used in different products designed and
+	  manufactured by Protonic Holland.
+
 endchoice
 
 choice
@@ -954,6 +961,16 @@ config NR_CPUS
 config HIGHMEM
 	bool "High memory support"
 
+config PRT_IOADDR
+	hex "PRTPPC IO-address space start"
+	depends on PRTPPC
+	default "0xf8100000"
+	
+config PRT_IOSIZE
+	hex "PRTPPC IO-address space size"
+	depends on PRTPPC
+	default "0x00040000"
+
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "mm/Kconfig"
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
+obj-$(CONFIG_PRTPPC)		+= prtppc_setup.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff --git a/arch/ppc/platforms/prtppc.h b/arch/ppc/platforms/prtppc.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/prtppc.h
@@ -0,0 +1,40 @@
+/*
+ * PRTPPC board definitions, loosely based on:
+ *   TQM8xx(L/M) board specific definitions
+ * 
+ * Author: David Jander <david@protonic.nl>
+ *
+ * Copyright (c) 2005 Protonic Holland b.v.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __PRTPPC_H__
+#define __PRTPPC_H__
+
+#include <linux/config.h>
+
+#include <asm/ppcboot.h>
+
+#define BOARD_CHIP_NAME "MPC86X"
+
+#define	PRTPPC_IMMR_BASE	0xF8000000	/* phys. addr of IMMR */
+#define	PRTPPC_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
+
+#define	IMAP_ADDR	PRTPPC_IMMR_BASE	/* physical base address of IMMR area */
+#define IMAP_SIZE	PRTPPC_IMAP_SIZE	/* mapped size of IMMR area */
+
+/* define IO_BASE for External bus devices */
+#define _IO_BASE        CONFIG_PRT_IOADDR
+#define _IO_BASE_SIZE  	CONFIG_PRT_IOSIZE
+
+#define	FEC_INTERRUPT		 9	/* = SIU_LEVEL4			*/
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+#endif	/* __PRTPPC_H__ */
diff --git a/arch/ppc/platforms/prtppc_serial.h b/arch/ppc/platforms/prtppc_serial.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/prtppc_serial.h
@@ -0,0 +1,100 @@
+/*
+ * include/asm-ppc/prtppc_serial.h
+ * 
+ * Definitions for Protonic PRTPPC board multi-uart interface
+ * 	Usable for PRTACM and MSAMPS doughterboards.
+ * 
+ * Author: David Jander <david@protonic.nl>
+ *
+ * Copyright (c) 2005 Protonic Holland b.v.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __PRTPPC_SERIAL_H
+#define __PRTPPC_SERIAL_H
+
+#include <linux/config.h>
+
+/* Make room for 3 mpc8xx SCM devices at minor 64,65 and 66 */
+// #define SERIAL_DEV_OFFSET	3
+
+#if !defined(CONFIG_PRT_UARTADDR)
+#define CONFIG_PRT_UARTADDR _IO_BASE
+#endif
+
+/* Define the UART base addresses and IRQs */
+#define	PRTPPC_UART0_BASE	(CONFIG_PRT_UARTADDR)
+#define	PRTPPC_UART1_BASE	(CONFIG_PRT_UARTADDR + 8)
+#define	PRTPPC_UART2_BASE	(CONFIG_PRT_UARTADDR + 16)
+#define	PRTPPC_UART3_BASE	(CONFIG_PRT_UARTADDR + 24)
+#define	PRTPPC_UART4_BASE	(CONFIG_PRT_UARTADDR + 32)
+#define	PRTPPC_UART5_BASE	(CONFIG_PRT_UARTADDR + 40)
+#define	PRTPPC_UART6_BASE	(CONFIG_PRT_UARTADDR + 48)
+#define	PRTPPC_UART7_BASE	(CONFIG_PRT_UARTADDR + 56)
+
+/* On PRTACM there are 2 16C554 quad uart chips, with INTx outputs
+ * Negted and OR'd together 4 on 1. 
+ * Chip one goes to IRQ1, Chip two to IRQ2 
+ */
+#define PRTPPC_UART0_IRQ	SIU_IRQ1
+#define PRTPPC_UART1_IRQ	SIU_IRQ1
+#define PRTPPC_UART2_IRQ	SIU_IRQ1
+#define PRTPPC_UART3_IRQ	SIU_IRQ1
+#define PRTPPC_UART4_IRQ	SIU_IRQ2
+#define PRTPPC_UART5_IRQ	SIU_IRQ2
+#define PRTPPC_UART6_IRQ	SIU_IRQ2
+#define PRTPPC_UART7_IRQ	SIU_IRQ2
+
+
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define RS_TABLE_SIZE  16
+#else
+#define RS_TABLE_SIZE  8
+#endif
+
+/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
+#define BASE_BAUD ( 1843200 / 16 )
+
+/* AUTO_IRQ is scary, but maybe it even works :-) */
+#ifdef CONFIG_SERIAL_DETECT_IRQ
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
+#else
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
+#endif
+
+/* Define a prototype UART entry.... */
+#define STD_SERIAL_PORT_ITEM(num) \
+	{ 0, BASE_BAUD, PRTPPC_UART##num##_BASE, 		\
+		PRTPPC_UART##num##_IRQ, 			\
+		STD_COM_FLAGS, 					\
+		iomem_base: (u8 *)PRTPPC_UART##num##_BASE,	\
+		iomem_reg_shift: 0,				\
+		io_type: SERIAL_IO_MEM }
+
+/* Make a table from it */
+#if (CONFIG_SERIAL_8250_NR_UARTS > 4)
+#define STD_SERIAL_PORT_DFNS \
+		STD_SERIAL_PORT_ITEM(0), \
+		STD_SERIAL_PORT_ITEM(1), \
+		STD_SERIAL_PORT_ITEM(2), \
+		STD_SERIAL_PORT_ITEM(3), \
+		STD_SERIAL_PORT_ITEM(4), \
+		STD_SERIAL_PORT_ITEM(5), \
+		STD_SERIAL_PORT_ITEM(6), \
+		STD_SERIAL_PORT_ITEM(7)
+#else
+#define STD_SERIAL_PORT_DFNS \
+		STD_SERIAL_PORT_ITEM(0), \
+		STD_SERIAL_PORT_ITEM(1), \
+		STD_SERIAL_PORT_ITEM(2), \
+		STD_SERIAL_PORT_ITEM(3)
+#endif /* CONFIG_SERIAL_8250_NR_UARTS */
+
+#define SERIAL_PORT_DFNS \
+        STD_SERIAL_PORT_DFNS
+
+#endif /* __PRTPPC_SERIAL_H */
diff --git a/arch/ppc/platforms/prtppc_setup.c b/arch/ppc/platforms/prtppc_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/prtppc_setup.c
@@ -0,0 +1,88 @@
+/*
+ * arch/ppc/platforms/prtppc_setup.c
+ *
+ * PRTPPC platform support
+ *
+ * Author: David Jander <david@protonic.nl>
+ *
+ * Copyright (c) 2005 Protonic Holland b.v.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/usb_isp116x.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+
+#include <asm/mpc8xx.h>
+#include <asm/8xx_immap.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/delay.h>
+
+struct resource prt_isp1160_resource[] =
+{
+	{
+		.name = "isp1160_data",
+		.flags = IORESOURCE_MEM,
+		.start = 0xf8100040,
+		.end = 0xf8100041,
+	},
+	{
+		.name = "isp1160_addr",
+		.flags = IORESOURCE_MEM,
+		.start = 0xf8100042,
+		.end = 0xf8100043,
+	},
+	{
+		.name = "isp1160_irq",
+		.flags = IORESOURCE_IRQ,
+		.start = SIU_IRQ6,
+		.end = SIU_IRQ6,
+	}
+};
+
+
+void platform_delay(struct device * dev, int delay)
+{
+	ndelay(delay);
+}
+
+struct isp116x_platform_data isp1160_config =
+{
+	.sel15Kres = 1,
+	.oc_enable = 1,
+	.int_act_high = 0,
+	.int_edge_triggered = 1,
+	.remote_wakeup_enable = 0,
+	.delay = platform_delay,
+};
+			
+void __init prtppc_platform_init(void)
+{
+	struct platform_device *pdev;
+	static volatile immap_t *immap = (immap_t *)IMAP_ADDR;
+	
+	printk("prtppc_platform_init()\n");
+	
+	pdev = platform_device_register_simple("isp116x-hcd",0,prt_isp1160_resource,3);
+	pdev->dev.platform_data = &isp1160_config;
+	
+	/* Configure SIU_IRQ6 as edge triggered */
+	immap->im_siu_conf.sc_siel |= 0x00080000;
+	irq_desc[SIU_IRQ6].status &= ~IRQ_LEVEL;
+}
+
+/* Anything special for this platform */
+void __init board_init(void)
+{
+	/* Register a platform_init function */
+	ppc_md.init=prtppc_platform_init;
+}
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -367,7 +367,7 @@ m8xx_map_io(void)
 #ifdef CONFIG_PCI
         io_block_mapping(PCI_CSR_ADDR, PCI_CSR_ADDR, PCI_CSR_SIZE, _PAGE_IO);
 #endif
-#if defined(CONFIG_NETTA)
+#if defined(CONFIG_NETTA) || defined (CONFIG_PRTPPC)
 	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
 #endif
 }
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -10,7 +10,8 @@ menu "USB support"
 config USB_ARCH_HAS_HCD
 	boolean
 	default y if USB_ARCH_HAS_OHCI
-	default y if ARM				# SL-811
+	default y if ARM                               # SL-811
+	default y if PRTPPC
 	default PCI
 
 # many non-PCI SOC chips embed OHCI
diff --git a/drivers/usb/host/isp116x.h b/drivers/usb/host/isp116x.h
--- a/drivers/usb/host/isp116x.h
+++ b/drivers/usb/host/isp116x.h
@@ -365,6 +365,33 @@ struct isp116x_ep {
 #define	IRQ_TEST()	do{}while(0)
 #endif
 
+#if defined(CONFIG_PRTPPC)
+/* On the PRTPPC the ISP1160 is connected through an 8-bit bus via a CPLD
+ * which translates the 8-bit data to 16-bit back and forth.
+ * The UPM splits the 16-bit bus-cycles up into two 8-bit cycles.
+ * The only caveat is that on writing, we have to write to the higher address first
+ * and then to the lower address, while on reading it has to be done the other way around,
+ * that is first the lower address and then the higher address.
+ * So for reading we can use normal 16-bit read functions, while for writing,
+ * we just redefine (temporarily) writew() and __raw_writew() to these below.
+ */
+static void inline writew_hcd(unsigned int port,u16 data)
+{
+	out_8((volatile unsigned char __iomem *)(port | 0x00000001), (data>>8) & 0x00ff);
+	out_8((volatile unsigned char __iomem *)(port & 0xfffffffe), data & 0x00ff);
+}
+
+static void inline raw_writew_hcd(unsigned int port,u16 data)
+{
+	__raw_writeb(data & 0x00ff, (volatile unsigned char __iomem *)(port | 0x00000001));
+	__raw_writeb((data>>8) & 0x00ff, (volatile unsigned char __iomem *)(port & 0xfffffffe));
+}
+
+#define writew(b,a) 		writew_hcd((unsigned int)(a),b)
+#define __raw_writew(b,a) 	raw_writew_hcd((unsigned int)(a),b)
+
+#endif /* CONFIG_PRTPPC */
+
 static inline void isp116x_write_addr(struct isp116x *isp116x, unsigned reg)
 {
 	IRQ_TEST();
@@ -421,6 +448,11 @@ static inline u32 isp116x_read_data32(st
 	return val;
 }
 
+#if defined(CONFIG_PRTPPC)
+#undef writew
+#undef __raw_writew
+#endif /* CONFIG_PRTPPC */
+
 /* Let's keep register access functions out of line. Hint:
    we wait at least 150 ns at every access.
 */
diff --git a/include/asm-ppc/cpm_spi.h b/include/asm-ppc/cpm_spi.h
new file mode 100644
--- /dev/null
+++ b/include/asm-ppc/cpm_spi.h
@@ -0,0 +1,340 @@
+/*
+ * Simple CPM SPI interface for the MPC 8260 and MPC 8xx.
+ * 
+ * Copyright (c) 2002 Wolfgang Grandegger (wg@denx.de)
+ *
+ * This interface is partly derived from code copyrighted
+ * by Navin Boppuri (nboppuri@trinetcommunication.co) and
+ * Prashant Patel (pmpatel@trinetcommunication.com).
+ */
+
+#ifndef __CPM_SPI_H
+#define __CPM_SPI_H 
+
+#define SPMODE_LEN(x) (((x) - 1) << 4)
+
+#define CPM_SPI_POLL_RETRIES 1000 /* in micro-seconds */
+
+/*
+ * Board specific setting and functions:
+ *
+ * CPM_SPI_MAX_CHIPS: Maximum number of chips on the SPI.
+ *
+ * CPM_SPI_CLOCK: the bitwise or of the DIV16 and PM bits,
+ *      see 16.12.4.1 in the MPC823e User's Manual.
+ *
+ * CPM_SPI_MODE : SPI mode setting,
+ *      see 16.12.4.1 in the MPC823e User's Manual.
+ * 
+ */
+
+#ifdef CONFIG_R360MPI
+/* There are two MPC2510 connected to the SPI */
+
+#define CPM_SPI_MAX_CHIPS	2
+#if 1
+#define CPM_SPI_BITS_PER_CHAR	8
+#define CPM_SPI_SWAP_BYTES	0
+#else
+#define CPM_SPI_BITS_PER_CHAR	16
+#define CPM_SPI_SWAP_BYTES	1
+#endif
+
+/* There are read timeouts with a clock value of 2 */ 
+#define CPM_SPI_CLOCK 		3
+
+#define CPM_SPI_SPMODE (SPMODE_REV | SPMODE_MSTR | \
+			SPMODE_LEN(CPM_SPI_BITS_PER_CHAR) |\
+	                CPM_SPI_CLOCK)
+
+static inline void
+cpm_spi_init_ports (volatile immap_t *immap)
+{
+        volatile iop8xx_t *iop = &immap->im_ioport;
+	/* we use PC14 and PC15 for chip select */
+	iop->iop_pcpar &= ~(0x0003);
+	iop->iop_pcdir |=   0x0003;
+	iop->iop_pcso  &= ~(0x0003);
+	iop->iop_pcdat |=   0x0003 ; /* de-select */
+}
+
+static inline void
+cpm_spi_set_cs (volatile immap_t *immap, int id, int select)
+{
+        volatile iop8xx_t *iop = &immap->im_ioport;
+	/* we use PC14/PC15 for chip 0/1 select */
+	if (select)
+		iop->iop_pcdat &= ~(2 >> id);
+	else
+		iop->iop_pcdat |=  (2 >> id);
+}
+
+#elif defined(CONFIG_HMI10)
+
+#define CPM_SPI_MAX_CHIPS	1
+#define CPM_SPI_BITS_PER_CHAR	8
+#define CPM_SPI_SWAP_BYTES	0
+
+#define CPM_SPI_CLOCK 		15
+
+#define CPM_SPI_SPMODE (SPMODE_CP | SPMODE_REV | SPMODE_MSTR | \
+			SPMODE_LEN(CPM_SPI_BITS_PER_CHAR) |\
+	                CPM_SPI_CLOCK)
+
+static inline void
+cpm_spi_init_ports (volatile immap_t *immap)
+{
+        volatile iop8xx_t *iop = &immap->im_ioport;
+	/* we use PA6 for chip select */
+	iop->iop_papar &= ~(0x0200);
+	iop->iop_padir |=   0x0200;
+	iop->iop_padat |=   0x0200 ; /* de-select */
+}
+
+static inline void
+cpm_spi_set_cs (volatile immap_t *immap, int id, int select)
+{
+        volatile iop8xx_t *iop = &immap->im_ioport;
+	/* we use PA6 for chip select */
+	if (select)
+		iop->iop_padat &= ~(0x0200);
+	else
+		iop->iop_padat |=  (0x0200);
+}
+
+#elif defined (CONFIG_PM826)
+/* There are two MPC2510 connected to the SPI */
+
+#define CPM_SPI_MAX_CHIPS	32
+#if 0
+#define CPM_SPI_BITS_PER_CHAR	8
+#define CPM_SPI_SWAP_BYTES	0
+#else
+#define CPM_SPI_BITS_PER_CHAR	16
+#define CPM_SPI_SWAP_BYTES	1
+#endif
+
+/* There are read timeouts with a clock value of 2 */ 
+#define CPM_SPI_CLOCK 		0
+
+#define CPM_SPI_SPMODE (SPMODE_REV | SPMODE_MSTR | \
+			SPMODE_LEN(CPM_SPI_BITS_PER_CHAR) |\
+	                CPM_SPI_CLOCK)
+
+/*
+ * Pin configuration:
+ *
+ * SEL:
+ *   PD19
+ *
+ * CS:
+ *   PA9 PA8 PB17 PB16 PB13 PB12
+ *   High                   Low
+ *
+ * IRQ:
+ *   PC7 PC6 PC5 PC4 PC3 PC2 PC1
+ *   High                    Low 
+ */
+
+static inline void
+cpm_spi_init_ports (volatile immap_t *immap)
+{
+	volatile iop8260_t *iop = &immap->im_ioport;
+
+	/* Configure CS pins */
+	iop->iop_ppara &= ~0x00c00000;
+	iop->iop_pdira |=  0x00c00000;
+	iop->iop_podra &= ~0x00c00000;
+	iop->iop_pdata &= ~0x00c00000;
+
+	iop->iop_pparb &= ~0x000cc000;
+	iop->iop_pdirb |=  0x000cc000;
+	iop->iop_podrb &= ~0x000cc000;
+	iop->iop_pdatb &= ~0x000cc000;
+
+	iop->iop_ppard &= ~0x00001000;
+	iop->iop_pdird |=  0x00001000;
+	iop->iop_podrd &= ~0x00001000;
+	iop->iop_podrd |=  0x00001000;
+
+	/* Configure IRQ pins */
+	iop->iop_pparc &= ~0x7f000000;
+	iop->iop_pdirc &= ~0x7f000000;
+	iop->iop_podrc |=  0x7f000000;
+}
+
+static inline void
+cpm_spi_set_cs (volatile immap_t *immap, int id, int select)
+{
+	volatile iop8260_t *iop = &immap->im_ioport;
+	unsigned long portb, porta;
+
+	if (select) {
+		iop->iop_pdatd |= 0x00001000;
+		
+		porta = portb = 0;
+		if (id & 0x01) portb |= 0x00080000;
+		if (id & 0x02) portb |= 0x00040000;
+		if (id & 0x04) portb |= 0x00008000;
+		if (id & 0x08) portb |= 0x00004000;
+		if (id & 0x10) porta |= 0x00800000;
+		if (id & 0x20) porta |= 0x00400000;
+
+		iop->iop_pdata  = (iop->iop_pdata & ~0x00c00000) | porta;
+		iop->iop_pdatb  = (iop->iop_pdatb & ~0x000cc000) | portb;
+		iop->iop_pdatd &= ~0x00001000;
+
+	} else {
+#if 0 /* SEL line won't work correctly */
+		iop->iop_pdatd |= 0x00001000;
+#else
+		iop->iop_pdata &= ~0x00c00000;
+		iop->iop_pdatb &= ~0x000cc000;
+#endif
+	}
+}
+
+static inline int
+cpm_spi_get_irq_cs (void)
+{
+	volatile immap_t *immap = (immap_t *)IMAP_ADDR;
+	volatile iop8260_t *iop = &immap->im_ioport;
+	unsigned long portc;
+	int irq;
+
+	portc = iop->iop_pdatc;
+
+	irq = 0;
+	if (portc & 0x01000000) irq += 64;
+	if (portc & 0x02000000) irq += 32;
+	if (portc & 0x04000000) irq += 16;
+	if (portc & 0x08000000) irq += 8;
+	if (portc & 0x10000000) irq += 4;
+	if (portc & 0x20000000) irq += 2;
+	if (portc & 0x40000000) irq += 1;
+
+	return irq;
+}
+
+#elif defined (CONFIG_ATC)
+
+#define CPM_SPI_MAX_CHIPS	32
+#define CPM_SPI_SWAP_BYTES	0
+
+static inline void
+cpm_spi_init_ports (volatile immap_t *immap)
+{
+
+	immap->im_ioport.iop_ppard &= ~0x00080000;
+	immap->im_ioport.iop_pdird |= 0x00080000;
+	immap->im_ioport.iop_podrd &= ~0x00080000;
+	immap->im_ioport.iop_pdatd |= 0x00080000;
+}
+
+static inline void
+cpm_spi_set_cs (volatile immap_t *immap, int id, int select)
+{
+
+	if (select) {
+		immap->im_ioport.iop_pdatd &= ~0x00080000;
+	} else {
+		immap->im_ioport.iop_pdatd |= 0x00080000;
+	}
+}
+    
+#elif defined (CONFIG_PRTPPC)
+
+#define NUM_SPI_CHIPSELS    4
+
+#define PB_SPI_CS0      0x00010000      /* PB 15 is Chip Select for the RTC */
+#define PB_SPI_CS1      0x00000001      /* PB 31 is Chip select for the MMC */
+#define PA_SPI_CS2      0x2000      /* PA 2 (PA has 16-bit registers !!) */
+#define PA_SPI_CS3      0x1000      /* PA 3 (PA has 16-bit registers !!) */
+
+#define CPM_SPI_MAX_CHIPS       NUM_SPI_CHIPSELS
+#define CPM_SPI_SWAP_BYTES      0
+
+#define CPM_SPI_SPMODE (/* SPMODE_DIV16 | */\
+                        SPMODE_CP |     \
+                        SPMODE_REV |    \
+                        SPMODE_MSTR |   \
+                        SPMODE_LEN(8) | \
+                        0x0f )
+
+static inline void
+cpm_spi_init_ports (volatile immap_t *immap)
+{
+        printk("CPM_SPI: Config chipsels\n");
+        /* Set Port-B pin assignment for SPI pins */
+	immap->im_cpm.cp_pbpar |= 0x0000000e; /* Route PB30,29,28 to second function */
+    	immap->im_cpm.cp_pbdir |= 0x0000000e; /* Select SPI block for second function */
+
+    	/* Set Port-B and Port-A pin assignments for SPI_CS0...CS3 pins */
+    	immap->im_cpm.cp_pbpar &= ~(PB_SPI_CS0 | PB_SPI_CS1); /* Route PB15,PB31 to GPIO */
+    	immap->im_ioport.iop_papar &= ~(PA_SPI_CS2 | PA_SPI_CS3); /* Route PB15,PB31 to GPIO */
+
+    	immap->im_cpm.cp_pbdir |= (PB_SPI_CS0 | PB_SPI_CS1);  /* Set PB15,PB31 as outputs */
+    	immap->im_ioport.iop_padir |= (PA_SPI_CS2 | PA_SPI_CS3);  /* Set PA2,PA3 as outputs */
+
+    	immap->im_cpm.cp_pbdat |= (PB_SPI_CS0 | PB_SPI_CS1);  /* Clear Chip Selects (active low) */
+    	immap->im_ioport.iop_padat |= (PA_SPI_CS2 | PA_SPI_CS3);  /* Clear Chip Selects (active low) */
+}
+
+static inline void
+cpm_spi_set_cs (volatile immap_t *immap, int id, int select)
+{
+    	/* printk("CPM_SPI: CS%d = %d\n",id,select); */
+	if(select) {		
+		switch(id)
+		{
+			case 0:
+               			immap->im_cpm.cp_pbdat |= PB_SPI_CS0; /* SET */
+				/* Clear all others */
+				immap->im_cpm.cp_pbdat |= PB_SPI_CS1;
+				immap->im_ioport.iop_padat |= PA_SPI_CS2 | PA_SPI_CS3;
+			break;
+			case 1:
+               			immap->im_cpm.cp_pbdat &= ~PB_SPI_CS1; /* SET */
+				/* Clear all others */
+				immap->im_cpm.cp_pbdat &= ~PB_SPI_CS0;
+				immap->im_ioport.iop_padat |= PA_SPI_CS2 | PA_SPI_CS3;
+			break;
+			case 2:
+               			immap->im_ioport.iop_padat &= ~PA_SPI_CS2; /* SET */
+				/* Clear all others */
+				immap->im_cpm.cp_pbdat &= ~PB_SPI_CS0;
+				immap->im_cpm.cp_pbdat |= PB_SPI_CS1;
+				immap->im_ioport.iop_padat |= PA_SPI_CS3;
+			break;
+			case 3:
+               			immap->im_ioport.iop_padat &= ~PA_SPI_CS3; /* SET */
+				/* Clear all others */
+				immap->im_cpm.cp_pbdat &= ~PB_SPI_CS0;
+				immap->im_cpm.cp_pbdat |= PB_SPI_CS1;
+				immap->im_ioport.iop_padat |= PA_SPI_CS2;
+			break;
+			default:
+			break;
+		}
+	}
+	else {
+		/* Just clear all CS's */
+		/* FIXME: This _can_ go wrong when doing this:
+		   Select1
+		   Do something on SPI 1
+		   Select2
+		   Unselect 1
+		   Do something on SPI 2 will fail
+		   Unselect 2
+		*/
+		immap->im_cpm.cp_pbdat &= ~PB_SPI_CS0;
+		immap->im_cpm.cp_pbdat |= PB_SPI_CS1;
+		immap->im_ioport.iop_padat |= PA_SPI_CS2 | PA_SPI_CS3;
+	}
+}
+
+#else
+#error "CPM SPI support is not implemented for your board"
+#endif
+
+#endif
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -68,6 +68,10 @@
 #include <platforms/mpc885ads.h>
 #endif
 
+#if defined(CONFIG_PRTPPC)
+#include <platforms/prtppc.h>
+#endif
+
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */
diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
--- a/include/asm-ppc/serial.h
+++ b/include/asm-ppc/serial.h
@@ -38,6 +38,8 @@
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_RADSTONE_PPC7D)
 #include <platforms/radstone_ppc7d.h>
+#elif defined(CONFIG_PRTPPC)
+#include <platforms/prtppc_serial.h>
 #else
 
 /*

--Boundary-00=_e6vcDuEg1jh4wNt--
