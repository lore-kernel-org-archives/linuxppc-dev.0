Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 931EEB7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 04:15:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8NID50E012343
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 14:13:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8NIFoSE250850
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 14:15:50 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8NIFner018693
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 14:15:50 -0400
Date: Wed, 23 Sep 2009 14:15:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090923181546.GI14261@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<1253051047.8375.232.camel@pasglop>
	<20090916131943.GA14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090916131943.GA14261@zod.rchland.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2009 at 09:19:43AM -0400, Josh Boyer wrote:
>On Wed, Sep 16, 2009 at 07:44:07AM +1000, Benjamin Herrenschmidt wrote:
>>On Tue, 2009-09-15 at 11:32 -0400, Josh Boyer wrote:
>Ok, so I think that is related to what I originally hit.
>
>I played around with removing the current-speed property on canyonlands today,
>and noticed that I would get no console output at all unless I specified a
>baudrate with console=ttyS0,115200.  That was sort of contrary to what I found
>with bamboo, so I diffed the configs to see why.  Bamboo has udbg enabled and
>hence has legacy_serial builtin, whereas canyonlands just has of_serial.

Correcting myself again, there really isn't any difference from a driver
perspective at a build level.  Both Cayonlands and Bamboo have udbg selected.
The difference is that Bamboo has linux,stdout-path specified in the choosen
node and Caynonlands does not.  Udbg looks for that, etc etc.

>Alternatively, we could try patching of_serial.c to do the baudrate probe
>as well.

I looked at this.  It's rather ugly, because of_serial.c doesn't really do
anything from a hardware perspective.  It simply binds to the device nodes
and lets the underlying serial driver do all the hardware handling.  We'd
need to have it ioremap, probe, iounmap and that all seems rather silly.

Looking at the 8250 driver, there is a place we could autoprobe it.  Something
like the ugly patch below.  It would probably need to be wrapped in a CONFIG
option, but you get the idea.

Overall, I'm not sure having either is a requirement for removing the
current-speed properties from the DTS files.  The only thing I could see
needing is telling of_serial.c to ignore a current-speed=0 property, as that
seems to be pretty invalid, but what some versions of U-Boot do.

josh

---

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 2209620..0cced56 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2778,7 +2778,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 static int __init serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
-	int baud = 9600;
+	int baud = 0;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
@@ -2797,6 +2797,26 @@ static int __init serial8250_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	if (baud == 0) {
+		unsigned char old_lcr, div, pre;
+		struct uart_8250_port *up = (struct uart_8250_port *) port;
+
+		old_lcr = serial_inp(up, UART_LCR);
+		serial_outp(up, UART_LCR, UART_LCR_DLAB);
+		div = serial_dl_read(up);
+		if (serial_inp(up, UART_MCR) & 0x80)
+			pre = 4;
+		else
+			pre = 1;
+
+		serial_outp(up, UART_LCR, old_lcr);
+
+		baud = (port->uartclk / pre) / (div * 16);
+
+		if (baud > (port->uartclk / 16))
+			baud = 9600;
+	}
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
