Date: Thu, 11 Apr 2002 13:00:53 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] early serial init
Message-ID: <Pine.LNX.4.30.0204111259350.23686-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is a patch to setup the serial ports early. It works fine on our
walnut boards.

--- arch/ppc/platforms/walnut.c.orig	Thu Apr 11 12:55:55 2002
+++ arch/ppc/platforms/walnut.c	Thu Apr 11 12:58:35 2002
@@ -31,6 +31,7 @@
 #include <linux/blk.h>
 #include <linux/pci.h>
 #include <linux/rtc.h>
+#include <linux/serial.h>

 #include <asm/system.h>
 #include <asm/pci-bridge.h>
@@ -247,6 +248,11 @@
 void __init
 board_init(void)
 {
+	struct serial_struct serial_req;
+	bd_t *bip = (bd_t *) __res;
+	u32 chrcr;
+	int div;
+	ulong bb;
 #ifdef CONFIG_PPC_RTC
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
@@ -254,4 +260,40 @@
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 #endif
+	chrcr = mfdcr(DCRN_CHCR0);
+	div = ((chrcr&0x3e)>>1)+1;
+	div *= 16;
+	bb = bip->bi_intfreq/div;
+
+	if( !(chrcr & CHR0_U0EC) ){
+		memset(&serial_req, 0, sizeof(serial_req));
+		serial_req.line       = 0;
+		serial_req.baud_base  = bb;
+		serial_req.port       = 0;
+		serial_req.irq        = UART0_INT;
+		serial_req.flags      = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+		serial_req.io_type    = SERIAL_IO_MEM;
+		serial_req.iomem_base = (u8 *)UART0_IO_BASE;
+		serial_req.iomem_reg_shift = 0;
+
+		if (early_serial_setup(&serial_req) != 0) {
+			printk("Early serial init of port 0 failed\n");
+		}
+	}
+
+	if( !(chrcr & CHR0_U1EC) ){
+		memset(&serial_req, 0, sizeof(serial_req));
+		serial_req.line       = 1;
+		serial_req.baud_base  = bb;
+		serial_req.port       = 1;
+		serial_req.irq        = UART1_INT;
+		serial_req.flags      = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+		serial_req.io_type    = SERIAL_IO_MEM;
+		serial_req.iomem_base = (u8 *)UART1_IO_BASE;
+		serial_req.iomem_reg_shift = 0;
+
+		if (early_serial_setup(&serial_req) != 0) {
+			printk("Early serial init of port 1 failed\n");
+		}
+	}
 }


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
