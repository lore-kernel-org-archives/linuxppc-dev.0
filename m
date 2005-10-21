Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 4797D68623
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 22:15:11 +1000 (EST)
Message-ID: <4358DBCD.8090709@ru.mvista.com>
Date: Fri, 21 Oct 2005 16:15:09 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Chris <chris@2net.co.uk>
References: <4358C4AC.2070900@2net.co.uk>
In-Reply-To: <4358C4AC.2070900@2net.co.uk>
Content-Type: multipart/mixed; boundary="------------010608060409070908050208"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: kgdb support in Linux 2.6 for 8xx
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
--------------010608060409070908050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
Chris wrote:
> Hi,
> 
> It would be nice to be able to do some kernel debugging on my TQM823L 
> board running 2.6 (2.6.13.1, to be exact). I have two questions
> 
> 1. Has anyone got kgdboe working in this configuration? If so, could you 
> give me a pointer to a patch?
> 
Not exactly. I have implemented support for KGDB on cpm_uart driven 
boards (most of 8xx use it), but it is only tested on 827x family. 
Anyway, 8xx should work with minimal changes.
> 2. kgdb over serial is lacking the getDebugChar and putDebugChar 
> functions that used to be in 8xx_io/uart.c. Has anyone done any work on 
> merging them into 2.6?
> 
There is a kgdb community project - http://kgdb.sf.net. The attached 
patch  is for this one (it has been submitted but not in the CVS so far).
> [OK, that's actually three questions. One just crept in]
> 
> Thanks in advance,
> Chris
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly

--------------010608060409070908050208
Content-Type: text/x-patch;
 name="cpm_uart_kgdb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_kgdb.patch"

This add support for KGDB using cpm_uart driver. 
Should work on all the boards utilizing it, tested on 8272ADS.

Index: linux-2.6.13.1/drivers/serial/cpm_uart/Makefile
===================================================================
--- linux-2.6.13.1.orig/drivers/serial/cpm_uart/Makefile
+++ linux-2.6.13.1/drivers/serial/cpm_uart/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SERIAL_CPM) += cpm_uart.o
 # Select the correct platform objects.
 cpm_uart-objs-$(CONFIG_CPM2)	+= cpm_uart_cpm2.o
 cpm_uart-objs-$(CONFIG_8xx)	+= cpm_uart_cpm1.o
+cpm_uart-objs-$(CONFIG_KGDB)	+= cpm_uart_kgdb.o
 
 cpm_uart-objs	:= cpm_uart_core.o $(cpm_uart-objs-y)
Index: linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart.h
===================================================================
--- linux-2.6.13.1.orig/drivers/serial/cpm_uart/cpm_uart.h
+++ linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart.h
@@ -42,6 +42,38 @@
 
 #define SCC_WAIT_CLOSING 100
 
+#ifdef CONFIG_KGDB
+
+/* Speed of the debug UART. */
+#if defined(CONFIG_KGDB_9600BAUD)
+#define KGDB_BAUD B9600
+#elif defined(CONFIG_KGDB_19200BAUD)
+#define KGDB_BAUD B19200
+#elif defined(CONFIG_KGDB_38400BAUD)
+#define KGDB_BAUD B38400
+#elif defined(CONFIG_KGDB_57600BAUD)
+#define KGDB_BAUD B57600
+#else
+#define KGDB_BAUD B115200	/* Start with this if not given */
+#endif
+
+#ifdef CONFIG_KGDB_CPM_UART_SCC1
+#define KGDB_PINFO_INDEX 	UART_SCC1
+#elif CONFIG_KGDB_CPM_UART_SCC2
+#define KGDB_PINFO_INDEX	UART_SCC2
+#elif CONFIG_KGDB_CPM_UART_SCC3
+#define KGDB_PINFO_INDEX	UART_SCC3
+#elif CONFIG_KGDB_CPM_UART_SCC4
+#define KGDB_PINFO_INDEX	UART_SCC4
+#elif CONFIG_KGDB_CPM_UART_SMC1
+#define KGDB_PINFO_INDEX	UART_SMC1
+#elif CONFIG_KGDB_CPM_UART_SMC2
+#define KGDB_PINFO_INDEX	UART_SMC2
+#error The S(M)CC for kgdb console is undefined
+#endif
+
+#endif /* CONFIG_KGDB */
+
 struct uart_cpm_port {
 	struct uart_port	port;
 	u16			rx_nrfifos;
@@ -77,6 +109,9 @@ extern int cpm_uart_port_map[UART_NR];
 extern int cpm_uart_nr;
 extern struct uart_cpm_port cpm_uart_ports[UART_NR];
 
+void cpm_uart_early_write(int index, const char *s, u_int count);
+int cpm_uart_early_setup(int index,int early);
+
 /* these are located in their respective files */
 void cpm_line_cr_cmd(int line, int cmd);
 int cpm_uart_init_portdesc(void);
@@ -90,4 +125,19 @@ void scc2_lineif(struct uart_cpm_port *p
 void scc3_lineif(struct uart_cpm_port *pinfo);
 void scc4_lineif(struct uart_cpm_port *pinfo);
 
+static inline unsigned long cpu2cpm_addr(void *addr)
+{
+	if ((unsigned long)addr >= CPM_ADDR)
+		return (unsigned long)addr;
+	return virt_to_bus(addr);
+}
+
+static inline void *cpm2cpu_addr(unsigned long addr)
+{
+	if (addr >= CPM_ADDR)
+		return (void *)addr;
+	return bus_to_virt(addr);
+}
+
+
 #endif /* CPM_UART_H */
Index: linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_core.c
===================================================================
--- linux-2.6.13.1.orig/drivers/serial/cpm_uart/cpm_uart_core.c
+++ linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -71,20 +71,6 @@ static void cpm_uart_initbd(struct uart_
 
 /**************************************************************/
 
-static inline unsigned long cpu2cpm_addr(void *addr)
-{
-	if ((unsigned long)addr >= CPM_ADDR)
-		return (unsigned long)addr;
-	return virt_to_bus(addr);
-}
-
-static inline void *cpm2cpu_addr(unsigned long addr)
-{
-	if (addr >= CPM_ADDR)
-		return (void *)addr;
-	return bus_to_virt(addr);
-}
-
 /*
  * Check, if transmit buffers are processed
 */
@@ -992,22 +978,17 @@ struct uart_cpm_port cpm_uart_ports[UART
 	},
 };
 
-#ifdef CONFIG_SERIAL_CPM_CONSOLE
-/*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
- *
- *	Note that this is called with interrupts already disabled
- */
-static void cpm_uart_console_write(struct console *co, const char *s,
+void cpm_uart_early_write(int index, const char *s,
 				   u_int count)
 {
-	struct uart_cpm_port *pinfo =
-	    &cpm_uart_ports[cpm_uart_port_map[co->index]];
+	struct uart_cpm_port *pinfo;
 	unsigned int i;
 	volatile cbd_t *bdp, *bdbase;
 	volatile unsigned char *cp;
 
+	BUG_ON(index>UART_NR);
+	pinfo = &cpm_uart_ports[index];
+
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->tx_cur;
@@ -1071,36 +1052,16 @@ static void cpm_uart_console_write(struc
 	pinfo->tx_cur = (volatile cbd_t *) bdp;
 }
 
-/*
- * Setup console. Be careful is called early !
- */
-static int __init cpm_uart_console_setup(struct console *co, char *options)
+int cpm_uart_early_setup(int index, int early)
 {
+	int ret;
 	struct uart_port *port;
 	struct uart_cpm_port *pinfo;
-	int baud = 38400;
-	int bits = 8;
-	int parity = 'n';
-	int flow = 'n';
-	int ret;
 
+	BUG_ON(index>UART_NR);
 	port =
-	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
+	    (struct uart_port *)&cpm_uart_ports[index];
 	pinfo = (struct uart_cpm_port *)port;
-
-	pinfo->flags |= FLAG_CONSOLE;
-
-	if (options) {
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	} else {
-		bd_t *bd = (bd_t *) __res;
-
-		if (bd->bi_baudrate)
-			baud = bd->bi_baudrate;
-		else
-			baud = 9600;
-	}
-
 	/*
 	 * Setup any port IO, connect any baud rate generators,
 	 * etc.  This is expected to be handled by board
@@ -1108,7 +1069,6 @@ static int __init cpm_uart_console_setup
 	 */
 	if (pinfo->set_lineif)
 		pinfo->set_lineif(pinfo);
-
 	if (IS_SMC(pinfo)) {
 		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
 		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
@@ -1116,8 +1076,7 @@ static int __init cpm_uart_console_setup
 		pinfo->sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
 		pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	}
-
-	ret = cpm_uart_allocbuf(pinfo, 1);
+	ret = cpm_uart_allocbuf(pinfo, early);
 
 	if (ret)
 		return ret;
@@ -1129,6 +1088,56 @@ static int __init cpm_uart_console_setup
 	else
 		cpm_uart_init_scc(pinfo);
 
+	return 0;
+}
+
+#ifdef CONFIG_SERIAL_CPM_CONSOLE
+/*
+ *	Print a string to the serial port trying not to disturb
+ *	any possible real use of the port...
+ *
+ *	Note that this is called with interrupts already disabled
+ */
+
+static void cpm_uart_console_write(struct console *co, const char *s,
+				   u_int count)
+{
+	cpm_uart_early_write(cpm_uart_port_map[co->index],s,count);
+}
+
+/*
+ * Setup console. Be careful is called early !
+ */
+static int __init cpm_uart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	struct uart_cpm_port *pinfo;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+
+	port =
+	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
+	pinfo = (struct uart_cpm_port *)port;
+
+	pinfo->flags |= FLAG_CONSOLE;
+
+	if (options) {
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	} else {
+		bd_t *bd = (bd_t *) __res;
+
+		if (bd->bi_baudrate)
+			baud = bd->bi_baudrate;
+		else
+			baud = 9600;
+	}
+
+	ret = cpm_uart_early_setup(cpm_uart_port_map[co->index], 1);
+	if(ret)
+		return ret;
 	uart_set_options(port, co, baud, parity, bits, flow);
 
 	return 0;
@@ -1190,6 +1199,10 @@ static int __init cpm_uart_init(void)
 
 	for (i = 0; i < cpm_uart_nr; i++) {
 		int con = cpm_uart_port_map[i];
+
+		/* We are not interested in ports yet utilized by kgdb */
+		if(con == KGDB_PINFO_INDEX)
+			continue;
 		cpm_uart_ports[con].port.line = i;
 		cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
 		uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
Index: linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_cpm2.c
===================================================================
--- linux-2.6.13.1.orig/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -252,6 +252,10 @@ int cpm_uart_init_portdesc(void)
 {
 	pr_debug("CPM uart[-]:init portdesc\n");
 
+	/* Check if we have called this yet. This may happen if early kgdb
+	breakpoint is on */
+	if(cpm_uart_nr)
+		return 0;
 	cpm_uart_nr = 0;
 #ifdef CONFIG_SERIAL_CPM_SMC1
 	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) & cpm2_immr->im_smc[0];
Index: linux-2.6.13.1/lib/Kconfig.debug
===================================================================
--- linux-2.6.13.1.orig/lib/Kconfig.debug
+++ linux-2.6.13.1/lib/Kconfig.debug
@@ -196,6 +196,7 @@ choice
 	default KGDB_8250_NOMODULE
 	default KGDB_SIBYTE if SIBYTE_SB1xxx_SOC
 	default KGDB_MPSC if SERIAL_MPSC
+	default KGDB_CPM_UART if (8xx || 8260)
 	help
 	  There are a number of different ways in which you can communicate
 	  with KGDB.  The most common is via serial, with the 8250 driver
@@ -221,6 +222,11 @@ config KGDB_8250_NOMODULE
 	  GDB.  This is independent of the normal (SERIAL_8250) driver
 	  for this chipset.
 
+config KGDB_CPM_UART
+ 	bool "KGDB: On CPM UART"
+ 	help
+ 	  Uses CPM UART to communicate with the host GDB.
+
 config KGDBOE_NOMODULE
 	bool "KGDB: On ethernet - in kernel"
 	select KGDBOE
@@ -247,6 +253,62 @@ config KGDB_SIBYTE
 
 endchoice
 
+choice
+ 	prompt "  SCC/SMC for KGDB console"
+ 	depends on KGDB_CPM_UART
+ 	default KGDB_CPM_UART_SCC4 if ADS8272
+
+config KGDB_CPM_UART_SCC1
+ 	bool "Use SCC1 for KGDB"
+ 	depends on SERIAL_CPM_SCC1
+
+config KGDB_CPM_UART_SCC2
+ 	bool "Use SCC2 for KGDB"
+ 	depends on SERIAL_CPM_SCC2
+
+config KGDB_CPM_UART_SCC3
+ 	bool "Use SCC3 for KGDB"
+ 	depends on SERIAL_CPM_SCC3
+
+config KGDB_CPM_UART_SCC4
+ 	bool "Use SCC4 for KGDB"
+ 	depends on SERIAL_CPM_SCC4
+
+config KGDB_CPM_UART_SMC1
+ 	bool "Use SMC1 for KGDB"
+ 	depends on SERIAL_CPM_SMC1
+
+config KGDB_CPM_UART_SMC2
+ 	bool "Use SMC2 for KGDB"
+ 	depends on SERIAL_CPM_SMC2
+
+endchoice
+
+choice
+	depends on KGDB && !KGDB_ETH
+    	prompt "Debug serial port BAUD"
+	default KGDB_115200BAUD
+	help
+	  gdb and the kernel stub need to agree on the baud rate to be
+	  used.  Standard rates from 9600 to 115200 are allowed, and this
+	  may be overridden via the commandline.
+
+config KGDB_9600BAUD
+	bool "9600"
+
+config KGDB_19200BAUD
+	bool "19200"
+
+config KGDB_38400BAUD
+	bool "38400"
+
+config KGDB_57600BAUD
+	bool "57600"
+
+config KGDB_115200BAUD
+	bool "115200"
+endchoice
+
 config KGDBOE
 	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
 	depends on m && KGDB_ONLY_MODULES
Index: linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_kgdb.c
===================================================================
--- /dev/null
+++ linux-2.6.13.1/drivers/serial/cpm_uart/cpm_uart_kgdb.c
@@ -0,0 +1,191 @@
+/*
+ * drivers/serial/cpm_uart/cpm_uart_kgdb.c
+ *
+ * CPM UART interface for kgdb.
+ *
+ * Author: Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Used some bits from drivers/serial/kgdb_8250.c as a template
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kgdb.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+#include <asm/io.h>
+#include <asm/serial.h>		/* For BASE_BAUD and SERIAL_PORT_DFNS */
+
+#include "cpm_uart.h"
+
+#define GDB_BUF_SIZE	512	/* power of 2, please */
+
+
+static char kgdb_buf[GDB_BUF_SIZE], *kgdbp;
+static int kgdb_chars;
+
+/* Forward declarations. */
+
+/*
+ * Receive character from the serial port.  This only works well
+ * before the port is initialize for real use.
+ */
+static int kgdb_wait_key(char *obuf)
+{
+	struct uart_cpm_port *pinfo;
+
+	u_char				c, *cp;
+	volatile	cbd_t		*bdp;
+	int				i;
+
+	pinfo = &cpm_uart_ports[KGDB_PINFO_INDEX];
+
+	/* Get the address of the host memory buffer.
+	 */
+	bdp = pinfo->rx_cur;
+	while (bdp->cbd_sc & BD_SC_EMPTY);
+
+	/* If the buffer address is in the CPM DPRAM, don't
+	 * convert it.
+	 */
+	cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+
+	if (obuf) {
+		i = c = bdp->cbd_datlen;
+		while (i-- > 0)
+		{
+			*obuf++ = *cp++;
+		}
+	} else {
+		c = *cp;
+	}
+	bdp->cbd_sc |= BD_SC_EMPTY;
+
+	if (bdp->cbd_sc & BD_SC_WRAP) {
+		bdp = pinfo->rx_bd_base;
+	} else {
+		bdp++;
+	}
+	pinfo->rx_cur = (cbd_t *)bdp;
+
+	return((int)c);
+}
+
+
+/*
+ * Wait until the interface can accept a char, then write it.
+ */
+static void
+kgdb_put_debug_char(int chr)
+{
+	static char ch[2];
+	ch[0]=(char)chr;
+	cpm_uart_early_write(KGDB_PINFO_INDEX, ch, 1);
+}
+
+
+/*
+ * Get a char if available, return -1 if nothing available.
+ * Empty the receive buffer first, then look at the interface hardware.
+ */
+static int
+kgdb_get_debug_char(void)
+{
+	if (kgdb_chars<=0) {
+		kgdb_chars = kgdb_wait_key(kgdb_buf);
+		kgdbp = kgdb_buf;
+	}
+	kgdb_chars--;
+
+	return (*kgdbp++);
+}
+
+static void termios_set_options(int index,
+		 int baud, int parity, int bits, int flow)
+{
+	struct termios termios;
+	struct uart_port *port;
+	struct uart_cpm_port *pinfo;
+
+	BUG_ON(index>UART_NR);
+
+	port =
+	    (struct uart_port *)&cpm_uart_ports[index];
+	pinfo = (struct uart_cpm_port *)port;
+
+	/*
+	 * Ensure that the serial console lock is initialised
+	 * early.
+	 */
+	spin_lock_init(&port->lock);
+
+	memset(&termios, 0, sizeof(struct termios));
+
+	termios.c_cflag = CREAD | HUPCL | CLOCAL;
+
+	termios.c_cflag |= baud;
+
+	if (bits == 7)
+		termios.c_cflag |= CS7;
+	else
+		termios.c_cflag |= CS8;
+
+	switch (parity) {
+	case 'o': case 'O':
+		termios.c_cflag |= PARODD;
+		/*fall through*/
+	case 'e': case 'E':
+		termios.c_cflag |= PARENB;
+		break;
+	}
+
+	if (flow == 'r')
+		termios.c_cflag |= CRTSCTS;
+
+	port->ops->set_termios(port, &termios, NULL);
+}
+
+/*
+ *  Returns:
+ *	0 on success, 1 on failure.
+ */
+static int kgdb_init(void)
+{
+	struct uart_port *port;
+	struct uart_cpm_port *pinfo;
+
+	int use_bootmem = 0; /* use dma by default */
+
+	if(!cpm_uart_nr)
+	{
+		use_bootmem = 1;
+		cpm_uart_init_portdesc();
+	}
+	port = (struct uart_port *)&cpm_uart_ports[KGDB_PINFO_INDEX];
+	pinfo = (struct uart_cpm_port *)port;
+
+	if (cpm_uart_early_setup(KGDB_PINFO_INDEX, use_bootmem))
+		return 1;
+
+	termios_set_options(KGDB_PINFO_INDEX, KGDB_BAUD,'n',8,'n');
+	pinfo->sccp->scc_sccm |= UART_SCCM_TX;
+	return 0;
+}
+
+
+struct kgdb_io kgdb_io_ops = {
+	.read_char = kgdb_get_debug_char,
+	.write_char = kgdb_put_debug_char,
+	.init = kgdb_init,
+};
+

--------------010608060409070908050208--
