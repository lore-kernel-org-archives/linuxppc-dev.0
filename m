Message-ID: <3E1F7800.7DDF49E@synergymicro.com>
Date: Fri, 10 Jan 2003 17:48:49 -0800
From: Bill Fincke <willy@synergymicro.com>
Reply-To: willy@synergymicro.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Discovery gt64260_mpsc.c serial port driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We've ported the gt64260_mpsc.c driver from the MontaVista tree
to the Gemini kernel.  We're not using the 2 async serial ports
as console ports (we have 16552 UARTs for that), but as aux ports.
The driver seems to work OK when connected as a 9600-baud terminal
port and typed at by hand.  But we tried a loop back test, with
one port writing into the other and had all kinds of problems:

If we run 1 gt64260 port into the other, we never get any
received data - all the interrupts are "Tx done", but never
"Rx buffer ready".

If we write from a 16552 port into the gt64260, sending 1 character
at a time, with a 2-second loop delay, we can read OK.  But
if we take out the delay, or write a line at a time, the gt64260
gets 1 Rx interrupt for the 1st character, and that's all.

Has anyone used the gt64260_mpsc driver for anything other than
a manual console?  Is there a reason why the driver appears to
not work reading 1 port and writing the other simultaneously?
I've read the gt64260 errata and haven't found anything that
appears to be related.

Also, the driver came with the major device number set to 4 and
device name "/dev/ttys0".  We had to change the major to something
else (240 at the moment, and "/dev/ttyGT0") to keep the driver
from colliding with the real console. Is there an official major
number and tty device name for the gt64260 when it's not used as
the console?

Thanks,
  Bill Fincke
  Synergy Microsystems

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
