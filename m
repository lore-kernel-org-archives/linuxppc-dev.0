Return-Path: <rdcorle@yahoo.com>
Received: from web56302.mail.re3.yahoo.com (web56302.mail.re3.yahoo.com
	[216.252.110.226]) by ozlabs.org (Postfix) with SMTP id 1049567D72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 23:38:24 +1000 (EST)
Message-ID: <20061027133823.25945.qmail@web56302.mail.re3.yahoo.com>
Date: Fri, 27 Oct 2006 06:38:23 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: initial success with uartlite w/interrupt and 2.6.18.1
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

DB;=0A=0AI moved the declaration to outside the loop and now the uartlite d=
river sends and receives=0Adata.  See below for details (as if it needs exp=
laining, right?  :-))=0A=0AFYI, the RS232 irq line stays high (it's level-t=
riggered for RX data) for 9usec, although I=0Asuspect that isn't the irq se=
rvice time as it probably drops as soon as the RX fifo is read.=0AStill, it=
's good to know that it takes that long from irq start to reading a byte.=
=0A=0AI still don't know why I could not get it to properly function in 2.6=
.17, although I was close =0Awith the latest patch you gave me.=0A=0ANow on=
 to the temac...=0A=0A-cy=0A=0A---------------- code follows  -------------=
---------=0A=0Astatic irqreturn_t ulite_isr(int irq, void *dev_id, struct p=
t_regs *regs)=0A{=0A        struct uart_port *port =3D (struct uart_port *)=
dev_id;=0A        int busy;=0A        int stat;=0A=0A        spin_lock(&por=
t->lock); /* Lock the port in case of printk */=0A=0A        do {=0A       =
         stat =3D readb((unsigned volatile *) (port->membase + ULITE_STATUS=
_BYTE));=0A                busy  =3D ulite_receive(port, stat);=0A         =
       busy |=3D ulite_transmit(port, stat);=0A        } while (busy);=0A=
=0A        spin_unlock(&port->lock);=0A=0A        tty_flip_buffer_push(port=
->info->tty);=0A=0A        return IRQ_HANDLED;=0A}=0A=0A=0A=0A
