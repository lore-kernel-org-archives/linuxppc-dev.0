Return-Path: <takata@linux-m32r.org>
Received: from mail04.idc.renesas.com (mail.renesas.com [202.234.163.13])
	by ozlabs.org (Postfix) with ESMTP id BA65C68A75
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 01:10:39 +1100 (EST)
Received: from mail04.idc.renesas.com ([127.0.0.1])
	by mail04.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id
	M2006020223103611316
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Feb 2006 23:10:36 +0900
Date: Thu, 02 Feb 2006 23:10:33 +0900 (JST)
Message-Id: <20060202.231033.1059963967.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060202102721.GE5034@flint.arm.linux.org.uk>
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
	<20060202102721.GE5034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: pfg@sgi.com, linux-mips@linux-mips.org, takata@linux-m32r.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On m32r,
  compile and boot test: OK

Thank you.

-- Takata

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 02 Feb 2006 10:27:21 +0000
> Ping?
> 
> On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> > The serial_core layer has its own definitions for these, and I'd
> > appreciate it if folk would use them instead of the old ASYNC_* and
> > SERIAL_IO_* definitions.
> > 
> > They're compatible _at the moment_ but I make no guarantees that they
> > will stay that way.  Hence, it's in your interest to ensure that you're
> > using the correct definitions.
> > 
> > MIPS, PPC seem to be the architectures which are stuck in the past on
> > this issue, as is the M32R SIO driver.
> > 
> > The ioc4_serial driver is worse.  It assumes that it can set/clear
> > ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> > serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> > clearing it (pointless), and then it writes to tty->alt_speed... which
> > isn't used by the serial layer so is also pointless.
> > 
> > So, here's a patch to fix some of this crap up.  Please test and
> > enjoy - I certainly didn't.
...
> >  drivers/serial/m32r_sio.c                  |    2 +-
> >  18 files changed, 32 insertions(+), 51 deletions(-)
...
> > +++ b/arch/mips/cobalt/setup.c
> > diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
> > --- a/drivers/serial/m32r_sio.c
> > +++ b/drivers/serial/m32r_sio.c
> > @@ -80,7 +80,7 @@
> >  #include <asm/serial.h>
> >  
> >  /* Standard COM flags */
> > -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> > +#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
> >  
> >  /*
> >   * SERIAL_PORT_DFNS tells us about built-in ports that have no
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 
