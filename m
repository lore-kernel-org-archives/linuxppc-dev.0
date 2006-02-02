Return-Path: <frank.bodammer@hs.gcd-erlangen.de>
Received: from mail.gcd-erlangen.de (mail3.gcd-erlangen.de [62.138.55.136])
	by ozlabs.org (Postfix) with ESMTP id A0FA868A53
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 05:43:28 +1100 (EST)
Received: from [192.168.200.88] (unknown [217.64.173.97])
	by mail.gcd-erlangen.de (Postfix) with ESMTP id 0F56C4BD2CF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 19:22:48 +0100 (CET)
Message-ID: <43E24DF7.5010304@hs.gcd-erlangen.de>
Date: Thu, 02 Feb 2006 19:22:47 +0100
From: Frank Bodammer <frank.bodammer@hs.gcd-erlangen.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: AW: MPC5200,PSC in uart mode, receiving problem
References: <002001c5ce3b$3972bbe0$34f1ff0a@beint.local>
In-Reply-To: <002001c5ce3b$3972bbe0$34f1ff0a@beint.local>
Content-Type: multipart/mixed; boundary="------------090904010104010909080606"
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
--------------090904010104010909080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Achim Machura wrote:
> Here the patch
>  
> 
>>Even better, post a patch here on the list so we all can benefit.

I experienced similar problems with the serial ports on mpc5200 PSCs
and so i was happy to find your patch, which solved some problem, but
not all. The overrun flag still wasn´t reset after an input overrun
error, so this error was reported persistent for each received character.
I fixed this by adding an command to reset the psc error flags in
receive_char() where the overrun flag is checked. Maybe this isn't
the best solution, but it seems to work.

To reset the overrun error flag, i tried the following statement:

	out_8(&psc->command, MPC5xxx_PSC_RST_ERR_STAT);

but i got unpredictable behaviour in some cases ending in a reset.
Doing the same this way:

	psc->command = MPC5xxx_PSC_RST_ERR_STAT;

always worked as expected. Does someone know what may be wrong with
'out_8' on mpc5200 with kernel 2.4.25 or is that a configuration problem.

By the way, i improved some other parts of the code, especially the
/proc output and the portconfig stuff, so i also attach a patch here,
even not all of it may be useful.

Frank

--------------090904010104010909080606
Content-Type: text/plain;
 name="patch_linuxppc_2_4_psc-060202.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_linuxppc_2_4_psc-060202.diff"

--- psc-orig.c	2006-02-02 10:41:45.000000000 +0100
+++ psc.c	2006-02-02 17:30:59.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/generic_serial.h>
+#include <linux/proc_fs.h>
 #ifdef CONFIG_UBOOT
 #include <asm/ppcboot.h>
 #endif
@@ -37,7 +38,8 @@
  * This driver can spew a whole lot of debugging output at you. If you
  * need maximum performance, you should disable the DEBUG define.
  */
-#undef MPC5xxx_PSC_DEBUG 
+#undef MPC5xxx_PSC_DEBUG
+//#define MPC5xxx_PSC_DEBUG		1
 
 #ifdef MPC5xxx_PSC_DEBUG
 #define MPC5xxx_PSC_DEBUG_OPEN		0x00000001
@@ -55,6 +57,7 @@
 #define MPC5xxx_PSC_DEBUG_FIRMWARE	0x00001000
 #define MPC5xxx_PSC_DEBUG_MEMTEST	0x00002000
 #define MPC5xxx_PSC_DEBUG_THROTTLE	0x00004000
+#define MPC5xxx_PSC_DEBUG_CLEARERR	0x00008000
 #define MPC5xxx_PSC_DEBUG_ALL		0xffffffff
 
 int rs_debug = MPC5xxx_PSC_DEBUG_ALL & ~MPC5xxx_PSC_DEBUG_TRANSMIT;
@@ -73,7 +76,7 @@
 /*
  * Number of serial ports
  */
-#define MPC5xxx_PSC_NPORTS	3
+#define MPC5xxx_PSC_NPORTS	4
 
 #ifdef CONFIG_PPC_5xxx_PSC_CONSOLE
 #ifndef CONFIG_PPC_5xxx_PSC_CONSOLE_PORT
@@ -89,7 +92,7 @@
 /*
  * Hardware specific serial port structure
  */
-struct rs_port { 	
+struct rs_port {
 	struct gs_port		gs;		/* Must be first field! */
 
 	struct mpc5xxx_psc	*psc;
@@ -121,7 +124,7 @@
 /*
  * Used by generic serial driver to access hardware
  */
-static struct real_driver rs_real_driver = { 
+static struct real_driver rs_real_driver = {
 	.disable_tx_interrupts	= rs_disable_tx_interrupts, 
 	.enable_tx_interrupts	= rs_enable_tx_interrupts, 
 	.disable_rx_interrupts	= rs_disable_rx_interrupts, 
@@ -134,9 +137,15 @@
 	.hungup			= rs_hungup,
 }; 
 
+#ifdef CONFIG_PS2MULT
+struct serial_state rs_table[RS_TABLE_SIZE] = {
+	SERIAL_PORT_DFNS	/* Defined in serial.h */
+};
+#else
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
 	SERIAL_PORT_DFNS	/* Defined in serial.h */
 };
+#endif
 
 /*
  * Structures and such for TTY sessions and usage counts
@@ -151,6 +160,14 @@
 int rs_initialized = 0;
 
 /*
+ * proc stuff
+ */
+static int sio_read_info(char * buf, char ** start, off_t offset, int count, int  *eof, void * data);
+
+static struct proc_dir_entry 	*proc_psc_dir,
+				*proc_psc[MPC5xxx_PSC_NPORTS];
+
+/*
  * ----------------------------------------------------------------------
  *
  * Here starts the interrupt handling routines.  All of the following
@@ -180,11 +197,11 @@
 
 	/* While there are characters, get them ... */
 	while (--count >= 0) {
-		status = in_be16(&psc->mpc5xxx_psc_status);
+		status = psc->mpc5xxx_psc_status;
 		if (!(status & MPC5xxx_PSC_SR_RXRDY))
 			break;
 
-		ch = in_8(&psc->mpc5xxx_psc_buffer_8);
+		ch = psc->mpc5xxx_psc_buffer_8;
 
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
 			continue;
@@ -215,6 +232,9 @@
 					tty->flip.count++;
 				}
 				*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+				rs_dprintk(MPC5xxx_PSC_DEBUG_RECEIVE, "reset psc overrun error status: 0x%04x\n", status);
+				/* Reset PSC error status */
+				psc->command = MPC5xxx_PSC_RST_ERR_STAT;
 			}
 		}
 
@@ -234,7 +254,7 @@
 
 	/* While I'm able to transmit ... */
 	while (--count >= 0) {
-		status = in_be16(&psc->mpc5xxx_psc_status);
+		status = psc->mpc5xxx_psc_status;
 		/*
 		 * XXX -df
 		 * check_modem_status(status);
@@ -243,7 +263,7 @@
 			break;
 
 		if (port->x_char) {
-			out_8(&psc->mpc5xxx_psc_buffer_8, port->x_char);
+			psc->mpc5xxx_psc_buffer_8 = port->x_char;
 			port->icount.tx++;
 			port->x_char = 0;
 		}
@@ -252,8 +272,7 @@
 			break;
 		}
 		else {
-			out_8(&psc->mpc5xxx_psc_buffer_8,
-				port->gs.xmit_buf[port->gs.xmit_tail++]);
+			psc->mpc5xxx_psc_buffer_8 = port->gs.xmit_buf[port->gs.xmit_tail++];
 			port->icount.tx++;
 			port->gs.xmit_tail &= SERIAL_XMIT_SIZE-1;
 			if (--port->gs.xmit_cnt <= 0) {
@@ -266,7 +285,7 @@
 			 port->gs.tty->hw_stopped) {
 		rs_disable_tx_interrupts(port);
 	}
-	
+
 	if (port->gs.xmit_cnt <= port->gs.wakeup_chars) {
 		if ((port->gs.tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
 				port->gs.tty->ldisc.write_wakeup)
@@ -275,7 +294,7 @@
 				"Waking up.... ldisc (%d)....\n",
 				port->gs.wakeup_chars); 
 		wake_up_interruptible(&port->gs.tty->write_wait);
-	}	
+	}
 }
 
 
@@ -294,19 +313,35 @@
 
 static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	struct rs_port * port;
+	struct rs_port * port = (struct rs_port *)dev_id;
+	struct mpc5xxx_psc *psc = port->psc;
 	unsigned long flags;
+	u16 status;
 
 	spin_lock_irqsave(&mpc5xxx_serial_lock, flags);
 
-	port = (struct rs_port *)dev_id;
 	rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS,
 			"rs_interrupt (port %p)...", port);
 
+	if (!port || !port->gs.tty) {
+		printk( KERN_DEBUG"%s(%d): port=%p tty=%p\n", __FUNCTION__, __LINE__,
+				port, port?port->gs.tty:NULL );
+		goto out;
+	}
+
+	status = psc->mpc5xxx_psc_status;
+	/* RB-Bit is set ?  */
+	if (status & MPC5xxx_PSC_SR_RB)
+	{
+		rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS, "reset psc error status: 0x%04x\n", status);
+		psc->command = MPC5xxx_PSC_RST_ERR_STAT;
+		goto out;
+	}
+
 	receive_char(port);
 
 	transmit_char(port);
-
+out:
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);
 
 	rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS, "end.\n");
@@ -318,7 +353,7 @@
  *		interface with the generic_serial driver		*
  ************************************************************************
  */
-static void rs_disable_tx_interrupts(void * ptr) 
+static void rs_disable_tx_interrupts(void *ptr)
 {
 	struct rs_port *port = ptr; 
 	struct mpc5xxx_psc *psc = port->psc;
@@ -328,7 +363,7 @@
 	port->gs.flags &= ~GS_TX_INTEN;
 
 	port->imr &= ~MPC5xxx_PSC_IMR_TXRDY;
-	out_be16(&psc->mpc5xxx_psc_imr, port->imr);
+	psc->mpc5xxx_psc_imr = port->imr;
 
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);
 }
@@ -342,7 +377,7 @@
 	spin_lock_irqsave(&mpc5xxx_serial_lock, flags);
 
 	port->imr |= MPC5xxx_PSC_IMR_TXRDY;
-	out_be16(&psc->mpc5xxx_psc_imr, port->imr);
+	psc->mpc5xxx_psc_imr = port->imr;
 
 	/* Send a char to start TX interrupts happening */
 	transmit_char(port);
@@ -359,7 +394,8 @@
 	spin_lock_irqsave(&mpc5xxx_serial_lock, flags);
 
 	port->imr &= ~MPC5xxx_PSC_IMR_RXRDY;
-	out_be16(&psc->mpc5xxx_psc_imr, port->imr);
+	psc->mpc5xxx_psc_imr = port->imr;
+	rs_dprintk(MPC5xxx_PSC_DEBUG_RECEIVE,"disable RxInt\n");
 
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);
 }
@@ -373,18 +409,10 @@
 	spin_lock_irqsave(&mpc5xxx_serial_lock, flags);
 
 	port->imr |= MPC5xxx_PSC_IMR_RXRDY;
-	out_be16(&psc->mpc5xxx_psc_imr, port->imr);
-
-	/* Empty the input buffer - apparently this is *vital* */
-	/*
-	 * XXXX add this back in if needed, -df
-	 *
-	 * while (in_be16(&psc->mpc5xxx_psc_status) & MPC5xxx_PSC_SR_RXRDY)
-	 *	in_8(&psc->mpc5xxx_psc_buffer_8);
-	 */
+	psc->mpc5xxx_psc_imr = port->imr;
+	rs_dprintk(MPC5xxx_PSC_DEBUG_RECEIVE,"enable RxInt\n");
 
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);
-
 }
 
 static int rs_get_CD(void * ptr) 
@@ -394,7 +422,7 @@
 	func_enter();
 
 	func_exit();
-	return (in_8(&port->psc->mpc5xxx_psc_ipcr) & MPC5xxx_PSC_DCD) != 0;
+	return (port->psc->mpc5xxx_psc_ipcr & MPC5xxx_PSC_DCD) != 0;
 }
 
 static void rs_shutdown_port(void * ptr) 
@@ -432,34 +460,67 @@
 
 	divisor = ((port->gs.baud_base / (port->gs.baud * 16)) + 1) >> 1;
 	if (port->gs.baud < 50 || divisor == 0) {
-		printk(KERN_NOTICE "MPC5xxx PSC: Bad speed requested, %d\n",
-				port->gs.baud);
+		printk(KERN_NOTICE "MPC5xxx PSC: Bad speed requested, %d, %d\n",
+				port->gs.baud, divisor);
 		return 0;
 	}
 	/* Configure the PSC for UART mode */
 	line = minor(port->gs.tty->device) - port->gs.tty->driver.minor_start;
+
+#if 0
+	/* This works only for PSC1..PSC3 and assumes that the ports are assigned  */
+	/* in this order. In other configurations it affects functions like usb    */
+	/* or ethernet. It isn't needed, when portconfig is done by the bootloader */
 	val32 = in_be32(&gpio->port_config);
 	val32 |= (MPC5xxx_GPIO_PSC_CONFIG_UART_WITHOUT_CD << (4*line));
 	out_be32(&gpio->port_config, val32);
+#else
+	switch ((int) port->psc) {
+		case MPC5xxx_PSC1: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC1\n");
+			gpio->port_config |= MPC5xxx_GPIO_PSC_CONFIG_UART_WITHOUT_CD;
+			break;
+		}
+		case MPC5xxx_PSC2: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC2\n");
+			gpio->port_config |= (MPC5xxx_GPIO_PSC_CONFIG_UART_WITHOUT_CD << 4);
+			break;
+		}
+		case MPC5xxx_PSC3: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC3\n");
+			gpio->port_config |= (MPC5xxx_GPIO_PSC_CONFIG_UART_WITHOUT_CD << 8);
+			break;
+		}
+		case MPC5xxx_PSC4: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC4\n");
+			break;
+		}
+		case MPC5xxx_PSC5: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC5\n");
+			break;
+		}
+		case MPC5xxx_PSC6: {
+			rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "Setup portconfig for PSC6\n");
+			break;
+		}
+	}
+#endif
+
 	/* reset and enable PSC */
-	out_8(&psc->command, MPC5xxx_PSC_RST_TX
-		  | MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_ENABLE);
-	out_8(&psc->command, MPC5xxx_PSC_RST_RX);
+	psc->command = MPC5xxx_PSC_RST_TX | MPC5xxx_PSC_TX_ENABLE;
+
 	/* Set PSC operation mode as 'UART, DCD ignored' */
-	out_be32(&psc->sicr, 0x0);
+	psc->sicr = 0x0;
 	/* Set clocking */
-	out_be16(&psc->mpc5xxx_psc_clock_select, 0xdd00);
+	psc->mpc5xxx_psc_clock_select = 0xdd00;
 	/* Set tx FIFO alarm level */
-	out_be16(&psc->tfalarm, 0xf8);
+	psc->tfalarm = 0xf8;
 	/* Put PSC into the operation */
-	out_8(&psc->command, MPC5xxx_PSC_SEL_MODE_REG_1
-		  | MPC5xxx_PSC_RX_ENABLE
-		  | MPC5xxx_PSC_TX_ENABLE);
-
-	rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "calculated divisor: %d\n",
-			divisor);
-	out_8(&psc->ctur, divisor>>8);
-	out_8(&psc->ctlr, divisor);
+	psc->command = MPC5xxx_PSC_SEL_MODE_REG_1 | MPC5xxx_PSC_RX_ENABLE | MPC5xxx_PSC_TX_ENABLE;
+
+	rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS, "calculated divisor: %d\n", divisor);
+	psc->ctur = divisor >> 8;
+	psc->ctlr = divisor;
 
 	/* Program hardware for parity, data bits, stop bits */
 	if ((CFLAG & CSIZE)==CS5)
@@ -496,19 +557,20 @@
 	rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS,
 			"baud_base: %d\n", port->gs.baud_base);
 #ifdef MPC5xxx_PSC_DEBUG
-	if (rs_debug & MPC5xxx_PSC_DEBUG_TERMIOS)
-		out_8(&psc->command, MPC5xxx_PSC_SEL_MODE_REG_1);
+	if (rs_debug & MPC5xxx_PSC_DEBUG_TERMIOS) {
+		psc->command = MPC5xxx_PSC_SEL_MODE_REG_1;
+	}
 #endif
 	rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS,
 			"mode 1 register was: %08x, now: %08x\n",
-			in_8(&psc->mode), mode1);
+			psc->mode, mode1);
 	rs_dprintk(MPC5xxx_PSC_DEBUG_TERMIOS,
 			"mode 2 register was: %08x, now: %08x\n",
-			in_8(&psc->mode), mode2);
+			psc->mode, mode2);
 
-	out_8(&psc->command, MPC5xxx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->mode, mode1);
-	out_8(&psc->mode, mode2);
+	psc->command = MPC5xxx_PSC_SEL_MODE_REG_1;
+	psc->mode = mode1;
+	psc->mode = mode2;
 
 	func_exit();
 	return 0;
@@ -539,7 +601,7 @@
 
 	line = minor(tty->device) - tty->driver.minor_start;
 	rs_dprintk(MPC5xxx_PSC_DEBUG_OPEN,
-			"%d: opening line %d. tty=%p ctty=%p)\n", 
+			"%d: opening line %d. tty=%p ctty=%p)\n",
 			(int) current->pid, line, tty, current->tty);
 
 	if ((line < 0) || (line >= RS_TABLE_SIZE))
@@ -728,7 +790,7 @@
 #endif
 
 	func_enter();
-	
+
 	if (I_IXOFF(tty)) {
 		if (port->x_char)
 			port->x_char = 0;
@@ -763,6 +825,7 @@
 static int rs_init_portstructs(void)
 {
 	struct rs_port *port;
+	struct mpc5xxx_psc *psc;
 	int i;
 #ifdef CONFIG_UBOOT
 	extern unsigned char __res[];
@@ -789,7 +852,7 @@
 	rs_driver.termios_locked = rs_termios_locked;
 
 	port = rs_ports;
-	for (i=0; i < MPC5xxx_PSC_NPORTS;i++) {
+	for (i = 0; i < MPC5xxx_PSC_NPORTS; i++) {
 		rs_dprintk(MPC5xxx_PSC_DEBUG_INIT, "initing port %d\n", i);
 		port->gs.callout_termios = tty_std_termios;
 		port->gs.normal_termios	= tty_std_termios;
@@ -813,6 +876,8 @@
 #endif
 		rs_dprintk(MPC5xxx_PSC_DEBUG_INIT, "psc base 0x%08lx\n",
 				(unsigned long)port->psc);
+		psc = port->psc;
+		psc->command = MPC5xxx_PSC_RST_ERR_STAT;
 		port++;
 	}
 
@@ -822,7 +887,9 @@
 
 static int rs_init_drivers(void)
 {
-	int error;
+	struct rs_port *port;
+	char proc_psc_name[8];
+	int i, error;
 
 	func_enter();
 
@@ -878,6 +945,19 @@
 		return 1;
 	}
 
+	/* Create /proc entries */
+	proc_psc_dir = proc_mkdir("driver/psc_mpc52xx", NULL);
+	if (proc_psc_dir != NULL) {
+		for (i=0; i < MPC5xxx_PSC_NPORTS; i++) {
+			sprintf(proc_psc_name, "ttyS%1d", i);
+			proc_psc[i] = create_proc_entry(proc_psc_name, 0444, proc_psc_dir);
+			proc_psc[i]->read_proc = sio_read_info;
+			proc_psc[i]->write_proc = NULL;
+			proc_psc[i]->data = &rs_ports[i];
+			proc_psc[i]->owner = THIS_MODULE;
+		}
+	}
+
 	func_exit();
 	return 0;
 }
@@ -888,6 +968,7 @@
 	int rc;
 	int i;
 	struct rs_port *port;
+	char name[6];
 
 	func_enter();
 	rs_dprintk(MPC5xxx_PSC_DEBUG_INIT,
@@ -896,20 +977,29 @@
 	rc = rs_init_portstructs();
 	rs_init_drivers();
 	port = rs_ports;
-	for (i=0; i < MPC5xxx_PSC_NPORTS;i++) {
-		rs_disable_rx_interrupts(port); 
-		rs_disable_tx_interrupts(port); 
+	for (i=0; i < MPC5xxx_PSC_NPORTS; i++) {
+		rs_disable_rx_interrupts(port);
+		rs_disable_tx_interrupts(port);
+		switch ((int) port->psc) {
+			case MPC5xxx_PSC1: { sprintf(name, "PSC1"); break; }
+			case MPC5xxx_PSC2: { sprintf(name, "PSC2"); break; }
+			case MPC5xxx_PSC3: { sprintf(name, "PSC3"); break; }
+			case MPC5xxx_PSC4: { sprintf(name, "PSC4"); break; }
+			case MPC5xxx_PSC5: { sprintf(name, "PSC5"); break; }
+			case MPC5xxx_PSC6: { sprintf(name, "PSC6"); break; }
+			default: { sprintf(name, "PSC?"); break; }
+		}
+
 		if (request_irq(port->irq, rs_interrupt,
 			SA_SHIRQ | SA_INTERRUPT, "serial", port)) {
-			printk(KERN_ERR
-				"rs: Cannot allocate irq for PSC%d.\n", i+1);
+			printk(KERN_ERR "rs: Cannot allocate irq for %s (ttyS%d).\n", name, i);
 			rc = 0;
 			continue;
 		}
 		rs_dprintk(MPC5xxx_PSC_DEBUG_INIT,
 				"requested irq for port[%d] = %08x\n",
 				i, (u32)port);
-		printk(KERN_INFO "ttyS%d on PSC%d\n", i, i+1);
+		printk(KERN_INFO "ttyS%d on %s\n", i, name);
 		port++;
 	}
 
@@ -940,25 +1030,27 @@
 	/*
 	 * Turn PSC interrupts off
 	 */
-	out_be16(&psc->mpc5xxx_psc_imr, 0);
+	psc->mpc5xxx_psc_imr = 0;
 
 	/*
 	 * Wait for the Tx register to become empty
 	 */
 	i = BUSY_WAIT;
-	while (!(in_be16(&psc->mpc5xxx_psc_status) & MPC5xxx_PSC_SR_TXEMP) &&
-			i--)
+	while (!(psc->mpc5xxx_psc_status & MPC5xxx_PSC_SR_TXEMP) && i--) {
 		udelay(1);
-	out_8(&psc->mpc5xxx_psc_buffer_8, c);
+	}
+
+	psc->mpc5xxx_psc_buffer_8 = c;
+
 	i = BUSY_WAIT;
-	while (!(in_be16(&psc->mpc5xxx_psc_status) & MPC5xxx_PSC_SR_TXEMP) &&
-			i--)
+	while (!(psc->mpc5xxx_psc_status & MPC5xxx_PSC_SR_TXEMP) && i--) {
 		udelay(1);
+	}
 
 	/*
 	 * Turn PSC interrupts back on
 	 */
-	out_be16(&psc->mpc5xxx_psc_imr, port->imr);
+	psc->mpc5xxx_psc_imr = port->imr;
 }
 
 static void serial_console_write(struct console *co, const char *s,
@@ -1050,17 +1142,14 @@
 		break;
 	}
 
-	out_8(&psc->command, MPC5xxx_PSC_RST_TX
-			| MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_ENABLE);
-	out_8(&psc->command, MPC5xxx_PSC_RST_RX);
-
-	out_be32(&psc->sicr, 0x0);
-	out_be16(&psc->mpc5xxx_psc_clock_select, 0xdd00);
-	out_be16(&psc->tfalarm, 0xf8);
-
-	out_8(&psc->command, MPC5xxx_PSC_SEL_MODE_REG_1
-			| MPC5xxx_PSC_RX_ENABLE
-			| MPC5xxx_PSC_TX_ENABLE);
+	psc->command = MPC5xxx_PSC_RST_TX | MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_ENABLE;
+	psc->command = MPC5xxx_PSC_RST_RX;
+
+	psc->sicr = 0x0;
+	psc->mpc5xxx_psc_clock_select = 0xdd00;
+	psc->tfalarm = 0xf8;
+
+	psc->command = MPC5xxx_PSC_SEL_MODE_REG_1 | MPC5xxx_PSC_RX_ENABLE | MPC5xxx_PSC_TX_ENABLE;
 
 #ifdef CONFIG_UBOOT
 	divisor = ((bd->bi_ipbfreq / (baud * 16)) + 1) >> 1;	/* round up */
@@ -1071,11 +1160,11 @@
 	mode1 = bits | parity | MPC5xxx_PSC_MODE_ERR;
 	mode2 = MPC5xxx_PSC_MODE_ONE_STOP;
 
-	out_8(&psc->ctur, divisor>>8);
-	out_8(&psc->ctlr, divisor);
-	out_8(&psc->command, MPC5xxx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->mode, mode1);
-	out_8(&psc->mode, mode2);
+	psc->ctur = divisor >> 8;
+	psc->ctlr = divisor;
+	psc->command = MPC5xxx_PSC_SEL_MODE_REG_1;
+	psc->mode = mode1;
+	psc->mode = mode2;
 
 	return 0;
 }
@@ -1095,3 +1184,51 @@
 }
 
 #endif
+
+static int sio_read_info(char *buf, char **start, off_t offset, int count, int  *eof, void *data)
+{
+	struct rs_port *port;
+	struct mpc5xxx_psc *psc;
+	u16 nStat;
+	int len = 0;
+
+	port = (struct rs_port *) data;
+	psc = port->psc;
+	nStat = psc->mpc5xxx_psc_status;
+
+	switch ((int) psc) {
+		case MPC5xxx_PSC1: { len += sprintf(buf+len, "PSC1: "); break; }
+		case MPC5xxx_PSC2: { len += sprintf(buf+len, "PSC2: "); break; }
+		case MPC5xxx_PSC3: { len += sprintf(buf+len, "PSC3: "); break; }
+		case MPC5xxx_PSC4: { len += sprintf(buf+len, "PSC4: "); break; }
+		case MPC5xxx_PSC5: { len += sprintf(buf+len, "PSC5: "); break; }
+		case MPC5xxx_PSC6: { len += sprintf(buf+len, "PSC6: "); break; }
+		default: { len += sprintf(buf+len, "PSC?: "); break; }
+	}
+	len += sprintf(buf+len, "Baudrate=%d, ", port->baud);
+	len += sprintf(buf+len, "Flags=0x%04x, ", port->cflag);
+	len += sprintf(buf+len, "Status=0x%04x ", nStat);
+	len += sprintf(buf+len, "Irq=%d, ", port->irq);
+	len += sprintf(buf+len, "Base=0x%08x\n      ", port->psc);
+	len += sprintf(buf+len, "RB:%d, ",(nStat & MPC5xxx_PSC_SR_RB) ? 1 : 0);
+	len += sprintf(buf+len, "FE:%d, ",(nStat & MPC5xxx_PSC_SR_FE) ? 1 : 0);
+	len += sprintf(buf+len, "PE:%d, ",(nStat & MPC5xxx_PSC_SR_PE) ? 1 : 0);
+	len += sprintf(buf+len, "OR:%d, ",(nStat & MPC5xxx_PSC_SR_OE) ? 1 : 0);
+	len += sprintf(buf+len, "TxEMP:%d, ",(nStat & MPC5xxx_PSC_SR_TXEMP) ? 1 : 0);
+	len += sprintf(buf+len, "TxRDY:%d, ",(nStat & MPC5xxx_PSC_SR_TXRDY) ? 1 : 0);
+	len += sprintf(buf+len, "RXFULL:%d, ",(nStat & MPC5xxx_PSC_SR_RXFULL) ? 1 : 0);
+	len += sprintf(buf+len, "RxRDY:%d, ",(nStat & MPC5xxx_PSC_SR_RXRDY) ? 1 : 0);
+	len += sprintf(buf+len, "CDE:%d\n",(nStat & MPC5xxx_PSC_SR_CDE) ? 1 : 0);
+
+	if (len <= offset + count)
+		*eof = 1;
+	*start = buf + offset;
+	len -= offset;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+

--------------090904010104010909080606--
