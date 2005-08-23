Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id AEC2B68094
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 08:11:13 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so947071nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:11:10 -0700 (PDT)
Date: Tue, 23 Aug 2005 16:07:35 -0600
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050823220735.GB1000@siegfried.thelikelysolution.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Grant Likely <glikely@gmail.com>
Subject: [PATCH] Allow ns16550.c to get base baud from rs_table instead of
	BAUD_BASE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Modifies serial_init to get base baud rate from the rs_table entry instead
of BAUD_BASE.  Will default back to BAUD_BASE if base_baud is not set.

This patch eliminates duplication between the SERIAL_PORT_DFNS macro and
BAUD_BASE.  Without the patch, if a port set the baud rate in
SERIAL_PORT_DFNS, but did not update BASE_BAUD, the BASE_BAUD value
would still be used.

Rather; serial_init() should look first in SERIAL_PORT_DFNS and use
BASE_BAUD as a backup.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>
---

 arch/ppc/boot/common/ns16550.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

8ef971164affa27492e0f4abe73baf9b438575db
diff --git a/arch/ppc/boot/common/ns16550.c b/arch/ppc/boot/common/ns16550.c
--- a/arch/ppc/boot/common/ns16550.c
+++ b/arch/ppc/boot/common/ns16550.c
@@ -25,6 +25,7 @@ unsigned long serial_init(int chan, void
 {
 |------unsigned long com_port;
 |------unsigned char lcr, dlm;
+|------unsigned long baud_base;

 |------/* We need to find out which type io we're expecting.  If it's
 |------ * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
@@ -43,6 +44,12 @@ unsigned long serial_init(int chan, void

 |------/* How far apart the registers are. */
 |------shift = rs_table[chan].iomem_reg_shift;
+|------baud_base = rs_table[chan].baud_base;
+#if defined(BASE_BAUD)
+|------if (!baud_base)
+|------|-------baud_base = BASE_BAUD;
+#endif
+
 |------
 |------/* save the LCR */
 |------lcr = inb(com_port + (UART_LCR << shift));
@@ -62,9 +69,9 @@ unsigned long serial_init(int chan, void
 |------else {
 |------|-------/* Input clock. */
 |------|-------outb(com_port + (UART_DLL << shift),
-|------|-------     (BASE_BAUD / SERIAL_BAUD) & 0xFF);
+|------|-------     (baud_base / SERIAL_BAUD) & 0xFF);
 |------|-------outb(com_port + (UART_DLM << shift),
-|------|-------     (BASE_BAUD / SERIAL_BAUD) >> 8);
+|------|-------     (baud_base / SERIAL_BAUD) >> 8);
 |------|-------/* 8 data, 1 stop, no parity */
 |------|-------outb(com_port + (UART_LCR << shift), 0x03);
 |------|-------/* RTS/DTR */
