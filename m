Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76D05DDEB8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 18:52:15 +1000 (EST)
Date: Wed, 4 Apr 2007 09:51:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404085159.GB13134@flint.arm.linux.org.uk>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403230908.GA13471@cynthia.pants.nu>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 04:09:08PM -0700, Brad Boyer wrote:
> The availability of the specific chip in question is a red herring in
> my opinion. I do understand that 8250 compatible chips are very common
> and are the most likely serial chips to be used with Linux. However, I
> will point out that the define is TTY_MAJOR, not 8250_MAJOR. It seems
> to me that whoever named it was thinking in more generic terms.

You're reading too much into the name.  It's historical, and the reason
can still be seen in LANANA:

  4 char        TTY devices
                  0 = /dev/tty0         Current virtual console

                  1 = /dev/tty1         First virtual console
                    ...
                 63 = /dev/tty63        63rd virtual console
                 64 = /dev/ttyS0        First UART serial port
                    ...
                255 = /dev/ttyS191      192nd UART serial port

                UART serial ports refer to 8250/16450/16550 series devices.

When the drivers/char/serial.c driver was written, it was in the very
early days of Linux.  I'd guess that the major/minor numbers were similar
to Minix, thereby allowing a minixfs to be used as the initial filesystem
type.

Anyway, as you can see, defining chardev major 4 to be "8250_MAJOR" would
also be a misnomer because it's used for the virtual consoles, and it's
_that_ use for which it (probably) was called TTY_MAJOR.

(Note that in the very early days, this major also got used for PTY
devices.  Since then they've moved to major 2/3 and then we got Unix98
PTY support.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
