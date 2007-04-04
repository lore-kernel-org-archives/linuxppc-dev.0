Return-Path: <geert@linux-m68k.org>
Received: from adicia.telenet-ops.be (adicia.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id 5866CDDE28
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 19:48:16 +1000 (EST)
Date: Wed, 4 Apr 2007 11:48:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <20070404085159.GB13134@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0704041146290.30582@anakin>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
	<20070404085159.GB13134@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2007, Russell King wrote:
> On Tue, Apr 03, 2007 at 04:09:08PM -0700, Brad Boyer wrote:
> > The availability of the specific chip in question is a red herring in
> > my opinion. I do understand that 8250 compatible chips are very common
> > and are the most likely serial chips to be used with Linux. However, I
> > will point out that the define is TTY_MAJOR, not 8250_MAJOR. It seems
> > to me that whoever named it was thinking in more generic terms.
> 
> You're reading too much into the name.  It's historical, and the reason
> can still be seen in LANANA:
> 
>   4 char        TTY devices
>                   0 = /dev/tty0         Current virtual console
> 
>                   1 = /dev/tty1         First virtual console
>                     ...
>                  63 = /dev/tty63        63rd virtual console
>                  64 = /dev/ttyS0        First UART serial port
>                     ...
>                 255 = /dev/ttyS191      192nd UART serial port
> 
>                 UART serial ports refer to 8250/16450/16550 series devices.
> 
> When the drivers/char/serial.c driver was written, it was in the very
> early days of Linux.  I'd guess that the major/minor numbers were similar
> to Minix, thereby allowing a minixfs to be used as the initial filesystem
> type.
> 
> Anyway, as you can see, defining chardev major 4 to be "8250_MAJOR" would
> also be a misnomer because it's used for the virtual consoles, and it's
> _that_ use for which it (probably) was called TTY_MAJOR.
> 
> (Note that in the very early days, this major also got used for PTY
> devices.  Since then they've moved to major 2/3 and then we got Unix98
> PTY support.)

Oh, and I always thought PTYs were moved to free up more minors for our
zillions of serial ports...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
