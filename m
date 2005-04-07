Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id B76EA67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 17:26:13 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j377UAvO000905
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 7 Apr 2005 10:30:11 +0300 (EEST)
Message-ID: <4254DDE9.4060409@intracom.gr>
Date: Thu, 07 Apr 2005 10:14:49 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: ppc embedded list <linuxppc-embedded@ozlabs.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>, Jeff Garzik <jgarzik@pobox.com>
Content-Type: multipart/mixed; boundary="------------080205090705040708090406"
Subject: [PATCH] Intracom platform patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080205090705040708090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

The following patch adds platform support for the netta2 board.

It's main attraction however is as an example on how to do
the fec_8xx platform driver initialization.

Regards

Pantelis

P.S. This and the previous patches are

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>


--------------080205090705040708090406
Content-Type: text/x-patch;
 name="intracom-platforms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intracom-platforms.patch"

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/Makefile linux-2.5-intracom/arch/ppc/platforms/Makefile
--- linux-2.5/arch/ppc/platforms/Makefile	2005-04-01 13:33:07 +03:00
+++ linux-2.5-intracom/arch/ppc/platforms/Makefile	2005-04-01 13:54:32 +03:00
@@ -46,6 +46,7 @@
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
+obj-$(CONFIG_NETTA2)		+= netta2_setup.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/intracom_common.h linux-2.5-intracom/arch/ppc/platforms/intracom_common.h
--- linux-2.5/arch/ppc/platforms/intracom_common.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/intracom_common.h	2005-03-28 13:11:37 +03:00
@@ -0,0 +1,92 @@
+#ifndef INTRACOM_COMMON_H
+#define INTRACOM_COMMON_H
+
+#ifndef __ASSEMBLY__
+
+/**********************************************/
+
+extern spinlock_t i_port_spinlock;
+
+static inline unsigned long i_pin_lock(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i_port_spinlock, flags);
+	return flags;
+}
+
+static inline void i_pin_unlock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&i_port_spinlock, flags);
+}
+
+/**********************************************/
+
+#ifdef CONFIG_8xx
+#include <platforms/intracom_common_8xx.h>
+#endif
+
+#ifdef CONFIG_8260
+#include <platforms/intracom_common_82xx.h>
+#endif
+
+#include <syslib/fw_env.h>
+
+/**********************************************/
+
+enum intracom_board {
+	ib_netta,
+	ib_netta2,
+	ib_netphone,
+	ib_iad,
+	ib_netroute,
+};
+
+struct intracom_config {
+	enum intracom_board board;
+	int version;
+
+	/* generic enable options */
+	int fec_no;
+	struct {
+		int	phy_addr;
+		int	fec_irq;
+		int	phy_irq;
+		__u8	mac_addr[6];
+	} fec[2];
+
+	int fxs_no;
+	int fxo_no;
+	int bri_no;
+	int pri_no;
+	int dsl_no;
+	int pcmcia_no;
+
+	union {
+		struct {
+			/* various */
+			unsigned int has_alt_nand_wiring : 1;
+			unsigned int has_io_reset	 : 1;
+			unsigned int has_64Mb_sdram	 : 1;
+			unsigned int has_swapped_hook	 : 1;
+			unsigned int has_isdn		 : 1;
+		} netta;
+
+		struct {
+		} netta2;
+
+		struct {
+		} netphone;
+
+		struct {
+		} iad;
+	} u;
+};
+
+extern struct intracom_config i_cfg;
+
+/**********************************************/
+
+#endif
+
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/intracom_common_82xx.h linux-2.5-intracom/arch/ppc/platforms/intracom_common_82xx.h
--- linux-2.5/arch/ppc/platforms/intracom_common_82xx.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/intracom_common_82xx.h	2005-03-28 13:11:37 +03:00
@@ -0,0 +1,4 @@
+#ifndef INTRACOM_COMMON_82XX_H
+#define INTRACOM_COMMON_82XX_H
+
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/intracom_common_8xx.h linux-2.5-intracom/arch/ppc/platforms/intracom_common_8xx.h
--- linux-2.5/arch/ppc/platforms/intracom_common_8xx.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/intracom_common_8xx.h	2005-03-28 13:11:37 +03:00
@@ -0,0 +1,224 @@
+#ifndef INTRACOM_COMMON_8XX_H
+#define INTRACOM_COMMON_8XX_H
+
+/**********************************************/
+
+/* shorthand for the ports data registers */
+#define PORTA		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat)
+#define PORTB		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat)
+#define PORTC		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pcdat)
+#define PORTD		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pddat)
+#define PORTE		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pedat)
+
+/********************************************************************************/
+
+/* external write only register */
+#define PORTXWO		(*(volatile uint *)ERWO_BASE)
+extern volatile uint *PORTXWO_map;
+extern uint PORTXWO_last;
+
+/* external read only register */
+#define PORTXRO		(*(volatile uint *)ERRO_BASE)
+extern volatile uint *PORTXRO_map;
+
+/********************************************************************************/
+
+#define PIN_PORT_EQ(p, x)	((void *) & x ## _PORT == (void *) & p)
+#define PIN_PORT_NE(p, x)	((void *) & x ## _PORT != (void *) & p)
+
+#define PIN_PORT_RW(x)		(PIN_PORT_NE(PORTXWO, x) && PIN_PORT_NE(PORTXRO, x))
+#define PIN_PORT_RO(x)		PIN_PORT_EQ(PORTXRO, x)
+#define PIN_PORT_WO(x)		PIN_PORT_EQ(PORTXWO, x)
+
+/********************************************************************************/
+
+#define PIN_SFT(x) ((sizeof(x ## _PORT) * 8 - 1) - x ## _BIT)
+#define PIN_MSK(x) (1U << PIN_SFT(x))
+
+/********************************************************************************/
+
+/* normal m8xx pins */
+#define _PIN_HI(x) \
+	do { \
+		x ## _PORT |=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_LO(x) \
+	do { \
+		x ## _PORT &= ~PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_TGL(x) \
+	do { \
+		x ## _PORT ^=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_GET(x) \
+	(!!(x ## _PORT & PIN_MSK(x)))
+
+#define _PIN_SET(x, v)	\
+	do { \
+		if (__builtin_constant_p(v)) { \
+			if ((v) != 0) \
+				_PIN_HI(x); \
+			else \
+				_PIN_LO(x); \
+		} else \
+			x ## _PORT = ( x ## _PORT & ~PIN_MSK(x)) | (!!(v) << PIN_SFT(x)); \
+	} while(0)
+
+#define _PIN_CFG_IN(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_ANY(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_FALL(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT(x, v) \
+	do { \
+		_PIN_SET(x, v); \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(0, PIN_MSK(x), 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT_HI(x) _PIN_CFG_OUT(x, 1)
+#define _PIN_CFG_OUT_LO(x) _PIN_CFG_OUT(x, 0)
+
+/***********************************************************************/
+
+#define PIN_HI(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTXWO, x)) { \
+			PORTXWO_last |= PIN_MSK(x); \
+			*PORTXWO_map = PORTXWO_last; \
+		} else \
+			_PIN_HI(x); \
+	} while(0)
+
+#define PIN_LO(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTXWO, x)) { \
+			PORTXWO_last &= ~PIN_MSK(x); \
+			*PORTXWO_map = PORTXWO_last; \
+		} else \
+			_PIN_LO(x); \
+	} while(0)
+
+#define PIN_TGL(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTXWO, x)) { \
+			PORTXWO_last ^= PIN_MSK(x); \
+			*PORTXWO_map = PORTXWO_last; \
+		} else \
+			_PIN_TGL(x); \
+	} while(0)
+
+#define PIN_SET(x, v) \
+	do { \
+		if (PIN_PORT_EQ(PORTXWO, x)) { \
+			if (v) \
+				PORTXWO_last |=  PIN_MSK(x); \
+			else \
+				PORTXWO_last &= ~PIN_MSK(x); \
+			*PORTXWO_map = PORTXWO_last; \
+		} else \
+			_PIN_SET(x, v); \
+	} while(0)
+
+#define PIN_GET(x) \
+	(PIN_PORT_EQ(PORTXRO, x) ? \
+		!!(*PORTXRO_map & PIN_MSK(x)) : \
+		(PIN_PORT_EQ(PORTXWO, x) ? \
+			!!(PORTXWO_last & PIN_MSK(x)) : \
+			_PIN_GET(x)))
+
+/********************************************************************************/
+
+static inline void PORTA_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_padir  = (imap->im_ioport.iop_padir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_paodr &= ~msk;
+	imap->im_ioport.iop_papar &= ~msk;
+}
+
+static inline void PORTB_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pbdir  = (imap->im_cpm.cp_pbdir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_pbodr &= ~msk;
+	imap->im_cpm.cp_pbpar &= ~msk;
+}
+
+static inline void PORTC_config(uint inmsk, uint outmsk, uint fallmsk)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pcdir  = (imap->im_ioport.iop_pcdir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pcso  &= ~msk;
+	imap->im_ioport.iop_pcint  = (imap->im_ioport.iop_pcint & ~(ushort)inmsk) | ((ushort)fallmsk & (ushort)inmsk);
+	imap->im_ioport.iop_pcpar &= ~msk;
+}
+
+static inline void PORTD_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pddir  = (imap->im_ioport.iop_pddir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pdpar &= ~msk;
+}
+
+static inline void PORTE_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pedir  = (imap->im_cpm.cp_pedir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_peodr &= ~msk;
+	imap->im_cpm.cp_pepar &= ~msk;
+}
+
+static inline void PORTXWO_config(uint dummy1, uint dummy2, uint dummy3)
+{
+	/* nothing */
+}
+
+static inline void PORTXRO_config(uint dummy1, uint dummy2, uint dummy3)
+{
+	/* nothing */
+}
+
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/intracom_swspi.h linux-2.5-intracom/arch/ppc/platforms/intracom_swspi.h
--- linux-2.5/arch/ppc/platforms/intracom_swspi.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/intracom_swspi.h	2005-03-28 13:11:37 +03:00
@@ -0,0 +1,35 @@
+#ifndef INTRACOM_SWSPI_H
+#define INTRACOM_SWSPI_H
+
+#ifndef __ASSEMBLY__
+
+#include "intracom_common.h"
+
+#ifdef CONFIG_NETTA
+#include "netta.h"
+#endif
+
+static inline unsigned int spi_transfer(unsigned int tx)
+{
+	unsigned int rx;
+	int b;
+
+	rx = 0; b = 8;
+	while (--b >= 0) {
+		PIN_SET(SPI_TXD, tx & 0x80);
+		tx <<= 1;
+		PIN_TGL(SPI_CLK);
+		SPI_DELAY();
+		rx <<= 1;
+		rx |= PIN_GET(SPI_RXD);
+		PIN_TGL(SPI_CLK);
+		SPI_DELAY();
+	}
+
+	return rx;
+}
+
+#endif
+
+#endif
+
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/netta2.h linux-2.5-intracom/arch/ppc/platforms/netta2.h
--- linux-2.5/arch/ppc/platforms/netta2.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/netta2.h	2005-03-28 13:11:37 +03:00
@@ -0,0 +1,279 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the NetTA2 systems.
+ *
+ * Copyright (c) 2002-2004 * Intracom S.A. Greece
+ *
+ * Pantelis Antoniou
+ * panto@intracom.gr
+ *
+ */
+#ifndef __MACH_NETTA2_DEFS
+#define __MACH_NETTA2_DEFS
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+
+#include <asm/atomic.h>
+#include <asm/ppcboot.h>
+
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+
+#endif
+
+/***********************************************************************************************************
+
+   Pin definitions: 
+
+ (Default settings for V3)
+
+ +------+----------------+--------+---+------------------------------------------------------------
+ |  #   | Name           | Type   | R | Comment
+ +------+----------------+--------+---+------------------------------------------------------------
+ | PA3  | IO_RESET	 | Output | H | General I/O reset
+ | PA6  | N.C.           | Output | L | 
+ | PA7  | N.C.           | Output | L | 
+ | PA10 | DSP_RESET      | Output | H | DSP reset
+ | PA14 | N.C.           | Output | L |  
+ | PA15 | N.C.           | Output | L |  
+ | PB19 | N.C.           | Output | L | 
+ | PB23 | N.C.           | Output | L | 
+ | PB26 | SPIEN_SEP      | Output | H | Serial EEPROM chip select
+ | PB27 | N.C.           | Output | L | 
+ | PB28 | SPI_RXD_3V     | Input  |   | SPI Data Rx
+ | PB29 | SPI_TXD        | Output | H | SPI Data Tx
+ | PB30 | SPI_CLK        | Output | H | SPI Clock
+ | PC10 | N.C.           | Output | L | 
+ | PC11 | N.C.           | Output | L | 
+ | PC12 | F_RY_BY        | Input  |   | NAND F_RY_BY
+ | PC13 | HOOK           | Input  |   | Hook input interrupt
+ | PC15 | N.C.           | Output | L |
+ | PE17 | F_ALE          | Output | L | NAND F_ALE
+ | PE18 | F_CLE          | Output | L | NAND F_CLE
+ | PE20 | F_CE           | Output | H | NAND F_CE
+ | PE24 | USB_RESET      | Output | H | USB_RESET
+ | PE27 | SPICS_DUSLIC   | Output | H | Duslic chip select
+ | PE28 | N.C.           | Output | L | 
+ | PE29 | N.C.           | Output | L | 
+ | PE30 | N.C.           | Output | L | 
+ | PE31 | N.C.           | Output | L | 
+ +------+----------------+--------+---+---------------------------------------------------
+
+ ----------------------------------------------------------------------------------------------
+
+   Serial register input:
+
+ +------+----------------+------------------------------------------------------------
+ |  #   | Name           | Comment
+ +------+----------------+------------------------------------------------------------
+ |    4 | HOOK           | Hook switch
+ |    5 | BT_LINK        | Bluetooth link status
+ |    6 | HOST_WAKE      | Bluetooth host wake up
+ |    7 | OK_ETH         | Cisco inline power OK status
+ +------+----------------+------------------------------------------------------------
+
+ ----------------------------------------------------------------------------------------------
+
+ Chip selects:
+
+ +------+----------------+------------------------------------------------------------
+ |  #   | Name           | Comment
+ +------+----------------+------------------------------------------------------------
+ | CS0  | CS0            | Boot flash
+ | CS1  | CS_FLASH       | NAND flash
+ | CS2  | CS_DSP         | DSP
+ | CS3  | DCS_DRAM       | DRAM
+ | CS4  | CS_FLASH2      | (V2) 2nd flash
+ +------+----------------+------------------------------------------------------------
+
+ ----------------------------------------------------------------------------------------------
+
+ Interrupts:
+
+ +------+----------------+------------------------------------------------------------
+ |  #   | Name           | Comment
+ +------+----------------+------------------------------------------------------------
+ | IRQ1 | IRQ_DSP        | DSP interrupt
+ | IRQ3 | S_INTER        | DUSLIC ???
+ | IRQ4 | F_RY_BY        | NAND
+ | IRQ7 | IRQ_MAX        | MAX 3100 interrupt
+ +------+----------------+------------------------------------------------------------
+
+ ----------------------------------------------------------------------------------------------
+
+ Interrupts on PCMCIA pins:
+
+ +------+----------------+------------------------------------------------------------
+ |  #   | Name           | Comment
+ +------+----------------+------------------------------------------------------------
+ | IP_A0| PHY1_LINK      | Link status changed for #1 Ethernet interface
+ | IP_A1| PHY2_LINK      | Link status changed for #2 Ethernet interface
+ | IP_A2| RMII1_MDINT    | PHY interrupt for #1
+ | IP_A3| RMII2_MDINT    | PHY interrupt for #2
+ | IP_A5| HOST_WAKE      | (V2) Bluetooth host wake
+ | IP_A6| OK_ETH         | (V2) Cisco inline power OK
+ +------+----------------+------------------------------------------------------------
+
+*************************************************************************************************/
+
+#define	IMAP_ADDR	0xFF000000		/* physical base address of IMMR area	*/
+#define IMAP_SIZE	(64 * 1024)		/* mapped size of IMMR area		*/
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+#define DSP_SIZE	0x00010000	/* 64K */
+#define NAND_SIZE	0x00010000
+#define USB_SIZE	0x00010000
+#define DUMMY_SIZE	0x00010000
+
+#define DSP_BASE	0xF1000000
+#define NAND_BASE	0xF1010000
+#define USB_BASE	0xF1020000
+#define DUMMY_BASE	0xF1030000
+
+/***********************************************************************/
+
+/* SPI pin definitions */
+
+#define SPI_RXD_PORT	PORTB
+#define SPI_RXD_BIT	28
+
+#define SPI_TXD_PORT	PORTB
+#define SPI_TXD_BIT	29
+
+#define SPI_CLK_PORT	PORTB
+#define SPI_CLK_BIT	30
+
+#define SPI_DELAY() /* nothing */
+
+/**********************************************/
+
+/* output */
+#define UART_RTS_PORT	PORTB
+#define UART_RTS_BIT	19
+
+/* input */
+#define UART_CTS_PORT	PORTB
+#define UART_CTS_BIT	23
+
+/**********************************************/
+
+/* NAND flash pins */
+
+#define F_ALE_PORT	PORTE
+#define F_ALE_BIT	17
+
+#define F_CLE_PORT	PORTE
+#define F_CLE_BIT	18
+
+#define F_CE_PORT	PORTE
+#define F_CE_BIT	20
+
+#define F_RY_BY_PORT	PORTC
+#define F_RY_BY_BIT	12
+
+/**********************************************/
+
+/* CODEC */
+#define SPIEN_C_PORT		PORTE
+#define SPIEN_C_BIT		27
+
+#define COM_HOOK_PORT		PORTC
+#define COM_HOOK_BIT		13
+
+/**********************************************/
+/* FXO */
+
+#define SPIEN_FXO_PORT		PORTE
+#define SPIEN_FXO_BIT		28
+
+#define IRQ_FXO_PORT		PORTE
+#define IRQ_FXO_BIT		29
+
+#define SPIEN_FXO_V4_PORT	PORTE
+#define SPIEN_FXO_V4_BIT	30
+
+/**********************************************/
+
+/* DSP */
+#define DSP_RESET_PORT          PORTA
+#define DSP_RESET_BIT           10
+
+/**********************************************/
+
+/* USB */
+#define USB_RESET_PORT          PORTE
+#define USB_RESET_BIT           24
+
+/* FXO/DuSLIC reset */
+#define PCM_DEV_RESET_PORT      PORTB
+#define PCM_DEV_RESET_BIT       27
+
+/**********************************************/
+/* ADSL Reset */
+#define ADSL_RESET_V4_PORT		PORTE
+#define ADSL_RESET_V4_BIT		29
+
+/**********************************************/
+
+#define P_SHDN_PORT		PORTE
+#define P_SHDN_BIT		23
+
+#define P_OC_PORT		PORTB
+#define P_OC_BIT		26
+
+/**********************************************/
+
+/*-----------------------------------------------------------------------
+ * PCMCIA stuff
+ *-----------------------------------------------------------------------
+ *
+ */
+#define PCMCIA_MEM_SIZE		( 64 << 20 )
+
+#define	MAX_HWIFS	1	/* overwrite default in include/asm-ppc/ide.h	*/
+
+/*
+ * Definitions for IDE0 Interface
+ */
+#define IDE0_BASE_OFFSET		0
+#define IDE0_DATA_REG_OFFSET		(PCMCIA_MEM_SIZE + 0x320)
+#define IDE0_ERROR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 1)
+#define IDE0_NSECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 2)
+#define IDE0_SECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 3)
+#define IDE0_LCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 4)
+#define IDE0_HCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 5)
+#define IDE0_SELECT_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 6)
+#define IDE0_STATUS_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 7)
+#define IDE0_CONTROL_REG_OFFSET		0x0106
+#define IDE0_IRQ_REG_OFFSET		0x000A	/* not used			*/
+
+#define	IDE0_INTERRUPT			13
+
+/* XXX FUCK!, for IDE disk set to 0, for normal PCMCIA set to 1 */
+/* XXX don't ask me why.. */
+#if 1
+/* define IO_BASE for PCMCIA */
+#define _IO_BASE 0x80000000
+#define _IO_BASE_SIZE  (64<<10)
+#endif
+
+/***********************************************************************/
+
+#ifndef __ASSEMBLY__
+
+extern int netta2_version;
+extern int netta2_is_iad;
+extern int netta2_dsp_ti;
+extern int netta2_dsp_clk;
+extern int netta2_has_fxo;
+extern int netta2_has_pcmcia;
+
+#endif
+
+#endif	/* __MACH_NETVIA_DEFS */
+
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/ppc/platforms/netta2_setup.c linux-2.5-intracom/arch/ppc/platforms/netta2_setup.c
--- linux-2.5/arch/ppc/platforms/netta2_setup.c	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/arch/ppc/platforms/netta2_setup.c	2005-04-07 09:39:22 +03:00
@@ -0,0 +1,359 @@
+/*
+ * arch/ppc/platforms/netta2.c  Platform setup for the Intracom NetTA board
+ *
+ * Copyright (C) 2003-2005, Intracom S.A. Greece
+ * All Rights Reserved.
+ *
+ * Pantelis Antoniou
+ * panto@intracom.gr
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/fec_8xx_pd.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+
+#include "intracom_common.h"
+
+#define UPMA	0x00000000
+#define UPMB	0x00800000
+
+/***********************************************************************/
+
+spinlock_t i_port_spinlock;
+
+/***********************************************************************/
+
+EXPORT_SYMBOL(i_port_spinlock);
+
+/***********************************************************************/
+
+int netta2_version;
+int netta2_is_iad;
+int netta2_dsp_ti;
+int netta2_dsp_clk;
+int netta2_has_fxo;
+int netta2_has_pcmcia;
+
+EXPORT_SYMBOL(netta2_version);
+EXPORT_SYMBOL(netta2_is_iad);
+EXPORT_SYMBOL(netta2_dsp_ti);
+EXPORT_SYMBOL(netta2_dsp_clk);
+EXPORT_SYMBOL(netta2_has_fxo);
+EXPORT_SYMBOL(netta2_has_pcmcia);
+
+static int has_token(const char *board, const char *token)
+{
+	const char *s;
+	int len = strlen(token);
+
+	s = strstr(board, token);
+	return s != NULL && (s == board || s[-1] == ' ') && (s[len] == '\0' || s[len] == ' ');
+}
+
+static void __init detect_board_features(void)
+{
+	const char *board = __fw_getenv("board");
+
+	netta2_version = 3;
+	netta2_is_iad = 1;
+	netta2_dsp_ti = 54;
+	netta2_dsp_clk = 15360;
+	netta2_has_fxo = 0;
+	netta2_has_pcmcia = 0;
+
+	/* no board? just set defaults */
+	if (board != NULL) {
+		/* detect version */
+		if (has_token(board, "V1"))
+			netta2_version = 1;
+		else if (has_token(board, "V2"))
+			netta2_version = 2;
+		else if (has_token(board, "V3"))
+			netta2_version = 3;
+		else if (has_token(board, "V4"))
+			netta2_version = 4;
+
+		netta2_is_iad = has_token(board, "IAD");
+
+		if (has_token(board, "54XX"))
+			netta2_dsp_ti = 54;
+		else if (has_token(board, "55XX"))
+			netta2_dsp_ti = 55;
+
+		if (has_token(board, "DSPC15360"))
+			netta2_dsp_clk = 15360;
+		else if (has_token(board, "DSPC18432"))
+			netta2_dsp_clk = 18432;
+		else if (has_token(board, "DSPC19546"))
+			netta2_dsp_clk = 19546;
+
+		netta2_has_fxo = has_token(board, "FXO");
+		netta2_has_pcmcia = has_token(board, "PCMCIA");
+	}
+
+	printk(KERN_INFO "netta2: version=%d, is_iad=%d, dsp_ti=%d, dsp_clk=%d, has_fxo=%d, has_pcmcia=%d\n",
+			netta2_version, netta2_is_iad, netta2_dsp_ti, netta2_dsp_clk, netta2_has_fxo, netta2_has_pcmcia);
+}
+
+static const char *ro_vars[] = {
+	"ethaddr", "eth1addr", "adsladdr", "serial#", "usbaddr", "usb1addr", "ver", "board",
+	NULL
+};
+
+/***********************************************************************/
+
+static struct fec_platform_info fec1_info;
+static struct fec_platform_info fec2_info;
+
+static struct platform_device mpc8xx_fec1_device = {
+	.name = MPC8XX_FEC_NAME,
+	.id = 0,
+        .dev = {
+		.platform_data = &fec1_info,
+	},
+};
+
+static struct platform_device mpc8xx_fec2_device = {
+	.name = MPC8XX_FEC_NAME,
+	.id = 1,
+        .dev = {
+		.platform_data = &fec2_info,
+	},
+};
+
+/***********************************************************************/
+
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+static void __init netta2_fixup_fec_pdata(struct platform_device *pd, int idx)
+{
+	struct fec_platform_info *fpi = pd->dev.platform_data;
+	immap_t *immap = (immap_t *)IMAP_ADDR;
+	bd_t *bd = (bd_t *) __res;
+	const char *s;
+	char *e;
+	int i;
+	static int fixed_once = 0;
+	const char *macvar;
+
+	/* guard */
+	if ((unsigned int)idx >= 2)
+		return;
+
+	if (idx == 0)
+		macvar = "ethaddr";
+	else
+		macvar = "eth1addr";
+
+	/* if no mac don't bother */
+	if ((s = __fw_getenv(macvar)) == NULL)
+		return;
+
+	/* common settings */
+	fpi->fec_no = idx;
+	fpi->use_mdio = 1;
+	fpi->rx_ring = 128;
+	fpi->tx_ring = 16;
+	fpi->rx_copybreak = 240;
+	fpi->use_napi = 1;
+	fpi->napi_weight = 17;
+	for (i = 0; i < 6; i++) {
+		fpi->macaddr[i] = simple_strtoul(s, &e, 16);
+		if (*e)
+			s = e + 1;
+	}
+	fpi->sys_clk = bd->bi_intfreq;
+
+	if (fixed_once == 0) {
+		/* use MDC for MII (common) */
+		setbits16(immap->im_ioport.iop_pdpar, 0x0080);
+		clrbits16(immap->im_ioport.iop_pddir, 0x0080);
+		fixed_once = 1;
+	}
+
+	if (idx == 0) {
+
+		/* configure FEC1 pins */
+		setbits16(immap->im_ioport.iop_papar, 0xe810);
+		setbits16(immap->im_ioport.iop_padir, 0x0810);
+		clrbits16(immap->im_ioport.iop_padir, 0xe000);
+
+		setbits32(immap->im_cpm.cp_pbpar, 0x00000001);
+		clrbits32(immap->im_cpm.cp_pbdir, 0x00000001);
+
+		setbits32(immap->im_cpm.cp_cptr, 0x00000100);
+		clrbits32(immap->im_cpm.cp_cptr, 0x00000050);
+
+		clrbits16(immap->im_ioport.iop_pcpar, 0x0200);
+		clrbits16(immap->im_ioport.iop_pcdir, 0x0200);
+		clrbits16(immap->im_ioport.iop_pcso, 0x0200);
+		setbits16(immap->im_ioport.iop_pcint, 0x0200);
+
+		/* setup specific */
+		fpi->phy_addr = 0x09;
+		fpi->fec_irq = SIU_LEVEL1;
+		fpi->phy_irq = CPM_IRQ_OFFSET + CPMVEC_PIO_PC6;
+
+	} else {
+
+		/* configure FEC2 pins */
+		setbits32(immap->im_cpm.cp_pepar, 0x00039620);
+		setbits32(immap->im_cpm.cp_pedir, 0x00039620);
+		setbits32(immap->im_cpm.cp_peso, 0x00031000);
+		clrbits32(immap->im_cpm.cp_peso, 0x00008620);
+
+		setbits32(immap->im_cpm.cp_cptr, 0x00000080);
+		clrbits32(immap->im_cpm.cp_cptr, 0x00000028);
+
+		clrbits16(immap->im_ioport.iop_pcpar, 0x0200);
+		clrbits16(immap->im_ioport.iop_pcdir, 0x0200);
+		clrbits16(immap->im_ioport.iop_pcso, 0x0200);
+		setbits16(immap->im_ioport.iop_pcint, 0x0200);
+
+		/* setup specific */
+		fpi->phy_addr = 0x0B;
+		fpi->fec_irq = SIU_LEVEL3;
+		fpi->phy_irq = CPM_IRQ_OFFSET + CPMVEC_PIO_PC7;
+	}
+}
+
+static int __init netta2_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn)(struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{ MPC8XX_FEC_NAME, netta2_fixup_fec_pdata },
+	};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id + strlen(s);
+
+			j = s - dev->bus_id;
+
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev = container_of(dev, struct platform_device, dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+
+	return 0;
+}
+
+int __init
+netta2_init(void)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	volatile memctl8xx_t *memctl;
+
+	printk(KERN_NOTICE "netta2: Init\n");
+
+	platform_notify = netta2_platform_notify;
+
+	__fw_envinit(16 * 1024, ro_vars);	/* we know the max env size is 16K for this */
+
+	detect_board_features();
+
+	memctl = &imap->im_memctl;
+
+	/* CS0: boot flash */
+	/* XXX leave boot settings */
+
+        /* CS2: DSP */
+	memctl->memc_or2 = ((0xFFFFFFFFLU & ~(DSP_SIZE - 1)) | OR_CSNT_SAM | OR_BI | OR_SCY_15_CLK | OR_ACS_DIV2 | OR_EHTR | OR_TRLX);
+	memctl->memc_br2 = ((DSP_BASE & BR_BA_MSK) | BR_PS_8 | BR_V);
+
+	/* CS3: DRAM */
+
+#if defined(CONFIG_USB_D12)
+	/* USB chip select */
+	memctl->memc_or6 = ((0xFFFFFFFFLU & ~(USB_SIZE - 1)) | OR_G5LS | OR_BI | OR_SCY_2_CLK);
+	memctl->memc_br6 = ((USB_BASE & BR_BA_MSK) | BR_PS_8 | BR_V | BR_MS_UPMA);
+	/* dummy cs for usb delay */
+	memctl->memc_or7 = ((0xFFFFFFFFLU & ~(DUMMY_SIZE - 1)) | OR_TRLX | OR_BI | OR_SCY_12_CLK);
+	memctl->memc_br7 = ((DUMMY_BASE & BR_BA_MSK) | BR_PS_8 | BR_V);
+    
+#else
+	memctl->memc_br6 &= ~BR_V;	/* invalid */
+	memctl->memc_br7 &= ~BR_V;	/* invalid */
+#endif
+
+	imap->im_siu_conf.sc_sypcr |= 0x0000FF00;
+
+	spin_lock_init(&i_port_spinlock);
+
+	/* configure SPI pins */
+	_PIN_CFG_OUT_HI(SPI_TXD);
+	_PIN_CFG_OUT_HI(SPI_CLK);
+	_PIN_CFG_IN(SPI_RXD);
+
+	/* configure NAND pins */
+	_PIN_CFG_OUT_LO(F_ALE);
+	_PIN_CFG_OUT_LO(F_CLE);
+	_PIN_CFG_OUT_HI(F_CE);
+	_PIN_CFG_IN(F_RY_BY);
+
+	/* configure DSP pins */
+	_PIN_CFG_OUT_HI(DSP_RESET);
+    
+#if defined(CONFIG_USB_D12)
+	/* configure USB pins */
+	_PIN_CFG_OUT_LO(USB_RESET);
+	udelay(1000);
+	_PIN_CFG_OUT_HI(USB_RESET);
+#endif
+
+	/* configure DSP pins */
+	_PIN_CFG_OUT_HI(DSP_RESET);
+
+	/* configure FXO/DuSLIC reset */
+	_PIN_CFG_OUT_HI(PCM_DEV_RESET);
+	
+	/* configure UART pins */
+	_PIN_CFG_OUT_HI(UART_RTS);
+	_PIN_CFG_IN(UART_CTS);
+	
+	/* USB CLK now from processor */
+	if (netta2_version == 4) {
+		/* PA3 = BRGO3 */
+		imap->im_ioport.iop_padir |= 0x1000;
+		imap->im_ioport.iop_papar |= 0x1000;
+		/* Set BRG3O = CLK2/6 */
+		imap->im_cpm.cp_brgc3 = 0x0001400e;
+	}
+        
+	platform_device_register(&mpc8xx_fec1_device);
+	platform_device_register(&mpc8xx_fec2_device);
+
+	return 0;
+}
+
+arch_initcall(netta2_init);
+

--------------080205090705040708090406--
