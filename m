Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 662F9680C3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 17:59:21 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9Q7xCQx008088
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Oct 2006 09:59:14 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9Q7x8KR008025
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Oct 2006 09:59:08 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: CPM2 SCC/SMC break handling broken
Date: Thu, 26 Oct 2006 10:02:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610261002.44688.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I need to generate a break on a CPM2 SMC serial port (same issue with SCC 
serial ports).

The tcsendbreak() man page states that the function should generate a break 
between 250ms and 500ms, but testing showed that the break is one character 
long (10 bits in 8N1 mode).

Breaks are handled by the tty layer (drivers/char/tty_io.c), the generic 
serial layer (drivers/serial/serial_core.c) and the CPM driver 
(drivers/char/cpm_uart/cpm_uart_core.c).

As the tty driver (drivers/serial/serial_core.c) defines a break handler 
(break_ctl), the tty layer calls send_break to send the break:

static int send_break(struct tty_struct *tty, unsigned int duration)
{
        tty->driver->break_ctl(tty, -1);
        if (!signal_pending(current)) {
                msleep_interruptible(duration);
        }
        tty->driver->break_ctl(tty, 0);
        if (signal_pending(current))
                return -EINTR;
        return 0;
}

tty->driver->break_ctl just forwards the call to the CPM driver, which does

static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
{
        struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
        int line = pinfo - cpm_uart_ports;

        pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
                break_state);

        if (break_state)
                cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
        else
                cpm_line_cr_cmd(line, CPM_CR_RESTART_TX);
}

CPM_CR_STOP_TX is documented to generate a break of BRKCR characters. The 
BRKCR register is initialized to 1, so only 1 break character is sent, which 
won't last between 250ms and 500ms.

cpm_uart_break_ctl() is not told how long the break must last, so it can't 
modify BRKCR before sending CPM_CR_STOP_TX. A solution would be to let the 
driver handle the break itself instead of having tty_io.c calling 
send_break(). To do that, the driver (serial_core.c) must not declare a break 
handler. This would obviously break all other serial drivers. Another 
solution would be to have a new platform handler for CPM serial ports which 
will turn the I/O ports to low-level outputs. This sounds more like a hack to 
me though.

Could anyone think of a proper solution which would not disturb the other 
drivers too much ?

Laurent Pinchart
