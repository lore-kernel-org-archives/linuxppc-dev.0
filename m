Message-ID: <39DE00A8.576CAA9A@mvista.com>
Date: Fri, 06 Oct 2000 09:41:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "Kim, Jin Young" <jykim@raonet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot failed on Sandpoint under baudrate 38400
References: <NEBBLJBIIKANNNOGGKNDIEKECCAA.jykim@raonet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Kim, Jin Young" wrote:

> > >
> > > Yes, I set bootloader(arch/ppc/boot/ns16550.c)  and DINK (sb -k
> > 38400) to 38400.
> > > So where do I change the baud rate for kernel ?
> >
> > Take a look in include/asm-ppc/serial.h at the define of
> > BASE_BAUD and it's use in
> > STD_SERIAL_PORT_DEFNS.
>
> Isn't it for the clock divisor?  What happen if I want to return to 9600 baud?
>
> How about changing  the line
> "serial_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;" to
> "serial_driver.init_termios.c_cflag = B38400 | CS8 | CREAD | HUPCL | CLOCAL;"
> in rs_int() for the serial device and
> "int baud = 9600;" to "int baud = 38400;" in serial_console_setup() for the console.
>
> Both in drivers/char/serial.c
>
> Stephan Kim

Yes, you're right.  Sorry, I was thinking of something else.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
