Message-ID: <3ECD5D27.7020302@mvista.com>
Date: Thu, 22 May 2003 16:28:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch to add KGDB support to gt64260 MPSC
Content-Type: multipart/mixed;
 boundary="------------040202050205050903010109"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040202050205050903010109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch that:

- Removes polled putc routine from arch/ppc/kernel/gt64260_common.c
- Creates arch/ppc/kernel/gt64260_dbg.c file that contains progress
routine and kgdb interface routine for gt64260 MPSC.
- Does some compiler warning cleanups on arch/ppc/kernel/gt64260_pic.c

Mark

--------------040202050205050903010109
Content-Type: text/plain;
 name="gt_dbg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gt_dbg.patch"

===== arch/ppc/kernel/gt64260_common.c 1.15 vs edited =====
--- 1.15/arch/ppc/kernel/gt64260_common.c	Tue Apr  1 12:43:14 2003
+++ edited/arch/ppc/kernel/gt64260_common.c	Tue May 13 13:44:09 2003
@@ -1819,68 +1819,5 @@
     	memcpy(gt64260_mac_addrs[port], mac_addr, 6);
 }

-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG)
-/*
- *****************************************************************************
- *
- *	Low-level MPSC/UART I/O routines
- *
- *****************************************************************************
- */
-
-/*
- * gt64260_putc()
- *
- * Dump a character out the MPSC port for gt64260_mpsc_progress
- * this assumes the baud rate has already been set up and the
- * MPSC initialized by the bootloader or firmware.
- */
-
-static inline void
-gt_putc(char c)
-{
-	mb();
-	gt_write(GT64260_MPSC_0_CHR_1, c);
-	mb();
-	gt_write(GT64260_MPSC_0_CHR_2, 0x200);
-	mb();
-
-	udelay(10000);
-}
-
-void
-puthex(unsigned long val)
-{
-
-        int i;
-
-        for (i = 7;  i >= 0;  i--) {
-		gt_putc("0123456789ABCDEF"[(val>>28) & 0x0f]);
-		val <<= 4;
-	}
-	gt_putc('\r');
-	gt_putc('\n');
-
-}
-
-void
-gt64260_mpsc_progress(char *s, unsigned short hex)
-{
-	/* spit stuff out the 64260 mpsc */
-
-	volatile char	c;
-	while ((c = *s++) != 0){
-		gt_putc(c);
-		if ( c == '\n' ) gt_putc('\r');
-	}
-	gt_putc('\n');
-	gt_putc('\r');
-
-	return;
-}
-
-#endif /* CONFIG_DEBUG_TEXT */
-
 EXPORT_SYMBOL(gt64260_set_base);
 EXPORT_SYMBOL(gt64260_get_base);
===== arch/ppc/kernel/gt64260_dbg.c 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/gt64260_dbg.c	Tue May  6 11:38:27 2003
+++ edited/arch/ppc/kernel/gt64260_dbg.c	Wed May 14 16:47:37 2003
@@ -0,0 +1,105 @@
+/*
+ * arch/ppc/kernel/gt64260_dbg.c
+ *
+ * KGDB and progress routines for the Marvell/Galileo GT64260 (Discovery).
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2003 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/*
+ *****************************************************************************
+ *
+ *	Low-level MPSC/UART I/O routines
+ *
+ *****************************************************************************
+ */
+
+
+#include <linux/config.h>
+#include <linux/irq.h>
+#include <asm/gt64260.h>
+
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+void
+gt64260_progress_init(void)
+{
+	if (ppc_md.early_serial_map) {
+		ppc_md.early_serial_map();
+	}
+	return;
+}
+
+void
+gt64260_mpsc_progress(char *s, unsigned short hex)
+{
+	volatile char	c;
+
+	gt_polled_putc(0, '\r');
+
+	while ((c = *s++) != 0){
+		gt_polled_putc(0, c);
+	}
+
+	gt_polled_putc(0, '\n');
+	gt_polled_putc(0, '\r');
+
+	return;
+}
+#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+
+
+#if defined(CONFIG_KGDB)
+
+#if defined(CONFIG_KGDB_TTYS0)
+#define KGDB_PORT 0
+#elif defined(CONFIG_KGDB_TTYS1)
+#define KGDB_PORT 1
+#else
+#error "Invalid kgdb_tty port"
+#endif
+
+void
+putDebugChar(unsigned char c)
+{
+	gt_polled_putc(KGDB_PORT, (char)c);
+}
+
+int
+getDebugChar(void)
+{
+	unsigned char	c;
+
+	while (!gt_polled_getc(KGDB_PORT, &c));
+	return (int)c;
+}
+
+void
+putDebugString(char* str)
+{
+	while (*str != '\0') {
+		putDebugChar(*str);
+		str++;
+	}
+	putDebugChar('\r');
+	return;
+}
+
+void
+kgdb_interruptible(int enable)
+{
+}
+
+void
+kgdb_map_scc(void)
+{
+	if (ppc_md.early_serial_map) {
+		ppc_md.early_serial_map();
+	}
+}
+#endif	/* CONFIG_KGDB */
===== arch/ppc/kernel/gt64260_pic.c 1.12 vs edited =====
--- 1.12/arch/ppc/kernel/gt64260_pic.c	Thu Mar 13 12:30:11 2003
+++ edited/arch/ppc/kernel/gt64260_pic.c	Tue May 13 16:10:23 2003
@@ -172,13 +172,13 @@
 #else /* !CONFIG_SMP */

 static inline void
-gt_write_intr_mask_lo()
+gt_write_intr_mask_lo(void)
 {
 	gt_write(gt64260_intr_mask_reg_offset[0][0], ppc_cached_irq_mask[0]);
 }

 static inline void
-gt_write_intr_mask_hi()
+gt_write_intr_mask_hi(void)
 {
 	gt_write(gt64260_intr_mask_reg_offset[0][1], ppc_cached_irq_mask[1]);
 }
@@ -362,7 +362,7 @@
  *  void
  */

-void
+static void
 gt64260_unmask_irq(unsigned int irq)
 {
 	irq -= gt64260_irq_base;
===== arch/ppc/kernel/Makefile 1.131 vs edited =====
--- 1.131/arch/ppc/kernel/Makefile	Fri May  2 12:05:40 2003
+++ edited/arch/ppc/kernel/Makefile	Tue May  6 18:04:28 2003
@@ -51,6 +51,10 @@
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
 endif
+ifeq ($(CONFIG_GT64260_CONSOLE),y)
+obj-$(CONFIG_KGDB)		+= gt64260_dbg.o
+obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gt64260_dbg.o
+endif
 ifeq ($(CONFIG_4xx),y)
 obj-$(CONFIG_4xx)		+= todc_time.o idle_4xx.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o ocp.o

--------------040202050205050903010109--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
