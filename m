Message-ID: <A109131318C4D1119AC20060088DECE34B8F32@mail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Christopher Huffine'" <huffine@wopr.nrl.navy.mil>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Serial port two on an 823 based system (BSE-IPEngine) (Additi
	onal Thoughts)
Date: Mon, 5 Feb 2001 10:10:01 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We started with a BSE board and moved on to our own design. The kernel
version we use is 2.2.13. I remember having a problem in this area but was
not the engineer that changed it. Looking in the files I found the
following. Hope this is helpful. All I know is it works for us.

in the __initfunc(int rs_8xx_init(void)) in uart.c
see if you have something similar to the following

	/* Configure SMCs Tx/Rx instead of port B parallel I/O.
	*/
#if 0
	/* DRC SMC1/SMC2 are on PortB on A MPC860 */
	cp->cp_pbpar |= 0x00000cc0;
	cp->cp_pbdir &= ~0x00000cc0;
	cp->cp_pbodr &= ~0x00000cc0;
#else
	/* DRC SMC1 is on PortA and SMC2 is on PortA on A MPC823 */
	cp->cp_pbpar |= 0x000000c0;
	cp->cp_pbdir &= ~0x000000c0;
	cp->cp_pbodr &= ~0x000000c0;
	immap->im_ioport.iop_papar |= 0x00c0;
	immap->im_ioport.iop_padir &= ~0x00c0;
	immap->im_ioport.iop_paodr &= ~0x00c0;
#endif

Also, furthur down in the file:

static _INLINE_ void transmit_chars(ser_info_t *info)
{

//DRC--removed for  call back routines to happen	if (info->flags &
TX_WAKEUP)
	{
		rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
	}

-----Original Message-----
From: Christopher Huffine [mailto:huffine@wopr.nrl.navy.mil]
Sent: Monday, January 29, 2001 3:34 AM
To: linuxppc-embedded@lists.linuxppc.org
Cc: Stuart Adams; Don Kremer; support@brightstareng.com; Gary Sheets
Subject: Serial port two on an 823 based system (BSE-IPEngine)
(Additional Thoughts)



Folks,

Some additional information.  I have pulled the data
sheet on the 823 processor and found the SMC data
TX and RX lines for ports one and two.  SMTXD1 (pin N11)
sends out the serial data that you would expect
for the console, and its partner, SMRXD1 (pin T11) receives
in the console keystrokes.

Unfortunately,  SMRTXD2 (pin T11) shows no activity
when characters are sent out of the port.  It reamains logic
high, no glitches.

I have communicated with Wolfgang Denx who confirms
that under HHL Kernel 2.2.14, both serial ports
work on his 823 based boards.  Since the 823 is integrated
with the communications controller, I would expect functionality
that works in one board to work in the other.  Is there a possiblity
that the boot loader or pre-boot ROM monitor could somehow
prevent use of port two?

Thanks,

Chris

On Sun, 28 Jan 2001, Christopher Huffine wrote:

> Folks,
>
> I'm trying to utilize the second serial port on a
> Bright Star Engineering IPEngine.  I've tried two
> verions of the kernel (2.2.14 from Montavista's HHL),
> as well as the 2.2.0 from BSE directly.  The revisions
> of uart.c in arch/ppc/8xx_io differ from 0.1 and 0.3
>
> The kernel seems to boot up, configure, and recognize
> everything properly:
>
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0380 is a SMC
>
>
> Here's the story:  I can read from the port fine.  Writing
> from the port (to external devices), however is a problem.
> Yes, I am opening the port and deviceproperly for read-write.
> I have tried both the new, standard ttyS0 dev file, as well
> as the older cua0 device files.  Yes, the permissions are set
> propery.  Upon boot-up, the kernel reconizes and configures
> both.
>
> cat /proc/tty/drivers returns the following as one would
> expect:
>
> serial               /dev/cua        5   64-65 serial:callout
> serial               /dev/ttyS       4   64-65 serial
>
> cat /proc/tty/driver/serial returns:
>
> driverinfo:1.0 driver:0.03
> 0: uart:SMC port:280 irq:4
> 1: uart:SMC port:380 irq:3
>
> cat /proc/devices returns as you'd expect:
>
> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 ttyS
>   5 cua
>  10 misc
> 128 ptm
> 136 pts
>
> Using a simple command such as
> 	echo	"hello world" > /dev/ttyS0
>
> causes the text to display on the console port
> 	echo 	"hello world" > /dev/ttyS1
>
> does not cause any charaters to be written.
>
> Using a C program (using open, write(s), and read(s),
> allows characters to be _read_ OK.  Writes, however,
> return a perror() of "Bad Address" (with kernel 2.0.0).
> With the Montavista version of 2.2.14, I get no errors,
> and `write' returns that all of the bytes were
> properly sent out.  The file descriptor is valid, and again,
> the permission are set properly.
>
> I have probed the serial transciever chip (linear 1385)
> and the bits coming into the transciever for serial port one
> look fine.  Nothing is making into the driver for
> serial port two.
>
> Next, I have turned on all of the debugging statements in
> uart.c looking to figure out what is going on.  Everything
> appears to to be operating properly.  open() calls make it, and
> seems to complete sucessfully.  Writes seems to come in, and
> complete sucessfully.  Closes seem to complete properly.
>
> I have only two guesses right now:  the hardware is not
> connected properly from the CPM transmit pin on the 823 to the
> line driver, or the setup of the CPM is corrupt somehow, and
> get the setup for receive enabled and executed properly,
> but the write does not complete properly.
>
> I have tried moving the console from port 0 to port 1, with
> little luck -- the system hangs when changing the console
> port selection in uart.c ... This may because the console
> control is somewhat more complex, with parts of it in
> arch/ppc/mbxboot/8xx_tty.c as well.
>
> Any suggestions would be greatly appreciated.
>
> Thanks,
>
> Chris
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
