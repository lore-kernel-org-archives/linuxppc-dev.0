Date: Fri, 6 Apr 2001 11:08:48 -0400 (EDT)
From: "Kevin M. Myer" <kevin_myer@iu13.k12.pa.us>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Serial console problems w/ 2.4.1
Message-ID: <Pine.LNX.4.33.0104061050510.1481-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to boot an Apple Network Server using a serial console and am
having trouble doing so.  I have no trouble getting Open Firmware output
and input to go through the serial port but I can't get the machine to
boot into Linux.  Originally, I had xmon support compiled in and when I
would try to boot the kernel, I would get the following output over the
serial line:

ATZ1V1
+++

I suspect that output is coming from xmon (not sure why) but I disabled
that and now, there's nothing coming across the serial line.

For the kernel command line, I'm using <kernel-name> console=ttyS0,38400

Open Firmware serial port settings are 38400,8N1,XON/XOFF (and I don't
know how to change them).  Looking at the macserial driver, it appears to
use those settings anyway.  Also looking at the driver, I see, at about
line 2619:

panic("macserial: console not supported yet !");

It seems to be right in the middle of an initialization routine - is it
really not supported?

Also, just to cover the obvious bases, I'm assuming that the OpenFirwmare
devices ttya and ttyb correspond to ttyS0 and ttyS1 respectively.  Is that
correct?  dmesg shows a tty00 and tty01, not a ttyS0 and ttyS1 so I'm a
bit confused to what the real device name is.  I'm going to connect both
serial ports to my PC just to make sure I'm not accidently sending output
to the other port.

What am I missing?  CONFIG_MAC_SERIAL is y, ENABLE_SERIAL_CONSOLE is y and
OpenFirmware works over serial lines.

Thanks,
Kevin

--
Kevin M. Myer
Systems Administrator
Lancaster-Lebanon Intermediate Unit 13
(717)-560-6140


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
