Message-ID: <38E243A4.4F633A75@zing.net>
Date: Wed, 29 Mar 2000 12:55:48 -0500
From: Chris Hallinan <clh@zing.net>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioctl constants
References: <20000329001916.D2C3C355E2@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
>
> Hi Chris,
>
> Chris Hallinan writes:
> > I'm using kernel 2.2.13 and a slightly modified version of serial.c to
> > operate an additional 16550 device at a non-standard i/o address.
> ...
> > I've studied the related header files: the constants used in serial.c
> > are hard coded in asm/ioctls.h.  (Two examples are TIOCGSERIAL and
> > TIOCSSERIAL for get/set_serial_info).  I've grepped for these values,
> > and don't see anywhere where they are re-defined.  Virtually every ioctl
> > that hits the driver has a bad value.
>
> OK, here's a completely wild guess for you: is it possible that your
> application is including asm-i386/ioctls.h instead of asm-ppc/ioctls.h?
>
> You should get the right one if your linux/include/asm symlink is set
> correctly and your application goes:
>     #include <sys/ioctl.h>
>
> Perhaps somewhere along the line they're getting mixed.
>
> Regards,
> Graham

Thanks for the replies.  As it turns out, at least on my system, the
constants in asm-i386/ioctls.h and asm-ppc/ioctls.h are identical.  They
define values such as TIOCGSERIAL = 0x541e and TIOCSSERIAL = 0x541f.
The "errant" ioctl() commands hitting the driver look like 0x7413 (I
determined that one is get_serial, and 0x7414 (that one appears to be
set_serial.)

Other unknown cmd values hitting the driver include 0x744d, 0x745a,
0x7451, 0x7459 and 0x744b.  It should be possible to determine what
these mean by evaluating the _IOR and _IOW macros, I just haven't had
time to do this.

There appears to be an 'old' and 'new' way to specify these IOCTL
constants.  For example:
old TIOCGSERIAL - new TCGETS
old: TIOCSSERIAL - new: TCSETS

I wrote a simple program which uses tcgetattr() and even that sends
"errant" ioctl cmds into my serial.o module.

I'm guessing that someone has figured out a way to make both schemes
work in one system.  Any ideas?

-Chris Hallinan
DS4.COM, Inc.

-CLH

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
