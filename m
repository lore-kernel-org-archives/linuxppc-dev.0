From: "Kim, Jin Young" <jykim@raonet.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux boot failed on Sandpoint under baudrate 38400
Date: Fri, 6 Oct 2000 10:30:19 +0900
Message-ID: <NEBBLJBIIKANNNOGGKNDIEKECCAA.jykim@raonet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <39DCFB9C.9B19BF2E@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Mark A. Greer
> Sent: Friday, October 06, 2000 7:07 AM
> To: Zhaobin Zhu
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Linux boot failed on Sandpoint under baudrate 38400
>
>
>
> Zhaobin Zhu wrote:
>
> > "Mark A. Greer" wrote:
> >
> > > What do you mean by garbled?  Do you mean the characters look
> okay but some
> > > seem to be missing or just a bunch of strange characters?
> > >
> >
> >  a bunch of strange characters.
>
> Okay, then its likely a simple baud rate issue.
>
> > > The kernel, the bootloader, and DINK all need to be set up
> for the same baud
> > > rate.  It sounds like you have dink and the bootloader setup
> for one baud rate
> > > and the kernel is probably still at 9600.  Could that be the case?
> > >
> > > Mark
> > >
> >
> > Yes, I set bootloader(arch/ppc/boot/ns16550.c)  and DINK (sb -k
> 38400) to 38400.
> > So where do I change the baud rate for kernel ?
>
> Take a look in include/asm-ppc/serial.h at the define of
> BASE_BAUD and it's use in
> STD_SERIAL_PORT_DEFNS.

Isn't it for the clock divisor?  What happen if I want to return to 9600 baud?

How about changing  the line
"serial_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;" to
"serial_driver.init_termios.c_cflag = B38400 | CS8 | CREAD | HUPCL | CLOCAL;"
in rs_int() for the serial device and
"int baud = 9600;" to "int baud = 38400;" in serial_console_setup() for the console.

Both in drivers/char/serial.c

Stephan Kim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
