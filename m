Return-Path: <achim.machura@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id 84F1968545
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 18:10:29 +1000 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Date: Tue, 11 Oct 2005 10:10:19 +0200
Message-ID: <002001c5ce3b$3972bbe0$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0021_01C5CE4B.FCFB8BE0"
In-reply-to: <20051011071841.6C0FE353ADC@atlas.denx.de>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: MPC5200,PSC in uart mode, receiving problem 
Reply-To: achim.machura@berghof.com
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

------=_NextPart_000_0021_01C5CE4B.FCFB8BE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Here the patch
 
> Even better, post a patch here on the list so we all can benefit.
 
Best regards,

Achim
------=_NextPart_000_0021_01C5CE4B.FCFB8BE0
Content-Type: application/octet-stream;
	name="patch_linuxppc_2_4_develLABEL_2004_04_30_1320_psc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch_linuxppc_2_4_develLABEL_2004_04_30_1320_psc"

Index: psc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- psc.c	(.../kernel/linux/arch/ppc/5xxx_io/psc.c)	(Revision 777)=0A=
+++ psc.c	(.../firmware/kernel/linux/arch/ppc/5xxx_io/psc.c)	=
(Arbeitskopie)=0A=
@@ -29,6 +29,7 @@=0A=
 #include <linux/serial.h>=0A=
 #include <linux/serialP.h>=0A=
 #include <linux/generic_serial.h>=0A=
+#include <linux/proc_fs.h>=0A=
 #ifdef CONFIG_UBOOT=0A=
 #include <asm/ppcboot.h>=0A=
 #endif=0A=
@@ -37,7 +38,7 @@=0A=
  * This driver can spew a whole lot of debugging output at you. If you=0A=
  * need maximum performance, you should disable the DEBUG define.=0A=
  */=0A=
-#undef MPC5xxx_PSC_DEBUG =0A=
+#undef MPC5xxx_PSC_DEBUG=0A=
 =0A=
 #ifdef MPC5xxx_PSC_DEBUG=0A=
 #define MPC5xxx_PSC_DEBUG_OPEN		0x00000001=0A=
@@ -55,6 +56,7 @@=0A=
 #define MPC5xxx_PSC_DEBUG_FIRMWARE	0x00001000=0A=
 #define MPC5xxx_PSC_DEBUG_MEMTEST	0x00002000=0A=
 #define MPC5xxx_PSC_DEBUG_THROTTLE	0x00004000=0A=
+#define MPC5xxx_PSC_DEBUG_CLEARERR	0x00008000=0A=
 #define MPC5xxx_PSC_DEBUG_ALL		0xffffffff=0A=
 =0A=
 int rs_debug =3D MPC5xxx_PSC_DEBUG_ALL & ~MPC5xxx_PSC_DEBUG_TRANSMIT;=0A=
@@ -150,13 +152,23 @@=0A=
 int rs_refcount;=0A=
 int rs_initialized =3D 0;=0A=
 =0A=
+=0A=
 /*=0A=
+ * proc stuff=0A=
+ */=0A=
+static int sio_read_info(char * buf, char ** start, off_t offset, int =
count, int  *eof, void * data );=0A=
+static int sio_clear_err(struct file *file,  const char *buffer,  =
unsigned long count,   void *data);=0A=
+static struct proc_dir_entry  *pProcEntry =3D NULL;=0A=
+=0A=
+=0A=
+void clear_err(struct mpc5xxx_psc * psc);=0A=
+/*=0A=
  * =
----------------------------------------------------------------------=0A=
  *=0A=
  * Here starts the interrupt handling routines.  All of the following=0A=
  * subroutines are declared as inline and are folded into=0A=
  * rs_interrupt().  They were separated out for readability's sake.=0A=
- *=0A=
+ *MPC5xxx_PSC_DEBUG_RECEIVE=0A=
  * Note: rs_interrupt() is a "fast" interrupt, which means that it=0A=
  * runs with interrupts turned off.  People who may want to modify=0A=
  * rs_interrupt() should try to keep the interrupt handler as fast as=0A=
@@ -294,19 +306,36 @@=0A=
 =0A=
 static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)=0A=
 {=0A=
-	struct rs_port * port;=0A=
+	struct rs_port * port =3D (struct rs_port *)dev_id;=0A=
+	struct mpc5xxx_psc *psc =3D port->psc;=0A=
 	unsigned long flags;=0A=
+	u16 status;=0A=
 =0A=
 	spin_lock_irqsave(&mpc5xxx_serial_lock, flags);=0A=
 =0A=
-	port =3D (struct rs_port *)dev_id;=0A=
+=0A=
 	rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS,=0A=
 			"rs_interrupt (port %p)...", port);=0A=
 =0A=
+	if (!port || !port->gs.tty) {=0A=
+		printk( KERN_DEBUG"%s(%d): port=3D%p tty=3D%p\n", __FUNCTION__, =
__LINE__,=0A=
+				port, port?port->gs.tty:NULL );=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	status =3D in_be16(&psc->mpc5xxx_psc_status);=0A=
+	/* RB-Bit is set ?  */=0A=
+	if(status & MPC5xxx_PSC_SR_RB)=0A=
+	{=0A=
+		clear_err(psc);=0A=
+		rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS, "clear err in isr nach =
status %d.\n", status);=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
 	receive_char(port);=0A=
 =0A=
 	transmit_char(port);=0A=
-=0A=
+out:=0A=
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);=0A=
 =0A=
 	rs_dprintk(MPC5xxx_PSC_DEBUG_INTERRUPTS, "end.\n");=0A=
@@ -318,7 +347,7 @@=0A=
  *		interface with the generic_serial driver		*=0A=
  =
************************************************************************=0A=
  */=0A=
-static void rs_disable_tx_interrupts(void * ptr) =0A=
+static void rs_disable_tx_interrupts(void * ptr)=0A=
 {=0A=
 	struct rs_port *port =3D ptr; =0A=
 	struct mpc5xxx_psc *psc =3D port->psc;=0A=
@@ -360,7 +389,7 @@=0A=
 =0A=
 	port->imr &=3D ~MPC5xxx_PSC_IMR_RXRDY;=0A=
 	out_be16(&psc->mpc5xxx_psc_imr, port->imr);=0A=
-=0A=
+	rs_dprintk(MPC5xxx_PSC_DEBUG_RECEIVE,"disable RxInt\n");=0A=
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);=0A=
 }=0A=
 =0A=
@@ -382,7 +411,7 @@=0A=
 	 * while (in_be16(&psc->mpc5xxx_psc_status) & MPC5xxx_PSC_SR_RXRDY)=0A=
 	 *	in_8(&psc->mpc5xxx_psc_buffer_8);=0A=
 	 */=0A=
-=0A=
+	rs_dprintk(MPC5xxx_PSC_DEBUG_RECEIVE,"enable RxInt\n");=0A=
 	spin_unlock_irqrestore(&mpc5xxx_serial_lock, flags);=0A=
 =0A=
 }=0A=
@@ -442,9 +471,15 @@=0A=
 	val32 |=3D (MPC5xxx_GPIO_PSC_CONFIG_UART_WITHOUT_CD << (4*line));=0A=
 	out_be32(&gpio->port_config, val32);=0A=
 	/* reset and enable PSC */=0A=
-	out_8(&psc->command, MPC5xxx_PSC_RST_TX=0A=
-		  | MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_ENABLE);=0A=
-	out_8(&psc->command, MPC5xxx_PSC_RST_RX);=0A=
+//	out_8(&psc->command, MPC5xxx_PSC_RST_TX=0A=
+//		  | MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_ENABLE);=0A=
+//	out_8(&psc->command, MPC5xxx_PSC_RST_RX);=0A=
+=0A=
+	/* neu */=0A=
+		/* reset and enable PSC */=0A=
+	out_8(&psc->command, MPC5xxx_PSC_RST_TX  |  MPC5xxx_PSC_TX_ENABLE);=0A=
+ 	//out_8(&psc->command, MPC5xxx_PSC_RST_RX);=0A=
+	/* ende neu*/=0A=
 	/* Set PSC operation mode as 'UART, DCD ignored' */=0A=
 	out_be32(&psc->sicr, 0x0);=0A=
 	/* Set clocking */=0A=
@@ -539,7 +574,7 @@=0A=
 =0A=
 	line =3D minor(tty->device) - tty->driver.minor_start;=0A=
 	rs_dprintk(MPC5xxx_PSC_DEBUG_OPEN,=0A=
-			"%d: opening line %d. tty=3D%p ctty=3D%p)\n", =0A=
+			"%d: opening line %d. tty=3D%p ctty=3D%p)\n",=0A=
 			(int) current->pid, line, tty, current->tty);=0A=
 =0A=
 	if ((line < 0) || (line >=3D RS_TABLE_SIZE))=0A=
@@ -813,6 +848,7 @@=0A=
 #endif=0A=
 		rs_dprintk(MPC5xxx_PSC_DEBUG_INIT, "psc base 0x%08lx\n",=0A=
 				(unsigned long)port->psc);=0A=
+		clear_err(port->psc);=0A=
 		port++;=0A=
 	}=0A=
 =0A=
@@ -878,6 +914,11 @@=0A=
 		return 1;=0A=
 	}=0A=
 =0A=
+	//pProcEntry =3D  =
create_proc_read_entry("driver/sio0",0444,NULL,sio_read_info,NULL);=0A=
+	pProcEntry =3D  create_proc_entry("driver/sio0",0444,NULL);=0A=
+	pProcEntry->read_proc =3D sio_read_info;=0A=
+	pProcEntry->write_proc =3D sio_clear_err;=0A=
+	pProcEntry->owner =3D THIS_MODULE;=0A=
 	func_exit();=0A=
 	return 0;=0A=
 }=0A=
@@ -1094,3 +1135,61 @@=0A=
 }=0A=
 =0A=
 #endif=0A=
+static int sio_read_info(char * buf, char ** start, off_t offset, int =
count, int  *eof, void * data )=0A=
+{=0A=
+=0A=
+	int len =3D 0;=0A=
+	struct mpc5xxx_psc *psc =3D (struct mpc5xxx_psc *) MPC5xxx_PSC1;=0A=
+	u16 nStat;=0A=
+=0A=
+	*eof =3D 1;=0A=
+	*buf =3D 0;=0A=
+	nStat =3D in_be16(&psc->mpc5xxx_psc_status);=0A=
+	if(count > len + 120)=0A=
+	{=0A=
+		len +=3D sprintf(buf+len, "\n Status PSC 1: %d",nStat);=0A=
+		len +=3D sprintf(buf+len, "\n RB: %d",(nStat & MPC5xxx_PSC_SR_RB) ? 1 =
: 0);=0A=
+		len +=3D sprintf(buf+len, "\n FE: %d",(nStat & MPC5xxx_PSC_SR_FE) ? 1 =
: 0);=0A=
+		len +=3D sprintf(buf+len, "\n PE: %d",(nStat & MPC5xxx_PSC_SR_PE) ? 1 =
: 0);=0A=
+		len +=3D sprintf(buf+len, "\n OR: %d",(nStat & MPC5xxx_PSC_SR_OE) ? 1 =
: 0);=0A=
+		len +=3D sprintf(buf+len, "\n TxEMP: %d",(nStat & =
MPC5xxx_PSC_SR_TXEMP) ? 1 : 0);=0A=
+		len +=3D sprintf(buf+len, "\n TxRDY: %d",(nStat & =
MPC5xxx_PSC_SR_TXRDY) ? 1 : 0);=0A=
+		len +=3D sprintf(buf+len, "\n RXFULL: %d",(nStat & =
MPC5xxx_PSC_SR_RXFULL) ? 1 : 0);=0A=
+		len +=3D sprintf(buf+len, "\n RxRDY: %d",(nStat & =
MPC5xxx_PSC_SR_RXRDY) ? 1 : 0);=0A=
+		len +=3D sprintf(buf+len, "\n CDE: %d\n",(nStat & MPC5xxx_PSC_SR_CDE) =
? 1 : 0);=0A=
+=0A=
+	}=0A=
+	return len;=0A=
+=0A=
+}=0A=
+static int sio_clear_err(struct file *file,  const char *buffer,  =
unsigned long count,   void *data)=0A=
+{=0A=
+=0A=
+	struct mpc5xxx_psc *psc =3D (struct mpc5xxx_psc *) MPC5xxx_PSC1;=0A=
+=0A=
+	clear_err(psc);=0A=
+	return (int)count;=0A=
+}=0A=
+=0A=
+void clear_err(struct mpc5xxx_psc * psc)=0A=
+{=0A=
+    u8 byCmd;=0A=
+	u16 i;=0A=
+	unsigned int status, nBytes;=0A=
+=0A=
+	nBytes =3D in_be16(&psc->rfnum) & MPC5xxx_PSC_RFNUM_MASK;=0A=
+	for(i=3D0; i< nBytes;i++)=0A=
+	{=0A=
+		byCmd =3D in_8(&psc->mpc5xxx_psc_buffer_8);=0A=
+		rs_dprintk(MPC5xxx_PSC_DEBUG_CLEARERR,"loesche Byte %d von %d =
Bytes\n",i+1,nBytes);=0A=
+	}=0A=
+	status =3D in_be16(&psc->mpc5xxx_psc_status);=0A=
+	rs_dprintk(MPC5xxx_PSC_DEBUG_CLEARERR,"status Start %d\n",status);=0A=
+	byCmd =3D (u8) MPC5xxx_PSC_RST_ERR_STAT;=0A=
+	out_8(&psc->command, byCmd);=0A=
+	wmb();=0A=
+	status =3D in_be16(&psc->mpc5xxx_psc_status);=0A=
+	rmb();=0A=
+	rs_dprintk(MPC5xxx_PSC_DEBUG_CLEARERR,"status clear %d\n",status);=0A=
+}=0A=
+=0A=

------=_NextPart_000_0021_01C5CE4B.FCFB8BE0--
