Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55FCA679F7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Feb 2006 19:44:59 +1100 (EST)
Date: Fri, 10 Feb 2006 08:44:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210084445.GA1947@flint.arm.linux.org.uk>
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> The ioc4_serial driver is worse.  It assumes that it can set/clear
> ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> clearing it (pointless), and then it writes to tty->alt_speed... which
> isn't used by the serial layer so is also pointless.

Okay, the only remaining part of this patch which hasn't been applied
is this - can anyone ack it?

diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
 	}
 
 	if (cflag & CRTSCTS) {
-		info->flags |= ASYNC_CTS_FLOW;
 		port->ip_sscr |= IOC4_SSCR_HFC_EN;
 	}
 	else {
-		info->flags &= ~ASYNC_CTS_FLOW;
 		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
 	}
 	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
@@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
 
 	info = the_port->info;
 
-	if (info->tty) {
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
-		clear_bit(TTY_IO_ERROR, &info->tty->flags);
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			info->tty->alt_speed = 57600;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			info->tty->alt_speed = 115200;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-			info->tty->alt_speed = 230400;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-			info->tty->alt_speed = 460800;
-	}
 	local_open(port);
 
 	/* set the speed of the serial port */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
