Message-ID: <3ECD5C96.60306@mvista.com>
Date: Thu, 22 May 2003 16:26:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for gt64260_mpsc
Content-Type: multipart/mixed;
 boundary="------------060507040107070705020803"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060507040107070705020803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch that:

- Adds early initialization of MPSC for kgdb and progress.
- Creates polled getc routine for kgdb.
- Creates polled getc routine for kgdb and progress (previously in
arch/ppc/kernel/gt64260_common.c).
- Adds MAGIC_SYSRQ support.

Mark

--------------060507040107070705020803
Content-Type: text/plain;
 name="gt_mpsc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gt_mpsc.patch"

===== drivers/char/Config.in 1.51 vs edited =====
--- 1.51/drivers/char/Config.in	Fri May  9 12:54:39 2003
+++ edited/drivers/char/Config.in	Thu May 15 10:20:49 2003
@@ -54,9 +54,6 @@
 	 bool '    MPSC Console support' CONFIG_GT64260_CONSOLE
 	 if [ "$CONFIG_GT64260_CONSOLE" = "y" ]; then
 	    define_bool CONFIG_SERIAL_CONSOLE y
-	    choice 'Default console port' \
-	       "MPSC0		CONFIG_GT64260_CONSOLE_0 \
-		MPSC1		CONFIG_GT64260_CONSOLE_1" MPSC0
 	    if [ "$CONFIG_USE_PPCBOOT" != "y" ]; then
 	       int 'Serial Console Baudrate' CONFIG_SERIAL_CONSOLE_BAUD 115200
 	    fi
===== drivers/char/gt64260_mpsc.c 1.3 vs edited =====
--- 1.3/drivers/char/gt64260_mpsc.c	Tue Jan 14 09:25:33 2003
+++ edited/drivers/char/gt64260_mpsc.c	Thu May 22 11:52:58 2003
@@ -39,6 +39,9 @@
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/circ_buf.h>
+#ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/sysrq.h>
+#endif

 #ifdef CONFIG_GT64260_CONSOLE
 # include <linux/console.h>
@@ -91,9 +94,6 @@
 # endif
 #endif

-/* I bet you can figure this one out */
-#define SDMA_IRQ 36
-
 #ifdef CONFIG_DEVFS_FS
 # define GT_MPSC_DEVNAME "tts/%d"
 # define GT_MPSC_AUXNAME "cua/%d"
@@ -246,6 +246,9 @@

 #ifdef CONFIG_GT64260_CONSOLE
 extern struct console sercons;
+#if defined(CONFIG_MAGIC_SYSRQ)
+static unsigned long break_pressed; /* break, really ... */
+#endif
 #endif

 #ifdef	CONFIG_USE_PPCBOOT
@@ -937,7 +940,7 @@
 }

 static void
-rx_interrupt(struct mpsc_port *info)
+rx_interrupt(struct mpsc_port *info, struct pt_regs *regs)
 {
 	volatile rxd_t *rxd = &info->rx_ring[info->rx_current];
 	struct async_icount *icount = &info->icount;
@@ -974,20 +977,14 @@
 		if (cnt > info->rx_hiwater)
 			info->rx_hiwater = cnt;

-		if (sts & STS_BR) {
-			icount->brk++;
-			tty_insert_flip_char(tty, 0, TTY_BREAK);
-			tty_schedule_flip(tty);
-			return;
-		}
-
 		/* if there is nowhere to put the data, discard it */
 		if (tty == 0)
 			continue;

 		/* RX anomoly -- galileo bug! */
-		if (!cnt)
+		if ((cnt == 0) && !(sts & STS_BR)) {
 			continue;
+		}

 		/* Make sure there is enough room to store the chars */
 		/* which is more important? clearning out the rx ring or
@@ -1006,28 +1003,54 @@

 		if (tty->flip.count < TTY_FLIPBUF_SIZE) {
 			int count = min_t(int, cnt, TTY_FLIPBUF_SIZE - tty->flip.count);
-
 			memcpy(tty->flip.char_buf_ptr, pp, count);
 			memset(tty->flip.flag_buf_ptr, TTY_NORMAL, count);

 			tty->flip.count += count;
 			tty->flip.char_buf_ptr += count;
+			tty->flip.flag_buf_ptr += count;

-			/* Allow for possible error flag below */
-			tty->flip.flag_buf_ptr += count - 1;
-
-			if (sts & STS_PE) {
-				icount->parity++;
-				*tty->flip.flag_buf_ptr = TTY_PARITY;
-			} else if (sts & STS_FR) {
-				icount->frame++;
-				*tty->flip.flag_buf_ptr = TTY_FRAME;
-			} else if (sts & STS_OR) {
-				*tty->flip.flag_buf_ptr = TTY_OVERRUN;
-				icount->overrun++;
+			if (sts & (STS_BR | STS_PE | STS_FR | STS_OR)) {
+				if (sts & STS_BR) {
+					icount->brk++;
+#if defined(CONFIG_GT64260_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+					if (info->line == sercons.index) {
+						if (!break_pressed) {
+							break_pressed = jiffies;
+							goto ignore_char;
+						}
+						break_pressed = 0;
+					}
+#endif
+					tty_insert_flip_char(tty, 0, TTY_BREAK);
+				}
+				else if (sts & STS_PE) {
+					icount->parity++;
+					*tty->flip.flag_buf_ptr = TTY_PARITY;
+				}
+				else if (sts & STS_FR) {
+					icount->frame++;
+					*tty->flip.flag_buf_ptr = TTY_FRAME;
+				}
+				else if (sts & STS_OR) {
+					*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+					icount->overrun++;
+				}
 			}
-
-			tty->flip.flag_buf_ptr++;
+#if defined(CONFIG_GT64260_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+			if (break_pressed && info->line == sercons.index) {
+				if (*pp != 0 &&
+				    time_before(jiffies, break_pressed + HZ*5)){
+					handle_sysrq(*pp,regs,NULL,NULL);
+					tty->flip.count -= 1;
+					tty->flip.flag_buf_ptr -= 1;
+					tty->flip.char_buf_ptr -= 1;
+					break_pressed = 0;
+					goto ignore_char;
+				}
+				break_pressed = 0;
+			}
+#endif
 			tty_flip_buffer_push(tty);

 			/* Oops.. lost some chars */
@@ -1039,7 +1062,9 @@
 			icount->buf_overrun++;
 			printk("gt64260_mpsc: buffer overrun\n");
 		}
-
+#if defined(CONFIG_GT64260_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+ignore_char:
+#endif
 		/* Advance to next descriptor */
 		rxd = &info->rx_ring[info->rx_current];
 		INVALIDATE_DCACHE((u32)rxd, (u32)(rxd+1));
@@ -1051,6 +1076,65 @@
 		galsdma_enable_rx(info->line);
 }

+#if	defined(CONFIG_GT64260_CONSOLE) && defined(CONFIG_KGDB)
+int
+gt_polled_getc(int chan, unsigned char *c)
+{
+	struct mpsc_port	*info = &mpsc_ports[chan];
+	volatile rxd_t		*rxd;
+	unsigned long		sts;
+	int			rc;
+	static unsigned char	*pp = NULL;
+	static unsigned int	cnt = 0;
+
+	rxd = &info->rx_ring[info->rx_current];
+
+	/* Start of nex rxd */
+	if (cnt == 0) {
+		INVALIDATE_DCACHE((u32)rxd, (u32)(rxd+1));
+
+		/* If no char, return 0 */
+		if (rxd->cmd_sts & STS_OWN) {
+			return 0;
+		}
+
+		sts = rxd->cmd_sts;
+		cnt = rxd->bytecnt;
+
+		if (sts & STS_BR) {	/* BREAK */
+			return 0;	/* XXXX */
+		}
+
+		/* RX anomoly -- galileo bug! */
+		if (cnt > 0) {
+			pp = phys_to_virt((u32) rxd->buf_ptr);
+			INVALIDATE_DCACHE((u32)pp, (u32)(pp+RX_BUF_SIZE));
+		}
+	}
+
+	/* Get data from rxd, if any */
+	if (cnt > 0) {
+		*c = (char)*pp;
+		pp++;
+		cnt--;
+		rc = 1;
+	}
+	else {
+		rc = 0;
+	}
+
+	/* No data left in this rxd, move to next one */
+	if (cnt == 0) {
+		rxd->cmd_sts = STS_OWN | STS_EI | STS_LAST | STS_FIRST;
+		rxd->bytecnt = 0;
+		CLEAN_DCACHE((u32)rxd, (u32)(rxd+1));
+		info->rx_current = (info->rx_current + 1) % NUM_RX_DESC;
+	}
+
+	return rc;
+}
+#endif
+
 static void
 gt_sdma_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
@@ -1063,7 +1147,7 @@
 		if (! (info->flags & ASYNC_INITIALIZED))
 			continue;

-		rx_interrupt(info);
+		rx_interrupt(info, fp);
 		tx_interrupt(info);
 	}
 }
@@ -1184,14 +1268,20 @@
 static void
 setup_once(void)
 {
-        /* Write-only register cache hack */
-	memset(&mh, 0, sizeof(mh));
-	mh.GT64260_MPSC_MRR_M=0x3fffffff;
-
-	/* Setup the mpsc port state structure */
-	memset(&mpsc_ports, 0, sizeof(struct mpsc_port) * NR_PORTS);
-	mpsc_ports[0].line = 0;
-	mpsc_ports[1].line = 1;
+	static char	first_time = 1;
+
+	if (first_time) {
+		/* Write-only register cache hack */
+		memset(&mh, 0, sizeof(mh));
+		mh.GT64260_MPSC_MRR_M=0x3ffffe38;
+
+		/* Setup the mpsc port state structure */
+		memset(&mpsc_ports, 0, sizeof(struct mpsc_port) * NR_PORTS);
+		mpsc_ports[0].line = 0;
+		mpsc_ports[1].line = 1;
+
+		first_time = 0;
+	}
 }


@@ -1401,19 +1491,25 @@
 	return atomic_read(&info->tx_len);
 }

+/* Can't really poll b/c of erratum on GT64260A MPSC so must delay instead */
+void
+gt_polled_putc(int chan, char c)
+{
+	/* use TCS to send high priority chars */
+	gt_write(GT64260_MPSC_0_CHR_1 + (chan * GALMPSC_REG_GAP), c);
+	mb();
+	gt_write(GT64260_MPSC_0_CHR_2 + (chan * GALMPSC_REG_GAP), 0x200);
+	mb();
+	udelay(10000);
+}
+
 static void
 gt_tty_send_xchar(struct tty_struct *tty, char ch)
 {
 	struct mpsc_port *info = &mpsc_ports[0];

 	if (tty) info = (struct mpsc_port *)tty->driver_data;
-
-	/* use TCS to send high priority chars */
-	gt_write(GT64260_MPSC_0_CHR_1+(info->line*GALMPSC_REG_GAP), ch);
-	mb();
-	gt_write(GT64260_MPSC_0_CHR_2+(info->line*GALMPSC_REG_GAP), 0x200);
-	mb();
-	udelay(10000);
+	gt_polled_putc(info->line, ch);
 }

 static void
@@ -1526,10 +1622,11 @@
 	if (sercons.cflag && sercons.index == line) {
 		tty->termios->c_cflag = sercons.cflag;
 		sercons.cflag = 0;
-		gt_set_cflag(info->line, tty->termios->c_cflag);
 	}
 #endif

+	gt_set_cflag(info->line, tty->termios->c_cflag);
+
 	info->session = current->session;
 	info->pgrp = current->pgrp;

@@ -1540,6 +1637,31 @@
 	return 0;
 }

+
+#if	defined(CONFIG_GT64260_CONSOLE) && defined(CONFIG_KGDB)
+void
+gt_early_mpsc_init(int chan, unsigned short cflag)
+{
+	struct mpsc_port *info = &mpsc_ports[chan];
+
+	setup_once();
+
+	/* Start up serial port */
+	ll_mpsc_init(info->line);
+	setup_dma(info);
+
+	/* clear and enable interrupt */
+	galsdma_intr_ack();
+
+	/* start receiver and go to 'hunt mode' */
+	galsdma_enable_rx(info->line);
+
+	gt_set_cflag(info->line, cflag);
+
+	return;
+}
+#endif
+
 static void
 gt_tty_close(struct tty_struct *tty, struct file *filp)
 {
@@ -1649,7 +1771,7 @@
 	serial_driver.type = TTY_DRIVER_TYPE_SERIAL;
 	serial_driver.subtype = SERIAL_TYPE_NORMAL;
 	serial_driver.init_termios = tty_std_termios;
-	serial_driver.init_termios.c_cflag = B38400 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	serial_driver.flags = TTY_DRIVER_REAL_RAW;
 	serial_driver.refcount = &gt_refcount;
 	serial_driver.table = gt_table;
@@ -1684,7 +1806,7 @@
 	galsdma_intr_mask(0, 0xf);
 	galsdma_intr_mask(1, 0xf);

-	retval = request_irq(SDMA_IRQ, gt_sdma_interrupt, 0, "GT64260 Serial DMA", 0);
+	retval = request_irq(GT64260_SDMA_IRQ, gt_sdma_interrupt, 0, "GT64260 Serial DMA", 0);
 	if (retval){
 		printk(KERN_ERR "Could't get GT64260 SDMA IRQ");
 		if ( ppc_md.progress ) ppc_md.progress("Could't get GT64260 SDMA IRQ", 0x0);
@@ -1710,7 +1832,7 @@
 	if (tmp_buf)
 		free_page((u32) tmp_buf);

-	free_irq(SDMA_IRQ, NULL);
+	free_irq(GT64260_SDMA_IRQ, NULL);
 	restore_flags(flags);
 }

@@ -1734,7 +1856,7 @@
 static int __init
 gt_console_setup(struct console *co, char *options)
 {
-	int baud = 38400;
+	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int cflag = CREAD | HUPCL | CLOCAL;
@@ -1889,7 +2011,7 @@
 	unblank:	gt_console_unblank,
 	setup:		gt_console_setup,
 	flags:		CON_PRINTBUFFER,
-	index:		CONFIG_SERIAL_CONSOLE_PORT,
+	index:		-1,
 };

 int
@@ -1903,5 +2025,3 @@
 	return 0;
 }
 #endif /* CONFIG_GT64260_CONSOLE */
-
-
===== include/asm-ppc/gt64260.h 1.16 vs edited =====
--- 1.16/include/asm-ppc/gt64260.h	Tue Apr  1 12:43:14 2003
+++ edited/include/asm-ppc/gt64260.h	Thu May 22 14:57:14 2003
@@ -350,6 +350,7 @@
 void gt64260_init_irq(void);
 int gt64260_get_irq(struct pt_regs *regs);

+void gt64260_progress_init(void);
 void gt64260_mpsc_progress(char *s, unsigned short hex);

 void gt64260_set_intr_mask_reg_offsets(int cpu,
@@ -357,5 +358,10 @@
 					u32 hi_reg_offset);

 void gt64260_set_mac_addr(int selector, unsigned char *mac_addr);
+
+void gt_early_mpsc_init(int chan, unsigned short cflag);
+void gt_polled_putc(int chan, char c);
+int gt_polled_getc(int chan, unsigned char *c);
+

 #endif /* __ASMPPC_GT64260_H */

--------------060507040107070705020803--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
