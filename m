Message-ID: <3EDFBA42.3050306@mvista.com>
Date: Thu, 05 Jun 2003 14:46:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for arch/ppc/kernel/gen550_dbg.c
Content-Type: multipart/mixed;
 boundary="------------010002040706090100070505"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010002040706090100070505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch add in the check to see if the UART already appears to be
initialized that is in arch/ppc/boot/common/ns16550.c.

Please apply if there are no objections.

Mark
--

--------------010002040706090100070505
Content-Type: text/plain;
 name="gen550.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gen550.patch"

===== arch/ppc/kernel/gen550_dbg.c 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/gen550_dbg.c	Fri Apr 25 11:01:46 2003
+++ edited/arch/ppc/kernel/gen550_dbg.c	Wed Jun  4 17:17:12 2003
@@ -57,6 +57,7 @@
 unsigned long serial_init(int chan, void *ignored)
 {
 	unsigned long com_port;
+	unsigned char lcr, dlm;

 	/* We need to find out which type io we're expecting.  If it's
 	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
@@ -79,22 +80,38 @@

 	/* How far apart the registers are. */
 	shift = rs_table[chan].iomem_reg_shift;
+
+	/* save the LCR */
+	lcr = serial_inb(com_port + (UART_LCR << shift));

 	/* Access baud rate */
-	serial_outb(com_port + (UART_LCR << shift), 0x80);
+	serial_outb(com_port + (UART_LCR << shift), UART_LCR_DLAB);
+	dlm = serial_inb(com_port + (UART_DLM << shift));

-	/* Input clock. */
-	serial_outb(com_port + (UART_DLL << shift),
+	/*
+	 * Test if serial port is unconfigured
+	 * We assume that no-one uses less than 110 baud or
+	 * less than 7 bits per character these days.
+	 *  -- paulus.
+	 */
+	if ((dlm <= 4) && (lcr & 2)) {
+		/* port is configured, put the old LCR back */
+		serial_outb(com_port + (UART_LCR << shift), lcr);
+	}
+	else {
+		/* Input clock. */
+		serial_outb(com_port + (UART_DLL << shift),
 			(rs_table[chan].baud_base / SERIAL_BAUD) & 0xFF);
-	serial_outb(com_port + (UART_DLM << shift),
-			(rs_table[chan].baud_base / SERIAL_BAUD) >> 8);
-	/* 8 data, 1 stop, no parity */
-	serial_outb(com_port + (UART_LCR << shift), 0x03);
-	/* RTS/DTR */
-	serial_outb(com_port + (UART_MCR << shift), 0x03);
+		serial_outb(com_port + (UART_DLM << shift),
+				(rs_table[chan].baud_base / SERIAL_BAUD) >> 8);
+		/* 8 data, 1 stop, no parity */
+		serial_outb(com_port + (UART_LCR << shift), 0x03);
+		/* RTS/DTR */
+		serial_outb(com_port + (UART_MCR << shift), 0x03);

-	/* Clear & enable FIFOs */
-	serial_outb(com_port + (UART_FCR << shift), 0x07);
+		/* Clear & enable FIFOs */
+		serial_outb(com_port + (UART_FCR << shift), 0x07);
+	}

 	return (com_port);
 }

--------------010002040706090100070505--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
