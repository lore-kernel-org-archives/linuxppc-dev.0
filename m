Date: Sun, 28 Jan 2001 07:00:11 -0500 (EST)
From: Christopher Huffine <huffine@wopr.nrl.navy.mil>
To: linuxppc-embedded@lists.linuxppc.org
cc: Stuart Adams <sja@brightstareng.com>, support@brightstareng.com
Subject: Serial port two on an 823 based system (BSE-IPEngine)
Message-ID: <Pine.LNX.4.21.0101280549560.15693-100000@wopr.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I'm trying to utilize the second serial port on a
Bright Star Engineering IPEngine.  I've tried two
verions of the kernel (2.2.14 from Montavista's HHL),
as well as the 2.2.0 from BSE directly.  The revisions
of uart.c in arch/ppc/8xx_io differ from 0.1 and 0.3

The kernel seems to boot up, configure, and recognize
everything properly:

CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC


Here's the story:  I can read from the port fine.  Writing
from the port (to external devices), however is a problem.
Yes, I am opening the port and deviceproperly for read-write.
I have tried both the new, standard ttyS0 dev file, as well
as the older cua0 device files.  Yes, the permissions are set
propery.  Upon boot-up, the kernel reconizes and configures
both.

cat /proc/tty/drivers returns the following as one would
expect:

serial               /dev/cua        5   64-65 serial:callout
serial               /dev/ttyS       4   64-65 serial

cat /proc/tty/driver/serial returns:

driverinfo:1.0 driver:0.03
0: uart:SMC port:280 irq:4
1: uart:SMC port:380 irq:3

cat /proc/devices returns as you'd expect:

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
 10 misc
128 ptm
136 pts

Using a simple command such as
	echo	"hello world" > /dev/ttyS0

causes the text to display on the console port
	echo 	"hello world" > /dev/ttyS1

does not cause any charaters to be written.

Using a C program (using open, write(s), and read(s),
allows characters to be _read_ OK.  Writes, however,
return a perror() of "Bad Address" (with kernel 2.0.0).
With the Montavista version of 2.2.14, I get no errors,
and `write' returns that all of the bytes were
properly sent out.  The file descriptor is valid, and again,
the permission are set properly.

I have probed the serial transciever chip (linear 1385)
and the bits coming into the transciever for serial port one
look fine.  Nothing is making into the driver for
serial port two.

Next, I have turned on all of the debugging statements in
uart.c looking to figure out what is going on.  Everything
appears to to be operating properly.  open() calls make it, and
seems to complete sucessfully.  Writes seems to come in, and
complete sucessfully.  Closes seem to complete properly.

I have only two guesses right now:  the hardware is not
connected properly from the CPM transmit pin on the 823 to the
line driver, or the setup of the CPM is corrupt somehow, and
get the setup for receive enabled and executed properly,
but the write does not complete properly.

I have tried moving the console from port 0 to port 1, with
little luck -- the system hangs when changing the console
port selection in uart.c ... This may because the console
control is somewhat more complex, with parts of it in
arch/ppc/mbxboot/8xx_tty.c as well.

Any suggestions would be greatly appreciated.

Thanks,

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
