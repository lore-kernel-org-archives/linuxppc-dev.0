Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A9FC367B64
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:36:19 +1000 (EST)
Message-ID: <44900005.70508@esd-electronics.com>
Date: Wed, 14 Jun 2006 14:24:37 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: fix CPCI405 board support
Content-Type: multipart/mixed; boundary="------------040405040000050205040604"
Cc: paulus@samba.org2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040405040000050205040604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch brings the CPCI405 board support up to date and fixes several 
outstanding issues:

      -add bios_fixup()
      -enable RTC only when CONFIG_GEN_RTC defined
      -corrected CompactPCI interrupt map
      -added cpci405_early_serial_map for correct UART clocking
      -removed unused code

Matthias

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>



--------------040405040000050205040604
Content-Type: text/plain;
 name="cpci405_uptodate_2006_06_14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpci405_uptodate_2006_06_14.patch"

Bring CPCI405 board support up to date
    -add bios_fixup()
    -enable RTC only when CONFIG_GEN_RTC defined
    -corrected CompactPCI interrupt map
    -added cpci405_early_serial_map for correct UART clocking
    -removed unused code

---
commit dc0ce6e05de6309219d9c97bcfdf7a632fcbc57b
tree b9265b8ec2935a5a8a8890a81f8bb2b381920bf3
parent 128e6ced247cda88f96fa9f2e4ba8b2c4a681560
author Matthias Fuchs <matthias.fuchs@esd-electronics.com> Wed, 14 Jun 2006 09:26:32 +0200
committer Matthias Fuchs <matthias.fuchs@esd-electronics.com> Wed, 14 Jun 2006 09:26:32 +0200

 arch/ppc/platforms/4xx/Kconfig   |    2 -
 arch/ppc/platforms/4xx/cpci405.c |  139 +++++++++++++++++++++++++++++++++++---
 arch/ppc/platforms/4xx/cpci405.h |   30 +++-----
 3 files changed, 140 insertions(+), 31 deletions(-)

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 174ddbc..293bd48 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -183,7 +183,7 @@ config IBM_EMAC4
 
 config BIOS_FIXUP
 	bool
-	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
+	depends on BUBINGA || EP405 || SYCAMORE || WALNUT || CPCI405
 	default y
 
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
diff --git a/arch/ppc/platforms/4xx/cpci405.c b/arch/ppc/platforms/4xx/cpci405.c
index 6571e39..42cb3f6 100644
--- a/arch/ppc/platforms/4xx/cpci405.c
+++ b/arch/ppc/platforms/4xx/cpci405.c
@@ -1,10 +1,12 @@
 /*
  * Board setup routines for the esd CPCI-405 cPCI Board.
  *
- * Author: Stefan Roese
- *         stefan.roese@esd-electronics.com
+ * Copyright 2001-2006 esd electronic system design - hannover germany
  *
- * Copyright 2001 esd electronic system design - hannover germany
+ * Authors: Matthias Fuchs
+ *          matthias.fuchs@esd-electronics.com
+ *          Stefan Roese
+ *          stefan.roese@esd-electronics.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -20,9 +22,17 @@ #include <asm/system.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/todc.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <asm/ocp.h>
+#include <asm/ibm_ocp_pci.h>
+#include <platforms/4xx/ibm405gp.h>
 
+#ifdef CONFIG_GEN_RTC
 void *cpci405_nvram;
+#endif
+
+extern bd_t __res;
 
 /*
  * Some IRQs unique to CPCI-405.
@@ -36,18 +46,69 @@ ppc405_map_irq(struct pci_dev *dev, unsi
 	 *      A       B       C       D
 	 */
 	{
-		{28,	28,	28,	28},	/* IDSEL 15 - cPCI slot 8 */
-		{29,	29,	29,	29},	/* IDSEL 16 - cPCI slot 7 */
-		{30,	30,	30,	30},	/* IDSEL 17 - cPCI slot 6 */
-		{27,	27,	27,	27},	/* IDSEL 18 - cPCI slot 5 */
-		{28,	28,	28,	28},	/* IDSEL 19 - cPCI slot 4 */
-		{29,	29,	29,	29},	/* IDSEL 20 - cPCI slot 3 */
-		{30,	30,	30,	30},	/* IDSEL 21 - cPCI slot 2 */
+		{28,	29,	30,	27},	/* IDSEL 15 - cPCI slot 8 */
+		{29,	30,	27,	28},	/* IDSEL 16 - cPCI slot 7 */
+		{30,	27,	28,	29},	/* IDSEL 17 - cPCI slot 6 */
+		{27,	28,	29,	30},	/* IDSEL 18 - cPCI slot 5 */
+		{28,	29,	30,	27},	/* IDSEL 19 - cPCI slot 4 */
+		{29,	30,	27,	28},	/* IDSEL 20 - cPCI slot 3 */
+		{30,	27,	28,	29},	/* IDSEL 21 - cPCI slot 2 */
         };
 	const long min_idsel = 15, max_idsel = 21, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 };
 
+/* The serial clock for the chip is an internal clock determined by
+ * different clock speeds/dividers.
+ * Calculate the proper input baud rate and setup the serial driver.
+ */
+static void __init
+cpci405_early_serial_map(void)
+{
+	u32 uart_div;
+	int uart_clock;
+	struct uart_port port;
+
+         /* Calculate the serial clock input frequency
+          *
+          * The uart clock is the cpu frequency (provided in the board info
+          * structure) divided by the external UART Divisor.
+          */
+	uart_div = ((mfdcr(DCRN_CHCR_BASE) & CHR0_UDIV) >> 1) + 1;
+	uart_clock = __res.bi_procfreq / uart_div;
+
+	/* Setup serial port access */
+	memset(&port, 0, sizeof(port));
+#if defined(CONFIG_UART0_TTYS0)
+	port.membase = (void*)UART0_IO_BASE;
+	port.irq = UART0_INT;
+#else
+	port.membase = (void*)UART1_IO_BASE;
+	port.irq = UART1_INT;
+#endif
+	port.uartclk = uart_clock;
+	port.regshift = 0;
+	port.iotype = UPIO_MEM;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+#if defined(CONFIG_UART0_TTYS0)
+	port.membase = (void*)UART1_IO_BASE;
+	port.irq = UART1_INT;
+#else
+	port.membase = (void*)UART0_IO_BASE;
+	port.irq = UART0_INT;
+#endif
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+}
+
 void __init
 cpci405_setup_arch(void)
 {
@@ -55,14 +116,68 @@ cpci405_setup_arch(void)
 
 	ibm_ocp_set_emac(0, 0);
 
-	TODC_INIT(TODC_TYPE_MK48T35, cpci405_nvram, cpci405_nvram, cpci405_nvram, 8);
+        cpci405_early_serial_map();
+
+#ifdef CONFIG_GEN_RTC
+	TODC_INIT(TODC_TYPE_MK48T35, 
+		  cpci405_nvram, cpci405_nvram, cpci405_nvram, 8);
+#endif
+}
+
+void __init
+bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
+{
+	unsigned int bar_response, bar;
+
+	/* Disable region first */
+	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
+	/* PLB starting addr, PCI: 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
+	/* PCI start addr, 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
+	/* 512MB range of PLB to PCI */
+	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
+	/* Enable no pre-fetch, enable region */
+	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
+						(PPC405_PCI_UPPER_MEM -
+						 PPC405_PCI_MEM_BASE)) | 0x01));
+
+	/* Disable region one */
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm1ms), 0x00000001);
+
+	/* Disable region two */
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
+	out_le32((void *) &(pcip->ptm2la), 0x00000000);
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+	}
 }
 
 void __init
 cpci405_map_io(void)
 {
 	ppc4xx_map_io();
+
+#ifdef CONFIG_GEN_RTC
 	cpci405_nvram = ioremap(CPCI405_NVRAM_PADDR, CPCI405_NVRAM_SIZE);
+#endif
 }
 
 void __init
@@ -74,9 +189,11 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.setup_arch = cpci405_setup_arch;
 	ppc_md.setup_io_mappings = cpci405_map_io;
 
+#ifdef CONFIG_GEN_RTC
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
 	ppc_md.get_rtc_time = todc_get_rtc_time;
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
+#endif
 }
diff --git a/arch/ppc/platforms/4xx/cpci405.h b/arch/ppc/platforms/4xx/cpci405.h
index e27f7cb..f5a5c0c 100644
--- a/arch/ppc/platforms/4xx/cpci405.h
+++ b/arch/ppc/platforms/4xx/cpci405.h
@@ -1,37 +1,29 @@
 /*
  * CPCI-405 board specific definitions
  *
- * Copyright (c) 2001 Stefan Roese (stefan.roese@esd-electronics.com)
+ * Copyright 2001-2006 esd electronic system design - hannover germany
+ *
+ * Authors: Matthias Fuchs
+ *          matthias.fuchs@esd-electronics.com
+ *          Stefan Roese
+ *          stefan.roese@esd-electronics.com
  */
 
 #ifdef __KERNEL__
-#ifndef __ASM_CPCI405_H__
-#define __ASM_CPCI405_H__
+#ifndef __CPCI405_H__
+#define __CPCI405_H__
 
 #include <linux/config.h>
-
-/* We have a 405GP core */
 #include <platforms/4xx/ibm405gp.h>
-
 #include <asm/ppcboot.h>
 
-#ifndef __ASSEMBLY__
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 /* Map for the NVRAM space */
 #define CPCI405_NVRAM_PADDR	((uint)0xf0200000)
 #define CPCI405_NVRAM_SIZE	((uint)32*1024)
 
-#ifdef CONFIG_PPC405GP_INTERNAL_CLOCK
-#define BASE_BAUD		201600
-#else
-#define BASE_BAUD		691200
-#endif
+#define BASE_BAUD		0
 
-#define PPC4xx_MACHINE_NAME "esd CPCI-405"
+#define PPC4xx_MACHINE_NAME     "esd CPCI-405"
 
-#endif /* !__ASSEMBLY__ */
-#endif	/* __ASM_CPCI405_H__ */
+#endif	/* __CPCI405_H__ */
 #endif /* __KERNEL__ */



--------------040405040000050205040604--
