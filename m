Message-ID: <38E11532.958228C3@zing.net>
Date: Tue, 28 Mar 2000 15:25:22 -0500
From: Chris Hallinan <clh@zing.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ioctl constants
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using kernel 2.2.13 and a slightly modified version of serial.c to
operate an additional 16550 device at a non-standard i/o address.

I'm troublshooting a ppp disconnect problem which has led me to the
serial driver.  I've noticed that a large number of rs_ioctl() calls hit
the driver with incorrect constants.  Using printk()'s, I'm able to
determine what values are being passed in, but of course, not who is
calling them.

I've studied the related header files: the constants used in serial.c
are hard coded in asm/ioctls.h.  (Two examples are TIOCGSERIAL and
TIOCSSERIAL for get/set_serial_info).  I've grepped for these values,
and don't see anywhere where they are re-defined.  Virtually every ioctl
that hits the driver has a bad value.

I can only assume that the results of this are ugly!  I'm guessing that
the libraries are compiled with a different convention?  Has anyone run
into this issue?

-Chris Hallinan
DS4.COM, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
