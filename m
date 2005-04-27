Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 4632B67AC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 00:41:48 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Wed, 27 Apr 2005 16:59:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504271659.52998.Schramel.Linux@go.bartec.de>
Subject: PCI IO_BASE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

actually my system (2.4.25 on MPC8270 with PCI) runs fine and it will be tested. Thanks to all.
But one thing isn't really clear. The IO_BASE and memory windows for pci.

This is original taken from arch/ppc/plattforms/ads8260.h

/* window for a PCI master to access MPC8266 memory */
#define PCI_SLV_MEM_LOCAL	0x00000000	/* Local base */
#define PCI_SLV_MEM_BUS		0x00000000	/* PCI base */

/* window for the processor to access PCI memory with prefetching */
#define PCI_MSTR_MEM_LOCAL		0x80000000	/* Local base */
#define PCI_MSTR_MEM_BUS		0x80000000	/* PCI base   */
#define PCI_MSTR_MEM_SIZE		0x20000000	/* 512MB */

/* window for the processor to access PCI memory without prefetching */
#define PCI_MSTR_MEMIO_LOCAL	0xA0000000	/* Local base */
#define PCI_MSTR_MEMIO_BUS		0xA0000000	/* PCI base   */
#define PCI_MSTR_MEMIO_SIZE		0x20000000	/* 512MB */

/* window for the processor to access PCI I/O */
#define PCI_MSTR_IO_LOCAL	0xF4000000      /* Local base */
#define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
#define PCI_MSTR_IO_SIZE        0x04000000	/* 64MB */

#define _IO_BASE				PCI_MSTR_IO_LOCAL
#define _ISA_MEM_BASE		PCI_MSTR_MEMIO_LOCAL
#define PCI_DRAM_OFFSET	PCI_SLV_MEM_BUS
#endif /* CONFIG_PCI */

These memory windows are not really clear to me. Which documentation can expand my theoretical background? Any comments are welcome.

If CONFIG_PCI is defined the io accesses will depend on the _IO_BASE (at example for ide accesses, now i know ;-)).
Why it depends on it ?
If i will adapt another chip with the standard io-accesses of /asm/io.h, which things i ve to know (offsets, windowsizes,etc..)?  

Thanks for your comments.

Marco



-- 
---------
Marco Schramel
