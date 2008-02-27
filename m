Return-Path: <John.Linn@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 67845DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 10:15:09 +1100 (EST)
Received: from outbound5-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-dub-R.bigfish.com (Postfix) with ESMTP id 552E51342C68
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:14:57 +0000 (UTC)
Received: from mail190-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound5-dub.bigfish.com (Postfix) with ESMTP id 3EE361F0052
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:14:57 +0000 (UTC)
Received: from mail190-dub (localhost.localdomain [127.0.0.1])
	by mail190-dub-R.bigfish.com (Postfix) with ESMTP id 6AF492785DD
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:14:56 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail190-dub.bigfish.com (Postfix) with ESMTP id DD4124507B7
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:14:52 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <John.Linn@xilinx.com>) id 1JUVUC-0001kT-AB
	for linuxppc-dev@ozlabs.org; Wed, 27 Feb 2008 15:14:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: FW: [PATCH] Xilinx: LL TEMAC/Bootstrap: Updated driver and bootstrap
	to pull mac addr from eeprom
Date: Wed, 27 Feb 2008 16:14:50 -0700
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>,
	"git-dev" <git-dev@xilinx.com>
Message-Id: <20080227231452.DD4124507B7@mail190-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The LL TEMAC driver was updated to use the mac address from the board
data,
to use the Marvell specific PHY code so that 10 Mbit works, and to use
the
dcr_host from the platform data rather than using conditional
compilation
for DCR with DMA. The bootstrap loader was changed to read the mac
address
from the eeprom into the board data.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/ppc/boot/simple/Makefile              |   10 +-
 arch/ppc/boot/simple/embed_config.c        |  154 ++++-
 drivers/i2c/algos/xilinx_iic/Makefile      |    2 +-
 drivers/i2c/algos/xilinx_iic/xiic_l.c      |  967
++++++++++++++++++++++++++++
 drivers/net/xilinx_lltemac/xlltemac_main.c |   58 +-
 5 files changed, 1153 insertions(+), 38 deletions(-)
 create mode 100755 drivers/i2c/algos/xilinx_iic/xiic_l.c

diff --git a/arch/ppc/boot/simple/Makefile
b/arch/ppc/boot/simple/Makefile
index 8581bea..2b0671e 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -21,6 +21,11 @@
 # XXX_memory.o file for this to work, as well as editing the
 # misc-$(CONFIG_MACHINE) variable.
=20
+ifeq ($(CONFIG_XILINX_EMBED_CONFIG),y)
+EXTRA_CFLAGS		+=3D -Idrivers/i2c/algos/xilinx_iic
+EXTRA_CFLAGS		+=3D -Idrivers/xilinx_common
+endif
+
 boot				:=3D arch/ppc/boot
 common				:=3D $(boot)/common
 utils				:=3D $(boot)/utils
@@ -128,6 +133,9 @@ zimageinitrd-$(CONFIG_WALNUT)		:=3D
zImage.initrd-TREE
          end-$(CONFIG_EV64360)          :=3D ev64360
    cacheflag-$(CONFIG_EV64360)          :=3D -include $(clear_L2_L3)
=20
+     extra.o-$(CONFIG_XILINX_EMBED_CONFIG)  :=3D
../../../../drivers/xilinx_common/xio.o \
+
../../../../drivers/i2c/algos/xilinx_iic/xiic_l.o=09
+
 # kconfig 'feature', only one of these will ever be 'y' at a time.
 # The rest will be unset.
 motorola :=3D $(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
@@ -187,7 +195,7 @@ boot-$(CONFIG_REDWOOD_6)	+=3D embed_config.o
 boot-$(CONFIG_8xx)		+=3D embed_config.o
 boot-$(CONFIG_8260)		+=3D embed_config.o
 boot-$(CONFIG_EP405)		+=3D embed_config.o
-boot-$(CONFIG_XILINX_EMBED_CONFIG)	+=3D embed_config.o
+boot-$(CONFIG_XILINX_EMBED_CONFIG)	+=3D embed_config.o=20
 boot-$(CONFIG_BSEIP)		+=3D iic.o
 boot-$(CONFIG_MBX)		+=3D iic.o pci.o qspan_pci.o
 boot-$(CONFIG_MV64X60)		+=3D misc-mv64x60.o
diff --git a/arch/ppc/boot/simple/embed_config.c
b/arch/ppc/boot/simple/embed_config.c
index beb03db..45f1421 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -17,12 +17,14 @@
 #include <asm/mpc8260.h>
 #include <asm/immap_cpm2.h>
 #endif
-#ifdef CONFIG_40x
+#if defined (CONFIG_40x) || defined (CONFIG_44x)
 #include <asm/io.h>
 #endif
+
 #ifdef CONFIG_XILINX_VIRTEX
 #include <platforms/4xx/xparameters/xparameters.h>
 #endif
+
 extern unsigned long timebase_period_ns;
=20
 /* For those boards that don't provide one.
@@ -744,17 +746,134 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
=20
-#if defined(CONFIG_XILINX_EMBED_CONFIG)
+#if defined(CONFIG_XILINX_ML403) || defined(CONFIG_XILINX_ML405) ||
defined(CONFIG_XILINX_ML507)
+
+#if (!defined(XPAR_IIC_0_BASEADDR) ||
!defined(XPAR_PERSISTENT_0_IIC_0_BASEADDR))
+int get_cfg_data(unsigned char **cfg_data)
+{
+	/*
+	 * The ML300, ML40x and ML50x uses an I2C SEEPROM to store the
Ethernet
+	 * MAC address, but either an I2C interface or the SEEPROM
aren't
+	 * configured in.  If you are in this situation, you'll need to
define
+	 * an alternative way of storing the Ethernet MAC address.  For
now, a
+	 * hard-coded MAC will be used. If this is sufficient, you may
simply
+	 * comment out the followign #warning.
+	 */
+#warning I2C needed for obtaining the Ethernet MAC address. Using
hard-coded MAC address
+	return 0;	/* no cfg data found */
+}
+#else
+#include <xiic_l.h>
+
+#define CFG_DATA_SIZE \
+ (XPAR_PERSISTENT_0_IIC_0_HIGHADDR - XPAR_PERSISTENT_0_IIC_0_BASEADDR +
1)
+
+int get_cfg_data(unsigned char **cfg_data)
+{
+	static unsigned char sdata[CFG_DATA_SIZE]; /* 'static': get
sdata off the stack */
+	int i;
+
+	/*
+	 * Fill our SEEPROM data array (sdata) from address
+	 * XPAR_PERSISTENT_0_IIC_0_BASEADDR of the SEEPROM at slave
+	 * address XPAR_PERSISTENT_0_IIC_0_EEPROMADDR.  We'll then parse
+	 * that data looking for a MAC address. */
+	sdata[0] =3D XPAR_PERSISTENT_0_IIC_0_BASEADDR >> 8;
+#if defined(XPAR_IIC_0_TEN_BIT_ADR) && (XPAR_IIC_0_TEN_BIT_ADR =3D=3D =
1)
+	sdata[1] =3D XPAR_PERSISTENT_0_IIC_0_BASEADDR & 0xFF;
+	i =3D XIic_Send(XPAR_IIC_0_BASEADDR,
+		      XPAR_PERSISTENT_0_IIC_0_EEPROMADDR>>1, sdata, 2,
XIIC_STOP);
+	if (i !=3D 2)
+		return 0;	/* Couldn't send the address.  Return
error. */
+#else
+	i =3D XIic_Send(XPAR_IIC_0_BASEADDR,
+		      XPAR_PERSISTENT_0_IIC_0_EEPROMADDR>>1, sdata, 1,
XIIC_STOP);
+	if (i !=3D 1) {
+		return 0;	/* Couldn't send the address.  Return
error. */
+	}
+#endif
+	i =3D XIic_Recv(XPAR_IIC_0_BASEADDR,
+		      XPAR_PERSISTENT_0_IIC_0_EEPROMADDR>>1,
+		      sdata, sizeof(sdata), XIIC_STOP);
+	if (i !=3D sizeof(sdata)) {
+		return 0;	/* Didn't read all the data.  Return
error. */
+	}
+	*cfg_data =3D sdata;
+	return CFG_DATA_SIZE;
+}
+#endif /* (!defined(XPAR_IIC_0_BASEADDR) ||
!defined(XPAR_PERSISTENT_0_IIC_0_BASEADDR)) */
+
+static int
+hexdigit(char c)
+{
+	if ('0' <=3D c && c <=3D '9')
+		return c - '0';
+	else if ('a' <=3D c && c <=3D 'f')
+		return c - 'a' + 10;
+	else if ('A' <=3D c && c <=3D 'F')
+		return c - 'A' + 10;
+	else
+		return -1;
+}
+
+typedef struct iic_eeprom_struct {
+	/* Generally used parameters */
+	char which_board[17];          /* 0x000 to 0x010 Plain text ID
of which board */
+	char board_rev[5];             /* 0x011 to 0x015 Plain text
Board Rev (A, B, C, etc) */
+	char minor_board_rev[5];       /* 0x016 to 0x01A Plain text
minor board rev (001, 002, etc) */
+	char which_FPGA[19];           /* 0x01B to 0x02E Plain text
which FPGA is on the board (main FPGA if multiple) */
+	char board_sn[9];              /* 0x02F to 0x037 Plain text
Serial Number of board */
+	char board_mac_id[13];         /* 0x038 to 0x044 Plain text MAC
Address for this board */
+	char last_test_date[12];       /* 0x045 to 0x050 Plain text last
date that tests were run (DD-MMM-YYYY) */
+	char manufacture_date[12];     /* 0x051 to 0x05C Plain text
Manufacture Date (DD-MMM-YYYY) */
+	char manufacture_id[17];       /* 0x05D to 0x06D Plain text
Manufacture ID (Name) */
+	char tested_before[19];        /* 0x06E to 0x080 Plain text set
to 'Xilinx Virtex-X Based MLxxx' (?19?) */
+} iic_eeprom_struct;
+
+static int get_mac_addr(unsigned char *mac)
+{
+	iic_eeprom_struct *eeprom;
+	int cfg_size;
+
+	cfg_size =3D get_cfg_data((unsigned char **)&eeprom);
+
+	if (cfg_size =3D=3D 0)
+		return 1;	/* Failed to read configuration data */
+
+	/* check the manufacture date to make sure we've got the right
struct
+	 * info */
+	if ((eeprom->board_mac_id[0] =3D=3D '0') &&
+	    (eeprom->board_mac_id[1] =3D=3D '0') &&
+            (eeprom->board_mac_id[2] =3D=3D '0') &&	=09
+            (eeprom->board_mac_id[3] =3D=3D 'A') &&
+	    (eeprom->board_mac_id[4] =3D=3D '3') &&
+	    (eeprom->board_mac_id[5] =3D=3D '5')) {
+		mac[0] =3D (hexdigit(eeprom->board_mac_id[0]) << 4) |
(hexdigit(eeprom->board_mac_id[1]));
+		mac[1] =3D (hexdigit(eeprom->board_mac_id[2]) << 4) |
(hexdigit(eeprom->board_mac_id[3]));
+		mac[2] =3D (hexdigit(eeprom->board_mac_id[4]) << 4) |
(hexdigit(eeprom->board_mac_id[5]));
+		mac[3] =3D (hexdigit(eeprom->board_mac_id[6]) << 4) |
(hexdigit(eeprom->board_mac_id[7]));
+		mac[4] =3D (hexdigit(eeprom->board_mac_id[8]) << 4) |
(hexdigit(eeprom->board_mac_id[9]));
+		mac[5] =3D (hexdigit(eeprom->board_mac_id[10]) << 4) |
(hexdigit(eeprom->board_mac_id[11]));
+
+		/* Success */
+		return 0;
+
+	}=20
+
+	/* Data not recognized */
+	return 1;
+}
+
 void
 embed_config(bd_t ** bdp)
 {
+#ifdef CONFIG_40x
 	static const unsigned long line_size =3D 32;
 	static const unsigned long congruence_classes =3D 256;
 	unsigned long addr;
 	unsigned long dccr;
-	uint8_t* cp;
+#endif
 	bd_t *bd;
-	int i;
=20
 	/*
 	 * Invalidate the data cache if the data cache is turned off.
@@ -765,6 +884,7 @@ embed_config(bd_t ** bdp)
 	 *   a bootloader and we assume that the cache contents are
 	 *   valid.
 	 */
+#ifdef CONFIG_40x
 	__asm__("mfdccr %0": "=3Dr" (dccr));
 	if (dccr =3D=3D 0) {
 		for (addr =3D 0;
@@ -773,23 +893,37 @@ embed_config(bd_t ** bdp)
 			__asm__("dccci 0,%0": :"b"(addr));
 		}
 	}
+#endif
=20
 	bd =3D &bdinfo;
 	*bdp =3D bd;
 	bd->bi_memsize =3D XPAR_DDR_0_SIZE;
 	bd->bi_intfreq =3D XPAR_CORE_CLOCK_FREQ_HZ;
 	bd->bi_busfreq =3D XPAR_PLB_CLOCK_FREQ_HZ;
+#ifdef XPAR_PCI_0_CLOCK_FREQ_HZ
 	bd->bi_pci_busfreq =3D XPAR_PCI_0_CLOCK_FREQ_HZ;
+#endif
=20
-	/* Copy the default ethernet address */
-	cp =3D (u_char *)def_enet_addr;
-	for (i=3D0; i<6; i++)
-		bd->bi_enetaddr[i] =3D *cp++;
+	if (get_mac_addr(bd->bi_enetaddr)) {
+		/* The SEEPROM is corrupted. set the address to
+		 * Xilinx's preferred default. However, first to
+		 * eliminate a compiler warning because we don't really
+		 * use def_enet_addr, we'll reference it. The compiler
+		 * optimizes it away so no harm done. */
+		bd->bi_enetaddr[0] =3D def_enet_addr[0];
+		bd->bi_enetaddr[0] =3D 0x00;
+		bd->bi_enetaddr[1] =3D 0x0A;
+		bd->bi_enetaddr[2] =3D 0x35;
+		bd->bi_enetaddr[3] =3D 0x01;
+		bd->bi_enetaddr[4] =3D 0x02;
+		bd->bi_enetaddr[5] =3D 0x03;
+	}
=20
 	timebase_period_ns =3D 1000000000 / bd->bi_tbfreq;
-	/* see bi_tbfreq definition in
arch/ppc/platforms/4xx/xilinx_ml300.h */
+	/* see bi_tbfreq definition in
arch/ppc/platforms/4xx/xilinx_mlxxx.h */
 }
-#endif /* CONFIG_XILINX_EMBED_CONFIG */
+#endif /* defined(CONFIG_XILINX_ML403) || defined(CONFIG_XILINX_ML405)
||=20
+          defined(CONFIG_XILINX_ML507) */
=20
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
diff --git a/drivers/i2c/algos/xilinx_iic/Makefile
b/drivers/i2c/algos/xilinx_iic/Makefile
index 78ff332..80e351a 100644
--- a/drivers/i2c/algos/xilinx_iic/Makefile
+++ b/drivers/i2c/algos/xilinx_iic/Makefile
@@ -11,4 +11,4 @@ xilinx_iic-objs	:=3D i2c-algo-xilinx.o
=20
 # The Xilinx OS independent code.
 xilinx_iic-objs	+=3D xiic.o xiic_options.o xiic_master.o \
-		   xiic_intr.o
+		   xiic_intr.o xiic_l.o
diff --git a/drivers/i2c/algos/xilinx_iic/xiic_l.c
b/drivers/i2c/algos/xilinx_iic/xiic_l.c
new file mode 100755
index 0000000..e2e23e3
--- /dev/null
+++ b/drivers/i2c/algos/xilinx_iic/xiic_l.c
@@ -0,0 +1,967 @@
+/* $Id: xiic_l.c,v 1.3 2007/12/17 19:15:38 meinelte Exp $ */
+/**********************************************************************
********
+*
+*       XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+*       AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+*       SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+*       OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+*       APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+*       THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF
INFRINGEMENT,
+*       AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY
REQUIRE
+*       FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+*       WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+*       IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+*       REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+*       INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+*       FOR A PARTICULAR PURPOSE.
+*
+*       (c) Copyright 2002-2007 Xilinx Inc.
+*       All rights reserved.
+* This program is free software; you can redistribute it and/or modify
it
+* under the terms of the GNU General Public License as published by the
+* Free Software Foundation; either version 2 of the License, or (at
your
+* option) any later version.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
USA
+*
+***********************************************************************
*******/
+/**********************************************************************
*******/
+/**
+*
+* @file xiic_l.c
+*
+* This file contains low-level driver functions that can be used to
access the
+* device in normal and dynamic controller mode. The user should refer
to the
+* hardware device specification for more details of the device
operation.
+*
+* <pre>
+* MODIFICATION HISTORY:
+*
+* Ver   Who  Date     Changes
+* ----- --- -------   -----------------------------------------------
+* 1.01b jhl 05/13/02  First release
+* 1.01b jhl 10/14/02  Corrected bug in the receive function, the setup
of the
+*                     interrupt status mask was not being done in the
loop such
+*                     that a read would sometimes fail on the last byte
because
+*                     the transmit error which should have been ignored
was
+*                     being used.  This would leave an extra byte in
the FIFO
+*                     and the bus throttled such that the next
operation would
+*                     also fail.  Also updated the receive function to
not
+*                     disable the device after the last byte until
after the
+*                     bus transitions to not busy which is more
consistent
+*                     with the expected behavior.
+* 1.01c ecm  12/05/02 new rev
+* 1.02a mta  03/09/06 Implemented Repeated Start in the Low Level
Driver.
+* 1.03a mta  04/04/06 Implemented Dynamic IIC core routines.
+* 1.03a ecm  06/15/06 Fixed the hang in low_level_eeprom_test with -O0
+*                     Added polling loops for BNB to allow the slave to
+*                     respond correctly. Also added polling loop prior
+*                     to reset in _Recv.
+* 1.13a wgr  03/22/07 Converted to new coding style.
+* 1.13b ecm  11/29/07 added BB polling loops to the DynSend and DynRecv
+*					  routines to handle the race
condition with BNB in IISR.
+* </pre>
+*
+***********************************************************************
*****/
+
+/***************************** Include Files
*******************************/
+
+#include "xbasic_types.h"
+#include "xio.h"
+#include "xiic_l.h"
+
+/************************** Constant Definitions
***************************/
+
+/**************************** Type Definitions
*****************************/
+
+/***************** Macros (Inline Functions) Definitions
*******************/
+
+/************************** Function Prototypes
****************************/
+
+static unsigned RecvData(u32 BaseAddress, u8 *BufferPtr,
+			 unsigned ByteCount, u8 Option);
+static unsigned SendData(u32 BaseAddress, u8 *BufferPtr,
+			 unsigned ByteCount, u8 Option);
+
+static unsigned DynRecvData(u32 BaseAddress, u8 *BufferPtr, u8
ByteCount);
+static unsigned DynSendData(u32 BaseAddress, u8 *BufferPtr,
+			    u8 ByteCount, u8 Option);
+
+/************************** Variable Definitions
**************************/
+
+/**********************************************************************
******/
+/**
+* Receive data as a master on the IIC bus.  This function receives the
data
+* using polled I/O and blocks until the data has been received. It only
+* supports 7 bit addressing mode of operation. The user is responsible
for
+* ensuring the bus is not busy if multiple masters are present on the
bus.
+*
+* @param    BaseAddress contains the base address of the IIC device.
+* @param    Address contains the 7 bit IIC address of the device to
send the
+*           specified data to.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent.
+* @param    Option indicates whether to hold or free the bus after
reception
+*           of data, XIIC_STOP =3D end with STOP condition,
XIIC_REPEATED_START
+*           =3D don't end with STOP condition.
+*
+* @return
+*
+* The number of bytes received.
+*
+* @note
+*
+* None
+*
+***********************************************************************
*******/
+unsigned XIic_Recv(u32 BaseAddress, u8 Address,
+		   u8 *BufferPtr, unsigned ByteCount, u8 Option)
+{
+	u8 CntlReg;
+	unsigned RemainingByteCount;
+	volatile u8 StatusReg;
+
+	/* Tx error is enabled incase the address (7 or 10) has no
device to answer
+	 * with Ack. When only one byte of data, must set NO ACK before
address goes
+	 * out therefore Tx error must not be enabled as it will go off
immediately
+	 * and the Rx full interrupt will be checked.  If full, then the
one byte
+	 * was received and the Tx error will be disabled without
sending an error
+	 * callback msg.
+	 */
+	XIic_mClearIisr(BaseAddress,
+			XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK
|
+			XIIC_INTR_ARB_LOST_MASK);
+
+	/* Set receive FIFO occupancy depth for 1 byte (zero based)
+	 */
+	XIo_Out8(BaseAddress + XIIC_RFD_REG_OFFSET, 0);
+
+
+	/* Check to see if already Master on the Bus.
+	 * If Repeated Start bit is not set send Start bit by setting
MSMS bit else
+	 * Send the address.
+	 */
+	CntlReg =3D XIo_In8(BaseAddress + XIIC_CR_REG_OFFSET);
+	if ((CntlReg & XIIC_CR_REPEATED_START_MASK) =3D=3D 0) {
+		/* 7 bit slave address, send the address for a read
operation
+		 * and set the state to indicate the address has been
sent
+		 */
+		XIic_mSend7BitAddress(BaseAddress, Address,
+				      XIIC_READ_OPERATION);
+
+
+		/* MSMS gets set after putting data in FIFO. Start the
master receive
+		 * operation by setting CR Bits MSMS to Master, if the
buffer is only one
+		 * byte, then it should not be acknowledged to indicate
the end of data
+		 */
+		CntlReg =3D XIIC_CR_MSMS_MASK |
XIIC_CR_ENABLE_DEVICE_MASK;
+		if (ByteCount =3D=3D 1) {
+			CntlReg |=3D XIIC_CR_NO_ACK_MASK;
+		}
+
+		/* Write out the control register to start receiving
data and call the
+		 * function to receive each byte into the buffer
+		 */
+		XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET, CntlReg);
+
+		/* Clear the latched interrupt status for the bus not
busy bit which must
+		 * be done while the bus is busy
+		 */
+		StatusReg =3D XIo_In8(BaseAddress + XIIC_SR_REG_OFFSET);
+
+		while ((StatusReg & XIIC_SR_BUS_BUSY_MASK) =3D=3D 0) {
+			StatusReg =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+
+		}
+
+		XIic_mClearIisr(BaseAddress, XIIC_INTR_BNB_MASK);
+	}
+	else {
+		/* Already owns the Bus indicating that its a Repeated
Start call.
+		 * 7 bit slave address, send the address for a read
operation
+		 * and set the state to indicate the address has been
sent
+		 */
+		XIic_mSend7BitAddress(BaseAddress, Address,
+				      XIIC_READ_OPERATION);
+	}
+	/* Try to receive the data from the IIC bus */
+
+	RemainingByteCount =3D
+		RecvData(BaseAddress, BufferPtr, ByteCount, Option);
+
+	CntlReg =3D XIo_In8(BaseAddress + XIIC_CR_REG_OFFSET);
+	if ((CntlReg & XIIC_CR_REPEATED_START_MASK) =3D=3D 0) {
+		/* The receive is complete, disable the IIC device if
the Option is
+		 * to release the Bus after Reception of data and return
the number of
+		 * bytes that was received
+		 */
+		XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET, 0);
+	}
+
+	/* Return the number of bytes that was received */
+
+	return ByteCount - RemainingByteCount;
+}
+
+/**********************************************************************
********
+*
+* Receive the specified data from the device that has been previously
addressed
+* on the IIC bus.  This function assumes that the 7 bit address has
been sent
+* and it should wait for the transmit of the address to complete.
+*
+* @param    BaseAddress contains the base address of the IIC device.
+* @param    BufferPtr points to the buffer to hold the data that is
received.
+* @param    ByteCount is the number of bytes to be received.
+* @param    Option indicates whether to hold or free the bus after
reception
+*           of data, XIIC_STOP =3D end with STOP condition,
XIIC_REPEATED_START
+*           =3D don't end with STOP condition.
+*
+* @return
+*
+* The number of bytes remaining to be received.
+*
+* @note
+*
+* This function does not take advantage of the receive FIFO because it
is
+* designed for minimal code space and complexity.  It contains loops
that
+* that could cause the function not to return if the hardware is not
working.
+*
+* This function assumes that the calling function will disable the IIC
device
+* after this function returns.
+*
+***********************************************************************
*******/
+static unsigned RecvData(u32 BaseAddress, u8 *BufferPtr,
+			 unsigned ByteCount, u8 Option)
+{
+	u8 CntlReg;
+	u32 IntrStatusMask;
+	u32 IntrStatus;
+
+	/* Attempt to receive the specified number of bytes on the IIC
bus */
+
+	while (ByteCount > 0) {
+		/* Setup the mask to use for checking errors because
when receiving one
+		 * byte OR the last byte of a multibyte message an error
naturally
+		 * occurs when the no ack is done to tell the slave the
last byte
+		 */
+		if (ByteCount =3D=3D 1) {
+			IntrStatusMask =3D
+				XIIC_INTR_ARB_LOST_MASK |
XIIC_INTR_BNB_MASK;
+		}
+		else {
+			IntrStatusMask =3D
+				XIIC_INTR_ARB_LOST_MASK |
+				XIIC_INTR_TX_ERROR_MASK |
XIIC_INTR_BNB_MASK;
+		}
+
+		/* Wait for the previous transmit and the 1st receive to
complete
+		 * by checking the interrupt status register of the IPIF
+		 */
+		while (1) {
+			IntrStatus =3D XIIC_READ_IISR(BaseAddress);
+			if (IntrStatus & XIIC_INTR_RX_FULL_MASK) {
+				break;
+			}
+			/* Check the transmit error after the receive
full because when
+			 * sending only one byte transmit error will
occur because of the
+			 * no ack to indicate the end of the data
+			 */
+			if (IntrStatus & IntrStatusMask) {
+				return ByteCount;
+			}
+		}
+
+		CntlReg =3D XIo_In8(BaseAddress + XIIC_CR_REG_OFFSET);
+
+		/* Special conditions exist for the last two bytes so
check for them
+		 * Note that the control register must be setup for
these conditions
+		 * before the data byte which was already received is
read from the
+		 * receive FIFO (while the bus is throttled
+		 */
+		if (ByteCount =3D=3D 1) {
+			if (Option =3D=3D XIIC_STOP) {
+
+				/* If the Option is to release the bus
after the last data
+				 * byte, it has already been read and no
ack has been done, so
+				 * clear MSMS while leaving the device
enabled so it can get off
+				 * the IIC bus appropriately with a
stop.
+				 */
+				XIo_Out8(BaseAddress +
XIIC_CR_REG_OFFSET,
+					 XIIC_CR_ENABLE_DEVICE_MASK);
+			}
+		}
+
+		/* Before the last byte is received, set NOACK to tell
the slave IIC
+		 * device that it is the end, this must be done before
reading the byte
+		 * from the FIFO
+		 */
+		if (ByteCount =3D=3D 2) {
+			/* Write control reg with NO ACK allowing last
byte to
+			 * have the No ack set to indicate to slave last
byte read.
+			 */
+			XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
+				 CntlReg | XIIC_CR_NO_ACK_MASK);
+		}
+
+		/* Read in data from the FIFO and unthrottle the bus
such that the
+		 * next byte is read from the IIC bus
+		 */
+		*BufferPtr++ =3D XIo_In8(BaseAddress +
XIIC_DRR_REG_OFFSET);
+
+		if ((ByteCount =3D=3D 1) && (Option =3D=3D XIIC_REPEATED_START))
{
+
+			/* RSTA bit should be set only when the FIFO is
completely Empty.
+			 */
+			XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
+				 XIIC_CR_ENABLE_DEVICE_MASK |
XIIC_CR_MSMS_MASK
+				 | XIIC_CR_REPEATED_START_MASK);
+
+		}
+
+		/* Clear the latched interrupt status so that it will be
updated with
+		 * the new state when it changes, this must be done
after the receive
+		 * register is read
+		 */
+		XIic_mClearIisr(BaseAddress, XIIC_INTR_RX_FULL_MASK |
+				XIIC_INTR_TX_ERROR_MASK |
+				XIIC_INTR_ARB_LOST_MASK);
+		ByteCount--;
+	}
+
+
+	if (Option =3D=3D XIIC_STOP) {
+
+		/* If the Option is to release the bus after Reception
of data, wait
+		 * for the bus to transition to not busy before
returning, the IIC
+		 * device cannot be disabled until this occurs. It
should transition as
+		 * the MSMS bit of the control register was cleared
before the last byte
+		 * was read from the FIFO.
+		 */
+		while (1) {
+			if (XIIC_READ_IISR(BaseAddress) &
+			    XIIC_INTR_BNB_MASK) {
+				break;
+			}
+		}
+	}
+
+	return ByteCount;
+}
+
+/**********************************************************************
******/
+/**
+* Send data as a master on the IIC bus.  This function sends the data
+* using polled I/O and blocks until the data has been sent.  It only
supports
+* 7 bit addressing mode of operation.  The user is responsible for
ensuring
+* the bus is not busy if multiple masters are present on the bus.
+*
+* @param    BaseAddress contains the base address of the IIC device.
+* @param    Address contains the 7 bit IIC address of the device to
send the
+*           specified data to.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent.
+* @param    Option indicates whether to hold or free the bus after
+*           transmitting the data.
+*
+* @return
+*
+* The number of bytes sent.
+*
+* @note
+*
+* None
+*
+***********************************************************************
*******/
+unsigned XIic_Send(u32 BaseAddress, u8 Address,
+		   u8 *BufferPtr, unsigned ByteCount, u8 Option)
+{
+	unsigned RemainingByteCount;
+	u8 ControlReg;
+	volatile u8 StatusReg;
+
+	/* Check to see if already Master on the Bus.
+	 * If Repeated Start bit is not set send Start bit by setting
MSMS bit else
+	 * Send the address.
+	 */
+	ControlReg =3D XIo_In8(BaseAddress + XIIC_CR_REG_OFFSET);
+	if ((ControlReg & XIIC_CR_REPEATED_START_MASK) =3D=3D 0) {
+		/* Put the address into the FIFO to be sent and indicate
that the operation
+		 * to be performed on the bus is a write operation
+		 */
+		XIic_mSend7BitAddress(BaseAddress, Address,
+				      XIIC_WRITE_OPERATION);
+		/* Clear the latched interrupt status so that it will be
updated with the
+		 * new state when it changes, this must be done after
the address is put
+		 * in the FIFO
+		 */
+		XIic_mClearIisr(BaseAddress, XIIC_INTR_TX_EMPTY_MASK |
+				XIIC_INTR_TX_ERROR_MASK |
+				XIIC_INTR_ARB_LOST_MASK);
+
+		/* MSMS must be set after putting data into transmit
FIFO, indicate the
+		 * direction is transmit, this device is master and
enable the IIC device
+		 */
+		XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
+			 XIIC_CR_MSMS_MASK | XIIC_CR_DIR_IS_TX_MASK |
+			 XIIC_CR_ENABLE_DEVICE_MASK);
+
+		/* Clear the latched interrupt
+		 * status for the bus not busy bit which must be done
while the bus is busy
+		 */
+		StatusReg =3D XIo_In8(BaseAddress + XIIC_SR_REG_OFFSET);
+		while ((StatusReg & XIIC_SR_BUS_BUSY_MASK) =3D=3D 0) {
+			StatusReg =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+		}
+
+		XIic_mClearIisr(BaseAddress, XIIC_INTR_BNB_MASK);
+
+	}
+	else {
+		/* Already owns the Bus indicating that its a Repeated
Start call.
+		 * 7 bit slave address, send the address for a write
operation
+		 * and set the state to indicate the address has been
sent
+		 */
+		XIic_mSend7BitAddress(BaseAddress, Address,
+				      XIIC_WRITE_OPERATION);
+	}
+
+	/* Send the specified data to the device on the IIC bus
specified by the
+	 * the address
+	 */
+	RemainingByteCount =3D
+		SendData(BaseAddress, BufferPtr, ByteCount, Option);
+
+	ControlReg =3D XIo_In8(BaseAddress + XIIC_CR_REG_OFFSET);
+	if ((ControlReg & XIIC_CR_REPEATED_START_MASK) =3D=3D 0) {
+		/* The Transmission is completed, disable the IIC device
if the Option
+		 * is to release the Bus after transmission of data and
return the number
+		 * of bytes that was received. Only wait if master, if
addressed as slave
+		 * just reset to release the bus.
+		 */
+		if ((ControlReg & XIIC_CR_MSMS_MASK) !=3D 0) {
+			XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
+				 (ControlReg & ~XIIC_CR_MSMS_MASK));
+			StatusReg =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+			while ((StatusReg & XIIC_SR_BUS_BUSY_MASK) !=3D 0)
{
+				StatusReg =3D
+					XIo_In8(BaseAddress +
+						XIIC_SR_REG_OFFSET);
+			}
+		}
+
+		XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET, 0);
+	}
+
+	return ByteCount - RemainingByteCount;
+}
+
+/**********************************************************************
********
+*
+* Send the specified buffer to the device that has been previously
addressed
+* on the IIC bus.  This function assumes that the 7 bit address has
been sent
+* and it should wait for the transmit of the address to complete.
+*
+* @param    BaseAddress contains the base address of the IIC device.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent.
+* @param    Option indicates whether to hold or free the bus after
+*           transmitting the data.
+*
+* @return
+*
+* The number of bytes remaining to be sent.
+*
+* @note
+*
+* This function does not take advantage of the transmit FIFO because it
is
+* designed for minimal code space and complexity.  It contains loops
that
+* that could cause the function not to return if the hardware is not
working.
+*
+***********************************************************************
*******/
+static unsigned SendData(u32 BaseAddress, u8 *BufferPtr,
+			 unsigned ByteCount, u8 Option)
+{
+	u32 IntrStatus;
+
+	/* Send the specified number of bytes in the specified buffer by
polling
+	 * the device registers and blocking until complete
+	 */
+	while (ByteCount > 0) {
+		/* Wait for the transmit to be empty before sending any
more data
+		 * by polling the interrupt status register
+		 */
+		while (1) {
+			IntrStatus =3D XIIC_READ_IISR(BaseAddress);
+
+			if (IntrStatus & (XIIC_INTR_TX_ERROR_MASK |
+					  XIIC_INTR_ARB_LOST_MASK |
+					  XIIC_INTR_BNB_MASK)) {
+				return ByteCount;
+			}
+
+			if (IntrStatus & XIIC_INTR_TX_EMPTY_MASK) {
+				break;
+			}
+		}
+		/* If there is more than one byte to send then put the
next byte to send
+		 * into the transmit FIFO
+		 */
+		if (ByteCount > 1) {
+			XIo_Out8(BaseAddress + XIIC_DTR_REG_OFFSET,
+				 *BufferPtr++);
+		}
+		else {
+			if (Option =3D=3D XIIC_STOP) {
+				/* If the Option is to release the bus
after the last data
+				 * byte, Set the stop Option before
sending the last byte
+				 * of data so that the stop Option will
be generated
+				 * immediately following the data. This
is done by clearing
+				 * the MSMS bit in the control register.
+				 */
+				XIo_Out8(BaseAddress +
XIIC_CR_REG_OFFSET,
+					 XIIC_CR_ENABLE_DEVICE_MASK |
+					 XIIC_CR_DIR_IS_TX_MASK);
+			}
+
+			/* Put the last byte to send in the transmit
FIFO */
+
+			XIo_Out8(BaseAddress + XIIC_DTR_REG_OFFSET,
+				 *BufferPtr++);
+
+			if (Option =3D=3D XIIC_REPEATED_START) {
+				XIic_mClearIisr(BaseAddress,
+
XIIC_INTR_TX_EMPTY_MASK);
+				/* Wait for the transmit to be empty
before setting RSTA bit. */
+				while (1) {
+					IntrStatus =3D
+						XIIC_READ_IISR
+						(BaseAddress);
+					if (IntrStatus &
+					    XIIC_INTR_TX_EMPTY_MASK) {
+						/* RSTA bit should be
set only when the FIFO is completely Empty.
+						 */
+						XIo_Out8(BaseAddress +
+
XIIC_CR_REG_OFFSET,
+
XIIC_CR_REPEATED_START_MASK
+							 |
+
XIIC_CR_ENABLE_DEVICE_MASK
+							 |
+
XIIC_CR_DIR_IS_TX_MASK
+							 |
XIIC_CR_MSMS_MASK);
+						break;
+					}
+				}
+			}
+
+		}
+
+		/* Clear the latched interrupt status register and this
must be done after
+		 * the transmit FIFO has been written to or it won't
clear
+		 */
+		XIic_mClearIisr(BaseAddress, XIIC_INTR_TX_EMPTY_MASK);
+
+		/* Update the byte count to reflect the byte sent and
clear the latched
+		 * interrupt status so it will be updated for the new
state
+		 */
+		ByteCount--;
+	}
+
+	if (Option =3D=3D XIIC_STOP) {
+		/* If the Option is to release the bus after
transmission of data,
+		 * Wait for the bus to transition to not busy before
returning, the IIC
+		 * device cannot be disabled until this occurs.
+		 * Note that this is different from a receive operation
because the stop
+		 * Option causes the bus to go not busy.
+		 */
+		while (1) {
+			if (XIIC_READ_IISR(BaseAddress) &
+			    XIIC_INTR_BNB_MASK) {
+				break;
+			}
+		}
+	}
+
+	return ByteCount;
+}
+
+/**********************************************************************
*******/
+/**
+* Receive data as a master on the IIC bus. This function receives the
data
+* using polled I/O and blocks until the data has been received. It only
+* supports 7 bit addressing. The user is responsible for ensuring the
bus is
+* not busy if multiple masters are present on the bus.
+*
+* @param    BaseAddress contains the base address of the IIC Device.
+* @param    Address contains the 7 bit IIC Device address of the device
to send
+*           the specified data to.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent. This value
can't be
+*           greater than 255 and needs to be greater than 0.
+*
+* @return   The number of bytes received.
+*
+* @note     Upon entry to this function, the IIC interface needs to be
already
+*           enabled in the CR register.
+*
+***********************************************************************
*******/
+unsigned XIic_DynRecv(u32 BaseAddress, u8 Address, u8 *BufferPtr, u8
ByteCount)
+{
+	unsigned RemainingByteCount;
+	u32 StatusRegister;
+
+	/*
+	 * Clear the latched interrupt status so that it will be updated
with
+	 * the new state when it changes.
+	 */
+	XIic_mClearIisr(BaseAddress, XIIC_INTR_TX_EMPTY_MASK |
+			XIIC_INTR_TX_ERROR_MASK |
XIIC_INTR_ARB_LOST_MASK);
+
+	/*
+	 * Send the 7 bit slave address for a read operation and set the
state
+	 * to indicate the address has been sent. Upon writing the
address, a
+	 * start condition is initiated. MSMS is automatically set to
master
+	 * when the address is written to the Fifo. If MSMS was already
set,
+	 *  then a re-start is sent prior to the address.
+	 */
+	XIic_mDynSend7BitAddress(BaseAddress, Address,
XIIC_READ_OPERATION);
+
+	/*
+	 * Wait for the bus to go busy.
+	 */
+	StatusRegister =3D XIo_In8(BaseAddress + XIIC_SR_REG_OFFSET);
+
+	while (( StatusRegister & XIIC_SR_BUS_BUSY_MASK) !=3D
XIIC_SR_BUS_BUSY_MASK)
+	{
+		StatusRegister =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+	}
+
+	/*
+	 * Clear the latched interrupt status for the bus not busy bit
which
+	 * must be done while the bus is busy.
+	 */
+	XIic_mClearIisr(BaseAddress, XIIC_INTR_BNB_MASK);
+
+	/*
+	 * Write to the Tx Fifo the dynamic stop control bit with the
number of
+	 * bytes that are to be read over the IIC interface from the
presently
+	 * addressed device.
+	 */
+	XIic_mDynSendStop(BaseAddress, ByteCount);
+
+	/*
+	 * Receive the data from the IIC bus.
+	 */
+	RemainingByteCount =3D DynRecvData(BaseAddress, BufferPtr,
ByteCount);
+
+	/*
+	 * The receive is complete. Return the number of bytes that were
+	 * received.
+	 */
+	return ByteCount - RemainingByteCount;
+}
+
+/**********************************************************************
*******/
+/**
+* Receive the specified data from the device that has been previously
addressed
+* on the IIC bus. This function assumes the following:
+*   - The Rx Fifo occupancy depth has been set to its max.
+*   - Upon entry, the Rx Fifo is empty.
+*   - The 7 bit address has been sent.
+*   - The dynamic stop and number of bytes to receive has been written
to Tx
+*     Fifo.
+*
+* @param    BaseAddress contains the base address of the IIC Device.
+* @param    BufferPtr points to the buffer to hold the data that is
received.
+* @param    ByteCount is the number of bytes to be received. The range
of this
+*           value is greater than 0 and not higher than 255.
+*
+* @return   The number of bytes remaining to be received.
+*
+* @note     This function contains loops that could cause the function
not
+*           to return if the hardware is not working.
+*
+***********************************************************************
*******/
+static unsigned DynRecvData(u32 BaseAddress, u8 *BufferPtr, u8
ByteCount)
+{
+ 	u8 StatusReg;
+ 	u32 IntrStatus;
+ 	u32 IntrStatusMask;
+
+ 	while (ByteCount > 0) {
+
+ 		/* Setup the mask to use for checking errors because
when
+ 		 * receiving one byte OR the last byte of a multibyte
message
+ 		 * an error naturally occurs when the no ack is done to
tell
+ 		 * the slave the last byte.
+ 		 */
+ 		if (ByteCount =3D=3D 1) {
+ 			IntrStatusMask =3D
+ 				XIIC_INTR_ARB_LOST_MASK |
XIIC_INTR_BNB_MASK;
+ 		}
+ 		else {
+ 			IntrStatusMask =3D
+ 				XIIC_INTR_ARB_LOST_MASK |
+ 				XIIC_INTR_TX_ERROR_MASK |
XIIC_INTR_BNB_MASK;
+ 		}
+
+ 		/*
+ 		 * Wait for a byte to show up in the Rx Fifo.
+ 		 */
+ 		do {
+ 			StatusReg =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+ 			IntrStatus =3D XIIC_READ_IISR(BaseAddress);
+
+ 			/* Check the transmit error after the receive
full
+ 			 * because when sending only one byte transmit
error
+ 			 * will occur because of the no ack to indicate
the end
+ 			 *  of the data.
+ 			 */
+ 			if (IntrStatus & IntrStatusMask) {
+ 				return ByteCount;
+ 			}
+
+ 		} while ((StatusReg & XIIC_SR_RX_FIFO_EMPTY_MASK) =3D=3D
+ 			 		XIIC_SR_RX_FIFO_EMPTY_MASK);
+
+ 		/*
+ 		 * Read in byte from the Rx Fifo. If the Fifo reached
the
+ 		 * programmed occupancy depth as programmed in the Rx
occupancy
+ 		 * reg, this read access will un throttle the bus such
that
+ 		 * the next byte is read from the IIC bus.
+ 		 */
+ 		*BufferPtr++ =3D XIo_In8(BaseAddress +
XIIC_DRR_REG_OFFSET);
+ 		ByteCount--;
+ 	}
+
+	return ByteCount;
+}
+
+/**********************************************************************
*******/
+/**
+* Send data as a master on the IIC bus. This function sends the data
using
+* polled I/O and blocks until the data has been sent. It only supports
7 bit
+* addressing. The user is responsible for ensuring the bus is not busy
if
+* multiple masters are present on the bus.
+*
+* @param    BaseAddress contains the base address of the IIC Device.
+* @param    Address contains the 7 bit IIC address of the device to
send the
+*           specified data to.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent.
+* @param    Option: XIIC_STOP =3D end with STOP condition,
XIIC_REPEATED_START
+*           =3D don't end with STOP condition.
+*
+* @return   The number of bytes sent.
+*
+* @note     None.
+*
+***********************************************************************
*******/
+unsigned XIic_DynSend(u32 BaseAddress, u16 Address, u8 *BufferPtr,
+		      u8 ByteCount, u8 Option)
+{
+	unsigned RemainingByteCount;
+	u32 StatusRegister;
+
+	/*
+	 * Clear the latched interrupt status so that it will be updated
with
+	 * the new state when it changes, this must be done after the
address
+	 * is put in the FIFO
+	 */
+	XIic_mClearIisr(BaseAddress, XIIC_INTR_TX_EMPTY_MASK |
+			XIIC_INTR_TX_ERROR_MASK |
XIIC_INTR_ARB_LOST_MASK);
+
+	/*
+	 * Put the address into the Fifo to be sent and indicate that
the
+	 * operation to be performed on the bus is a write operation.
Upon
+	 * writing the address, a start condition is initiated. MSMS is
+	 * automatically set to master when the address is written to
the Fifo.
+	 * If MSMS was already set, then a re-start is sent prior to the
+	 *  address.
+	 */
+	if(!(Address & XIIC_TX_DYN_STOP_MASK))
+	{
+
+		XIic_mDynSend7BitAddress(BaseAddress, Address,
+		XIIC_WRITE_OPERATION);
+	}
+	else
+	{
+		XIic_mDynSendStartStopAddress(BaseAddress, Address,
+					XIIC_WRITE_OPERATION);
+    }
+
+	/*
+	 * Wait for the bus to go busy.
+	 */
+	StatusRegister =3D XIo_In8(BaseAddress + XIIC_SR_REG_OFFSET);
+
+	while (( StatusRegister & XIIC_SR_BUS_BUSY_MASK) !=3D
XIIC_SR_BUS_BUSY_MASK)
+	{
+		StatusRegister =3D XIo_In8(BaseAddress +
XIIC_SR_REG_OFFSET);
+	}
+
+	/*
+	 * Clear the latched interrupt status for the bus not busy bit
which
+	 * must be done while the bus is busy.
+	 */
+	XIic_mClearIisr(BaseAddress, XIIC_INTR_BNB_MASK);
+
+	/*
+	 * Send the specified data to the device on the IIC bus
specified by the
+	 * the address.
+	 */
+	RemainingByteCount =3D DynSendData(BaseAddress, BufferPtr,
ByteCount,
+					 Option);
+
+	/*
+	 * The send is complete return the number of bytes that was
sent.
+	 */
+	return ByteCount - RemainingByteCount;
+}
+
+/**********************************************************************
********
+*
+* Send the specified buffer to the device that has been previously
addressed
+* on the IIC bus. This function assumes that the 7 bit address has been
sent.
+*
+* @param    BaseAddress contains the base address of the IIC Device.
+* @param    BufferPtr points to the data to be sent.
+* @param    ByteCount is the number of bytes to be sent.
+* @param    Option: XIIC_STOP =3D end with STOP condition,
XIIC_REPEATED_START
+*           =3D don't end with STOP condition.
+*
+* @return   The number of bytes remaining to be sent.
+*
+* @note     This function does not take advantage of the transmit Fifo
because
+*           it is designed for minimal code space and complexity.
+*
+***********************************************************************
*******/
+static unsigned DynSendData(u32 BaseAddress, u8 *BufferPtr,
+			    u8 ByteCount, u8 Option)
+{
+	u32 IntrStatus;
+
+	while (ByteCount > 0) {
+		/*
+		 * Wait for the transmit to be empty before sending any
more
+		 * data by polling the interrupt status register.
+		 */
+		while (1) {
+			IntrStatus =3D XIIC_READ_IISR(BaseAddress);
+			if (IntrStatus & (XIIC_INTR_TX_ERROR_MASK |
+					  XIIC_INTR_ARB_LOST_MASK |
+					  XIIC_INTR_BNB_MASK)) {
+				/*
+				 * Error condition (NACK or ARB Lost or
BNB
+				 * Error Has occurred. Clear the Control
+				 * register to send a STOP condition on
the Bus
+				 * and return the number of bytes still
to
+				 * transmit.
+				 */
+
+				XIo_Out8(BaseAddress +
XIIC_CR_REG_OFFSET,
+					 0x03);
+				XIo_Out8(BaseAddress +
XIIC_CR_REG_OFFSET,
+					 0x01);
+
+				return ByteCount;
+			}
+
+			/*
+			 * Check for the transmit Fifo to become Empty.
+			 */
+			if (IntrStatus & XIIC_INTR_TX_EMPTY_MASK) {
+				break;
+			}
+		}
+
+		/*
+		 * Send data to Tx Fifo. If a stop condition is
specified and
+		 * the last byte is being sent, then set the dynamic
stop bit.
+		 */
+		if ((ByteCount =3D=3D 1) && (Option =3D=3D XIIC_STOP)) {
+			/*
+			 * The MSMS will be cleared automatically upon
setting
+			 *  dynamic stop.
+			 */
+			XIo_Out16(BaseAddress + XIIC_DTR_REG_OFFSET - 1,
+				  	XIIC_TX_DYN_STOP_MASK |
*BufferPtr++);
+		}
+		else {
+			XIo_Out8(BaseAddress + XIIC_DTR_REG_OFFSET,
+
*BufferPtr++);
+		}
+
+		/*
+		 * Update the byte count to reflect the byte sent.
+		 */
+		ByteCount--;
+	}
+
+	if (Option =3D=3D XIIC_STOP) {
+		/*
+		 * If the Option is to release the bus after
transmission of
+		 * data, Wait for the bus to transition to not busy
before
+		 * returning, the IIC device cannot be disabled until
this
+		 * occurs.
+		 */
+		while (1) {
+			if (XIIC_READ_IISR(BaseAddress) &
XIIC_INTR_BNB_MASK) {
+				break;
+			}
+		}
+	}
+
+	return ByteCount;
+}
+
+/**********************************************************************
********
+*
+* Initialize the IIC core for Dynamic Functionality.
+*
+* @param    BaseAddress contains the base address of the IIC Device.
+*
+* @return   XST_SUCCESS if Successful else XST_FAILURE.
+*
+* @note     None.
+*
+***********************************************************************
*******/
+int XIic_DynInit(u32 BaseAddress)
+{
+    u8 Status;
+
+	/*
+	 * Reset IIC Core.
+	 */
+	XIIC_RESET(BaseAddress);
+
+    /*
+     * Set receive Fifo depth to maximum (zero based).
+     */
+    XIo_Out8(BaseAddress + XIIC_RFD_REG_OFFSET, IIC_RX_FIFO_DEPTH - 1);
+
+    /*
+     * Reset Tx Fifo.
+     */
+    XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
XIIC_CR_TX_FIFO_RESET_MASK);
+
+    /*
+     * Enable IIC Device, remove Tx Fifo reset & disable general call.
+     */
+    XIo_Out8(BaseAddress + XIIC_CR_REG_OFFSET,
XIIC_CR_ENABLE_DEVICE_MASK);
+
+    /*
+     * Read status register and verify IIC Device is in initial state.
Only the
+     * Tx Fifo and Rx Fifo empty bits should be set.
+     */
+    Status =3D XIo_In8(BaseAddress + XIIC_SR_REG_OFFSET);
+    if(Status =3D=3D (XIIC_SR_RX_FIFO_EMPTY_MASK |
XIIC_SR_TX_FIFO_EMPTY_MASK))
+    {
+        return XST_SUCCESS;
+    }
+
+    return XST_FAILURE;
+}
+
diff --git a/drivers/net/xilinx_lltemac/xlltemac_main.c
b/drivers/net/xilinx_lltemac/xlltemac_main.c
index fb1ab28..11bcb48 100644
--- a/drivers/net/xilinx_lltemac/xlltemac_main.c
+++ b/drivers/net/xilinx_lltemac/xlltemac_main.c
@@ -623,27 +623,27 @@ int renegotiate_speed(struct net_device *dev, int
speed, DUPLEX duplex)
 	return -1;
 }
=20
-// #define XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
+#define MARVELL_88E1111_PHY
 /*
  * This function sets up MAC's speed according to link speed of PHY
- * This function is specific to MARVELL 88E1111 PHY chip on Xilinx
ML403
- * board and assumes GMII interface is being used by the TEMAC
+ * This function is specific to MARVELL 88E1111 PHY chip on many Xilinx

+ * boards and assumes GMII interface is being used by the TEMAC
  */
 void set_mac_speed(struct net_local *lp)
 {
 	u16 phylinkspeed;
 	struct net_device *dev =3D lp->ndev;
-	int ret;
=20
-#ifndef XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
+#ifndef MARVELL_88E1111_PHY
+	int ret;
 	int retry_count =3D 1;
 #endif
=20
 	/*
-	 * See comments at top for an explanation of
-	 * XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
+	 * See comments at top for an explanation of=20
+	 * #undef MARVELL_88E1111_PHY
 	 */
-#ifdef XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
+#ifdef MARVELL_88E1111_PHY
 #define MARVELL_88E1111_PHY_SPECIFIC_STATUS_REG_OFFSET  17
 #define MARVELL_88E1111_LINKSPEED_MARK                  0xC000
 #define MARVELL_88E1111_LINKSPEED_SHIFT                 14
@@ -687,7 +687,8 @@ void set_mac_speed(struct net_local *lp)
 		break;
 	}
=20
-#else
+#else	/* generic PHY, there have been issues with 10Mbit with this
code */
+
 	if (XLlTemac_GetPhysicalInterface(&lp->Emac) =3D=3D
XTE_PHY_TYPE_MII) {
 		phylinkspeed =3D 100;
 	}
@@ -881,6 +882,7 @@ static void poll_gmii(unsigned long data)
 	netif_carrier =3D netif_carrier_ok(dev) !=3D 0;
 	if (phy_carrier !=3D netif_carrier) {
 		if (phy_carrier) {
+			set_mac_speed(lp);
 			printk(KERN_INFO
 			       "%s: XLlTemac: PHY Link carrier
restored.\n",
 			       dev->name);
@@ -1015,7 +1017,7 @@ static irqreturn_t xenet_dma_rx_interrupt(int irq,
void *dev_id)
 	struct net_local *lp =3D (struct net_local *) dev->priv;
 	struct list_head *cur_lp;
=20
-        unsigned int flags;
+        unsigned long flags;
=20
 	/* Read pending interrupts */
 	irq_status =3D XLlDma_mBdRingGetIrq(&lp->Dma.RxBdRing);
@@ -1026,7 +1028,6 @@ static irqreturn_t xenet_dma_rx_interrupt(int irq,
void *dev_id)
 		XLlDma_Reset(&lp->Dma);
 		return IRQ_HANDLED;
 	}
-
 	if ((irq_status & (XLLDMA_IRQ_DELAY_MASK |
XLLDMA_IRQ_COALESCE_MASK))) {
 		spin_lock_irqsave(&receivedQueueSpin, flags);
 		list_for_each(cur_lp, &receivedQueue) {
@@ -1052,7 +1053,7 @@ static irqreturn_t xenet_dma_tx_interrupt(int irq,
void *dev_id)
 	struct net_local *lp =3D (struct net_local *) dev->priv;
 	struct list_head *cur_lp;
=20
-	unsigned int flags;
+	unsigned long flags;
=20
 	/* Read pending interrupts */
 	irq_status =3D XLlDma_mBdRingGetIrq(&(lp->Dma.TxBdRing));
@@ -1401,7 +1402,7 @@ static void FifoSendHandler(struct net_device
*dev)
 {
 	struct net_local *lp;
 	struct sk_buff *skb;
-	unsigned int flags;
+	unsigned long flags;
=20
 	spin_lock_irqsave(&XTE_tx_spinlock, flags);
 	lp =3D (struct net_local *) dev->priv;
@@ -2979,7 +2980,7 @@ static int detect_phy(struct net_local *lp, char
*dev_name)
 	printk(KERN_WARNING "XTemac: No PHY detected.  Assuming a PHY at
address 0\n");
 	return 0;		/* default to zero */
 }
-
+extern bd_t __res;
=20
 /** Shared device initialization code */
 static int xtenet_setup(
@@ -3047,8 +3048,10 @@ static int xtenet_setup(
 		goto error;
 	}
=20
-	/* Set the MAC address */
-	memcpy(ndev->dev_addr, pdata->mac_addr, 6);
+	/* Set the MAC address from the iic eeprom info in the board
data */
+        memcpy(ndev->dev_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
+        memcpy(pdata->mac_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
+
 	if (_XLlTemac_SetMacAddress(&lp->Emac, ndev->dev_addr) !=3D
XST_SUCCESS) {
 		/* should not fail right after an initialize */
 		dev_err(dev, "XLlTemac: could not set MAC address.\n");
@@ -3072,17 +3075,20 @@ static int xtenet_setup(
=20
 		dev_err(dev, "XLlTemac: using DMA mode.\n");
=20
-#ifndef XDCRIO_H
-		virt_baddr =3D (u32) ioremap(pdata->ll_dev_baseaddress,
4096);
-		if (0 =3D=3D virt_baddr) {
-			dev_err(dev,
-			       "XLlTemac: Could not allocate iomem for
local link connected device.\n");
-			rc =3D -EIO;
-			goto error;
+		if (pdata->dcr_host) {
+			printk("XLlTemac: DCR address: 0x%0x\n",
pdata->ll_dev_baseaddress);
+			XLlDma_Initialize(&lp->Dma,
pdata->ll_dev_baseaddress);
+		} else {
+		        virt_baddr =3D (u32)
ioremap(pdata->ll_dev_baseaddress, 4096);
+			if (0 =3D=3D virt_baddr) {
+			        dev_err(dev,
+					"XLlTemac: Could not allocate
iomem for local link connected device.\n");
+				rc =3D -EIO;
+				goto error;
+			}
+			printk("XLlTemac: Dma base address: phy: 0x%x,
virt: 0x%x\n", pdata->ll_dev_baseaddress, virt_baddr);
+			XLlDma_Initialize(&lp->Dma, virt_baddr);
 		}
-#endif
-		printk("XLlTemac: Dma base address: phy: 0x%x, virt:
0x%x\n", pdata->ll_dev_baseaddress, virt_baddr);
-		XLlDma_Initialize(&lp->Dma, virt_baddr);
=20
=20
 		ndev->hard_start_xmit =3D xenet_DmaSend;
--=20
1.5.2.1
