Return-Path: <jtyner@eon.cs.ucr.edu>
Received: from mail.cs.ucr.edu (mail.cs.ucr.edu [138.23.169.83])
	by ozlabs.org (Postfix) with ESMTP id B0C20DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:05:04 +1100 (EST)
Received: from mail.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 37EC22AEB66
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:05:03 -0800 (PST)
Received: from eon.cs.ucr.edu (eon.cs.ucr.edu [138.23.169.9])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 1CAC42AEB8E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:05:01 -0800 (PST)
Received: from eon.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by eon.cs.ucr.edu (Postfix) with ESMTP id C914FF3FC9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:05:00 -0800 (PST)
Received: (from jtyner@localhost)
	by eon.cs.ucr.edu (8.13.1/8.13.1/Submit) id lB3L50p5029186
	for linuxppc-dev@ozlabs.org; Mon, 3 Dec 2007 13:05:00 -0800
Date: Mon, 3 Dec 2007 13:05:00 -0800
From: John Tyner <jtyner@cs.ucr.edu>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make QSpan PCI work
Message-ID: <20071203210500.GB22557@cs.ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch makes the QSpan PCI code compile and work on my 
hardware. The patch is against 2.4, but I'm hoping it will still be viewed 
as useful since the code currently does not even compile (2.6 is the 
same). I had to make a change to move the PCI setup later in the 
m8xx_setup code as well because the kernel would crash during the 
pcibios_alloc_controller because the bootmem stuff had not come up yet.

Please CC me on any responses since I'm not subscribed.

Thanks,
John

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="qspan.patch"

diff -ruNa linux-2.4.35.4.orig/arch/ppc/kernel/m8xx_setup.c linux-2.4.35.4/arch/ppc/kernel/m8xx_setup.c
--- linux-2.4.35.4.orig/arch/ppc/kernel/m8xx_setup.c	2007-11-17 09:23:15.000000000 -0800
+++ linux-2.4.35.4/arch/ppc/kernel/m8xx_setup.c	2007-11-29 14:38:41.000000000 -0800
@@ -65,6 +65,10 @@
 {
 	int	cpm_page;
 
+#ifdef CONFIG_PCI
+	m8xx_setup_pci_ptrs();
+#endif
+
 	cpm_page = (int) alloc_bootmem_pages(PAGE_SIZE);
 
 	/* Reset the Communication Processor Module.
@@ -364,10 +368,6 @@
 	if ( r3 )
 		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
 
-#ifdef CONFIG_PCI
-	m8xx_setup_pci_ptrs();
-#endif
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
 	if ( r4 )
diff -ruNa linux-2.4.35.4.orig/arch/ppc/kernel/qspan_pci.c linux-2.4.35.4/arch/ppc/kernel/qspan_pci.c
--- linux-2.4.35.4.orig/arch/ppc/kernel/qspan_pci.c	2007-11-17 09:23:15.000000000 -0800
+++ linux-2.4.35.4/arch/ppc/kernel/qspan_pci.c	2007-12-03 11:22:44.000000000 -0800
@@ -28,6 +28,7 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 
+#include "qspan_pci.h"
 
 /*
  * This blows......
@@ -83,7 +84,7 @@
 		"	.align 2\n"			\
 		"	.long 1b,3b\n"			\
 		".text"					\
-		: "=r"(x) : "r"(addr) : " %0")
+		: "+r"(x) : "r"(addr) )
 
 #define QS_CONFIG_ADDR	((volatile uint *)(PCI_CSR_ADDR + 0x500))
 #define QS_CONFIG_DATA	((volatile uint *)(PCI_CSR_ADDR + 0x504))
@@ -94,8 +95,8 @@
 #define mk_config_type1(bus, dev, offset) \
 	mk_config_addr(bus, dev, offset) | 1;
 
-int qspan_pcibios_read_config_byte(unsigned char bus, unsigned char dev_fn,
-				  unsigned char offset, unsigned char *val)
+static int qspan_pcibios_read_config_byte(struct pci_dev * const dev,
+                                          int offset, u8 * const val)
 {
 	uint	temp;
 	u_char	*cp;
@@ -103,7 +104,7 @@
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127)) {
+	if ((dev->bus->number > 7) || (dev->devfn > 127)) {
 		*val = 0xff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -115,10 +116,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	__get_qspan_pci_config(temp, QS_CONFIG_DATA, "lwz");
 
 #ifdef CONFIG_RPXCLASSIC
@@ -133,8 +134,8 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_read_config_word(unsigned char bus, unsigned char dev_fn,
-				  unsigned char offset, unsigned short *val)
+static int qspan_pcibios_read_config_word(struct pci_dev * const dev,
+                                          int offset, u16 * const val)
 {
 	uint	temp;
 	ushort	*sp;
@@ -142,7 +143,7 @@
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127)) {
+	if ((dev->bus->number > 7) || (dev->devfn > 127)) {
 		*val = 0xffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -154,10 +155,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	__get_qspan_pci_config(temp, QS_CONFIG_DATA, "lwz");
 	offset ^= 0x02;
 
@@ -172,14 +173,14 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_read_config_dword(unsigned char bus, unsigned char dev_fn,
-				   unsigned char offset, unsigned int *val)
+static int qspan_pcibios_read_config_dword(struct pci_dev * const dev,
+                                           const int offset, u32 * const val)
 {
 #ifdef CONFIG_RPXCLASSIC
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127)) {
+	if ((dev->bus->number > 7) || (dev->devfn > 127)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -191,10 +192,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	__get_qspan_pci_config(*val, QS_CONFIG_DATA, "lwz");
 
 #ifdef CONFIG_RPXCLASSIC
@@ -206,8 +207,8 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_write_config_byte(unsigned char bus, unsigned char dev_fn,
-				   unsigned char offset, unsigned char val)
+static int qspan_pcibios_write_config_byte(struct pci_dev * const dev,
+                                           int offset, const u8 val)
 {
 	uint	temp;
 	u_char	*cp;
@@ -215,10 +216,10 @@
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127))
+	if ((dev->bus->number > 7) || (dev->devfn > 127))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	qspan_pcibios_read_config_dword(bus, dev_fn, offset, &temp);
+	qspan_pcibios_read_config_dword(dev, offset, &temp);
 
 	offset ^= 0x03;
 	cp = ((u_char *)&temp) + (offset & 0x03);
@@ -231,10 +232,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	*QS_CONFIG_DATA = temp;
 
 #ifdef CONFIG_RPXCLASSIC
@@ -246,8 +247,8 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_write_config_word(unsigned char bus, unsigned char dev_fn,
-				   unsigned char offset, unsigned short val)
+static int qspan_pcibios_write_config_word(struct pci_dev * const dev,
+                                           int offset, const u16 val)
 {
 	uint	temp;
 	ushort	*sp;
@@ -255,10 +256,10 @@
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127))
+	if ((dev->bus->number > 7) || (dev->devfn > 127))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	qspan_pcibios_read_config_dword(bus, dev_fn, offset, &temp);
+	qspan_pcibios_read_config_dword(dev, offset, &temp);
 
 	offset ^= 0x02;
 	sp = ((ushort *)&temp) + ((offset >> 1) & 1);
@@ -271,10 +272,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	*QS_CONFIG_DATA = temp;
 
 #ifdef CONFIG_RPXCLASSIC
@@ -286,14 +287,14 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_write_config_dword(unsigned char bus, unsigned char dev_fn,
-				    unsigned char offset, unsigned int val)
+static int qspan_pcibios_write_config_dword(struct pci_dev * const dev,
+                                            const int offset, const u32 val)
 {
 #ifdef CONFIG_RPXCLASSIC
 	unsigned long flags;
 #endif
 
-	if ((bus > 7) || (dev_fn > 127))
+	if ((dev->bus->number > 7) || (dev->devfn > 127))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 #ifdef CONFIG_RPXCLASSIC
@@ -303,10 +304,10 @@
 	eieio();
 #endif
 
-	if (bus == 0)
-		*QS_CONFIG_ADDR = mk_config_addr(bus, dev_fn, offset);
+	if (dev->bus->number == 0)
+		*QS_CONFIG_ADDR = mk_config_addr(dev->bus->number, dev->devfn, offset);
 	else
-		*QS_CONFIG_ADDR = mk_config_type1(bus, dev_fn, offset);
+		*QS_CONFIG_ADDR = mk_config_type1(dev->bus->number, dev->devfn, offset);
 	*(unsigned int *)QS_CONFIG_DATA = val;
 
 #ifdef CONFIG_RPXCLASSIC
@@ -318,62 +319,140 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int qspan_pcibios_find_device(unsigned short vendor, unsigned short dev_id,
-			     unsigned short index, unsigned char *bus_ptr,
-			     unsigned char *dev_fn_ptr)
+static void qspan_init( void )
 {
-    int num, devfn;
-    unsigned int x, vendev;
+        qspan_t * const qs = (qspan_t *)PCI_CSR_ADDR;
 
-    if (vendor == 0xffff)
-	return PCIBIOS_BAD_VENDOR_ID;
-    vendev = (dev_id << 16) + vendor;
-    num = 0;
-    for (devfn = 0;  devfn < 32;  devfn++) {
-	qspan_pcibios_read_config_dword(0, devfn<<3, PCI_VENDOR_ID, &x);
-	if (x == vendev) {
-	    if (index == num) {
-		*bus_ptr = 0;
-		*dev_fn_ptr = devfn<<3;
-		return PCIBIOS_SUCCESSFUL;
-	    }
-	    ++num;
-	}
-    }
-    return PCIBIOS_DEVICE_NOT_FOUND;
+        /*
+         * clear all PCI error status
+         * disable SERR, and PERR
+         * disable I/O-space, memory-space, and bus mastering
+         */
+        qs->pci_cs      = QSPCI_CS_D_PE | QSPCI_CS_S_SERR | QSPCI_CS_R_MA |
+                QSPCI_CS_R_TA | QSPCI_CS_S_TA | QSPCI_CS_DEVSEL( 1 ) |
+                QSPCI_CS_MD_PED;
+
+        /* Disable i20 mode */
+        qs->i20_cs     |= QSI20_CS_I20_EN;
+
+        /* disable all slave and target images */
+        qs->pbti0_ctl   = 0;
+        qs->pbti1_ctl   = 0;
+        qs->qbsi0_at    = 0;
+        qs->qbsi1_at    = 0;
+
+        /*
+         * set latency timer to 8 clocks
+         * disable cache line
+         */
+        qs->pci_misc0   = 0;
+
+        /*
+         * allow PCI access to the 4KByte register file in PCI memory space
+         * (put at bottom, the PCI autoconfigure routine places PCI-memory
+         * devices found from the top of PCI memory space down)
+         */
+        qs->pci_bsm     = 0;
+
+        /* disable the PCI configuration expansion ROM */
+        qs->pci_bsrom   = 0;
+
+        /*
+         * set interrupt line to zero (this is a S/W register, its value
+         * is a don't care for the F/W)
+         */
+        qs->pci_misc1   = 0;
+
+        /* Enable PCI access to CPU DRAM at address 0 (64M) */
+        qs->pbti0_add   = 0x00000000;
+        qs->pbti0_ctl   = QSPBTI_CTL_EN | QSPBTI_CTL_BS( 10 ) | QSPBTI_CTL_PWEN;
+
+        /*
+         * enable error logging
+         */
+        qs->pb_errcs    = QSPB_ERRCS_EN;
+
+        /*
+         * clear all IDMA error status
+         * initialize to PowerQUICC mode
+         */
+        qs->idma_cs     = QSIDMA_CS_IRST | QSIDMA_CS_DONE | QSIDMA_CS_IPE |
+                QSIDMA_CS_IQE | QSIDMA_CS_IMODE;
+
+        /*
+         * disable all interrupts
+         * clear all interrupt status
+         * map all interrupts to the QBus
+         */
+        qs->int_ctl     = 0;
+        qs->int_stat    = ~0;
+        qs->int_dir     = 0;
+
+        /*
+         * BG* input is synchronous to QCLK
+         * BG* input is synchronous to QCLK (acknowledge)
+         * QBus is big-endian
+         */
+        qs->misc_ctl    = QSMISC_CTL_S_BG | QSMISC_CTL_S_BB |
+                QSMISC_CTL_MSTSLV( 3 );
+        qs->misc_ctl2  &= ~QSMISC_CTL2_QINT_PME;
+
+        /* setup slave image #0, 64KB window to PCI MEM space */
+        qs->qbsi0_ctl   = 0;
+        qs->qbsi0_at    = QSQBSI_AT_TA( PCI_ISA_MEM_ADDR >> 16 ) |
+                QSQBSI_AT_BS( 0 ) | QSQBSI_AT_EN;
+
+        /*
+         * clear all QBus error status
+         * enable QBus error log
+         */
+        qs->qb_errcs    = QSQB_ERRCS_EN | QSQB_ERRCS_ES;
+
+        /* Matrix only enable Memory-space and bus-mastering */
+        qs->pci_cs     |= QSPCI_CS_BM | QSPCI_CS_MS;
 }
 
-int qspan_pcibios_find_class(unsigned int class_code, unsigned short index,
-			    unsigned char *bus_ptr, unsigned char *dev_fn_ptr)
+static struct pci_ops qspan_pci_ops =
 {
-    int devnr, x, num;
-
-    num = 0;
-    for (devnr = 0;  devnr < 32;  devnr++) {
-	qspan_pcibios_read_config_dword(0, devnr<<3, PCI_CLASS_REVISION, &x);
-	if ((x>>8) == class_code) {
-	    if (index == num) {
-		*bus_ptr = 0;
-		*dev_fn_ptr = devnr<<3;
-		return PCIBIOS_SUCCESSFUL;
-	    }
-	    ++num;
-	}
-    }
-    return PCIBIOS_DEVICE_NOT_FOUND;
-}
+	.read_byte      = qspan_pcibios_read_config_byte,
+	.read_word      = qspan_pcibios_read_config_word,
+	.read_dword     = qspan_pcibios_read_config_dword,
+	.write_byte     = qspan_pcibios_write_config_byte,
+	.write_word     = qspan_pcibios_write_config_word,
+	.write_dword    = qspan_pcibios_write_config_dword,
+};
 
-void __init
-m8xx_pcibios_fixup(void))
+void __init m8xx_pcibios_fixup(void)
 {
-   /* Lots to do here, all board and configuration specific. */
+        /* Lots to do here, all board and configuration specific. */
 }
 
-void __init
-m8xx_setup_pci_ptrs(void))
+void __init m8xx_setup_pci_ptrs(void)
 {
-	set_config_access_method(qspan);
+        struct pci_controller * hose;
+
+        qspan_init();
 
 	ppc_md.pcibios_fixup = m8xx_pcibios_fixup;
-}
 
+        hose = pcibios_alloc_controller();
+        if ( !hose ) {
+                return;
+        }
+
+        hose->ops = &qspan_pci_ops;
+
+        hose->io_space.name     = "PCI I/O";
+        hose->io_space.start    = PCI_ISA_IO_ADDR;
+        hose->io_space.end      = PCI_ISA_IO_ADDR + PCI_ISA_IO_SIZE - 1;
+        hose->io_space.flags    = IORESOURCE_IO;
+
+        hose->io_resource       = hose->io_space;
+
+        hose->mem_space.name    = "PCI Memory";
+        hose->mem_space.start   = PCI_ISA_MEM_ADDR;
+        hose->mem_space.end     = PCI_ISA_MEM_ADDR + PCI_ISA_MEM_SIZE - 1;
+        hose->mem_space.flags   = IORESOURCE_MEM;
+
+        hose->mem_resources[0]  = hose->mem_space;
+}
diff -ruNa linux-2.4.35.4.orig/arch/ppc/kernel/qspan_pci.h linux-2.4.35.4/arch/ppc/kernel/qspan_pci.h
--- linux-2.4.35.4.orig/arch/ppc/kernel/qspan_pci.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4.35.4/arch/ppc/kernel/qspan_pci.h	2007-12-03 11:06:29.000000000 -0800
@@ -0,0 +1,195 @@
+#ifndef _PPC_KERNEL_QSPAN_PCI_H
+#define _PPC_KERNEL_QSPAN_PCI_H
+
+typedef struct qspan {
+        u32 pci_id;             /* 0x000 - PCI configuration space ID register */
+        u32 pci_cs;             /* 0x004 - PCI configuration space control and status register */
+        u32 pci_class;  /* 0x008 - PCI configuration class register */
+        u32 pci_misc0;  /* 0x00C - PCI configuration miscellaneous 0 register */
+        u32 pci_bsm;    /* 0x010 - PCI configuration base address for memory register */
+        u32 pci_bsio;   /* 0x014 - PCI configuration base address for I/O register */
+        u32 pci_u0[0x005];      /* 0x018 - PCI unimplemented */
+        u32 pci_sid;    /* 0x02C - PCI configuration subsystem ID register */
+        u32 pci_bsrom;  /* 0x030 - PCI configuration expansion ROM base address register */
+        u32 pci_r0[0x002];      /* 0x034 - PCI reserved */
+        u32 pci_misc1;  /* 0x03C - PCI configuration miscellaneous 1 register */
+        u32 pci_u1[0x030];      /* 0x040 - PCI unimplemented */
+        u32 pbti0_ctl;  /* 0x100 - PCI bus target image 0 control register */
+        u32 pbti0_add;  /* 0x104 - PCI bus target image 0 address register */
+        u32 qspan_r0[0x002];/* 0x108 - QSpan reserved */
+        u32 pbti1_ctl;  /* 0x110 - PCI bus target image 1 control register */
+        u32 pbti1_add;  /* 0x114 - PCI bus target image 1 address register */
+        u32 qspan_r1[0x009];/* 0x118 - QSpan reserved */
+        u32 pbrom_ctl;  /* 0x13C - PCI bus expansion ROM control register */
+        u32 pb_errcs;   /* 0x140 - PCI bus error control and status register */
+        u32 pb_aerr;    /* 0x144 - PCI bus address error log register */
+        u32 pb_derr;    /* 0x148 - PCI bus data error log register */
+        u32 qspan_r2[0x02D];/* 0x14C - QSpan reserved */
+        u32 i20_cs;     /* 0x200 - IDMA control and status register */
+        u32 qspan_r2a[0x07F];/* 0x204 - QSpan reserved */
+        u32 idma_cs;    /* 0x400 - IDMA control and status register */
+        u32 idma_add;   /* 0x404 - IDMA address register */
+        u32 idma_cnt;   /* 0x408 - IDMA transfer count register */
+        u32 qspan_r3[0x03D];/* 0x40C - QSpan reserved */
+        u32 con_add;    /* 0x500 - configuration address register */
+        u32 con_data;   /* 0x504 - configuration data register */
+        u32 qspan_r4[0x03E];/* 0x508 - QSpan reserved */
+        u32 int_stat;   /* 0x600 - interrupt status register */
+        u32 int_ctl;    /* 0x604 - interrupt control register */
+        u32 int_dir;    /* 0x608 - interrupt direction control register */
+        u32 qspan_r5[0x07D];/* 0x60C - QSpan reserved */
+        u32 misc_ctl;   /* 0x800 - miscellaneous control and status register */
+        u32 eepprom_cs;     /* 0x804 - reserved */
+        u32 misc_ctl2;     /* 0x808 - misc ctl 2 */
+        u32 qspan_r6[0x1BD];/* 0x80c - QSpan reserved */
+        u32 qbsi0_ctl;  /* 0xF00 - QBus slave image 0 control register */
+        u32 qbsi0_at;   /* 0xF04 - QBus slave image 0 address translation register */
+        u32 qspan_r7[0x002];/* 0xF08 - QSpan reserved */
+        u32 qbsi1_ctl;  /* 0xF10 - QBus slave image 1 control register */
+        u32 qbsi1_at;   /* 0xF14 - QBus slave image 1 address translation register */
+        u32 qspan_r8[0x01A];/* 0xF18 - QSpan reserved */
+        u32 qb_errcs;   /* 0xF80 - QBus error log control and status register */
+        u32 qb_aerr;    /* 0xF84 - QBus address error log register */
+        u32 qb_derr;    /* 0xF88 - QBus data error log register */
+        u32 qspan_r9[0x01D];/* 0xF8C - QSpan reserved */
+} qspan_t;
+
+#define QSPCI_CS_D_PE                   ( 1 << 31 )
+#define QSPCI_CS_S_SERR                 ( 1 << 30 )
+#define QSPCI_CS_R_MA                   ( 1 << 29 )
+#define QSPCI_CS_R_TA                   ( 1 << 28 )
+#define QSPCI_CS_S_TA                   ( 1 << 27 )
+#define QSPCI_CS_DEVSEL( x )            ( ( ( x ) & 0x3 ) << 25 )
+#define QSPCI_CS_MD_PED                 ( 1 << 24 )
+#define QSPCI_CS_TFBBC                  ( 1 << 23 )
+#define QSPCI_CS_DEV66                  ( 1 << 21 )
+#define QSPCI_CS_CAP_L                  ( 1 << 20 )
+#define QSPCI_CS_MFFBC                  ( 1 << 9 )
+#define QSPCI_CS_SERR_EN                ( 1 << 8 )
+#define QSPCI_CS_WAIT                   ( 1 << 7 )
+#define QSPCI_CS_PERESP                 ( 1 << 6 )
+#define QSPCI_CS_VGAPS                  ( 1 << 5 )
+#define QSPCI_CS_MWI_EN                 ( 1 << 4 )
+#define QSPCI_CS_SC                     ( 1 << 3 )
+#define QSPCI_CS_BM                     ( 1 << 2 )
+#define QSPCI_CS_MS                     ( 1 << 1 )
+#define QSPCI_CS_IOS                    ( 1 << 0 )
+
+#define QSPBTI_CTL_EN                   ( 1 << 31 )
+#define QSPBTI_CTL_BS( x )              ( ( ( x ) & 0xf ) << 24 )
+#define QSPBTI_CTL_PREN                 ( 1 << 23 )
+#define QSPBTI_CTL_BRSTWREN             ( 1 << 22 )
+#define QSPBTI_CTL_INVEND               ( 1 << 19 )
+#define QSPBTI_CTL_TC( x )              ( ( ( x ) & 0xf ) << 12 )
+#define QSPBTI_CTL_DSIZE( x )           ( ( ( x ) & 0x3 ) << 10 )
+#define QSPBTI_CTL_PWEN                 ( 1 << 7 )
+#define QSPBTI_CTL_PAS                  ( 1 << 6 )
+
+#define QSPB_ERRCS_EN                   ( 1 << 31 )
+#define QSPB_ERRCS_ES                   ( 1 << 24 )
+#define QSPB_ERRCS_UNL_QSC              ( 1 << 23 )
+#define QSPB_ERRCS_CMDERR( x )          ( ( ( x ) & 0xf ) << 4 )
+#define QSPB_ERRCS_BE_ERR( x )          ( ( ( x ) & 0xf ) << 0 )
+
+#define QSI20_CS_QIBA( x )              ( ( ( x ) & 0xfff ) << 16 )
+#define QSI20_CS_IF_E                   ( 1 << 15 )
+#define QSI20_CS_IP_E                   ( 1 << 14 )
+#define QSI20_CS_OF_E                   ( 1 << 13 )
+#define QSI20_CS_OP_E                   ( 1 << 12 )
+#define QSI20_CS_IF_F                   ( 1 << 11 )
+#define QSI20_CS_IP_F                   ( 1 << 10 )
+#define QSI20_CS_OF_F                   ( 1 << 9 )
+#define QSI20_CS_OP_F                   ( 1 << 8 )
+#define QSI20_CS_FIFO_SIZE( x )         ( ( ( x ) & 0x7 ) << 4 )
+#define QSI20_CS_RR_BP                  ( 1 << 1 )
+#define QSI20_CS_I20_EN                 ( 1 << 0 )
+
+#define QSIDMA_CS_GO                    ( 1 << 31 )
+#define QSIDMA_CS_IRST_REQ              ( 1 << 30 )
+#define QSIDMA_CS_ACT                   ( 1 << 23 )
+#define QSIDMA_CS_IRST                  ( 1 << 22 )
+#define QSIDMA_CS_DONE                  ( 1 << 21 )
+#define QSIDMA_CS_IPE                   ( 1 << 20 )
+#define QSIDMA_CS_IQE                   ( 1 << 19 )
+#define QSIDMA_CS_CMD                   ( 1 << 18 )
+#define QSIDMA_CS_IWM( x )              ( ( ( x ) & 0xf ) << 12 )
+#define QSIDMA_CS_TC( x )               ( ( ( x ) & 0xf ) << 8 )
+#define QSIDMA_CS_TC_EN                 ( 1 << 7 )
+#define QSIDMA_CS_CHAIN                 ( 1 << 6 )
+#define QSIDMA_CS_DMA                   ( 1 << 5 )
+#define QSIDMA_CS_DIR                   ( 1 << 4 )
+#define QSIDMA_CS_IMODE                 ( 1 << 3 )
+#define QSIDMA_CS_QTERM                 ( 1 << 2 )
+#define QSIDMA_CS_STERM                 ( 1 << 1 )
+#define QSIDMA_CS_PORT16                ( 1 << 0 )
+
+#define QSINT_PEL_IS                    ( 1 << 31 )
+#define QSINT_QEL_IS                    ( 1 << 30 )
+#define QSINT_MDPED_IS                  ( 1 << 29 )
+#define QSINT_PCSR_IS                   ( 1 << 28 )
+#define QSINT_IQE_IS                    ( 1 << 27 )
+#define QSINT_IPE_IS                    ( 1 << 26 )
+#define QSINT_IRST_IS                   ( 1 << 25 )
+#define QSINT_DONE_IS                   ( 1 << 24 )
+#define QSINT_INT_IS                    ( 1 << 23 )
+#define QSINT_PERR_IS                   ( 1 << 22 )
+#define QSINT_SERR_IS                   ( 1 << 21 )
+#define QSINT_QINT_IS                   ( 1 << 20 )
+#define QSINT_MB3_IS                    ( 1 << 19 )
+#define QSINT_MB2_IS                    ( 1 << 18 )
+#define QSINT_MB1_IS                    ( 1 << 17 )
+#define QSINT_MB0_IS                    ( 1 << 16 )
+#define QSINT_QDPE_S                    ( 1 << 15 )
+#define QSINT_PSC_IS                    ( 1 << 14 )
+#define QSINT_OPNE_S                    ( 1 << 13 )
+#define QSINT_IPN_IS                    ( 1 << 12 )
+#define QSINT_IFE_S                     ( 1 << 11 )
+#define QSINT_OFE_S                     ( 1 << 10 )
+#define QSINT_IPF_S                     ( 1 << 9 )
+#define QSINT_OFF_S                     ( 1 << 8 )
+#define QSINT_SI3_IS                    ( 1 << 3 )
+#define QSINT_SI2_IS                    ( 1 << 2 )
+#define QSINT_SI1_IS                    ( 1 << 1 )
+#define QSINT_SI0_IS                    ( 1 << 0 )
+
+#define QSMISC_CTL_SW_RST               ( 1 << 31 )
+#define QSMISC_CTL_S_BG                 ( 1 << 19 )
+#define QSMISC_CTL_S_BB                 ( 1 << 18 )
+#define QSMISC_CTL_QB_BOC               ( 1 << 16 )
+#define QSMISC_CTL_QB_MA_BE_D           ( 1 << 12 )
+#define QSMISC_CTL_QFIFO_BLK8           ( 1 << 9 )
+#define QSMISC_CTL_QFIFO_MODE           ( 1 << 8 )
+#define QSMISC_CTL_PRCNT( x )           ( ( ( x ) & 0x3f ) << 2 )
+#define QSMISC_CTL_MSTSLV( x )          ( ( ( x ) & 0x3 ) << 0 )
+
+#define QSMISC_CTL2_PCI_DIS             ( 1 << 31 )
+#define QSMISC_CTL2_PTP_IB              ( 1 << 23 )
+#define QSMISC_CTL2_KEEP_BB             ( 1 << 22 )
+#define QSMISC_CTL2_MAX_RTRY( x )       ( ( ( x ) & 0x3 ) << 20 )
+#define QSMISC_CTL2_PTC_PD              ( 1 << 19 )
+#define QSMISC_CTL2_TA_BE_EN            ( 1 << 18 )
+#define QSMISC_CTL2_BURST_4             ( 1 << 17 )
+#define QSMISC_CTL2_PR_SING             ( 1 << 16 )
+#define QSMISC_CTL2_PRCNT2( x )         ( ( ( x ) & 0x3f ) << 10 )
+#define QSMISC_CTL2_REG_AC              ( 1 << 9 )
+#define QSMISC_CTL2_QSC_PW              ( 1 << 8 )
+#define QSMISC_CTL2_QBUS_PAR            ( 1 << 4 )
+#define QSMISC_CTL2_EEPROM_ACC          ( 1 << 3 )
+#define QSMISC_CTL2_NOTO                ( 1 << 2 )
+#define QSMISC_CTL2_PSC_QRST            ( 1 << 1 )
+#define QSMISC_CTL2_QINT_PME            ( 1 << 0 )
+
+#define QSQBSI_CTL_PWEN                 ( 1 << 31 )
+#define QSQBSI_CTL_PAS                  ( 1 << 24 )
+#define QSQBSI_CTL_PREN                 ( 1 << 23 )
+
+#define QSQBSI_AT_TA( x )               ( ( ( x ) & 0xffff ) << 16 )
+#define QSQBSI_AT_BS( x )               ( ( ( x ) & 0xf ) << 4 )
+#define QSQBSI_AT_EN                    ( 1 << 0 )
+
+#define QSQB_ERRCS_EN                   ( 1 << 31 )
+#define QSQB_ERRCS_ES                   ( 1 << 24 )
+#define QSQB_ERRCS_TC_ERR( x )          ( ( ( x ) & 0xf ) << 4 )
+#define QSQB_ERRCS_SIZ_ERR( x )         ( ( ( x ) & 0x3 ) << 0 )
+
+#endif

--dc+cDN39EJAMEtIO--
