Date: Sat, 28 Jul 2001 17:09:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org,
	ppcboot-users@lists.sourceforge.net
Subject: Re: ISA SIO Problems
Message-ID: <20010728170936.C755@opus.bloom.county>
References: <200107282354.QAA00412@krakatoa.gigabitnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200107282354.QAA00412@krakatoa.gigabitnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 28, 2001 at 04:54:19PM -0700, James F Dougherty wrote:

> I am trying to use the serial.c driver with HHL-2.4 and modified it

hhl-2.0 you mean. :)

> by adding the following entry to rs_table[] :

Okay, the more portable way would be to:
1) edit include/asm-ppc/serial.h, and Yet Another #elif
2) Make include/asm-ppc/mousse_serial.h, which has something like:
#define STD_SERIAL_PORT_DFNS
 {0, 9600, MOUSSE_SERIAL_0, 4, STD_COM_FLAGS, PORT_8250, \
 	io_base: (u8 *) SERIAL_MOUSE_0 \
	io_type: SERIAL_IO_MEM

> The problem is that when I finally do boot up and mount the root filesystem,
> the console no longer works, and when I try to exit from my tip console
> session, the serial port on my sun box gets wedged.
>
> My serial port does not have H/W flow control, is there some other
> options I need to configure (tty terminal ios flags?) in order to
> get my serial port to work without HW flow control?

Look at Documentation/serial.txt I think it is, for what options to pass
linux for console= bits.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
